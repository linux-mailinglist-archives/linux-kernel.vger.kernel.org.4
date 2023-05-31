Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276A717AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjEaJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjEaJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:01:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B6B124
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:01:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so6517775e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523691; x=1688115691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzn4m2H/FTJRfB6bL/ET9uNQCruK8cNknsLXsMEBu2E=;
        b=ROrn/OQ80wrgTm1WTNqqnPiEHuLEDkI0JODJbZ1ec7jx2JPoLm5jeP/VoCbaSGPqtd
         zCisK5VEiJuxY8FIDnLQStny+QIu5xosh2X3f1g9gGx1O76QXPRzCnqYRDTRQVWP67nx
         LTcjetWRP+UdP8lwt536SsagLUsDsYCq+PriKUhcIV0GKmwQKkCxAcuFwDiaX+FXMqGL
         ZrV9r2TSkwUs4iVB47w3PcemwSYSsIy0Ln4AWl5ChIkjGgv7T9TNRjtlcs3fI6d23Wdd
         QBTATxzzbnsmaxHlfDN623sKRNDhflTPKwOiD26/l9barwljGDvXFh1KK83HnakqIGbE
         sxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523691; x=1688115691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yzn4m2H/FTJRfB6bL/ET9uNQCruK8cNknsLXsMEBu2E=;
        b=EeW8TMB8ZoUYjPUI/IdHuIsub/6XyAzbpnHCEylU3Lh5vg6irMG1xooWZgbG7Bq/km
         Dhjt7ON5tAS6gi8lWADfbCF85zqvegceR+H40MF3om2GG89i5XJYhOrwI3I8ytW6e0pO
         aAd8MPG0LPWUjluwSK066WZMuWln1eTCc1T+dLDT7pfhVira+sMZY55DdccznAdKbr4M
         MEgXx51j9tHTnllmBvQ08vcTAxVMKRgBQpp8buR5LRhMWcGf1hIY2jC+D3YEwxXD0pGy
         5YCw0sclEsOjNAEEwKwJ3LtxGLs5GQaq/y/glCfmsY9KUVqOO0yBlIVR8oo+D7yh5jf0
         bAdA==
X-Gm-Message-State: AC+VfDyfOVVeRYEq7tGNKZLlR4YASYNEUKCzDVldw+tc1uzEmvp6F5jM
        qCFqCr3R2aLAzHOOgaLKMy/mcw==
X-Google-Smtp-Source: ACHHUZ6eAO4MLkWKSzQ1EWOX6goASrvWTAshO8u2qa5GJ5XpLI20XqQHeTybKLJ5NCy67gNHZnv59w==
X-Received: by 2002:a2e:3e01:0:b0:2af:1262:e917 with SMTP id l1-20020a2e3e01000000b002af1262e917mr2085788lja.25.1685523690859;
        Wed, 31 May 2023 02:01:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e9184000000b002adbe01cd69sm3217446ljg.9.2023.05.31.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:01:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 11:01:21 +0200
Subject: [PATCH 2/4] clk: qcom: gcc-msm8998: Don't check halt bit on some
 branch clks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v1-2-2b5a8fc90991@linaro.org>
References: <20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685523686; l=1575;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3hJNNh4/9lwYUqpHcPuPz2a/mPNaOro7+/PxaHyFiI4=;
 b=D1cKQbxl6Xtd1J+LgAXmgHxu0Ctd1287EHb5ahT81jhB+8oir0bvlwKU/9Yd7q9zlcE9kYHd7
 LbEi/VMCfCUA4ssNg9vYIWFjz1hEtBchnbksdUULcaB26XqQFz2Sv07
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some branch clocks are governed externally and we're only supposed to
send a request concerning their shutdown, not actually ensure it happens.

Use the BRANCH_HALT_SKIP define to skip checking the halt bit.

Fixes: db2c7c0a04b1 ("clk: qcom: Add missing msm8998 gcc_bimc_gfx_clk")
Fixes: b5f5f525c547 ("clk: qcom: Add MSM8998 Global Clock Control (GCC) driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index be024f8093c5..c343bdfc3cc1 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2061,7 +2061,7 @@ static struct clk_branch gcc_gp3_clk = {
 
 static struct clk_branch gcc_bimc_gfx_clk = {
 	.halt_reg = 0x46040,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x46040,
 		.enable_mask = BIT(0),
@@ -2074,7 +2074,7 @@ static struct clk_branch gcc_bimc_gfx_clk = {
 
 static struct clk_branch gcc_gpu_bimc_gfx_clk = {
 	.halt_reg = 0x71010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71010,
 		.enable_mask = BIT(0),
@@ -2100,7 +2100,7 @@ static struct clk_branch gcc_gpu_bimc_gfx_src_clk = {
 
 static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 	.halt_reg = 0x71004,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71004,
 		.enable_mask = BIT(0),

-- 
2.40.1

