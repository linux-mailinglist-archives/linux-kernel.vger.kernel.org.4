Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39E73A3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFVO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjFVO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:19 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D447170C;
        Thu, 22 Jun 2023 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6R3OBnyiBxxxiVIfdj1hEGO2s8km5su18Wx8/Afaa5w=; b=XZZF1vztOkOYq29iqRaHJ9e5BO
        8SpGnc4p/9R6AD0/n0vChVSwD9dr5KMjdgU/XbWooZwf4F2krnoiLbKzWP0ZEqhfytPtFB4m9vOpG
        ad6N7CeIKQc63bHAZ780vSA0rQ2J6somn71uMII5ikFJSrAnXie1T/nf11LgqikjFLPI=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlF-0002fr-W1; Thu, 22 Jun 2023 10:58:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Thu, 22 Jun 2023 10:57:52 -0400
Message-Id: <20230622145800.2442116-10-hugo@hugovil.com>
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
Subject: [PATCH v4 09/17] rtc: pcf2127: adapt for CLKOUT register at any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 drivers/rtc/rtc-pcf2127.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index ce7fe6e2fd47..21fa42870dd4 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -101,6 +101,7 @@ struct pcf21xx_config {
 	u8 regs_alarm_base; /* Alarm function base registers. */
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
+	u8 reg_clkout; /* Clkout register. */
 };
 
 struct pcf2127 {
@@ -631,6 +632,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
+		.reg_clkout = PCF2127_REG_CLKOUT,
 	},
 	[PCF2129] = {
 		.type = PCF2129,
@@ -641,6 +643,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
+		.reg_clkout = PCF2127_REG_CLKOUT,
 	},
 };
 
@@ -720,12 +723,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
 
-	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
+	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
 	if (ret < 0)
 		return ret;
 
 	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
-		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
+		ret = regmap_set_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
 				      PCF2127_BIT_CLKOUT_OTPR);
 		if (ret < 0)
 			return ret;
-- 
2.30.2

