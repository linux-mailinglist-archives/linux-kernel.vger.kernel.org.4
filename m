Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1489A6BF58A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCQW5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCQW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA172CFCB;
        Fri, 17 Mar 2023 15:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E086860CA0;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3A3C433D2;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=cBF4sj28SAckbtk/zdaRv0Kn7wKLfTnCwzHMWh0YXEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaNMZEwnKjK5vylx0dTMRlraH3Ve/gk1FTjHVmxaZNBxeth8m0RA28nUAnqLQVmCj
         QmorLZ3+ICq8t9bOlPRkcMXrecn0oj1nN8Ag+5Y9HSsaa7HB97yj8c+afl9ZPVTr6w
         TaA9ZTT0RZETqOFIC6+HJ7uEwWjPLcr6T1/QbGDGckJhfh7PAAFkwY2v/GWFRJlehv
         jKbirgkCKjxTuNSOHcIoHsJm/3eDyTYPd1wsmgxnPTyJeGoSZ414j2W9vscfTmN70v
         cDeLfMMsBvxz9wzPITtU7u+vyftubY6PMO3rd/EYA/hTMMhL3f6MjKGbwEXmL9ZxEQ
         oKnUpvvrHCgLA==
Received: by mercury (Postfix, from userid 1000)
        id 8D0171062105; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 05/14] power: supply: generic-adc-battery: drop jitter delay support
Date:   Fri, 17 Mar 2023 23:56:58 +0100
Message-Id: <20230317225707.1552512-6-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
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

Drop support for configuring IRQ jitter delay by using big
enough fixed value.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

