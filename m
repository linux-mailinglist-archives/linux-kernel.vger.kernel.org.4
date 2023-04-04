Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5B6D7046
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjDDWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjDDWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:47:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E572D61
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:47:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k37so44338337lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680648464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9hExFqp3rfsa5Xr1FlWQxDCQKu/ifdPHYr+ePtML1g=;
        b=pnLRtgO/bJjn2T6YqMKU0nCLmdge+M6jC0+9/I3Ij5FtgLe4ud041XUXIfN+gWE3wr
         fMyDC7gfIjcR6gwyN3Oj4IltTHfQbGQPvy4O8UEDliwt1NXtS9QRCorafV9A5+KnIFne
         os1Gvc6mznp2M0IAVThrrP1fRjzoiByoIhP1RMXH7oLXWt0skOYG2YrqmZe6RJVfsXj5
         mXKPZN7t/WAPms3RFUcOh0zREuYTIT9G39QqvbZZo6Jhc0r4jOhr/eicd7Fd5fIsTV+N
         BMano6hqvbsHWodLanAD9PIqYEadaarfyY+LtsnUUSCowJUD5gupm4fPOHBuK0+OP+7A
         46Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680648464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9hExFqp3rfsa5Xr1FlWQxDCQKu/ifdPHYr+ePtML1g=;
        b=BIsTUuMmzr8f6kG71LXv5uVzJTUM2eZkk+IzIiNRYAYhd2m8mmjOyw7rikAiLW20N9
         5G3rVIeKF1C32CeViVT4gj7+JW94KgLnMSEnflLTNeSfzN9CkB+zRtfrRFAf5o1r6og3
         t4qelVBolvLz3mWkMnzNZm9EG73KD81kvt5wGU0B++pGtuQaLMbgn6oVrHRO2E1ppGoH
         cNN8pYBY9QOzVCCkLM8NjPUR35o//lGshdyzJHFcx6c6C8RF3fXRQja44YF6/CjPJhKs
         WkNArDuKlD6gxZzpQH16BesWqAZ8vFbC3uXFTNqz+V24M15ZfMJ1MQQlwEfd5NtN9/Fq
         mKLg==
X-Gm-Message-State: AAQBX9cXdW/HehkESDR5VymESFln8Q91SRLXr5FdqTzcZmX7kNkJ5VYA
        qgM1K/txmUPYLBjYW+oRvmmDow==
X-Google-Smtp-Source: AKy350ak7OUgZo6HPs4brOwgTKEHifOyuewZv8S2pt0pEd/FnNxQ1gfrVeFunCR7KnI7ySOiNBLp9Q==
X-Received: by 2002:ac2:569e:0:b0:4dd:9b6b:6b5b with SMTP id 30-20020ac2569e000000b004dd9b6b6b5bmr1169547lfr.16.1680648464286;
        Tue, 04 Apr 2023 15:47:44 -0700 (PDT)
Received: from localhost.localdomain (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v14-20020ac2560e000000b004e8011cbaa0sm2508307lfd.111.2023.04.04.15.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 15:47:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, bhupesh.sharma@linaro.org,
        vladimir.zapolskiy@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Iskren Chernev <me@iskren.info>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm6115: Mark RCGs shared where applicable
Date:   Wed,  5 Apr 2023 00:47:19 +0200
Message-Id: <20230404224719.909746-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vast majority of shared RCGs were not marked as such. Fix it.

Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC) driver for SM6115")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6115.c | 50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index ceb7abd961ac..20ebee2c2005 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -694,7 +694,7 @@ static struct clk_rcg2 gcc_camss_axi_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -715,7 +715,7 @@ static struct clk_rcg2 gcc_camss_cci_clk_src = {
 		.parent_data = gcc_parents_9,
 		.num_parents = ARRAY_SIZE(gcc_parents_9),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -738,7 +738,7 @@ static struct clk_rcg2 gcc_camss_csi0phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -753,7 +753,7 @@ static struct clk_rcg2 gcc_camss_csi1phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -768,7 +768,7 @@ static struct clk_rcg2 gcc_camss_csi2phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -790,7 +790,7 @@ static struct clk_rcg2 gcc_camss_mclk0_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -805,7 +805,7 @@ static struct clk_rcg2 gcc_camss_mclk1_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -820,7 +820,7 @@ static struct clk_rcg2 gcc_camss_mclk2_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -835,7 +835,7 @@ static struct clk_rcg2 gcc_camss_mclk3_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -857,7 +857,7 @@ static struct clk_rcg2 gcc_camss_ope_ahb_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -881,7 +881,7 @@ static struct clk_rcg2 gcc_camss_ope_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -916,7 +916,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -941,7 +941,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -956,7 +956,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -971,7 +971,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -986,7 +986,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1001,7 +1001,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1024,7 +1024,7 @@ static struct clk_rcg2 gcc_camss_tfe_cphy_rx_clk_src = {
 		.parent_data = gcc_parents_10,
 		.num_parents = ARRAY_SIZE(gcc_parents_10),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1046,7 +1046,7 @@ static struct clk_rcg2 gcc_camss_top_ahb_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1116,7 +1116,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1329,7 +1329,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1351,7 +1351,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1392,7 +1392,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1414,7 +1414,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1483,7 +1483,7 @@ static struct clk_rcg2 gcc_video_venus_clk_src = {
 		.parent_data = gcc_parents_13,
 		.num_parents = ARRAY_SIZE(gcc_parents_13),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
-- 
2.40.0

