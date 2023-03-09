Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8C6B316D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjCIWvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjCIWu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D985F73AD;
        Thu,  9 Mar 2023 14:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D494B820E1;
        Thu,  9 Mar 2023 22:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80958C4339E;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=wvOJ8rQ6bnzbunmB5UwoBejQRHk8rSnA78s83MjDCC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icDVNSzDQyZrsEydVf10tIyhdVrFrl3j0Su/1/DUBMa0hMowj9yF5Yyv6qTR0jMXZ
         i/UvAs1Z6/WbEzRDUYzK0/GpgCBxHuXomhebAh8x8ZzqG05q1YUXza8++cGfa6wWNv
         bCbHCHL+8RQKz014Q9DuSLWPFuMO0I4DUOFiljk1hAK8hWutDjyW2lA7FajmGXBOUJ
         B6uru2D+9duOoW20Wme02IkMoGA8FSzn+2kajPq1lpHF5jx9Lv4U/HMK6mk+rfhbp1
         nkHCwwoSlbY/2J2AHRc1Jg6CXJMDCo7syePatDMxeV4wPbyBgYO98shQYZdC8eVTZm
         t5VzOJ9DuXq0w==
Received: by mercury (Postfix, from userid 1000)
        id 6399B10609DA; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 05/11] power: supply: generic-adc-battery: drop jitter delay support
Date:   Thu,  9 Mar 2023 23:50:35 +0100
Message-Id: <20230309225041.477440-6-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
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

Drop support for configuring IRQ jitter delay by using big
enough fixed value.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 13 ++++---------
 include/linux/power/generic-adc-battery.h  |  3 ---
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 535972a332b3..e20894460d7f 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -227,12 +227,10 @@ static void gab_work(struct work_struct *work)
 static irqreturn_t gab_charged(int irq, void *dev_id)
 {
 	struct gab *adc_bat = dev_id;
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	int delay;
 
-	delay = pdata->jitter_delay ? pdata->jitter_delay : JITTER_DEFAULT;
 	schedule_delayed_work(&adc_bat->bat_work,
-			msecs_to_jiffies(delay));
+			      msecs_to_jiffies(JITTER_DEFAULT));
+
 	return IRQ_HANDLED;
 }
 
@@ -358,14 +356,11 @@ static int __maybe_unused gab_suspend(struct device *dev)
 static int __maybe_unused gab_resume(struct device *dev)
 {
 	struct gab *adc_bat = dev_get_drvdata(dev);
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	int delay;
-
-	delay = pdata->jitter_delay ? pdata->jitter_delay : JITTER_DEFAULT;
 
 	/* Schedule timer to check current status */
 	schedule_delayed_work(&adc_bat->bat_work,
-			msecs_to_jiffies(delay));
+			      msecs_to_jiffies(JITTER_DEFAULT));
+
 	return 0;
 }
 
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
index c68cbf34cd34..50eb4bf28286 100644
--- a/include/linux/power/generic-adc-battery.h
+++ b/include/linux/power/generic-adc-battery.h
@@ -11,13 +11,10 @@
  * @battery_info:         recommended structure to specify static power supply
  *			   parameters
  * @cal_charge:           calculate charge level.
- * @jitter_delay:         delay required after the interrupt to check battery
- *			  status.Default set is 10ms.
  */
 struct gab_platform_data {
 	struct power_supply_info battery_info;
 	int	(*cal_charge)(long value);
-	int     jitter_delay;
 };
 
 #endif /* GENERIC_ADC_BATTERY_H */
-- 
2.39.2

