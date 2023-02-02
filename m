Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE068835C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjBBPzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjBBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90059B7F;
        Thu,  2 Feb 2023 07:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736CD61C18;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11E0C433A7;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=/YRM5Ic3ZY+jzd9X9EDvX7MvH3WHxEA0VUrC4Satfvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3c+cuq38lydsmyCdWn2pChmJPkNQJYH+sUZQiqqbvDW4yuypjcTgAynTgvTCevti
         2ei4pAWza9t8VSeB869xiCJLxkjt8xHzf0FCyAT0aVGeFXkjr1WeXdb820rVrvVi0R
         hANkyEawt78gcjwqQQF7JJNxyYbIDf2fKYiUmR80iHc0ZxWLnxMmSyrDjj+I4tJd92
         CY2/t4EWAONaAVboPjAu9oF6ZrbC1FOHeTVXowS6Xpsz4uM7FBXG1m1dSQdnA0xES9
         hdDFReBoOaeiTL+X3pTKV7GBqJ1Zi2uErgjm9ksHEwFJ43kO9oBuwML8R4jTvBTOyo
         AuZXgVp4JeyqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001mE-JV; Thu, 02 Feb 2023 16:55:09 +0100
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
Subject: [PATCH v2 12/22] rtc: pm8xxx: use u32 for timestamps
Date:   Thu,  2 Feb 2023 16:54:38 +0100
Message-Id: <20230202155448.6715-13-johan+linaro@kernel.org>
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

The PMIC RTC registers are 32-bit so explicitly use u32 rather than
unsigned long for timestamps to reflect the hardware.

This will also help avoid unintentional range extensions when adding
support for managing an external offset.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 8a94a19e0d14..b1ce246c501a 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -74,7 +74,7 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 	u8 value[NUM_8_BIT_RTC_REGS];
 	bool alarm_enabled;
-	unsigned long secs;
+	u32 secs;
 	int rc;
 
 	if (!rtc_dd->allow_set_time)
@@ -83,7 +83,7 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	secs = rtc_tm_to_time64(tm);
 	put_unaligned_le32(secs, value);
 
-	dev_dbg(dev, "set time: %ptRd %ptRt (%lu)\n", tm, tm, secs);
+	dev_dbg(dev, "set time: %ptRd %ptRt (%u)\n", tm, tm, secs);
 
 	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
 				      regs->alarm_en, 0, &alarm_enabled);
@@ -131,10 +131,10 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	int rc;
 	u8 value[NUM_8_BIT_RTC_REGS];
-	unsigned long secs;
 	unsigned int reg;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u32 secs;
 
 	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
 	if (rc)
@@ -158,7 +158,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	secs = get_unaligned_le32(value);
 	rtc_time64_to_tm(secs, tm);
 
-	dev_dbg(dev, "read time: %ptRd %ptRt (%lu)\n", tm, tm, secs);
+	dev_dbg(dev, "read time: %ptRd %ptRt (%u)\n", tm, tm, secs);
 
 	return 0;
 }
@@ -168,7 +168,7 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	u8 value[NUM_8_BIT_RTC_REGS];
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
-	unsigned long secs;
+	u32 secs;
 	int rc;
 
 	secs = rtc_tm_to_time64(&alarm->time);
@@ -201,9 +201,9 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int rc;
 	unsigned int ctrl_reg;
 	u8 value[NUM_8_BIT_RTC_REGS];
-	unsigned long secs;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u32 secs;
 
 	rc = regmap_bulk_read(rtc_dd->regmap, regs->alarm_rw, value,
 			      sizeof(value));
-- 
2.39.1

