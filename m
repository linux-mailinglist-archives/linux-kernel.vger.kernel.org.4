Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3579A5F1A48
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJAGRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJAGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:17:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516710ED8C;
        Fri, 30 Sep 2022 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664605016; x=1696141016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t/YWdSEiWY+uTuC+27pnC4fxAatDyZxJkBTz60ecTr4=;
  b=0K61zAo9AyGjdEfuHRgXMXAjTNHdS4DaZsAYFi5uxgYvflob1P0/SRHS
   YJ6IShzKi22YH8jhHGZTKbPErkK/SwjpVvJMM0MyJN+X8OBfvHcrG5bMe
   ffGlTTYA/9iHOIFHSv/laLw/+ojvVv9u1bhXAwGHe3Wda8ka8C9LCJrrM
   moaCLxhIxL+E0JW5FTMknF84Lx4wPRlCE4zyNJsGh5eM5VvvKn0gwGoF1
   MqWbX2xhbpIGhveyX9n96JeJV/DjoXwexSBiPFe0cAI7ARrsTWCv6Whzr
   qCkaBc2JtjNJtniKf5cTGkbr1kjA/xMpTv3IropgV7ETvuYFIfuv1cF+f
   g==;
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="176561499"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 23:15:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 23:15:18 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 30 Sep 2022 23:15:13 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485 support to quad-uart driver.
Date:   Sat, 1 Oct 2022 11:45:06 +0530
Message-ID: <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx uart supports rs485 mode of operation in the hardware with
auto-direction control with configurable delay for releasing RTS after
the transmission. This patch adds support for the rs485 mode.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
Changes in v2:
- move pci1xxxx_rs485_config to a separate patch with
  pci1xxxx_rs485_supported.
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 41a4b94f52b4..999e5a284266 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -137,6 +137,61 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 	writel((quot << 8) | frac, (port->membase + CLK_DIVISOR_REG));
 }
 
+static const struct serial_rs485 pci1xxxx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_after_send = 1,
+	/* Delay RTS before send is not supported */
+};
+
+static int pci1xxxx_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	u32 clock_div = readl(port->membase + CLK_DIVISOR_REG);
+	u8 delay_in_baud_periods = 0;
+	u32 baud_period_in_ns = 0;
+	u8 data = 0;
+
+	/* pci1xxxx's uart hardware supports only RTS delay after
+	 * Tx and in units of bit times to a maximum of 15
+	 */
+
+	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+			SER_RS485_RTS_AFTER_SEND;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		memset(rs485->padding, 0, sizeof(rs485->padding));
+
+		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
+
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
+			data |= ADCL_CFG_POL_SEL;
+			rs485->flags |=  SER_RS485_RTS_AFTER_SEND;
+		} else {
+			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		}
+
+		if (rs485->delay_rts_after_send) {
+			baud_period_in_ns = ((clock_div >> 8) * 16);
+			delay_in_baud_periods = (rs485->delay_rts_after_send * 1000000) /
+						baud_period_in_ns;
+			if (delay_in_baud_periods > 0xF)
+				delay_in_baud_periods = 0xF;
+			data |= delay_in_baud_periods << 8;
+			rs485->delay_rts_after_send = (baud_period_in_ns * delay_in_baud_periods) /
+						      1000000;
+			rs485->delay_rts_before_send = 0;
+		}
+	} else {
+		memset(rs485, 0, sizeof(*rs485));
+	}
+
+	writeb(data, (port->membase + ADCL_CFG_REG));
+	port->rs485 = *rs485;
+
+	return 0;
+}
+
 static int pci1xxxx_get_num_ports(struct pci_dev *dev)
 {
 	int nr_ports = 1;
@@ -217,6 +272,8 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
 	port->port.set_termios = serial8250_do_set_termios;
 	port->port.get_divisor = pci1xxxx_get_divisor;
 	port->port.set_divisor = pci1xxxx_set_divisor;
+	port->port.rs485_config = pci1xxxx_rs485_config;
+	port->port.rs485_supported = pci1xxxx_rs485_supported;
 	ret = pci1xxxx_setup_port(priv, port, offset);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

