Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01AA5B730E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiIMPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiIMO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:59:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263457434D;
        Tue, 13 Sep 2022 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663079318; x=1694615318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IAvz+EPRVJUa2sWHwWF/4LgxqmMeTJl/Cd8xvZqLdzA=;
  b=DuTbcKJYCsBH6ALs5uDL8+qarqKM5HvWdZNN6iI/25wCqslpsH2tLj+E
   6nKlsuqMLNus1lEWxuMR4n2eOyUEyz+tFookFS+x81/ihjSZnzhfwkfP8
   J2Loona3UkR70WkyqrxcCgZ24G3W0Erm5ek5h3KdRri79GklhgsDy1MxA
   gUAVAIyT+YW16Y/pVU4aIvtR/1Ce/sIlemfReBsZMyvDvgzTunLFAiHt3
   pYqZ5iCqckpHAUorNmkEvoYmogQtD23WycXwafSlWp+u7EDzDsCue+/JR
   O99jzO4Wti0ii61nRu7IxDIFzQa4Ab3bghg9fzT7ARm3z5GpzhipD/ilk
   A==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="180313680"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:25:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:25:48 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:25:43 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <sergiu.moga@microchip.com>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 12/14] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
Date:   Tue, 13 Sep 2022 17:22:04 +0300
Message-ID: <20220913142205.162399-13-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913142205.162399-1-sergiu.moga@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the driver only divides the clock divisor if the
IP handled at that point is USART, since UART IP's do not support
implicit peripheral clock division. Instead, in the case of UART,
go with the highest possible clock divisor.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before and is mainly meant as both cleanup
and as a way to introduce a new field into struct atmel_uart_port that will be
used by the last patch to diferentiate between USART and UART regarding the
location of the Baudrate Clock Source bitmask.



v2 -> v3:
- Use ATMEL_US_CD instead of 65535
- Previously [PATCH 10]




 drivers/tty/serial/atmel_serial.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ab4a9dfae07d..ad7483230090 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -150,6 +150,7 @@ struct atmel_uart_port {
 	u32			rts_low;
 	bool			ms_irq_enabled;
 	u32			rtor;	/* address of receiver timeout register if it exists */
+	bool			is_usart;
 	bool			has_frac_baudrate;
 	bool			has_hw_timer;
 	struct timer_list	uart_timer;
@@ -1825,6 +1826,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 	 */
 	atmel_port->has_frac_baudrate = false;
 	atmel_port->has_hw_timer = false;
+	atmel_port->is_usart = false;
 
 	if (name == new_uart) {
 		dev_dbg(port->dev, "Uart with hw timer");
@@ -1834,6 +1836,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 		dev_dbg(port->dev, "Usart\n");
 		atmel_port->has_frac_baudrate = true;
 		atmel_port->has_hw_timer = true;
+		atmel_port->is_usart = true;
 		atmel_port->rtor = ATMEL_US_RTOR;
 		version = atmel_uart_readl(port, ATMEL_US_VERSION);
 		switch (version) {
@@ -1863,6 +1866,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
+			atmel_port->is_usart = true;
 			atmel_port->rtor = ATMEL_US_RTOR;
 			break;
 		case 0x203:
@@ -2283,10 +2287,21 @@ static void atmel_set_termios(struct uart_port *port,
 		cd = uart_get_divisor(port, baud);
 	}
 
-	if (cd > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
+	/*
+	 * If the current value of the Clock Divisor surpasses the 16 bit
+	 * ATMEL_US_CD mask and the IP is USART, switch to the Peripheral
+	 * Clock implicitly divided by 8.
+	 * If the IP is UART however, keep the highest possible value for
+	 * the CD and avoid needless division of CD, since UART IP's do not
+	 * support implicit division of the Peripheral Clock.
+	 */
+	if (atmel_port->is_usart && cd > ATMEL_US_CD) {
 		cd /= 8;
 		mode |= ATMEL_US_USCLKS_MCK_DIV8;
+	} else {
+		cd &= ATMEL_US_CD;
 	}
+
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
-- 
2.34.1

