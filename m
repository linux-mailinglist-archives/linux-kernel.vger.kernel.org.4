Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B96CA4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjC0MyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjC0Mxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:53:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A21991
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so5193733wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679921615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUUSEO3n82oExAtWC9rzQU8vJ+6r7+eAysrgLy7HO+M=;
        b=cOBDGUpnxpTVaMs9FZS0b2dEIizTFb5TZ7ADOSNJWYamswM5ZfCynNfkltTDxFHSLI
         HS2oY1320LmJfHSY2kkYH/Dxj0sdlUiiij2tS9yDt0iD9lG1ktmqRZa36cxGx5vlyZvI
         MQOmmBerwnQXnbZZOLbFqYamTfMfFa9NnWKqFWv2IFZNypjwKT9ddamLba92LVjJa1ab
         7PLzjv1O3jRmVfBWQF7oHOWzWecru2QgO8wguwiD5a8IiJapAOpQdjo3WlYc+7HoduTZ
         4p9TiXkhXzKWOmzvKO/V0AjrcdSmJbraUSrKKJp2A1M5rdd8Nr4SgKxfWj/3dBLUjmO2
         XjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUUSEO3n82oExAtWC9rzQU8vJ+6r7+eAysrgLy7HO+M=;
        b=s+IQs04O9QhpjkhKE/oUYVYxNXp6Nkzp1wwlcQd9QkhQWQno1rFBa0gH05GDhuTtBj
         X0jJx9NBrsppbswK4uyyffOYbVKWkHPW3R1YVD0b/yZiD3eeEfpA6bR0L8Nv7U4bSLsJ
         nGMoJUQkFcoRClTmhU7VGJkTNGQJc7o+AUARc63w+Ypa5T4j9r7TMIea5Fsc7e85XH3i
         6k/tBNZXJHRBtrtWC+psvlCzC8BZfrUTU/QLMhbL+mYEnsX2DT3UVQ4bB92zmUwhojjA
         3ftIeMyjxzHzn6KMLETVWx7lj31WKy8UOiAPSz8nx29rp7k2iFpzkxluBJDR+zJJTnAn
         H5tA==
X-Gm-Message-State: AO0yUKWeR9qVyTexRt0NKh7/WTwPrhGTmxqi5dQKyKh6aMUMTGh7tSEM
        LE+KF1Djvn8vx7k8QBV558Z9vA==
X-Google-Smtp-Source: AK7set9t6T82YBmAdzVga+yKTwTAAhlvYH93ek3LolfE0tf1LsE4KZO1ainSyZbbfLWa4F8VAO0vSQ==
X-Received: by 2002:a05:600c:22cd:b0:3eb:29fe:7343 with SMTP id 13-20020a05600c22cd00b003eb29fe7343mr9145616wmg.33.1679921615302;
        Mon, 27 Mar 2023 05:53:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:313d:a304:2790:a949])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003ee58e8c971sm13572220wmc.14.2023.03.27.05.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:53:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 17/18] regulator: qcom-rpmh: add support for pmm8654au regulators
Date:   Mon, 27 Mar 2023 14:53:15 +0200
Message-Id: <20230327125316.210812-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the RPMH regulators exposed by the PMM8654au PMIC and its variants.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 4826d60e5d95..b0a58c62b1e2 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -694,6 +694,16 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
+	.n_voltages = 188,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_nldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -704,6 +714,16 @@ static const struct rpmh_vreg_hw_data pmic5_nldo = {
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
+	.n_voltages = 211,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -749,6 +769,15 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_voltages = 215,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -937,6 +966,28 @@ static const struct rpmh_vreg_init_data pmm8155au_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps527,  "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps527,  "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps527,  "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps527,  "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps527,  "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps527,  "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps527,  "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps527,  "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps527,  "vdd-s9"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-s9"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,    "vdd-l2-l3"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l2-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-s9"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo515,    "vdd-s9"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo515,    "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_nldo515,    "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo515_mv, "vdd-l8-l9"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,       "vdd-l8-l9"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
@@ -1431,6 +1482,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pmm8155au-rpmh-regulators",
 		.data = pmm8155au_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmm8654au-rpmh-regulators",
+		.data = pmm8654au_vreg_data,
+	},
 	{
 		.compatible = "qcom,pmx55-rpmh-regulators",
 		.data = pmx55_vreg_data,
-- 
2.37.2

