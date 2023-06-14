Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D62730703
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbjFNSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbjFNSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:04:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35478211D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f62b552751so9127947e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765892; x=1689357892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGw2C5vkxiY4wctjycR/LXyEjdyTIKRRhbkUxP7hBTM=;
        b=BvWUFQOMwUAw+799RcIFhdkQkYEA6nhpj5raefBstGMyuak6gmzcmsnn7Gs7VRS/xN
         hXU10yT6epQMsBmGM8xeAbxkWYOz9lweVMKqiMsN5o3OydSoSCFILVnAJof9Ahbjwxra
         edk/x1FR4RACuMenE258Kq2Gp0/PdBWoPkXbseB00DNkF102wKxUfb1dQIYfnTUTLi/g
         XhIeLO4sJdItbLUefu4IiPNy1feqntFYkAiFqVeraPY8S4ZelHcGqmudTw3kyeGJDAao
         OPWS+kjgfXPB7NUxuw1vMndBAfyMnJ9C3OE5kCMaOws3oILhmpsIBqK+7sTN68W330Lo
         YQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765892; x=1689357892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGw2C5vkxiY4wctjycR/LXyEjdyTIKRRhbkUxP7hBTM=;
        b=WAxqOUNA85rUsQ/VrxzKRhBPaQ5EqeSjVEY6Ol61pKfEgL6ftdJukdlX/6sWEelyZ+
         Xq+/LeOhDwdbHzyvfDq7jp2Y/I8cXt1Prn/p5584/kPKqLf0JKLWODI+P2fZrbTqf6aT
         zCJ67t5EXnGPhd9jVddyph7Z2eHkaAcD1ptiMTb6WJcDGlmHWyQlGOpJ7iiU0xRfRrEy
         Oow/rVOwGdSrZoj4uJWeN7YcqkHYrq4crSg+IYi51jaHXit/TWJ8Necss9PqTWNdBGLx
         2SGv7ifxULkzW3b1TsUQ1ZGqnjdavgbQeT6Jgh5kIlHhMKEL6UhWu32PX0YYL73+K+xr
         cNqw==
X-Gm-Message-State: AC+VfDyTHLZoCGg9noYPDnuO1gFGhpSsty2bzWFL+FzVlGmo8X1GNZys
        AQsQunGhh0l2SOXTJ5f2bHiRkQ==
X-Google-Smtp-Source: ACHHUZ4/LvVs+wlMI7h0NrxPtnCt54xv9IMn/KBKcEzdHKLNVfMGWnrxSx+E1Dma2gNDLU3coa3vpA==
X-Received: by 2002:a19:7915:0:b0:4f6:13f1:38a4 with SMTP id u21-20020a197915000000b004f613f138a4mr7924026lfc.41.1686765892390;
        Wed, 14 Jun 2023 11:04:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:31 +0200
Subject: [PATCH v6 12/22] interconnect: qcom: msm8996: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-12-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=2380;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4G5XsIopPXChuGS66XojsbOsXrnNNj++E+3+a47uogk=;
 b=y/PW+xEjCSkoU+i8wWXoJLlt1BYerNuvA5JwKj+8SQKFX1QQ4dcxvKpaWzV2BHKtLj7aDZFFR
 5fDHwfBfAakByzyoCP94VKOsuHq8wVPt+aWkgU8NRGL+APp+A5qgDfF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index b03b1d454a41..42722681b4ce 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1839,6 +1839,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a1noc_nodes,
 	.num_nodes = ARRAY_SIZE(a1noc_nodes),
+	.bus_clk_desc = &aggre1_branch_clk,
 	.regmap_cfg = &msm8996_a1noc_regmap_config
 };
 
@@ -1860,6 +1861,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
+	.bus_clk_desc = &aggre2_branch_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
@@ -1888,6 +1890,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = bimc_nodes,
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8996_bimc_regmap_config
 };
 
@@ -1946,6 +1949,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &msm8996_cnoc_regmap_config
 };
 
@@ -1999,6 +2003,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config
@@ -2037,6 +2042,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = pnoc_nodes,
 	.num_nodes = ARRAY_SIZE(pnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8996_pnoc_regmap_config
 };
 
@@ -2081,6 +2087,7 @@ static const struct qcom_icc_desc msm8996_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = snoc_nodes,
 	.num_nodes = ARRAY_SIZE(snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8996_snoc_regmap_config
 };
 

-- 
2.41.0

