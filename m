Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7973A3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjFVO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjFVO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:18 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3B1FC0;
        Thu, 22 Jun 2023 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SGY6nyxedz/MrsHxRZq44oAULx7Vv+IDnNYFC8bOlqQ=; b=TwHjE4EaZXO5RtVoBQ7OvDxC25
        4yHQ3kmsTsRwfaQmsX8XnjGGr+1VU6KODcj2zshTvle/lczB7bf0kiiypGTQ8UnRUbgepVyNSTGVg
        alRyNmnVSeWeyvePexrtMJE+HMVUGc6mhNf8aMgMNlMIzMF2WNeUjhDYpEOGCkR4rvrc=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlD-0002fr-PS; Thu, 22 Jun 2023 10:58:12 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:50 -0400
Message-Id: <20230622145800.2442116-8-hugo@hugovil.com>
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
Subject: [PATCH v4 07/17] rtc: pcf2127: adapt for alarm registers at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 0b9110b936f0..31f6bba81212 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -47,11 +47,7 @@
 #define PCF2127_REG_TIME_BASE		0x03
 #define PCF2127_BIT_SC_OSF			BIT(7)
 /* Alarm registers */
-#define PCF2127_REG_ALARM_SC		0x0A
-#define PCF2127_REG_ALARM_MN		0x0B
-#define PCF2127_REG_ALARM_HR		0x0C
-#define PCF2127_REG_ALARM_DM		0x0D
-#define PCF2127_REG_ALARM_DW		0x0E
+#define PCF2127_REG_ALARM_BASE		0x0A
 #define PCF2127_BIT_ALARM_AE			BIT(7)
 /* CLKOUT control register */
 #define PCF2127_REG_CLKOUT		0x0f
@@ -102,6 +98,7 @@ struct pcf21xx_config {
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
 	u8 reg_time_base; /* Time/date base register. */
+	u8 regs_alarm_base; /* Alarm function base registers. */
 };
 
 struct pcf2127 {
@@ -381,8 +378,8 @@ static int pcf2127_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
-			       sizeof(buf));
+	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
+			       buf, sizeof(buf));
 	if (ret)
 		return ret;
 
@@ -432,8 +429,8 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	buf[3] = bin2bcd(alrm->time.tm_mday);
 	buf[4] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
 
-	ret = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
-				sizeof(buf));
+	ret = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
+				buf, sizeof(buf));
 	if (ret)
 		return ret;
 
@@ -629,6 +626,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
+		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 	},
 	[PCF2129] = {
 		.type = PCF2129,
@@ -636,6 +634,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
+		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 	},
 };
 
-- 
2.30.2

