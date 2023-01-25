Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AAF67A936
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjAYD1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjAYD1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014653B26
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz11so44278460ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dKcE4jHccZOMOJ076LzEOV5Ke8TJRcTIiVilxyXl8k=;
        b=AImo6y1Z8UxHMOS1/tplDK9LI1FZujfXlVXjsTxYSt0UTqrShXB1oZN2W5UdWsGhkA
         HwYGPNDy6/a9LJGN+M2uBtlyf4oj2P9BXv+U4nlA9wpnVJcz/vJejkGwVB0R32tgYcec
         ddPaY4XD9UDL9RyNW+wR0IBwaGzxULXG7kIxW616lMzihRXzinpZSNHuGTp/JI8s1pXn
         6bbE870cpAznaaw6iDY2g0VDjhzoRRG5bMs1SBVI0HhtklMm63tbO1+nPZRAzCnzFtGf
         yptsHMp2RWtnwxicLCBB6v9p2pcdlw0lCqZ4vLJllxfpcZfWllcyMMiMW08mBlJMp74B
         IuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dKcE4jHccZOMOJ076LzEOV5Ke8TJRcTIiVilxyXl8k=;
        b=YP6MVn6YE5AXdELFIuitjBVpKCxX37AKj3YP8E82PO6Ih/XdwdZdBmuGz/pXt+fgto
         vtXsYyUv0N2GD6DfnR7/jfoOTwSPIs4vUI14Hr6C61g0ZJtLLjuwZhm/Y1FVhm1eVHei
         YQbMciegOACULE8r0ttWiAty2cAKKxSJX3wyUyrKatxgWy9QOPLhDRg3BvHojBKG8WJs
         5bdJpcQl6jk0K0T2hPYQ7vXjuklS0v6v4vtvyQjCSMllCyetPiTEu3A0KJZFFobJKma/
         OkszOR+VGYTv2pGZ+Oj/hMeHJKwUHMVuBghf1YKrBUMpIrITia8YeOf8zLXWrvifSalL
         Z/Ow==
X-Gm-Message-State: AFqh2kqHQetqO/cSShOlt1yxr9NBCbhABFC3iNtIIx9w68LxPWhFQwus
        MnLiZgExUEjrA7m8trckKnpLEQ==
X-Google-Smtp-Source: AMrXdXt0txRbFgX2bBphixqKqTbLmAkJnHcxJrVRs6KCo1M4NP8bFLyBmatKCdugSnxW5k2eSAJOpQ==
X-Received: by 2002:a17:906:f6ce:b0:877:9b5a:bd51 with SMTP id jo14-20020a170906f6ce00b008779b5abd51mr22683001ejb.72.1674617254744;
        Tue, 24 Jan 2023 19:27:34 -0800 (PST)
Received: from localhost.localdomain (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1742913ejc.2.2023.01.24.19.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:27:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] soc: qcom: rpmpd: Expand #defines into structs
Date:   Wed, 25 Jan 2023 04:27:23 +0100
Message-Id: <20230125032728.611640-3-konrad.dybcio@linaro.org>
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

Expand preprocessor macros into human-readable structs for easier
reference.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 839 +++++++++++++++++++++++++++++++++------
 1 file changed, 722 insertions(+), 117 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 0c2d930ab38f..9a7da7cead9e 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -40,57 +40,6 @@
 
 #define MAX_CORNER_RPMPD_STATE	6
 
-#define DEFINE_RPMPD_PAIR(_platform, _name, _active, r_type, r_key,	\
-			  r_id)						\
-	static struct rpmpd _platform##_##_active;			\
-	static struct rpmpd _platform##_##_name = {			\
-		.pd = {	.name = #_name,	},				\
-		.peer = &_platform##_##_active,				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_##r_key,					\
-	};								\
-	static struct rpmpd _platform##_##_active = {			\
-		.pd = { .name = #_active, },				\
-		.peer = &_platform##_##_name,				\
-		.active_only = true,					\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_##r_key,					\
-	}
-
-#define DEFINE_RPMPD_CORNER(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_CORNER,					\
-	}
-
-#define DEFINE_RPMPD_LEVEL(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_LEVEL,					\
-	}
-
-#define DEFINE_RPMPD_VFC(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_FLOOR_CORNER,				\
-	}
-
-#define DEFINE_RPMPD_VFL(_platform, _name, r_type, r_id)		\
-	static struct rpmpd _platform##_##_name = {			\
-		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_##r_type,				\
-		.res_id = r_id,						\
-		.key = KEY_FLOOR_LEVEL,					\
-	}
-
 struct rpmpd_req {
 	__le32 key;
 	__le32 nbytes;
@@ -120,11 +69,56 @@ struct rpmpd_desc {
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* mdm9607 RPM Power Domains */
-DEFINE_RPMPD_PAIR(mdm9607, vddcx, vddcx_ao, SMPA, LEVEL, 3);
-DEFINE_RPMPD_VFL(mdm9607, vddcx_vfl, SMPA, 3);
+static struct rpmpd mdm9607_vddcx_ao;
+static struct rpmpd mdm9607_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &mdm9607_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mdm9607_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &mdm9607_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mdm9607_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 3,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd mdm9607_vddmx_ao;
+static struct rpmpd mdm9607_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &mdm9607_vddmx_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mdm9607_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &mdm9607_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mdm9607_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 12,
+	.key = KEY_FLOOR_LEVEL,
+};
 
-DEFINE_RPMPD_PAIR(mdm9607, vddmx, vddmx_ao, LDOA, LEVEL, 12);
-DEFINE_RPMPD_VFL(mdm9607, vddmx_vfl, LDOA, 12);
 static struct rpmpd *mdm9607_rpmpds[] = {
 	[MDM9607_VDDCX] =	&mdm9607_vddcx,
 	[MDM9607_VDDCX_AO] =	&mdm9607_vddcx_ao,
@@ -141,8 +135,30 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 /* msm8226 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8226, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(msm8226, vddcx_vfc, SMPA, 1);
+static struct rpmpd msm8226_vddcx_ao;
+static struct rpmpd msm8226_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8226_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8226_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8226_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8226_vddcx_vfc = {
+	.pd = { .name = "vddcx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
 
 static struct rpmpd *msm8226_rpmpds[] = {
 	[MSM8226_VDDCX] =	&msm8226_vddcx,
@@ -157,13 +173,73 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 /* msm8939 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8939, vddmd, vddmd_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(msm8939, vddmd_vfc, SMPA, 1);
+static struct rpmpd msm8939_vddmd_ao;
+static struct rpmpd msm8939_vddmd = {
+	.pd = { .name = "vddmd", },
+	.peer = &msm8939_vddmd_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8939_vddmd_ao = {
+	.pd = { .name = "vddmd_ao", },
+	.peer = &msm8939_vddmd,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8939_vddmd_vfc = {
+	.pd = { .name = "vddmd_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
 
-DEFINE_RPMPD_PAIR(msm8939, vddcx, vddcx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_VFC(msm8939, vddcx_vfc, SMPA, 2);
+static struct rpmpd msm8939_vddcx_ao;
+static struct rpmpd msm8939_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8939_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8939_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8939_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8939_vddcx_vfc = {
+	.pd = { .name = "vddcx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_FLOOR_CORNER,
+};
 
-DEFINE_RPMPD_PAIR(msm8939, vddmx, vddmx_ao, LDOA, CORNER, 3);
+static struct rpmpd msm8939_vddmx_ao;
+static struct rpmpd msm8939_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8939_vddmx_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8939_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8939_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
+};
 
 static struct rpmpd *msm8939_rpmpds[] = {
 	[MSM8939_VDDMDCX] =	&msm8939_vddmd,
@@ -183,10 +259,48 @@ static const struct rpmpd_desc msm8939_desc = {
 };
 
 /* msm8916 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8916, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(msm8916, vddmx, vddmx_ao, LDOA, CORNER, 3);
+static struct rpmpd msm8916_vddcx_ao;
+static struct rpmpd msm8916_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8916_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8916_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8916_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8916_vddmx_ao;
+static struct rpmpd msm8916_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8916_vddmx_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
+};
 
-DEFINE_RPMPD_VFC(msm8916, vddcx_vfc, SMPA, 1);
+static struct rpmpd msm8916_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8916_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8916_vddcx_vfc = {
+	.pd = { .name = "vddcx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
 
 static struct rpmpd *msm8916_rpmpds[] = {
 	[MSM8916_VDDCX] =	&msm8916_vddcx,
@@ -203,11 +317,66 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 /* msm8953 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8953, vddmd, vddmd_ao, SMPA, LEVEL, 1);
-DEFINE_RPMPD_PAIR(msm8953, vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(msm8953, vddmx, vddmx_ao, SMPA, LEVEL, 7);
+static struct rpmpd msm8953_vddmd_ao;
+static struct rpmpd msm8953_vddmd = {
+	.pd = { .name = "vddmd", },
+	.peer = &msm8953_vddmd_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_VFL(msm8953, vddcx_vfl, SMPA, 2);
+static struct rpmpd msm8953_vddmd_ao = {
+	.pd = { .name = "vddmd_ao", },
+	.peer = &msm8953_vddmd,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8953_vddcx_ao;
+static struct rpmpd msm8953_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8953_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8953_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8953_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8953_vddmx_ao;
+static struct rpmpd msm8953_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8953_vddmx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8953_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8953_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8953_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&msm8953_vddmd,
@@ -226,11 +395,55 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 /* msm8976 RPM Power Domains */
-DEFINE_RPMPD_PAIR(msm8976, vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(msm8976, vddmx, vddmx_ao, SMPA, LEVEL, 6);
+static struct rpmpd msm8976_vddcx_ao;
+static struct rpmpd msm8976_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8976_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_VFL(msm8976, vddcx_vfl, RWSC, 2);
-DEFINE_RPMPD_VFL(msm8976, vddmx_vfl, RWSM, 6);
+static struct rpmpd msm8976_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8976_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8976_vddmx_ao;
+static struct rpmpd msm8976_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8976_vddmx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 6,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8976_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8976_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 6,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8976_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_RWSC,
+	.res_id = 2,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd msm8976_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_RWSM,
+	.res_id = 6,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&msm8976_vddcx,
@@ -248,13 +461,63 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 /* msm8994 RPM Power domains */
-DEFINE_RPMPD_PAIR(msm8994, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(msm8994, vddmx, vddmx_ao, SMPA, CORNER, 2);
-/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-DEFINE_RPMPD_CORNER(msm8994, vddgfx, SMPB, 2);
+static struct rpmpd msm8994_vddcx_ao;
+static struct rpmpd msm8994_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8994_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8994_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8994_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
 
-DEFINE_RPMPD_VFC(msm8994, vddcx_vfc, SMPA, 1);
-DEFINE_RPMPD_VFC(msm8994, vddgfx_vfc, SMPB, 2);
+static struct rpmpd msm8994_vddmx_ao;
+static struct rpmpd msm8994_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8994_vddmx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8994_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8994_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8994_vddgfx = {
+	.pd = { .name = "vddgfx", },
+	/* SMPC if your board has a PM8004! */
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8994_vddcx_vfc = {
+	.pd = { .name = "vddcx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd msm8994_vddgfx_vfc = {
+	.pd = { .name = "vddgfx_vfc", },
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_FLOOR_CORNER,
+};
 
 static struct rpmpd *msm8994_rpmpds[] = {
 	[MSM8994_VDDCX] =	&msm8994_vddcx,
@@ -273,12 +536,62 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 /* msm8996 RPM Power domains */
-DEFINE_RPMPD_PAIR(msm8996, vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_PAIR(msm8996, vddmx, vddmx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_CORNER(msm8996, vddsscx, LDOA, 26);
+static struct rpmpd msm8996_vddcx_ao;
+static struct rpmpd msm8996_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8996_vddcx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
 
-DEFINE_RPMPD_VFC(msm8996, vddcx_vfc, SMPA, 1);
-DEFINE_RPMPD_VFC(msm8996, vddsscx_vfc, LDOA, 26);
+static struct rpmpd msm8996_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8996_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8996_vddmx_ao;
+static struct rpmpd msm8996_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8996_vddmx_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8996_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8996_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8996_vddsscx = {
+	.pd = { .name = "vddsscx", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 26,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd msm8996_vddcx_vfc = {
+	.pd = { .name = "vddcx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_CORNER,
+};
+
+static struct rpmpd msm8996_vddsscx_vfc = {
+	.pd = { .name = "vddsscx_vfc", },
+	.res_type = RPMPD_LDOA,
+	.res_id = 26,
+	.key = KEY_FLOOR_CORNER,
+};
 
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&msm8996_vddcx,
@@ -297,17 +610,83 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 /* msm8998 RPM Power domains */
-DEFINE_RPMPD_PAIR(msm8998, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(msm8998, vddcx_vfl, RWCX, 0);
+static struct rpmpd msm8998_vddcx_ao;
+static struct rpmpd msm8998_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &msm8998_vddcx_ao,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8998_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &msm8998_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8998_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
-DEFINE_RPMPD_PAIR(msm8998, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(msm8998, vddmx_vfl, RWMX, 0);
+static struct rpmpd msm8998_vddmx_ao;
+static struct rpmpd msm8998_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &msm8998_vddmx_ao,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(msm8998, vdd_ssccx, RWSC, 0);
-DEFINE_RPMPD_VFL(msm8998, vdd_ssccx_vfl, RWSC, 0);
+static struct rpmpd msm8998_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &msm8998_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(msm8998, vdd_sscmx, RWSM, 0);
-DEFINE_RPMPD_VFL(msm8998, vdd_sscmx_vfl, RWSM, 0);
+static struct rpmpd msm8998_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd msm8998_vdd_ssccx = {
+	.pd = { .name = "vdd_ssccx", },
+	.res_type = RPMPD_RWSC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8998_vdd_ssccx_vfl = {
+	.pd = { .name = "vdd_ssccx_vfl", },
+	.res_type = RPMPD_RWSC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd msm8998_vdd_sscmx = {
+	.pd = { .name = "vdd_sscmx", },
+	.res_type = RPMPD_RWSM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd msm8998_vdd_sscmx_vfl = {
+	.pd = { .name = "vdd_sscmx_vfl", },
+	.res_type = RPMPD_RWSM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd *msm8998_rpmpds[] = {
 	[MSM8998_VDDCX] =		&msm8998_vddcx,
@@ -329,14 +708,58 @@ static const struct rpmpd_desc msm8998_desc = {
 };
 
 /* qcs404 RPM Power domains */
-DEFINE_RPMPD_PAIR(qcs404, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(qcs404, vddmx_vfl, RWMX, 0);
+static struct rpmpd qcs404_vddmx_ao;
+static struct rpmpd qcs404_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &qcs404_vddmx_ao,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd qcs404_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &qcs404_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd qcs404_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd qcs404_vdd_lpicx = {
+	.pd = { .name = "vdd_lpicx", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd qcs404_vdd_lpicx_vfl = {
+	.pd = { .name = "vdd_lpicx_vfl", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(qcs404, vdd_lpicx, RWLC, 0);
-DEFINE_RPMPD_VFL(qcs404, vdd_lpicx_vfl, RWLC, 0);
+static struct rpmpd qcs404_vdd_lpimx = {
+	.pd = { .name = "vdd_lpimx", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(qcs404, vdd_lpimx, RWLM, 0);
-DEFINE_RPMPD_VFL(qcs404, vdd_lpimx_vfl, RWLM, 0);
+static struct rpmpd qcs404_vdd_lpimx_vfl = {
+	.pd = { .name = "vdd_lpimx_vfl", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] = &qcs404_vddmx,
@@ -355,17 +778,83 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 /* sdm660 RPM Power domains */
-DEFINE_RPMPD_PAIR(sdm660, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sdm660, vddcx_vfl, RWCX, 0);
+static struct rpmpd sdm660_vddcx_ao;
+static struct rpmpd sdm660_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &sdm660_vddcx_ao,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_PAIR(sdm660, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sdm660, vddmx_vfl, RWMX, 0);
+static struct rpmpd sdm660_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &sdm660_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(sdm660, vdd_ssccx, RWLC, 0);
-DEFINE_RPMPD_VFL(sdm660, vdd_ssccx_vfl, RWLC, 0);
+static struct rpmpd sdm660_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(sdm660, vdd_sscmx, RWLM, 0);
-DEFINE_RPMPD_VFL(sdm660, vdd_sscmx_vfl, RWLM, 0);
+static struct rpmpd sdm660_vddmx_ao;
+static struct rpmpd sdm660_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &sdm660_vddmx_ao,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sdm660_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &sdm660_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sdm660_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd sdm660_vdd_ssccx = {
+	.pd = { .name = "vdd_ssccx", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sdm660_vdd_ssccx_vfl = {
+	.pd = { .name = "vdd_ssccx_vfl", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd sdm660_vdd_sscmx = {
+	.pd = { .name = "vdd_sscmx", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sdm660_vdd_sscmx_vfl = {
+	.pd = { .name = "vdd_sscmx_vfl", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =		&sdm660_vddcx,
@@ -387,14 +876,69 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 /* sm4250/6115 RPM Power domains */
-DEFINE_RPMPD_PAIR(sm6115, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6115, vddcx_vfl, RWCX, 0);
+static struct rpmpd sm6115_vddcx_ao;
+static struct rpmpd sm6115_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &sm6115_vddcx_ao,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6115_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &sm6115_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6115_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd sm6115_vddmx_ao;
+static struct rpmpd sm6115_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &sm6115_vddmx_ao,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_PAIR(sm6115, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6115, vddmx_vfl, RWMX, 0);
+static struct rpmpd sm6115_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &sm6115_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6115_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd sm6115_vdd_lpi_cx = {
+	.pd = { .name = "vdd_lpi_cx", },
+	.res_type = RPMPD_RWLC,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_LEVEL(sm6115, vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(sm6115, vdd_lpi_mx, RWLM, 0);
+static struct rpmpd sm6115_vdd_lpi_mx = {
+	.pd = { .name = "vdd_lpi_mx", },
+	.res_type = RPMPD_RWLM,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =		&sm6115_vddcx,
@@ -414,11 +958,55 @@ static const struct rpmpd_desc sm6115_desc = {
 };
 
 /* sm6125 RPM Power domains */
-DEFINE_RPMPD_PAIR(sm6125, vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6125, vddcx_vfl, RWCX, 0);
+static struct rpmpd sm6125_vddcx_ao;
+static struct rpmpd sm6125_vddcx = {
+	.pd = { .name = "vddcx", },
+	.peer = &sm6125_vddcx_ao,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6125_vddcx_ao = {
+	.pd = { .name = "vddcx_ao", },
+	.peer = &sm6125_vddcx,
+	.active_only = true,
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6125_vddcx_vfl = {
+	.pd = { .name = "vddcx_vfl", },
+	.res_type = RPMPD_RWCX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
+
+static struct rpmpd sm6125_vddmx_ao;
+static struct rpmpd sm6125_vddmx = {
+	.pd = { .name = "vddmx", },
+	.peer = &sm6125_vddmx_ao,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6125_vddmx_ao = {
+	.pd = { .name = "vddmx_ao", },
+	.peer = &sm6125_vddmx,
+	.active_only = true,
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
 
-DEFINE_RPMPD_PAIR(sm6125, vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(sm6125, vddmx_vfl, RWMX, 0);
+static struct rpmpd sm6125_vddmx_vfl = {
+	.pd = { .name = "vddmx_vfl", },
+	.res_type = RPMPD_RWMX,
+	.res_id = 0,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd *sm6125_rpmpds[] = {
 	[SM6125_VDDCX] =		&sm6125_vddcx,
@@ -435,7 +1023,24 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-DEFINE_RPMPD_PAIR(sm6375, vddgx, vddgx_ao, RWGX, LEVEL, 0);
+static struct rpmpd sm6375_vddgx_ao;
+static struct rpmpd sm6375_vddgx = {
+	.pd = {	.name = "vddgx", },
+	.peer = &sm6375_vddgx_ao,
+	.res_type = RPMPD_RWGX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd sm6375_vddgx_ao = {
+	.pd = {	.name = "vddgx_ao", },
+	.peer = &sm6375_vddgx,
+	.active_only = true,
+	.res_type = RPMPD_RWGX,
+	.res_id = 0,
+	.key = KEY_LEVEL,
+};
+
 static struct rpmpd *sm6375_rpmpds[] = {
 	[SM6375_VDDCX] = &sm6125_vddcx,
 	[SM6375_VDDCX_AO] = &sm6125_vddcx_ao,
-- 
2.39.1

