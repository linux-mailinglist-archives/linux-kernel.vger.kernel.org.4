Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3A7224FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjFEL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjFEL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:56:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D4DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:56:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso33737525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685966174; x=1688558174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkvtpUZa+WNJu/9LgV9hMES117F+4ewA0642BFfUJVw=;
        b=BAYU4aFmBg0ZyMTZNGRbL3f/Z0s5Uy8eiKthMZGFw29QHdDhc2BdwQkGLm3O0hY02Q
         Ys9ls4OwE1PFwpdx8TPaaSL4QDeWXbOVe5aheZzW/XtBAYPRXJvnxQlmEcg2ebsEEjPr
         kToYHyGW3DDTcRnCFmvW4ZxWGsSxQD8QIXfec3UyHDGvIxdzAa6u3rdBsOLLD2EcYPWu
         7hhJGgiwwAPjiGkBJSeiRis/pAtwm/YkB4zooWGt1ULMX3BNNsWsBGel5+BYKtZx3qxZ
         ncQYRBYcmvjWo+8CsXZXMb9icJo/yyj4kL1V2X+MTIfG/jsrU06whRAZA7+VNY7YcR1f
         2Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966174; x=1688558174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkvtpUZa+WNJu/9LgV9hMES117F+4ewA0642BFfUJVw=;
        b=Ii41fD/j5S3fNwo6NstRpDLgSTXG2aNo5xPbZTPUx9fBQVjY/SA0qIB7Xzi5YtNmb7
         xWQvmAEjWoKIfCEA+K5DCJ2tqV0HQUFT5ohT0wqRhrUrkG881q3RDa/0i3smpG5W+daJ
         +xf+rekkiS43+Xz4TAvJcWEq5sFGZnggEiV7SXgUf4RAhbgypjraHRuXxYsTa/E6nKdM
         rxxozhfkbbY2mzdf5xXyTR2lq5+vrLBHPqwSNQuj4QCzBtn1kkpuKMPs0s4XKnaJdWcI
         h6xsk3HUSS+2c/hv5ngprlObXxSdRJwHU7H5Ju8tGr3evegzv3L/Pz87a+PbtsDja9Px
         293g==
X-Gm-Message-State: AC+VfDysYam72NL4mjmwFM6NCR6MTKtDmtHKet6Zcy8O1tuxJ9oh4Ny3
        ENU7W7YknCNdlycOFCNSIHjB1Gua/gaXD5fd4sY=
X-Google-Smtp-Source: ACHHUZ6NZP6T00+DLX0Dq4eGhE7MGLZa7rHDq9fDuqmMsjSahFOJGidDf1eWYEJqDckwivYG+8Nmuw==
X-Received: by 2002:a1c:ed03:0:b0:3f4:1ce0:a606 with SMTP id l3-20020a1ced03000000b003f41ce0a606mr7738878wmh.1.1685966174612;
        Mon, 05 Jun 2023 04:56:14 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bc5d8000000b003f17848673fsm10631636wmk.27.2023.06.05.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:56:14 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: qcom-rpmh: Fix regulators for PM8550
Date:   Mon,  5 Jun 2023 14:56:07 +0300
Message-Id: <20230605115607.921308-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8550 uses only NLDOs 515 and the LDO 6 through 8 are low voltage
type, so fix accordingly.

Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index b0a58c62b1e2..f3b280af0773 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1057,21 +1057,21 @@ static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
 };
 
 static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
 	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,    "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo_lv, "vdd-l6-l7"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv, "vdd-l6-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv, "vdd-l8-l9"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo, "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo, "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo, "vdd-l8-l9"),
 	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,    "vdd-l1-l4-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,    "vdd-l11"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo515,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo515,    "vdd-l11"),
 	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
 	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo,    "vdd-l15"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo515,    "vdd-l15"),
 	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
 	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
 	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
@@ -1086,9 +1086,9 @@ static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
 	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
 	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
 	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,   "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,   "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,   "vdd-l3"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,   "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,   "vdd-l3"),
 	{}
 };
 
@@ -1101,9 +1101,9 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
 	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
 	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
 	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
-	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo,   "vdd-l1"),
-	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo,   "vdd-l2"),
-	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo,   "vdd-l3"),
+	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
+	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
 	{}
 };
 
-- 
2.34.1

