Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19E721DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjFEGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEGPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:15:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 038D6DB;
        Sun,  4 Jun 2023 23:15:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0E00A80C1;
        Mon,  5 Jun 2023 06:15:13 +0000 (UTC)
Date:   Mon, 5 Jun 2023 09:15:11 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230605061511.GW14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
 <20230603063533.GS14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603063533.GS14287@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230603 06:35]:
> * Tony Lindgren <tony@atomide.com> [230603 05:41]:
> > I don't think 8250_mtk needs to do register access before and after the
> > serial port registration, but if it does, then adding custom read/write
> > functions can be done that do not rely on initialized port like
> > serial_out().
> 
> Oh but mtk8250_runtime_suspend() calls serial_in(up, MTK_UART_DEBUG0), so
> yeah if that gets called before registration is complete it causes a NULL
> pointer exception. If the serial_ctrl and serial_port devices do runtime
> suspend before port registration completes, things will fail.
> 
> Sounds like doing pm_runtime_resume_and_get() in mtk8250_probe() might
> fix the issue. Still seems that adding a custom read function for
> mtk8250_runtime_suspend() to use instead of calling serial_in() should
> not be needed.

Looking at this again, if serial8250_register_8250_port() fails, then
mtk8250_runtime_suspend() would again try to access uninitialized port.

Here's a better untested version of the patch to try.

Regards,

Tony

8< ---------------------------
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -57,6 +57,8 @@
 #define MTK_UART_XON1		40	/* I/O: Xon character 1 */
 #define MTK_UART_XOFF1		42	/* I/O: Xoff character 1 */
 
+#define MTK_UART_REGSHIFT	2
+
 #ifdef CONFIG_SERIAL_8250_DMA
 enum dma_rx_status {
 	DMA_RX_START = 0,
@@ -69,6 +71,7 @@ struct mtk8250_data {
 	int			line;
 	unsigned int		rx_pos;
 	unsigned int		clk_count;
+	void __iomem		*membase;
 	struct clk		*uart_clk;
 	struct clk		*bus_clk;
 	struct uart_8250_dma	*dma;
@@ -187,6 +190,17 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
 }
 #endif
 
+/* Read and write for register access before and after port registration */
+static u32 __maybe_unused mtk8250_read(struct mtk8250_data *data, u32 reg)
+{
+	return readl(data->membase + (reg << MTK_UART_REGSHIFT));
+}
+
+static void mtk8250_write(struct mtk8250_data *data, u32 reg, u32 val)
+{
+	writel(val, data->membase + (reg << MTK_UART_REGSHIFT));
+}
+
 static int mtk8250_startup(struct uart_port *port)
 {
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -425,11 +439,10 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(data->line);
 
 	/* wait until UART in idle status */
 	while
-		(serial_in(up, MTK_UART_DEBUG0));
+		(mtk8250_read(data, MTK_UART_DEBUG0));
 
 	if (data->clk_count == 0U) {
 		dev_dbg(dev, "%s clock count is 0\n", __func__);
@@ -553,6 +566,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->membase = uart.port.membase;
 	data->clk_count = 0;
 
 	if (pdev->dev.of_node) {
@@ -570,7 +584,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 	uart.port.dev = &pdev->dev;
 	uart.port.iotype = UPIO_MEM32;
-	uart.port.regshift = 2;
+	uart.port.regshift = MTK_UART_REGSHIFT;
 	uart.port.private_data = data;
 	uart.port.shutdown = mtk8250_shutdown;
 	uart.port.startup = mtk8250_startup;
@@ -581,27 +595,30 @@ static int mtk8250_probe(struct platform_device *pdev)
 		uart.dma = data->dma;
 #endif
 
-	/* Disable Rate Fix function */
-	writel(0x0, uart.port.membase +
-			(MTK_UART_RATE_FIX << uart.port.regshift));
-
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(&pdev->dev);
-	err = mtk8250_runtime_resume(&pdev->dev);
+	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
 		goto err_pm_disable;
 
+	/* Disable Rate Fix function */
+	mtk8250_write(data, 0, MTK_UART_RATE_FIX);
+
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0) {
 		err = data->line;
-		goto err_pm_disable;
+		goto err_pm_put;
 	}
 
 	data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
 
+	pm_runtime_put_sync(&pdev->dev);
+
 	return 0;
 
+err_pm_put:
+	pm_runtime_put_sync(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 
@@ -694,7 +711,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->port.iotype = UPIO_MEM32;
-	device->port.regshift = 2;
+	device->port.regshift = MTK_UART_REGSHIFT;
 
 	return early_serial8250_setup(device, NULL);
 }
