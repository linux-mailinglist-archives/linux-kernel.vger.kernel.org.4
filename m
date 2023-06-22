Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3189B73A3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjFVO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjFVO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:18 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042FE9;
        Thu, 22 Jun 2023 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6I1cEHhy5Roy7I0XVKIfzmtn2VgEqrBDuhUdFcLK8pA=; b=CUn3JunHbMJzvxbPy/JLVjvKCk
        157bRh19u+SdhEFCKCYS4oyfwNzwPU5/zvacYfdWrbammRSTB+otpF7E4nat0oB4E2f55bzI4fZJS
        MC3tzXAccE+hvjbCTo0uGhYj+xhkrHfAqDfhdr2zFlACriHDHA5i8ttI9x8qE7t9cULc=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlE-0002fr-Rd; Thu, 22 Jun 2023 10:58:13 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Thu, 22 Jun 2023 10:57:51 -0400
Message-Id: <20230622145800.2442116-9-hugo@hugovil.com>
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
Subject: [PATCH v4 08/17] rtc: pcf2127: adapt for WD registers at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 drivers/rtc/rtc-pcf2127.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 31f6bba81212..ce7fe6e2fd47 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -99,6 +99,8 @@ struct pcf21xx_config {
 	unsigned int has_bit_wd_ctl_cd0:1;
 	u8 reg_time_base; /* Time/date base register. */
 	u8 regs_alarm_base; /* Alarm function base registers. */
+	u8 reg_wd_ctl; /* Watchdog control register. */
+	u8 reg_wd_val; /* Watchdog value register. */
 };
 
 struct pcf2127 {
@@ -269,7 +271,7 @@ static int pcf2127_wdt_ping(struct watchdog_device *wdd)
 {
 	struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
 
-	return regmap_write(pcf2127->regmap, PCF2127_REG_WD_VAL, wdd->timeout);
+	return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val, wdd->timeout);
 }
 
 /*
@@ -303,7 +305,7 @@ static int pcf2127_wdt_stop(struct watchdog_device *wdd)
 {
 	struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
 
-	return regmap_write(pcf2127->regmap, PCF2127_REG_WD_VAL,
+	return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val,
 			    PCF2127_WD_VAL_STOP);
 }
 
@@ -352,7 +354,7 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 	watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
 
 	/* Test if watchdog timer is started by bootloader */
-	ret = regmap_read(pcf2127->regmap, PCF2127_REG_WD_VAL, &wdd_timeout);
+	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val, &wdd_timeout);
 	if (ret)
 		return ret;
 
@@ -627,6 +629,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 1,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
+		.reg_wd_ctl = PCF2127_REG_WD_CTL,
+		.reg_wd_val = PCF2127_REG_WD_VAL,
 	},
 	[PCF2129] = {
 		.type = PCF2129,
@@ -635,6 +639,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.has_bit_wd_ctl_cd0 = 0,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
+		.reg_wd_ctl = PCF2127_REG_WD_CTL,
+		.reg_wd_val = PCF2127_REG_WD_VAL,
 	},
 };
 
@@ -736,7 +742,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	 * as T. Bits labeled as T must always be written with
 	 * logic 0.
 	 */
-	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_WD_CTL,
+	ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_wd_ctl,
 				 PCF2127_BIT_WD_CTL_CD1 |
 				 PCF2127_BIT_WD_CTL_CD0 |
 				 PCF2127_BIT_WD_CTL_TF1 |
-- 
2.30.2

