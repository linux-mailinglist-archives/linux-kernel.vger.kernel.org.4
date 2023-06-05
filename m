Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5371D7223D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjFEKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFEKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:48:57 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564BEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:48:56 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b28fc460bcso135976a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962135; x=1688554135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sU0hdLKWLUXC5gL6XBV1Z95emduDUiAxA6L/yTSTI2M=;
        b=nVYRHaGHcp6+Lz2/TuBKRgjl1/a80FcMmE+IuqbIcHZmlYNy1wI+VrAA/XWFcctuya
         YEt1p8xK/Ap55gNAi2SAtcvXpix9uPguO7OksUQNGnLRkOLQqPjtj73ocxN0dbh92SOn
         2TMyYdgAaUhK9m7CpAwO4aWi2JjkvHOiAL1GzUX70F0rtl5k9ub4pSXvjcmhHRhgVGdR
         AFtL9dOXSqveBqJclLe3VMQIBmYc4p+khdEgCHU/5iRP9eRVsPMV70wUpwcRxXsqta7J
         ZMRGDoIlmZ6aSFA8wsrT4N4h7MrGMs/gvSGwLXy+VQUDlI7GUcvnuHq8eww/pl6D+lPX
         qZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962135; x=1688554135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU0hdLKWLUXC5gL6XBV1Z95emduDUiAxA6L/yTSTI2M=;
        b=PCroiqNTtX3vw4dORGnpYQJSi89FsaopGyFHn1useYLw51VQC1/Sd2/FrwGI0EnbtF
         lmTBe1TTfMnDmyZpNv2mbSmSykBLYwQkGBauWEPXw3o6mHjAyYfd/nWltTj/rdln0jvp
         fMLqC/5I9xwvuPh/lZsTxf1uCb9fGP8DsGNxQBZtj9O2IieKACpG70YFhwEQjx5YG0TB
         kP5YDcsn9dIXPXuJw16pYr9REjImD1Xxcnt8DhHNKoPJYedO7sjJShn3BCJm8K049dkw
         Vk76L7DBUcSzZnwpHULE5QdyF2RqYFbw0BO2WH46eNsbj002n1rcDDBG6I4e2Dr9i2s+
         hJdQ==
X-Gm-Message-State: AC+VfDwgdzsmj1cTHFsQYuky5ko3fvgcHhAqByAsFfsV9pqAQcwXTQDh
        Fm6SRFPC7SKoSKcIutz+YrQPna0khPU=
X-Google-Smtp-Source: ACHHUZ6wDD54Ur2duypNZNZBOCDybkw7YBufeoFkLOfWMgpndNSdEMwp5hDOTEZmSahKPSXczrta2w==
X-Received: by 2002:a9d:66c4:0:b0:6af:67d4:b37 with SMTP id t4-20020a9d66c4000000b006af67d40b37mr11047749otm.6.1685962135206;
        Mon, 05 Jun 2023 03:48:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:2003:b135:89cf:b185:51e1:ed4b])
        by smtp.gmail.com with ESMTPSA id w7-20020aa78587000000b0064d681c753csm4935442pfn.40.2023.06.05.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:48:54 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH 1/2] regulator: act8945a: rely on hardware for operating mode
Date:   Mon,  5 Jun 2023 16:18:29 +0530
Message-Id: <20230605104830.68552-1-raagjadav@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ->get_mode() and ->set_mode() hooks to read/write operating mode
from/to hardware instead of relying on driver memory.
While at it, map fixed-frequency PWM regulators to REGULATOR_MODE_FAST.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/regulator/act8945a-regulator.c | 62 ++++++++++++++++++--------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index e26264529b74..bd54d76efcbc 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -65,12 +65,10 @@ enum {
 	ACT8945A_ID_LDO2,
 	ACT8945A_ID_LDO3,
 	ACT8945A_ID_LDO4,
-	ACT8945A_ID_MAX,
 };
 
 struct act8945a_pmic {
 	struct regmap *regmap;
-	u32 op_mode[ACT8945A_ID_MAX];
 };
 
 static const struct linear_range act8945a_voltage_ranges[] = {
@@ -142,6 +140,7 @@ static unsigned int act8945a_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
 	case ACT8945A_REGULATOR_MODE_FIXED:
+		return REGULATOR_MODE_FAST;
 	case ACT8945A_REGULATOR_MODE_NORMAL:
 		return REGULATOR_MODE_NORMAL;
 	case ACT8945A_REGULATOR_MODE_LOWPOWER:
@@ -153,10 +152,9 @@ static unsigned int act8945a_of_map_mode(unsigned int mode)
 
 static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
-	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
 	struct regmap *regmap = rdev->regmap;
 	int id = rdev_get_id(rdev);
-	int reg, ret, val = 0;
+	int reg, val = 0;
 
 	switch (id) {
 	case ACT8945A_ID_DCDC1:
@@ -185,36 +183,64 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 	}
 
 	switch (mode) {
-	case REGULATOR_MODE_STANDBY:
-		if (id > ACT8945A_ID_DCDC3)
-			val = BIT(5);
-		break;
+	case REGULATOR_MODE_FAST:
 	case REGULATOR_MODE_NORMAL:
 		if (id <= ACT8945A_ID_DCDC3)
 			val = BIT(5);
 		break;
+	case REGULATOR_MODE_STANDBY:
+		if (id > ACT8945A_ID_DCDC3)
+			val = BIT(5);
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(regmap, reg, BIT(5), val);
-	if (ret)
-		return ret;
-
-	act8945a->op_mode[id] = mode;
-
-	return 0;
+	return regmap_update_bits(regmap, reg, BIT(5), val);
 }
 
 static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
 {
-	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev->regmap;
 	int id = rdev_get_id(rdev);
+	int reg, ret, val = 0;
 
-	if (id < ACT8945A_ID_DCDC1 || id >= ACT8945A_ID_MAX)
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg = ACT8945A_DCDC1_CTRL;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg = ACT8945A_DCDC2_CTRL;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg = ACT8945A_DCDC3_CTRL;
+		break;
+	case ACT8945A_ID_LDO1:
+		reg = ACT8945A_LDO1_CTRL;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg = ACT8945A_LDO2_CTRL;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg = ACT8945A_LDO3_CTRL;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg = ACT8945A_LDO4_CTRL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	return act8945a->op_mode[id];
+	ret = regmap_read(regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	if (id <= ACT8945A_ID_DCDC3 && (val & BIT(5)))
+		return REGULATOR_MODE_FAST;
+	else if	(id > ACT8945A_ID_DCDC3 && !(val & BIT(5)))
+		return REGULATOR_MODE_NORMAL;
+	else
+		return REGULATOR_MODE_STANDBY;
 }
 
 static const struct regulator_ops act8945a_ops = {
-- 
2.25.1

