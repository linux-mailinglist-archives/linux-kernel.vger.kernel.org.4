Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5473A04C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFVL6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFVL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:58:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7211BF9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b45c289615so95028241fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435076; x=1690027076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BeSpE3Uo2n8gHC5/9wqy8m/N9Ajlsi5ROuDjpnkB8E=;
        b=uN9D9VCrZ/r2UEX6MtywDEFINRAwY0Xmp4Z/J8Qc38fn2mKMGtEH8SxxyGAGkNrJZv
         XgV/ojRqO28ptAy7Sn3JXO6QLfBHM8Y3UTmUHX8iTw6N52UJSmFrII+Scpemkl5TLW6i
         7KUrsepVkTY+Z6wEJ1yMVmMETIB5cfYl8wP5yBWJAGH+MfAdjAsrhxmIHAwjU2gLJvnD
         Sv4tOhpQaqhrbdPw+xR5ENTnEFBg/CPYoqb2dIgh28Yzdaejy8ylVpaHTnoPIpbqHXkS
         jcGYk6HZTaW88U9EJXlkyVg8VTd9f2RkxjukzrcSiu28QSC10vUml+WgHgvhBFZqOiki
         a9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435076; x=1690027076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BeSpE3Uo2n8gHC5/9wqy8m/N9Ajlsi5ROuDjpnkB8E=;
        b=kO/EGz1hlpxdzgNcr8uJ6WcBS1CZRrxOrO9S3r3NqDCjeW/wgw2VZiL0/nIhOgZ748
         /DEzYKn0/pNu2ULiDBXkxkE/KXul0kMS1SUigCFxSNbvefG1qk/ydY0kzyadsXDt2onj
         oCj42NImnii9nOdoCHPKAcqLPcAR7WgnvY2VlHRvWu3I3CviPEKC2Bw2coHzUDQ8OZlQ
         m+WiJITl8Z8nXiskJUefv4tUkxXMNwZd+hxa3bSRBTd9zg2c8cymODnT2Iu3R4Am/vNr
         h7xR4NbH7SRyZKEphVg8uks3GixVeo+IfwXFFITeT27omqEaFRlgSvOezpKDLJpQGEFI
         64Pw==
X-Gm-Message-State: AC+VfDwsvZ1a8zpvJdypejWVY+ld0qS7bP8UaC0XwolCJV19l0luo2TX
        QEfzNTZ8rfAofo/kLvxaOaxAog==
X-Google-Smtp-Source: ACHHUZ4+NaZmD70hTl4GjwDfaM5+0kvxGlaDPhrX+r3D+Ca6PGZQjFY+fu5+mDmEKSPGvsoRUsTL5g==
X-Received: by 2002:a05:6512:68:b0:4f6:3ab6:3d9e with SMTP id i8-20020a056512006800b004f63ab63d9emr9859962lfo.59.1687435076336;
        Thu, 22 Jun 2023 04:57:56 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:57:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 13:57:46 +0200
Subject: [PATCH 6/9] clk: qcom: gcc-msm8998: Don't check halt bit on some
 branch clks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v1-6-5b7a0d6e98b1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=1420;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RMdpPTx0djdmSD0IRCOXo7v4qwhogMdk+CvkRbKSXoY=;
 b=nXGgMQ70zoaumt/TBlld6IqSQFvVaxn2XlqCKqTL97RyXLaeCUKWnUU136fMxxQeDB49j6YkX
 Nay9tUVEsgPCUFc3D8OUJSnju0/0HSp8deMuJoJKr+0Sy8N7N7hXXor
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

Some branch clocks are governed externally and we're only supposed to
send a request concerning their shutdown, not actually ensure it happens.

Use the BRANCH_HALT_SKIP define to skip checking the halt bit.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index cccb19cae481..ef410f52f09f 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2112,7 +2112,7 @@ static struct clk_branch gcc_gp3_clk = {
 
 static struct clk_branch gcc_bimc_gfx_clk = {
 	.halt_reg = 0x46040,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x46040,
 		.enable_mask = BIT(0),
@@ -2125,7 +2125,7 @@ static struct clk_branch gcc_bimc_gfx_clk = {
 
 static struct clk_branch gcc_gpu_bimc_gfx_clk = {
 	.halt_reg = 0x71010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71010,
 		.enable_mask = BIT(0),
@@ -2151,7 +2151,7 @@ static struct clk_branch gcc_gpu_bimc_gfx_src_clk = {
 
 static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 	.halt_reg = 0x71004,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71004,
 		.enable_mask = BIT(0),

-- 
2.41.0

