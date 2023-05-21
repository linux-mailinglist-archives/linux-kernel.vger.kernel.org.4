Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5570ADB8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjEULrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C500E47
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-95fde138693so516268066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684669205; x=1687261205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BVvd2yufw+BLykR/+MC80568t6BgpSllPFSORcsVX0=;
        b=Iaa2CzKYihonZCk28eUqTHfkbfErQX4rt6s/pwZQnvx1MrCh1LxXNhzvEcSU53kHFX
         Jatya+bPkiX0R9X1dLXu6w7gZh8DuROxd4JkC4FvhJ+6dNis5tli3b4NiZ22OSAxyY5Y
         Tsx7qijFN96IOaqeE+6NNZ3ZeB92oeMFtSllKYC+0Kb4ioNv+ulm1GIpjVmw9LFXoIu4
         IABNOzvA6WBDknXrA/W+89a0GPbja/0J8KPZzu25WxAjfepkhY7zQsPjzJ+Z9z8Ohn69
         uoAV8HW10fDSe5CCeapMVvWc8K8g14f8XpycRZNxC6cHSpMj/16Ok6aAKK1xYezcqyPo
         CkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669205; x=1687261205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BVvd2yufw+BLykR/+MC80568t6BgpSllPFSORcsVX0=;
        b=G1HGOIFQ/0YbD2zizcdyD/SXWgne/0WLlzGVoW2u7SRqCRUMi06D4Hr0kZaUaNzzlP
         OwEOwGkSC+uQ4pIJMumtLCmT+IZNFWguKBQ7SveoZjsSv46j3pfKPfdOiM0ltDi/fExh
         P/YQM2scJ76XdtQwuCgNCEgbecjq/vBJUmzScVtxUpzW2Qt6sSjqLjHVHr/FP7h66fGq
         nOm0SF5qo3Eb2qOkPosuwYFRlQbibQVhRfp0kRtKeZJfkQzX6GC8WHpsxkTbVyb8lYsH
         Fl+OZxecB9PjenpEjXgGKo9t+3Q/5GIxU/OTW2Mm2h9H+08rPN+b0FibDOVceOu5Ierb
         bmKQ==
X-Gm-Message-State: AC+VfDzG5A0uyDb36VXzQZsJyTf511Vn2gefgQ9huYqCWZBrvpmmMD8k
        LYXKXdagbbT5TSWj7GOVauS5xcxBxBphsg==
X-Google-Smtp-Source: ACHHUZ7gK3LD0rffutZs1W5DSej94BF+7nVfGNk/kLnJr6Z6StKyOOHvojNGaijTQ76fswW7V6nLGA==
X-Received: by 2002:a17:907:94c1:b0:932:f88c:c2ff with SMTP id dn1-20020a17090794c100b00932f88cc2ffmr6835903ejc.34.1684669205349;
        Sun, 21 May 2023 04:40:05 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0096f7996d59csm1833911ejl.184.2023.05.21.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 04:40:05 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Sun, 21 May 2023 13:39:50 +0200
Subject: [PATCH RFC v3 1/5] regulator: move monitor handling into own
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v3-1-4179b586d8a1@skidata.com>
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

Similar to the existing implementation, the new function does not handle
EOPNOTSUPP as an error. The initial monitoring state is set to the
regulator state.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 134 ++++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dc741ac156c3..76f112817f9d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1426,7 +1426,7 @@ static int notif_set_limit(struct regulator_dev *rdev,
 
 static int handle_notify_limits(struct regulator_dev *rdev,
 			int (*set)(struct regulator_dev *, int, int, bool),
-			struct notification_limit *limits)
+			const struct notification_limit *limits)
 {
 	int ret = 0;
 
@@ -1451,6 +1451,80 @@ static int handle_notify_limits(struct regulator_dev *rdev,
 
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
+	int ret;
+
+	/* only set the state if monitoring is activated in the device-tree. */
+	if (reg_c->over_voltage_detection) {
+		ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
+					   enable ? &reg_c->over_voltage_limits
+					   : &disable_limits);
+		if (ret) {
+			if (ret != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set over voltage limits %pe\n",
+					 ERR_PTR(ret));
+				return ret;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested over voltage limits\n");
+		}
+	}
+	if (reg_c->under_voltage_detection) {
+		ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
+					   enable ? &reg_c->under_voltage_limits
+					   : &disable_limits);
+		if (ret) {
+			if (ret != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set under voltage limits %pe\n",
+					 ERR_PTR(ret));
+				return ret;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested under voltage limits\n");
+		}
+	}
+	if (reg_c->over_current_detection) {
+		ret = handle_notify_limits(rdev, ops->set_over_current_protection,
+					   enable ? &reg_c->over_curr_limits
+					   : &disable_limits);
+		if (ret) {
+			if (ret != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set over current limits: %pe\n",
+					 ERR_PTR(ret));
+				return ret;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested over-current limits\n");
+		}
+	}
+	if (reg_c->over_temp_detection) {
+		ret = handle_notify_limits(rdev, ops->set_thermal_protection,
+					   enable ? &reg_c->temp_limits
+					   : &disable_limits);
+		if (ret) {
+			if (ret != -EOPNOTSUPP) {
+				rdev_err(rdev, "failed to set temperature limits %pe\n",
+					 ERR_PTR(ret));
+				return ret;
+			}
+			rdev_warn(rdev,
+				  "IC does not support requested temperature limits\n");
+		}
+	}
+
+	return 0;
+}
+
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
@@ -1564,60 +1638,12 @@ static int set_machine_constraints(struct regulator_dev *rdev)
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
+	/* set initial monitor state to current regulator state. */
+	ret = _regulator_is_enabled(rdev);
+	if (ret >= 0) {
+		ret = monitors_set_state(rdev, !!ret);
+		if (ret)
 			return ret;
-		}
-		rdev_warn(rdev,
-			  "IC does not support requested temperature limits\n");
 	}
 
 	if (rdev->constraints->active_discharge && ops->set_active_discharge) {

-- 
2.34.1

