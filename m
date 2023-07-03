Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265F1746233
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGCSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGCSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:20:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D7E6A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:20:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69f1570b2so79430141fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688408418; x=1691000418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt7V3UlchNnOxeTA5rMeaxcrjkQGtjZo+XDYRU++2Ls=;
        b=vpv3etGnXrrEh35dcbEHYW1nSyzFNZEy/767Pgh23Vnu80xCW8YURIg24i292S2E7I
         jrQ8RX+QYccHX+6ADW0dXKmvV/zz18cPkqaimQb/IPky3Xo7/HSbnbgrbdf46ZgbM0pa
         hD1BcT8M6RXz21wKPk21BEEGEMdd99Zx6Av+pp0LyAz/3I+2NrEcWZSEdrzPJhyKPeTy
         accz4U/BiVbEN2XG4TdertR42GI48Qyx5Yn7CN96aPz5uktTO/nPL/viWzIj5W9wACif
         PxfxXSslREtYASdLoEdSkMjFb0+rp4Xrp61Z45h2LyFPuMguxFEgdVQnisbWiWWJbbrB
         Rk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408418; x=1691000418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt7V3UlchNnOxeTA5rMeaxcrjkQGtjZo+XDYRU++2Ls=;
        b=dARYf8hKsT3jyjzc2rGqbjaTjQ6mYd/AQrOexkNuzlRUDApfkgVBF9eBhGx4KWBf4+
         L88krTAvqM6PvMNtHWjZaWgBSeVBprn8Tqw9vuom3cH7uhSRZvJB7/VZCK6oAqmQ1OR7
         cOxTIlJi2O8OjsnuNZUOca55hRJkIyd4pMSn1KbMGz7tD1w7+CSdwPJno50kn72Fn7hy
         PQ2Kh0vVeJkE/DSC85YNsIWkjMLo7qnu95dqPQtn44YJ9D6l1HUjVKx0Hj9loDzAsjsA
         6CtoOIlc+3v//5VXI4g1JTUnBHabm7lEzhhl8/inXlGOVNWYj3ONgcaqttPEmq4UCseM
         FIng==
X-Gm-Message-State: ABy/qLb9usBfnY3dhQNj+eF5LxTyYQVfeLeLbW0uFtVyKyLeg20R/U6G
        51IaQA7WsH00W+DmXvyxvVDBbw==
X-Google-Smtp-Source: APBJJlEOcD/GenKzzrw8vw5DZ6VZZU8FGH6FFaiD7Z7m5NhSozho296b0yqM5RBCzF2e8eXFhnAh5g==
X-Received: by 2002:a2e:9059:0:b0:2b6:9909:79cb with SMTP id n25-20020a2e9059000000b002b6990979cbmr8308978ljg.42.1688408417855;
        Mon, 03 Jul 2023 11:20:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e9c09000000b002b6995f38a2sm4946224lji.100.2023.07.03.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:20:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 20:20:10 +0200
Subject: [PATCH v2 6/8] clk: qcom: gcc-msm8998: Don't check halt bit on
 some branch clks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v2-6-6222fbc2916b@linaro.org>
References: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688408407; l=1472;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=viesbfDPZKW9ahGiPob2JBLSqZxiLZQDZKyuYqbzZTo=;
 b=ISB50XHa+GvfrRMOqhYdMo/UVo1dJsdoFWkSeQP1LpOycDTxnSvD3Uk7LzgTPleZL750EOjEM
 wY5p0o2x5bFDrPaT2fUtoswPpgixUEuOBZ1XrhPD9XifJHjRvie6ZE+
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

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
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

