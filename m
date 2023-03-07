Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D566ADF85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCGNCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCGNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:01:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5317A8E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:01:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i28so17038419lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wx65b6tHAAIHsJSsttrbtRIwIAX7Thn6gXbFwUEFkEQ=;
        b=vTU/OzncrcdvHDBc0YWnwoMNXNf+pFhP2l9Ep80IBtqVAJzJGMcfis0sLnAGf3EjGX
         SbzGAM8ipRiuTjDY/y/gMpQq7MNtS3D2M0ur2reHgySdAPyktewCFMBhZKmPSlJQCEmi
         mSwT5yXYq0tiaCP7w9x+dIe3hpHB6gZfsxXWDNCLr/kEGHJorKAF6d1/1GQeUD0psfsF
         4SdMFGr63jJCwKUTl0us7+4bqHjUTjsuhXLQFUNINJSIkNs8+7IRxzq8UbFgQi/qKVnv
         vkJzZsK/757eOebOp/6L0VQueLY04Pg/cy65aV3F/B9UXYyfUjBXaavdRQgBbYMgc3hm
         uOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx65b6tHAAIHsJSsttrbtRIwIAX7Thn6gXbFwUEFkEQ=;
        b=T3s7TPMCqKPUftnl0T9Bfk1hzi5PMLjobSmHLUgawg3irCjZ+DZqTb9w2Z+il4qLoQ
         ff37SScl2z4hSJVSMsLRjMT1omQj1OUNn8LtsJqUYWQMpkRFZwy9keYdVkGnwPpdhJ9M
         vVKpli/uPz1K5uKiva+ElLFvb3+tg63GUC3zLQ99bPwWYGl53WVkqqd6py2Haruakohm
         T4/Uqat49WAO9u4K0thxuhurTRctX1W6fvD5SOlAFeemp9pKujMQ8ih/sgujZ6LBq55S
         Vg+ZOqHBHS4FFDAY7lFul5hC4rXNVPxuUUZVnwmYMM6FLLv5RKy+GkkEy4yHGS2f4GcF
         5iPw==
X-Gm-Message-State: AO0yUKW92i8gNHjPaV9VANnzlJ39IGQ2TwAAyZfhAaKV/eP5QvIejEue
        jccsbm/NrZP0gorJOZ7WvD9YvA==
X-Google-Smtp-Source: AK7set9jrafvwImhbea+2NwdNxYqe4InfqnkSApRE2IgoEMsIZXl/6vpS8pkuH8DPFUBiaTVGwjYEg==
X-Received: by 2002:ac2:4a85:0:b0:4b9:f5e5:8fb4 with SMTP id l5-20020ac24a85000000b004b9f5e58fb4mr3722068lfp.3.1678194104784;
        Tue, 07 Mar 2023 05:01:44 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u2-20020ac248a2000000b004cc5e97d356sm2048265lfg.148.2023.03.07.05.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:01:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 07 Mar 2023 14:01:40 +0100
Subject: [PATCH v3 02/10] drm/msm/dsi: Get rid of msm_dsi_config::num_dsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v3-2-8bd7e1add38a@linaro.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678194100; l=5659;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qNGmgSDARDPbwjPqlQOeXVvCmCFaveBX4Casc6DHvz4=;
 b=JDj2+PYyZuOr5jZ965RePL4Lo0u91NdEH45hK5STufYOKg86qRx38/3S1k7lX7SCnycYHyDnYs1b
 9Oui7tGTDVChv+I92HbrRBMdFLxeIejvcvXgjh0IpAssADzHnRoG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting multiple sets of possible base registers,
remove the num_dsi variable. We're comparing the io_start array contents
with the reg value from the DTS, so it will either match one of the
expected values or don't match against a zero (which we get from partial
array initialization).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 13 -------------
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 -
 drivers/gpu/drm/msm/dsi/dsi_host.c |  2 +-
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 6d21f0b33411..4515f52b407a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -22,7 +22,6 @@ static const struct msm_dsi_config apq8064_dsi_cfg = {
 	.bus_clk_names = dsi_v2_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_v2_bus_clk_names),
 	.io_start = { 0x4700000, 0x5800000 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_6g_bus_clk_names[] = {
@@ -42,7 +41,6 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
 	.bus_clk_names = dsi_6g_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
 	.io_start = { 0xfd922800, 0xfd922b00 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_8916_bus_clk_names[] = {
@@ -61,7 +59,6 @@ static const struct msm_dsi_config msm8916_dsi_cfg = {
 	.bus_clk_names = dsi_8916_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
 	.io_start = { 0x1a98000 },
-	.num_dsi = 1,
 };
 
 static const char * const dsi_8976_bus_clk_names[] = {
@@ -80,7 +77,6 @@ static const struct msm_dsi_config msm8976_dsi_cfg = {
 	.bus_clk_names = dsi_8976_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
 	.io_start = { 0x1a94000, 0x1a96000 },
-	.num_dsi = 2,
 };
 
 static const struct regulator_bulk_data msm8994_dsi_regulators[] = {
@@ -99,7 +95,6 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
 	.bus_clk_names = dsi_6g_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
 	.io_start = { 0xfd998000, 0xfd9a0000 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_8996_bus_clk_names[] = {
@@ -119,7 +114,6 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
 	.bus_clk_names = dsi_8996_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
 	.io_start = { 0x994000, 0x996000 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_msm8998_bus_clk_names[] = {
@@ -138,7 +132,6 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
 	.bus_clk_names = dsi_msm8998_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_msm8998_bus_clk_names),
 	.io_start = { 0xc994000, 0xc996000 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_sdm660_bus_clk_names[] = {
@@ -156,7 +149,6 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
 	.bus_clk_names = dsi_sdm660_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_sdm660_bus_clk_names),
 	.io_start = { 0xc994000, 0xc996000 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_sdm845_bus_clk_names[] = {
@@ -178,7 +170,6 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.bus_clk_names = dsi_sdm845_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
 	.io_start = { 0xae94000, 0xae96000 },
-	.num_dsi = 2,
 };
 
 static const struct regulator_bulk_data sm8550_dsi_regulators[] = {
@@ -192,7 +183,6 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
 	.bus_clk_names = dsi_sdm845_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
 	.io_start = { 0xae94000, 0xae96000 },
-	.num_dsi = 2,
 };
 
 static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
@@ -206,7 +196,6 @@ static const struct msm_dsi_config sc7180_dsi_cfg = {
 	.bus_clk_names = dsi_sc7180_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
 	.io_start = { 0xae94000 },
-	.num_dsi = 1,
 };
 
 static const char * const dsi_sc7280_bus_clk_names[] = {
@@ -224,7 +213,6 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
 	.bus_clk_names = dsi_sc7280_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
 	.io_start = { 0xae94000, 0xae96000 },
-	.num_dsi = 2,
 };
 
 static const char * const dsi_qcm2290_bus_clk_names[] = {
@@ -242,7 +230,6 @@ static const struct msm_dsi_config qcm2290_dsi_cfg = {
 	.bus_clk_names = dsi_qcm2290_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
 	.io_start = { 0x5e94000 },
-	.num_dsi = 1,
 };
 
 static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 44be4a88aa83..6b6b16c5fd25 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -39,7 +39,6 @@ struct msm_dsi_config {
 	const char * const *bus_clk_names;
 	const int num_bus_clks;
 	const resource_size_t io_start[DSI_MAX];
-	const int num_dsi;
 };
 
 struct msm_dsi_host_cfg_ops {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 18fa30e1e858..9021f0d65515 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1868,7 +1868,7 @@ static int dsi_host_get_id(struct msm_dsi_host *msm_host)
 	if (!res)
 		return -EINVAL;
 
-	for (i = 0; i < cfg->num_dsi; i++) {
+	for (i = 0; i < DSI_MAX; i++) {
 		if (cfg->io_start[i] == res->start)
 			return i;
 	}

-- 
2.39.2

