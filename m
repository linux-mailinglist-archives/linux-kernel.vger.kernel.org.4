Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E96229B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKILJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiKILJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:09:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD1240A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:08:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id 13so45781693ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSekvk4BBAH+HiJM42246O9iVO6lFwd+IZgG+7vdJp4=;
        b=Rqe1xMeBA6JynxVyCMfSI87NC0Lpu/E4wKvPxvTENMn2ZFUBf+wuiVtLuHsY8uaU6R
         siuZOOEQb0NrTpXKtqpIuu082Jv54Ucu0KNqLY6R576aWZDlB3cGyKLakYQLsPNNtc4o
         mEuRgJUrOAUVP9ETUrqgH2FnfqhRtPRPaKzAAT7L50R8NBGQY7y6fiAhzBcAme3ZiVFh
         RydY3iGCGkt1Ydytsx1k8otsB0QAil/57O1b4nqy8SZcLHkhqne756QOep5rKdItPQQX
         4hVo/FU4eKfjdxIDjzQZqkhQCfJLPGfFsv3D86fiafwW+RJeEvOBGCBoQet7CtdBN3kL
         5ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSekvk4BBAH+HiJM42246O9iVO6lFwd+IZgG+7vdJp4=;
        b=TU/OA/nTDOBr0aFr8FFb7C5hRUFbxliDhcB53rzEtMZQYgPh8OJWqyYFQh0qrWtBKn
         BI+NlixiIkDjcemiMvpjtID7GqfutF5PEA68uiOGRrcRxmGaBomNTfc3jEGv02btrmh2
         NXuTBweVbPo1n5gQBCwHVBcGUqoAvU3gJs1SB2YIsDF8HLuCoa8c0JDJV3eZ8+9Jc1D/
         3KrLUerTEpkGcLSG+1Xf5kYreZ6j2Y1iItNkrgrIlfK+4EV8VLRItx2E0mCmqIysKtIE
         nPHGHeTP9155yxcK0vr3mxWp2NZnV085S09VCBJg8imqUCOAstEO8B39mLBDhhCkczvl
         htIQ==
X-Gm-Message-State: ACrzQf023KRTr/qgZ5Fgt9y1eYFMksZ88hv9frbCcsDc9ntEamMK0ARz
        9tnpflWuCq5c1iYGg0zc70HfPA==
X-Google-Smtp-Source: AMsMyM7IZ7B+fbcY8mY/DeW5KRzbn3Yiddth4DgsGMv6T7EMcgc6z9nH+nMvwrQUO2jlyZ28+yVHcw==
X-Received: by 2002:a17:907:2724:b0:7ad:dc93:dff1 with SMTP id d4-20020a170907272400b007addc93dff1mr46638877ejl.134.1667992136199;
        Wed, 09 Nov 2022 03:08:56 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b007add28659b0sm5863468ejx.140.2022.11.09.03.08.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:08:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: qcom_smd: Add PMR735a regulators
Date:   Wed,  9 Nov 2022 12:08:46 +0100
Message-Id: <20221109110846.45789-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109110846.45789-1-konrad.dybcio@linaro.org>
References: <20221109110846.45789-1-konrad.dybcio@linaro.org>
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

PMR735a is already supported in the RPMH regulator driver, but
there are cases where it's bundled with SMD RPM SoCs. Port it over
to qcom_smd-regulator to enable usage in such cases.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/regulator/qcom_smd-regulator.c | 24 ++++++++++++++++++++++++
 include/linux/soc/qcom/smd-rpm.h       |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index f98168d58dce..9eaae13fd385 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -677,6 +677,15 @@ static const struct regulator_desc pm6125_ftsmps = {
 	.ops = &rpm_smps_ldo_ops,
 };
 
+static const struct regulator_desc pmic5_ftsmps520 = {
+	.linear_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 264,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 static const struct regulator_desc pms405_hfsmps3 = {
 	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
@@ -1265,6 +1274,20 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pmr735a_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPE, 1, &pmic5_ftsmps520, "vdd_s1"},
+	{ "s2", QCOM_SMD_RPM_SMPE, 2, &pmic5_ftsmps520, "vdd_s2"},
+	{ "s3", QCOM_SMD_RPM_SMPE, 3, &pms405_hfsmps3, "vdd_s3"},
+	{ "l1", QCOM_SMD_RPM_LDOE, 1, &pm660_nldo660, "vdd_l1_l2"},
+	{ "l2", QCOM_SMD_RPM_LDOE, 2, &pm660_nldo660, "vdd_l1_l2"},
+	{ "l3", QCOM_SMD_RPM_LDOE, 3, &pm660_nldo660, "vdd_l3"},
+	{ "l4", QCOM_SMD_RPM_LDOE, 4, &pm660_ht_lvpldo, "vdd_l4"},
+	{ "l5", QCOM_SMD_RPM_LDOE, 5, &pm660_nldo660, "vdd_l5_l6"},
+	{ "l6", QCOM_SMD_RPM_LDOE, 6, &pm660_nldo660, "vdd_l5_l6"},
+	{ "l7", QCOM_SMD_RPM_LDOE, 7, &pm660_pldo660, "vdd_l7_bob"},
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pms405_hfsmps3, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pms405_hfsmps3, "vdd_s2" },
@@ -1305,6 +1328,7 @@ static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
 	{ .compatible = "qcom,rpm-pmi8994-regulators", .data = &rpm_pmi8994_regulators },
 	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
+	{ .compatible = "qcom,rpm-pmr735a-regulators", .data = &rpm_pmr735a_regulators },
 	{ .compatible = "qcom,rpm-pms405-regulators", .data = &rpm_pms405_regulators },
 	{}
 };
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 3ab8c07f71c0..62de54992e49 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -19,6 +19,7 @@ struct qcom_smd_rpm;
 #define QCOM_SMD_RPM_CLK_BUF_A	0x616B6C63
 #define QCOM_SMD_RPM_LDOA	0x616f646c
 #define QCOM_SMD_RPM_LDOB	0x626F646C
+#define QCOM_SMD_RPM_LDOE	0x656f646c
 #define QCOM_SMD_RPM_RWCX	0x78637772
 #define QCOM_SMD_RPM_RWMX	0x786d7772
 #define QCOM_SMD_RPM_RWLC	0x636c7772
@@ -32,6 +33,7 @@ struct qcom_smd_rpm;
 #define QCOM_SMD_RPM_QUP_CLK	0x707571
 #define QCOM_SMD_RPM_SMPA	0x61706d73
 #define QCOM_SMD_RPM_SMPB	0x62706d73
+#define QCOM_SMD_RPM_SMPE	0x65706d73
 #define QCOM_SMD_RPM_SPDM	0x63707362
 #define QCOM_SMD_RPM_VSA	0x00617376
 #define QCOM_SMD_RPM_MMAXI_CLK	0x69786d6d
-- 
2.38.1

