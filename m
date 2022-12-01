Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E563E90B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiLAEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLAEvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:51:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A39FA98;
        Wed, 30 Nov 2022 20:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669870293; x=1701406293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pwr8pzAseXIeubllSBB96HA4PC9HFFfLLbN91MIJKmg=;
  b=JQqZEgm+/Ih9k8/idwJ+xrt+fsde8oDf8ckLJ1e2ZgVQzOb3eu2NMaVG
   DG/a0cSdvwXB3RY3zgYmh7y0vLhem9RavNVLeGxDti+xl3e+GGYmamzQL
   hKe5xZg//Rw0OiBnKYQxZ8OmnZUp5XNxIFqFLriGhz/afOEwfTrZ2S6RG
   ++AcO7f/wj7wG9FOEpK9VoujfD1nHhzujaW38ktOuOCPgyL3oXHiGv3u/
   YjkxdF84iqOQQaRQ4ATKih6q12yIphEpFeYD7FCXWhCamuHEYgvk5UIFF
   rvRt3s22I6LqpZa6MPHVV1avinTaYqj3ASJB71qEM01RUWecdbY2HwFDw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="185988780"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2022 21:51:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 30 Nov 2022 21:51:29 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 30 Nov 2022 21:51:22 -0700
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
Subject: [PATCH v6 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
Date:   Thu, 1 Dec 2022 10:21:45 +0530
Message-ID: <20221201045146.1055913-4-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
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

pci1xxxx uart supports RS485 mode of operation in the hardware with
auto-direction control with configurable delay for releasing RTS after
the transmission. This patch adds support for the RS485 mode.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
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
index d5037e76b636..7585066d6baf 100644
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

