Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF31737598
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFTUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFTUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D741712
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98bcc533490so2192066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291419; x=1689883419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts2CvJG3GQxySwikSNebm+mM4uY8v3kHsQNk6jHGEmI=;
        b=lxfFIdKlW14qiAG+usHGbXGl2NssFFvBXi/XeJMCcQeumGWXHpQVdJp5mPcSiC3V53
         LJEYudCnt+mddDHLhig6Ck+uhC1fZdD+yusON4aHbVA15tT1aICoyzkU9uA8Ylg6xi8O
         jeU4cqmRnW85tdI4X3KLP0hwXtRe6Ytv1GfBkdZdIn1dasm9H5NAjFWavgBDuo7IUsWs
         NMROZbF57Lne63wzLAxqoSqq6p9Y90wOE7M6YzRedaU/FmasfD4m0gBPVXCnd4QaRLxN
         r3QUkznnSY5lb2tpdUyk/pxuIvTxtDdjJ0lq+/xefhn7tiU5GVMyXUx2W4lqEthGwITu
         V0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291419; x=1689883419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts2CvJG3GQxySwikSNebm+mM4uY8v3kHsQNk6jHGEmI=;
        b=FuWYKwdRd+pUjm7R33RFFa+K2zRrpaX22QRS9Xu7jwSasu94jWk2N7bcNVu5tmJUOi
         56qLbWdqWVD0pjOIansUu7Bcs0CVROh1ojUId4LsWxhP008Suh5hn48IeNohUbxMbB1j
         bU72lM8YXHLzkSmw8i73bPRiAWyYEDWo33mpF9NF1dykFg3imrnzC5Jiq7Cf3UtOP58z
         i6sTWCNETd27qNb5yWynYahhPfI3HDYqdPfIrxFPnlFpgRK7y7AJRjDbvuZpKNSkbtly
         KWq7F5iRAd2VWVvWdj2bw4P71uRflL5HKx3ZKqfmCjHYNcKIzoXmUA51G7Y5PJ869Oqq
         1Abg==
X-Gm-Message-State: AC+VfDz8Pa9onKZnRcx8dVUYdnO5DKg6wrl6JOHcn0lyxLJZ9jmRFdD6
        xJKp1cxf1Wc6pLBeHIBJ+zA=
X-Google-Smtp-Source: ACHHUZ5LizFMA9UIa4WQfMs2hig/hFlMq4RxvMkJHSBLkvKpppVy2BgvwuZB87K0NBUngV2hhdN0Tw==
X-Received: by 2002:a17:907:26c8:b0:94e:afa6:299f with SMTP id bp8-20020a17090726c800b0094eafa6299fmr13176803ejc.22.1687291419095;
        Tue, 20 Jun 2023 13:03:39 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:38 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:01 +0200
Subject: [PATCH RFC v4 08/13] regulator: move monitor handling into own
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-8-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Extract the current monitor handling into an own function and create
helper for initialization, disabling and re-enabling of monitors.
For reenabling the monitors, the current state and mode is considered to
avoid entering an invalid state on regulators with enabled workarounds.

Additionally, monitors of disabled regulators are not disabled before
changing state. The mon_disable_reg_disabled property is still respected
in this case, because turning off the monitor happens when the regulator
is still enabled.

Differ between initialization and normal "workaround handling" when an
EOPNOTSUPP is returned.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 234 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 178 insertions(+), 56 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9bddab17450e..873e53633698 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1426,7 +1426,7 @@ static int notif_set_limit(struct regulator_dev *rdev,
 
 static int handle_notify_limits(struct regulator_dev *rdev,
 			int (*set)(struct regulator_dev *, int, int, bool),
-			struct notification_limit *limits)
+			const struct notification_limit *limits)
 {
 	int ret = 0;
 
@@ -1451,6 +1451,180 @@ static int handle_notify_limits(struct regulator_dev *rdev,
 
 	return ret;
 }
+
+static const struct notification_limit disable_limits = {
+	.prot = REGULATOR_NOTIF_LIMIT_DISABLE,
+	.err = REGULATOR_NOTIF_LIMIT_DISABLE,
+	.warn = REGULATOR_NOTIF_LIMIT_DISABLE,
+};
+
+static int monitors_set_state(struct regulator_dev *rdev,  bool enable,
+			      unsigned int mons)
+{
+	const struct regulation_constraints *reg_c = rdev->constraints;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int tmp, ret = 0;
+
+	rdev_dbg(rdev, "%s: en: %d, mons: %x\n", __func__, enable, mons);
+
+	/* only set the state if monitoring is activated in the device-tree. */
+	if ((mons & REGULATOR_MONITOR_OVER_VOLTAGE) && reg_c->over_voltage_detection) {
+		tmp = handle_notify_limits(rdev, ops->set_over_voltage_protection,
+					   enable ? &reg_c->over_voltage_limits
+					   : &disable_limits);
+		if (tmp) {
+			if (tmp != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set over voltage limits %pe\n",
+					 ERR_PTR(tmp));
+				return tmp;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested over voltage limits\n");
+			ret = tmp;
+		}
+	}
+	if ((mons & REGULATOR_MONITOR_UNDER_VOLTAGE) && reg_c->under_voltage_detection) {
+		tmp = handle_notify_limits(rdev, ops->set_under_voltage_protection,
+					   enable ? &reg_c->under_voltage_limits
+					   : &disable_limits);
+		if (tmp) {
+			if (tmp != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set under voltage limits %pe\n",
+					 ERR_PTR(tmp));
+				return ret;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested under voltage limits\n");
+			ret = tmp;
+		}
+	}
+	if ((mons & REGULATOR_MONITOR_OVER_CURRENT) && reg_c->over_current_detection) {
+		tmp = handle_notify_limits(rdev, ops->set_over_current_protection,
+					   enable ? &reg_c->over_curr_limits
+					   : &disable_limits);
+		if (ret) {
+			if (tmp != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set over current limits: %pe\n",
+					 ERR_PTR(tmp));
+				return tmp;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested over-current limits\n");
+			ret = tmp;
+		}
+	}
+	if ((mons & REGULATOR_MONITOR_OVER_TEMPERATURE) && reg_c->over_temp_detection) {
+		tmp = handle_notify_limits(rdev, ops->set_thermal_protection,
+					   enable ? &reg_c->temp_limits
+					   : &disable_limits);
+		if (tmp) {
+			if (tmp != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set temperature limits %pe\n",
+					 ERR_PTR(tmp));
+				return tmp;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested temperature limits\n");
+			ret = tmp;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * monitors_disable - disables given monitors if the regulator is enabled
+ * @rdev: regulator source
+ * @mons: monitors to enable
+ */
+static int monitors_disable(struct regulator_dev *rdev, unsigned int mons)
+{
+	int reg_enabled;
+
+	if (!mons)
+		return 0;
+
+	reg_enabled = _regulator_is_enabled(rdev);
+	if (reg_enabled <= 0)
+		return reg_enabled;
+
+	return monitors_set_state(rdev, false, mons);
+}
+
+/**
+ * monitors_enable - enables given monitors
+ * @rdev: regulator source
+ * @mons: monitors to enable
+ *
+ * Enables monitors based on their workaround properties and the current state
+ * or mode.
+ */
+static int monitors_enable(struct regulator_dev *rdev, unsigned int mons)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	const struct regulator_ops *ops = desc->ops;
+
+	/* don't enable monitors if regulator is in unsupported mode. */
+	if (desc->mon_unsupported_reg_modes &&
+	    (desc->mon_unsupported_reg_modes & ops->get_mode(rdev)))
+		return 0;
+
+	/* don't enable monitor on disabled regulator with workaround active. */
+	if (mons & desc->mon_disable_reg_disabled) {
+		int reg_enabled = _regulator_is_enabled(rdev);
+
+		if (reg_enabled < 0)
+			return reg_enabled;
+		if (!reg_enabled)
+			mons &= ~desc->mon_disable_reg_disabled;
+	}
+
+	return monitors_set_state(rdev, true, mons);
+}
+
+static int monitors_init(struct regulator_dev *rdev)
+{
+	unsigned int mons = REGULATOR_MONITOR_NONE;
+	int reg_enabled = _regulator_is_enabled(rdev);
+	int ret;
+
+	/*
+	 * Ensure that monitors of disabled regulators with respective
+	 * workaround active are disabled during initialization.
+	 */
+	if (reg_enabled < 0)
+		return reg_enabled;
+	if (!reg_enabled && rdev->desc->mon_disable_reg_disabled) {
+		mons = rdev->desc->mon_disable_reg_disabled;
+		ret = monitors_set_state(rdev, false, mons);
+	}
+
+	/* Ignore EOPNOTSUPP at initialization, but not during workarounds. */
+	ret = monitors_enable(rdev, ~mons);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	return 0;
+}
+
+static int monitors_reenable(struct regulator_dev *rdev, unsigned int mons)
+{
+	int reg_enabled;
+
+	if (!mons)
+		return 0;
+
+	/*
+	 * Monitors of disabled regulators are not turned off, therefore skip
+	 * turning on.
+	 */
+	reg_enabled = _regulator_is_enabled(rdev);
+	if (reg_enabled <= 0)
+		return reg_enabled;
+
+	return monitors_enable(rdev, mons);
+}
+
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
@@ -1605,61 +1779,9 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		}
 	}
 
-	if (rdev->constraints->over_current_detection)
-		ret = handle_notify_limits(rdev,
-					   ops->set_over_current_protection,
-					   &rdev->constraints->over_curr_limits);
-	if (ret) {
-		if (ret != -EOPNOTSUPP) {
-			rdev_err(rdev, "failed to set over current limits: %pe\n",
-				 ERR_PTR(ret));
-			return ret;
-		}
-		rdev_warn(rdev,
-			  "IC does not support requested over-current limits\n");
-	}
-
-	if (rdev->constraints->over_voltage_detection)
-		ret = handle_notify_limits(rdev,
-					   ops->set_over_voltage_protection,
-					   &rdev->constraints->over_voltage_limits);
-	if (ret) {
-		if (ret != -EOPNOTSUPP) {
-			rdev_err(rdev, "failed to set over voltage limits %pe\n",
-				 ERR_PTR(ret));
-			return ret;
-		}
-		rdev_warn(rdev,
-			  "IC does not support requested over voltage limits\n");
-	}
-
-	if (rdev->constraints->under_voltage_detection)
-		ret = handle_notify_limits(rdev,
-					   ops->set_under_voltage_protection,
-					   &rdev->constraints->under_voltage_limits);
-	if (ret) {
-		if (ret != -EOPNOTSUPP) {
-			rdev_err(rdev, "failed to set under voltage limits %pe\n",
-				 ERR_PTR(ret));
-			return ret;
-		}
-		rdev_warn(rdev,
-			  "IC does not support requested under voltage limits\n");
-	}
-
-	if (rdev->constraints->over_temp_detection)
-		ret = handle_notify_limits(rdev,
-					   ops->set_thermal_protection,
-					   &rdev->constraints->temp_limits);
-	if (ret) {
-		if (ret != -EOPNOTSUPP) {
-			rdev_err(rdev, "failed to set temperature limits %pe\n",
-				 ERR_PTR(ret));
-			return ret;
-		}
-		rdev_warn(rdev,
-			  "IC does not support requested temperature limits\n");
-	}
+	ret = monitors_init(rdev);
+	if (ret)
+		return ret;
 
 	if (rdev->constraints->active_discharge && ops->set_active_discharge) {
 		bool ad_state = (rdev->constraints->active_discharge ==

-- 
2.34.1

