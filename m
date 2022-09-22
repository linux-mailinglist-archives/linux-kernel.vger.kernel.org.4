Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A555E618C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiIVLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIVLnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:43:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F8E5127;
        Thu, 22 Sep 2022 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846981; x=1695382981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PkvW2+v4ra7Kos8RB8EjzdxzU827BFV7cqmkcNq8EWY=;
  b=KIMc6MU4uEa2K28bTfNUvvLFMLEsOLude3k5R8mmO9CsBx3ozbUL1/dM
   nLmWrHc1zM9MLA/Ovz1An7/gC84ZOp2gaT0frY8M5nTIbMRyHLVIFfjRK
   chL8BM4gpEZ5ngtcXIAfy2ta8LfabS6kDPTvFPZAVGqhAS2X1XZY5WwBF
   kgNvP7c+asLxs2IamJMSmmLUy8AiA/Thz/iBha0zCbiOcHw9CY2uOJKsU
   V25I/OTQDK4iTPwNCyaN9fJ8PorH9zqYBAqVgoJ2GWtrrXypUlVg1e4fn
   ZWmMUCALP0tXb4Ql11Whel7YgJ8jBQqzxxPvntsHu9D0KpEaQ0XcFxdYc
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="114897503"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:43:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:42:58 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:42:52 -0700
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
Subject: [PATCH v5 6/9] tty: serial: atmel: Separate mode clearing between UART and USART
Date:   Thu, 22 Sep 2022 14:33:44 +0300
Message-ID: <20220922113347.144383-7-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922113347.144383-1-sergiu.moga@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
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

When clearing the mode of the serial IP inside the atmel_set_termios()
method, make sure that the difference between the bitfields placement
of the UART IP's and USART IP's is taken into account, as some of
them overlap with each other. For example, ATMEL_UA_BRSRCCK overlaps
with ATMEL_US_NBSTOP and ATMEL_US_USCLKS overlaps with ATMEL_UA_FILTER.

Furthermore, add definitions for the Baud Rate Source Clock and the
Filter bitfields of the Mode Register of UART IP's, since they were
missing.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v5:
- This patch was not here before but it also includes the previous patch:
`[PATCH v4 7/9] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register`
squashed into it and define BRSRCCK as a bitfield instead of a bitmask,
since it is only 1 bit.



 drivers/tty/serial/atmel_serial.c | 7 +++++--
 drivers/tty/serial/atmel_serial.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ab4a9dfae07d..e3e14cb7668b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2134,8 +2134,11 @@ static void atmel_set_termios(struct uart_port *port,
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
 
 	/* reset the mode, clock divisor, parity, stop bits and data size */
-	mode &= ~(ATMEL_US_USCLKS | ATMEL_US_CHRL | ATMEL_US_NBSTOP |
-		  ATMEL_US_PAR | ATMEL_US_USMODE);
+	if (atmel_port->is_usart)
+		mode &= ~(ATMEL_US_NBSTOP | ATMEL_US_PAR | ATMEL_US_CHRL |
+			  ATMEL_US_USCLKS | ATMEL_US_USMODE);
+	else
+		mode &= ~(ATMEL_UA_BRSRCCK | ATMEL_US_PAR | ATMEL_UA_FILTER);
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
 
diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index 0d8a0f9cc5c3..2a525b58e11a 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -50,6 +50,7 @@
 #define		ATMEL_US_USCLKS_MCK		(0 <<  4)
 #define		ATMEL_US_USCLKS_MCK_DIV8	(1 <<  4)
 #define		ATMEL_US_USCLKS_SCK		(3 <<  4)
+#define	ATMEL_UA_FILTER		BIT(4)
 #define	ATMEL_US_CHRL		GENMASK(7, 6)	/* Character Length */
 #define		ATMEL_US_CHRL_5			(0 <<  6)
 #define		ATMEL_US_CHRL_6			(1 <<  6)
@@ -67,6 +68,7 @@
 #define		ATMEL_US_NBSTOP_1		(0 << 12)
 #define		ATMEL_US_NBSTOP_1_5		(1 << 12)
 #define		ATMEL_US_NBSTOP_2		(2 << 12)
+#define	ATMEL_UA_BRSRCCK	BIT(12)	/* Clock Selection for UART */
 #define	ATMEL_US_CHMODE		GENMASK(15, 14)	/* Channel Mode */
 #define		ATMEL_US_CHMODE_NORMAL		(0 << 14)
 #define		ATMEL_US_CHMODE_ECHO		(1 << 14)
-- 
2.34.1

