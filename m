Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE767CDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjAZOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjAZOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195D011658;
        Thu, 26 Jan 2023 06:22:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A834761759;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B1EC4331F;
        Thu, 26 Jan 2023 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742977;
        bh=INUNOAIIyLUZq0CCEN/lm/WexHT7eTy04ZYkgnZoeqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpfDILN2/jmt5IWV20uE5H1mYQBcSmwIwqTbLLvoYOEp/zNi5IrgiHZzkKAwwjRki
         pjFVGhFRxXyl19M7GNrx6Lpqt2rndcbq0KhBb0VQJ4W6qv2sbzslQDQu7baw2IMYxa
         GQFjj5Z8y4tMNitdpflXU2dlyIRBOBMWxvuioZXCbtuPARuabznAnJ3d5UT+QdAUGh
         sZR2rLlkEPSkaDtpiwuJePe3tZObN0KJ12hPVdjCBh4iPYcVh4vChnbqiE1z+biknV
         cVfW47SIwsnWU0JYNpPR6PvxI04GLPQ5A6m/0/cToyuSoygGDZ5qnATab5lRJOQFgw
         Bg/szEjH6j9yA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006iT-Ik; Thu, 26 Jan 2023 15:23:04 +0100
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
Subject: [PATCH 07/24] rtc: pm8xxx: use unaligned le32 helpers
Date:   Thu, 26 Jan 2023 15:20:40 +0100
Message-Id: <20230126142057.25715-8-johan+linaro@kernel.org>
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

Use the unaligned le32 helpers instead of open coding when accessing the
time and alarm registers.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 90027a7cfb12..5ff6898bcace 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include <asm/unaligned.h>
+
 /* RTC_CTRL register bit fields */
 #define PM8xxx_RTC_ENABLE		BIT(7)
 #define PM8xxx_RTC_ALARM_CLEAR		BIT(0)
@@ -68,25 +70,21 @@ struct pm8xxx_rtc {
  */
 static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	int rc, i;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u8 value[NUM_8_BIT_RTC_REGS];
 	bool alarm_enabled;
 	unsigned long secs;
+	int rc;
 
 	if (!rtc_dd->allow_set_time)
 		return -ENODEV;
 
 	secs = rtc_tm_to_time64(tm);
+	put_unaligned_le32(secs, value);
 
 	dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
 
-	for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
-		value[i] = secs & 0xFF;
-		secs >>= 8;
-	}
-
 	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
 				      regs->alarm_en, 0, &alarm_enabled);
 	if (rc)
@@ -157,9 +155,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			return rc;
 	}
 
-	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
-	       ((unsigned long)value[3] << 24);
-
+	secs = get_unaligned_le32(value);
 	rtc_time64_to_tm(secs, tm);
 
 	dev_dbg(dev, "secs = %lu, h:m:s == %ptRt, y-m-d = %ptRdr\n", secs, tm, tm);
@@ -169,18 +165,14 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	int rc, i;
 	u8 value[NUM_8_BIT_RTC_REGS];
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	unsigned long secs;
+	int rc;
 
 	secs = rtc_tm_to_time64(&alarm->time);
-
-	for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
-		value[i] = secs & 0xFF;
-		secs >>= 8;
-	}
+	put_unaligned_le32(secs, value);
 
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 				regs->alarm_en, 0);
@@ -219,9 +211,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (rc)
 		return rc;
 
-	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
-	       ((unsigned long)value[3] << 24);
-
+	secs = get_unaligned_le32(value);
 	rtc_time64_to_tm(secs, &alarm->time);
 
 	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
-- 
2.39.1

