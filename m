Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981466458C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLGLTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiLGLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:19:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7C24BCF;
        Wed,  7 Dec 2022 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670411933; x=1701947933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyxA4tt9p6iV+N4mRj1pIbu4bzCNJHqjGIzPONeKW3I=;
  b=lORf2RRLgA4wZIkwcPVAR6qbEDDIqfbZ9liZnsj6qpP3cFbW4WGI1Jjo
   xtohowIRKV4WEJJGhpf0OrxF5kx1Vwr/UWHEg7VIvmuhFGXSacC3IjDic
   U/qPwJf1UaGSySvssHk052TwMdgaEMuoZ7Eueip43qchnkEFyKWBn3X4a
   jQrUXB9qUvDux5Xv0VZ9EedLKg0LjOFB7ju4CsmX5GHNwm1B5TInEADcl
   BkGbnMjomx2ZkxOrMQKHdB2iGNq/CA/lYETB3U+pPBGhgX7ZQergQdt3r
   hyPXx1F+fMm80MO8ck3VHqLPxZjYauEMQuHjL5OQ01CSxJEV2ae0vrLEw
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="126919609"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2022 04:18:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Dec 2022 04:18:46 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Dec 2022 04:18:41 -0700
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
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v7 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
Date:   Thu, 8 Dec 2022 05:23:04 +0530
Message-ID: <20221207235305.695541-4-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207235305.695541-1-kumaravel.thiagarajan@microchip.com>
References: <20221207235305.695541-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
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
 drivers/tty/serial/8250/8250_pci1xxxx.c | 49 +++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index be554e2d884b..9f0da264314a 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -145,6 +145,53 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
 }
 
+static int pci1xxxx_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	u32 clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);
+	u64 delay_in_baud_periods;
+	u32 baud_period_in_ns;
+	u32 data = 0;
+
+	/*
+	 * pci1xxxx's uart hardware supports only RTS delay after
+	 * Tx and in units of bit times to a maximum of 15
+	 */
+	if (rs485->flags & SER_RS485_ENABLED) {
+		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
+
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
+			data |= ADCL_CFG_POL_SEL;
+
+		if (rs485->delay_rts_after_send) {
+			baud_period_in_ns =
+				FIELD_GET(BAUD_CLOCK_DIV_INT_MSK, clock_div) *
+				UART_BIT_SAMPLE_CNT;
+			delay_in_baud_periods =
+				rs485->delay_rts_after_send * NSEC_PER_MSEC /
+				baud_period_in_ns;
+			delay_in_baud_periods =
+				min_t(u64, delay_in_baud_periods,
+				      FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));
+			data |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK,
+					   delay_in_baud_periods);
+			rs485->delay_rts_after_send =
+				baud_period_in_ns * delay_in_baud_periods /
+				NSEC_PER_MSEC;
+		}
+	}
+	writel(data, port->membase + ADCL_CFG_REG);
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
 static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
 			  struct uart_8250_port *port, int port_idx)
 {
@@ -155,6 +202,8 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
 	port->port.set_termios = serial8250_do_set_termios;
 	port->port.get_divisor = pci1xxxx_get_divisor;
 	port->port.set_divisor = pci1xxxx_set_divisor;
+	port->port.rs485_config = pci1xxxx_rs485_config;
+	port->port.rs485_supported = pci1xxxx_rs485_supported;
 
 	ret = serial8250_pci_setup_port(priv->pdev, port, 0, port_idx * 256, 0);
 	if (ret < 0)
-- 
2.25.1

