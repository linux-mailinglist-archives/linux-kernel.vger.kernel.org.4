Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1571B67CDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjAZOXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjAZOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E183113E5;
        Thu, 26 Jan 2023 06:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C0361846;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821F6C4339B;
        Thu, 26 Jan 2023 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742977;
        bh=12u1vORkka94MbRRqgLlh8ZafR0J0iVA3PYzmbaNfEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4XKfhvgXqSaWLQLZ/mqtZmY2hh/qdyPnFadZsmNNDeNRgSrypLpTPcLcEuDCh8mq
         r3KJvlBgrD8IQb/jM4jaFO8HzslJ2ljUwrE4NC7YR78jBLsFKhJKOS3CZntmX4i+tT
         mUP/cNjw2LvbVfXTRr1ocQh+9sF6l1vG2A7KTpMMlCUfJgRmIq2yJVMwRe5DtH980E
         fOJBcssv/q84TKRV0unRQz7XuBzA0sc0vOLNdRexe3hxfXauzArcplvcjL7qoaBPoG
         TCQY3BmPbK4OxSU9Pb1ZXGIP6s5rFre8BZ4sb51eQqGZXH4jiU8UW7T0IqpLpc+zuI
         jn2nygOW48jFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006iG-3G; Thu, 26 Jan 2023 15:23:04 +0100
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
Subject: [PATCH 02/24] rtc: pm8xxx: drop spmi error messages
Date:   Thu, 26 Jan 2023 15:20:35 +0100
Message-Id: <20230126142057.25715-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unnecessary error messages after every spmi regmap access,
which are not expected to fail.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 71 ++++++++++------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index d114f0da537d..f49bda999e02 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -105,10 +105,8 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		alarm_enabled = 1;
 		ctrl_reg &= ~regs->alarm_en;
 		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
-		if (rc) {
-			dev_err(dev, "Write to RTC Alarm control register failed\n");
+		if (rc)
 			goto rtc_rw_fail;
-		}
 	}
 
 	/* Disable RTC H/w before writing on RTC register */
@@ -120,51 +118,39 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		rtc_disabled = 1;
 		rtc_ctrl_reg &= ~PM8xxx_RTC_ENABLE;
 		rc = regmap_write(rtc_dd->regmap, regs->ctrl, rtc_ctrl_reg);
-		if (rc) {
-			dev_err(dev, "Write to RTC control register failed\n");
+		if (rc)
 			goto rtc_rw_fail;
-		}
 	}
 
 	/* Write 0 to Byte[0] */
 	rc = regmap_write(rtc_dd->regmap, regs->write, 0);
-	if (rc) {
-		dev_err(dev, "Write to RTC write data register failed\n");
+	if (rc)
 		goto rtc_rw_fail;
-	}
 
 	/* Write Byte[1], Byte[2], Byte[3] */
 	rc = regmap_bulk_write(rtc_dd->regmap, regs->write + 1,
 			       &value[1], sizeof(value) - 1);
-	if (rc) {
-		dev_err(dev, "Write to RTC write data register failed\n");
+	if (rc)
 		goto rtc_rw_fail;
-	}
 
 	/* Write Byte[0] */
 	rc = regmap_write(rtc_dd->regmap, regs->write, value[0]);
-	if (rc) {
-		dev_err(dev, "Write to RTC write data register failed\n");
+	if (rc)
 		goto rtc_rw_fail;
-	}
 
 	/* Enable RTC H/w after writing on RTC register */
 	if (rtc_disabled) {
 		rtc_ctrl_reg |= PM8xxx_RTC_ENABLE;
 		rc = regmap_write(rtc_dd->regmap, regs->ctrl, rtc_ctrl_reg);
-		if (rc) {
-			dev_err(dev, "Write to RTC control register failed\n");
+		if (rc)
 			goto rtc_rw_fail;
-		}
 	}
 
 	if (alarm_enabled) {
 		ctrl_reg |= regs->alarm_en;
 		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
-		if (rc) {
-			dev_err(dev, "Write to RTC Alarm control register failed\n");
+		if (rc)
 			goto rtc_rw_fail;
-		}
 	}
 
 rtc_rw_fail:
@@ -183,28 +169,22 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 
 	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
-	if (rc) {
-		dev_err(dev, "RTC read data register failed\n");
+	if (rc)
 		return rc;
-	}
 
 	/*
 	 * Read the LSB again and check if there has been a carry over.
 	 * If there is, redo the read operation.
 	 */
 	rc = regmap_read(rtc_dd->regmap, regs->read, &reg);
-	if (rc < 0) {
-		dev_err(dev, "RTC read data register failed\n");
+	if (rc < 0)
 		return rc;
-	}
 
 	if (unlikely(reg < value[0])) {
 		rc = regmap_bulk_read(rtc_dd->regmap, regs->read,
 				      value, sizeof(value));
-		if (rc) {
-			dev_err(dev, "RTC read data register failed\n");
+		if (rc)
 			return rc;
-		}
 	}
 
 	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
@@ -241,10 +221,8 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	rc = regmap_bulk_write(rtc_dd->regmap, regs->alarm_rw, value,
 			       sizeof(value));
-	if (rc) {
-		dev_err(dev, "Write to RTC ALARM register failed\n");
+	if (rc)
 		goto rtc_rw_fail;
-	}
 
 	if (alarm->enabled) {
 		rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
@@ -271,10 +249,8 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	rc = regmap_bulk_read(rtc_dd->regmap, regs->alarm_rw, value,
 			      sizeof(value));
-	if (rc) {
-		dev_err(dev, "RTC alarm time read failed\n");
+	if (rc)
 		return rc;
-	}
 
 	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
 	       ((unsigned long)value[3] << 24);
@@ -282,10 +258,9 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	rtc_time64_to_tm(secs, &alarm->time);
 
 	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
-	if (rc) {
-		dev_err(dev, "Read from RTC alarm control register failed\n");
+	if (rc)
 		return rc;
-	}
+
 	alarm->enabled = !!(ctrl_reg & PM8xxx_RTC_ALARM_ENABLE);
 
 	dev_dbg(dev, "Alarm set for - h:m:s=%ptRt, y-m-d=%ptRdr\n",
@@ -315,19 +290,15 @@ static int pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 		ctrl_reg &= ~regs->alarm_en;
 
 	rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
-	if (rc) {
-		dev_err(dev, "Write to RTC control register failed\n");
+	if (rc)
 		goto rtc_rw_fail;
-	}
 
 	/* Clear Alarm register */
 	if (!enable) {
 		rc = regmap_bulk_write(rtc_dd->regmap, regs->alarm_rw, value,
 				       sizeof(value));
-		if (rc) {
-			dev_err(dev, "Clear RTC ALARM register failed\n");
+		if (rc)
 			goto rtc_rw_fail;
-		}
 	}
 
 rtc_rw_fail:
@@ -366,8 +337,6 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 	rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
 	if (rc) {
 		spin_unlock(&rtc_dd->ctrl_reg_lock);
-		dev_err(rtc_dd->rtc_dev,
-			"Write to alarm control register failed\n");
 		goto rtc_alarm_handled;
 	}
 
@@ -375,17 +344,11 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 
 	/* Clear RTC alarm register */
 	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl2, &ctrl_reg);
-	if (rc) {
-		dev_err(rtc_dd->rtc_dev,
-			"RTC Alarm control2 register read failed\n");
+	if (rc)
 		goto rtc_alarm_handled;
-	}
 
 	ctrl_reg |= PM8xxx_RTC_ALARM_CLEAR;
 	rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl2, ctrl_reg);
-	if (rc)
-		dev_err(rtc_dd->rtc_dev,
-			"Write to RTC Alarm control2 register failed\n");
 
 rtc_alarm_handled:
 	return IRQ_HANDLED;
-- 
2.39.1

