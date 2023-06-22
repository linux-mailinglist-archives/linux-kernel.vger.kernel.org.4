Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264C73A40B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFVO7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjFVO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:30 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D01FEC;
        Thu, 22 Jun 2023 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IQpVb9Ez0bncJndXyJNlAW/aR3F6hHG3RxuZFkwyx94=; b=Xteqz4nlspbn/msGnw/EszzeLP
        iOqb3A+8aHqjwk8kkaCQC6v23heMj+pclljySYpNzQTlKi55LD27CEOfo6PF9gXOFdNfQyzuhxNxR
        M0N5YZnsIOBZOywgrDtmilHfAbDZk3ktTonvz+vIwqiLfmmFVqE5fZC/q2Vdxo4oaEFU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlP-0002fr-BC; Thu, 22 Jun 2023 10:58:23 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Thu, 22 Jun 2023 10:57:58 -0400
Message-Id: <20230622145800.2442116-16-hugo@hugovil.com>
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
Subject: [PATCH v4 15/17] rtc: pcf2127: add flag for watchdog register value read support
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
Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 drivers/rtc/rtc-pcf2127.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index c20eab277385..9da3f0096d6b 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -185,6 +185,7 @@ struct pcf21xx_config {
 	int max_register;
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
+	unsigned int wd_val_reg_readable:1; /* If watchdog value register can be read. */
 	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
 	u8 reg_time_base; /* Time/date base register. */
 	u8 regs_alarm_base; /* Alarm function base registers. */
@@ -486,7 +487,6 @@ static int pcf2127_watchdog_get_period(int n, int f1000)
 
 static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 {
-	u32 wdd_timeout;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_WATCHDOG) ||
@@ -514,12 +514,17 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
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
@@ -919,6 +924,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x1d,
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
+		.wd_val_reg_readable = 1,
 		.has_int_a_b = 0,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
@@ -946,6 +952,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.wd_val_reg_readable = 1,
 		.has_int_a_b = 0,
 		.reg_time_base = PCF2127_REG_TIME_BASE,
 		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
@@ -973,6 +980,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.max_register = 0x36,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
+		.wd_val_reg_readable = 0,
 		.has_int_a_b = 1,
 		.reg_time_base = PCF2131_REG_TIME_BASE,
 		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
-- 
2.30.2

