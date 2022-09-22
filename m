Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E45E61A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiIVLoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiIVLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:43:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C67F9B875;
        Thu, 22 Sep 2022 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663847006; x=1695383006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4zE5vDxVc9rp05PTgtTI2qIjpkr6XGF013rACtbZn8=;
  b=Wl56XrMvIyWg0D0R2A9edjulsjp6Vyt6bvixiBSajnzYJcr+eaaOuKIz
   XTo61fxTm/BNG9HHRf8/PSVrA7iHo4yxFPojscvcoSLNXjoZaS14qru/3
   +q8WVvJGmhuChMCe5ov0yZq2imPtn88bHXdLqvqkvz5f4XHpRGNOACHGq
   6bjoVylfZU3CHxTHaWxcRI6ucmoZKA7RvQ8nCfYh8W5jV87vm5he5Y7QS
   /C4UlomPcR4hD0OJGyk0eEu1n9YYl3Rh7fPkxJA3sowbWMhhrtVhTTV6O
   lW+R7bzqy4MyIQLITiR4ipcJwKW3vJaZp9XZf9diGUSQTKvFpCO9EKX5x
   w==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="175079053"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:43:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:43:22 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:43:16 -0700
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
Subject: [PATCH v5 9/9] tty: serial: atmel: Use FIELD_PREP/FIELD_GET
Date:   Thu, 22 Sep 2022 14:33:47 +0300
Message-ID: <20220922113347.144383-10-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922113347.144383-1-sergiu.moga@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all open-coded instances of bitfields retrieval/setting
to FIELD_PREP/FIELD_GET where possible.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v5:
- Nothing, this patch was not here before



 drivers/tty/serial/atmel_serial.h | 74 ++++++++++++++++---------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index 0fcadbeabc6c..87f8f7996307 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -9,6 +9,8 @@
  * Based on AT91RM9200 datasheet revision E.
  */
 
+#include <linux/bitfield.h>
+
 #ifndef ATMEL_SERIAL_H
 #define ATMEL_SERIAL_H
 
@@ -39,42 +41,42 @@
 
 #define ATMEL_US_MR		0x04	/* Mode Register */
 #define	ATMEL_US_USMODE		GENMASK(3, 0)	/* Mode of the USART */
-#define		ATMEL_US_USMODE_NORMAL		0
-#define		ATMEL_US_USMODE_RS485		1
-#define		ATMEL_US_USMODE_HWHS		2
-#define		ATMEL_US_USMODE_MODEM		3
-#define		ATMEL_US_USMODE_ISO7816_T0	4
-#define		ATMEL_US_USMODE_ISO7816_T1	6
-#define		ATMEL_US_USMODE_IRDA		8
+#define		ATMEL_US_USMODE_NORMAL		FIELD_PREP(ATMEL_US_USMODE, 0)
+#define		ATMEL_US_USMODE_RS485		FIELD_PREP(ATMEL_US_USMODE, 1)
+#define		ATMEL_US_USMODE_HWHS		FIELD_PREP(ATMEL_US_USMODE, 2)
+#define		ATMEL_US_USMODE_MODEM		FIELD_PREP(ATMEL_US_USMODE, 3)
+#define		ATMEL_US_USMODE_ISO7816_T0	FIELD_PREP(ATMEL_US_USMODE, 4)
+#define		ATMEL_US_USMODE_ISO7816_T1	FIELD_PREP(ATMEL_US_USMODE, 6)
+#define		ATMEL_US_USMODE_IRDA		FIELD_PREP(ATMEL_US_USMODE, 8)
 #define	ATMEL_US_USCLKS		GENMASK(5, 4)	/* Clock Selection */
-#define		ATMEL_US_USCLKS_MCK		(0 <<  4)
-#define		ATMEL_US_USCLKS_MCK_DIV8	(1 <<  4)
-#define		ATMEL_US_USCLKS_GCLK		(2 <<  4)
-#define		ATMEL_US_USCLKS_SCK		(3 <<  4)
+#define		ATMEL_US_USCLKS_MCK		FIELD_PREP(ATMEL_US_USCLKS, 0)
+#define		ATMEL_US_USCLKS_MCK_DIV8	FIELD_PREP(ATMEL_US_USCLKS, 1)
+#define		ATMEL_US_USCLKS_GCLK		FIELD_PREP(ATMEL_US_USCLKS, 2)
+#define		ATMEL_US_USCLKS_SCK		FIELD_PREP(ATMEL_US_USCLKS, 3)
 #define	ATMEL_UA_FILTER		BIT(4)
 #define	ATMEL_US_CHRL		GENMASK(7, 6)	/* Character Length */
-#define		ATMEL_US_CHRL_5			(0 <<  6)
-#define		ATMEL_US_CHRL_6			(1 <<  6)
-#define		ATMEL_US_CHRL_7			(2 <<  6)
-#define		ATMEL_US_CHRL_8			(3 <<  6)
+#define		ATMEL_US_CHRL_5			FIELD_PREP(ATMEL_US_CHRL, 0)
+#define		ATMEL_US_CHRL_6			FIELD_PREP(ATMEL_US_CHRL, 1)
+#define		ATMEL_US_CHRL_7			FIELD_PREP(ATMEL_US_CHRL, 2)
+#define		ATMEL_US_CHRL_8			FIELD_PREP(ATMEL_US_CHRL, 3)
 #define	ATMEL_US_SYNC		BIT(8)		/* Synchronous Mode Select */
 #define	ATMEL_US_PAR		GENMASK(11, 9)	/* Parity Type */
-#define		ATMEL_US_PAR_EVEN		(0 <<  9)
-#define		ATMEL_US_PAR_ODD		(1 <<  9)
-#define		ATMEL_US_PAR_SPACE		(2 <<  9)
-#define		ATMEL_US_PAR_MARK		(3 <<  9)
-#define		ATMEL_US_PAR_NONE		(4 <<  9)
-#define		ATMEL_US_PAR_MULTI_DROP		(6 <<  9)
+#define		ATMEL_US_PAR_EVEN		FIELD_PREP(ATMEL_US_PAR, 0)
+#define		ATMEL_US_PAR_ODD		FIELD_PREP(ATMEL_US_PAR, 1)
+#define		ATMEL_US_PAR_SPACE		FIELD_PREP(ATMEL_US_PAR, 2)
+#define		ATMEL_US_PAR_MARK		FIELD_PREP(ATMEL_US_PAR, 3)
+#define		ATMEL_US_PAR_NONE		FIELD_PREP(ATMEL_US_PAR, 4)
+#define		ATMEL_US_PAR_MULTI_DROP		FIELD_PREP(ATMEL_US_PAR, 6)
 #define	ATMEL_US_NBSTOP		GENMASK(13, 12)	/* Number of Stop Bits */
-#define		ATMEL_US_NBSTOP_1		(0 << 12)
-#define		ATMEL_US_NBSTOP_1_5		(1 << 12)
-#define		ATMEL_US_NBSTOP_2		(2 << 12)
+#define		ATMEL_US_NBSTOP_1		FIELD_PREP(ATMEL_US_NBSTOP, 0)
+#define		ATMEL_US_NBSTOP_1_5		FIELD_PREP(ATMEL_US_NBSTOP, 1)
+#define		ATMEL_US_NBSTOP_2		FIELD_PREP(ATMEL_US_NBSTOP, 2)
 #define	ATMEL_UA_BRSRCCK	BIT(12)	/* Clock Selection for UART */
 #define	ATMEL_US_CHMODE		GENMASK(15, 14)	/* Channel Mode */
-#define		ATMEL_US_CHMODE_NORMAL		(0 << 14)
-#define		ATMEL_US_CHMODE_ECHO		(1 << 14)
-#define		ATMEL_US_CHMODE_LOC_LOOP	(2 << 14)
-#define		ATMEL_US_CHMODE_REM_LOOP	(3 << 14)
+#define		ATMEL_US_CHMODE_NORMAL		FIELD_PREP(ATMEL_US_CHMODE, 0)
+#define		ATMEL_US_CHMODE_ECHO		FIELD_PREP(ATMEL_US_CHMODE, 1)
+#define		ATMEL_US_CHMODE_LOC_LOOP	FIELD_PREP(ATMEL_US_CHMODE, 2)
+#define		ATMEL_US_CHMODE_REM_LOOP	FIELD_PREP(ATMEL_US_CHMODE, 3)
 #define	ATMEL_US_MSBF		BIT(16)	/* Bit Order */
 #define	ATMEL_US_MODE9		BIT(17)	/* 9-bit Character Length */
 #define	ATMEL_US_CLKO		BIT(18)	/* Clock Output Select */
@@ -82,7 +84,7 @@
 #define	ATMEL_US_INACK		BIT(20)	/* Inhibit Non Acknowledge */
 #define	ATMEL_US_DSNACK		BIT(21)	/* Disable Successive NACK */
 #define	ATMEL_US_MAX_ITER_MASK	GENMASK(26, 24)	/* Max Iterations */
-#define	ATMEL_US_MAX_ITER(n)	(((n) << 24) & ATMEL_US_MAX_ITER_MASK)
+#define	ATMEL_US_MAX_ITER(n)	FIELD_PREP(ATMEL_US_MAX_ITER_MASK, (n))
 #define	ATMEL_US_FILTER		BIT(28)	/* Infrared Receive Line Filter */
 
 #define ATMEL_US_IER		0x08	/* Interrupt Enable Register */
@@ -134,19 +136,19 @@
 
 #define ATMEL_US_CMPR		0x90	/* Comparaison Register */
 #define ATMEL_US_FMR		0xa0	/* FIFO Mode Register */
-#define	ATMEL_US_TXRDYM(data)	(((data) & 0x3) << 0)	/* TX Ready Mode */
-#define	ATMEL_US_RXRDYM(data)	(((data) & 0x3) << 4)	/* RX Ready Mode */
+#define	ATMEL_US_TXRDYM(data)	FIELD_PREP(GENMASK(1, 0), (data))	/* TX Ready Mode */
+#define	ATMEL_US_RXRDYM(data)	FIELD_PREP(GENMASK(5, 4), (data))	/* RX Ready Mode */
 #define		ATMEL_US_ONE_DATA	0x0
 #define		ATMEL_US_TWO_DATA	0x1
 #define		ATMEL_US_FOUR_DATA	0x2
 #define	ATMEL_US_FRTSC		BIT(7)	/* FIFO RTS pin Control */
-#define	ATMEL_US_TXFTHRES(thr)	(((thr) & 0x3f) << 8)	/* TX FIFO Threshold */
-#define	ATMEL_US_RXFTHRES(thr)	(((thr) & 0x3f) << 16)	/* RX FIFO Threshold */
-#define	ATMEL_US_RXFTHRES2(thr)	(((thr) & 0x3f) << 24)	/* RX FIFO Threshold2 */
+#define	ATMEL_US_TXFTHRES(thr)	FIELD_PREP(GENMASK(13, 8), (thr))	/* TX FIFO Threshold */
+#define	ATMEL_US_RXFTHRES(thr)	FIELD_PREP(GENMASK(21, 16), (thr))	/* RX FIFO Threshold */
+#define	ATMEL_US_RXFTHRES2(thr)	FIELD_PREP(GENMASK(29, 24), (thr))	/* RX FIFO Threshold2 */
 
 #define ATMEL_US_FLR		0xa4	/* FIFO Level Register */
-#define	ATMEL_US_TXFL(reg)	(((reg) >> 0) & 0x3f)	/* TX FIFO Level */
-#define	ATMEL_US_RXFL(reg)	(((reg) >> 16) & 0x3f)	/* RX FIFO Level */
+#define	ATMEL_US_TXFL(reg)	FIELD_GET(GENMASK(5, 0), (reg))		/* TX FIFO Level */
+#define	ATMEL_US_RXFL(reg)	FIELD_GET(GENMASK(21, 16), (reg))	/* RX FIFO Level */
 
 #define ATMEL_US_FIER		0xa8	/* FIFO Interrupt Enable Register */
 #define ATMEL_US_FIDR		0xac	/* FIFO Interrupt Disable Register */
-- 
2.34.1

