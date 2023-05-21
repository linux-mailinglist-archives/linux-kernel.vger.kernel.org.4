Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7646670ADC5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjEULrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98839E4B
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ac4dd11bso985201566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684669208; x=1687261208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tup0fS1Ilgny0Y9QHNptVTLtqhryknUFnq8PvXS+SwM=;
        b=h81dhzI4XMEIp+UuShvAuYmnYwf57fHKAQYu5GynhG1bMvfF0FPzo1o+IEzkqERbho
         LUe09PWOZrireopuOT2PV2D1qOogrNvRhHJofUvG8GA1Y2UIxTBrTZ9MHjPmb5LryMwo
         US9j8bhOGba1maJBegoGBc8uFs3dMwNo3dlhKHSb++XrsoMXC6ilgWu+hmvHuwCOHfiv
         NxDqN6HyOrvfEoFjbuW7A0v3WRhmnQkQCrqbSJ0d2CeH6rTh4z+PZrkMELoEpRuU6lWV
         TGG2mTABA1aXqmtRGM2w3Qu/+BzSrVllA3Wtl6Nj+Kpcz0AUKWlL/roEX6jPstiLAru6
         71zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669208; x=1687261208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tup0fS1Ilgny0Y9QHNptVTLtqhryknUFnq8PvXS+SwM=;
        b=IxkFktzIordtCCTx9l76vRWkuNH/psAewJK7/DYihovCbT7kGH2h+2zkSagmQwVaB8
         KxdbwC7OK23QNaID7ZiINwyUVDERaA7NiuxhQzZnsq+neCQ2HCvr2M0/wn/emIAGgU6K
         Cg05CecLc/bY3s+N/SJO+qlW4+aKmjK2rl/1tdS1OFfDQs+0jdtGlq+48j9SjruqdjE8
         UsjkjoCZw7CDiSJcWFusxzbNvGDNHn5EDjcH1Dz7Vq3nymf76Dye/Pd2R/h9vrvA/KqP
         roggYHQVVq8W6Wzpw1G4/Imh6gyb2wQJ9bFY5CwDvThOfw5jK8/SS3p4tScI301sK8cp
         GXFA==
X-Gm-Message-State: AC+VfDwuaex1QHZ8Pg309xThg9jEbk7F9lsCeEOVBJDF/YAFnrh6cJZF
        Gm7ZN/+PMN97k8akHWsjzxc=
X-Google-Smtp-Source: ACHHUZ7FkQr4E0IzlSheCD4krH4EzHncz46xuRzvGRaqLiLW13dn2NFEOPdfqpEjelWZuYCX0bueQg==
X-Received: by 2002:a17:907:5cd:b0:94e:46ef:1361 with SMTP id wg13-20020a17090705cd00b0094e46ef1361mr6283834ejb.34.1684669208002;
        Sun, 21 May 2023 04:40:08 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0096f7996d59csm1833911ejl.184.2023.05.21.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 04:40:07 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Sun, 21 May 2023 13:39:53 +0200
Subject: [PATCH RFC v3 4/5] regulator: add properties to handle monitoring
 on state change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v3-4-4179b586d8a1@skidata.com>
References: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
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
 drivers/regulator/core.c         | 90 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h | 13 ++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e59204920d6c..98a9283a0322 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1638,6 +1638,34 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		}
 	}
 
+	/*
+	 * when the core is in charge of disabling monitors while the regulator
+	 * changes its value, it is essential to know if a monitor is active.
+	 */
+	if (rdev->desc->mon_disable_reg_set_higher ||
+	    rdev->desc->mon_disable_reg_set_lower) {
+		unsigned int monitor_state = REGULATOR_MONITOR_INVALID;
+
+		ret = ops->get_active_protections(rdev, &monitor_state);
+		if (ret)
+			return ret;
+
+		/*
+		 * when a monitor is active, without dt knowing, we have to
+		 * adapt the constraints to ensure functionality.
+		 */
+		if (!rdev->constraints->over_voltage_detection &&
+		    (monitor_state & REGULATOR_MONITOR_OVER_VOLTAGE)) {
+			rdev_warn(rdev, "dt unaware of over-voltage protection!\n");
+			rdev->constraints->over_voltage_detection = 1;
+		}
+		if (!rdev->constraints->under_voltage_detection &&
+		    (monitor_state & REGULATOR_MONITOR_UNDER_VOLTAGE)) {
+			rdev_warn(rdev, "dt unaware of under-voltage protection!\n");
+			rdev->constraints->under_voltage_detection = 1;
+		}
+	}
+
 	/* set initial monitor state to current regulator state. */
 	ret = _regulator_is_enabled(rdev);
 	if (ret >= 0) {
@@ -3516,6 +3544,15 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 	if (ret & NOTIFY_STOP_MASK)
 		return -EINVAL;
 
+	if ((rdev->desc->mon_disable_reg_set_higher &&
+	    (min_uV > data.old_uV || max_uV > data.old_uV)) ||
+	    (rdev->desc->mon_disable_reg_set_lower &&
+	    (min_uV < data.old_uV || max_uV < data.old_uV))) {
+		ret = monitors_set_state(rdev, false);
+		if (ret)
+			return ret;
+	}
+
 	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
 	if (ret >= 0)
 		return ret;
@@ -3540,6 +3577,13 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	if (ret & NOTIFY_STOP_MASK)
 		return -EINVAL;
 
+	if ((rdev->desc->mon_disable_reg_set_higher && uV > data.old_uV) ||
+	    (rdev->desc->mon_disable_reg_set_lower && uV < data.old_uV)) {
+		ret = monitors_set_state(rdev, false);
+		if (ret)
+			return ret;
+	}
+
 	ret = rdev->desc->ops->set_voltage_sel(rdev, selector);
 	if (ret >= 0)
 		return ret;
@@ -3736,6 +3780,15 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 out:
 	trace_regulator_set_voltage_complete(rdev_get_name(rdev), best_val);
 
+	if ((rdev->desc->mon_disable_reg_set_higher || rdev->desc->mon_disable_reg_set_lower) &&
+	    _regulator_is_enabled(rdev) > 0) {
+		/* if setting voltage failed, ignore monitoring error. */
+		if (ret)
+			monitors_set_state(rdev, true);
+		else
+			ret = monitors_set_state(rdev, true);
+	}
+
 	return ret;
 }
 
@@ -4645,7 +4698,24 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 	if (ret < 0)
 		goto out;
 
+	if (mode & rdev->desc->mon_unsupported_reg_modes) {
+		ret = monitors_set_state(rdev, false);
+		if (ret)
+			goto out;
+	}
+
 	ret = rdev->desc->ops->set_mode(rdev, mode);
+	if (ret) {
+		/* get_mode() is required: regulator_curr_mode should be valid. */
+		if ((regulator_curr_mode & ~rdev->desc->mon_unsupported_reg_modes) &&
+		    _regulator_is_enabled(rdev) > 0)
+			monitors_set_state(rdev, true);
+		goto out;
+	}
+
+	if ((mode & ~rdev->desc->mon_unsupported_reg_modes) && _regulator_is_enabled(rdev) > 0)
+		ret = monitors_set_state(rdev, true);
+
 out:
 	regulator_unlock(rdev);
 	return ret;
@@ -5572,6 +5642,26 @@ regulator_register(struct device *dev,
 		goto rinse;
 	}
 
+	/*
+	 * mon_unsupported_reg_modes property requires get_mode() to get the old
+	 * state in case a state switch is failing.
+	 */
+	if (regulator_desc->mon_unsupported_reg_modes &&
+	    !regulator_desc->ops->get_mode) {
+		ret = -EINVAL;
+		goto rinse;
+	}
+	/*
+	 * mon_disable_reg_set_* property requires get_active_protections() to
+	 * know if a regulator is monitored without the device-tree knowing it.
+	 */
+	if ((regulator_desc->mon_disable_reg_set_higher ||
+	    regulator_desc->mon_disable_reg_set_lower) &&
+	    !regulator_desc->ops->get_active_protections) {
+		ret = -EINVAL;
+		goto rinse;
+	}
+
 	rdev = kzalloc(sizeof(struct regulator_dev), GFP_KERNEL);
 	if (rdev == NULL) {
 		ret = -ENOMEM;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 35547e9eca48..bf42a5f452c5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -366,6 +366,15 @@ enum regulator_type {
  *                     the regulator was actually enabled. Max upto enable_time.
  *
  * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
+ *
+ * @mon_disable_reg_set_higher: Disables regulator's monitors while it is
+ *                              changing its value to a higher one.
+ * @mon_disable_reg_set_lower: Disables regulator's monitors while it is
+ *                             changing its value to a lower one.
+ * @mon_unsupported_reg_modes: Disables regulator's monitors before an
+ *                             unsupported mode is entered. REGULATOR_MODE_* are
+ *                             OR'ed. REGULATOR_MODE_INVALID means all modes can
+ *                             be monitored.
  */
 struct regulator_desc {
 	const char *name;
@@ -440,6 +449,10 @@ struct regulator_desc {
 	unsigned int poll_enabled_time;
 
 	unsigned int (*of_map_mode)(unsigned int mode);
+
+	unsigned int mon_disable_reg_set_higher;
+	unsigned int mon_disable_reg_set_lower;
+	unsigned int mon_unsupported_reg_modes;
 };
 
 /**

-- 
2.34.1

