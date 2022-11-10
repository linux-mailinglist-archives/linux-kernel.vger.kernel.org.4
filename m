Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B6623E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKJJRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:17:48 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02E682AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:17:47 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u2so728696ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXJcyenTe5vrVQO4BXPfziVJuW4vZr13iBtdffMSgQY=;
        b=TH8f0c9RT08oEvIJLhqIa7LuTwbjaWhcUm5EI/rPbB5bDQ42vhkN87UbVrukAeeRGB
         1CL0tR32h6X0s2EmcuOl/HiDyPnwFOUAl2uFNLNX32VrKk9y/Mc57h98TaftwvKF6hzQ
         3xRdgaEO12ll2sroV954nwT7qWECND+d0nmBEgfYkOp3qFihDcFwkg6dorrCxFgKqPjq
         V8BsyUQouyEA8utOrBlOgkNglT9u8pVtcBFxpuPzbXio9RVYUZB5f4jr/rG+rlpN1KFk
         I4OCeYoOqKtqxhM9sGRHRbPVsVuvsvRjavP8+XBEgYwQen2ybxbB31I5gb6TqPVIFfZy
         Rqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXJcyenTe5vrVQO4BXPfziVJuW4vZr13iBtdffMSgQY=;
        b=15jrl+DPtwRZoxarFwvTWI3JSngNVggMqoG1a/UymU0fpZy9WDaGun7dGMA3FSRi6F
         A7mYHQufvTfD0QshIyEACTi+fX23IXOlmuoMjBydBsWr2jOAzm98xwNDGKTH6DwQjDDR
         SVFeTCvgrgw7to4CGN5D8fibZaCMI7RO2nnUx+6bJIVL8g8N+KkSq6G0LzOg6rLTAQz4
         mA5G5oVH4+2QVmYpeSPJ8vT7Qf4m/Z9I1QBEd7x/pZzzfI6obc25uSKTGt9oHt1HItD6
         oq/0dI3qss+sDgpS95zN6Wc4Uq3pXWdTFbM24wfrVpgzs7RIo/r/hZqpWgxClmXDTlHF
         UHOw==
X-Gm-Message-State: ACrzQf1vj31WTY60jzNAMp0m6dHbM9gfFVuL0JuJSTfNdEC3gKH2yahG
        EtAeQwm2Uc0Tmqtwf8M2vmMljw==
X-Google-Smtp-Source: AMsMyM4MjOfDR5ztaydaO4hjmHxa97bEYlC7KNQ+NMoQZBLkNKrhrQVqoNDLJmBX0qcsAh+25/7YOQ==
X-Received: by 2002:a2e:b614:0:b0:277:5df:9728 with SMTP id r20-20020a2eb614000000b0027705df9728mr8115662ljn.337.1668071865942;
        Thu, 10 Nov 2022 01:17:45 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id r18-20020a2e8e32000000b00278d3123a16sm101219ljk.50.2022.11.10.01.17.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Nov 2022 01:17:45 -0800 (PST)
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
Subject: [PATCH v2 2/2] regulator: qcom_smd: Add PMR735a regulators
Date:   Thu, 10 Nov 2022 10:17:36 +0100
Message-Id: <20221110091736.3344-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221110091736.3344-1-konrad.dybcio@linaro.org>
References: <20221110091736.3344-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v1:
- Add and use pmic5_ftsmps520 in place of pms405_hfsmps3 for s3

 drivers/regulator/qcom_smd-regulator.c | 33 ++++++++++++++++++++++++++
 include/linux/soc/qcom/smd-rpm.h       |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index f98168d58dce..9f2b58458841 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -677,6 +677,24 @@ static const struct regulator_desc pm6125_ftsmps = {
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
+static const struct regulator_desc pmic5_hfsmps515 = {
+	.linear_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 236,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 static const struct regulator_desc pms405_hfsmps3 = {
 	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
@@ -1265,6 +1283,20 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pmr735a_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPE, 1, &pmic5_ftsmps520, "vdd_s1"},
+	{ "s2", QCOM_SMD_RPM_SMPE, 2, &pmic5_ftsmps520, "vdd_s2"},
+	{ "s3", QCOM_SMD_RPM_SMPE, 3, &pmic5_hfsmps515, "vdd_s3"},
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
@@ -1305,6 +1337,7 @@ static const struct of_device_id rpm_of_match[] = {
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

