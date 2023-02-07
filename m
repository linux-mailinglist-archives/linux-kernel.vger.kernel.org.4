Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A468CE0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBGENp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjBGENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:13:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5F834317;
        Mon,  6 Feb 2023 20:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675743199; x=1707279199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJvtkw952wW/ogNdxp5pM4eb//aZ1utFfCZjGHTy2bc=;
  b=eAgCBzMEBWiQHDOEB2cJQ+ui/+8aswTMKMwybpkeJLjhYo2HIcrPV3Bz
   DAUqnxQGKbAP9YNGOc/fa5w6NG9WsXw3qxmw4qCqGxjJ6phaz3H7G5BnZ
   qoCfHdq0AQlA4hPYRSLGPBr05RL4PmoooEoJn207r1WNqAgSsoVyjvWnz
   VNwtrqju9sefCSSwOeLErDpJNVJcKr6wenMRTmY8ksH2XBmyENox9oKgD
   amQqKws7qNcWyBSVa1m557J0XjT+5M6/kAGpQgsJ7v440oovP15UIHSoS
   LKiJn7dWyGEKLLKossehMynGxqdCYYzFS5/y1+rFcbyJA5sQTYgO/8FW3
   g==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="195671511"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 21:13:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 21:13:17 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 21:13:11 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <macro@orcam.me.uk>, <andriy.shevchenko@linux.intel.com>,
        <lukas@wunner.de>, <cang1@live.co.uk>,
        <matthew.gerlach@linux.intel.com>, <deller@gmx.de>,
        <phil.edworthy@renesas.com>, <geert+renesas@glider.be>,
        <marpagan@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <etremblay@distech-controls.com>, <wander@redhat.com>,
        <UNGLinuxDriver@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v13 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
Date:   Tue, 7 Feb 2023 22:18:13 +0530
Message-ID: <20230207164814.3104605-4-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
References: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx uart supports RS485 mode of operation in the hardware with
auto-direction control with configurable delay for releasing RTS after
the transmission. This patch adds support for the RS485 mode.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes in v13:
- No Change

Changes in v12:
- No Change

Changes in v11:
- No Change

Changes in v10:
- No Change

Changes in v9:
- No Change

Changes in v8:
- Modified datatype of delay_in_baud_periods to u32

Changes in v7:
- No Change

Changes in v6:
- Modified datatype of delay_in_baud_periods to u64 to avoid overflows

Changes in v5:
- Removed unnecessary assignments
- Corrected styling issues in comments

Changes in v4:
- No Change

Changes in v3:
- Remove flags sanitization in driver which is taken care in core

Changes in v2:
- move pci1xxxx_rs485_config to a separate patch with
  pci1xxxx_rs485_supported.
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 50 +++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index ea04c014edb9..58f47d18f7d8 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -164,6 +164,54 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
 }
 
+static int pci1xxxx_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	u32 delay_in_baud_periods;
+	u32 baud_period_in_ns;
+	u32 mode_cfg = 0;
+	u32 clock_div;
+
+	/*
+	 * pci1xxxx's uart hardware supports only RTS delay after
+	 * Tx and in units of bit times to a maximum of 15
+	 */
+	if (rs485->flags & SER_RS485_ENABLED) {
+		mode_cfg = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
+
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
+			mode_cfg |= ADCL_CFG_POL_SEL;
+
+		if (rs485->delay_rts_after_send) {
+			clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);
+			baud_period_in_ns =
+				FIELD_GET(BAUD_CLOCK_DIV_INT_MSK, clock_div) *
+				UART_BIT_SAMPLE_CNT;
+			delay_in_baud_periods =
+				rs485->delay_rts_after_send * NSEC_PER_MSEC /
+				baud_period_in_ns;
+			delay_in_baud_periods =
+				min_t(u32, delay_in_baud_periods,
+				      FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));
+			mode_cfg |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK,
+					   delay_in_baud_periods);
+			rs485->delay_rts_after_send =
+				baud_period_in_ns * delay_in_baud_periods /
+				NSEC_PER_MSEC;
+		}
+	}
+	writel(mode_cfg, port->membase + ADCL_CFG_REG);
+	return 0;
+}
+
+static const struct serial_rs485 pci1xxxx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_after_send = 1,
+	/* Delay RTS before send is not supported */
+};
+
 static int pci1xxxx_setup(struct pci_dev *pdev,
 			  struct uart_8250_port *port, int port_idx)
 {
@@ -174,6 +222,8 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	port->port.set_termios = serial8250_do_set_termios;
 	port->port.get_divisor = pci1xxxx_get_divisor;
 	port->port.set_divisor = pci1xxxx_set_divisor;
+	port->port.rs485_config = pci1xxxx_rs485_config;
+	port->port.rs485_supported = pci1xxxx_rs485_supported;
 
 	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
 	if (ret < 0)
-- 
2.25.1

