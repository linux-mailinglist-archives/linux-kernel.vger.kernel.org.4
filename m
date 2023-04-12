Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143E6DF918
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDLOxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDLOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:53:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B3A6E88
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z8so16885842lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681311196; x=1683903196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcBUTwrPn98Ub9uNAVdB99KXgqzNGzqHRdwuVwi4QY0=;
        b=FTE84kV8JcYu5Uc3XNq6UbkUo6STYOeJDee4Oi0FFI5g2B7rq+su2i53iiAZCi/zoY
         MA9UvPc0qtcz7w/pihTBVcZIW88OHfX89fkJyribV8Qc3k3NkO4Vizs2sQ4v8XLHnS+k
         zpwIjJtXmBl6T4/73l56oUYq+9eNpd72crloZ9lyi/yGMFrgItAt1NSSFpTg7wk4cXgp
         v5CMMJhj17eNhCX/UknNx2b4UrT/kfXkoaRoxKT+X4dd8YWF4QX5K27Olhc3PEM/s99M
         pVKxRZ+H/TceYszlcwcOn9M2mzH4CdRUz9DTxD+XYCn36cnBgwMg2diHxsiWFC47+bKN
         NGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311196; x=1683903196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcBUTwrPn98Ub9uNAVdB99KXgqzNGzqHRdwuVwi4QY0=;
        b=73OnbvCEL6nm9p61gSmQEcNDrQdgimenRXZpaar4gAM8/fO0uLA+rS3E1uFal6yJfL
         b8iakEzIEqrKeSCgiG6o7mFrTKwEDqhTSKBhkp4G31RPfRpVKgN10aXK15RU+sMt7N8r
         jD2W7bNaSkH5Arg3ZF9xDN7yF/k+/DV/CMbuiAr19edTugumpd1mCu3/gZxc1mO2Ga6+
         cVlc99UPC6rwT9DXrIKtjGTbiZ7mMUM+vu5XEH7/e1j5D9Fah4WvMepSaygGPvplpIGD
         AcxnM1NaAXIOwXzROBklr8ZHZf6OIdz8T/1HfNwk3oy+LvXxvaBKvRggRYjloJkpaZD8
         AN6w==
X-Gm-Message-State: AAQBX9c1dBORKOPHY6oeF+warD1vhwk0FyVoLpapoWBHPiA+3sQUiKU4
        zno+Aw+sUAadWoOJKcqoZn5r8fssxeaJXBjh85E=
X-Google-Smtp-Source: AKy350Y9FVP7ihnyoOGS8FPwJJAmnb/lbALdSo5FRLgLoL55Oom6+cjZTh74PqxMOAV+qZGCkInBNQ==
X-Received: by 2002:ac2:51a6:0:b0:4ea:f8f0:545f with SMTP id f6-20020ac251a6000000b004eaf8f0545fmr3831047lfk.52.1681311196306;
        Wed, 12 Apr 2023 07:53:16 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id w5-20020ac24425000000b004e95f1c9e7dsm3015367lfl.78.2023.04.12.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:53:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 12 Apr 2023 16:53:07 +0200
Subject: [PATCH 3/3] clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-qcm_dispcc-v1-3-bf2989a75ae4@linaro.org>
References: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
In-Reply-To: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681311191; l=1435;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0ujSVRUiOXtdaFduY1BUwp/tKHCvG84AuQ805mYqR5c=;
 b=44aZNte1QZmDbZwJffhUosLZ1SYc+AmEHM4NinljzKhiUgke/oDbeX8sOLmZe9criHLgNua6QdwX
 8qWTpd6eB7m8nPI7tqzUdpkW24oZmgUlAkzIOqi40/UYZQ6lt7KM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL0_OUT_DIV was previously shoved in under the name of its undivided
sibling in parent_map_2. Resolve it.

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

