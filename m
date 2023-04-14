Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12E56E21BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDNLHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjDNLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:07:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5686599
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:06:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i6so11155826lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681470405; x=1684062405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMYMl2ifsB/W/YSsZX4ho7CAb5MXEt6JddjCfUBoXWc=;
        b=I5dMM8CmLImhWIReAg4whN6HRPHrrIZUgjO8DTM2z6QGvFLOZpUvi90CvfubIAjCLw
         MA1GJCryG1ELTxPW728bHrXAiCIs3lPYpEjmozxlFnrwJWQXc35rLUu12eUG5WVZMthR
         gcjtvDdWcJ7C1w6MQzNioTbgTnIZ8q4LRC9S6fLb8I7ga7I0qyuVuwmHFHvgJsPuyC4M
         G+L7DZ2K36NDL4ojD6mRaQt0P7rE2Iw8gYfI7/G9vXHVN6PV9Gx7izgULsxswuwV3aAr
         PCYdrjGY/kjbaGsODQaTlFhxP8Z441aPeLGZIJSW4xvwjl+/H3M8uodjDC/w9+qon8Cb
         JJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470405; x=1684062405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMYMl2ifsB/W/YSsZX4ho7CAb5MXEt6JddjCfUBoXWc=;
        b=WqRkKc0nKyFTlb2ceeKLbtmc8BLjs+XtPnys+V1U2wGs699qsoFpTJ9VZ6dvJ8r3f9
         ZAhT5YfafKsAhVDCTgEo3cxdbq0haSOZ/l/SFDLymNZ9xH262qBy96IgmCADQZ7bX4hQ
         V/pcF+XUufG4Ml8BJS4npdMGNl9jWHaigdbQDuKgH3idnj8a/CNTekEMt9qPvZLoWzbT
         8mZgdnEasmYVLG4/+wOzRXvlv0dXyzSq6lVDhM4iAl463ZT66QHLzfRTPcN6es1mjs8w
         JhlzagykllwctCJC36lcDhTsRGHyXXNub6oSHU/CC3HlpeJNB+XumQc7ydswF3WT2vCZ
         0mcQ==
X-Gm-Message-State: AAQBX9dgnU6uhJ2ddLkK2H4vATHI3+WLi8xb//qbMSD1rphiHB/Sx/Hx
        64hQNBZfyD6+4JOvEp3Zc9twJg==
X-Google-Smtp-Source: AKy350aX9Ui41IrGKcRJRxVt3BVFPljIGXNdhMEomIKPucGsbJtU9Mdph41NKbhuDFgPIC+0sUo6KQ==
X-Received: by 2002:ac2:5186:0:b0:4ec:89d3:a8a4 with SMTP id u6-20020ac25186000000b004ec89d3a8a4mr1938022lfi.31.1681470404997;
        Fri, 14 Apr 2023 04:06:44 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id j18-20020ac24552000000b004eae672e96bsm751398lfm.255.2023.04.14.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:06:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Apr 2023 13:06:35 +0200
Subject: [PATCH v2 1/2] clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-qcm_dispcc-v2-1-bce7dd512fe4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681470402; l=1442;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=73vWeRsxULxsTVXt8fy3JbmdlkHXYRh2zqlvDKixePU=;
 b=klqeNgs4fXDoPiNelL6kgiOMXIkheqGeXB3qXqFzW9T7u7aojyCS3BnOA/+58IShkSe6Ug/wsKAR
 dVQM6J9nAyADbHTyClq3Fh1cEFfZvFKKo6i7FqOBuMkJHB1QRAwL
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

BI_TCXO_AO (.fw_name = "bi_tcxo_ao") was previously made to reuse the
same parent enum entry as BI_TCXO (.fw_name = "bi_tcxo") in parent_map_2.

Resolve it by introducing its own entry in the parent enum and
correctly assigning it in disp_cc_parent_map_2[].

Fixes: cc517ea3333f ("clk: qcom: Add display clock controller driver for QCM2290")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-qcm2290.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index e9cfe41c0442..ee62aca4e5bb 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -24,6 +24,7 @@
 
 enum {
 	P_BI_TCXO,
+	P_BI_TCXO_AO,
 	P_DISP_CC_PLL0_OUT_MAIN,
 	P_DSI0_PHY_PLL_OUT_BYTECLK,
 	P_DSI0_PHY_PLL_OUT_DSICLK,
@@ -82,7 +83,7 @@ static const struct clk_parent_data disp_cc_parent_data_1[] = {
 };
 
 static const struct parent_map disp_cc_parent_map_2[] = {
-	{ P_BI_TCXO, 0 },
+	{ P_BI_TCXO_AO, 0 },
 	{ P_GPLL0_OUT_MAIN, 4 },
 };
 
@@ -151,7 +152,7 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 };
 
 static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(19200000, P_BI_TCXO_AO, 1, 0, 0),
 	F(37500000, P_GPLL0_OUT_MAIN, 8, 0, 0),
 	F(75000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
 	{ }

-- 
2.40.0

