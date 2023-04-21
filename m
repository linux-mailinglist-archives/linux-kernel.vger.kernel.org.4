Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD68A6EA6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjDUJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDUJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:13:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C141998
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f109b1808so229725066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682068398; x=1684660398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xxxa39sRYsIqUGyxDA0sj3TJcO5atZMPoDeI65I6qiA=;
        b=UD8IgWBqREhpJJAyEJjTmgocAe8i1Yzp1Ysg5Qcf6sZYHjL8eCs1ZF44BC5lyUsf+r
         tCSHj/PvyuUckcDSlN++V+4lc+u0wOEZBegwINUCrYAM0hhOTUrgeoEvw8Z6rCaFF3ag
         1FKRcT+vLlqB2mf7TnCbEptPqY/d3+FwcQzLNUHouYwCJ8ApmiMkjDJ63YWuq3M1r2Yg
         hWQtGgmh8nn+BO+6HWjCmrO8CgXd4orNf4CP6P7+eshAqZfhVjwUodxzdpzrXBmZQItI
         YyLoe/m4jWvgdDbaD9y8ujRCxGNVZonumwXuVRfTWz3kBH/STuVV2+8rIpqaa1u9YhI5
         z/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682068398; x=1684660398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxxa39sRYsIqUGyxDA0sj3TJcO5atZMPoDeI65I6qiA=;
        b=YntA+xRsB45swb6M5wVYS+R2Ed7mpIM4j8RovgqAWoAwdkMn4tRVcgsYyh/YleO4oR
         JWX01FNl8yLPH8K7IOhLeEOS/KUkEEHTZWtUI4cVqTUI45DB4EXGU/4jOUApQaWwfE0d
         hRqeKCiWYnml946LHcjz20MDKrocV59REVXcAw+mpLMLktEmiyMIvLWoe3mzEHvMh1el
         zwW4UsL9b2L4D4B7LwMFmzgF/R9GUg4TPdXFrCKoRbgsKdtEyQW2IC5JIEepPowUyOU0
         bZ1fkQH1z9t+Kcme7TnR2P7Dy2V64pYWrG1P+NlBFHaOKCFVhBk3V7vUwxypH7RbpuFj
         u8KA==
X-Gm-Message-State: AAQBX9ddmJyi6aZMhNdmqzG7MSAH5bFKswX1RFiFuGBjGHCdK+2HcA6m
        3FeuHQyHF55Sr4/IYwDtGAfyI75vYDsLX48H
X-Google-Smtp-Source: AKy350Z51fHEnOiBFDpJWjgPvurG7DtFxu7CEeEObtuo/rubpZjMoHFef84+2ho8sa9l5xZn4+nsvQ==
X-Received: by 2002:a17:906:269b:b0:94e:4fe5:613a with SMTP id t27-20020a170906269b00b0094e4fe5613amr1595454ejc.25.1682068398437;
        Fri, 21 Apr 2023 02:13:18 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id lc21-20020a170906dff500b0094ef10eceb3sm1766775ejc.185.2023.04.21.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:13:18 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 21 Apr 2023 11:13:06 +0200
Subject: [PATCH RFC v2 1/2] regulator: add properties to disable monitoring
 on actions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v2-1-c303bcc75ebc@skidata.com>
References: <20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com,
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

These are useful when the state of the regulator might change during
runtime, but the monitors state (in hardware) are not implicitly changed
with the change of the regulator state or mode (in hardware). Also, when
the monitors should be disabled while ramping after a set_value().

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c         | 64 ++++++++++++++++++++++++++++++++++++----
 include/linux/regulator/driver.h | 10 +++++++
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4fcd36055b02..5052e1da85a7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1360,7 +1360,7 @@ static int notif_set_limit(struct regulator_dev *rdev,
 
 static int handle_notify_limits(struct regulator_dev *rdev,
 			int (*set)(struct regulator_dev *, int, int, bool),
-			struct notification_limit *limits)
+			const struct notification_limit *limits)
 {
 	int ret = 0;
 
@@ -1385,6 +1385,29 @@ static int handle_notify_limits(struct regulator_dev *rdev,
 
 	return ret;
 }
+
+static const struct notification_limit disable_limits = {
+	.prot = REGULATOR_NOTIF_LIMIT_DISABLE,
+	.err = REGULATOR_NOTIF_LIMIT_DISABLE,
+	.warn = REGULATOR_NOTIF_LIMIT_DISABLE,
+};
+
+static int monitors_set_state(struct regulator_dev *rdev, bool enable)
+{
+	const struct regulation_constraints *reg_c = rdev->constraints;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int ret = 0;
+
+	/* only set the state if monitoring is activated in the device-tree. */
+	if (reg_c->over_voltage_detection)
+		ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
+					   enable ? &reg_c->over_voltage_limits : &disable_limits);
+	if (!ret && reg_c->under_voltage_detection)
+		ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
+					   enable ? &reg_c->under_voltage_limits : &disable_limits);
+	return ret;
+}
+
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
@@ -1512,7 +1535,7 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			  "IC does not support requested over-current limits\n");
 	}
 
-	if (rdev->constraints->over_voltage_detection)
+	if (rdev->constraints->over_voltage_detection && !rdev->desc->mon_disable_while_reg_off)
 		ret = handle_notify_limits(rdev,
 					   ops->set_over_voltage_protection,
 					   &rdev->constraints->over_voltage_limits);
@@ -1526,7 +1549,7 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			  "IC does not support requested over voltage limits\n");
 	}
 
-	if (rdev->constraints->under_voltage_detection)
+	if (rdev->constraints->under_voltage_detection && !rdev->desc->mon_disable_while_reg_off)
 		ret = handle_notify_limits(rdev,
 					   ops->set_under_voltage_protection,
 					   &rdev->constraints->under_voltage_limits);
@@ -2734,7 +2757,10 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
-	return 0;
+	if (rdev->desc->mon_disable_while_reg_off)
+		ret = monitors_set_state(rdev, true);
+
+	return ret;
 }
 
 /**
@@ -2893,7 +2919,12 @@ EXPORT_SYMBOL_GPL(regulator_enable);
 
 static int _regulator_do_disable(struct regulator_dev *rdev)
 {
-	int ret;
+	int ret = 0;
+
+	if (rdev->desc->mon_disable_while_reg_off)
+		ret = monitors_set_state(rdev, false);
+	if (ret)
+		return ret;
 
 	trace_regulator_disable(rdev_get_name(rdev));
 
@@ -3537,7 +3568,7 @@ static int _regulator_set_voltage_time(struct regulator_dev *rdev,
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV)
 {
-	int ret;
+	int ret = 0;
 	int delay = 0;
 	int best_val = 0;
 	unsigned int selector;
@@ -3545,6 +3576,11 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	const struct regulator_ops *ops = rdev->desc->ops;
 	int old_uV = regulator_get_voltage_rdev(rdev);
 
+	if (rdev->desc->mon_disable_while_reg_set)
+		ret = monitors_set_state(rdev, false);
+	if (ret)
+		return ret;
+
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
 	min_uV += rdev->constraints->uV_offset;
@@ -3636,6 +3672,10 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 out:
 	trace_regulator_set_voltage_complete(rdev_get_name(rdev), best_val);
 
+	if (rdev->desc->mon_disable_while_reg_set)
+		/* TODO: ignore return value here when ret already !0? */
+		ret = monitors_set_state(rdev, true);
+
 	return ret;
 }
 
@@ -4545,7 +4585,19 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 	if (ret < 0)
 		goto out;
 
+	if (mode & rdev->desc->mon_unsupported_reg_modes)
+		ret = monitors_set_state(rdev, false);
+	if (ret)
+		goto out;
+
 	ret = rdev->desc->ops->set_mode(rdev, mode);
+	if (ret)
+		goto out;
+
+	if (mode & ~rdev->desc->mon_unsupported_reg_modes)
+		/* TODO: if set_mode fails, we stay unmonitored */
+		ret = monitors_set_state(rdev, true);
+
 out:
 	regulator_unlock(rdev);
 	return ret;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d3b4a3d4514a..2fdc2c78e4bd 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -357,6 +357,12 @@ enum regulator_type {
  *                     the regulator was actually enabled. Max upto enable_time.
  *
  * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
+ *
+ * @mon_disable_while_reg_off: Disables regulator's monitors while it is off.
+ * @mon_disable_while_reg_set: Disables regulator's monitors while it is changing its value.
+ * @mon_unsupported_reg_modes: Disables regulator's monitors before an unsupported mode is entered.
+ *                             Unsupported REGULATOR_MODE_* are OR'ed. REGULATOR_MODE_INVALID means
+ *                             all modes can be monitored.
  */
 struct regulator_desc {
 	const char *name;
@@ -431,6 +437,10 @@ struct regulator_desc {
 	unsigned int poll_enabled_time;
 
 	unsigned int (*of_map_mode)(unsigned int mode);
+
+	unsigned int mon_disable_while_reg_off;
+	unsigned int mon_disable_while_reg_set;
+	unsigned int mon_unsupported_reg_modes;
 };
 
 /**

-- 
2.34.1

