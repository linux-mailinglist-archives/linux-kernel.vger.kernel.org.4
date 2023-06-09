Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE472A478
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjFIUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjFIUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412A3C1E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso24175441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341969; x=1688933969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=ne9sxJh4WRlTO6IrZRVrQCOT6AqS5fidAFKk6ofL9ONi8f5K1Ytun+KGssoGIpHWIp
         tt1Eq/so81xZBLBmU3/sRsYxasS+J7dyNR+inK8vR8kawjEWRiXlgLQGPFGoryIgE+la
         5+NpSqt3SIm5n26fqsCrfe5ylD1IrxexTreffeo475Q5igC5AfUwEw/81fiRVSIiLzF+
         AfbxPJY0vbJZBWql/0EtOAz0hwBOFz1Y3e1zHt4oJ/1DQTQNxl6b85FQ9sv81BzjM2FS
         yWxyKhd4nN36aieiLUuFFn2fuMlmXPYjAdD3/7AZ1sTE+Ylqs9kd3p45ABZCoC8H96me
         6mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341969; x=1688933969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/J5ZhP262QYGYmarLd4yzENGlRt7ikJiCOlHTeoidM=;
        b=BEtnY9AsDqyU9czrfaTGQkaG8Jz/67jdOAtR97jGmvZCdtNif+klx5eLDGL991+l0q
         0sUSu5EEdgttWlGGAOaYXtu38EfBT0CkNN5AltMA0PMoxNcjWdR+T7SYAQ9tmTJdhUZe
         lPJlK6toffRq8Y3+KV/YndOwxw8gsJaKzSD8HfjdW1Uf1AeuNuly6wVsnV+lD79T+g0C
         Cqv0oxb2rfylyFIJTlXus3+2/107n09UtCAtEnw2hzx8vhD8d5V/txaNxux928iVg/A7
         XHhZaCh1bVPEivVa5QQF8QYz9XSTgjc+ob53zlZWy23Zz6npWwF4ScfPow3EKBlQGhXf
         bvkg==
X-Gm-Message-State: AC+VfDxn55v/gDjtDOuNOjUF2D0pm5o58JWTgZvjM366NtctvHdsxRpy
        XzV3szrcghxaIJcZGQU5o2/MMg==
X-Google-Smtp-Source: ACHHUZ4xqAK8AuledRjnOigCBShad1if3VHAIZpwD2WAqQQSmIFxU/DlP9VVhT+KWDseAfEuDp1OnA==
X-Received: by 2002:a19:6706:0:b0:4f3:aa29:b663 with SMTP id b6-20020a196706000000b004f3aa29b663mr1474307lfc.35.1686341969154;
        Fri, 09 Jun 2023 13:19:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:16 +0200
Subject: [PATCH v2 11/22] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-11-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=1986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Krc2Kcr5fnOQoU3m0Y+nr01slcqtM3Q1E0UfX4Ye6Q4=;
 b=sOxKuMZDi2Sv0ZJT+rBA5GRTGFjZDU/L2gedaTsYn1y0hrQsXEdNhtuG7lfrBWqHsgVCQ2cX8
 2+dKfhyzUXqDotzTIycNzhOC8Y1Krk8I1xRlDwjJZJ15UdXvFUy/yRz
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 003fc7d110a7..5743ed680e8e 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1511,6 +1511,7 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
+	.bus_clk_desc = &aggre2_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
@@ -1539,6 +1540,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
@@ -1593,6 +1595,7 @@ static const struct qcom_icc_desc sdm660_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &sdm660_cnoc_regmap_config,
 };
 
@@ -1655,6 +1658,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
@@ -1692,6 +1696,7 @@ static const struct qcom_icc_desc sdm660_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &sdm660_snoc_regmap_config,
 };
 

-- 
2.41.0

