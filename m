Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A23688388
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjBBP4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjBBPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5839B8F;
        Thu,  2 Feb 2023 07:54:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B776961BF5;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F197C4339E;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=PJLRhF0N1IQ7Gq3TQcph77IiU5e79uPUOVm8qGIdNmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cdk/5Zo0AQs7i+8rPf6s0KwPi3GXahlPSo2f260LtUYREerBYzBXokmM8B0ywcy+F
         7/2vD8+BqxP8GarUZux1Fn40TKxs0wXSEr2sKec3vssd8oQE40dfU2uP9VaO6zL+83
         HHpZXWv+9WuHNVpF6CdCSnq0x3zeHAbclDKdoEAK+wur8r1i/1yv5srlAlxZYXf6Lz
         tqMGDxZblG0QjjbuT7cbQjfaEnJ2NxdPWXTVP1ICs+fVE+GqoqPd23y9olDlrcWGlh
         HtHRmW489LEVt3ETdBEjsvg+JOV9BpIkxSPWsbDM61VpSgNpXrFF6eYGXPNpGa/fRn
         jYRQk+1t+pRPg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvY-0001ln-Oe; Thu, 02 Feb 2023 16:55:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 03/22] rtc: pm8xxx: use regmap_update_bits()
Date:   Thu,  2 Feb 2023 16:54:29 +0100
Message-Id: <20230202155448.6715-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using regmap_update_bits() instead of open coding
read-modify-write accesses.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 87 ++++++++++------------------------------
 1 file changed, 22 insertions(+), 65 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index f49bda999e02..8c2847ac64f4 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -78,10 +78,10 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	int rc, i;
 	unsigned long secs, irq_flags;
-	u8 value[NUM_8_BIT_RTC_REGS], alarm_enabled = 0, rtc_disabled = 0;
-	unsigned int ctrl_reg, rtc_ctrl_reg;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u8 value[NUM_8_BIT_RTC_REGS];
+	bool alarm_enabled;
 
 	if (!rtc_dd->allow_set_time)
 		return -ENODEV;
@@ -97,31 +97,16 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
 
-	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
+	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
+				      regs->alarm_en, 0, &alarm_enabled);
 	if (rc)
 		goto rtc_rw_fail;
 
-	if (ctrl_reg & regs->alarm_en) {
-		alarm_enabled = 1;
-		ctrl_reg &= ~regs->alarm_en;
-		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
-		if (rc)
-			goto rtc_rw_fail;
-	}
-
 	/* Disable RTC H/w before writing on RTC register */
-	rc = regmap_read(rtc_dd->regmap, regs->ctrl, &rtc_ctrl_reg);
+	rc = regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE, 0);
 	if (rc)
 		goto rtc_rw_fail;
 
-	if (rtc_ctrl_reg & PM8xxx_RTC_ENABLE) {
-		rtc_disabled = 1;
-		rtc_ctrl_reg &= ~PM8xxx_RTC_ENABLE;
-		rc = regmap_write(rtc_dd->regmap, regs->ctrl, rtc_ctrl_reg);
-		if (rc)
-			goto rtc_rw_fail;
-	}
-
 	/* Write 0 to Byte[0] */
 	rc = regmap_write(rtc_dd->regmap, regs->write, 0);
 	if (rc)
@@ -139,16 +124,14 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		goto rtc_rw_fail;
 
 	/* Enable RTC H/w after writing on RTC register */
-	if (rtc_disabled) {
-		rtc_ctrl_reg |= PM8xxx_RTC_ENABLE;
-		rc = regmap_write(rtc_dd->regmap, regs->ctrl, rtc_ctrl_reg);
-		if (rc)
-			goto rtc_rw_fail;
-	}
+	rc = regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE,
+				PM8xxx_RTC_ENABLE);
+	if (rc)
+		goto rtc_rw_fail;
 
 	if (alarm_enabled) {
-		ctrl_reg |= regs->alarm_en;
-		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
+		rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
+					regs->alarm_en, regs->alarm_en);
 		if (rc)
 			goto rtc_rw_fail;
 	}
@@ -275,21 +258,18 @@ static int pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	unsigned long irq_flags;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
-	unsigned int ctrl_reg;
 	u8 value[NUM_8_BIT_RTC_REGS] = {0};
+	unsigned int val;
 
 	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
 
-	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
-	if (rc)
-		goto rtc_rw_fail;
-
 	if (enable)
-		ctrl_reg |= regs->alarm_en;
+		val = regs->alarm_en;
 	else
-		ctrl_reg &= ~regs->alarm_en;
+		val = 0;
 
-	rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
+	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
+				regs->alarm_en, val);
 	if (rc)
 		goto rtc_rw_fail;
 
@@ -318,7 +298,6 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 {
 	struct pm8xxx_rtc *rtc_dd = dev_id;
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
-	unsigned int ctrl_reg;
 	int rc;
 
 	rtc_update_irq(rtc_dd->rtc, 1, RTC_IRQF | RTC_AF);
@@ -326,15 +305,8 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 	spin_lock(&rtc_dd->ctrl_reg_lock);
 
 	/* Clear the alarm enable bit */
-	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
-	if (rc) {
-		spin_unlock(&rtc_dd->ctrl_reg_lock);
-		goto rtc_alarm_handled;
-	}
-
-	ctrl_reg &= ~regs->alarm_en;
-
-	rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
+	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
+				regs->alarm_en, 0);
 	if (rc) {
 		spin_unlock(&rtc_dd->ctrl_reg_lock);
 		goto rtc_alarm_handled;
@@ -343,13 +315,11 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 	spin_unlock(&rtc_dd->ctrl_reg_lock);
 
 	/* Clear RTC alarm register */
-	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl2, &ctrl_reg);
+	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
+				PM8xxx_RTC_ALARM_CLEAR, 0);
 	if (rc)
 		goto rtc_alarm_handled;
 
-	ctrl_reg |= PM8xxx_RTC_ALARM_CLEAR;
-	rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl2, ctrl_reg);
-
 rtc_alarm_handled:
 	return IRQ_HANDLED;
 }
@@ -357,22 +327,9 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 static int pm8xxx_rtc_enable(struct pm8xxx_rtc *rtc_dd)
 {
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
-	unsigned int ctrl_reg;
-	int rc;
-
-	/* Check if the RTC is on, else turn it on */
-	rc = regmap_read(rtc_dd->regmap, regs->ctrl, &ctrl_reg);
-	if (rc)
-		return rc;
 
-	if (!(ctrl_reg & PM8xxx_RTC_ENABLE)) {
-		ctrl_reg |= PM8xxx_RTC_ENABLE;
-		rc = regmap_write(rtc_dd->regmap, regs->ctrl, ctrl_reg);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
+	return regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE,
+				  PM8xxx_RTC_ENABLE);
 }
 
 static const struct pm8xxx_rtc_regs pm8921_regs = {
-- 
2.39.1

