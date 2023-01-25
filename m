Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92A467A93F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjAYD2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjAYD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631A22A27
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:43 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz11so44278839ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6clkojqKpjdTaUHjaFWTeevyQq9O7rhCWN1zt+L8hI=;
        b=Ma8J4Ru7nPJNUp7jJafNZhoEiwbLmo/6OvaJ6KKnKpTjxyEjk/ZuIINJOfw4q1X3Fr
         WDmWa5XWqgu5HKjTzAk9HyMQlQ0NX/ZarS0UnOaKj7aV4Dm+s/9PbJ8IgiuUqRF6WYLS
         DC8ftdAnuUYnkENnO46pVKTEsnHaWislYT6Qf6zl+BMrIAVxgot3iPzYep8mMXRu9dSX
         1ZxYwKk/6eASVx362B0Aar9qUOISTsawDa8ruignHQMa8Vufn91KWH16c6ToeOOW3r43
         hyWvE0XHFvKCMr/33eNhDM26+7uOE4KAEbai4rtaDok51tjCL5ry+VEQLdo5jGVqBeL3
         MMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6clkojqKpjdTaUHjaFWTeevyQq9O7rhCWN1zt+L8hI=;
        b=e/DvaxhJDuGBNKn7LMIOxX7MKpXIToMzSAnLROK/hLXDsLueYSeDStR+tHERkow8Ey
         +fBVN8dLuBNNhdAt4NDLBAsAc6SEaoSCLsNxI3RjgH+CmI2TroWKAUpHO+vUSYMp0e5v
         W2QMkdvdUO50YOGdoX6erX+C59nQyMJ372lkiWzaGlzGVdUD9QDPh9B2ctk4pYro6cwr
         1T8GiTPjUDHtc0VS3KPMEcV0Naxwhb1LJyuqiGaVznToeTgfD1U++Dy0drPtiOixw93I
         j7QzZpod7p+GRhlX7Vv02+SjONF/w2s00/G7VPQMZg49z8KwBk7zqrDSlfFd7/sNaBxk
         NztQ==
X-Gm-Message-State: AO0yUKWVDK/UeIgJNozUyijuiMxTZanpZGn6INjAytyufdgjeTVaOL8O
        0ciBUdZnRvr9520FAdsD77tN0A==
X-Google-Smtp-Source: AK7set8DJ/Wy76GHyZUVU9Uf8ZzXXOUS/WIojR0rCs9c2ef/plqetB7Zx3cMSirR3EY4Ei2GBK42lg==
X-Received: by 2002:a17:906:a383:b0:878:1e3b:ae43 with SMTP id k3-20020a170906a38300b008781e3bae43mr651221ejz.46.1674617261303;
        Tue, 24 Jan 2023 19:27:41 -0800 (PST)
Received: from localhost.localdomain (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1742913ejc.2.2023.01.24.19.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:27:40 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] soc: qcom: rpmpd: Move all RPMPD definitions up and sort them by name
Date:   Wed, 25 Jan 2023 04:27:27 +0100
Message-Id: <20230125032728.611640-7-konrad.dybcio@linaro.org>
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

Move all the RPMPD definitions to the top of the file and sort them
to improve maintainability and ease searching through them when
adding support for a new SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 605 ++++++++++++++++++++-------------------
 1 file changed, 304 insertions(+), 301 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 38a85a07fa67..ca4e18cb9e84 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -68,70 +68,6 @@ struct rpmpd_desc {
 
 static DEFINE_MUTEX(rpmpd_lock);
 
-static struct rpmpd cx_s3a_lvl_ao;
-static struct rpmpd cx_s3a_lvl = {
-	.pd = { .name = "vddcx", },
-	.peer = &cx_s3a_lvl_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 3,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd cx_s3a_lvl_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &cx_s3a_lvl,
-	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 3,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd cx_s3a_lvl_vfl = {
-	.pd = { .name = "vddcx_vfl", },
-	.res_type = RPMPD_SMPA,
-	.res_id = 3,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd mx_l12a_lvl_ao;
-static struct rpmpd mx_l12a_lvl = {
-	.pd = { .name = "vddmx", },
-	.peer = &mx_l12a_lvl_ao,
-	.res_type = RPMPD_LDOA,
-	.res_id = 12,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd mx_l12a_lvl_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &mx_l12a_lvl,
-	.active_only = true,
-	.res_type = RPMPD_LDOA,
-	.res_id = 12,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd mx_l12a_lvl_vfl = {
-	.pd = { .name = "vddmx_vfl", },
-	.res_type = RPMPD_LDOA,
-	.res_id = 12,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&cx_s3a_lvl,
-	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
-	[MDM9607_VDDCX_VFL] =	&cx_s3a_lvl_vfl,
-	[MDM9607_VDDMX] =		&mx_l12a_lvl,
-	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
-	[MDM9607_VDDMX_VFL] =	&mx_l12a_lvl_vfl,
-};
-
-static const struct rpmpd_desc mdm9607_desc = {
-	.rpmpds = mdm9607_rpmpds,
-	.num_pds = ARRAY_SIZE(mdm9607_rpmpds),
-	.max_state = RPM_SMD_LEVEL_TURBO,
-};
 
 static struct rpmpd cx_s1a_corner_ao;
 static struct rpmpd cx_s1a_corner = {
@@ -158,115 +94,119 @@ static struct rpmpd cx_s1a_corner_vfc = {
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&cx_s1a_corner,
-	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8226_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-};
-
-static const struct rpmpd_desc msm8226_desc = {
-	.rpmpds = msm8226_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8226_rpmpds),
-	.max_state = MAX_CORNER_RPMPD_STATE,
-};
-
-static struct rpmpd md_s1a_corner_ao;
-static struct rpmpd md_s1a_corner = {
-	.pd = { .name = "vddmd", },
-	.peer = &md_s1a_corner_ao,
+static struct rpmpd cx_s2a_corner_ao;
+static struct rpmpd cx_s2a_corner = {
+	.pd = { .name = "vddcx", },
+	.peer = &cx_s2a_corner_ao,
 	.res_type = RPMPD_SMPA,
-	.res_id = 1,
+	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd md_s1a_corner_ao = {
-	.pd = { .name = "vddmd_ao", },
-	.peer = &md_s1a_corner,
+static struct rpmpd cx_s2a_corner_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &cx_s2a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
-	.res_id = 1,
+	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd md_s1a_corner_vfc = {
-	.pd = { .name = "vddmd_vfc", },
+static struct rpmpd cx_s2a_corner_vfc = {
+	.pd = { .name = "vddcx_vfc", },
 	.res_type = RPMPD_SMPA,
-	.res_id = 1,
+	.res_id = 2,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd cx_s2a_corner_ao;
-static struct rpmpd cx_s2a_corner = {
+static struct rpmpd cx_s2a_lvl_ao;
+static struct rpmpd cx_s2a_lvl = {
 	.pd = { .name = "vddcx", },
-	.peer = &cx_s2a_corner_ao,
+	.peer = &cx_s2a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
-	.key = KEY_CORNER,
+	.key = KEY_LEVEL,
 };
 
-static struct rpmpd cx_s2a_corner_ao = {
+static struct rpmpd cx_s2a_lvl_ao = {
 	.pd = { .name = "vddcx_ao", },
-	.peer = &cx_s2a_corner,
+	.peer = &cx_s2a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
-	.key = KEY_CORNER,
+	.key = KEY_LEVEL,
 };
 
-static struct rpmpd cx_s2a_corner_vfc = {
-	.pd = { .name = "vddcx_vfc", },
+static struct rpmpd cx_s2a_lvl_vfl = {
+	.pd = { .name = "vddcx_vfl", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
-	.key = KEY_FLOOR_CORNER,
+	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd mx_l3a_corner_ao;
-static struct rpmpd mx_l3a_corner = {
-	.pd = { .name = "vddmx", },
-	.peer = &mx_l3a_corner_ao,
-	.res_type = RPMPD_LDOA,
+static struct rpmpd cx_s3a_lvl_ao;
+static struct rpmpd cx_s3a_lvl = {
+	.pd = { .name = "vddcx", },
+	.peer = &cx_s3a_lvl_ao,
+	.res_type = RPMPD_SMPA,
 	.res_id = 3,
-	.key = KEY_CORNER,
+	.key = KEY_LEVEL,
 };
 
-static struct rpmpd mx_l3a_corner_ao = {
-	.pd = { .name = "vddmx_ao", },
-	.peer = &mx_l3a_corner,
+static struct rpmpd cx_s3a_lvl_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &cx_s3a_lvl,
 	.active_only = true,
-	.res_type = RPMPD_LDOA,
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd cx_s3a_lvl_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_SMPA,
 	.res_id = 3,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd gfx_s2b_corner = {
+	.pd = { .name = "vddgfx", },
+	/* SMPC if your board has a PM8004! */
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&md_s1a_corner,
-	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
-	[MSM8939_VDDMDCX_VFC] =	&md_s1a_corner_vfc,
-	[MSM8939_VDDCX] =	&cx_s2a_corner,
-	[MSM8939_VDDCX_AO] =	&cx_s2a_corner_ao,
-	[MSM8939_VDDCX_VFC] =	&cx_s2a_corner_vfc,
-	[MSM8939_VDDMX] =	&mx_l3a_corner,
-	[MSM8939_VDDMX_AO] =	&mx_l3a_corner_ao,
+static struct rpmpd gfx_s2b_corner_vfc = {
+	.pd = { .name = "vddgfx_vfc", },
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_FLOOR_CORNER,
 };
 
-static const struct rpmpd_desc msm8939_desc = {
-	.rpmpds = msm8939_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8939_rpmpds),
-	.max_state = MAX_CORNER_RPMPD_STATE,
+static struct rpmpd md_s1a_corner_ao;
+static struct rpmpd md_s1a_corner = {
+	.pd = { .name = "vddmd", },
+	.peer = &md_s1a_corner_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
 };
 
-static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&cx_s1a_corner,
-	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8916_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-	[MSM8916_VDDMX] =	&mx_l3a_corner,
-	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
+static struct rpmpd md_s1a_corner_ao = {
+	.pd = { .name = "vddmd_ao", },
+	.peer = &md_s1a_corner,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
 };
 
-static const struct rpmpd_desc msm8916_desc = {
-	.rpmpds = msm8916_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8916_rpmpds),
-	.max_state = MAX_CORNER_RPMPD_STATE,
+static struct rpmpd md_s1a_corner_vfc = {
+	.pd = { .name = "vddmd_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
 };
 
 static struct rpmpd md_s1a_lvl_ao;
@@ -287,63 +227,40 @@ static struct rpmpd md_s1a_lvl_ao = {
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd cx_s2a_lvl_ao;
-static struct rpmpd cx_s2a_lvl = {
-	.pd = { .name = "vddcx", },
-	.peer = &cx_s2a_lvl_ao,
-	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_LEVEL,
+static struct rpmpd mx_l3a_corner_ao;
+static struct rpmpd mx_l3a_corner = {
+	.pd = { .name = "vddmx", },
+	.peer = &mx_l3a_corner_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
 };
 
-static struct rpmpd cx_s2a_lvl_ao = {
-	.pd = { .name = "vddcx_ao", },
-	.peer = &cx_s2a_lvl,
+static struct rpmpd mx_l3a_corner_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &mx_l3a_corner,
 	.active_only = true,
-	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_LEVEL,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
 };
 
-static struct rpmpd mx_s7a_lvl_ao;
-static struct rpmpd mx_s7a_lvl = {
+static struct rpmpd mx_s2a_corner_ao;
+static struct rpmpd mx_s2a_corner = {
 	.pd = { .name = "vddmx", },
-	.peer = &mx_s7a_lvl_ao,
+	.peer = &mx_s2a_corner_ao,
 	.res_type = RPMPD_SMPA,
-	.res_id = 7,
-	.key = KEY_LEVEL,
+	.res_id = 2,
+	.key = KEY_CORNER,
 };
 
-static struct rpmpd mx_s7a_lvl_ao = {
+static struct rpmpd mx_s2a_corner_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &mx_s7a_lvl,
+	.peer = &mx_s2a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
-	.res_id = 7,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd cx_s2a_lvl_vfl = {
-	.pd = { .name = "vddcx_vfl", },
-	.res_type = RPMPD_SMPA,
 	.res_id = 2,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&md_s1a_lvl,
-	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
-	[MSM8953_VDDCX] =	&cx_s2a_lvl,
-	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8953_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
-	[MSM8953_VDDMX] =	&mx_s7a_lvl,
-	[MSM8953_VDDMX_AO] =	&mx_s7a_lvl_ao,
-};
-
-static const struct rpmpd_desc msm8953_desc = {
-	.rpmpds = msm8953_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8953_rpmpds),
-	.max_state = RPM_SMD_LEVEL_TURBO,
+	.key = KEY_CORNER,
 };
 
 static struct rpmpd mx_s6a_lvl_ao;
@@ -371,98 +288,47 @@ static struct rpmpd mx_s6a_lvl_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&cx_s2a_lvl,
-	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8976_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
-	[MSM8976_VDDMX] =	&mx_s6a_lvl,
-	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
-	[MSM8976_VDDMX_VFL] =	&mx_s6a_lvl_vfl,
-};
-
-static const struct rpmpd_desc msm8976_desc = {
-	.rpmpds = msm8976_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8976_rpmpds),
-	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
-};
-
-static struct rpmpd mx_s2a_corner_ao;
-static struct rpmpd mx_s2a_corner = {
+static struct rpmpd mx_s7a_lvl_ao;
+static struct rpmpd mx_s7a_lvl = {
 	.pd = { .name = "vddmx", },
-	.peer = &mx_s2a_corner_ao,
+	.peer = &mx_s7a_lvl_ao,
 	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_CORNER,
+	.res_id = 7,
+	.key = KEY_LEVEL,
 };
 
-static struct rpmpd mx_s2a_corner_ao = {
+static struct rpmpd mx_s7a_lvl_ao = {
 	.pd = { .name = "vddmx_ao", },
-	.peer = &mx_s2a_corner,
+	.peer = &mx_s7a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
-	.res_id = 2,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd gfx_s2b_corner = {
-	.pd = { .name = "vddgfx", },
-	/* SMPC if your board has a PM8004! */
-	.res_type = RPMPD_SMPB,
-	.res_id = 2,
-	.key = KEY_CORNER,
-};
-
-static struct rpmpd gfx_s2b_corner_vfc = {
-	.pd = { .name = "vddgfx_vfc", },
-	.res_type = RPMPD_SMPB,
-	.res_id = 2,
-	.key = KEY_FLOOR_CORNER,
-};
-
-static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&cx_s1a_corner,
-	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8994_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-	[MSM8994_VDDMX] =	&mx_s2a_corner,
-	[MSM8994_VDDMX_AO] =	&mx_s2a_corner_ao,
-	[MSM8994_VDDGFX] =	&gfx_s2b_corner,
-	[MSM8994_VDDGFX_VFC] =	&gfx_s2b_corner_vfc,
-};
-
-static const struct rpmpd_desc msm8994_desc = {
-	.rpmpds = msm8994_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8994_rpmpds),
-	.max_state = MAX_CORNER_RPMPD_STATE,
-};
-
-static struct rpmpd sscx_l26a_corner = {
-	.pd = { .name = "vddsscx", },
-	.res_type = RPMPD_LDOA,
-	.res_id = 26,
-	.key = KEY_CORNER,
+	.res_id = 7,
+	.key = KEY_LEVEL,
 };
 
-static struct rpmpd sscx_l26a_corner_vfc = {
-	.pd = { .name = "vddsscx_vfc", },
+static struct rpmpd mx_l12a_lvl_ao;
+static struct rpmpd mx_l12a_lvl = {
+	.pd = { .name = "vddmx", },
+	.peer = &mx_l12a_lvl_ao,
 	.res_type = RPMPD_LDOA,
-	.res_id = 26,
-	.key = KEY_FLOOR_CORNER,
+	.res_id = 12,
+	.key = KEY_LEVEL,
 };
 
-static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&cx_s1a_corner,
-	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8996_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-	[MSM8996_VDDMX] =	&mx_s2a_corner,
-	[MSM8996_VDDMX_AO] =	&mx_s2a_corner_ao,
-	[MSM8996_VDDSSCX] =	&sscx_l26a_corner,
-	[MSM8996_VDDSSCX_VFC] =	&sscx_l26a_corner_vfc,
+static struct rpmpd mx_l12a_lvl_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &mx_l12a_lvl,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_LEVEL,
 };
 
-static const struct rpmpd_desc msm8996_desc = {
-	.rpmpds = msm8996_rpmpds,
-	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
-	.max_state = MAX_CORNER_RPMPD_STATE,
+static struct rpmpd mx_l12a_lvl_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_FLOOR_LEVEL,
 };
 
 static struct rpmpd rwcx0_lvl_ao;
@@ -490,6 +356,56 @@ static struct rpmpd rwcx0_lvl_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
+static struct rpmpd rwmx0_lvl;
+static struct rpmpd rwmx0_lvl_ao;
+static struct rpmpd rwgx0_lvl_ao_w_rwmx0_parent;
+static struct rpmpd rwgx0_lvl_w_rwmx0_parent = {
+	.pd = {	.name = "vddgx", },
+	.peer = &rwgx0_lvl_ao_w_rwmx0_parent,
+	.parent = &rwmx0_lvl.pd,
+	.res_type = RPMPD_RWGX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd rwgx0_lvl_ao_w_rwmx0_parent = {
+	.pd = {	.name = "vddgx_ao", },
+	.peer = &rwgx0_lvl_w_rwmx0_parent,
+	.parent = &rwmx0_lvl_ao.pd,
+	.active_only = true,
+	.res_type = RPMPD_RWGX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd rwlc0_lvl = {
+	.pd = { .name = "vdd_lpi_cx", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd rwlm0_lvl = {
+	.pd = { .name = "vdd_lpi_mx", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd rwlc0_lvl_vfl = {
+	.pd = { .name = "vdd_lpicx_vfl", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd rwlm0_lvl_vfl = {
+	.pd = { .name = "vdd_lpimx_vfl", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
 static struct rpmpd rwmx0_lvl_ao;
 static struct rpmpd rwmx0_lvl = {
 	.pd = { .name = "vddmx", },
@@ -543,6 +459,141 @@ static struct rpmpd rwsm0_lvl_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
+static struct rpmpd sscx_l26a_corner = {
+	.pd = { .name = "vddsscx", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 26,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd sscx_l26a_corner_vfc = {
+	.pd = { .name = "vddsscx_vfc", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 26,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd *mdm9607_rpmpds[] = {
+	[MDM9607_VDDCX] =	&cx_s3a_lvl,
+	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
+	[MDM9607_VDDCX_VFL] =	&cx_s3a_lvl_vfl,
+	[MDM9607_VDDMX] =		&mx_l12a_lvl,
+	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
+	[MDM9607_VDDMX_VFL] =	&mx_l12a_lvl_vfl,
+};
+
+static const struct rpmpd_desc mdm9607_desc = {
+	.rpmpds = mdm9607_rpmpds,
+	.num_pds = ARRAY_SIZE(mdm9607_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
+static struct rpmpd *msm8226_rpmpds[] = {
+	[MSM8226_VDDCX] =	&cx_s1a_corner,
+	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8226_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+};
+
+static const struct rpmpd_desc msm8226_desc = {
+	.rpmpds = msm8226_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8226_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
+static struct rpmpd *msm8939_rpmpds[] = {
+	[MSM8939_VDDMDCX] =	&md_s1a_corner,
+	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
+	[MSM8939_VDDMDCX_VFC] =	&md_s1a_corner_vfc,
+	[MSM8939_VDDCX] =	&cx_s2a_corner,
+	[MSM8939_VDDCX_AO] =	&cx_s2a_corner_ao,
+	[MSM8939_VDDCX_VFC] =	&cx_s2a_corner_vfc,
+	[MSM8939_VDDMX] =	&mx_l3a_corner,
+	[MSM8939_VDDMX_AO] =	&mx_l3a_corner_ao,
+};
+
+static const struct rpmpd_desc msm8939_desc = {
+	.rpmpds = msm8939_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8939_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
+static struct rpmpd *msm8916_rpmpds[] = {
+	[MSM8916_VDDCX] =	&cx_s1a_corner,
+	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8916_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8916_VDDMX] =	&mx_l3a_corner,
+	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
+};
+
+static const struct rpmpd_desc msm8916_desc = {
+	.rpmpds = msm8916_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8916_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
+static struct rpmpd *msm8953_rpmpds[] = {
+	[MSM8953_VDDMD] =	&md_s1a_lvl,
+	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
+	[MSM8953_VDDCX] =	&cx_s2a_lvl,
+	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8953_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
+	[MSM8953_VDDMX] =	&mx_s7a_lvl,
+	[MSM8953_VDDMX_AO] =	&mx_s7a_lvl_ao,
+};
+
+static const struct rpmpd_desc msm8953_desc = {
+	.rpmpds = msm8953_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8953_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
+static struct rpmpd *msm8976_rpmpds[] = {
+	[MSM8976_VDDCX] =	&cx_s2a_lvl,
+	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8976_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
+	[MSM8976_VDDMX] =	&mx_s6a_lvl,
+	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
+	[MSM8976_VDDMX_VFL] =	&mx_s6a_lvl_vfl,
+};
+
+static const struct rpmpd_desc msm8976_desc = {
+	.rpmpds = msm8976_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8976_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
+};
+
+static struct rpmpd *msm8994_rpmpds[] = {
+	[MSM8994_VDDCX] =	&cx_s1a_corner,
+	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8994_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8994_VDDMX] =	&mx_s2a_corner,
+	[MSM8994_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[MSM8994_VDDGFX] =	&gfx_s2b_corner,
+	[MSM8994_VDDGFX_VFC] =	&gfx_s2b_corner_vfc,
+};
+
+static const struct rpmpd_desc msm8994_desc = {
+	.rpmpds = msm8994_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8994_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
+static struct rpmpd *msm8996_rpmpds[] = {
+	[MSM8996_VDDCX] =	&cx_s1a_corner,
+	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8996_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8996_VDDMX] =	&mx_s2a_corner,
+	[MSM8996_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[MSM8996_VDDSSCX] =	&sscx_l26a_corner,
+	[MSM8996_VDDSSCX_VFC] =	&sscx_l26a_corner_vfc,
+};
+
+static const struct rpmpd_desc msm8996_desc = {
+	.rpmpds = msm8996_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
 static struct rpmpd *msm8998_rpmpds[] = {
 	[MSM8998_VDDCX] =		&rwcx0_lvl,
 	[MSM8998_VDDCX_AO] =		&rwcx0_lvl_ao,
@@ -562,34 +613,6 @@ static const struct rpmpd_desc msm8998_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-static struct rpmpd rwlc0_lvl = {
-	.pd = { .name = "vdd_lpi_cx", },
-	.res_type = RPMPD_RWLC,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd rwlm0_lvl = {
-	.pd = { .name = "vdd_lpi_mx", },
-	.res_type = RPMPD_RWLM,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd rwlc0_lvl_vfl = {
-	.pd = { .name = "vdd_lpicx_vfl", },
-	.res_type = RPMPD_RWLC,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
-static struct rpmpd rwlm0_lvl_vfl = {
-	.pd = { .name = "vdd_lpimx_vfl", },
-	.res_type = RPMPD_RWLM,
-	.res_id = 0,
-	.key = KEY_FLOOR_LEVEL,
-};
-
 static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] = &rwmx0_lvl,
 	[QCS404_VDDMX_AO] = &rwmx0_lvl_ao,
@@ -657,26 +680,6 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-static struct rpmpd rwgx0_lvl_ao_w_rwmx0_parent;
-static struct rpmpd rwgx0_lvl_w_rwmx0_parent = {
-	.pd = {	.name = "vddgx", },
-	.peer = &rwgx0_lvl_ao_w_rwmx0_parent,
-	.parent = &rwmx0_lvl.pd,
-	.res_type = RPMPD_RWGX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
-static struct rpmpd rwgx0_lvl_ao_w_rwmx0_parent = {
-	.pd = {	.name = "vddgx_ao", },
-	.peer = &rwgx0_lvl_w_rwmx0_parent,
-	.parent = &rwmx0_lvl_ao.pd,
-	.active_only = true,
-	.res_type = RPMPD_RWGX,
-	.res_id = 0,
-	.key = KEY_LEVEL,
-};
-
 static struct rpmpd *sm6375_rpmpds[] = {
 	[SM6375_VDDCX] = &rwcx0_lvl,
 	[SM6375_VDDCX_AO] = &rwcx0_lvl_ao,
-- 
2.39.1

