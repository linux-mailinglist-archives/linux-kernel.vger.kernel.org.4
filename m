Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3FA6DA131
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjDFT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDFT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:28:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BB5243
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:28:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so1250001wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680809302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PPxvwTg/e/yb+Kfzl1iykhLb1sl3Cb0/2wn1AONayg=;
        b=sQa/9WxwWd5KAFprBAXbGxsg3qZEhuUNoAQ4KEz7VZ0upRzkNELtnZbEd+g6iqHyRn
         GXhvJAjk7sRrh/LuC8thKWC48dyDT7LtIpxNdQo/aX11BeqTWzKtwtCl643mdwnRg78O
         e4dcVEzP92GcmPzY401ZpXqJSJbBIgbf06x3pfujk7nDZ5ZT1/XZA34eMtgPxAvk8lM2
         n9VaqX5UaqvL2s/HUNIPTc0dxOmfbcjQk4D218qxiaDMdDybiLPsD/qiViy+411zpsij
         wSH6kiy5W3+Mw5zVu9PbAViAMibspr91iIL7agv0jos82QL4pjSsb9Af9CUDoa5RvUi6
         bv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PPxvwTg/e/yb+Kfzl1iykhLb1sl3Cb0/2wn1AONayg=;
        b=RnC3D4p9UgtYQ4qEMtQtt7fTG75B2yYFQ+nZPG041bbs00Cf06/4IEhpm4f/Hm32j1
         DgswZSlDDN9sw9NjoO+hu+IMt3nox6BZmcWikAtE3ZuYTPMMN3naZRzP5nBEQ+GTLYQT
         084IPhvyZjy/aU3SkAYX9+CTZZakXmhqFILlJkm6pbFLOu3ls2oRJKy1zkYcAxjMFaBV
         KTt0lKAQ8hzlTIx32ar1w4Ettr4GpxM0sCGwT9MsCBi9N0SSQBed/bqXK0bQyek8zceT
         nrzrR+fCVVywsIkoTSn5BECciftELO5VcKmD9kZ3TOYK/V1Ivpqdkx3Bd/PxfsJYTh8v
         w3gg==
X-Gm-Message-State: AAQBX9eWBLxmdcxILMd86PZRs2Wq7wkS2wS9dqd5hEpptCNygQS2mjtP
        H2xh2rp/4Ym7O9xFFkCiCsGEgQ==
X-Google-Smtp-Source: AKy350Yg5lwb9zNHl4+HxZwFw8D9HrfadSwkRINjo6lLzbbyQHA3FcDc49x8wWfUxYH4Q9rNqWmm+g==
X-Received: by 2002:adf:f10f:0:b0:2e6:1b9a:8cc8 with SMTP id r15-20020adff10f000000b002e61b9a8cc8mr7008457wro.29.1680809302493;
        Thu, 06 Apr 2023 12:28:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2489321wrn.52.2023.04.06.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:28:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] regulator: qcom-rpmh: add support for pmm8654au regulators
Date:   Thu,  6 Apr 2023 21:28:10 +0200
Message-Id: <20230406192811.460888-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406192811.460888-1-brgl@bgdev.pl>
References: <20230406192811.460888-1-brgl@bgdev.pl>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

