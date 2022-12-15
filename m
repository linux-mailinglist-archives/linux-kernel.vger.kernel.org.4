Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCD64DD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLOPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLOPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:18:09 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDCC41;
        Thu, 15 Dec 2022 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2TpvNPjJv8dDj4S0AWy3RhL4BnpJx4K5ru1eHBA0knE=; b=nZX7/WtofBUQQYU1kqwXQ6pVSe
        MY0Eo2yc67aJ00XNJu439CNUbx5xEs5iRsubdpJMEu6APpfIFv06RYNDpczor9MaQeV7DvrpRg9CK
        Lp788Li4ccE5ErB7xKkvXaPqS5k9BJUXgKpm2eTxZzH9GLqSEDohqTJaENE4m/5tG/aY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48102 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p5pmQ-0000EC-3I; Thu, 15 Dec 2022 10:04:14 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 15 Dec 2022 10:02:14 -0500
Message-Id: <20221215150214.1109074-14-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221215150214.1109074-1-hugo@hugovil.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 13/14] rtc: pcf2127: add flag for watchdog register value read support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The watchdog value register cannot be read on the PCF2131 after being
set.

Add a new flag to identify which variant has read access to this
register, and use this flag to selectively test if watchdog timer was
started by bootloader.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 3fd2fee4978b..1d2b5c9e6757 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -214,6 +214,7 @@ struct pcf21xx_config {
 	int max_register;
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
+	unsigned int wd_val_reg_readable:1; /* If watchdog value register can be read. */
 	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
 	unsigned int has_reset_reg:1; /* If variant has a reset register. */
 	u8 regs_td_base; /* Time/data base registers. */
@@ -511,7 +512,6 @@ static const struct watchdog_ops pcf2127_watchdog_ops = {
 
 static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 {
-	u32 wdd_timeout;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_WATCHDOG) ||
@@ -539,12 +539,17 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 	watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
 
 	/* Test if watchdog timer is started by bootloader */
-	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val, &wdd_timeout);
-	if (ret)
-		return ret;
+	if (pcf2127->cfg->wd_val_reg_readable) {
+		u32 wdd_timeout;
+
+		ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val,
+				  &wdd_timeout);
+		if (ret)
+			return ret;
 
-	if (wdd_timeout)
-		set_bit(WDOG_HW_RUNNING, &pcf2127->wdd.status);
+		if (wdd_timeout)
+			set_bit(WDOG_HW_RUNNING, &pcf2127->wdd.status);
+	}
 
 	return devm_watchdog_register_device(dev, &pcf2127->wdd);
 }
@@ -953,6 +958,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x1d,
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
+		.wd_val_reg_readable = 1,
 		.has_int_a_b = 0,
 		.has_reset_reg = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
@@ -980,6 +986,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.wd_val_reg_readable = 1,
 		.has_int_a_b = 0,
 		.has_reset_reg = 0,
 		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
@@ -1007,6 +1014,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x36,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.wd_val_reg_readable = 0,
 		.has_int_a_b = 1,
 		.has_reset_reg = 1,
 		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
-- 
2.30.2

