Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE01734DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFSI0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFSIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:24:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FEE64
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:24:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2261789f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687163086; x=1689755086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHbeGiy67UyCnv7xUd7e5L5v4opOjGa7V1cKA3irBoI=;
        b=LaYmDi6DMwM3sfRV/Z4WyxN8uju+TlzZnLXxpTubfYqpWqAJ/bWSVd8sHZ4cl7m/7k
         HOD6VlmS2T87jfQT+pXLo4ONzuI7enuJI2X6c2uFphQgogL+rYRDgE59m44Fa+Ebfg8H
         sAzZ73Kfg1Lu6sOGEL7/bsuUBWgmealHPtBDYUiOqZ9KnMGbxZ+Dj0mpsISf1B4SLglO
         mrImMsxLbOCLGl0U3lMQUOESXVQn9z+BAx/0aKqdFyypdgtEogiZFE5Msz/dusl6/jcE
         CAc+e80FyiWSQKzr9cPzgmN42OKhkcJaag7w0KCpbQ6XBAPsRau46d3ItrpwE+JuwlC9
         RS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687163086; x=1689755086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHbeGiy67UyCnv7xUd7e5L5v4opOjGa7V1cKA3irBoI=;
        b=cW1XHY39yDZHPhNAKAZAdOrZYj1AlO1Ho/I+D6pykCNDB003QJSOcl5JGUYfR9D1Yg
         mWroE7guPnKWj9rHYQwtTvF4JEqb94C/zyCQrbg+3Cjh0IR4zUHBjDCQu5u6xeQ4yMDR
         6SkCDM3Mhg1SvlNUMhG3CXpPzcUUQtmpJkd6ctxb9Ovg4B6PDIvp/hjBiYkPtHXPe4tL
         xcMNXworaNI4bWXGPuHszNGTG+MJ+CnasROmmKA9ew7Y0Q2vUBAAsdOzy9bsBXyvykQm
         3boroZguVBz8XqBRo9ymmRX3XIeGMVNdKWLVsYcgECYMjgkp/LZESMata1n0RLBxT5Ra
         79Ew==
X-Gm-Message-State: AC+VfDzE8l3ZvFgpU6mRaxs38XLNqjlbM70PcGGkM2GJ303dDhHldo2D
        mwAirVkJWua5PIrHEsQwFXKcoQ==
X-Google-Smtp-Source: ACHHUZ6sqMEuw/lSjs1zFYAnVAfqxpwYi9RGi/eqBNKRm+xCYthzer57Y28pwkdJRlPdHC67kr99ZA==
X-Received: by 2002:a5d:4a51:0:b0:309:419b:925d with SMTP id v17-20020a5d4a51000000b00309419b925dmr5685615wrs.70.1687163086318;
        Mon, 19 Jun 2023 01:24:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i1-20020adff301000000b002f28de9f73bsm30781262wro.55.2023.06.19.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:24:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:24:41 +0200
Subject: [PATCH 2/2] interconnect: qcom: sm8550: add enable_mask for bcm
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-2-66663c0aa592@linaro.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uIHdrS4LyC51s+N5izPggR2Uy3XcHfTE+9d4aVoV1QI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkBDLQdRob7w9vaGY5x7J+Xplj9H1IJNgfJ+LmDUd
 174ZHMCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAQywAKCRB33NvayMhJ0RDbEA
 CdTc8N3b7YocBH+QETbvesSXQWMtOUl+rmPgdcnoJzqUXSVxuTAVdYG/hdHbgjN028CYXt4H5hnmal
 DTqbsTZFrbx39xC1R+W/zbJ8r8uWhn9SR5uWeGB7mJEIctUO3xcSWXcUfNsyczmJ3NF4Xqi6x0D57Z
 0+O7OanbARofMedbTetNdXyYlGF7MUxRocLsl9QTDE9ssVksKFRBQqwAWV5LhkrGAxC5QIrprRmEo6
 QpcnfRJvo6HfXEiof+iWzN/1FPtdgrhf4wd1eZ3Z21x1vtWnrNzlg6orf/H9mDo9d2Nl/8+qOI2RCC
 M/4pYiAkk/xeTTupq21nkSZtQKXTr1U1UvIBQIbmGsPj2kUywjcmnr+EA54aEApCPK+MXmZ6VK6jxt
 eVzLeUYVI+lmwcu3JNXBQe/Bwno/dh4kZuy9pd8ZiRm0y9DbFrVTiH8nbKskaydQYsfbyF22MQlRpC
 eIbTfL+9M7nj0TU5N8HggDQdKXTIQM4nGJ84SI9OJSsX1ZIe0cV0D+VY/LVCT4o5fxiWyX38HmlXV/
 EgUDQqTAd7OlOwVAGGvhuMJTuOKJLtGeNMnIBMvp3fpuzxBBUaGynalTS7m57hX86rMJ4SDypICzgC
 86CQS+LgM7K0KYnSg+dp0XwEc2q52P/grfz6Wl8V8PRGazhyh3qYwKFVvkmw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the proper enable_mask to needs requiring such value
to be used instead of a bandwidth when voting.

The masks were copied from the downstream implementation at [1].

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r1-rel/drivers/interconnect/qcom/kalama.c

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

