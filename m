Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785D64DF06
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiLOQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiLOQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:52:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342337F94;
        Thu, 15 Dec 2022 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671123164; x=1702659164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7c9jSwU2YvZekx3KGxksBJgmGj8DCsp74IgYm7As1Is=;
  b=oQcI8knJ4brcIcH+hsirgTXdccia2npEU81OKxT4nGazu3/say1bAQuT
   PJFzxBp0BtMkOB0XkgR1MEru2L0bnBqD0B0lXiZ20FpgRWIZ2gjUgMHsa
   psETnH9qcI58Lb8Froi2vpa7SzCFjlxZIuYaLUwwzrd8p/F3iG8lyDJZi
   k30VUAhK5Him3gVngKnPfB7PTfcqQ/bnQgKDh1c4U9R8DCJZmn42Jyv1i
   Iz8TM9zBMToangvJ2tJMZoyk/AGd/H3ax37jbzROTn1l+08n2w+3YWGNX
   +vyqhQkzx1kZ61/iFxsuYj8UHuAimtke/PSai9ZWaXWWiOwF1S76W4ToT
   w==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="193245156"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2022 09:52:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:52:42 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:52:36 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <macro@orcam.me.uk>, <andriy.shevchenko@linux.intel.com>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <UNGLinuxDriver@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v9 tty-next 4/4] serial: 8250_pci1xxxx: Add power management functions to quad-uart driver
Date:   Fri, 16 Dec 2022 10:56:56 +0530
Message-ID: <20221216052656.2098100-5-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v9:
- No Change

Changes in v8:
- No Change

Changes in v7:
- No Change

Changes in v6:
- No Change

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
 drivers/tty/serial/8250/8250_pci1xxxx.c | 115 ++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index e46c6b835a36..31790c8b6087 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -211,6 +211,116 @@ static const struct serial_rs485 pci1xxxx_rs485_supported = {
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
 static int pci1xxxx_setup(struct pci_dev *pdev,
 			  struct uart_8250_port *port, int port_idx)
 {
@@ -350,6 +460,8 @@ static void pci1xxxx_serial_remove(struct pci_dev *dev)
 	pci_iounmap(dev, priv->membase);
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_pm_ops, pci1xxxx_suspend, pci1xxxx_resume);
+
 static const struct pci_device_id pci1xxxx_pci_tbl[] = {
 	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
 	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
@@ -364,6 +476,9 @@ static struct pci_driver pci1xxxx_pci_driver = {
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

