Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FA694834
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBMOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjBMOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:35:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934E1BAFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hx15so32314955ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEQZHKiyj0lPt3lYNPAK/FtlnejzIJ6PuUeF01vkYQs=;
        b=IqGiPM9FytVoDIGPQB/QF/cLp+e0dpORCk9jy1STkQ0VeRwu8cWvKgNsdqVULZgAZA
         zyrkkyQCNpXC36ryvnEbptKiMEmZ4xHDnl85GppMro/ivDJUe0DpRDsAak23fB9lnvKx
         sLvquL/5KfovuK5UfAnKcfL89fg3mwyR7FOm5bYq6U+dQYP0ZWizKlW+AMJdVgIkzq0p
         kXYdJWdIq1rMejeeuksiF3xswdqDr6OypdiW+aO2/vsdFfOZzs5fy+c4p9TJZTBZpsB8
         pjfa3UpdqHuLtTTGVWS5haqcIHF8Y18cYKmveTjBihM9IJysrhjuRWFo4yHGgiVLROZl
         il5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEQZHKiyj0lPt3lYNPAK/FtlnejzIJ6PuUeF01vkYQs=;
        b=bkBFUiVY6o5xWAQ/jQ4P0tGnR5i474UcVhdbgUwQZmC0+boYr5URtV7/PWp6+1O5Tc
         iVMhfbQF9m4vmcw8YhjvML1jWg6vuMK4K+Ys0zSVmsiRbXbD8Hb3w8fouua5opZItDFn
         SvUhIcwZPAG9RkmzQ4FC3oxqWLRgAzdqvRO0UHgIu283YVO1Jjt1A2PWbLaeviFaSyGu
         JrfazPPmnKCsC5kVE3NASWwhbZwFCkesjeaoIoFSLF36miTbvCiutP/G/VJYzoL2iV5Q
         Cb4J3Gwkhw+9GcM/LUktRY4oe7IyuLatNBY0aGhrfJmeuZpmUbFmNqsqBfXgh8cmOcPl
         wPIQ==
X-Gm-Message-State: AO0yUKXDEgqNcgdkgbAiD1gZd0gnxg1OUdZEn7ivH5FLZqbiKjZ/KtDF
        r2PIDYotx2rFxUmyy2pAkwmM3Q==
X-Google-Smtp-Source: AK7set9dhQeebRnO2yYqdVRq+EaKy56aZtaJO9jGfVxJYnOQKt4Eq3jcmfdMiiC+DDzoUtkG5feaJQ==
X-Received: by 2002:a17:907:d2a:b0:8af:ef9a:1911 with SMTP id gn42-20020a1709070d2a00b008afef9a1911mr11883444ejc.5.1676298939368;
        Mon, 13 Feb 2023 06:35:39 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id uz6-20020a170907118600b0088a2397cb2csm6927186ejb.143.2023.02.13.06.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:35:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] soc: qcom: rpmpd: Make bindings assignments consistent
Date:   Mon, 13 Feb 2023 15:35:21 +0100
Message-Id: <20230213143524.1943754-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
References: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
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

Currently the whitespace between [DT_BINDING] = &struct is all over
the place.. some SoC structs have a space, others have a tab, others
have N tabs.. Make that a single tab for everybody to keep things
coherent.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 118 +++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 695b2fc56f40..946630d82b3d 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -642,16 +642,16 @@ static const struct rpmpd_desc msm8996_desc = {
 
 /* msm8998 RPM Power domains */
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =		&cx_rwcx0_lvl,
-	[MSM8998_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[MSM8998_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[MSM8998_VDDMX] =		&mx_rwmx0_lvl,
-	[MSM8998_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[MSM8998_VDDMX_VFL] =		&mx_rwmx0_vfl,
-	[MSM8998_SSCCX] =		&ssc_cx_rwsc0_lvl,
-	[MSM8998_SSCCX_VFL] =		&ssc_cx_rwsc0_vfl,
-	[MSM8998_SSCMX] =		&ssc_mx_rwsm0_lvl,
-	[MSM8998_SSCMX_VFL] =		&ssc_mx_rwsm0_vfl,
+	[MSM8998_VDDCX] =	&cx_rwcx0_lvl,
+	[MSM8998_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[MSM8998_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[MSM8998_VDDMX] =	&mx_rwmx0_lvl,
+	[MSM8998_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[MSM8998_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[MSM8998_SSCCX] =	&ssc_cx_rwsc0_lvl,
+	[MSM8998_SSCCX_VFL] =	&ssc_cx_rwsc0_vfl,
+	[MSM8998_SSCMX] =	&ssc_mx_rwsm0_lvl,
+	[MSM8998_SSCMX_VFL] =	&ssc_mx_rwsm0_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -662,13 +662,13 @@ static const struct rpmpd_desc msm8998_desc = {
 
 /* qcs404 RPM Power domains */
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] = &mx_rwmx0_lvl,
-	[QCS404_VDDMX_AO] = &mx_rwmx0_lvl_ao,
-	[QCS404_VDDMX_VFL] = &mx_rwmx0_vfl,
-	[QCS404_LPICX] = &lpi_cx_rwlc0_lvl,
-	[QCS404_LPICX_VFL] = &lpi_cx_rwlc0_vfl,
-	[QCS404_LPIMX] = &lpi_mx_rwlm0_lvl,
-	[QCS404_LPIMX_VFL] = &lpi_mx_rwlm0_vfl,
+	[QCS404_VDDMX] =	&mx_rwmx0_lvl,
+	[QCS404_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[QCS404_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[QCS404_LPICX] =	&lpi_cx_rwlc0_lvl,
+	[QCS404_LPICX_VFL] =	&lpi_cx_rwlc0_vfl,
+	[QCS404_LPIMX] =	&lpi_mx_rwlm0_lvl,
+	[QCS404_LPIMX_VFL] =	&lpi_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -679,16 +679,16 @@ static const struct rpmpd_desc qcs404_desc = {
 
 /* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =		&cx_rwcx0_lvl,
-	[SDM660_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[SDM660_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[SDM660_VDDMX] =		&mx_rwmx0_lvl,
-	[SDM660_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[SDM660_VDDMX_VFL] =		&mx_rwmx0_vfl,
-	[SDM660_SSCCX] =		&ssc_cx_rwlc0_lvl,
-	[SDM660_SSCCX_VFL] =		&ssc_cx_rwlc0_vfl,
-	[SDM660_SSCMX] =		&ssc_mx_rwlm0_lvl,
-	[SDM660_SSCMX_VFL] =		&ssc_mx_rwlm0_vfl,
+	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
+	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SDM660_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SDM660_VDDMX] =	&mx_rwmx0_lvl,
+	[SDM660_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SDM660_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[SDM660_SSCCX] =	&ssc_cx_rwlc0_lvl,
+	[SDM660_SSCCX_VFL] =	&ssc_cx_rwlc0_vfl,
+	[SDM660_SSCMX] =	&ssc_mx_rwlm0_lvl,
+	[SDM660_SSCMX_VFL] =	&ssc_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -699,14 +699,14 @@ static const struct rpmpd_desc sdm660_desc = {
 
 /* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&cx_rwcx0_lvl,
-	[SM6115_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[SM6115_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[SM6115_VDDMX] =		&mx_rwmx0_lvl,
-	[SM6115_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[SM6115_VDDMX_VFL] =		&mx_rwmx0_vfl,
-	[SM6115_VDD_LPI_CX] =		&lpi_cx_rwlc0_lvl,
-	[SM6115_VDD_LPI_MX] =		&lpi_mx_rwlm0_lvl,
+	[SM6115_VDDCX] =	&cx_rwcx0_lvl,
+	[SM6115_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SM6115_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SM6115_VDDMX] =	&mx_rwmx0_lvl,
+	[SM6115_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SM6115_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[SM6115_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[SM6115_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -717,12 +717,12 @@ static const struct rpmpd_desc sm6115_desc = {
 
 /* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&cx_rwcx0_lvl,
-	[SM6125_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[SM6125_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[SM6125_VDDMX] =		&mx_rwmx0_lvl,
-	[SM6125_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[SM6125_VDDMX_VFL] =		&mx_rwmx0_vfl,
+	[SM6125_VDDCX] =	&cx_rwcx0_lvl,
+	[SM6125_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SM6125_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SM6125_VDDMX] =	&mx_rwmx0_lvl,
+	[SM6125_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SM6125_VDDMX_VFL] =	&mx_rwmx0_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -732,16 +732,16 @@ static const struct rpmpd_desc sm6125_desc = {
 };
 
 static struct rpmpd *sm6375_rpmpds[] = {
-	[SM6375_VDDCX] = &cx_rwcx0_lvl,
-	[SM6375_VDDCX_AO] = &cx_rwcx0_lvl_ao,
-	[SM6375_VDDCX_VFL] = &cx_rwcx0_vfl,
-	[SM6375_VDDMX] = &mx_rwmx0_lvl,
-	[SM6375_VDDMX_AO] = &mx_rwmx0_lvl_ao,
-	[SM6375_VDDMX_VFL] = &mx_rwmx0_vfl,
-	[SM6375_VDDGX] = &gx_rwgx0_lvl,
-	[SM6375_VDDGX_AO] = &gx_rwgx0_lvl_ao,
-	[SM6375_VDD_LPI_CX] = &lpi_cx_rwlc0_lvl,
-	[SM6375_VDD_LPI_MX] = &lpi_mx_rwlm0_lvl,
+	[SM6375_VDDCX] =	&cx_rwcx0_lvl,
+	[SM6375_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SM6375_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SM6375_VDDMX] =	&mx_rwmx0_lvl,
+	[SM6375_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SM6375_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[SM6375_VDDGX] =	&gx_rwgx0_lvl,
+	[SM6375_VDDGX_AO] =	&gx_rwgx0_lvl_ao,
+	[SM6375_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[SM6375_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -751,14 +751,14 @@ static const struct rpmpd_desc sm6375_desc = {
 };
 
 static struct rpmpd *qcm2290_rpmpds[] = {
-	[QCM2290_VDDCX] = &cx_rwcx0_lvl,
-	[QCM2290_VDDCX_AO] = &cx_rwcx0_lvl_ao,
-	[QCM2290_VDDCX_VFL] = &cx_rwcx0_vfl,
-	[QCM2290_VDDMX] = &mx_rwmx0_lvl,
-	[QCM2290_VDDMX_AO] = &mx_rwmx0_lvl_ao,
-	[QCM2290_VDDMX_VFL] = &mx_rwmx0_vfl,
-	[QCM2290_VDD_LPI_CX] = &lpi_cx_rwlc0_lvl,
-	[QCM2290_VDD_LPI_MX] = &lpi_mx_rwlm0_lvl,
+	[QCM2290_VDDCX] =	&cx_rwcx0_lvl,
+	[QCM2290_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[QCM2290_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[QCM2290_VDDMX] =	&mx_rwmx0_lvl,
+	[QCM2290_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[QCM2290_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[QCM2290_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[QCM2290_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {
-- 
2.39.1

