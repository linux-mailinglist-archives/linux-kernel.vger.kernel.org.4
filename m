Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85D07291C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbjFIHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjFIHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:51:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4044A0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:50:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-652a6cf1918so1241987b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686297039; x=1688889039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwmX1lTiaCCczI1NPGTxhaGHkbuif3HHQrM659nXr0Y=;
        b=FR2Wn4n+oAcav3W8ywrHAUlNhIwMJGwIjHBjEMlglZwMUFwfGuCJh2kCw1PnjwAD2R
         yeLewDqbV07CjbDPe18mNTFxDm37arVJlH9KtqgPRMUp094La7B6zpZ2wF/D6Q0Eg9ky
         BrjnSXNQHeLJ6oNRT/fErnZgEYwHbPpL13IHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686297039; x=1688889039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwmX1lTiaCCczI1NPGTxhaGHkbuif3HHQrM659nXr0Y=;
        b=KM0/Vukaht48ct5S3wUBdaI55/4T+u463+nVRlO+aQ0kewsPpX2T3grsSW3VjZtq8u
         4ssAPKCTMGX72yx4mwZ2HuGi4r1Wf9J6BfTWqK2oLCtF/vLWfRGcLzpgFAquSUulBD1m
         4JAJ5awp8arpFiiracLi2SrXcTokyrBwRilEm87aVuhNovdmBMj4SUryOHRK5gUNmVGH
         odt5YbE8PBPV4yd7KG4E9vtp9QoJ+Bj7kIdBpo88UY7AWw8H2mOvR79wnNduEmRE+dvt
         PVBlzGk6nSPHniC/R09BMeuVj7dUEIdlyZRgh2D28kWg+8QOsQDN5cteh78ca5h2s51d
         FLfA==
X-Gm-Message-State: AC+VfDzjaDWr61lMoHoZzQci9M7f0kcvHKaUHx7WujA4+FzYFCMa4VdU
        AKBQ3gioFLcswUP+4Y/LLZso2g==
X-Google-Smtp-Source: ACHHUZ60Lmzc970vMEATF5+BYisQid0/hhwIis16X//WxSfGUtBN8MgTeODNHu33Q8JvLmqHSSbuvQ==
X-Received: by 2002:a05:6a21:6da6:b0:10c:ef18:746e with SMTP id wl38-20020a056a216da600b0010cef18746emr314444pzb.58.1686297039199;
        Fri, 09 Jun 2023 00:50:39 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id r17-20020a170902c61100b001ac84f5559csm2622346plr.126.2023.06.09.00.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:50:38 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] regulator: Use bitfield values for range selectors
Date:   Fri,  9 Jun 2023 15:50:30 +0800
Message-ID: <20230609075032.2804554-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v1:
- Fixed up bd71847_buck4_volt_range_sel in bd718x7-regulator.c

 drivers/regulator/atc260x-regulator.c  |  2 +-
 drivers/regulator/bd718x7-regulator.c  | 10 +++++-----
 drivers/regulator/helpers.c            |  9 ++++++---
 drivers/regulator/tps6287x-regulator.c |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

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
index b0b9938c20a1..211ed9861417 100644
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
@@ -317,7 +317,7 @@ static const struct linear_range bd71847_buck4_volts[] = {
 	REGULATOR_LINEAR_RANGE(2600000, 0x00, 0x03, 100000),
 };
 
-static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x40 };
+static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x1 };
 
 /*
  * BUCK6
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
2.41.0.162.gfafddb0af9-goog

