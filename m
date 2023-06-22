Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1D73A3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjFVO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjFVO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:14 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5401BD3;
        Thu, 22 Jun 2023 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjlL749POLc458GlWLRNNri1NUsgCuh3v/YoFElLBtY=; b=G85cFQ3JOCgUBiDDwphMR0OAow
        daaTLqjzSEE2ptl59o8LuXr+ymH3UF0ho84FXgIDyMf3J0QgBoaMKH4rTHvjjvlv5NOHofHaxSugb
        HK32/1vgDrCZPTcWrnSYpMacayaUjdB7j5g96p+Va3LJOYkuEnF8S0SX6mfswlEMPS6I=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLl8-0002fr-2v; Thu, 22 Jun 2023 10:58:06 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:45 -0400
Message-Id: <20230622145800.2442116-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622145800.2442116-1-hugo@hugovil.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 02/17] rtc: pcf2127: improve timestamp reading performance
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reading the 7 timetamp registers currently involves reading 25 registers
solely to be able to print the content of the three control registers,
in addition to the 7 timestamp registers. This print never occurs,
unless the user enables dynamic debug in this driver or set
CONFIG_RTC_DEBUG.

Reading the timestamp registers should consist of reading 7
consecutive timestamp registers.

This patch optimize the performance of reading the timestamp registers
by reading 7 consecutive registers instead of 25, and dropping the
print of the control registers.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 475a627b2254..a913a5c82ebf 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -66,12 +66,6 @@
 #define PCF2127_REG_TS_CTRL		0x12
 #define PCF2127_BIT_TS_CTRL_TSOFF		BIT(6)
 #define PCF2127_BIT_TS_CTRL_TSM			BIT(7)
-#define PCF2127_REG_TS_SC		0x13
-#define PCF2127_REG_TS_MN		0x14
-#define PCF2127_REG_TS_HR		0x15
-#define PCF2127_REG_TS_DM		0x16
-#define PCF2127_REG_TS_MO		0x17
-#define PCF2127_REG_TS_YR		0x18
 /*
  * RAM registers
  * PCF2127 has 512 bytes general-purpose static RAM (SRAM) that is
@@ -440,9 +434,9 @@ static int pcf2127_rtc_ts_read(struct device *dev, time64_t *ts)
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
 	struct rtc_time tm;
 	int ret;
-	unsigned char data[25];
+	unsigned char data[7];
 
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, data,
+	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_TS_CTRL, data,
 			       sizeof(data));
 	if (ret) {
 		dev_err(dev, "%s: read error ret=%d\n", __func__, ret);
@@ -450,20 +444,16 @@ static int pcf2127_rtc_ts_read(struct device *dev, time64_t *ts)
 	}
 
 	dev_dbg(dev,
-		"%s: raw data is cr1=%02x, cr2=%02x, cr3=%02x, ts_sc=%02x, ts_mn=%02x, ts_hr=%02x, ts_dm=%02x, ts_mo=%02x, ts_yr=%02x\n",
-		__func__, data[PCF2127_REG_CTRL1], data[PCF2127_REG_CTRL2],
-		data[PCF2127_REG_CTRL3], data[PCF2127_REG_TS_SC],
-		data[PCF2127_REG_TS_MN], data[PCF2127_REG_TS_HR],
-		data[PCF2127_REG_TS_DM], data[PCF2127_REG_TS_MO],
-		data[PCF2127_REG_TS_YR]);
-
-	tm.tm_sec = bcd2bin(data[PCF2127_REG_TS_SC] & 0x7F);
-	tm.tm_min = bcd2bin(data[PCF2127_REG_TS_MN] & 0x7F);
-	tm.tm_hour = bcd2bin(data[PCF2127_REG_TS_HR] & 0x3F);
-	tm.tm_mday = bcd2bin(data[PCF2127_REG_TS_DM] & 0x3F);
+		"%s: raw data is ts_sc=%02x, ts_mn=%02x, ts_hr=%02x, ts_dm=%02x, ts_mo=%02x, ts_yr=%02x\n",
+		__func__, data[1], data[2], data[3], data[4], data[5], data[6]);
+
+	tm.tm_sec = bcd2bin(data[1] & 0x7F);
+	tm.tm_min = bcd2bin(data[2] & 0x7F);
+	tm.tm_hour = bcd2bin(data[3] & 0x3F);
+	tm.tm_mday = bcd2bin(data[4] & 0x3F);
 	/* TS_MO register (month) value range: 1-12 */
-	tm.tm_mon = bcd2bin(data[PCF2127_REG_TS_MO] & 0x1F) - 1;
-	tm.tm_year = bcd2bin(data[PCF2127_REG_TS_YR]);
+	tm.tm_mon = bcd2bin(data[5] & 0x1F) - 1;
+	tm.tm_year = bcd2bin(data[6]);
 	if (tm.tm_year < 70)
 		tm.tm_year += 100; /* assume we are in 1970...2069 */
 
-- 
2.30.2

