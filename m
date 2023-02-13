Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE16694824
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBMOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBMOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:35:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA615C96
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qb15so30308878ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y99UavQ24X32/XC08lGHSHxla8tRJhstk+ojmM0a12E=;
        b=Oi9yP8WEKbaV+Z69Zfh2AKdKTBpiFqhda8+MOusWZPUhm7pGGwrnAbKFjiAZOw4Y0o
         tjFK5aKZmQyZguCzz0cgU7gGh7HeUBWv/yuro7H1nqfcjKqOPSqOc1YBzCORsemckeEf
         3Wz56xnKU9/KnEeUycoDl5GktocPcrKH2w5seUZAw3S09nxbddu8HrBCqPlTt9+6RxA/
         RLvM+qLSUVdf8N8PzVFVWqX5nb9dYvEXdCGidEBR9mxcCiUSu5k+6p9UTrnZlgDPcFlO
         FqyDHGUw7F+KVaK376YdX+40Apf0seNWW7F3UFc/Dp0C9j3ZKAYfnEKu7NePwJSktA7x
         Sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y99UavQ24X32/XC08lGHSHxla8tRJhstk+ojmM0a12E=;
        b=5hj5z5Nc4edYOF2pL36i8eP+rKY6tCDDP+NY1UCcBfDnjdEL9cOPu6Xg/o0hKUCCtB
         1kaiSrB2iUzLx9movvK2DlCELRXnzkPapsBIeka4rrx0pLmojayM6P5/3a5N50JL+WxV
         v9Hl/WCPV40N1khpZrNft9IHUIkfaryobIqd9vwtY/teruCh0NyJBfn1v//0OEKdRlYS
         +ZiNAtKSbb7PUPShnaJMPEJ8sDoPvDHgJsgJ9DOWocIVMRFOsuwEFyqHqboVmkpK7O9s
         2TZrtPuPRUjvHNt7gb8KANJZwEvft/yS6EbM/rPoWymiNdVtu/NKBPVRiUbdCQNy3ppy
         cOdg==
X-Gm-Message-State: AO0yUKWtCOWb2ZupDxdLN/xdaegk4ilu2twZs6dvoaANEyZAP6xJRDYv
        xItkdnqWUFlpVGIRDeu4JNU4TA==
X-Google-Smtp-Source: AK7set8OgYX2xWQtPxHv+wJJ0qDSHPXvCQ+CmhcQVq3lmN2gNoA3DrznhHFon1sRBohAh++kPsZEbQ==
X-Received: by 2002:a17:906:651:b0:88e:e498:109b with SMTP id t17-20020a170906065100b0088ee498109bmr23969909ejb.5.1676298932115;
        Mon, 13 Feb 2023 06:35:32 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id uz6-20020a170907118600b0088a2397cb2csm6927186ejb.143.2023.02.13.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:35:31 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] soc: qcom: rpmpd: Bring all definitions to the top
Date:   Mon, 13 Feb 2023 15:35:16 +0100
Message-Id: <20230213143524.1943754-2-konrad.dybcio@linaro.org>
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

Keep all definitions in one place in preparation for a cleanup to make
things tidier.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 111 +++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 62 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index d99a56509e33..7d9e762232ea 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -117,12 +117,58 @@ struct rpmpd_desc {
 
 static DEFINE_MUTEX(rpmpd_lock);
 
-/* mdm9607 RPM Power Domains */
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 2);
 DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 3);
+DEFINE_RPMPD_VFL(vddcx_vfl, RWCX, 0);
+DEFINE_RPMPD_VFL(vddcx_vfl, RWSC, 2);
+DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 1);
+DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 2);
+DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 2);
 DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 3);
 
+DEFINE_RPMPD_CORNER(vddgfx, SMPB, 2);
+DEFINE_RPMPD_VFC(vddgfx_vfc, SMPB, 2);
+
+DEFINE_RPMPD_PAIR(vddgx, vddgx_ao, RWGX, LEVEL, 0);
+
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, CORNER, 3);
 DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, LEVEL, 12);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 6);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 7);
 DEFINE_RPMPD_VFL(vddmx_vfl, LDOA, 12);
+DEFINE_RPMPD_VFL(vddmx_vfl, RWMX, 0);
+DEFINE_RPMPD_VFL(vddmx_vfl, RWSM, 6);
+
+DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
+DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
+
+DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
+DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
+
+DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
+DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
+
+DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
+DEFINE_RPMPD_LEVEL(vdd_ssccx, RWLC, 0);
+DEFINE_RPMPD_LEVEL(vdd_ssccx, RWSC, 0);
+DEFINE_RPMPD_VFC(vddsscx_vfc, LDOA, 26);
+DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWLC, 0);
+DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWSC, 0);
+
+DEFINE_RPMPD_LEVEL(vdd_sscmx, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_sscmx, RWSM, 0);
+DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWLM, 0);
+DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWSM, 0);
+
+/* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {
 	[MDM9607_VDDCX] =	&SMPA3_LEVEL_vddcx,
 	[MDM9607_VDDCX_AO] =	&SMPA3_LEVEL_vddcx_ao,
@@ -139,9 +185,6 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 /* msm8226 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 1);
-
 static struct rpmpd *msm8226_rpmpds[] = {
 	[MSM8226_VDDCX] =	&SMPA1_CORNER_vddcx,
 	[MSM8226_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
@@ -155,14 +198,6 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 /* msm8939 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
-
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 2);
-
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, CORNER, 3);
-
 static struct rpmpd *msm8939_rpmpds[] = {
 	[MSM8939_VDDMDCX] =	&SMPA1_CORNER_vddmd,
 	[MSM8939_VDDMDCX_AO] =	&SMPA1_CORNER_vddmd_ao,
@@ -196,12 +231,6 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 /* msm8953 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 7);
-
-DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 2);
-
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&SMPA1_LEVEL_vddmd,
 	[MSM8953_VDDMD_AO] =	&SMPA1_LEVEL_vddmd_ao,
@@ -219,11 +248,6 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 /* msm8976 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 6);
-
-DEFINE_RPMPD_VFL(vddcx_vfl, RWSC, 2);
-DEFINE_RPMPD_VFL(vddmx_vfl, RWSM, 6);
-
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&SMPA2_LEVEL_vddcx,
 	[MSM8976_VDDCX_AO] =	&SMPA2_LEVEL_vddcx_ao,
@@ -240,18 +264,14 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 /* msm8994 RPM Power domains */
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, CORNER, 2);
-/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-DEFINE_RPMPD_CORNER(vddgfx, SMPB, 2);
-
-DEFINE_RPMPD_VFC(vddgfx_vfc, SMPB, 2);
-
 static struct rpmpd *msm8994_rpmpds[] = {
 	[MSM8994_VDDCX] =	&SMPA1_CORNER_vddcx,
 	[MSM8994_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
 	[MSM8994_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
 	[MSM8994_VDDMX] =	&SMPA2_CORNER_vddmx,
 	[MSM8994_VDDMX_AO] =	&SMPA2_CORNER_vddmx_ao,
+
+	/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
 	[MSM8994_VDDGFX] =	&SMPB2_vddgfx_corner,
 	[MSM8994_VDDGFX_VFC] =	&SMPB2_vddgfx_vfc,
 };
@@ -263,10 +283,6 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 /* msm8996 RPM Power domains */
-DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
-
-DEFINE_RPMPD_VFC(vddsscx_vfc, LDOA, 26);
-
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&SMPA1_CORNER_vddcx,
 	[MSM8996_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
@@ -284,18 +300,6 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 /* msm8998 RPM Power domains */
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(vddcx_vfl, RWCX, 0);
-
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(vddmx_vfl, RWMX, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_ssccx, RWSC, 0);
-DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWSC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_sscmx, RWSM, 0);
-DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWSM, 0);
-
 static struct rpmpd *msm8998_rpmpds[] = {
 	[MSM8998_VDDCX] =		&RWCX0_LEVEL_vddcx,
 	[MSM8998_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
@@ -316,12 +320,6 @@ static const struct rpmpd_desc msm8998_desc = {
 };
 
 /* qcs404 RPM Power domains */
-DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
-DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
-DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
-
 static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] = &RWMX0_LEVEL_vddmx,
 	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
@@ -339,13 +337,6 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 /* sdm660 RPM Power domains */
-
-DEFINE_RPMPD_LEVEL(vdd_ssccx, RWLC, 0);
-DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_sscmx, RWLM, 0);
-DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWLM, 0);
-
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =		&RWCX0_LEVEL_vddcx,
 	[SDM660_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
@@ -366,9 +357,6 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 /* sm4250/6115 RPM Power domains */
-DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
-
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =		&RWCX0_LEVEL_vddcx,
 	[SM6115_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
@@ -402,7 +390,6 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-DEFINE_RPMPD_PAIR(vddgx, vddgx_ao, RWGX, LEVEL, 0);
 static struct rpmpd *sm6375_rpmpds[] = {
 	[SM6375_VDDCX] = &RWCX0_LEVEL_vddcx,
 	[SM6375_VDDCX_AO] = &RWCX0_LEVEL_vddcx_ao,
-- 
2.39.1

