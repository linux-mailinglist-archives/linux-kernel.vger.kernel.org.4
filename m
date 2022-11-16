Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4C62BB45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiKPLR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiKPLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:17:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E75BD4A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:05:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so29179162wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+SkcKGspAYQt+/CY2bmF3YU2t1yMvMelOrYVcZNY1M=;
        b=ukNHNdDSwn4dcMd1YAPNo7SI3QXUSMTVuIUehmNwuePjNCYaDYNkXKR6v77gf3Wc5A
         R54JuNW1RQ4997oU0EMjkgU7/zg7HgNPrJcD4nUKh8AwM3luDN23LnGLUOluBJa7EYBn
         tlzMbatu1bjae1cYe8Ne1/zrsWCQacBvv5arxrs1nPqYXzm9tpzkY2r9KurQeAa6/f4m
         KEns68uLlnRm2Tu8ubSDoueXTAnRVvQSCFXNjbw4+pJoRg4ITk6gSZYfvnjrB8CUs7vN
         Qxk699o/rNNOqKjbWB+neXMEu556N2igYaKk/Bj5ufW1rftljrOsTV2yVB8ZyZ8iUuNx
         bd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+SkcKGspAYQt+/CY2bmF3YU2t1yMvMelOrYVcZNY1M=;
        b=PWm3l9OMDjUvGcYCZpaAPqxy6wUJiuaihEnvNX11HF5NUaTGneyHl+NMTJtCUh3V+W
         Z9s+s7ks+umNrHpnsVysBFKcqQ1uUGVwwnOlBMjkcyMB443gKkMFMXgGZx3Zc/JrwLD1
         vHJe2ld9rp+iqDoOwSkLtIaidcaF3CeGgSs4xTUoE+Zv5dLb0dL4sgzvcfyBEnspe+Ov
         fqRtjFrZpv2Za4JjjKgrmXT4L+6+8ex24vG+eh3yZRJaRE+MEjdMfzrbnNh9na3daAjC
         f1d2McgfT37Nuy9M5kggmQ9REa0mmUVF4Iw9UjNJqhzKZeJ1r1mdEVLHsgA/Iyf1UTHC
         5ynw==
X-Gm-Message-State: ANoB5pmpQj3yMnqR2YdxXdgztRnmy/3J7fren0ahPbiKmu8Ejiz+5iGu
        nKJDrjfoDXeb7qEXkoHFplrRzlUDFehFmA==
X-Google-Smtp-Source: AA0mqf7R7x+z/E6ZJtET5op5JxISLFZhn/cCxR6MajCo9fI+dnQKfBhJFpOK7qLaMTQW2zTI0g4tRw==
X-Received: by 2002:adf:f744:0:b0:22e:3e8a:80f5 with SMTP id z4-20020adff744000000b0022e3e8a80f5mr13528706wrp.144.1668596732001;
        Wed, 16 Nov 2022 03:05:32 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003cf894c05e4sm1806231wmq.22.2022.11.16.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:05:31 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] regulator: qcom-rpmh: Add support for PM8550 regulators
Date:   Wed, 16 Nov 2022 13:05:15 +0200
Message-Id: <20221116110515.2612515-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116110515.2612515-1-abel.vesa@linaro.org>
References: <20221116110515.2612515-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rpmh regulators found in PM8550 PMIC.
They contain FT-SMPS 525s, so add their configuration as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 81 +++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 4158ff126a67..42c42d17335b 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -731,6 +731,24 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
+	.n_voltages = 268,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
+	.n_voltages = 268,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -987,6 +1005,57 @@ static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,    "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo_lv, "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv, "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv, "vdd-l8-l9"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,    "vdd-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo,    "vdd-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
+	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
+	RPMH_VREG("bob2",   "bob%s2",  &pmic5_bob,     "vdd-bob2"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,   "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,   "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,   "vdd-l3"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
+	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
+	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
+	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
+	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo,   "vdd-l1"),
+	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo,   "vdd-l2"),
+	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo,   "vdd-l3"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515, "vdd-s2"),
@@ -1314,6 +1383,18 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pm8450-rpmh-regulators",
 		.data = pm8450_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8550-rpmh-regulators",
+		.data = pm8550_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8550ve-rpmh-regulators",
+		.data = pm8550ve_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8550vs-rpmh-regulators",
+		.data = pm8550vs_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8998-rpmh-regulators",
 		.data = pm8998_vreg_data,
-- 
2.34.1

