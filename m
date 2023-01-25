Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92AB67A938
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjAYD1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjAYD1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:45 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A4539AB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id v6so44215382ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR995snuzFHld7ypW6pWZp9O+QjcVlZ4GzQp0k1XQaM=;
        b=Xe3ltG+FG12mg5TDSwxiKKO7zmMWfkimUkqs+Bv/yW1FIDK3NPR2ayGmlSD7Xn66ki
         h3Z3V2SJc3uf6PtlELXm5CV25Wx4LbH8D0UjJmt0m3OKmnEicFY9jspMiaFTrdDaWQ6W
         2OEtEmH4yyqubpaBOl/Pv/Mp1O1qHksGfSZJJo7XIQW2Jbos/IzAf+vKZlQk0MyZgshQ
         +3gyPdHxy43wkNLZu9WywUL7vyXgI05GvVGV5g/FMaoHf1J0AOoShJcVRcEPUAYcnXD1
         kLraNkbh4RWpoQ4oFEnTSjNRLKY0xQGo5T5hIsDhKDNBJSv/9ZXvCEgbPUAN1h6y4j8p
         2bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR995snuzFHld7ypW6pWZp9O+QjcVlZ4GzQp0k1XQaM=;
        b=SSrYdh0fI1oC0AyIFZN9Y7UbomC3LFKpkdhw8gbHOR6qDZZz9yLNgRH0/kfTxx7ds0
         Bbqs/pmiuih5epu73tMbtsljJzs6kfPRRyHmoLUPjW91H009wKRrTeN+mX4DjNitocAr
         9Ir8uowcL5cLJ6EhrjtgzbEYY/9kAa115ax96OEitbO0Au6G3VfWEQz0vefXBtn5Pc6s
         TTgtdMtDFZc6EoySz/ZCQh9t57bv8YPFqZfMqnfJXYi/udnHNmeGNT9Sb7QUksJbYOXX
         of9U5+Tn7zC0wZztnCFAIzugMQjMydU2OwNSw9z/C6ndi0vCEFj61t2ujXsdntKtyXvH
         P+Tg==
X-Gm-Message-State: AFqh2kqPMg41oXk28feqiHAmUDO1C5F44pNTyvnqVb8QkUkiQuGccGlS
        w26jno7rkW/UMU7c/WxHpxT+9g==
X-Google-Smtp-Source: AMrXdXu3yW9H7Lowtgdye5LTcvsBQrDkc5CGZFg9zHaaszW74qfTNMow/kgAPYesHL6wk8S2k4cXpA==
X-Received: by 2002:a17:907:c70f:b0:871:d04e:1df with SMTP id ty15-20020a170907c70f00b00871d04e01dfmr37912147ejc.29.1674617258142;
        Tue, 24 Jan 2023 19:27:38 -0800 (PST)
Received: from localhost.localdomain (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1742913ejc.2.2023.01.24.19.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:27:37 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] soc: qcom: rpmpd: Remove SoC names from RPMPD names
Date:   Wed, 25 Jan 2023 04:27:25 +0100
Message-Id: <20230125032728.611640-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125032728.611640-1-konrad.dybcio@linaro.org>
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
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

SoC names were used only to distinguish between defines. That made
reusing them messy and often times, the same RPM power domains were
defined multiple times. Assign descriptive, SoC-independent names to
each RPMPD description struct and remove duplicate definitions.

Bloat-o-meter results:
Total: Before=133713, After=74201, chg -44.51%

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 763 +++++++++++----------------------------
 1 file changed, 205 insertions(+), 558 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index a69182618b76..9fff40527f9e 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -69,50 +69,50 @@ struct rpmpd_desc {
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* mdm9607 RPM Power Domains */
-static struct rpmpd mdm9607_vddcx_ao;
-static struct rpmpd mdm9607_vddcx = {
+static struct rpmpd cx_s3a_lvl_ao;
+static struct rpmpd cx_s3a_lvl = {
 	.pd = { .name = "vddcx", },
-	.peer = &mdm9607_vddcx_ao,
+	.peer = &cx_s3a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 3,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd mdm9607_vddcx_ao = {
+static struct rpmpd cx_s3a_lvl_ao = {
 	.pd = { .name = "vddcx_ao", },
-	.peer = &mdm9607_vddcx,
+	.peer = &cx_s3a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 3,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd mdm9607_vddcx_vfl = {
+static struct rpmpd cx_s3a_lvl_vfl = {
 	.pd = { .name = "vddcx_vfl", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 3,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd mdm9607_vddmx_ao;
-static struct rpmpd mdm9607_vddmx = {
+static struct rpmpd mx_l12a_lvl_ao;
+static struct rpmpd mx_l12a_lvl = {
 	.pd = { .name = "vddmx", },
-	.peer = &mdm9607_vddmx_ao,
+	.peer = &mx_l12a_lvl_ao,
 	.res_type = RPMPD_LDOA,
 	.res_id = 12,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd mdm9607_vddmx_ao = {
+static struct rpmpd mx_l12a_lvl_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &mdm9607_vddmx,
+	.peer = &mx_l12a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_LDOA,
 	.res_id = 12,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd mdm9607_vddmx_vfl = {
+static struct rpmpd mx_l12a_lvl_vfl = {
 	.pd = { .name = "vddmx_vfl", },
 	.res_type = RPMPD_LDOA,
 	.res_id = 12,
@@ -120,12 +120,12 @@ static struct rpmpd mdm9607_vddmx_vfl = {
 };
 
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&mdm9607_vddcx,
-	[MDM9607_VDDCX_AO] =	&mdm9607_vddcx_ao,
-	[MDM9607_VDDCX_VFL] =	&mdm9607_vddcx_vfl,
-	[MDM9607_VDDMX] =	&mdm9607_vddmx,
-	[MDM9607_VDDMX_AO] =	&mdm9607_vddmx_ao,
-	[MDM9607_VDDMX_VFL] =	&mdm9607_vddmx_vfl,
+	[MDM9607_VDDCX] =	&cx_s3a_lvl,
+	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
+	[MDM9607_VDDCX_VFL] =	&cx_s3a_lvl_vfl,
+	[MDM9607_VDDMX] =		&mx_l12a_lvl,
+	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
+	[MDM9607_VDDMX_VFL] =	&mx_l12a_lvl_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -135,25 +135,25 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 /* msm8226 RPM Power Domains */
-static struct rpmpd msm8226_vddcx_ao;
-static struct rpmpd msm8226_vddcx = {
+static struct rpmpd cx_s1a_corner_ao;
+static struct rpmpd cx_s1a_corner = {
 	.pd = { .name = "vddcx", },
-	.peer = &msm8226_vddcx_ao,
+	.peer = &cx_s1a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8226_vddcx_ao = {
+static struct rpmpd cx_s1a_corner_ao = {
 	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8226_vddcx,
+	.peer = &cx_s1a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8226_vddcx_vfc = {
+static struct rpmpd cx_s1a_corner_vfc = {
 	.pd = { .name = "vddcx_vfc", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
@@ -161,9 +161,9 @@ static struct rpmpd msm8226_vddcx_vfc = {
 };
 
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&msm8226_vddcx,
-	[MSM8226_VDDCX_AO] =	&msm8226_vddcx_ao,
-	[MSM8226_VDDCX_VFC] =	&msm8226_vddcx_vfc,
+	[MSM8226_VDDCX] =	&cx_s1a_corner,
+	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8226_VDDCX_VFC] =	&cx_s1a_corner_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -173,68 +173,68 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 /* msm8939 RPM Power Domains */
-static struct rpmpd msm8939_vddmd_ao;
-static struct rpmpd msm8939_vddmd = {
+static struct rpmpd md_s1a_corner_ao;
+static struct rpmpd md_s1a_corner = {
 	.pd = { .name = "vddmd", },
-	.peer = &msm8939_vddmd_ao,
+	.peer = &md_s1a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8939_vddmd_ao = {
+static struct rpmpd md_s1a_corner_ao = {
 	.pd = { .name = "vddmd_ao", },
-	.peer = &msm8939_vddmd,
+	.peer = &md_s1a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8939_vddmd_vfc = {
+static struct rpmpd md_s1a_corner_vfc = {
 	.pd = { .name = "vddmd_vfc", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd msm8939_vddcx_ao;
-static struct rpmpd msm8939_vddcx = {
+static struct rpmpd cx_s2a_corner_ao;
+static struct rpmpd cx_s2a_corner = {
 	.pd = { .name = "vddcx", },
-	.peer = &msm8939_vddcx_ao,
+	.peer = &cx_s2a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8939_vddcx_ao = {
+static struct rpmpd cx_s2a_corner_ao = {
 	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8939_vddcx,
+	.peer = &cx_s2a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8939_vddcx_vfc = {
+static struct rpmpd cx_s2a_corner_vfc = {
 	.pd = { .name = "vddcx_vfc", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd msm8939_vddmx_ao;
-static struct rpmpd msm8939_vddmx = {
+static struct rpmpd mx_l3a_corner_ao;
+static struct rpmpd mx_l3a_corner = {
 	.pd = { .name = "vddmx", },
-	.peer = &msm8939_vddmx_ao,
+	.peer = &mx_l3a_corner_ao,
 	.res_type = RPMPD_LDOA,
 	.res_id = 3,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8939_vddmx_ao = {
+static struct rpmpd mx_l3a_corner_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8939_vddmx,
+	.peer = &mx_l3a_corner,
 	.active_only = true,
 	.res_type = RPMPD_LDOA,
 	.res_id = 3,
@@ -242,14 +242,14 @@ static struct rpmpd msm8939_vddmx_ao = {
 };
 
 static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&msm8939_vddmd,
-	[MSM8939_VDDMDCX_AO] =	&msm8939_vddmd_ao,
-	[MSM8939_VDDMDCX_VFC] =	&msm8939_vddmd_vfc,
-	[MSM8939_VDDCX] =	&msm8939_vddcx,
-	[MSM8939_VDDCX_AO] =	&msm8939_vddcx_ao,
-	[MSM8939_VDDCX_VFC] =	&msm8939_vddcx_vfc,
-	[MSM8939_VDDMX] =	&msm8939_vddmx,
-	[MSM8939_VDDMX_AO] =	&msm8939_vddmx_ao,
+	[MSM8939_VDDMDCX] =	&md_s1a_corner,
+	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
+	[MSM8939_VDDMDCX_VFC] =	&md_s1a_corner_vfc,
+	[MSM8939_VDDCX] =	&cx_s2a_corner,
+	[MSM8939_VDDCX_AO] =	&cx_s2a_corner_ao,
+	[MSM8939_VDDCX_VFC] =	&cx_s2a_corner_vfc,
+	[MSM8939_VDDMX] =	&mx_l3a_corner,
+	[MSM8939_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8939_desc = {
@@ -259,55 +259,12 @@ static const struct rpmpd_desc msm8939_desc = {
 };
 
 /* msm8916 RPM Power Domains */
-static struct rpmpd msm8916_vddcx_ao;
-static struct rpmpd msm8916_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &msm8916_vddcx_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8916_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8916_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8916_vddmx_ao;
-static struct rpmpd msm8916_vddmx = {
-	.pd = { .name = "vddmx", },
-	.peer = &msm8916_vddmx_ao,
-	.res_type = RPMPD_LDOA,
-	.res_id = 3,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8916_vddmx_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8916_vddmx,
-	.active_only = true,
-	.res_type = RPMPD_LDOA,
-	.res_id = 3,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8916_vddcx_vfc = {
-	.pd = { .name = "vddcx_vfc", },
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_FLOOR_CORNER,
-};
-
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&msm8916_vddcx,
-	[MSM8916_VDDCX_AO] =	&msm8916_vddcx_ao,
-	[MSM8916_VDDCX_VFC] =	&msm8916_vddcx_vfc,
-	[MSM8916_VDDMX] =	&msm8916_vddmx,
-	[MSM8916_VDDMX_AO] =	&msm8916_vddmx_ao,
+	[MSM8916_VDDCX] =	&cx_s1a_corner,
+	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8916_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8916_VDDMX] =	&mx_l3a_corner,
+	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -317,61 +274,61 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 /* msm8953 RPM Power Domains */
-static struct rpmpd msm8953_vddmd_ao;
-static struct rpmpd msm8953_vddmd = {
+static struct rpmpd md_s1a_lvl_ao;
+static struct rpmpd md_s1a_lvl = {
 	.pd = { .name = "vddmd", },
-	.peer = &msm8953_vddmd_ao,
+	.peer = &md_s1a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8953_vddmd_ao = {
+static struct rpmpd md_s1a_lvl_ao = {
 	.pd = { .name = "vddmd_ao", },
-	.peer = &msm8953_vddmd,
+	.peer = &md_s1a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8953_vddcx_ao;
-static struct rpmpd msm8953_vddcx = {
+static struct rpmpd cx_s2a_lvl_ao;
+static struct rpmpd cx_s2a_lvl = {
 	.pd = { .name = "vddcx", },
-	.peer = &msm8953_vddcx_ao,
+	.peer = &cx_s2a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8953_vddcx_ao = {
+static struct rpmpd cx_s2a_lvl_ao = {
 	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8953_vddcx,
+	.peer = &cx_s2a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8953_vddmx_ao;
-static struct rpmpd msm8953_vddmx = {
+static struct rpmpd mx_s7a_lvl_ao;
+static struct rpmpd mx_s7a_lvl = {
 	.pd = { .name = "vddmx", },
-	.peer = &msm8953_vddmx_ao,
+	.peer = &mx_s7a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 7,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8953_vddmx_ao = {
+static struct rpmpd mx_s7a_lvl_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8953_vddmx,
+	.peer = &mx_s7a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 7,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8953_vddcx_vfl = {
+static struct rpmpd cx_s2a_lvl_vfl = {
 	.pd = { .name = "vddcx_vfl", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
@@ -379,13 +336,13 @@ static struct rpmpd msm8953_vddcx_vfl = {
 };
 
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&msm8953_vddmd,
-	[MSM8953_VDDMD_AO] =	&msm8953_vddmd_ao,
-	[MSM8953_VDDCX] =	&msm8953_vddcx,
-	[MSM8953_VDDCX_AO] =	&msm8953_vddcx_ao,
-	[MSM8953_VDDCX_VFL] =	&msm8953_vddcx_vfl,
-	[MSM8953_VDDMX] =	&msm8953_vddmx,
-	[MSM8953_VDDMX_AO] =	&msm8953_vddmx_ao,
+	[MSM8953_VDDMD] =	&md_s1a_lvl,
+	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
+	[MSM8953_VDDCX] =	&cx_s2a_lvl,
+	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8953_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
+	[MSM8953_VDDMX] =	&mx_s7a_lvl,
+	[MSM8953_VDDMX_AO] =	&mx_s7a_lvl_ao,
 };
 
 static const struct rpmpd_desc msm8953_desc = {
@@ -395,50 +352,25 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 /* msm8976 RPM Power Domains */
-static struct rpmpd msm8976_vddcx_ao;
-static struct rpmpd msm8976_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &msm8976_vddcx_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd msm8976_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8976_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd msm8976_vddmx_ao;
-static struct rpmpd msm8976_vddmx = {
+static struct rpmpd mx_s6a_lvl_ao;
+static struct rpmpd mx_s6a_lvl = {
 	.pd = { .name = "vddmx", },
-	.peer = &msm8976_vddmx_ao,
+	.peer = &mx_s6a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 6,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8976_vddmx_ao = {
+static struct rpmpd mx_s6a_lvl_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8976_vddmx,
+	.peer = &mx_s6a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 6,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8976_vddcx_vfl = {
-	.pd = { .name = "vddcx_vfl", },
-	.res_type = RPMPD_RWSC,
-	.res_id = 2,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd msm8976_vddmx_vfl = {
+static struct rpmpd mx_s6a_lvl_vfl = {
 	.pd = { .name = "vddmx_vfl", },
 	.res_type = RPMPD_RWSM,
 	.res_id = 6,
@@ -446,12 +378,12 @@ static struct rpmpd msm8976_vddmx_vfl = {
 };
 
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&msm8976_vddcx,
-	[MSM8976_VDDCX_AO] =	&msm8976_vddcx_ao,
-	[MSM8976_VDDCX_VFL] =	&msm8976_vddcx_vfl,
-	[MSM8976_VDDMX] =	&msm8976_vddmx,
-	[MSM8976_VDDMX_AO] =	&msm8976_vddmx_ao,
-	[MSM8976_VDDMX_VFL] =	&msm8976_vddmx_vfl,
+	[MSM8976_VDDCX] =	&cx_s2a_lvl,
+	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8976_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
+	[MSM8976_VDDMX] =	&mx_s6a_lvl,
+	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
+	[MSM8976_VDDMX_VFL] =	&mx_s6a_lvl_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -461,43 +393,25 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 /* msm8994 RPM Power domains */
-static struct rpmpd msm8994_vddcx_ao;
-static struct rpmpd msm8994_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &msm8994_vddcx_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8994_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8994_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8994_vddmx_ao;
-static struct rpmpd msm8994_vddmx = {
+static struct rpmpd mx_s2a_corner_ao;
+static struct rpmpd mx_s2a_corner = {
 	.pd = { .name = "vddmx", },
-	.peer = &msm8994_vddmx_ao,
+	.peer = &mx_s2a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8994_vddmx_ao = {
+static struct rpmpd mx_s2a_corner_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8994_vddmx,
+	.peer = &mx_s2a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8994_vddgfx = {
+static struct rpmpd gfx_s2b_corner = {
 	.pd = { .name = "vddgfx", },
 	/* SMPC if your board has a PM8004! */
 	.res_type = RPMPD_SMPB,
@@ -505,14 +419,7 @@ static struct rpmpd msm8994_vddgfx = {
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8994_vddcx_vfc = {
-	.pd = { .name = "vddcx_vfc", },
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_FLOOR_CORNER,
-};
-
-static struct rpmpd msm8994_vddgfx_vfc = {
+static struct rpmpd gfx_s2b_corner_vfc = {
 	.pd = { .name = "vddgfx_vfc", },
 	.res_type = RPMPD_SMPB,
 	.res_id = 2,
@@ -520,13 +427,13 @@ static struct rpmpd msm8994_vddgfx_vfc = {
 };
 
 static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&msm8994_vddcx,
-	[MSM8994_VDDCX_AO] =	&msm8994_vddcx_ao,
-	[MSM8994_VDDCX_VFC] =	&msm8994_vddcx_vfc,
-	[MSM8994_VDDMX] =	&msm8994_vddmx,
-	[MSM8994_VDDMX_AO] =	&msm8994_vddmx_ao,
-	[MSM8994_VDDGFX] =	&msm8994_vddgfx,
-	[MSM8994_VDDGFX_VFC] =	&msm8994_vddgfx_vfc,
+	[MSM8994_VDDCX] =	&cx_s1a_corner,
+	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8994_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8994_VDDMX] =	&mx_s2a_corner,
+	[MSM8994_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[MSM8994_VDDGFX] =	&gfx_s2b_corner,
+	[MSM8994_VDDGFX_VFC] =	&gfx_s2b_corner_vfc,
 };
 
 static const struct rpmpd_desc msm8994_desc = {
@@ -536,57 +443,14 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 /* msm8996 RPM Power domains */
-static struct rpmpd msm8996_vddcx_ao;
-static struct rpmpd msm8996_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &msm8996_vddcx_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8996_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8996_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8996_vddmx_ao;
-static struct rpmpd msm8996_vddmx = {
-	.pd = { .name = "vddmx", },
-	.peer = &msm8996_vddmx_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8996_vddmx_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8996_vddmx,
-	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd msm8996_vddsscx = {
+static struct rpmpd sscx_l26a_corner = {
 	.pd = { .name = "vddsscx", },
 	.res_type = RPMPD_LDOA,
 	.res_id = 26,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd msm8996_vddcx_vfc = {
-	.pd = { .name = "vddcx_vfc", },
-	.res_type = RPMPD_SMPA,
-	.res_id = 1,
-	.key = KEY_FLOOR_CORNER,
-};
-
-static struct rpmpd msm8996_vddsscx_vfc = {
+static struct rpmpd sscx_l26a_corner_vfc = {
 	.pd = { .name = "vddsscx_vfc", },
 	.res_type = RPMPD_LDOA,
 	.res_id = 26,
@@ -594,13 +458,13 @@ static struct rpmpd msm8996_vddsscx_vfc = {
 };
 
 static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&msm8996_vddcx,
-	[MSM8996_VDDCX_AO] =	&msm8996_vddcx_ao,
-	[MSM8996_VDDCX_VFC] =	&msm8996_vddcx_vfc,
-	[MSM8996_VDDMX] =	&msm8996_vddmx,
-	[MSM8996_VDDMX_AO] =	&msm8996_vddmx_ao,
-	[MSM8996_VDDSSCX] =	&msm8996_vddsscx,
-	[MSM8996_VDDSSCX_VFC] =	&msm8996_vddsscx_vfc,
+	[MSM8996_VDDCX] =	&cx_s1a_corner,
+	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8996_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8996_VDDMX] =	&mx_s2a_corner,
+	[MSM8996_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[MSM8996_VDDSSCX] =	&sscx_l26a_corner,
+	[MSM8996_VDDSSCX_VFC] =	&sscx_l26a_corner_vfc,
 };
 
 static const struct rpmpd_desc msm8996_desc = {
@@ -610,78 +474,78 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 /* msm8998 RPM Power domains */
-static struct rpmpd msm8998_vddcx_ao;
-static struct rpmpd msm8998_vddcx = {
+static struct rpmpd rwcx0_lvl_ao;
+static struct rpmpd rwcx0_lvl = {
 	.pd = { .name = "vddcx", },
-	.peer = &msm8998_vddcx_ao,
+	.peer = &rwcx0_lvl_ao,
 	.res_type = RPMPD_RWCX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8998_vddcx_ao = {
+static struct rpmpd rwcx0_lvl_ao = {
 	.pd = { .name = "vddcx_ao", },
-	.peer = &msm8998_vddcx,
+	.peer = &rwcx0_lvl,
 	.active_only = true,
 	.res_type = RPMPD_RWCX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8998_vddcx_vfl = {
+static struct rpmpd rwcx0_lvl_vfl = {
 	.pd = { .name = "vddcx_vfl", },
 	.res_type = RPMPD_RWCX,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd msm8998_vddmx_ao;
-static struct rpmpd msm8998_vddmx = {
+static struct rpmpd rwmx0_lvl_ao;
+static struct rpmpd rwmx0_lvl = {
 	.pd = { .name = "vddmx", },
-	.peer = &msm8998_vddmx_ao,
+	.peer = &rwmx0_lvl_ao,
 	.res_type = RPMPD_RWMX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8998_vddmx_ao = {
+static struct rpmpd rwmx0_lvl_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &msm8998_vddmx,
+	.peer = &rwmx0_lvl,
 	.active_only = true,
 	.res_type = RPMPD_RWMX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8998_vddmx_vfl = {
+static struct rpmpd rwmx0_lvl_vfl = {
 	.pd = { .name = "vddmx_vfl", },
 	.res_type = RPMPD_RWMX,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd msm8998_vdd_ssccx = {
+static struct rpmpd rwsc0_lvl = {
 	.pd = { .name = "vdd_ssccx", },
 	.res_type = RPMPD_RWSC,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8998_vdd_ssccx_vfl = {
+static struct rpmpd rwsc0_lvl_vfl = {
 	.pd = { .name = "vdd_ssccx_vfl", },
 	.res_type = RPMPD_RWSC,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd msm8998_vdd_sscmx = {
+static struct rpmpd rwsm0_lvl = {
 	.pd = { .name = "vdd_sscmx", },
 	.res_type = RPMPD_RWSM,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd msm8998_vdd_sscmx_vfl = {
+static struct rpmpd rwsm0_lvl_vfl = {
 	.pd = { .name = "vdd_sscmx_vfl", },
 	.res_type = RPMPD_RWSM,
 	.res_id = 0,
@@ -689,16 +553,16 @@ static struct rpmpd msm8998_vdd_sscmx_vfl = {
 };
 
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =		&msm8998_vddcx,
-	[MSM8998_VDDCX_AO] =		&msm8998_vddcx_ao,
-	[MSM8998_VDDCX_VFL] =		&msm8998_vddcx_vfl,
-	[MSM8998_VDDMX] =		&msm8998_vddmx,
-	[MSM8998_VDDMX_AO] =		&msm8998_vddmx_ao,
-	[MSM8998_VDDMX_VFL] =		&msm8998_vddmx_vfl,
-	[MSM8998_SSCCX] =		&msm8998_vdd_ssccx,
-	[MSM8998_SSCCX_VFL] =		&msm8998_vdd_ssccx_vfl,
-	[MSM8998_SSCMX] =		&msm8998_vdd_sscmx,
-	[MSM8998_SSCMX_VFL] =		&msm8998_vdd_sscmx_vfl,
+	[MSM8998_VDDCX] =		&rwcx0_lvl,
+	[MSM8998_VDDCX_AO] =		&rwcx0_lvl_ao,
+	[MSM8998_VDDCX_VFL] =		&rwcx0_lvl_vfl,
+	[MSM8998_VDDMX] =		&rwmx0_lvl,
+	[MSM8998_VDDMX_AO] =		&rwmx0_lvl_ao,
+	[MSM8998_VDDMX_VFL] =		&rwmx0_lvl_vfl,
+	[MSM8998_SSCCX] =		&rwsc0_lvl,
+	[MSM8998_SSCCX_VFL] =		&rwsc0_lvl_vfl,
+	[MSM8998_SSCMX] =		&rwsm0_lvl,
+	[MSM8998_SSCMX_VFL] =		&rwsm0_lvl_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -708,53 +572,28 @@ static const struct rpmpd_desc msm8998_desc = {
 };
 
 /* qcs404 RPM Power domains */
-static struct rpmpd qcs404_vddmx_ao;
-static struct rpmpd qcs404_vddmx = {
-	.pd = { .name = "vddmx", },
-	.peer = &qcs404_vddmx_ao,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd qcs404_vddmx_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &qcs404_vddmx,
-	.active_only = true,
-	.res_type = RPMPD_RWMX,
+static struct rpmpd rwlc0_lvl = {
+	.pd = { .name = "vdd_lpi_cx", },
+	.res_type = RPMPD_RWLC,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd qcs404_vddmx_vfl = {
-	.pd = { .name = "vddmx_vfl", },
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd qcs404_vdd_lpicx = {
-	.pd = { .name = "vdd_lpicx", },
-	.res_type = RPMPD_RWLC,
+static struct rpmpd rwlm0_lvl = {
+	.pd = { .name = "vdd_lpi_mx", },
+	.res_type = RPMPD_RWLM,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd qcs404_vdd_lpicx_vfl = {
+static struct rpmpd rwlc0_lvl_vfl = {
 	.pd = { .name = "vdd_lpicx_vfl", },
 	.res_type = RPMPD_RWLC,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd qcs404_vdd_lpimx = {
-	.pd = { .name = "vdd_lpimx", },
-	.res_type = RPMPD_RWLM,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd qcs404_vdd_lpimx_vfl = {
+static struct rpmpd rwlm0_lvl_vfl = {
 	.pd = { .name = "vdd_lpimx_vfl", },
 	.res_type = RPMPD_RWLM,
 	.res_id = 0,
@@ -762,13 +601,13 @@ static struct rpmpd qcs404_vdd_lpimx_vfl = {
 };
 
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] = &qcs404_vddmx,
-	[QCS404_VDDMX_AO] = &qcs404_vddmx_ao,
-	[QCS404_VDDMX_VFL] = &qcs404_vddmx_vfl,
-	[QCS404_LPICX] = &qcs404_vdd_lpicx,
-	[QCS404_LPICX_VFL] = &qcs404_vdd_lpicx_vfl,
-	[QCS404_LPIMX] = &qcs404_vdd_lpimx,
-	[QCS404_LPIMX_VFL] = &qcs404_vdd_lpimx_vfl,
+	[QCS404_VDDMX] = &rwmx0_lvl,
+	[QCS404_VDDMX_AO] = &rwmx0_lvl_ao,
+	[QCS404_VDDMX_VFL] = &rwmx0_lvl_vfl,
+	[QCS404_LPICX] = &rwlc0_lvl,
+	[QCS404_LPICX_VFL] = &rwlc0_lvl_vfl,
+	[QCS404_LPIMX] = &rwlm0_lvl,
+	[QCS404_LPIMX_VFL] = &rwlm0_lvl_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -778,95 +617,17 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 /* sdm660 RPM Power domains */
-static struct rpmpd sdm660_vddcx_ao;
-static struct rpmpd sdm660_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &sdm660_vddcx_ao,
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sdm660_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &sdm660_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sdm660_vddcx_vfl = {
-	.pd = { .name = "vddcx_vfl", },
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd sdm660_vddmx_ao;
-static struct rpmpd sdm660_vddmx = {
-	.pd = { .name = "vddmx", },
-	.peer = &sdm660_vddmx_ao,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sdm660_vddmx_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &sdm660_vddmx,
-	.active_only = true,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sdm660_vddmx_vfl = {
-	.pd = { .name = "vddmx_vfl", },
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd sdm660_vdd_ssccx = {
-	.pd = { .name = "vdd_ssccx", },
-	.res_type = RPMPD_RWLC,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sdm660_vdd_ssccx_vfl = {
-	.pd = { .name = "vdd_ssccx_vfl", },
-	.res_type = RPMPD_RWLC,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd sdm660_vdd_sscmx = {
-	.pd = { .name = "vdd_sscmx", },
-	.res_type = RPMPD_RWLM,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sdm660_vdd_sscmx_vfl = {
-	.pd = { .name = "vdd_sscmx_vfl", },
-	.res_type = RPMPD_RWLM,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =		&sdm660_vddcx,
-	[SDM660_VDDCX_AO] =		&sdm660_vddcx_ao,
-	[SDM660_VDDCX_VFL] =		&sdm660_vddcx_vfl,
-	[SDM660_VDDMX] =		&sdm660_vddmx,
-	[SDM660_VDDMX_AO] =		&sdm660_vddmx_ao,
-	[SDM660_VDDMX_VFL] =		&sdm660_vddmx_vfl,
-	[SDM660_SSCCX] =		&sdm660_vdd_ssccx,
-	[SDM660_SSCCX_VFL] =		&sdm660_vdd_ssccx_vfl,
-	[SDM660_SSCMX] =		&sdm660_vdd_sscmx,
-	[SDM660_SSCMX_VFL] =		&sdm660_vdd_sscmx_vfl,
+	[SDM660_VDDCX] =		&rwcx0_lvl,
+	[SDM660_VDDCX_AO] =		&rwcx0_lvl_ao,
+	[SDM660_VDDCX_VFL] =		&rwcx0_lvl_vfl,
+	[SDM660_VDDMX] =		&rwmx0_lvl,
+	[SDM660_VDDMX_AO] =		&rwmx0_lvl_ao,
+	[SDM660_VDDMX_VFL] =		&rwmx0_lvl_vfl,
+	[SDM660_SSCCX] =		&rwlc0_lvl,
+	[SDM660_SSCCX_VFL] =		&rwlc0_lvl_vfl,
+	[SDM660_SSCMX] =		&rwlm0_lvl,
+	[SDM660_SSCMX_VFL] =		&rwlm0_lvl_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -876,79 +637,15 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 /* sm4250/6115 RPM Power domains */
-static struct rpmpd sm6115_vddcx_ao;
-static struct rpmpd sm6115_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &sm6115_vddcx_ao,
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6115_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &sm6115_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6115_vddcx_vfl = {
-	.pd = { .name = "vddcx_vfl", },
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd sm6115_vddmx_ao;
-static struct rpmpd sm6115_vddmx = {
-	.pd = { .name = "vddmx", },
-	.peer = &sm6115_vddmx_ao,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6115_vddmx_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &sm6115_vddmx,
-	.active_only = true,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6115_vddmx_vfl = {
-	.pd = { .name = "vddmx_vfl", },
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd sm6115_vdd_lpi_cx = {
-	.pd = { .name = "vdd_lpi_cx", },
-	.res_type = RPMPD_RWLC,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6115_vdd_lpi_mx = {
-	.pd = { .name = "vdd_lpi_mx", },
-	.res_type = RPMPD_RWLM,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&sm6115_vddcx,
-	[SM6115_VDDCX_AO] =		&sm6115_vddcx_ao,
-	[SM6115_VDDCX_VFL] =		&sm6115_vddcx_vfl,
-	[SM6115_VDDMX] =		&sm6115_vddmx,
-	[SM6115_VDDMX_AO] =		&sm6115_vddmx_ao,
-	[SM6115_VDDMX_VFL] =		&sm6115_vddmx_vfl,
-	[SM6115_VDD_LPI_CX] =		&sm6115_vdd_lpi_cx,
-	[SM6115_VDD_LPI_MX] =		&sm6115_vdd_lpi_mx,
+	[SM6115_VDDCX] =		&rwcx0_lvl,
+	[SM6115_VDDCX_AO] =		&rwcx0_lvl_ao,
+	[SM6115_VDDCX_VFL] =		&rwcx0_lvl_vfl,
+	[SM6115_VDDMX] =		&rwmx0_lvl,
+	[SM6115_VDDMX_AO] =		&rwmx0_lvl_ao,
+	[SM6115_VDDMX_VFL] =		&rwmx0_lvl_vfl,
+	[SM6115_VDD_LPI_CX] =		&rwlc0_lvl,
+	[SM6115_VDD_LPI_MX] =		&rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -958,63 +655,13 @@ static const struct rpmpd_desc sm6115_desc = {
 };
 
 /* sm6125 RPM Power domains */
-static struct rpmpd sm6125_vddcx_ao;
-static struct rpmpd sm6125_vddcx = {
-	.pd = { .name = "vddcx", },
-	.peer = &sm6125_vddcx_ao,
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6125_vddcx_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &sm6125_vddcx,
-	.active_only = true,
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6125_vddcx_vfl = {
-	.pd = { .name = "vddcx_vfl", },
-	.res_type = RPMPD_RWCX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd sm6125_vddmx_ao;
-static struct rpmpd sm6125_vddmx = {
-	.pd = { .name = "vddmx", },
-	.peer = &sm6125_vddmx_ao,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6125_vddmx_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &sm6125_vddmx,
-	.active_only = true,
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd sm6125_vddmx_vfl = {
-	.pd = { .name = "vddmx_vfl", },
-	.res_type = RPMPD_RWMX,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&sm6125_vddcx,
-	[SM6125_VDDCX_AO] =		&sm6125_vddcx_ao,
-	[SM6125_VDDCX_VFL] =		&sm6125_vddcx_vfl,
-	[SM6125_VDDMX] =		&sm6125_vddmx,
-	[SM6125_VDDMX_AO] =		&sm6125_vddmx_ao,
-	[SM6125_VDDMX_VFL] =		&sm6125_vddmx_vfl,
+	[SM6125_VDDCX] =		&rwcx0_lvl,
+	[SM6125_VDDCX_AO] =		&rwcx0_lvl_ao,
+	[SM6125_VDDCX_VFL] =		&rwcx0_lvl_vfl,
+	[SM6125_VDDMX] =		&rwmx0_lvl,
+	[SM6125_VDDMX_AO] =		&rwmx0_lvl_ao,
+	[SM6125_VDDMX_VFL] =		&rwmx0_lvl_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -1023,20 +670,20 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-static struct rpmpd sm6375_vddgx_ao;
-static struct rpmpd sm6375_vddgx = {
+static struct rpmpd rwgx0_lvl_ao_w_rwmx0_parent;
+static struct rpmpd rwgx0_lvl_w_rwmx0_parent = {
 	.pd = {	.name = "vddgx", },
-	.peer = &sm6375_vddgx_ao,
-	.parent = &sm6125_vddmx.pd,
+	.peer = &rwgx0_lvl_ao_w_rwmx0_parent,
+	.parent = &rwmx0_lvl.pd,
 	.res_type = RPMPD_RWGX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd sm6375_vddgx_ao = {
+static struct rpmpd rwgx0_lvl_ao_w_rwmx0_parent = {
 	.pd = {	.name = "vddgx_ao", },
-	.peer = &sm6375_vddgx,
-	.parent = &sm6125_vddmx_ao.pd,
+	.peer = &rwgx0_lvl_w_rwmx0_parent,
+	.parent = &rwmx0_lvl_ao.pd,
 	.active_only = true,
 	.res_type = RPMPD_RWGX,
 	.res_id = 0,
@@ -1044,16 +691,16 @@ static struct rpmpd sm6375_vddgx_ao = {
 };
 
 static struct rpmpd *sm6375_rpmpds[] = {
-	[SM6375_VDDCX] = &sm6125_vddcx,
-	[SM6375_VDDCX_AO] = &sm6125_vddcx_ao,
-	[SM6375_VDDCX_VFL] = &sm6125_vddcx_vfl,
-	[SM6375_VDDMX] = &sm6125_vddmx,
-	[SM6375_VDDMX_AO] = &sm6125_vddmx_ao,
-	[SM6375_VDDMX_VFL] = &sm6125_vddmx_vfl,
-	[SM6375_VDDGX] = &sm6375_vddgx,
-	[SM6375_VDDGX_AO] = &sm6375_vddgx_ao,
-	[SM6375_VDD_LPI_CX] = &sm6115_vdd_lpi_cx,
-	[SM6375_VDD_LPI_MX] = &sm6115_vdd_lpi_mx,
+	[SM6375_VDDCX] = &rwcx0_lvl,
+	[SM6375_VDDCX_AO] = &rwcx0_lvl_ao,
+	[SM6375_VDDCX_VFL] = &rwcx0_lvl_vfl,
+	[SM6375_VDDMX] = &rwmx0_lvl,
+	[SM6375_VDDMX_AO] = &rwmx0_lvl_ao,
+	[SM6375_VDDMX_VFL] = &rwmx0_lvl_vfl,
+	[SM6375_VDDGX] = &rwgx0_lvl_w_rwmx0_parent,
+	[SM6375_VDDGX_AO] = &rwgx0_lvl_ao_w_rwmx0_parent,
+	[SM6375_VDD_LPI_CX] = &rwlc0_lvl,
+	[SM6375_VDD_LPI_MX] = &rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -1063,14 +710,14 @@ static const struct rpmpd_desc sm6375_desc = {
 };
 
 static struct rpmpd *qcm2290_rpmpds[] = {
-	[QCM2290_VDDCX] = &sm6115_vddcx,
-	[QCM2290_VDDCX_AO] = &sm6115_vddcx_ao,
-	[QCM2290_VDDCX_VFL] = &sm6115_vddcx_vfl,
-	[QCM2290_VDDMX] = &sm6115_vddmx,
-	[QCM2290_VDDMX_AO] = &sm6115_vddmx_ao,
-	[QCM2290_VDDMX_VFL] = &sm6115_vddmx_vfl,
-	[QCM2290_VDD_LPI_CX] = &sm6115_vdd_lpi_cx,
-	[QCM2290_VDD_LPI_MX] = &sm6115_vdd_lpi_mx,
+	[QCM2290_VDDCX] = &rwcx0_lvl,
+	[QCM2290_VDDCX_AO] = &rwcx0_lvl_ao,
+	[QCM2290_VDDCX_VFL] = &rwcx0_lvl_vfl,
+	[QCM2290_VDDMX] = &rwmx0_lvl,
+	[QCM2290_VDDMX_AO] = &rwmx0_lvl_ao,
+	[QCM2290_VDDMX_VFL] = &rwmx0_lvl_vfl,
+	[QCM2290_VDD_LPI_CX] = &rwlc0_lvl,
+	[QCM2290_VDD_LPI_MX] = &rwlm0_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {
-- 
2.39.1

