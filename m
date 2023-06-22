Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468573A3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFVO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFVO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:13 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A51BD2;
        Thu, 22 Jun 2023 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NhZo2X+rvlhasT0zzoLOCM7JBzV7CQLtA3d0noDrOMM=; b=awi45ZhgnUIYyz773pBjIAV0dP
        gQDqUyWrohca42wrZt4dkCxOP6mmPfoRNykjXSHH6H042jowGI5e4Ze5LHTt00DLbqsYV7U2XkvU9
        vsFdOdxsI5EJ3aJPG123KDMUGnTP6ow3tB42WumJ0GXGYOLhjMbnOXyVsl8tE8nqmwiQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLl6-0002fr-Qv; Thu, 22 Jun 2023 10:58:05 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:44 -0400
Message-Id: <20230622145800.2442116-2-hugo@hugovil.com>
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
Subject: [PATCH v4 01/17] rtc: pcf2127: improve rtc_read_time() performance
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Improve performance and readability of rtc_read_time() by reading only
the 7 time registers, instead of reading 8 registers (additional CTRL3
register).

We drop reading of CTRL3 to monitor the low battery flag, as this
check is already available in the ioctl. Anyway, this check only
display an info message and has no other impacts.

The code readability also improves as we do not have to fiddle with
buffer pointer and size arithmetic.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 42 +++++++++++++--------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 87f4fc9df68b..475a627b2254 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -45,12 +45,6 @@
 /* Time and date registers */
 #define PCF2127_REG_SC			0x03
 #define PCF2127_BIT_SC_OSF			BIT(7)
-#define PCF2127_REG_MN			0x04
-#define PCF2127_REG_HR			0x05
-#define PCF2127_REG_DM			0x06
-#define PCF2127_REG_DW			0x07
-#define PCF2127_REG_MO			0x08
-#define PCF2127_REG_YR			0x09
 /* Alarm registers */
 #define PCF2127_REG_ALARM_SC		0x0A
 #define PCF2127_REG_ALARM_MN		0x0B
@@ -117,27 +111,22 @@ struct pcf2127 {
 static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
-	unsigned char buf[10];
+	unsigned char buf[7];
 	int ret;
 
 	/*
 	 * Avoid reading CTRL2 register as it causes WD_VAL register
 	 * value to reset to 0 which means watchdog is stopped.
 	 */
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL3,
-			       (buf + PCF2127_REG_CTRL3),
-			       ARRAY_SIZE(buf) - PCF2127_REG_CTRL3);
+	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_SC, buf,
+			       sizeof(buf));
 	if (ret) {
 		dev_err(dev, "%s: read error\n", __func__);
 		return ret;
 	}
 
-	if (buf[PCF2127_REG_CTRL3] & PCF2127_BIT_CTRL3_BLF)
-		dev_info(dev,
-			"low voltage detected, check/replace RTC battery.\n");
-
 	/* Clock integrity is not guaranteed when OSF flag is set. */
-	if (buf[PCF2127_REG_SC] & PCF2127_BIT_SC_OSF) {
+	if (buf[0] & PCF2127_BIT_SC_OSF) {
 		/*
 		 * no need clear the flag here,
 		 * it will be cleared once the new date is saved
@@ -148,20 +137,17 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	dev_dbg(dev,
-		"%s: raw data is cr3=%02x, sec=%02x, min=%02x, hr=%02x, "
+		"%s: raw data is sec=%02x, min=%02x, hr=%02x, "
 		"mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
-		__func__, buf[PCF2127_REG_CTRL3], buf[PCF2127_REG_SC],
-		buf[PCF2127_REG_MN], buf[PCF2127_REG_HR],
-		buf[PCF2127_REG_DM], buf[PCF2127_REG_DW],
-		buf[PCF2127_REG_MO], buf[PCF2127_REG_YR]);
-
-	tm->tm_sec = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
-	tm->tm_min = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
-	tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F); /* rtc hr 0-23 */
-	tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
-	tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
-	tm->tm_mon = bcd2bin(buf[PCF2127_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
-	tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]);
+		__func__, buf[0], buf[1], buf[2], buf[3], buf[4], buf[5], buf[6]);
+
+	tm->tm_sec = bcd2bin(buf[0] & 0x7F);
+	tm->tm_min = bcd2bin(buf[1] & 0x7F);
+	tm->tm_hour = bcd2bin(buf[2] & 0x3F); /* rtc hr 0-23 */
+	tm->tm_mday = bcd2bin(buf[3] & 0x3F);
+	tm->tm_wday = buf[4] & 0x07;
+	tm->tm_mon = bcd2bin(buf[5] & 0x1F) - 1; /* rtc mn 1-12 */
+	tm->tm_year = bcd2bin(buf[6]);
 	tm->tm_year += 100;
 
 	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
-- 
2.30.2

