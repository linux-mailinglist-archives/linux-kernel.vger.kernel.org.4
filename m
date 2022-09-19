Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513455BD047
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiISPPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiISPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:14:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20245357D8;
        Mon, 19 Sep 2022 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663600460; x=1695136460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c870c32AhfgZVg4pwd9ZMePlL4mjnVCOQA4N7lzg7uk=;
  b=k60+i5P5Mqyl8vfrc1i+E1GdVv6KyNK+2bguKeMU95I3ACooU2eHHgkd
   U2FUrfHj+dkYm7W3mLRABpD/Mh8XRGgIjtbUYeOeQ/9JE+fIXcVb8GVT4
   Fw/qzGqFNIy4KlA7VSJLqXIw614mloVUq6kmbaF19zFcqTK7vl8E5Pnh0
   JQqijtCIUzB/+YLNky7fiYYPepD2z2cKyZvIk/9YrZDbwXfGWHeQ9oTx8
   TfthvTR+nY/ysH1UYups6CpvsO21qmDUFW8wK5/ofYzR3iR3kojrtNfIs
   54jLBMeF2SFzhvrz8gRZsiDcn65t13Wv+0ZKkFXxjB65sMCa5IoatevgV
   w==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="114368422"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 08:14:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 08:14:17 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 19 Sep 2022 08:14:13 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the existence of GCLK
Date:   Mon, 19 Sep 2022 18:08:47 +0300
Message-ID: <20220919150846.1148783-10-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919150846.1148783-1-sergiu.moga@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
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

Previously, the atmel serial driver did not take into account the
possibility of using the more customizable generic clock as its
baudrate generator. Unless there is a Fractional Part available to
increase accuracy, there is a high chance that we may be able to
generate a baudrate closer to the desired one by using the GCLK as the
clock source. Now, depending on the error rate between
the desired baudrate and the actual baudrate, the serial driver will
fallback on the generic clock. The generic clock must be provided
in the DT node of the serial that may need a more flexible clock source.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- take into account the different placement of the baudrate clock source
into the IP's Mode Register (USART vs UART)
- don't check for atmel_port->gclk != NULL
- use clk_round_rate instead of clk_set_rate + clk_get_rate
- remove clk_disable_unprepare from the end of the probe method



v2 -> v3:
- add the error rate calculation function as an inline function instead of
a macro definition
- add `gclk_fail` goto
- replace `goto err` with `goto err_clk_disable_unprepare;`



v3 -> v4:
- Nothing, this was previously [PATCH 14]


 drivers/tty/serial/atmel_serial.c | 59 ++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c983798a4ab2..426f9d4f9a5a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/tty_flip.h>
@@ -110,6 +111,7 @@ struct atmel_uart_char {
 struct atmel_uart_port {
 	struct uart_port	uart;		/* uart */
 	struct clk		*clk;		/* uart clock */
+	struct clk		*gclk;		/* uart generic clock */
 	int			may_wakeup;	/* cached value of device_may_wakeup for times we need to disable it */
 	u32			backup_imr;	/* IMR saved during suspend */
 	int			break_active;	/* break being received */
@@ -229,6 +231,11 @@ static inline int atmel_uart_is_half_duplex(struct uart_port *port)
 		(port->iso7816.flags & SER_ISO7816_ENABLED);
 }
 
+static inline int atmel_error_rate(int desired_value, int actual_value)
+{
+	return 100 - (desired_value * 100) / actual_value;
+}
+
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
 {
@@ -2117,6 +2124,8 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 		 * This is called on uart_close() or a suspend event.
 		 */
 		clk_disable_unprepare(atmel_port->clk);
+		if (__clk_is_enabled(atmel_port->gclk))
+			clk_disable_unprepare(atmel_port->gclk);
 		break;
 	default:
 		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
@@ -2132,7 +2141,9 @@ static void atmel_set_termios(struct uart_port *port,
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
-	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
+	unsigned int old_mode, mode, imr, quot, div, cd, fp = 0;
+	unsigned int baud, actual_baud, gclk_rate;
+	int ret;
 
 	/* save the current mode register */
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
@@ -2302,6 +2313,46 @@ static void atmel_set_termios(struct uart_port *port,
 		cd = min_t(unsigned int, cd, ATMEL_US_CD);
 	}
 
+	/*
+	 * If there is no Fractional Part, there is a high chance that
+	 * we may be able to generate a baudrate closer to the desired one
+	 * if we use the GCLK as the clock source driving the baudrate
+	 * generator.
+	 */
+	if (!atmel_port->has_frac_baudrate) {
+		if (__clk_is_enabled(atmel_port->gclk))
+			clk_disable_unprepare(atmel_port->gclk);
+		gclk_rate = clk_round_rate(atmel_port->gclk, 16 * baud);
+		actual_baud = clk_get_rate(atmel_port->clk) / (16 * cd);
+		if (gclk_rate && abs(atmel_error_rate(baud, actual_baud)) >
+		    abs(atmel_error_rate(baud, gclk_rate / 16))) {
+			clk_set_rate(atmel_port->gclk, 16 * baud);
+			ret = clk_prepare_enable(atmel_port->gclk);
+			if (ret)
+				goto gclk_fail;
+
+			if (atmel_port->is_usart) {
+				mode &= ~ATMEL_US_USCLKS;
+				mode |= ATMEL_US_USCLKS_GCLK;
+			} else {
+				mode &= ~ATMEL_UA_BRSRCCK;
+				mode |= ATMEL_UA_BRSRCCK_GCLK;
+			}
+
+			/*
+			 * Set the Clock Divisor for GCLK to 1.
+			 * Since we were able to generate the smallest
+			 * multiple of the desired baudrate times 16,
+			 * then we surely can generate a bigger multiple
+			 * with the exact error rate for an equally increased
+			 * CD. Thus no need to take into account
+			 * a higher value for CD.
+			 */
+			cd = 1;
+		}
+	}
+
+gclk_fail:
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
@@ -2897,6 +2948,12 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	atmel_port->gclk = devm_clk_get_optional(&pdev->dev, "gclk");
+	if (IS_ERR(atmel_port->gclk)) {
+		ret = PTR_ERR(atmel_port->gclk);
+		goto err_clk_disable_unprepare;
+	}
+
 	ret = atmel_init_port(atmel_port, pdev);
 	if (ret)
 		goto err_clk_disable_unprepare;
-- 
2.34.1

