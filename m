Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B66069B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJTUnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJTUnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:43:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777921F9A27;
        Thu, 20 Oct 2022 13:42:56 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-059-009.ewe-ip-backbone.de [91.96.59.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A742E660252A;
        Thu, 20 Oct 2022 21:42:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666298574;
        bh=X3yfj13to2tg/D84twn9byIRBMZ9DxelBTecqBK6ZEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYMxm8dQAUdwxq1z43CZDCcSUCtHmQ6bPNtYXQLSNFko5M1OwJu1JsPk/vzZH8RT/
         BZOalH7i7nMudstpRK+bO16R1WjW2Fq7y77aTKbIen2cVS9JoS97AxCBTo+V50j8If
         PPrG0v4qgAhuuEnBPDA2HHYNwLZ9M92rvjbeGovhpVlOgdU9vaDBatL+72K4gtXe7q
         1qPTZc8xbsmiFBwDuPKF1H195wjrQYkYlnyoUJ9nbftoP/M41jAKJcbzVH7lm4TSex
         Look1yzXJyDucTz5uvtYrQGi2ARvgJ3HmSjXtvfWd6s3X/CBI8DU8J9o8UGPN1cRNb
         rnu8QFC/nCU9g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 54C14480898; Thu, 20 Oct 2022 22:42:52 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv4 03/13] rtc: rk808: reduce 'struct rk808' usage
Date:   Thu, 20 Oct 2022 22:42:41 +0200
Message-Id: <20221020204251.108565-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020204251.108565-1-sebastian.reichel@collabora.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce usage of 'struct rk808' (driver data of the parent MFD), so
that only the chip variant field is still being accessed directly.
This allows restructuring the MFD driver to support SPI based
PMICs.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/rtc/rtc-rk808.c | 47 ++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index e920da8c08da..2d9bcb3ce1e3 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -14,7 +14,6 @@
 #include <linux/bcd.h>
 #include <linux/mfd/rk808.h>
 #include <linux/platform_device.h>
-#include <linux/i2c.h>
 
 /* RTC_CTRL_REG bitfields */
 #define BIT_RTC_CTRL_REG_STOP_RTC_M		BIT(0)
@@ -51,7 +50,7 @@ struct rk_rtc_compat_reg {
 };
 
 struct rk808_rtc {
-	struct rk808 *rk808;
+	struct regmap *regmap;
 	struct rtc_device *rtc;
 	struct rk_rtc_compat_reg *creg;
 	int irq;
@@ -97,12 +96,11 @@ static void gregorian_to_rockchip(struct rtc_time *tm)
 static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
 	/* Force an update of the shadowed registers right now */
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
 				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
 				 BIT_RTC_CTRL_REG_RTC_GET_TIME);
 	if (ret) {
@@ -116,7 +114,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	 * 32khz. If we clear the GET_TIME bit here, the time of i2c transfer
 	 * certainly more than 31.25us: 16 * 2.5us at 400kHz bus frequency.
 	 */
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
 				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
 				 0);
 	if (ret) {
@@ -124,7 +122,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 		return ret;
 	}
 
-	ret = regmap_bulk_read(rk808->regmap, rk808_rtc->creg->seconds_reg,
+	ret = regmap_bulk_read(rk808_rtc->regmap, rk808_rtc->creg->seconds_reg,
 			       rtc_data, NUM_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "Failed to bulk read rtc_data: %d\n", ret);
@@ -148,7 +146,6 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
@@ -163,7 +160,7 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_data[6] = bin2bcd(tm->tm_wday);
 
 	/* Stop RTC while updating the RTC registers */
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M);
 	if (ret) {
@@ -171,14 +168,14 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 	}
 
-	ret = regmap_bulk_write(rk808->regmap, rk808_rtc->creg->seconds_reg,
+	ret = regmap_bulk_write(rk808_rtc->regmap, rk808_rtc->creg->seconds_reg,
 				rtc_data, NUM_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
 		return ret;
 	}
 	/* Start RTC again */
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
 	if (ret) {
 		dev_err(dev, "Failed to update RTC control: %d\n", ret);
@@ -191,12 +188,11 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
 	u8 alrm_data[NUM_ALARM_REGS];
 	uint32_t int_reg;
 	int ret;
 
-	ret = regmap_bulk_read(rk808->regmap,
+	ret = regmap_bulk_read(rk808_rtc->regmap,
 			       rk808_rtc->creg->alarm_seconds_reg,
 			       alrm_data, NUM_ALARM_REGS);
 	if (ret) {
@@ -212,7 +208,7 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->time.tm_year = (bcd2bin(alrm_data[5] & YEARS_REG_MSK)) + 100;
 	rockchip_to_gregorian(&alrm->time);
 
-	ret = regmap_read(rk808->regmap, rk808_rtc->creg->int_reg, &int_reg);
+	ret = regmap_read(rk808_rtc->regmap, rk808_rtc->creg->int_reg, &int_reg);
 	if (ret) {
 		dev_err(dev, "Failed to read RTC INT REG: %d\n", ret);
 		return ret;
@@ -228,10 +224,9 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int rk808_rtc_stop_alarm(struct rk808_rtc *rk808_rtc)
 {
-	struct rk808 *rk808 = rk808_rtc->rk808;
 	int ret;
 
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->int_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->int_reg,
 				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M, 0);
 
 	return ret;
@@ -239,10 +234,9 @@ static int rk808_rtc_stop_alarm(struct rk808_rtc *rk808_rtc)
 
 static int rk808_rtc_start_alarm(struct rk808_rtc *rk808_rtc)
 {
-	struct rk808 *rk808 = rk808_rtc->rk808;
 	int ret;
 
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->int_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->int_reg,
 				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M,
 				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 
@@ -252,7 +246,6 @@ static int rk808_rtc_start_alarm(struct rk808_rtc *rk808_rtc)
 static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
 	u8 alrm_data[NUM_ALARM_REGS];
 	int ret;
 
@@ -272,7 +265,7 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm_data[4] = bin2bcd(alrm->time.tm_mon + 1);
 	alrm_data[5] = bin2bcd(alrm->time.tm_year - 100);
 
-	ret = regmap_bulk_write(rk808->regmap,
+	ret = regmap_bulk_write(rk808_rtc->regmap,
 				rk808_rtc->creg->alarm_seconds_reg,
 				alrm_data, NUM_ALARM_REGS);
 	if (ret) {
@@ -313,20 +306,18 @@ static int rk808_rtc_alarm_irq_enable(struct device *dev,
 static irqreturn_t rk808_alarm_irq(int irq, void *data)
 {
 	struct rk808_rtc *rk808_rtc = data;
-	struct rk808 *rk808 = rk808_rtc->rk808;
-	struct i2c_client *client = rk808->i2c;
 	int ret;
 
-	ret = regmap_write(rk808->regmap, rk808_rtc->creg->status_reg,
+	ret = regmap_write(rk808_rtc->regmap, rk808_rtc->creg->status_reg,
 			   RTC_STATUS_MASK);
 	if (ret) {
-		dev_err(&client->dev,
+		dev_err(&rk808_rtc->rtc->dev,
 			"%s:Failed to update RTC status: %d\n", __func__, ret);
 		return ret;
 	}
 
 	rtc_update_irq(rk808_rtc->rtc, 1, RTC_IRQF | RTC_AF);
-	dev_dbg(&client->dev,
+	dev_dbg(&rk808_rtc->rtc->dev,
 		 "%s:irq=%d\n", __func__, irq);
 	return IRQ_HANDLED;
 }
@@ -404,10 +395,12 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 		break;
 	}
 	platform_set_drvdata(pdev, rk808_rtc);
-	rk808_rtc->rk808 = rk808;
+	rk808_rtc->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!rk808_rtc->regmap)
+		return -ENODEV;
 
 	/* start rtc running by default, and use shadowed timer. */
-	ret = regmap_update_bits(rk808->regmap, rk808_rtc->creg->ctrl_reg,
+	ret = regmap_update_bits(rk808_rtc->regmap, rk808_rtc->creg->ctrl_reg,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M |
 				 BIT_RTC_CTRL_REG_RTC_READSEL_M,
 				 BIT_RTC_CTRL_REG_RTC_READSEL_M);
@@ -417,7 +410,7 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regmap_write(rk808->regmap, rk808_rtc->creg->status_reg,
+	ret = regmap_write(rk808_rtc->regmap, rk808_rtc->creg->status_reg,
 			   RTC_STATUS_MASK);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.35.1

