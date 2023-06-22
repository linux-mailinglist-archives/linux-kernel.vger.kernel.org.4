Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183873A04F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFVL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFVL6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:58:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA1D1FCB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so92126191fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435077; x=1690027077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ui/BOOndyfM3aIC3fjk2ZOYgUTAS5R3hDINVZmRj27A=;
        b=G51dqI94M4i4IoL75MXheNZetaeRNUfDFt8S35vZUGj26eZxjgTbZOIzRYJD0HucV8
         rAs3iW+wMcnuDoX4mI6iKB+qLUbMm2L7xSSCes9QNqE1o1/akrk+sJw5ELyoDJcY809a
         tNLjN5qOuj3C8nrdCLNpMxMjEwQiSKJjJKaq3rAPGPix4U25stmqbH08hJxLNcDxqLbI
         pDZL5bZ+tpTUiazWnAjjXgKGB4OSqD399MM8mwrQ0+9BEzHr/KnD36roAdWj9z9kflWX
         uPGTIOX5cJ0ytC8hdZPpfyEBUMdIvCNtR2BBnABIQH2oc2NfHFNWkc5O2AQsBRgcDxp/
         TzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435077; x=1690027077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui/BOOndyfM3aIC3fjk2ZOYgUTAS5R3hDINVZmRj27A=;
        b=fKGGzHBnGGv+TEJiPnU5sfMHmQYYhAtRmYzeuONGQleOGLn3EdxElhuEwkAnzFi6DS
         pgYKwzanIHShFl7q3PFMUcXv5sRawGHWIdrmFxMj62lyA8D8Jlz+1i6Jrg0a3/WCjU3B
         QgSYBEREva6lGV8y+Vv0Q6ISGF0i0qnKu9HtogBeAqtNERRrLF9dLLTg124oM3W4szNN
         XrBOSGeskZimZ8QNyQUhLBuPvoICcbpwjB2OX+tDC+lY7G5S93IPLP2WJgof6vbI9SFa
         DWO6sLjyK6jdGTLFBwd2lEl4Id4hlXsnjZWQqU3UUfiVpCB+IntEo3cLAKjA8/1GwieU
         m1WA==
X-Gm-Message-State: AC+VfDz9/2KUL1cBD8R8JxNKchGp4wJU7T9ssHzLf43HpR4bwtm2sC/5
        R096BN18u6kwyWbN3/5jrKjK/g==
X-Google-Smtp-Source: ACHHUZ6jZm2wnWtDDlVoHE0YsY6U9Cq2xMNnPCpX781Y1UwaM/Zl4EPP3FI3QQ4a+4v3QKgCCe1EKA==
X-Received: by 2002:a19:435a:0:b0:4f8:5905:8e0a with SMTP id m26-20020a19435a000000b004f859058e0amr9990226lfj.6.1687435077710;
        Thu, 22 Jun 2023 04:57:57 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:57:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 13:57:47 +0200
Subject: [PATCH 7/9] clk: qcom: gcc-msm8998: Don't poke at some BIMC GPU
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v1-7-5b7a0d6e98b1@linaro.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=2115;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xt2xPT5OWFY9FXJ7H/2LPYsGPu00r53wEVIqMuapaII=;
 b=2hr6uDLk8/eJg7nshvP5I7TXQUvGJL8vGwFfDFLbEISgkyuS7aAIb5FCtKRIygJ5N7EZdjXrW
 KWdmpt+lRi2ANl52Dl0WnNjZEpFIn2kDxSk8B92YxqJ2G82pnjvV3rB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux should apparently not be concerned with gcc_gpu_bimc_gfx_src_clk and
gcc_gpu_bimc_gfx_src_clk on MSM8998, as they're preconfigured for us.
Unregister them to prevent issues.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index ef410f52f09f..980b5a1b58ae 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2136,19 +2136,6 @@ static struct clk_branch gcc_gpu_bimc_gfx_clk = {
 	},
 };
 
-static struct clk_branch gcc_gpu_bimc_gfx_src_clk = {
-	.halt_reg = 0x7100c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x7100c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_gpu_bimc_gfx_src_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 	.halt_reg = 0x71004,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -2168,19 +2155,6 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 	},
 };
 
-static struct clk_branch gcc_gpu_snoc_dvm_gfx_clk = {
-	.halt_reg = 0x71018,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x71018,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_gpu_snoc_dvm_gfx_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_hmss_ahb_clk = {
 	.halt_reg = 0x48000,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -3032,9 +3006,7 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
 	[GCC_BIMC_GFX_CLK] = &gcc_bimc_gfx_clk.clkr,
 	[GCC_GPU_BIMC_GFX_CLK] = &gcc_gpu_bimc_gfx_clk.clkr,
-	[GCC_GPU_BIMC_GFX_SRC_CLK] = &gcc_gpu_bimc_gfx_src_clk.clkr,
 	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
-	[GCC_GPU_SNOC_DVM_GFX_CLK] = &gcc_gpu_snoc_dvm_gfx_clk.clkr,
 	[GCC_HMSS_AHB_CLK] = &gcc_hmss_ahb_clk.clkr,
 	[GCC_HMSS_AT_CLK] = &gcc_hmss_at_clk.clkr,
 	[GCC_HMSS_RBCPR_CLK] = &gcc_hmss_rbcpr_clk.clkr,

-- 
2.41.0

