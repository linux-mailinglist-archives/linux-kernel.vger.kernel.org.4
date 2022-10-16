Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D73600151
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJPQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJPQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:29:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8931FA;
        Sun, 16 Oct 2022 09:29:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so20092552ejd.9;
        Sun, 16 Oct 2022 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpGhma0ux544N/LSculCP7CyWmsp71OY4+BVJajygNs=;
        b=bM+38r1+2BJ08XEH5whOixcOrcvZipu76RP2quEg8G3JMV2LSyzKei4cC0nxHoH0cI
         PCEQBPB9A6hAFfeGfA2QFzDB0hRoHVXlQANriM0RjghU0B2oQqlmDsAORbV3sA6GoPGI
         ompg6eCfvGRBLpz82uYmBwjAuYywSnx3T9vQgK6wb5IhkJR3aZoln1fZvEfvQhjwCaGb
         GBQNagWXxfAfCPuPJ4pEehcdHQsZ/zJaWTAXpUXpYF5HjkmviZx8VLDcUe+afksAfTwR
         7NSORFjPLEoGCrXNNF/SmXt/DQS4NjgqxnhW4mL9976kqk/yQrTZBgPsuTjMjYk2Rtw2
         tT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpGhma0ux544N/LSculCP7CyWmsp71OY4+BVJajygNs=;
        b=7tVlhIEmRy38/f9vk28OJekqddZtMZDpqDoGtWwUWvYd9h+ivrV92IwPflY17M6GNC
         VdgVFamKsCjXy5Pxjy0RCNZD5a0yvr94gw2o5P6eatDyzHWki7bPufMM101BvngvhgeP
         uShqTuDYaBv489rTq0IKLQ3LJzuu5/DO/pTeRodSTMTHNMfbDEAka4FEdLmdNn7/w2Kc
         NeDJXQATyFmmmMT5oIBfS6OlQ9we0WvZLbK9Lje19XVx0ftUfIXA2klUwBGy1bo8JZt6
         iT12fJ/rzP+vnHS8AR9WpyWJAFmu8AObFeDYAysTPJ9hZ5fPHzQZkZxzKcXXiDEDJCLN
         LwPQ==
X-Gm-Message-State: ACrzQf0MFeiROjp4Inbd1B4pplI4lSuaAqLsmxCp3HDwKNh3VgB6AtBI
        sVHaogSEBZwgFJpxhnX6Kas=
X-Google-Smtp-Source: AMsMyM7QZmS9xwdLhwpXKGqKT6fYAKGYwG4o4ecob0rjYZajxmN1WRs56mPv6Hi10pn1Ofh80iaO2g==
X-Received: by 2002:a17:906:dc8a:b0:788:4d96:1274 with SMTP id cs10-20020a170906dc8a00b007884d961274mr5721699ejc.540.1665937757268;
        Sun, 16 Oct 2022 09:29:17 -0700 (PDT)
Received: from fedora.. ([88.147.86.156])
        by smtp.gmail.com with ESMTPSA id h16-20020a170906719000b0078135401b9csm4790142ejk.130.2022.10.16.09.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:29:16 -0700 (PDT)
From:   tollsimy <simonetollardo@gmail.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tollsimy <simonetollardo@gmail.com>
Subject: [PATCH] Microchip MCP795xx RTC driver patch
Date:   Sun, 16 Oct 2022 18:29:13 +0200
Message-Id: <20221016162913.38661-1-simonetollardo@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC Microchip mcp795 patch for 5.19-rc5

Here is the mcp795 patch for the 5.19-rc5 merge window.
The main modification are the following:
        - fixed wrong driver naming: RTC is a Microchip
          mcp795 and not Maxim mcp795
        - added date/time write sequences: added date/time      
          write sequences accordingly to official silicon 
          errata document to fix silicon bugs.
        - added support to date/time permanent storage:
          the driver was missing some register bits in order
          to enable the storage of date/time whenever the       
          device looses main power.
        - added a check after starting oscillator in order
          to be sure that it is properly working as specified
          in the datasheet
        - renamed OSCON bit to OSCRUN as in the datasheet
        - add debug messages when setting and reading the
          alarm
        - removed wrong offset when retrieving the current
          year from the device

The patch has been successfully tested in the latest
linux-next releases, and the original problems that I found have
all been resolved.

Signed-off-by: tollsimy <simonetollardo@gmail.com>

---
 .../devicetree/bindings/rtc/maxim,mcp795.txt  |  11 -
 .../bindings/rtc/microchip,mcp795.txt         |  11 +
 drivers/rtc/rtc-mcp795.c                      | 359 ++++++++++++++----
 3 files changed, 296 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mcp795.txt

diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
deleted file mode 100644
index a59fdd8c236d..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-* Maxim MCP795		SPI Serial Real-Time Clock
-
-Required properties:
-- compatible: Should contain "maxim,mcp795".
-- reg: SPI address for chip
-
-Example:
-	mcp795: rtc@0 {
-		compatible = "maxim,mcp795";
-		reg = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/microchip,mcp795.txt b/Documentation/devicetree/bindings/rtc/microchip,mcp795.txt
new file mode 100644
index 000000000000..854364c3a173
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microchip,mcp795.txt
@@ -0,0 +1,11 @@
+* Microchip MCP795		SPI Serial Real-Time Clock
+
+Required properties:
+- compatible: Should contain "microchip,mcp795".
+- reg: SPI address for chip
+
+Example:
+	mcp795: rtc@0 {
+		compatible = "microchip,mcp795";
+		reg = <0>;
+	};
diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 0d515b3df571..292a440b62dd 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -3,11 +3,15 @@
  * SPI Driver for Microchip MCP795 RTC
  *
  * Copyright (C) Josef Gajdusek <atx@atx.name>
+ * Copyright (C) 2022 Simone Tollardo <simone.tollardo@gmail.com>
  *
  * based on other Linux RTC drivers
  *
  * Device datasheet:
- * https://ww1.microchip.com/downloads/en/DeviceDoc/22280A.pdf
+ * https://ww1.microchip.com/downloads/en/DeviceDoc/MCP7951X-MCP7952X-Battery-Backed-SPI-RTCC-20002300C.pdf
+ *
+ * Device errata:
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/MCP795XX-Family-Silicon-Errata-80000680D.pdf
  */
 
 #include <linux/module.h>
@@ -32,28 +36,148 @@
 #define MCP795_UNLOCK	0x14
 #define MCP795_IDWRITE	0x32
 #define MCP795_IDREAD	0x33
-#define MCP795_CLRWDT	0x44
 #define MCP795_CLRRAM	0x54
 
 /* MCP795 RTCC registers, see datasheet table 4-1 */
+#define MCP795_REG_TMSECONDS	0x00	/* Tenths of ms (=centi-seconds) */
 #define MCP795_REG_SECONDS	0x01
+#define MCP795_REG_MINUTES	0x02
+#define MCP795_REG_HOURS	0x03
 #define MCP795_REG_DAY		0x04
+#define MCP795_REG_DATE		0x05
 #define MCP795_REG_MONTH	0x06
+#define MCP795_REG_YEAR		0x07
 #define MCP795_REG_CONTROL	0x08
+#define MCP795_REG_OSC_TRIM	0x09
+/* Alarm 0 */
 #define MCP795_REG_ALM0_SECONDS	0x0C
+#define MCP795_REG_ALM0_MINUTES	0x0D
+#define MCP795_REG_ALM0_HOURS	0x0E
 #define MCP795_REG_ALM0_DAY	0x0F
-
-#define MCP795_ST_BIT		BIT(7)
-#define MCP795_24_BIT		BIT(6)
-#define MCP795_LP_BIT		BIT(5)
-#define MCP795_EXTOSC_BIT	BIT(3)
-#define MCP795_OSCON_BIT	BIT(5)
-#define MCP795_ALM0_BIT		BIT(4)
-#define MCP795_ALM1_BIT		BIT(5)
-#define MCP795_ALM0IF_BIT	BIT(3)
-#define MCP795_ALM0C0_BIT	BIT(4)
-#define MCP795_ALM0C1_BIT	BIT(5)
-#define MCP795_ALM0C2_BIT	BIT(6)
+#define MCP795_REG_ALM0_DATE	0x10
+#define MCP795_REG_ALM0_MONTH	0x11	/* Month only for alarm 0 */
+/* Alarm 1 */
+#define MCP795_REG_ALM1_TMSECONDS	0x12	/* Centi-seconds only for alarm 1 */
+#define MCP795_REG_ALM1_SECONDS	0x13
+#define MCP795_REG_ALM1_MINUTES	0x14
+#define MCP795_REG_ALM1_HOURS	0x15
+#define MCP795_REG_ALM1_DAY	0x16
+#define MCP795_REG_ALM1_DATE	0x17
+
+/* Power-Fail Timestamp */
+/* Power-Down Timetsamp */
+#define MCP795_REG_PWD_MINUTES	0x18
+#define MCP795_REG_PWD_HOURS	0x19
+#define MCP795_REG_PWD_DATE	0x1A
+#define MCP795_REG_PWD_MONTH	0x1B
+/* Power-Up Timestamp */
+#define MCP795_REG_PUP_MINUTES	0x1C
+#define MCP795_REG_PUP_HOURS	0x1D
+#define MCP795_REG_PUP_DATE	0x1E
+#define MCP795_REG_PUP_MONTH	0x1F
+
+/* MCP795_REG_CONTROL bits */
+
+/* MISC */
+#define MCP795_ST_BIT		BIT(7)	/* Status bit */
+#define MCP795_24_BIT		BIT(6)	/* 12/24 hour mode */
+#define MCP795_LP_BIT		BIT(5)	/* Leap Year */
+#define MCP795_OSCRUN_BIT	BIT(5)  /* Oscillator Run */
+#define MCP795_PWRFAIL_BIT	BIT(4)  /* Power Fail */
+#define MCP795_VBATEN_BIT	BIT(3)  /* VBAT Enable */
+
+/* RTCC 0x08 register bits */
+#define MCP795_SQWEN_BIT	BIT(6)  /* Square Wave Enable (MFP pin) */
+#define MCP795_ALM1_EN_BIT	BIT(5)  /* Alarm 1 Enable */
+#define MCP795_ALM0_EN_BIT	BIT(4)  /* Alarm 0 Enable */
+#define MCP795_EXTOSC_BIT	BIT(3)	/* External Oscillator */
+#define MCP795_CRSTRIM_BIT	BIT(2)  /* Crystal Trim */
+#define MCP795_SQWFS_BIT_H	BIT(1)  /* Square Wave Frequency Select H */
+#define MCP795_SQWFS_BIT_L	BIT(0)  /* Square Wave Frequency Select L */
+
+/* Alarms (0 and 1) */
+
+/* Centi-seconds - ALARM 1 ONLY */
+/* Alarms BCD Decimal Values of Centi-Second's Tens Digit (=deci-seconds) */
+#define MCP795_ALM1_CSEC_T_C0_BIT	BIT(4)
+#define MCP795_ALM1_CSEC_T_C1_BIT	BIT(5)
+#define MCP795_ALM1_CSEC_T_C2_BIT	BIT(6)
+#define MCP795_ALM1_CSEC_T_C3_BIT	BIT(6)
+/* Alarms BCD Decimal Values of Centi-Second's Ones Digit (=centi-seconds) */
+#define MCP795_ALM1_CSEC_O_C0_BIT	BIT(0)
+#define MCP795_ALM1_CSEC_O_C1_BIT	BIT(1)
+#define MCP795_ALM1_CSEC_O_C2_BIT	BIT(2)
+#define MCP795_ALM1_CSEC_O_C3_BIT	BIT(3)
+
+/* Seconds */
+/* Alarms BCD Decimal Values of Second's Tens Digit */
+#define MCP795_ALM_SEC_T_C0_BIT	BIT(4)
+#define MCP795_ALM_SEC_T_C1_BIT	BIT(5)
+#define MCP795_ALM_SEC_T_C2_BIT	BIT(6)
+/* Alarms BCD Decimal Values of Second's Ones Digit */
+#define MCP795_ALM_SEC_O_C0_BIT	BIT(0)
+#define MCP795_ALM_SEC_O_C1_BIT	BIT(1)
+#define MCP795_ALM_SEC_O_C2_BIT	BIT(2)
+#define MCP795_ALM_SEC_O_C3_BIT	BIT(3)
+
+/* Minutes */
+/* Alarms BCD Decimal Values of Minute's Tens Digit */
+#define MCP795_ALM_MIN_T_C0_BIT	BIT(4)
+#define MCP795_ALM_MIN_T_C1_BIT	BIT(5)
+#define MCP795_ALM_MIN_T_C2_BIT	BIT(6)
+/* Alarms BCD Decimal Values of Minute's Ones Digit */
+#define MCP795_ALM_MIN_O_C0_BIT	BIT(0)
+#define MCP795_ALM_MIN_O_C1_BIT	BIT(1)
+#define MCP795_ALM_MIN_O_C2_BIT	BIT(2)
+#define MCP795_ALM_MIN_O_C3_BIT	BIT(3)
+
+/* Hours */
+/* Alarms BCD Decimal Values of Hour's Tens Digit */
+#define MCP795_ALM_HOUR_T_C0_BIT	BIT(4)
+/* Alarms BCD Decimal Values of Hour's Ones Digit */
+#define MCP795_ALM_HOUR_O_C0_BIT	BIT(0)
+#define MCP795_ALM_HOUR_O_C1_BIT	BIT(1)
+#define MCP795_ALM_HOUR_O_C2_BIT	BIT(2)
+#define MCP795_ALM_HOUR_O_C3_BIT	BIT(3)
+
+/* Days */
+/* Alarms Interrupt Flag */
+#define MCP795_ALM_IF_BIT	BIT(3)
+/* Alarms BCD Decimal Values of Day's Ones Digit */
+#define MCP795_ALM_DAY_O_C0_BIT	BIT(0)
+#define MCP795_ALM_DAY_O_C1_BIT	BIT(1)
+#define MCP795_ALM_DAY_O_C2_BIT	BIT(2)
+
+/* Date */
+/* Alarms BCD Decimal Values of Date's Tens Digit */
+#define MCP795_ALM_DATE_T_C0_BIT	BIT(4)
+#define MCP795_ALM_DATE_T_C1_BIT	BIT(5)
+/* Alarms BCD Decimal Values of Date's Ones Digit */
+#define MCP795_ALM_DATE_O_C0_BIT	BIT(0)
+#define MCP795_ALM_DATE_O_C1_BIT	BIT(1)
+#define MCP795_ALM_DATE_O_C2_BIT	BIT(2)
+#define MCP795_ALM_DATE_O_C3_BIT	BIT(3)
+
+/* Months */
+/* Alarms BCD Decimal Values of Month's Tens Digit */
+#define MCP795_ALM0_MONTH_T_C0_BIT	BIT(3)
+/* Alarms BCD Decimal Values of Month's Ones Digit */
+#define MCP795_ALM0_MONTH_O_C0_BIT	BIT(0)
+#define MCP795_ALM0_MONTH_O_C1_BIT	BIT(1)
+#define MCP795_ALM0_MONTH_O_C2_BIT	BIT(2)
+#define MCP795_ALM0_MONTH_O_C3_BIT	BIT(3)
+
+/* Alarms Masks */
+#define MCP795_ALM_MASKS_BIT	BIT(4)
+
+/* BCD mask values for alarm matching - need BCD conversion */
+#define MCP795_ALM_MASK_SEC	0x00
+#define MCP795_ALM_MASK_MIN	0x01
+#define MCP795_ALM_MASK_HOUR	0x02
+#define MCP795_ALM_MASK_DAY	0x03
+#define MCP795_ALM_MASK_DATE	0x04
+#define MCP795_ALM_MASK_CSEC	0x05
+#define MCP795_ALM_MASK_ALL	0x07
 
 #define SEC_PER_DAY		(24 * 60 * 60)
 
@@ -69,7 +193,7 @@ static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
 
 	if (ret)
 		dev_err(dev, "Failed reading %d bytes from address %x.\n",
-					count, addr);
+			count, addr);
 
 	return ret;
 }
@@ -88,7 +212,7 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
 
 	if (ret)
 		dev_err(dev, "Failed to write %d bytes to address %x.\n",
-					count, addr);
+			count, addr);
 
 	return ret;
 }
@@ -123,17 +247,16 @@ static int mcp795_stop_oscillator(struct device *dev, bool *extosc)
 	if (ret)
 		return ret;
 	*extosc = !!(data & MCP795_EXTOSC_BIT);
-	ret = mcp795_rtcc_set_bits(
-				dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, 0);
+	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, 0);
 	if (ret)
 		return ret;
-	/* wait for the OSCON bit to clear */
+	/* wait for the OSCRUN bit to clear */
 	do {
 		usleep_range(700, 800);
 		ret = mcp795_rtcc_read(dev, MCP795_REG_DAY, &data, 1);
 		if (ret)
 			break;
-		if (!(data & MCP795_OSCON_BIT))
+		if (!(data & MCP795_OSCRUN_BIT))
 			break;
 
 	} while (--retries);
@@ -143,17 +266,34 @@ static int mcp795_stop_oscillator(struct device *dev, bool *extosc)
 
 static int mcp795_start_oscillator(struct device *dev, bool *extosc)
 {
+	int ret;
+	int retries = 5;
+
 	if (extosc) {
 		u8 data = *extosc ? MCP795_EXTOSC_BIT : 0;
-		int ret;
 
-		ret = mcp795_rtcc_set_bits(
-			dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, data);
+		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, data);
 		if (ret)
 			return ret;
 	}
-	return mcp795_rtcc_set_bits(
-			dev, MCP795_REG_SECONDS, MCP795_ST_BIT, MCP795_ST_BIT);
+	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS, MCP795_ST_BIT, MCP795_ST_BIT);
+	if (ret)
+		return ret;
+
+	/* wait for the OSCRUN bit to set */
+	do {
+		u8 data = MCP795_OSCRUN_BIT;
+
+		usleep_range(700, 800);
+		ret = mcp795_rtcc_read(dev, MCP795_REG_DAY, &data, 1);
+		if (ret)
+			break;
+		if ((data & MCP795_OSCRUN_BIT))
+			break;
+
+	} while (--retries);
+
+	return !retries ? -EIO : ret;
 }
 
 /* Enable or disable Alarm 0 in RTC */
@@ -164,18 +304,24 @@ static int mcp795_update_alarm(struct device *dev, bool enable)
 	dev_dbg(dev, "%s alarm\n", enable ? "Enable" : "Disable");
 
 	if (enable) {
+		/* Disable Square Wave Function to enable Alarm output */
+		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL,
+					   MCP795_SQWEN_BIT, 0);
 		/* clear ALM0IF (Alarm 0 Interrupt Flag) bit */
 		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_ALM0_DAY,
-					MCP795_ALM0IF_BIT, 0);
+					   MCP795_ALM_IF_BIT, 0);
 		if (ret)
 			return ret;
 		/* enable alarm 0 */
 		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL,
-					MCP795_ALM0_BIT, MCP795_ALM0_BIT);
+					   MCP795_ALM0_EN_BIT, MCP795_ALM0_EN_BIT);
 	} else {
 		/* disable alarm 0 and alarm 1 */
 		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL,
-					MCP795_ALM0_BIT | MCP795_ALM1_BIT, 0);
+					   MCP795_ALM0_EN_BIT | MCP795_ALM1_EN_BIT, 0);
+		/* Disable Alarm output to let enable Square Wave Function */
+		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL,
+					   MCP795_SQWEN_BIT, 0);
 	}
 	return ret;
 }
@@ -183,7 +329,7 @@ static int mcp795_update_alarm(struct device *dev, bool enable)
 static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 {
 	int ret;
-	u8 data[7];
+	u8 data[8];
 	bool extosc;
 
 	/* Stop RTC and store current value of EXTOSC bit */
@@ -192,32 +338,42 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 		return ret;
 
 	/* Read first, so we can leave config bits untouched */
-	ret = mcp795_rtcc_read(dev, MCP795_REG_SECONDS, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_TMSECONDS, data, sizeof(data));
 
 	if (ret)
 		return ret;
 
-	data[0] = (data[0] & 0x80) | bin2bcd(tim->tm_sec);
-	data[1] = (data[1] & 0x80) | bin2bcd(tim->tm_min);
-	data[2] = bin2bcd(tim->tm_hour);
-	data[3] = (data[3] & 0xF8) | bin2bcd(tim->tm_wday + 1);
-	data[4] = bin2bcd(tim->tm_mday);
-	data[5] = (data[5] & MCP795_LP_BIT) | bin2bcd(tim->tm_mon + 1);
-
-	if (tim->tm_year > 100)
-		tim->tm_year -= 100;
-
-	data[6] = bin2bcd(tim->tm_year);
-
-	/* Always write the date and month using a separate Write command.
-	 * This is a workaround for a know silicon issue that some combinations
-	 * of date and month values may result in the date being reset to 1.
-	 */
-	ret = mcp795_rtcc_write(dev, MCP795_REG_SECONDS, data, 5);
+	data[0] = 0x00;	//centiseconds not implemented
+	data[1] = (data[0] & 0x80) | bin2bcd(tim->tm_sec);
+	data[2] = (data[1] & 0x80) | bin2bcd(tim->tm_min);
+	data[3] = (data[3] & 0xC0) | bin2bcd(tim->tm_hour);
+	/* Add one beacause Linux weekday is from 0 to 6 */
+	data[4] = (data[3] & 0xF8) | bin2bcd(tim->tm_wday + 1);
+	data[5] = (data[5] & 0xC0) | bin2bcd(tim->tm_mday);
+	/* Add one because Linux month is from 0 to 11 */
+	data[6] = (data[6] & 0xC0) | ((data[6] & MCP795_LP_BIT)
+				| bin2bcd(tim->tm_mon + 1));
+	data[7] = bin2bcd(tim->tm_year);
+
+	/* Set time sequence needed to avoid common device problems, see errata */
+	/* Write month */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_MONTH, &data[6], 1);
 	if (ret)
 		return ret;
-
-	ret = mcp795_rtcc_write(dev, MCP795_REG_MONTH, &data[5], 2);
+	/* Write data (month day) */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_DATE, &data[5], 1);
+	if (ret)
+		return ret;
+	/* Write month again */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_MONTH, &data[6], 1);
+	if (ret)
+		return ret;
+	/* Send the rest apart from year and dayweek */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_TMSECONDS, data, 4);
+	if (ret)
+		return ret;
+	/* Send the year */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_YEAR, &data[7], 1);
 	if (ret)
 		return ret;
 
@@ -229,6 +385,14 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
+	/* Always set the weekday using a separate Write command and when
+	 * oscillator is running.
+	 * This is a workaround for a know silicon issue.
+	 */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_DAY, &data[4], 1);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "Set mcp795: %ptR\n", tim);
 
 	return 0;
@@ -237,20 +401,23 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 {
 	int ret;
-	u8 data[7];
+	u8 data[8];
+	int tm_c_sec;
 
-	ret = mcp795_rtcc_read(dev, MCP795_REG_SECONDS, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_TMSECONDS, data, sizeof(data));
 
 	if (ret)
 		return ret;
 
-	tim->tm_sec	= bcd2bin(data[0] & 0x7F);
-	tim->tm_min	= bcd2bin(data[1] & 0x7F);
-	tim->tm_hour	= bcd2bin(data[2] & 0x3F);
-	tim->tm_wday	= bcd2bin(data[3] & 0x07) - 1;
-	tim->tm_mday	= bcd2bin(data[4] & 0x3F);
-	tim->tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
-	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
+	tm_c_sec	= bcd2bin(data[0] & 0xFF);
+	tim->tm_sec	= bcd2bin(data[1] & 0x7F);
+	tim->tm_min	= bcd2bin(data[2] & 0x7F);
+	/* This is only for 24h mode, see datasheet for 12h mode */
+	tim->tm_hour	= bcd2bin(data[3] & 0x3F);
+	tim->tm_wday	= bcd2bin(data[4] & 0x07) - 1;
+	tim->tm_mday	= bcd2bin(data[5] & 0x3F);
+	tim->tm_mon	= bcd2bin(data[6] & 0x1F) - 1;
+	tim->tm_year	= bcd2bin(data[7]);
 
 	dev_dbg(dev, "Read from mcp795: %ptR\n", tim);
 
@@ -265,6 +432,17 @@ static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	u8 tmp[6];
 	int ret;
 
+	/* Set Alarm 0 Mask to match all */
+	/* Read first, so we can leave other bits untouched */
+	ret = mcp795_rtcc_read(dev, MCP795_REG_ALM0_DAY, tmp, 1);
+	if (ret)
+		return ret;
+	/* Set Alarm 0 Mask to match all */
+	tmp[0] = (tmp[0] & 0x8F) | (bin2bcd(MCP795_ALM_MASK_ALL) << 4);
+	ret = mcp795_rtcc_write(dev, MCP795_REG_ALM0_DAY, tmp, 1);
+	if (ret)
+		return ret;
+
 	/* Read current time from RTC hardware */
 	ret = mcp795_read_time(dev, &now_tm);
 	if (ret)
@@ -291,12 +469,14 @@ static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alm->time.tm_isdst	= -1;
 	alm->time.tm_yday	= -1;
 
+	/* set alarm match: seconds, minutes, hour, day, date and month */
 	tmp[0] = (tmp[0] & 0x80) | bin2bcd(alm->time.tm_sec);
 	tmp[1] = (tmp[1] & 0x80) | bin2bcd(alm->time.tm_min);
 	tmp[2] = (tmp[2] & 0xE0) | bin2bcd(alm->time.tm_hour);
 	tmp[3] = (tmp[3] & 0x80) | bin2bcd(alm->time.tm_wday + 1);
-	/* set alarm match: seconds, minutes, hour, day, date and month */
-	tmp[3] |= (MCP795_ALM0C2_BIT | MCP795_ALM0C1_BIT | MCP795_ALM0C0_BIT);
+	/* ALMxIF cleared in the update function */
+	tmp[3] |= (MCP795_ALM_SEC_T_C2_BIT | MCP795_ALM_SEC_T_C1_BIT
+				| MCP795_ALM_SEC_T_C0_BIT);
 	tmp[4] = (tmp[4] & 0xC0) | bin2bcd(alm->time.tm_mday);
 	tmp[5] = (tmp[5] & 0xE0) | bin2bcd(alm->time.tm_mon + 1);
 
@@ -309,10 +489,14 @@ static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		ret = mcp795_update_alarm(dev, true);
 		if (ret)
 			return ret;
+		alm->pending = 1;
 		dev_dbg(dev, "Alarm IRQ armed\n");
 	}
-	dev_dbg(dev, "Set alarm: %ptRdr(%d) %ptRt\n",
-		&alm->time, alm->time.tm_wday, &alm->time);
+
+	/* do not print year, it's not implemented in the RTC hardware */
+	dev_dbg(dev, "Set alarm: %02d-%02dT%02d:%02d:%02d\n", alm->time.tm_mon + 1,
+		alm->time.tm_mday, alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+
 	return 0;
 }
 
@@ -321,8 +505,7 @@ static int mcp795_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	u8 data[6];
 	int ret;
 
-	ret = mcp795_rtcc_read(
-			dev, MCP795_REG_ALM0_SECONDS, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_ALM0_SECONDS, data, sizeof(data));
 	if (ret)
 		return ret;
 
@@ -336,8 +519,17 @@ static int mcp795_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alm->time.tm_isdst	= -1;
 	alm->time.tm_yday	= -1;
 
-	dev_dbg(dev, "Read alarm: %ptRdr(%d) %ptRt\n",
-		&alm->time, alm->time.tm_wday, &alm->time);
+	alm->pending = !!(data[3] & MCP795_ALM_IF_BIT);
+
+	ret = mcp795_rtcc_read(dev, MCP795_REG_CONTROL, data, 1);
+	if (ret)
+		return ret;
+	alm->enabled = !!(data[0] & MCP795_ALM0_EN_BIT);
+
+	/* Do not print year, it's not implemented in the RTC hardware */
+	dev_dbg(dev, "Read alarm: %02d-%02dT%02d:%02d:%02d\n", alm->time.tm_mon + 1,
+		alm->time.tm_mday, alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+
 	return 0;
 }
 
@@ -381,6 +573,7 @@ static int mcp795_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	int ret;
+	u8 data;
 
 	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
@@ -393,10 +586,10 @@ static int mcp795_probe(struct spi_device *spi)
 	/* Start the oscillator but don't set the value of EXTOSC bit */
 	mcp795_start_oscillator(&spi->dev, NULL);
 	/* Clear the 12 hour mode flag*/
-	mcp795_rtcc_set_bits(&spi->dev, 0x03, MCP795_24_BIT, 0);
+	mcp795_rtcc_set_bits(&spi->dev, MCP795_REG_HOURS, MCP795_24_BIT, 0);
 
 	rtc = devm_rtc_device_register(&spi->dev, "rtc-mcp795",
-					&mcp795_rtc_ops, THIS_MODULE);
+				       &mcp795_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
@@ -409,22 +602,40 @@ static int mcp795_probe(struct spi_device *spi)
 		 * the interrupt.
 		 */
 		mcp795_rtcc_set_bits(&spi->dev, MCP795_REG_ALM0_DAY,
-					MCP795_ALM0IF_BIT, 0);
-		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
-				mcp795_irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				dev_name(&rtc->dev), spi);
+				     MCP795_ALM_IF_BIT, 0);
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL, mcp795_irq,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						dev_name(&rtc->dev), spi);
 		if (ret)
 			dev_err(&spi->dev, "Failed to request IRQ: %d: %d\n",
-						spi->irq, ret);
+				spi->irq, ret);
 		else
 			device_init_wakeup(&spi->dev, true);
 	}
+
+	/* If PWRFAIL BIT is set, it must be cleared */
+	ret = mcp795_rtcc_read(&spi->dev, MCP795_REG_DAY, &data, 1);
+	if (ret)
+		return ret;
+
+	if (!!(data & MCP795_PWRFAIL_BIT)) {
+		ret = mcp795_rtcc_set_bits(&spi->dev, MCP795_REG_DAY,
+					   MCP795_PWRFAIL_BIT, 0);
+		if (ret)
+			return ret;
+	}
+	/* Set VBAT flag to 1 */
+	ret = mcp795_rtcc_set_bits(&spi->dev, MCP795_REG_DAY, MCP795_VBATEN_BIT,
+				   MCP795_VBATEN_BIT);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
 #ifdef CONFIG_OF
 static const struct of_device_id mcp795_of_match[] = {
-	{ .compatible = "maxim,mcp795" },
+	{ .compatible = "microchip,mcp795" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp795_of_match);
-- 
2.37.3

