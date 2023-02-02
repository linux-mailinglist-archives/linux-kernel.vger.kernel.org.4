Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D97688346
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjBBPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjBBPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E10582A2;
        Thu,  2 Feb 2023 07:54:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77D3FB826E6;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A7BC433A0;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=hhCtw+HmTT9km9pBv0XwTlPCeUZBnbPGQDj+D0a9Ak0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICWzFqBqeoIbEZvVZrpJBztRAYt7EjK4J42PON/PY3CKo28LLjh+DC7PHGX8nAGie
         9ZZl2qo025ACLsbShOgdgFLJo/fP0efk5W2x0mA21rX3Xee7KZbMHehoGU9fMLzbio
         edrKqqe0JtotA9Yx+GpCEuYUgbz4fF2TiR7+P5yk8f9WcihNO+EJTaUA9LMDrrJp1Q
         JB9SFpClHW+RiAQXHyZ1PRpoxFJDxLqhLertqEzL0gnHvpq5HJMtemEBjg1gi0zW7E
         4mdLwSDtKZ5hoRZBGmGgjDk73lkq5yQENBpA3EITpTVpf6siA/CBSxv1rfPIh3GIE1
         psN5HEJb39Vjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvY-0001lp-Rs; Thu, 02 Feb 2023 16:55:08 +0100
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
Subject: [PATCH v2 04/22] rtc: pm8xxx: drop bogus locking
Date:   Thu,  2 Feb 2023 16:54:30 +0100
Message-Id: <20230202155448.6715-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
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

Since commit c8d523a4b053 ("drivers/rtc/rtc-pm8xxx.c: rework to support
pm8941 rtc") which removed the shadow control register there is no need
for a driver lock.

Specifically, the rtc ops are serialised by rtc core and the interrupt
handler only unconditionally disables the alarm using the alarm_ctrl
register.

Note that since only the alarm enable bit of alarm_ctrl is used after
enabling the RTC at probe, the locking was not needed when doing open
coded read-modify-write cycles either.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 67 +++++++++++++---------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 8c2847ac64f4..053a04f74a91 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -53,7 +53,6 @@ struct pm8xxx_rtc_regs {
  * @rtc_alarm_irq:	rtc alarm irq number.
  * @regs:		rtc registers description.
  * @rtc_dev:		device structure.
- * @ctrl_reg_lock:	spinlock protecting access to ctrl_reg.
  */
 struct pm8xxx_rtc {
 	struct rtc_device *rtc;
@@ -62,7 +61,6 @@ struct pm8xxx_rtc {
 	int rtc_alarm_irq;
 	const struct pm8xxx_rtc_regs *regs;
 	struct device *rtc_dev;
-	spinlock_t ctrl_reg_lock;
 };
 
 /*
@@ -77,11 +75,11 @@ struct pm8xxx_rtc {
 static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	int rc, i;
-	unsigned long secs, irq_flags;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u8 value[NUM_8_BIT_RTC_REGS];
 	bool alarm_enabled;
+	unsigned long secs;
 
 	if (!rtc_dd->allow_set_time)
 		return -ENODEV;
@@ -95,51 +93,46 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		secs >>= 8;
 	}
 
-	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
-
 	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
 				      regs->alarm_en, 0, &alarm_enabled);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	/* Disable RTC H/w before writing on RTC register */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE, 0);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	/* Write 0 to Byte[0] */
 	rc = regmap_write(rtc_dd->regmap, regs->write, 0);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	/* Write Byte[1], Byte[2], Byte[3] */
 	rc = regmap_bulk_write(rtc_dd->regmap, regs->write + 1,
 			       &value[1], sizeof(value) - 1);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	/* Write Byte[0] */
 	rc = regmap_write(rtc_dd->regmap, regs->write, value[0]);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	/* Enable RTC H/w after writing on RTC register */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->ctrl, PM8xxx_RTC_ENABLE,
 				PM8xxx_RTC_ENABLE);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	if (alarm_enabled) {
 		rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 					regs->alarm_en, regs->alarm_en);
 		if (rc)
-			goto rtc_rw_fail;
+			return rc;
 	}
 
-rtc_rw_fail:
-	spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
-
-	return rc;
+	return 0;
 }
 
 static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
@@ -184,9 +177,9 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int rc, i;
 	u8 value[NUM_8_BIT_RTC_REGS];
-	unsigned long secs, irq_flags;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	unsigned long secs;
 
 	secs = rtc_tm_to_time64(&alarm->time);
 
@@ -200,25 +193,22 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (rc)
 		return rc;
 
-	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
-
 	rc = regmap_bulk_write(rtc_dd->regmap, regs->alarm_rw, value,
 			       sizeof(value));
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	if (alarm->enabled) {
 		rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 					regs->alarm_en, regs->alarm_en);
 		if (rc)
-			goto rtc_rw_fail;
+			return rc;
 	}
 
 	dev_dbg(dev, "Alarm Set for h:m:s=%ptRt, y-m-d=%ptRdr\n",
 		&alarm->time, &alarm->time);
-rtc_rw_fail:
-	spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
-	return rc;
+
+	return 0;
 }
 
 static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
@@ -255,14 +245,11 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
 	int rc;
-	unsigned long irq_flags;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u8 value[NUM_8_BIT_RTC_REGS] = {0};
 	unsigned int val;
 
-	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
-
 	if (enable)
 		val = regs->alarm_en;
 	else
@@ -271,19 +258,17 @@ static int pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 				regs->alarm_en, val);
 	if (rc)
-		goto rtc_rw_fail;
+		return rc;
 
 	/* Clear Alarm register */
 	if (!enable) {
 		rc = regmap_bulk_write(rtc_dd->regmap, regs->alarm_rw, value,
 				       sizeof(value));
 		if (rc)
-			goto rtc_rw_fail;
+			return rc;
 	}
 
-rtc_rw_fail:
-	spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
-	return rc;
+	return 0;
 }
 
 static const struct rtc_class_ops pm8xxx_rtc_ops = {
@@ -302,25 +287,18 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 
 	rtc_update_irq(rtc_dd->rtc, 1, RTC_IRQF | RTC_AF);
 
-	spin_lock(&rtc_dd->ctrl_reg_lock);
-
 	/* Clear the alarm enable bit */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 				regs->alarm_en, 0);
-	if (rc) {
-		spin_unlock(&rtc_dd->ctrl_reg_lock);
-		goto rtc_alarm_handled;
-	}
-
-	spin_unlock(&rtc_dd->ctrl_reg_lock);
+	if (rc)
+		goto out;
 
 	/* Clear RTC alarm register */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
 				PM8xxx_RTC_ALARM_CLEAR, 0);
 	if (rc)
-		goto rtc_alarm_handled;
-
-rtc_alarm_handled:
+		goto out;
+out:
 	return IRQ_HANDLED;
 }
 
@@ -398,9 +376,6 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rtc_dd == NULL)
 		return -ENOMEM;
 
-	/* Initialise spinlock to protect RTC control register */
-	spin_lock_init(&rtc_dd->ctrl_reg_lock);
-
 	rtc_dd->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!rtc_dd->regmap) {
 		dev_err(&pdev->dev, "Parent regmap unavailable.\n");
-- 
2.39.1

