Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F8720E25
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 08:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjFCGfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:35:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27276E58;
        Fri,  2 Jun 2023 23:35:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 668D4804D;
        Sat,  3 Jun 2023 06:35:34 +0000 (UTC)
Date:   Sat, 3 Jun 2023 09:35:33 +0300
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
Message-ID: <20230603063533.GS14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603054139.GR14287@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230603 05:41]:
> I don't think 8250_mtk needs to do register access before and after the
> serial port registration, but if it does, then adding custom read/write
> functions can be done that do not rely on initialized port like
> serial_out().

Oh but mtk8250_runtime_suspend() calls serial_in(up, MTK_UART_DEBUG0), so
yeah if that gets called before registration is complete it causes a NULL
pointer exception. If the serial_ctrl and serial_port devices do runtime
suspend before port registration completes, things will fail.

Sounds like doing pm_runtime_resume_and_get() in mtk8250_probe() might
fix the issue. Still seems that adding a custom read function for
mtk8250_runtime_suspend() to use instead of calling serial_in() should
not be needed.

An experimental untested patch below, maye it helps?

Regards,

Tony

8< ------
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -588,20 +588,24 @@ static int mtk8250_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(&pdev->dev);
-	err = mtk8250_runtime_resume(&pdev->dev);
+	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
 		goto err_pm_disable;
 
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
 
-- 
2.41.0
