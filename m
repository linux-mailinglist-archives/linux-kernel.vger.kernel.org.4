Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F1A694827
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBMOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBMOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:35:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414DA1554C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id rp23so32343475ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYUpm8s83j1JMaoZia8U7rv3a45sUyCaItwBMtwXK9M=;
        b=cpRqo80mG1G4dLySDQwRWh7OJaCW0p6ju2kwHDt9svwHb2lbuTykFovjo53rxe9fPi
         QVEqW/3kmk7p9EX2zi0t2gBGyp302YfJTQWv9h4o1EZT7l7niUp8/cMPd3VPNeo+Xfx/
         LyOSN5UIJyk6O+dWQ7Jwpuow/kuB7dmKhadZXRo/WDM3q9KjMqGtAQeWa+EwVqWyCnlW
         4wAVTV/W3RNqDuDemcSxYNFCp+0Z0lqq8PboUKkYnMozcXI94xkAGkOWsbr0KLousSNd
         aTqv5loS8MdDcwWXgQckRsMGDAlOCGGB++w/hYkYaZVYWmoQRnwAA7APnwC/nnWZ4Sje
         R+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYUpm8s83j1JMaoZia8U7rv3a45sUyCaItwBMtwXK9M=;
        b=ABPvvpBepCmh2uHWWifFqAyaGld7NZknLbd8YqCCltN3j4eIv9lMK91ekbjJL9P0/J
         GNGxsFIF6eEL+5WclbmJskMlz/Zmfl6e7vxsYFUB/ZOMqWhfSJ3In68V+BCkwRGRCL8L
         C1efcjS0aVWLykAwN5b5nZxCezGMhT5yD2jfGN8Bbnbaf6IFkxL2UvXIUzZgxzZ44CA3
         HjcZRfmtpfeD9zrOgpgwHT3lyyMLg2CcVA5WywvV6jX6NlQ8+lDTbLAq1dC50/vfOhSl
         ivHkMExEI8VI7H0EIQ7+GgF6WiEUgo8u8wXf0EWb7LzlTZSRQpkiAjkY1m9ZT02LdVwF
         b+TQ==
X-Gm-Message-State: AO0yUKV9b9s/UVPa/8HPWZJQhNVp8A7N+Hg4IF5cZZAOSRKxhbx2OhTI
        3H7ISaSTRl5teuYaA03RDR20UQ==
X-Google-Smtp-Source: AK7set+9H1YZJEyNYcnd3+6tFGk6IC7yYGS61OsVFc0CW3cDvZcU5+entOxU0AzKNhClg9cb8Cofgw==
X-Received: by 2002:a17:907:2da6:b0:8ae:f73e:233f with SMTP id gt38-20020a1709072da600b008aef73e233fmr25183429ejc.32.1676298934778;
        Mon, 13 Feb 2023 06:35:34 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id uz6-20020a170907118600b0088a2397cb2csm6927186ejb.143.2023.02.13.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:35:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] soc: qcom: rpmpd: Remove vdd* from struct names
Date:   Mon, 13 Feb 2023 15:35:18 +0100
Message-Id: <20230213143524.1943754-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
References: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
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

It's rather obvious by the characteristic of these resources that
they correspond to some voltage lines governed by RPM. Remove the
"vdd" unnecessary prefix from them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 312 +++++++++++++++++++--------------------
 1 file changed, 156 insertions(+), 156 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 8ba025c4eca3..8f145663af9a 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -117,63 +117,63 @@ struct rpmpd_desc {
 
 static DEFINE_MUTEX(rpmpd_lock);
 
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 3);
-DEFINE_RPMPD_VFL(vddcx_vfl, RWCX, 0);
-DEFINE_RPMPD_VFL(vddcx_vfl, RWSC, 2);
-DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 1);
-DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 2);
-DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 2);
-DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 3);
-
-DEFINE_RPMPD_CORNER(vddgfx, SMPB, 2);
-DEFINE_RPMPD_VFC(vddgfx_vfc, SMPB, 2);
-
-DEFINE_RPMPD_PAIR(vddgx, vddgx_ao, RWGX, LEVEL, 0);
-
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, CORNER, 3);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, LEVEL, 12);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 6);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 7);
-DEFINE_RPMPD_VFL(vddmx_vfl, LDOA, 12);
-DEFINE_RPMPD_VFL(vddmx_vfl, RWMX, 0);
-DEFINE_RPMPD_VFL(vddmx_vfl, RWSM, 6);
-
-DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
-DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
-
-DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
-DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
-
-DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
-DEFINE_RPMPD_LEVEL(vdd_ssccx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(vdd_ssccx, RWSC, 0);
-DEFINE_RPMPD_VFC(vddsscx_vfc, LDOA, 26);
-DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWLC, 0);
-DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWSC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_sscmx, RWLM, 0);
-DEFINE_RPMPD_LEVEL(vdd_sscmx, RWSM, 0);
-DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWLM, 0);
-DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWSM, 0);
+DEFINE_RPMPD_PAIR(cx, cx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, LEVEL, 2);
+DEFINE_RPMPD_PAIR(cx, cx_ao, SMPA, LEVEL, 3);
+DEFINE_RPMPD_VFL(cx_vfl, RWCX, 0);
+DEFINE_RPMPD_VFL(cx_vfl, RWSC, 2);
+DEFINE_RPMPD_VFC(cx_vfc, SMPA, 1);
+DEFINE_RPMPD_VFC(cx_vfc, SMPA, 2);
+DEFINE_RPMPD_VFL(cx_vfl, SMPA, 2);
+DEFINE_RPMPD_VFL(cx_vfl, SMPA, 3);
+
+DEFINE_RPMPD_CORNER(gfx, SMPB, 2);
+DEFINE_RPMPD_VFC(gfx_vfc, SMPB, 2);
+
+DEFINE_RPMPD_PAIR(gx, gx_ao, RWGX, LEVEL, 0);
+
+DEFINE_RPMPD_PAIR(mx, mx_ao, LDOA, CORNER, 3);
+DEFINE_RPMPD_PAIR(mx, mx_ao, LDOA, LEVEL, 12);
+DEFINE_RPMPD_PAIR(mx, mx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(mx, mx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(mx, mx_ao, SMPA, LEVEL, 6);
+DEFINE_RPMPD_PAIR(mx, mx_ao, SMPA, LEVEL, 7);
+DEFINE_RPMPD_VFL(mx_vfl, LDOA, 12);
+DEFINE_RPMPD_VFL(mx_vfl, RWMX, 0);
+DEFINE_RPMPD_VFL(mx_vfl, RWSM, 6);
+
+DEFINE_RPMPD_PAIR(md, md_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(md, md_ao, SMPA, LEVEL, 1);
+DEFINE_RPMPD_VFC(md_vfc, SMPA, 1);
+
+DEFINE_RPMPD_LEVEL(lpi_cx, RWLC, 0);
+DEFINE_RPMPD_VFL(lpicx_vfl, RWLC, 0);
+
+DEFINE_RPMPD_LEVEL(lpi_mx, RWLM, 0);
+DEFINE_RPMPD_VFL(lpimx_vfl, RWLM, 0);
+
+DEFINE_RPMPD_CORNER(sscx, LDOA, 26);
+DEFINE_RPMPD_LEVEL(ssccx, RWLC, 0);
+DEFINE_RPMPD_LEVEL(ssccx, RWSC, 0);
+DEFINE_RPMPD_VFC(sscx_vfc, LDOA, 26);
+DEFINE_RPMPD_VFL(ssccx_vfl, RWLC, 0);
+DEFINE_RPMPD_VFL(ssccx_vfl, RWSC, 0);
+
+DEFINE_RPMPD_LEVEL(sscmx, RWLM, 0);
+DEFINE_RPMPD_LEVEL(sscmx, RWSM, 0);
+DEFINE_RPMPD_VFL(sscmx_vfl, RWLM, 0);
+DEFINE_RPMPD_VFL(sscmx_vfl, RWSM, 0);
 
 /* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&SMPA3_LEVEL_vddcx,
-	[MDM9607_VDDCX_AO] =	&SMPA3_LEVEL_vddcx_ao,
-	[MDM9607_VDDCX_VFL] =	&SMPA3_vddcx_vfl,
-	[MDM9607_VDDMX] =	&LDOA12_LEVEL_vddmx,
-	[MDM9607_VDDMX_AO] =	&LDOA12_LEVEL_vddmx_ao,
-	[MDM9607_VDDMX_VFL] =	&LDOA12_vddmx_vfl,
+	[MDM9607_VDDCX] =	&SMPA3_LEVEL_cx,
+	[MDM9607_VDDCX_AO] =	&SMPA3_LEVEL_cx_ao,
+	[MDM9607_VDDCX_VFL] =	&SMPA3_cx_vfl,
+	[MDM9607_VDDMX] =	&LDOA12_LEVEL_mx,
+	[MDM9607_VDDMX_AO] =	&LDOA12_LEVEL_mx_ao,
+	[MDM9607_VDDMX_VFL] =	&LDOA12_mx_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -184,9 +184,9 @@ static const struct rpmpd_desc mdm9607_desc = {
 
 /* msm8226 RPM Power Domains */
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&SMPA1_CORNER_vddcx,
-	[MSM8226_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
-	[MSM8226_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
+	[MSM8226_VDDCX] =	&SMPA1_CORNER_cx,
+	[MSM8226_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
+	[MSM8226_VDDCX_VFC] =	&SMPA1_cx_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -197,14 +197,14 @@ static const struct rpmpd_desc msm8226_desc = {
 
 /* msm8939 RPM Power Domains */
 static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&SMPA1_CORNER_vddmd,
-	[MSM8939_VDDMDCX_AO] =	&SMPA1_CORNER_vddmd_ao,
-	[MSM8939_VDDMDCX_VFC] =	&SMPA1_vddmd_vfc,
-	[MSM8939_VDDCX] =	&SMPA2_CORNER_vddcx,
-	[MSM8939_VDDCX_AO] =	&SMPA2_CORNER_vddcx_ao,
-	[MSM8939_VDDCX_VFC] =	&SMPA2_vddcx_vfc,
-	[MSM8939_VDDMX] =	&LDOA3_CORNER_vddmx,
-	[MSM8939_VDDMX_AO] =	&LDOA3_CORNER_vddmx_ao,
+	[MSM8939_VDDMDCX] =	&SMPA1_CORNER_md,
+	[MSM8939_VDDMDCX_AO] =	&SMPA1_CORNER_md_ao,
+	[MSM8939_VDDMDCX_VFC] =	&SMPA1_md_vfc,
+	[MSM8939_VDDCX] =	&SMPA2_CORNER_cx,
+	[MSM8939_VDDCX_AO] =	&SMPA2_CORNER_cx_ao,
+	[MSM8939_VDDCX_VFC] =	&SMPA2_cx_vfc,
+	[MSM8939_VDDMX] =	&LDOA3_CORNER_mx,
+	[MSM8939_VDDMX_AO] =	&LDOA3_CORNER_mx_ao,
 };
 
 static const struct rpmpd_desc msm8939_desc = {
@@ -215,11 +215,11 @@ static const struct rpmpd_desc msm8939_desc = {
 
 /* msm8916 RPM Power Domains */
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&SMPA1_CORNER_vddcx,
-	[MSM8916_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
-	[MSM8916_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
-	[MSM8916_VDDMX] =	&LDOA3_CORNER_vddmx,
-	[MSM8916_VDDMX_AO] =	&LDOA3_CORNER_vddmx_ao,
+	[MSM8916_VDDCX] =	&SMPA1_CORNER_cx,
+	[MSM8916_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
+	[MSM8916_VDDCX_VFC] =	&SMPA1_cx_vfc,
+	[MSM8916_VDDMX] =	&LDOA3_CORNER_mx,
+	[MSM8916_VDDMX_AO] =	&LDOA3_CORNER_mx_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -230,13 +230,13 @@ static const struct rpmpd_desc msm8916_desc = {
 
 /* msm8953 RPM Power Domains */
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&SMPA1_LEVEL_vddmd,
-	[MSM8953_VDDMD_AO] =	&SMPA1_LEVEL_vddmd_ao,
-	[MSM8953_VDDCX] =	&SMPA2_LEVEL_vddcx,
-	[MSM8953_VDDCX_AO] =	&SMPA2_LEVEL_vddcx_ao,
-	[MSM8953_VDDCX_VFL] =	&SMPA2_vddcx_vfl,
-	[MSM8953_VDDMX] =	&SMPA7_LEVEL_vddmx,
-	[MSM8953_VDDMX_AO] =	&SMPA7_LEVEL_vddmx_ao,
+	[MSM8953_VDDMD] =	&SMPA1_LEVEL_md,
+	[MSM8953_VDDMD_AO] =	&SMPA1_LEVEL_md_ao,
+	[MSM8953_VDDCX] =	&SMPA2_LEVEL_cx,
+	[MSM8953_VDDCX_AO] =	&SMPA2_LEVEL_cx_ao,
+	[MSM8953_VDDCX_VFL] =	&SMPA2_cx_vfl,
+	[MSM8953_VDDMX] =	&SMPA7_LEVEL_mx,
+	[MSM8953_VDDMX_AO] =	&SMPA7_LEVEL_mx_ao,
 };
 
 static const struct rpmpd_desc msm8953_desc = {
@@ -247,12 +247,12 @@ static const struct rpmpd_desc msm8953_desc = {
 
 /* msm8976 RPM Power Domains */
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&SMPA2_LEVEL_vddcx,
-	[MSM8976_VDDCX_AO] =	&SMPA2_LEVEL_vddcx_ao,
-	[MSM8976_VDDCX_VFL] =	&RWSC2_vddcx_vfl,
-	[MSM8976_VDDMX] =	&SMPA6_LEVEL_vddmx,
-	[MSM8976_VDDMX_AO] =	&SMPA6_LEVEL_vddmx_ao,
-	[MSM8976_VDDMX_VFL] =	&RWSM6_vddmx_vfl,
+	[MSM8976_VDDCX] =	&SMPA2_LEVEL_cx,
+	[MSM8976_VDDCX_AO] =	&SMPA2_LEVEL_cx_ao,
+	[MSM8976_VDDCX_VFL] =	&RWSC2_cx_vfl,
+	[MSM8976_VDDMX] =	&SMPA6_LEVEL_mx,
+	[MSM8976_VDDMX_AO] =	&SMPA6_LEVEL_mx_ao,
+	[MSM8976_VDDMX_VFL] =	&RWSM6_mx_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -263,15 +263,15 @@ static const struct rpmpd_desc msm8976_desc = {
 
 /* msm8994 RPM Power domains */
 static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&SMPA1_CORNER_vddcx,
-	[MSM8994_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
-	[MSM8994_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
-	[MSM8994_VDDMX] =	&SMPA2_CORNER_vddmx,
-	[MSM8994_VDDMX_AO] =	&SMPA2_CORNER_vddmx_ao,
+	[MSM8994_VDDCX] =	&SMPA1_CORNER_cx,
+	[MSM8994_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
+	[MSM8994_VDDCX_VFC] =	&SMPA1_cx_vfc,
+	[MSM8994_VDDMX] =	&SMPA2_CORNER_mx,
+	[MSM8994_VDDMX_AO] =	&SMPA2_CORNER_mx_ao,
 
 	/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-	[MSM8994_VDDGFX] =	&SMPB2_vddgfx_corner,
-	[MSM8994_VDDGFX_VFC] =	&SMPB2_vddgfx_vfc,
+	[MSM8994_VDDGFX] =	&SMPB2_gfx_corner,
+	[MSM8994_VDDGFX_VFC] =	&SMPB2_gfx_vfc,
 };
 
 static const struct rpmpd_desc msm8994_desc = {
@@ -282,13 +282,13 @@ static const struct rpmpd_desc msm8994_desc = {
 
 /* msm8996 RPM Power domains */
 static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&SMPA1_CORNER_vddcx,
-	[MSM8996_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
-	[MSM8996_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
-	[MSM8996_VDDMX] =	&SMPA2_CORNER_vddmx,
-	[MSM8996_VDDMX_AO] =	&SMPA2_CORNER_vddmx_ao,
-	[MSM8996_VDDSSCX] =	&LDOA26_vddsscx_corner,
-	[MSM8996_VDDSSCX_VFC] =	&LDOA26_vddsscx_vfc,
+	[MSM8996_VDDCX] =	&SMPA1_CORNER_cx,
+	[MSM8996_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
+	[MSM8996_VDDCX_VFC] =	&SMPA1_cx_vfc,
+	[MSM8996_VDDMX] =	&SMPA2_CORNER_mx,
+	[MSM8996_VDDMX_AO] =	&SMPA2_CORNER_mx_ao,
+	[MSM8996_VDDSSCX] =	&LDOA26_sscx_corner,
+	[MSM8996_VDDSSCX_VFC] =	&LDOA26_sscx_vfc,
 };
 
 static const struct rpmpd_desc msm8996_desc = {
@@ -299,16 +299,16 @@ static const struct rpmpd_desc msm8996_desc = {
 
 /* msm8998 RPM Power domains */
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =		&RWCX0_LEVEL_vddcx,
-	[MSM8998_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
-	[MSM8998_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
-	[MSM8998_VDDMX] =		&RWMX0_LEVEL_vddmx,
-	[MSM8998_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
-	[MSM8998_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
-	[MSM8998_SSCCX] =		&RWSC0_vdd_ssccx_lvl,
-	[MSM8998_SSCCX_VFL] =		&RWSC0_vdd_ssccx_vfl,
-	[MSM8998_SSCMX] =		&RWSM0_vdd_sscmx_lvl,
-	[MSM8998_SSCMX_VFL] =		&RWSM0_vdd_sscmx_vfl,
+	[MSM8998_VDDCX] =		&RWCX0_LEVEL_cx,
+	[MSM8998_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
+	[MSM8998_VDDCX_VFL] =		&RWCX0_cx_vfl,
+	[MSM8998_VDDMX] =		&RWMX0_LEVEL_mx,
+	[MSM8998_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
+	[MSM8998_VDDMX_VFL] =		&RWMX0_mx_vfl,
+	[MSM8998_SSCCX] =		&RWSC0_ssccx_lvl,
+	[MSM8998_SSCCX_VFL] =		&RWSC0_ssccx_vfl,
+	[MSM8998_SSCMX] =		&RWSM0_sscmx_lvl,
+	[MSM8998_SSCMX_VFL] =		&RWSM0_sscmx_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -319,13 +319,13 @@ static const struct rpmpd_desc msm8998_desc = {
 
 /* qcs404 RPM Power domains */
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] = &RWMX0_LEVEL_vddmx,
-	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
-	[QCS404_VDDMX_VFL] = &RWMX0_vddmx_vfl,
-	[QCS404_LPICX] = &RWLC0_vdd_lpi_cx_lvl,
-	[QCS404_LPICX_VFL] = &RWLC0_vdd_lpicx_vfl,
-	[QCS404_LPIMX] = &RWLM0_vdd_lpi_mx_lvl,
-	[QCS404_LPIMX_VFL] = &RWLM0_vdd_lpimx_vfl,
+	[QCS404_VDDMX] = &RWMX0_LEVEL_mx,
+	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_mx_ao,
+	[QCS404_VDDMX_VFL] = &RWMX0_mx_vfl,
+	[QCS404_LPICX] = &RWLC0_lpi_cx_lvl,
+	[QCS404_LPICX_VFL] = &RWLC0_lpicx_vfl,
+	[QCS404_LPIMX] = &RWLM0_lpi_mx_lvl,
+	[QCS404_LPIMX_VFL] = &RWLM0_lpimx_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -336,16 +336,16 @@ static const struct rpmpd_desc qcs404_desc = {
 
 /* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =		&RWCX0_LEVEL_vddcx,
-	[SDM660_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
-	[SDM660_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
-	[SDM660_VDDMX] =		&RWMX0_LEVEL_vddmx,
-	[SDM660_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
-	[SDM660_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
-	[SDM660_SSCCX] =		&RWLC0_vdd_ssccx_lvl,
-	[SDM660_SSCCX_VFL] =		&RWLC0_vdd_ssccx_vfl,
-	[SDM660_SSCMX] =		&RWLM0_vdd_sscmx_lvl,
-	[SDM660_SSCMX_VFL] =		&RWLM0_vdd_sscmx_vfl,
+	[SDM660_VDDCX] =		&RWCX0_LEVEL_cx,
+	[SDM660_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
+	[SDM660_VDDCX_VFL] =		&RWCX0_cx_vfl,
+	[SDM660_VDDMX] =		&RWMX0_LEVEL_mx,
+	[SDM660_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
+	[SDM660_VDDMX_VFL] =		&RWMX0_mx_vfl,
+	[SDM660_SSCCX] =		&RWLC0_ssccx_lvl,
+	[SDM660_SSCCX_VFL] =		&RWLC0_ssccx_vfl,
+	[SDM660_SSCMX] =		&RWLM0_sscmx_lvl,
+	[SDM660_SSCMX_VFL] =		&RWLM0_sscmx_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -356,14 +356,14 @@ static const struct rpmpd_desc sdm660_desc = {
 
 /* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&RWCX0_LEVEL_vddcx,
-	[SM6115_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
-	[SM6115_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
-	[SM6115_VDDMX] =		&RWMX0_LEVEL_vddmx,
-	[SM6115_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
-	[SM6115_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
-	[SM6115_VDD_LPI_CX] =		&RWLC0_vdd_lpi_cx_lvl,
-	[SM6115_VDD_LPI_MX] =		&RWLM0_vdd_lpi_mx_lvl,
+	[SM6115_VDDCX] =		&RWCX0_LEVEL_cx,
+	[SM6115_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
+	[SM6115_VDDCX_VFL] =		&RWCX0_cx_vfl,
+	[SM6115_VDDMX] =		&RWMX0_LEVEL_mx,
+	[SM6115_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
+	[SM6115_VDDMX_VFL] =		&RWMX0_mx_vfl,
+	[SM6115_VDD_LPI_CX] =		&RWLC0_lpi_cx_lvl,
+	[SM6115_VDD_LPI_MX] =		&RWLM0_lpi_mx_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -374,12 +374,12 @@ static const struct rpmpd_desc sm6115_desc = {
 
 /* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&RWCX0_LEVEL_vddcx,
-	[SM6125_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
-	[SM6125_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
-	[SM6125_VDDMX] =		&RWMX0_LEVEL_vddmx,
-	[SM6125_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
-	[SM6125_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
+	[SM6125_VDDCX] =		&RWCX0_LEVEL_cx,
+	[SM6125_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
+	[SM6125_VDDCX_VFL] =		&RWCX0_cx_vfl,
+	[SM6125_VDDMX] =		&RWMX0_LEVEL_mx,
+	[SM6125_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
+	[SM6125_VDDMX_VFL] =		&RWMX0_mx_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -389,16 +389,16 @@ static const struct rpmpd_desc sm6125_desc = {
 };
 
 static struct rpmpd *sm6375_rpmpds[] = {
-	[SM6375_VDDCX] = &RWCX0_LEVEL_vddcx,
-	[SM6375_VDDCX_AO] = &RWCX0_LEVEL_vddcx_ao,
-	[SM6375_VDDCX_VFL] = &RWCX0_vddcx_vfl,
-	[SM6375_VDDMX] = &RWMX0_LEVEL_vddmx,
-	[SM6375_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
-	[SM6375_VDDMX_VFL] = &RWMX0_vddmx_vfl,
-	[SM6375_VDDGX] = &RWGX0_LEVEL_vddgx,
-	[SM6375_VDDGX_AO] = &RWGX0_LEVEL_vddgx_ao,
-	[SM6375_VDD_LPI_CX] = &RWLC0_vdd_lpi_cx_lvl,
-	[SM6375_VDD_LPI_MX] = &RWLM0_vdd_lpi_mx_lvl,
+	[SM6375_VDDCX] = &RWCX0_LEVEL_cx,
+	[SM6375_VDDCX_AO] = &RWCX0_LEVEL_cx_ao,
+	[SM6375_VDDCX_VFL] = &RWCX0_cx_vfl,
+	[SM6375_VDDMX] = &RWMX0_LEVEL_mx,
+	[SM6375_VDDMX_AO] = &RWMX0_LEVEL_mx_ao,
+	[SM6375_VDDMX_VFL] = &RWMX0_mx_vfl,
+	[SM6375_VDDGX] = &RWGX0_LEVEL_gx,
+	[SM6375_VDDGX_AO] = &RWGX0_LEVEL_gx_ao,
+	[SM6375_VDD_LPI_CX] = &RWLC0_lpi_cx_lvl,
+	[SM6375_VDD_LPI_MX] = &RWLM0_lpi_mx_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -408,14 +408,14 @@ static const struct rpmpd_desc sm6375_desc = {
 };
 
 static struct rpmpd *qcm2290_rpmpds[] = {
-	[QCM2290_VDDCX] = &RWCX0_LEVEL_vddcx,
-	[QCM2290_VDDCX_AO] = &RWCX0_LEVEL_vddcx_ao,
-	[QCM2290_VDDCX_VFL] = &RWCX0_vddcx_vfl,
-	[QCM2290_VDDMX] = &RWMX0_LEVEL_vddmx,
-	[QCM2290_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
-	[QCM2290_VDDMX_VFL] = &RWMX0_vddmx_vfl,
-	[QCM2290_VDD_LPI_CX] = &RWLC0_vdd_lpi_cx_lvl,
-	[QCM2290_VDD_LPI_MX] = &RWLM0_vdd_lpi_mx_lvl,
+	[QCM2290_VDDCX] = &RWCX0_LEVEL_cx,
+	[QCM2290_VDDCX_AO] = &RWCX0_LEVEL_cx_ao,
+	[QCM2290_VDDCX_VFL] = &RWCX0_cx_vfl,
+	[QCM2290_VDDMX] = &RWMX0_LEVEL_mx,
+	[QCM2290_VDDMX_AO] = &RWMX0_LEVEL_mx_ao,
+	[QCM2290_VDDMX_VFL] = &RWMX0_mx_vfl,
+	[QCM2290_VDD_LPI_CX] = &RWLC0_lpi_cx_lvl,
+	[QCM2290_VDD_LPI_MX] = &RWLM0_lpi_mx_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {
-- 
2.39.1

