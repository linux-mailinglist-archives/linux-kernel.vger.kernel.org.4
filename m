Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E76E21BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjDNLHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDNLG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:06:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38BA9759
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:06:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e11so22827895lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681470406; x=1684062406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+BegmIBTVhKhfD7Ho/4urS4COPOO81dhsHGg9scGxg=;
        b=g5SRt2qS60TT+OthyGZDbd610efz79PA3ocDVEaVSAiUHGQhajClLWlRxA2GpHWSRI
         Cw9tu5buoFzgoMKKnKnsImCWi6rm1QfdVz/K67DdvUQBu1qX6EG89VajWvN7yM9NKpK+
         8v7zwGIU1GJW689hNf8BQIHGNO/1ElpaafFn+dvuMWJ9ejE90yaQXSSIP3kiyimeydqz
         Q2adtFPYMK8L6I+GnxzS5NjhN9YFcW1tMxynJ3SwKdZamQTUcUD2JZ1RLFoT2g4VSsF8
         Ut3q30cqPYqlRWK4VSoe4q8YkqVpynk2NBtf9kMTSyTcxU2vg77EjEQjkZ7N7eZ9oZ5p
         sEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470406; x=1684062406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+BegmIBTVhKhfD7Ho/4urS4COPOO81dhsHGg9scGxg=;
        b=ZJ8meGLJPnS4rzGEM1vBTcy4t4pms3xTM8cW+YpZN5PtwMS9h1BVDx4a4URVL/sYFo
         hDKcUyyq050C6gPlVwrKma6k+g6XdxgUkq3fmIG52c+679eY9Z6FgrOyRNzvfnwZ+M3K
         eGzuDkC3jvMO3MylOq3e70OqIK5o24+BkQSVAYfj0iRse5K8xfNZsiGcHdcsGO3u02Or
         wFYvQn2ShUdImL2So91/2zHf3OhBjglEG+jePZU5Lrm9qSkFPnnzMrFvv3yt9bQ8yqax
         M9n9OSbFvodoSIyYStq3+e1fgEV+/3+zETJD2HjL7Dae1QDvpJHyUiq1UkSbb14Y5Xmp
         l48w==
X-Gm-Message-State: AAQBX9faLraEt0jz4MSVMs9tSJu4Oyn1wy1tSTnqMZwahEmh8i/4pLPO
        yaXiYzQEyPLa7VuPAvO3oFNPUw==
X-Google-Smtp-Source: AKy350Y5RSfc0jxAz4V5H/b+H1oE/ntfZSqGOdGhrQtvd0IKywMq/ZbPezMiiV7I/vHZ8iTsV21lNQ==
X-Received: by 2002:ac2:4893:0:b0:4ec:9c2e:7ee3 with SMTP id x19-20020ac24893000000b004ec9c2e7ee3mr1864801lfc.42.1681470406087;
        Fri, 14 Apr 2023 04:06:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id j18-20020ac24552000000b004eae672e96bsm751398lfm.255.2023.04.14.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:06:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Apr 2023 13:06:36 +0200
Subject: [PATCH v2 2/2] clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-qcm_dispcc-v2-2-bce7dd512fe4@linaro.org>
References: <20230412-topic-qcm_dispcc-v2-0-bce7dd512fe4@linaro.org>
In-Reply-To: <20230412-topic-qcm_dispcc-v2-0-bce7dd512fe4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681470402; l=1630;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Ot/NHrSbW9+5csK1UT6o/fdNmdPt0KfTHT6AeS2TI2I=;
 b=Iwup5TWH8WazTzIVIvw0JEF6tfjNqgQIirmSDcAM4ppmZOoCZu7eDYcqsSIJAMfqcxPpkJPRjy0C
 ASL/xmAbC+FDIH5KpOxE7bM+61Pm1zzKfrTv1gH6Xtk4+4wH4Foj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL0_OUT_DIV (.fw_name = "gcc_disp_gpll0_div_clk_src") was previously
made to reuse the same parent enum entry as GPLL0_OUT_MAIN
(.fw_name = "gcc_disp_gpll0_clk_src") in parent_map_2.

Resolve it by introducing its own entry in the parent enum and
correctly assigning it in disp_cc_parent_map_2[].

Fixes: cc517ea3333f ("clk: qcom: Add display clock controller driver for QCM2290")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-qcm2290.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index ee62aca4e5bb..44dd5cfcc150 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -28,6 +28,7 @@ enum {
 	P_DISP_CC_PLL0_OUT_MAIN,
 	P_DSI0_PHY_PLL_OUT_BYTECLK,
 	P_DSI0_PHY_PLL_OUT_DSICLK,
+	P_GPLL0_OUT_DIV,
 	P_GPLL0_OUT_MAIN,
 	P_SLEEP_CLK,
 };
@@ -84,7 +85,7 @@ static const struct clk_parent_data disp_cc_parent_data_1[] = {
 
 static const struct parent_map disp_cc_parent_map_2[] = {
 	{ P_BI_TCXO_AO, 0 },
-	{ P_GPLL0_OUT_MAIN, 4 },
+	{ P_GPLL0_OUT_DIV, 4 },
 };
 
 static const struct clk_parent_data disp_cc_parent_data_2[] = {
@@ -153,8 +154,8 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 
 static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO_AO, 1, 0, 0),
-	F(37500000, P_GPLL0_OUT_MAIN, 8, 0, 0),
-	F(75000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(37500000, P_GPLL0_OUT_DIV, 8, 0, 0),
+	F(75000000, P_GPLL0_OUT_DIV, 4, 0, 0),
 	{ }
 };
 

-- 
2.40.0

