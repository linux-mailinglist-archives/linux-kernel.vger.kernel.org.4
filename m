Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5A6B81FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCMUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BF738B7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s22so17197382lfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYa7z2XtiVETPeMdM39GRjzbkKKAoqW/JHuDvkeW2Fw=;
        b=QVXzdiXLhkpbyvkaPcsq1XAfFPML1LM9LL/lDm/BhX4iLlaAyQ0cYEkTMDuVS3OTcf
         svY4FmW722Yz0DOW2aVJLeiQDwjQXH4XLSs3Dd+DyxL3HxUX/GIbzVs7H8K3Ms/W/MTp
         fxDG/PNVFUUyzxfOMhd5hJGu2yh4IcZdSQZYS5DuAW/gw0C1HAomEUTyuou7snDcJ10E
         V0UpASKRR9X/NRY/kAJMADcE3J2BdKzq1vDSheGytSwA+l4NHVjzYsyXaKhNAcLzJwag
         JzdMRYitECT6R2uNazclPr+tddS6dAXqyyeDI0fYSJ3GHnrCQfCAIxO2BPdn8z8hkz56
         zGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYa7z2XtiVETPeMdM39GRjzbkKKAoqW/JHuDvkeW2Fw=;
        b=rxangQGD15Pa+x8i0FCqAXs+5LJbgXmBJ9QKSAzSEXfnq8O44VAavmbcp6XbGGMXHD
         69Q6XAFSNP+pYA5MbJd7ydRBnaktH7AUn09OzLdeLWGB3SedvQ4Y7ARQmTGrq0Gp2Xk8
         jrZOGB8IuTR8nWHdlkV93rsB+d62p6owVz/YG879p5EZAZ6gOJPjQf/RLDOszwQLuPxS
         Jse7UZDrGRnZBff5IQF0hZsTeInW8sV2AdFfOp6OoHTVNavNBmrplSmFS87qEA6A1v0F
         Gj+IiZxVYLYHcBYAHyoDidTTsKIiLnATrp7gbqpJTMagbAaZSSRe/87/mcw53s0dXCEu
         V0Nw==
X-Gm-Message-State: AO0yUKXqGjipGUYxm6bV+veiAqjmVH2KFJKMAI5VfGeIQaXfqHLNdKuN
        jF+RVlyqDbSRUk4zjloxi7EQDg==
X-Google-Smtp-Source: AK7set+YCZjlknhSTOnMlSpqRd6DRkzUNbepPpx9xaqyAPZuqevBlNoHS24OoQFLkCumKArWKrZEdg==
X-Received: by 2002:ac2:53a6:0:b0:4dd:ac1b:771b with SMTP id j6-20020ac253a6000000b004ddac1b771bmr8958325lfh.39.1678737606148;
        Mon, 13 Mar 2023 13:00:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 20:59:59 +0100
Subject: [PATCH v3 01/10] soc: qcom: rpmpd: Remove SoC names from RPMPD
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-1-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=21183;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T1PdpR+U38P+Qh4/yP20dydzi8aOhHdS9sHjLf0o5g4=;
 b=8ZgYgnuDCQLGJdzn8XpYMhwaZm2LbEeYUfKS7QLh2FWjQwS19KFFKQdqSaMEc9rJ87IAeMSLNg3B
 1iggYRtIB4N9NPWWN2N39qkiR0pQ8JpwYQ6CL7Fu2S0x6lMuQIgJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the SoC names with type+id_key (or type+id+..name..+key for
fixed-key definitions) and remove duplicate entries.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 360 +++++++++++++++++++++--------------------------
 1 file changed, 164 insertions(+), 196 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 337b1ad1cd3b..d99a56509e33 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -40,51 +40,50 @@
 
 #define MAX_CORNER_RPMPD_STATE	6
 
-#define DEFINE_RPMPD_PAIR(_platform, _name, _active, r_type, r_key,	\
-			  r_id)						\
-	static struct rpmpd _platform##_##_active;			\
-	static struct rpmpd _platform##_##_name = {			\
+#define DEFINE_RPMPD_PAIR(_name, _active, r_type, r_key, r_id)		\
+	static struct rpmpd r_type##r_id##_##r_key##_##_active;			\
+	static struct rpmpd r_type##r_id##_##r_key##_##_name = {			\
 		.pd = {	.name = #_name,	},				\
-		.peer = &_platform##_##_active,				\
+		.peer = &r_type##r_id##_##r_key##_##_active,				\
 		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_##r_key,					\
 	};								\
-	static struct rpmpd _platform##_##_active = {			\
+	static struct rpmpd r_type##r_id##_##r_key##_##_active = {			\
 		.pd = { .name = #_active, },				\
-		.peer = &_platform##_##_name,				\
+		.peer = &r_type##r_id##_##r_key##_##_name,				\
 		.active_only = true,					\
 		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_##r_key,					\
 	}
 
-#define DEFINE_RPMPD_CORNER(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
+#define DEFINE_RPMPD_CORNER(_name, r_type, r_id)			\
+	static struct rpmpd r_type##r_id##_##_name##_corner = {			\
 		.pd = { .name = #_name, },				\
 		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_CORNER,					\
 	}
 
-#define DEFINE_RPMPD_LEVEL(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
+#define DEFINE_RPMPD_LEVEL(_name, r_type, r_id)				\
+	static struct rpmpd r_type##r_id##_##_name##_lvl = {			\
 		.pd = { .name = #_name, },				\
 		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_LEVEL,					\
 	}
 
-#define DEFINE_RPMPD_VFC(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
+#define DEFINE_RPMPD_VFC(_name, r_type, r_id)				\
+	static struct rpmpd r_type##r_id##_##_name = {			\
 		.pd = { .name = #_name, },				\
 		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_FLOOR_CORNER,				\
 	}
 
-#define DEFINE_RPMPD_VFL(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
+#define DEFINE_RPMPD_VFL(_name, r_type, r_id)				\
+	static struct rpmpd r_type##r_id##_##_name = {			\
 		.pd = { .name = #_name, },				\
 		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
@@ -119,18 +118,18 @@ struct rpmpd_desc {
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* mdm9607 RPM Power Domains */
-DEFINE_RPMPD_PAIR(mdm9607, vddcx, vddcx_ao, SMPA, LEVEL, 3);
-DEFINE_RPMPD_VFL(mdm9607, vddcx_vfl, SMPA, 3);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 3);
+DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 3);
 
-DEFINE_RPMPD_PAIR(mdm9607, vddmx, vddmx_ao, LDOA, LEVEL, 12);
-DEFINE_RPMPD_VFL(mdm9607, vddmx_vfl, LDOA, 12);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, LEVEL, 12);
+DEFINE_RPMPD_VFL(vddmx_vfl, LDOA, 12);
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&mdm9607_vddcx,
-	[MDM9607_VDDCX_AO] =	&mdm9607_vddcx_ao,
-	[MDM9607_VDDCX_VFL] =	&mdm9607_vddcx_vfl,
-	[MDM9607_VDDMX] =	&mdm9607_vddmx,
-	[MDM9607_VDDMX_AO] =	&mdm9607_vddmx_ao,
-	[MDM9607_VDDMX_VFL] =	&mdm9607_vddmx_vfl,
+	[MDM9607_VDDCX] =	&SMPA3_LEVEL_vddcx,
+	[MDM9607_VDDCX_AO] =	&SMPA3_LEVEL_vddcx_ao,
+	[MDM9607_VDDCX_VFL] =	&SMPA3_vddcx_vfl,
+	[MDM9607_VDDMX] =	&LDOA12_LEVEL_vddmx,
+	[MDM9607_VDDMX_AO] =	&LDOA12_LEVEL_vddmx_ao,
+	[MDM9607_VDDMX_VFL] =	&LDOA12_vddmx_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -140,13 +139,13 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 /* msm8226 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8226, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(msm8226, vddcx_vfc, SMPA, 1);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 1);
 
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&msm8226_vddcx,
-	[MSM8226_VDDCX_AO] =	&msm8226_vddcx_ao,
-	[MSM8226_VDDCX_VFC] =	&msm8226_vddcx_vfc,
+	[MSM8226_VDDCX] =	&SMPA1_CORNER_vddcx,
+	[MSM8226_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
+	[MSM8226_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -156,23 +155,23 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 /* msm8939 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8939, vddmd, vddmd_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(msm8939, vddmd_vfc, SMPA, 1);
+DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
 
-DEFINE_RPMPD_PAIR(msm8939, vddcx, vddcx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_VFC(msm8939, vddcx_vfc, SMPA, 2);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 2);
 
-DEFINE_RPMPD_PAIR(msm8939, vddmx, vddmx_ao, LDOA, CORNER, 3);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, CORNER, 3);
 
 static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&msm8939_vddmd,
-	[MSM8939_VDDMDCX_AO] =	&msm8939_vddmd_ao,
-	[MSM8939_VDDMDCX_VFC] =	&msm8939_vddmd_vfc,
-	[MSM8939_VDDCX] =	&msm8939_vddcx,
-	[MSM8939_VDDCX_AO] =	&msm8939_vddcx_ao,
-	[MSM8939_VDDCX_VFC] =	&msm8939_vddcx_vfc,
-	[MSM8939_VDDMX] =	&msm8939_vddmx,
-	[MSM8939_VDDMX_AO] =	&msm8939_vddmx_ao,
+	[MSM8939_VDDMDCX] =	&SMPA1_CORNER_vddmd,
+	[MSM8939_VDDMDCX_AO] =	&SMPA1_CORNER_vddmd_ao,
+	[MSM8939_VDDMDCX_VFC] =	&SMPA1_vddmd_vfc,
+	[MSM8939_VDDCX] =	&SMPA2_CORNER_vddcx,
+	[MSM8939_VDDCX_AO] =	&SMPA2_CORNER_vddcx_ao,
+	[MSM8939_VDDCX_VFC] =	&SMPA2_vddcx_vfc,
+	[MSM8939_VDDMX] =	&LDOA3_CORNER_vddmx,
+	[MSM8939_VDDMX_AO] =	&LDOA3_CORNER_vddmx_ao,
 };
 
 static const struct rpmpd_desc msm8939_desc = {
@@ -182,17 +181,12 @@ static const struct rpmpd_desc msm8939_desc = {
 };
 
 /* msm8916 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8916, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(msm8916, vddmx, vddmx_ao, LDOA, CORNER, 3);
-
-DEFINE_RPMPD_VFC(msm8916, vddcx_vfc, SMPA, 1);
-
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&msm8916_vddcx,
-	[MSM8916_VDDCX_AO] =	&msm8916_vddcx_ao,
-	[MSM8916_VDDCX_VFC] =	&msm8916_vddcx_vfc,
-	[MSM8916_VDDMX] =	&msm8916_vddmx,
-	[MSM8916_VDDMX_AO] =	&msm8916_vddmx_ao,
+	[MSM8916_VDDCX] =	&SMPA1_CORNER_vddcx,
+	[MSM8916_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
+	[MSM8916_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
+	[MSM8916_VDDMX] =	&LDOA3_CORNER_vddmx,
+	[MSM8916_VDDMX_AO] =	&LDOA3_CORNER_vddmx_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -202,20 +196,20 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 /* msm8953 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8953, vddmd, vddmd_ao, SMPA, LEVEL, 1);
-DEFINE_RPMPD_PAIR(msm8953, vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(msm8953, vddmx, vddmx_ao, SMPA, LEVEL, 7);
+DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 2);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 7);
 
-DEFINE_RPMPD_VFL(msm8953, vddcx_vfl, SMPA, 2);
+DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 2);
 
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&msm8953_vddmd,
-	[MSM8953_VDDMD_AO] =	&msm8953_vddmd_ao,
-	[MSM8953_VDDCX] =	&msm8953_vddcx,
-	[MSM8953_VDDCX_AO] =	&msm8953_vddcx_ao,
-	[MSM8953_VDDCX_VFL] =	&msm8953_vddcx_vfl,
-	[MSM8953_VDDMX] =	&msm8953_vddmx,
-	[MSM8953_VDDMX_AO] =	&msm8953_vddmx_ao,
+	[MSM8953_VDDMD] =	&SMPA1_LEVEL_vddmd,
+	[MSM8953_VDDMD_AO] =	&SMPA1_LEVEL_vddmd_ao,
+	[MSM8953_VDDCX] =	&SMPA2_LEVEL_vddcx,
+	[MSM8953_VDDCX_AO] =	&SMPA2_LEVEL_vddcx_ao,
+	[MSM8953_VDDCX_VFL] =	&SMPA2_vddcx_vfl,
+	[MSM8953_VDDMX] =	&SMPA7_LEVEL_vddmx,
+	[MSM8953_VDDMX_AO] =	&SMPA7_LEVEL_vddmx_ao,
 };
 
 static const struct rpmpd_desc msm8953_desc = {
@@ -225,19 +219,18 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 /* msm8976 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8976, vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(msm8976, vddmx, vddmx_ao, SMPA, LEVEL, 6);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 6);
 
-DEFINE_RPMPD_VFL(msm8976, vddcx_vfl, RWSC, 2);
-DEFINE_RPMPD_VFL(msm8976, vddmx_vfl, RWSM, 6);
+DEFINE_RPMPD_VFL(vddcx_vfl, RWSC, 2);
+DEFINE_RPMPD_VFL(vddmx_vfl, RWSM, 6);
 
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&msm8976_vddcx,
-	[MSM8976_VDDCX_AO] =	&msm8976_vddcx_ao,
-	[MSM8976_VDDCX_VFL] =	&msm8976_vddcx_vfl,
-	[MSM8976_VDDMX] =	&msm8976_vddmx,
-	[MSM8976_VDDMX_AO] =	&msm8976_vddmx_ao,
-	[MSM8976_VDDMX_VFL] =	&msm8976_vddmx_vfl,
+	[MSM8976_VDDCX] =	&SMPA2_LEVEL_vddcx,
+	[MSM8976_VDDCX_AO] =	&SMPA2_LEVEL_vddcx_ao,
+	[MSM8976_VDDCX_VFL] =	&RWSC2_vddcx_vfl,
+	[MSM8976_VDDMX] =	&SMPA6_LEVEL_vddmx,
+	[MSM8976_VDDMX_AO] =	&SMPA6_LEVEL_vddmx_ao,
+	[MSM8976_VDDMX_VFL] =	&RWSM6_vddmx_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -247,22 +240,20 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 /* msm8994 RPM Power domains */
-DEFINE_RPMPD_PAIR(msm8994, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(msm8994, vddmx, vddmx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, CORNER, 2);
 /* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-DEFINE_RPMPD_CORNER(msm8994, vddgfx, SMPB, 2);
+DEFINE_RPMPD_CORNER(vddgfx, SMPB, 2);
 
-DEFINE_RPMPD_VFC(msm8994, vddcx_vfc, SMPA, 1);
-DEFINE_RPMPD_VFC(msm8994, vddgfx_vfc, SMPB, 2);
+DEFINE_RPMPD_VFC(vddgfx_vfc, SMPB, 2);
 
 static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&msm8994_vddcx,
-	[MSM8994_VDDCX_AO] =	&msm8994_vddcx_ao,
-	[MSM8994_VDDCX_VFC] =	&msm8994_vddcx_vfc,
-	[MSM8994_VDDMX] =	&msm8994_vddmx,
-	[MSM8994_VDDMX_AO] =	&msm8994_vddmx_ao,
-	[MSM8994_VDDGFX] =	&msm8994_vddgfx,
-	[MSM8994_VDDGFX_VFC] =	&msm8994_vddgfx_vfc,
+	[MSM8994_VDDCX] =	&SMPA1_CORNER_vddcx,
+	[MSM8994_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
+	[MSM8994_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
+	[MSM8994_VDDMX] =	&SMPA2_CORNER_vddmx,
+	[MSM8994_VDDMX_AO] =	&SMPA2_CORNER_vddmx_ao,
+	[MSM8994_VDDGFX] =	&SMPB2_vddgfx_corner,
+	[MSM8994_VDDGFX_VFC] =	&SMPB2_vddgfx_vfc,
 };
 
 static const struct rpmpd_desc msm8994_desc = {
@@ -272,21 +263,18 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 /* msm8996 RPM Power domains */
-DEFINE_RPMPD_PAIR(msm8996, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(msm8996, vddmx, vddmx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_CORNER(msm8996, vddsscx, LDOA, 26);
+DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
 
-DEFINE_RPMPD_VFC(msm8996, vddcx_vfc, SMPA, 1);
-DEFINE_RPMPD_VFC(msm8996, vddsscx_vfc, LDOA, 26);
+DEFINE_RPMPD_VFC(vddsscx_vfc, LDOA, 26);
 
 static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&msm8996_vddcx,
-	[MSM8996_VDDCX_AO] =	&msm8996_vddcx_ao,
-	[MSM8996_VDDCX_VFC] =	&msm8996_vddcx_vfc,
-	[MSM8996_VDDMX] =	&msm8996_vddmx,
-	[MSM8996_VDDMX_AO] =	&msm8996_vddmx_ao,
-	[MSM8996_VDDSSCX] =	&msm8996_vddsscx,
-	[MSM8996_VDDSSCX_VFC] =	&msm8996_vddsscx_vfc,
+	[MSM8996_VDDCX] =	&SMPA1_CORNER_vddcx,
+	[MSM8996_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
+	[MSM8996_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
+	[MSM8996_VDDMX] =	&SMPA2_CORNER_vddmx,
+	[MSM8996_VDDMX_AO] =	&SMPA2_CORNER_vddmx_ao,
+	[MSM8996_VDDSSCX] =	&LDOA26_vddsscx_corner,
+	[MSM8996_VDDSSCX_VFC] =	&LDOA26_vddsscx_vfc,
 };
 
 static const struct rpmpd_desc msm8996_desc = {
@@ -296,29 +284,29 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 /* msm8998 RPM Power domains */
-DEFINE_RPMPD_PAIR(msm8998, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(msm8998, vddcx_vfl, RWCX, 0);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_VFL(vddcx_vfl, RWCX, 0);
 
-DEFINE_RPMPD_PAIR(msm8998, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(msm8998, vddmx_vfl, RWMX, 0);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_VFL(vddmx_vfl, RWMX, 0);
 
-DEFINE_RPMPD_LEVEL(msm8998, vdd_ssccx, RWSC, 0);
-DEFINE_RPMPD_VFL(msm8998, vdd_ssccx_vfl, RWSC, 0);
+DEFINE_RPMPD_LEVEL(vdd_ssccx, RWSC, 0);
+DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWSC, 0);
 
-DEFINE_RPMPD_LEVEL(msm8998, vdd_sscmx, RWSM, 0);
-DEFINE_RPMPD_VFL(msm8998, vdd_sscmx_vfl, RWSM, 0);
+DEFINE_RPMPD_LEVEL(vdd_sscmx, RWSM, 0);
+DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWSM, 0);
 
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
+	[MSM8998_VDDCX] =		&RWCX0_LEVEL_vddcx,
+	[MSM8998_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
+	[MSM8998_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
+	[MSM8998_VDDMX] =		&RWMX0_LEVEL_vddmx,
+	[MSM8998_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
+	[MSM8998_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
+	[MSM8998_SSCCX] =		&RWSC0_vdd_ssccx_lvl,
+	[MSM8998_SSCCX_VFL] =		&RWSC0_vdd_ssccx_vfl,
+	[MSM8998_SSCMX] =		&RWSM0_vdd_sscmx_lvl,
+	[MSM8998_SSCMX_VFL] =		&RWSM0_vdd_sscmx_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -328,23 +316,20 @@ static const struct rpmpd_desc msm8998_desc = {
 };
 
 /* qcs404 RPM Power domains */
-DEFINE_RPMPD_PAIR(qcs404, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(qcs404, vddmx_vfl, RWMX, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
+DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
 
-DEFINE_RPMPD_LEVEL(qcs404, vdd_lpicx, RWLC, 0);
-DEFINE_RPMPD_VFL(qcs404, vdd_lpicx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(qcs404, vdd_lpimx, RWLM, 0);
-DEFINE_RPMPD_VFL(qcs404, vdd_lpimx_vfl, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
+DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
 
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] = &qcs404_vddmx,
-	[QCS404_VDDMX_AO] = &qcs404_vddmx_ao,
-	[QCS404_VDDMX_VFL] = &qcs404_vddmx_vfl,
-	[QCS404_LPICX] = &qcs404_vdd_lpicx,
-	[QCS404_LPICX_VFL] = &qcs404_vdd_lpicx_vfl,
-	[QCS404_LPIMX] = &qcs404_vdd_lpimx,
-	[QCS404_LPIMX_VFL] = &qcs404_vdd_lpimx_vfl,
+	[QCS404_VDDMX] = &RWMX0_LEVEL_vddmx,
+	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
+	[QCS404_VDDMX_VFL] = &RWMX0_vddmx_vfl,
+	[QCS404_LPICX] = &RWLC0_vdd_lpicx_lvl,
+	[QCS404_LPICX_VFL] = &RWLC0_vdd_lpicx_vfl,
+	[QCS404_LPIMX] = &RWLM0_vdd_lpimx_lvl,
+	[QCS404_LPIMX_VFL] = &RWLM0_vdd_lpimx_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -354,29 +339,24 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 /* sdm660 RPM Power domains */
-DEFINE_RPMPD_PAIR(sdm660, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sdm660, vddcx_vfl, RWCX, 0);
-
-DEFINE_RPMPD_PAIR(sdm660, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sdm660, vddmx_vfl, RWMX, 0);
 
-DEFINE_RPMPD_LEVEL(sdm660, vdd_ssccx, RWLC, 0);
-DEFINE_RPMPD_VFL(sdm660, vdd_ssccx_vfl, RWLC, 0);
+DEFINE_RPMPD_LEVEL(vdd_ssccx, RWLC, 0);
+DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWLC, 0);
 
-DEFINE_RPMPD_LEVEL(sdm660, vdd_sscmx, RWLM, 0);
-DEFINE_RPMPD_VFL(sdm660, vdd_sscmx_vfl, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_sscmx, RWLM, 0);
+DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWLM, 0);
 
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
+	[SDM660_VDDCX] =		&RWCX0_LEVEL_vddcx,
+	[SDM660_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
+	[SDM660_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
+	[SDM660_VDDMX] =		&RWMX0_LEVEL_vddmx,
+	[SDM660_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
+	[SDM660_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
+	[SDM660_SSCCX] =		&RWLC0_vdd_ssccx_lvl,
+	[SDM660_SSCCX_VFL] =		&RWLC0_vdd_ssccx_vfl,
+	[SDM660_SSCMX] =		&RWLM0_vdd_sscmx_lvl,
+	[SDM660_SSCMX_VFL] =		&RWLM0_vdd_sscmx_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -386,24 +366,18 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 /* sm4250/6115 RPM Power domains */
-DEFINE_RPMPD_PAIR(sm6115, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6115, vddcx_vfl, RWCX, 0);
-
-DEFINE_RPMPD_PAIR(sm6115, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6115, vddmx_vfl, RWMX, 0);
-
-DEFINE_RPMPD_LEVEL(sm6115, vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(sm6115, vdd_lpi_mx, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
 
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&sm6115_vddcx,
-	[SM6115_VDDCX_AO] =		&sm6115_vddcx_ao,
-	[SM6115_VDDCX_VFL] =		&sm6115_vddcx_vfl,
-	[SM6115_VDDMX] =		&sm6115_vddmx,
-	[SM6115_VDDMX_AO] =		&sm6115_vddmx_ao,
-	[SM6115_VDDMX_VFL] =		&sm6115_vddmx_vfl,
-	[SM6115_VDD_LPI_CX] =		&sm6115_vdd_lpi_cx,
-	[SM6115_VDD_LPI_MX] =		&sm6115_vdd_lpi_mx,
+	[SM6115_VDDCX] =		&RWCX0_LEVEL_vddcx,
+	[SM6115_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
+	[SM6115_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
+	[SM6115_VDDMX] =		&RWMX0_LEVEL_vddmx,
+	[SM6115_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
+	[SM6115_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
+	[SM6115_VDD_LPI_CX] =		&RWLC0_vdd_lpi_cx_lvl,
+	[SM6115_VDD_LPI_MX] =		&RWLM0_vdd_lpi_mx_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -413,19 +387,13 @@ static const struct rpmpd_desc sm6115_desc = {
 };
 
 /* sm6125 RPM Power domains */
-DEFINE_RPMPD_PAIR(sm6125, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6125, vddcx_vfl, RWCX, 0);
-
-DEFINE_RPMPD_PAIR(sm6125, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6125, vddmx_vfl, RWMX, 0);
-
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&sm6125_vddcx,
-	[SM6125_VDDCX_AO] =		&sm6125_vddcx_ao,
-	[SM6125_VDDCX_VFL] =		&sm6125_vddcx_vfl,
-	[SM6125_VDDMX] =		&sm6125_vddmx,
-	[SM6125_VDDMX_AO] =		&sm6125_vddmx_ao,
-	[SM6125_VDDMX_VFL] =		&sm6125_vddmx_vfl,
+	[SM6125_VDDCX] =		&RWCX0_LEVEL_vddcx,
+	[SM6125_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
+	[SM6125_VDDCX_VFL] =		&RWCX0_vddcx_vfl,
+	[SM6125_VDDMX] =		&RWMX0_LEVEL_vddmx,
+	[SM6125_VDDMX_AO] =		&RWMX0_LEVEL_vddmx_ao,
+	[SM6125_VDDMX_VFL] =		&RWMX0_vddmx_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -434,18 +402,18 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-DEFINE_RPMPD_PAIR(sm6375, vddgx, vddgx_ao, RWGX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(vddgx, vddgx_ao, RWGX, LEVEL, 0);
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
+	[SM6375_VDDCX] = &RWCX0_LEVEL_vddcx,
+	[SM6375_VDDCX_AO] = &RWCX0_LEVEL_vddcx_ao,
+	[SM6375_VDDCX_VFL] = &RWCX0_vddcx_vfl,
+	[SM6375_VDDMX] = &RWMX0_LEVEL_vddmx,
+	[SM6375_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
+	[SM6375_VDDMX_VFL] = &RWMX0_vddmx_vfl,
+	[SM6375_VDDGX] = &RWGX0_LEVEL_vddgx,
+	[SM6375_VDDGX_AO] = &RWGX0_LEVEL_vddgx_ao,
+	[SM6375_VDD_LPI_CX] = &RWLC0_vdd_lpi_cx_lvl,
+	[SM6375_VDD_LPI_MX] = &RWLM0_vdd_lpi_mx_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -455,14 +423,14 @@ static const struct rpmpd_desc sm6375_desc = {
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
+	[QCM2290_VDDCX] = &RWCX0_LEVEL_vddcx,
+	[QCM2290_VDDCX_AO] = &RWCX0_LEVEL_vddcx_ao,
+	[QCM2290_VDDCX_VFL] = &RWCX0_vddcx_vfl,
+	[QCM2290_VDDMX] = &RWMX0_LEVEL_vddmx,
+	[QCM2290_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
+	[QCM2290_VDDMX_VFL] = &RWMX0_vddmx_vfl,
+	[QCM2290_VDD_LPI_CX] = &RWLC0_vdd_lpi_cx_lvl,
+	[QCM2290_VDD_LPI_MX] = &RWLM0_vdd_lpi_mx_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {

-- 
2.39.2

