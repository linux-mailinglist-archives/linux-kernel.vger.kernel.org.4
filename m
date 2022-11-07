Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06F061F39D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiKGMqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiKGMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:45:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC201C418;
        Mon,  7 Nov 2022 04:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667825140; x=1699361140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D//c159JdP5zGwVmYcseJt/CqM7tylXEkUxafuaKZOo=;
  b=pec5ydngnJ+bTp2udfOII6yv/LYczafrLZ+zGo4cFjKJOlI4crHIy2S/
   T1teoDh49Co6QY4aKc9WEzTMP++kvpDcWK0WsNsWJdg5IEFb4kccMju5F
   UmcqN60/QfiO0FsfdaSzZGmJoNaUkCix3VWxX3Z+5/B+3EKQ5a+TT5JlL
   Q5Ov+E1gsJHKl9CklQSmEop6NNa1+W0HxYFG104Pof3Iwv6+j+v+y3d3V
   84qf2VWZA4wUXGHl3O1UtkCk4T+YfN7E83paFpQXIowg4csF875tIdxE1
   KhvVT/OTlmOz4oFv9YudgR4SX1omgFH40m4rrl5FSypCIdfVfzIDdYmGX
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="122142863"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 05:45:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 05:45:38 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 05:45:33 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v3 tty-next 3/3] 8250: microchip: pci1xxxx: Add power management functions to quad-uart driver
Date:   Mon, 7 Nov 2022 18:15:17 +0530
Message-ID: <20221107124517.1364484-4-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
References: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx's quad-uart function has the capability to wake up the host
from suspend state. Enable wakeup before entering into suspend and
disable wakeup on resume.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
---
Changes in v3:
- Handled race condition in suspend and resume callbacks

Changes in v2:
- Use DEFINE_SIMPLE_DEV_PM_OPS instead of SIMPLE_DEV_PM_OPS.
- Use pm_sleep_ptr instead of CONFIG_PM_SLEEP.
- Change the return data type of pci1xxxx_port_suspend to bool from int.
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 117 ++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index ed3418feb262..adc1b51db0ca 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -184,6 +184,117 @@ static const struct serial_rs485 pci1xxxx_rs485_supported = {
 	/* Delay RTS before send is not supported */
 };
 
+static bool pci1xxxx_port_suspend(int line)
+{
+	struct uart_8250_port *up = serial8250_get_port(line);
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned long flags;
+	bool ret = false;
+	u8 wakeup_mask;
+
+	mutex_lock(&tport->mutex);
+	if (port->suspended == 0 && port->dev) {
+		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
+
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl &= ~TIOCM_OUT2;
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		if ((wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS)
+			ret = true;
+	}
+
+	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
+	mutex_unlock(&tport->mutex);
+
+	return ret;
+}
+
+static void pci1xxxx_port_resume(int line)
+{
+	struct uart_8250_port *up = serial8250_get_port(line);
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned long flags;
+
+	mutex_lock(&tport->mutex);
+	writeb(UART_BLOCK_SET_ACTIVE, port->membase + UART_ACTV_REG);
+	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
+
+	if (port->suspended == 0) {
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl |= TIOCM_OUT2;
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+	mutex_unlock(&tport->mutex);
+}
+
+static int pci1xxxx_suspend(struct device *dev)
+{
+	struct pci1xxxx_8250 *priv = dev_get_drvdata(dev);
+	struct pci_dev *pcidev = to_pci_dev(dev);
+	bool wakeup = false;
+	unsigned int data;
+	void __iomem *p;
+	int i;
+
+	for (i = 0; i < priv->nr; i++) {
+		if (priv->line[i] >= 0) {
+			serial8250_suspend_port(priv->line[i]);
+			wakeup |= pci1xxxx_port_suspend(priv->line[i]);
+		}
+	}
+
+	p = pci_ioremap_bar(pcidev, 0);
+	if (!p) {
+		dev_err(dev, "remapping of bar 0 memory failed");
+		return -ENOMEM;
+	}
+
+	data = readl(p + UART_RESET_REG);
+	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+
+	if (wakeup)
+		writeb(UART_PCI_CTRL_D3_CLK_ENABLE, p + UART_PCI_CTRL_REG);
+
+	iounmap(p);
+	device_set_wakeup_enable(dev, true);
+	pci_wake_from_d3(pcidev, true);
+
+	return 0;
+}
+
+static int pci1xxxx_resume(struct device *dev)
+{
+	struct pci1xxxx_8250 *priv = dev_get_drvdata(dev);
+	struct pci_dev *pcidev = to_pci_dev(dev);
+	unsigned int data;
+	void __iomem *p;
+	int i;
+
+	p = pci_ioremap_bar(pcidev, 0);
+	if (!p) {
+		dev_err(dev, "remapping of bar 0 memory failed");
+		return -ENOMEM;
+	}
+
+	data = readl(p + UART_RESET_REG);
+	writel(data & ~UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+	iounmap(p);
+
+	for (i = 0; i < priv->nr; i++) {
+		if (priv->line[i] >= 0) {
+			pci1xxxx_port_resume(priv->line[i]);
+			serial8250_resume_port(priv->line[i]);
+		}
+	}
+
+	return 0;
+}
+
 static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
 			  struct uart_8250_port *port, int idx)
 {
@@ -394,6 +505,9 @@ static void pci1xxxx_serial_remove(struct pci_dev *dev)
 	}
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_pm_ops, pci1xxxx_suspend,
+				pci1xxxx_resume);
+
 static const struct pci_device_id pci1xxxx_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
@@ -408,6 +522,9 @@ static struct pci_driver pci1xxxx_pci_driver = {
 	.name = "pci1xxxx serial",
 	.probe = pci1xxxx_serial_probe,
 	.remove = pci1xxxx_serial_remove,
+	.driver = {
+		.pm     = pm_sleep_ptr(&pci1xxxx_pm_ops),
+	},
 	.id_table = pci1xxxx_pci_tbl,
 };
 
-- 
2.25.1

