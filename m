Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B76E9042
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjDTKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjDTKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:32:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6F6EA0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:29:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u3so5102278ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681986574; x=1684578574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLV6OuUlEFZ5EObG3eJjSnPpQJZKRpheYqinpQmw1F8=;
        b=CNLmKXTMKGw5LJOEGeqmuNzcSZ2FktemA3K7GFbv+n8xxDt9M70dDgr3WwKK5SNlzG
         6YaH9xxKNMZqVDCKsuAHek+oEkssqTwHCXbcApy7NTVWAegJgAlRnlnLP5yvPnklZ/0m
         VDM9iPwuCdnWRLpml2sbEddabugR7PmXa/66Nk6Tt6eODHqy675IK4PYnzI/6mT5FKK5
         x3nER63QVrGZvKOeJOwAaTvr/6Xny8BpkncRkY1Gi8O9t268U6lbBX2lEcchEBhlRCFn
         /K/fWmp3pc/kyAgqwM2v3ElKnsoDRz1kiZ90IfgTSq++CC/Q6JNPrx2OE0PQT/5BV8xz
         /Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681986574; x=1684578574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLV6OuUlEFZ5EObG3eJjSnPpQJZKRpheYqinpQmw1F8=;
        b=PGvxxAY3WXkxgloEQNGkYx4P1SQGfbJpCdwspjDYXGYg0QATbdWnuaFxaBzugK60TE
         ppzDe0RSC14CGdICdSuQvcMjaigdOPFM+Obi5x9MufRtM6ifHL91t/AaiLs4AmVwP7OS
         bD+m8PdBhmprvzowU6BKUcDi/kv7OdmIoZjn08ENaS/1t4racRo1+LG9MW6AG90yfqLN
         4DFyjLGbQYmD/wZtBBX1K1T70e5zip1g+8Vci02rzkBi+hs85YYePLwOFYGuj1G6GVw4
         ZcaOicDnmwqnbvhKiBduFmd2GiHoUuYdMjBtnafFfV66vffE/mJK8kLFHTklRpJVptDL
         N/IA==
X-Gm-Message-State: AAQBX9cfliaWTSKBdL099tDtrQVgPqBRAnGMxJG7qr286bXwjjMwa3gi
        MtFpny9diF82ej5yNLB4OeE=
X-Google-Smtp-Source: AKy350Z97mrLI1ABOmIp+TzPToK/6M6pBesl0km9AmqM9yMIbCPeHzkpnnW+fiuZ78CBHq42vfeI8Q==
X-Received: by 2002:a17:906:6857:b0:953:4775:baa7 with SMTP id a23-20020a170906685700b009534775baa7mr1326366ejs.52.1681986574092;
        Thu, 20 Apr 2023 03:29:34 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090694d500b0094efe88a037sm584512ejy.9.2023.04.20.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:29:33 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 20 Apr 2023 12:29:20 +0200
Subject: [PATCH RFC 1/2] regulator: introduce regulator monitoring
 constraints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v1-1-f48b7438e891@skidata.com>
References: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
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

Add constraints for regulator monitoring. These are useful when the
state of the regulator might change during runtime, but the monitor
state (in hardware) is not implicitly changed with the change of the
regulator state or mode (in hardware).

When used, the core takes care of handling the monitor state. This could
ensure that a monitor does not stay active when its regulator is
disabled.

TODO: depending on the initial state of the regulator, the initial state
of the monitor might not be guaranteed to be correct for now.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c          | 155 ++++++++++++++++++++++++++++++++++----
 include/linux/regulator/machine.h |  34 +++++++++
 2 files changed, 175 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4fcd36055b02..3ec34c05bda2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1360,7 +1360,7 @@ static int notif_set_limit(struct regulator_dev *rdev,
 
 static int handle_notify_limits(struct regulator_dev *rdev,
 			int (*set)(struct regulator_dev *, int, int, bool),
-			struct notification_limit *limits)
+			const struct notification_limit *limits)
 {
 	int ret = 0;
 
@@ -1385,6 +1385,106 @@ static int handle_notify_limits(struct regulator_dev *rdev,
 
 	return ret;
 }
+
+static const struct notification_limit disable_limits = {
+	.prot = REGULATOR_NOTIF_LIMIT_DISABLE,
+	.err = REGULATOR_NOTIF_LIMIT_DISABLE,
+	.warn = REGULATOR_NOTIF_LIMIT_DISABLE,
+};
+
+static inline bool should_disable_monitor(const struct monitoring_constraints *mon_c, bool pre,
+					  bool enable, bool change, unsigned int mode)
+{
+	bool disable = !enable && !change && mode == REGULATOR_MODE_INVALID;
+
+	if (!pre)
+		return false;
+	return (mon_c->mon_disable_during_reg_set && change) ||
+	       (mon_c->mon_disable_during_reg_off && disable) ||
+	       (mon_c->mon_disable_pre_reg_idle && mode == REGULATOR_MODE_IDLE) ||
+	       (mon_c->mon_disable_pre_reg_standby && mode == REGULATOR_MODE_STANDBY);
+}
+
+static inline bool should_enable_monitor(const struct monitoring_constraints *mon_c, bool pre,
+					 bool enable, bool change, unsigned int mode)
+{
+	if (pre)
+		return false;
+	return (mon_c->mon_disable_during_reg_set && change) ||
+	       (mon_c->mon_disable_during_reg_off && enable) ||
+	       (mon_c->mon_enable_post_reg_normal && mode == REGULATOR_MODE_NORMAL) ||
+	       (mon_c->mon_enable_post_reg_fast && mode == REGULATOR_MODE_FAST);
+}
+
+static int handle_monitors(struct regulator_dev *rdev, bool pre, bool enable, bool change,
+			   unsigned int mode)
+{
+	const struct regulator_ops *ops = rdev->desc->ops;
+	const struct regulation_constraints *reg_c = rdev->constraints;
+
+	/*
+	 * ensure that voltage monitoring is explicitly enabled in the device tree and that the
+	 * driver has monitoring constraints and protection ops.
+	 */
+	bool handle_ov = reg_c->over_voltage_detection && reg_c->ov_constraints &&
+			 ops->set_over_voltage_protection;
+	bool handle_uv = reg_c->under_voltage_detection && reg_c->uv_constraints &&
+			 ops->set_under_voltage_protection;
+	int ret = 0;
+
+	if (!handle_ov && !handle_uv)
+		return 0;
+
+	dev_dbg(&rdev->dev, "%s: pre: %d, en: %d, ch: %d, mode: %u\n", __func__, pre, enable,
+		change, mode);
+	if ((enable + change + !!mode) > 1) {
+		dev_err(&rdev->dev, "%s: invalid combination!\n", __func__);
+		return -EINVAL;
+	}
+
+	if (handle_ov) {
+		if (should_disable_monitor(reg_c->ov_constraints, pre, enable, change, mode))
+			ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
+						   &disable_limits);
+		else if (should_enable_monitor(reg_c->ov_constraints, pre, enable, change, mode))
+			ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
+						   &reg_c->over_voltage_limits);
+	}
+	if (ret)
+		return ret;
+
+	if (handle_uv) {
+		if (should_disable_monitor(reg_c->uv_constraints, pre, enable, change, mode))
+			ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
+						   &disable_limits);
+		else if (should_enable_monitor(reg_c->uv_constraints, pre, enable, change, mode))
+			ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
+						   &reg_c->under_voltage_limits);
+	}
+
+	return ret;
+}
+
+static inline int handle_monitors_disable(struct regulator_dev *rdev)
+{
+	return handle_monitors(rdev, true, false, false, REGULATOR_MODE_INVALID);
+}
+
+static inline int handle_monitors_enable(struct regulator_dev *rdev)
+{
+	return handle_monitors(rdev, false, true, false, REGULATOR_MODE_INVALID);
+}
+
+static inline int handle_monitors_set(struct regulator_dev *rdev, bool pre)
+{
+	return handle_monitors(rdev, pre, false, true, REGULATOR_MODE_INVALID);
+}
+
+static inline int handle_monitors_mode(struct regulator_dev *rdev, bool pre, unsigned int mode)
+{
+	return handle_monitors(rdev, pre, false, false, mode);
+}
+
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
@@ -1512,7 +1612,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			  "IC does not support requested over-current limits\n");
 	}
 
-	if (rdev->constraints->over_voltage_detection)
+	/* only if we have static monitoring. with dynamic, it will be set according to state. */
+	if (rdev->constraints->over_voltage_detection && !rdev->constraints->ov_constraints)
 		ret = handle_notify_limits(rdev,
 					   ops->set_over_voltage_protection,
 					   &rdev->constraints->over_voltage_limits);
@@ -1526,7 +1627,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			  "IC does not support requested over voltage limits\n");
 	}
 
-	if (rdev->constraints->under_voltage_detection)
+	/* only if we have static monitoring. with dynamic, it will be set according to state. */
+	if (rdev->constraints->under_voltage_detection && !rdev->constraints->uv_constraints)
 		ret = handle_notify_limits(rdev,
 					   ops->set_under_voltage_protection,
 					   &rdev->constraints->under_voltage_limits);
@@ -2734,7 +2836,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
-	return 0;
+	return handle_monitors_enable(rdev);
 }
 
 /**
@@ -2895,6 +2997,10 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 {
 	int ret;
 
+	ret = handle_monitors_disable(rdev);
+	if (ret)
+		return ret;
+
 	trace_regulator_disable(rdev_get_name(rdev));
 
 	if (rdev->ena_pin) {
@@ -3406,7 +3512,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 				       unsigned *selector)
 {
 	struct pre_voltage_change_data data;
-	int ret;
+	int ret, err = 0;
 
 	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = min_uV;
@@ -3416,12 +3522,18 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 	if (ret & NOTIFY_STOP_MASK)
 		return -EINVAL;
 
-	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
-	if (ret >= 0)
+	ret = handle_monitors_set(rdev, true);
+	if (ret)
 		return ret;
 
-	_notifier_call_chain(rdev, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE,
-			     (void *)data.old_uV);
+	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
+	if (ret >= 0)
+		err = handle_monitors_set(rdev, false);
+	else
+		_notifier_call_chain(rdev, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE,
+				     (void *)data.old_uV);
+	if (err)
+		return err;
 
 	return ret;
 }
@@ -3430,7 +3542,7 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 					   int uV, unsigned selector)
 {
 	struct pre_voltage_change_data data;
-	int ret;
+	int ret, err = 0;
 
 	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = uV;
@@ -3440,12 +3552,18 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	if (ret & NOTIFY_STOP_MASK)
 		return -EINVAL;
 
-	ret = rdev->desc->ops->set_voltage_sel(rdev, selector);
-	if (ret >= 0)
+	ret = handle_monitors_set(rdev, true);
+	if (ret)
 		return ret;
 
-	_notifier_call_chain(rdev, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE,
-			     (void *)data.old_uV);
+	ret = rdev->desc->ops->set_voltage_sel(rdev, selector);
+	if (ret >= 0)
+		err = handle_monitors_set(rdev, false);
+	else
+		_notifier_call_chain(rdev, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE,
+				     (void *)data.old_uV);
+	if (err)
+		return err;
 
 	return ret;
 }
@@ -4545,7 +4663,16 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 	if (ret < 0)
 		goto out;
 
+	ret = handle_monitors_mode(rdev, true, mode);
+	if (ret)
+		goto out;
+
 	ret = rdev->desc->ops->set_mode(rdev, mode);
+	if (ret)
+		goto out;
+
+	ret = handle_monitors_mode(rdev, false, mode);
+
 out:
 	regulator_unlock(rdev);
 	return ret;
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 621b7f4a3639..1cfd10ec13a5 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -83,6 +83,36 @@ struct regulator_state {
 	bool changeable;
 };
 
+/**
+ * struct monitoring_constraints - regulator monitoring constraints.
+ *
+ * This struct describes monitoring specific constraints.
+ *
+ * The constraints should be set by a driver if an enable/disable or regulator MODE switch does not
+ * change the state of the monitor implicitly. When used, the core handles the monitoring of a
+ * dynamic regulator implicitly on state/mode change, based on this configuration. This should
+ * avoid that the monitor reaches an invalid state.
+ *
+ * @mon_disable_during_reg_set: Monitor should be disabled before and enabled after the regulators'
+ *                              value is changed
+ * @mon_disable_during_reg_off: Monitor should be disabled before a regulator disable and enabled
+ *                              after a regulator enable
+ *
+ * @mon_disable_pre_reg_idle: Monitor should be disabled before a switch to MODE_IDLE
+ * @mon_disable_pre_reg_standby: Monitor should be disabled before a switch to MODE_STANDBY
+ * @mon_enable_post_reg_normal: Monitor should be enabled after a switch to MODE_NORMAL
+ * @mon_enable_post_reg_fast: Monitor should be enabled after a switch to MODE_FAST
+ */
+struct monitoring_constraints {
+	unsigned mon_disable_during_reg_set:1;
+	unsigned mon_disable_during_reg_off:1;
+
+	unsigned mon_disable_pre_reg_idle:1;
+	unsigned mon_disable_pre_reg_standby:1;
+	unsigned mon_enable_post_reg_normal:1;
+	unsigned mon_enable_post_reg_fast:1;
+};
+
 #define REGULATOR_NOTIF_LIMIT_DISABLE -1
 #define REGULATOR_NOTIF_LIMIT_ENABLE -2
 struct notification_limit {
@@ -207,6 +237,10 @@ struct regulation_constraints {
 
 	unsigned int active_discharge;
 
+	/* monitoring constraints */
+	const struct monitoring_constraints *ov_constraints;
+	const struct monitoring_constraints *uv_constraints;
+
 	/* constraint flags */
 	unsigned always_on:1;	/* regulator never off when system is on */
 	unsigned boot_on:1;	/* bootloader/firmware enabled regulator */

-- 
2.34.1

