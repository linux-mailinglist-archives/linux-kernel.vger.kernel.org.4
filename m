Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E673A3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjFVO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFVO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:16 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8541171C;
        Thu, 22 Jun 2023 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MFAeS1fpgJDPWywkckQ2YwMSJRB/NE9brhzP8O3y2c4=; b=uXFLZwLKu37ClM3jbrXGm7skz0
        4KZMsdikjmERMIlw9zeFcDR1pjsTT7V0wm/QS4mnwTO7D7pkQbZjz6pNFOsKcoAvIVD2AT85eayHH
        VmPAkd48sfOh000UeRhJhaFRPgxvdKnkisMp1SNCrjB+fOMmiCirEvB3RUchjeepN9V8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlC-0002fr-Nj; Thu, 22 Jun 2023 10:58:11 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:49 -0400
Message-Id: <20230622145800.2442116-7-hugo@hugovil.com>
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
Subject: [PATCH v4 06/17] rtc: pcf2127: adapt for time/date registers at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Some variants (PCF2131) have a 100th seconds register. This register is
currently not supported in this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 61918d7dc7a5..0b9110b936f0 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -44,7 +44,7 @@
 #define PCF2127_BIT_CTRL3_BF			BIT(3)
 #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
 /* Time and date registers */
-#define PCF2127_REG_SC			0x03
+#define PCF2127_REG_TIME_BASE		0x03
 #define PCF2127_BIT_SC_OSF			BIT(7)
 /* Alarm registers */
 #define PCF2127_REG_ALARM_SC		0x0A
@@ -101,6 +101,7 @@ struct pcf21xx_config {
 	int max_register;
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
+	u8 reg_time_base; /* Time/date base register. */
 };
 
 struct pcf2127 {
@@ -127,8 +128,8 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	 * Avoid reading CTRL2 register as it causes WD_VAL register
 	 * value to reset to 0 which means watchdog is stopped.
 	 */
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_SC, buf,
-			       sizeof(buf));
+	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->reg_time_base,
+			       buf, sizeof(buf));
 	if (ret) {
 		dev_err(dev, "%s: read error\n", __func__);
 		return ret;
@@ -194,7 +195,7 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[i++] = bin2bcd(tm->tm_year - 100);
 
 	/* write register's data */
-	err = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_SC, buf, i);
+	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->reg_time_base, buf, i);
 	if (err) {
 		dev_dbg(dev, "%s: err=%d", __func__, err);
 		return err;
@@ -627,12 +628,14 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x1d,
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
+		.reg_time_base = PCF2127_REG_TIME_BASE,
 	},
 	[PCF2129] = {
 		.type = PCF2129,
 		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.reg_time_base = PCF2127_REG_TIME_BASE,
 	},
 };
 
-- 
2.30.2

