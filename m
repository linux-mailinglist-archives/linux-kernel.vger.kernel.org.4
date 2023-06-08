Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49F727952
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjFHH5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjFHH5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:57:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC8128
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:56:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5428f63c73aso99062a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686211018; x=1688803018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3C2rZMSJTRmrGY5FMhPctSUiD2DaIbQz7WMkwiTo0k=;
        b=W9Fk7kTqHjlNbIkLxtiJZDuIaWG9/lhXNTmDhenukiwNm3sA5KRD1XX/qJiuylhBQ3
         WTXuDtCcKf4C4j+iOE7BJlDN3OMffsG6I/wy7TdkXJYAdEtTnwBb7elNNquJhc3LDomC
         z9LWC4g/FaHq2BTXFhb7Db5ETO+pRXnYOnoG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686211018; x=1688803018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3C2rZMSJTRmrGY5FMhPctSUiD2DaIbQz7WMkwiTo0k=;
        b=N4ARAyW4tal20HKmJJnQkl+SM5TKAdCbAnJMvc9jdoa5Y6RMlBwpvMsSiNQRS+UsN3
         I+EOytTT+BMaL3mD6uvwum66tLe7vMaM7mPOa6CF2lS0eLky9W41TYzQpMsNECb8ECq1
         YkzmOO6inqdmT5z3ldbx60AO0FJ7MwdWa1CA+lkczqzmm0Sf+fG3AZZgVQQO1qm/RY44
         rgIRSVRDGVZm12H7VjE/V+TEY5iGh9Pt+/rnhkIKRmbcExPtSmbIdJda0UlX4KeGOmQ4
         Ai4duckmlbwHlGfmIBR9AHsO4IHE0MdyvxVhQ0WLcth5+/eabSiXQL9Bw4YO5KpB+xWV
         /PlA==
X-Gm-Message-State: AC+VfDyFXylXAc0B2S4NlHPI8yn/iIMJY3mvQkLzQCk07MHDd4eXHGut
        U+7oXzHGsE58aX6taplQvsAN79Kb9CVtobLhrrA=
X-Google-Smtp-Source: ACHHUZ5SUB2pJGp9fQxYxHJIipc/QQtHgRQqSV57BcyBggtmdpJcyg8shXknV1PFQwOgOfjfe4mzRA==
X-Received: by 2002:a17:902:bcc1:b0:1ac:482e:ed4d with SMTP id o1-20020a170902bcc100b001ac482eed4dmr4643518pls.18.1686211018431;
        Thu, 08 Jun 2023 00:56:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:9700:4b43:59b4:fde3])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001b045c9ababsm771441plx.264.2023.06.08.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 00:56:58 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] regulator: Use bitfield values for range selectors
Date:   Thu,  8 Jun 2023 15:56:48 +0800
Message-ID: <20230608075651.3214540-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the regulator helpers expect raw register values for the range
selectors. This is different from the voltage selectors, which are
normalized as bitfield values. This leads to a bit of confusion. Also,
raw values are harder to copy from datasheets or match up with them,
as datasheets will typically have bitfield values.

Make the helpers expect bitfield values, and convert existing users.
Include bitops.h explicitly for ffs(), and reorder the header include
statements. While at it, also replace module.h with export.h, since the
only use is EXPORT_SYMBOL_GPL.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/atc260x-regulator.c  | 2 +-
 drivers/regulator/bd718x7-regulator.c  | 8 ++++----
 drivers/regulator/helpers.c            | 9 ++++++---
 drivers/regulator/tps6287x-regulator.c | 2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index 87e237d740bc..0bba33955a1a 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -37,7 +37,7 @@ static const struct linear_range atc2609a_ldo_voltage_ranges1[] = {
 };
 
 static const unsigned int atc260x_ldo_voltage_range_sel[] = {
-	0x0, 0x20,
+	0x0, 0x1,
 };
 
 static int atc260x_dcdc_set_voltage_time_sel(struct regulator_dev *rdev,
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b0b9938c20a1..da1eea1207e5 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -289,7 +289,7 @@ static const struct linear_range bd71837_buck5_volts[] = {
  * and 0x1 for last 3 ranges.
  */
 static const unsigned int bd71837_buck5_volt_range_sel[] = {
-	0x0, 0x0, 0x0, 0x80, 0x80, 0x80
+	0x0, 0x0, 0x0, 0x1, 0x1, 0x1
 };
 
 /*
@@ -309,7 +309,7 @@ static const struct linear_range bd71847_buck3_volts[] = {
 };
 
 static const unsigned int bd71847_buck3_volt_range_sel[] = {
-	0x0, 0x0, 0x0, 0x40, 0x80, 0x80, 0x80
+	0x0, 0x0, 0x0, 0x1, 0x2, 0x2, 0x2
 };
 
 static const struct linear_range bd71847_buck4_volts[] = {
@@ -360,7 +360,7 @@ static const struct linear_range bd718xx_ldo1_volts[] = {
 	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
 };
 
-static const unsigned int bd718xx_ldo1_volt_range_sel[] = { 0x0, 0x20 };
+static const unsigned int bd718xx_ldo1_volt_range_sel[] = { 0x0, 0x1 };
 
 /*
  * LDO2
@@ -403,7 +403,7 @@ static const struct linear_range bd71847_ldo5_volts[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x0F, 100000),
 };
 
-static const unsigned int bd71847_ldo5_volt_range_sel[] = { 0x0, 0x20 };
+static const unsigned int bd71847_ldo5_volt_range_sel[] = { 0x0, 0x1 };
 
 /*
  * LDO6
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 586f42e378ee..8bdafea70d36 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -5,13 +5,14 @@
 // Copyright 2007, 2008 Wolfson Microelectronics PLC.
 // Copyright 2008 SlimLogic Ltd.
 
-#include <linux/kernel.h>
-#include <linux/err.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
-#include <linux/module.h>
 
 #include "internal.h"
 
@@ -108,6 +109,7 @@ static int regulator_range_selector_to_index(struct regulator_dev *rdev,
 		return -EINVAL;
 
 	rval &= rdev->desc->vsel_range_mask;
+	rval >>= ffs(rdev->desc->vsel_range_mask) - 1;
 
 	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
 		if (rdev->desc->linear_range_selectors[i] == rval)
@@ -195,6 +197,7 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 	sel += rdev->desc->linear_ranges[i].min_sel;
 
 	range = rdev->desc->linear_range_selectors[i];
+	range <<= ffs(rdev->desc->vsel_mask) - 1;
 
 	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
 		ret = regmap_update_bits(rdev->regmap,
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index 870e63ce3ff2..3139a0cbb6f7 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -41,7 +41,7 @@ static const struct linear_range tps6287x_voltage_ranges[] = {
 };
 
 static const unsigned int tps6287x_voltage_range_sel[] = {
-	0x0, 0x4, 0x8, 0xC
+	0x0, 0x1, 0x2, 0x3
 };
 
 static const unsigned int tps6287x_ramp_table[] = {
-- 
2.41.0.rc0.172.g3f132b7071-goog

