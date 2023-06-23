Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0773B82E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFWMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFWMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:51:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FBD2685
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-311099fac92so726316f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524653; x=1690116653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQPYx20u00M+roY3uJQ+vYmQ/eO8mxTFKwXZGsfFovc=;
        b=L1kdnLb0byVMkJxV/V+WUH2ZcGogGK15LBa3VtNBpYSGFU6FkheYu2+MoOxiG4JfEP
         iPc1qfotPFlbPPAi2RfzOdrI+kckiHGbhmzj1WQxRbdOUt9+vilvYiMwAZ1wPEVIXKVb
         nSrwQ+YqCcDB8YbQSPS3OrvG+0PpFdsA388cY7DRNGBkLsVv+01uTccn+60Kgbe6wpYA
         vSwZTqCNd+6Ux6lQ6yNreyuL6AFxPYiz1AkTRyqHATYlKAZtIlYcCQlxJ8spwvOAYmZn
         roX8pu+9qw8q9FPSKhVqcKKiCNgScZlBgZeqx7Q3dDsxofimNaAQ6UEZFgNinaAk6KRk
         d4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524653; x=1690116653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQPYx20u00M+roY3uJQ+vYmQ/eO8mxTFKwXZGsfFovc=;
        b=a93hgQTs3+gNuUEcrcWMsUBrPwd3vfZcYIJ3mqEmBXOdkd6qPrM1zmhUTnm2RseA7U
         mkcXQSRlaGLF4J9533natCLHa479AE6+dxKSbF5Q3nI2PwEK7YrhmS8j1zPrhyj72e3/
         gjxiSu8RfW9LCDxfUsYJ7bVCifBxCFIoJGh5Lu9wC3dmGSFzlgVwXRFVn8t4aCm0zUfq
         pLD3NMoWaWMwD3kiPWm4EQs45w7QyYXzK3AwEyDQSXjJfu3vXzeqA58/ANBhWmJaQxVs
         DMdfzbah+7P8XrAF3wGwJ5Z/405zree26Rg+SF8yDwUnNZy3VPsV9GceWTS/DpFZ6nq4
         VDew==
X-Gm-Message-State: AC+VfDxLH2gT4IKlpD7zN3WmqKqYSPz6gAdrJTX7I1MHBzHOsay6HFBj
        v3b//BrgKRNZ+I+HQWzBfdmR1A==
X-Google-Smtp-Source: ACHHUZ58EcdwBaufREV/IbtVElNkuD8EoWnB43qpGlRzvY1TJQqsTKUu/GiT2DRs4sPcrB1sJjbsIg==
X-Received: by 2002:adf:f203:0:b0:2f9:4fe9:74bb with SMTP id p3-20020adff203000000b002f94fe974bbmr19214534wro.40.1687524653483;
        Fri, 23 Jun 2023 05:50:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm9455350wrs.108.2023.06.23.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:50:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 23 Jun 2023 14:50:44 +0200
Subject: [PATCH v2 3/4] interconnect: qcom: sm8550: add enable_mask for bcm
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-3-709474b151cc@linaro.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4919;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8vaq0sZ17vKC2cKnCb7WrT7B4lW898uopnjsVkfE50c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklZUk+GpE3KkQ9NZ8JuKcjwSSnTwLfwsqcZKJRhV3
 gyjLbgKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJWVJAAKCRB33NvayMhJ0RZMD/
 9SqZFRDijRSb5YcmbiBZJpS6mWEC2FkFU1Zf7f246Vf+LOcuY9VQNfIYa/+7fUVwqRLVIUx5LFOSlU
 foKi/8l1srhiTBP75T6g65BrhNu21DZ+ZpemHoW7JAUj+2eFqu/HTpAy1SqJZcKHota/Od08o0efU0
 8xm9pSN17AyNx/vm+BaTL1x3dJU1ji/yocuHkZalbSEguUJOicQKn2LfCHs/BWkATiWrjHrh+ICjb0
 W2+C5DRGJewboUoPKooTpMV3iuHX3GcOYWyN0h5vPsPPP6r1MyExHWmwITHiGDPxdYN+f/kXjcboEB
 6+wxGbF6M0BgtyUNeYB+IZ95qEMfoVh8HWkRzHky/kyoZuc/taLJSowj/tgHMP5Vbeu07bGWN3yVCA
 UcBQnN8px97WExG1WpYvWsczSWn71Zy6ZokCV6veqasKHFtaLanK6AccD8bIq3AmV/l9qEKe/4l6iv
 sAmBjK+tLf1xZjx5BJTMBHZzi50REh5+NmxPKX8FE9Qa2RPspDoByMi5zqoS9pQKTBvIfhczwuIMF5
 marLjXH+ty5pO8Wr5oDmDCvFToEEeRHHyVySZ4lBKwTai9rPSZVrVTbebnew9VrustegyOhCOTvy7C
 2ugAyoX9ODa3apq0TqPUWGq2FTaNcWCfyFazXVzdCpJ1uoR3XSRn+34kyHZQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the proper enable_mask to nodes requiring such value
to be used instead of a bandwidth when voting.

The masks were copied from the downstream implementation at [1].

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r1-rel/drivers/interconnect/qcom/kalama.c

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/interconnect/qcom/sm8550.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index d823ba988ef6..0864ed285375 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1473,6 +1473,7 @@ static struct qcom_icc_node qns_mem_noc_sf_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = 0x8,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
@@ -1485,6 +1486,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
+	.enable_mask = 0x1,
 	.keepalive = true,
 	.num_nodes = 54,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
@@ -1524,6 +1526,7 @@ static struct qcom_icc_bcm bcm_cn1 = {
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
+	.enable_mask = 0x1,
 	.num_nodes = 2,
 	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
 };
@@ -1549,6 +1552,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 8,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_vapss_hcp,
@@ -1589,6 +1593,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 13,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &chm_apps, &qnm_gpu,
@@ -1608,6 +1613,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qhm_gic, &xm_gic,
 		   &qns_gemnoc_gc },
@@ -1633,6 +1639,7 @@ static struct qcom_icc_bcm bcm_sn7 = {
 
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
+	.enable_mask = 0x1,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
@@ -1657,12 +1664,14 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
 
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 2,
 	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
 };
 
 static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
 	.name = "ACV",
+	.enable_mask = 0x0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_0 },
 };
@@ -1681,6 +1690,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
 		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
@@ -1694,6 +1704,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
 		   &qnm_pcie_cam_ife_0 },
@@ -1701,6 +1712,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
 	.name = "ACV",
+	.enable_mask = 0x0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_1 },
 };
@@ -1719,6 +1731,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
 		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
@@ -1732,6 +1745,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
 		   &qnm_pcie_cam_ife_1 },
@@ -1739,6 +1753,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
 	.name = "ACV",
+	.enable_mask = 0x0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_2 },
 };
@@ -1757,6 +1772,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
 		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
@@ -1770,6 +1786,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
 		   &qnm_pcie_cam_ife_2 },

-- 
2.34.1

