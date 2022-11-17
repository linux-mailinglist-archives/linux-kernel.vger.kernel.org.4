Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D762D28B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiKQFCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiKQFBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:01:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C77391F5;
        Wed, 16 Nov 2022 21:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668661289; x=1700197289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIa7e02s2OlQrBiSr3I/1P4AtM84MFYonMHbPfbsrPY=;
  b=JVN9CfDDNsq8QjMlcBjvDz+ZjGnz7/3MNxNjjEKWslohONUkmta9XBGY
   J3ZRt+uqz2oBFq2zqrUoce+J+MJ2N2Un7KwnqzuYa7TlybaJDbIVN+Jbe
   /s7Z00RAAbu9NE759KAN8UXjP3NT96idDILEaJ2pjTgBbBahf+waD6COQ
   nWYI9NzXdMpbN2rJBfimi7rl2FJxWA7IiF6O+ysq7zcPbDcQgfbs54AxC
   +nh9JcwXTlWpu3PcWc22OOiWpbDBp/10PuCz4G0hBEBU+cX1nxWDKd6AO
   uI8lBAKY0AVRfD5Ha6OvKQHg4eKmLjZCCyEt92o7vlwmN4JHWYWHDSTT3
   g==;
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="200162683"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 22:01:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 22:01:26 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 22:01:20 -0700
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
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v5 tty-next 4/4] 8250: microchip: pci1xxxx: Add power management functions to quad-uart driver
Date:   Thu, 17 Nov 2022 10:31:26 +0530
Message-ID: <20221117050126.2966714-5-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx's quad-uart function has the capability to wake up UART
from suspend state. Enable wakeup before entering into suspend and
disable wakeup on resume.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
Changes in v5:
- Corrected commit message

Changes in v4:
- No Change

Changes in v3:
- Handled race condition in suspend and resume callbacks

Changes in v2:
- Use DEFINE_SIMPLE_DEV_PM_OPS instead of SIMPLE_DEV_PM_OPS.
- Use pm_sleep_ptr instead of CONFIG_PM_SLEEP.
- Change the return data type of pci1xxxx_port_suspend to bool from int.
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 116 ++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index bead9fd4019e..fa3477a7ea59 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -187,6 +187,116 @@ static const struct serial_rs485 pci1xxxx_rs485_supported = {
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
+		ret = (wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS;
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
@@ -404,6 +514,9 @@ static void pci1xxxx_serial_remove(struct pci_dev *dev)
 	}
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_pm_ops, pci1xxxx_suspend,
+				pci1xxxx_resume);
+
 static const struct pci_device_id pci1xxxx_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
@@ -418,6 +531,9 @@ static struct pci_driver pci1xxxx_pci_driver = {
 	.name = "pci1xxxx serial",
 	.probe = pci1xxxx_serial_probe,
 	.remove = pci1xxxx_serial_remove,
+	.driver = {
+		.pm     = pm_sleep_ptr(&pci1xxxx_pm_ops),
+	},
 	.id_table = pci1xxxx_pci_tbl,
 };
 module_pci_driver(pci1xxxx_pci_driver);
-- 
2.25.1

