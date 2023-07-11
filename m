Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D574EEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjGKMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjGKMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:22:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1C61716
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so88495501fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077976; x=1691669976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSHC4l0gplSJLLulVhlWKIZdx5+fKnKYFEmJEyGDU+A=;
        b=foJDSaBicnp7FQezuElZP030n0/FHiLPO9Fb9DgJh3gvHDsN4ZzbB8v0voLZ5iMeGs
         Qcd0tb880CQOtwLeCPMGv69H30FrFJuXxr03VgECOk5Z/AJkkWQ0zFF4qIh8CwOVZaqO
         Fc8xciynpGkbZbzdsWxDZukLIk49LO65y/9rYUjCG/gpRIeFUlK67IujuMqvTQK9kQJG
         PNrXavuemFDYZ+E8xqZ2cWe/hS2ImNg15AK/sAG4QyMJozRzbaYIklRs3g4mBnEx1Mdj
         ZwMdn8IcsY/aY4qjkUkh+DAbvApgYvXuGaOIF7k09F/BPEzzQiEiUc7o6FdMD7PFzxRq
         LEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077976; x=1691669976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSHC4l0gplSJLLulVhlWKIZdx5+fKnKYFEmJEyGDU+A=;
        b=PJ9JlRhgTmq+5LKfEt9GDHF7U8a8hzCX2h/YRgxKjTURb5WSSiJi1sk6meY5vWdXL8
         u9fdxd91E0NfXUCNOhFhXXbVUY/zbi7a7iScSZqx/cHXTXXS+TVli5MjM7SSLgKeDkLr
         s/43bw4E/jXx/vK6/+K2s0pLd8CrACljrfJSkgRHv75TM+NEeHUy8BrRjfqE+hyDEkMO
         W7YZGex20GreYpeaB8tCzi1GsrIn38s4mBfBpgdopADsKI/s4DA/vrjF0sQ3CA42C7Je
         kxLl+wu7RlpskuW6zBbJEx3NGcnub/3TrANOm9sYCFXyK7NS4biK/Shoo9+w+7GmmpeQ
         lHkg==
X-Gm-Message-State: ABy/qLaY4g06dfLj8LR78IZFz0bph5TY8U9dmCh/lj4gg+17ReDT5nIn
        JzbJ6pb/zh83mSwwPbBN7idD5A==
X-Google-Smtp-Source: APBJJlEU9I11aEXrAvD0lMzre2JXwbJszN+iFqWDfzBtJ6UCVwR0/JRGXW5+TgQ8uUK8clcH2V8gUQ==
X-Received: by 2002:a2e:990f:0:b0:2b7:1c0f:f215 with SMTP id v15-20020a2e990f000000b002b71c0ff215mr6566247lji.2.1689077976203;
        Tue, 11 Jul 2023 05:19:36 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:52 +0200
Subject: [PATCH 53/53] interconnect: qcom: sm8550: Point camera paths to
 the camera RSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-53-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=5762;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=W6na5tQubESsXoW9+LUn1M9R9sjGfLBb8AasT+sD/gg=;
 b=LJKdtd94KUc+CXD5JNWf2ab3MiRf13typSRJvQgEbZhLudJiAhYDUF0t9U94EeCcSdhQdDg6d
 QOliq5sd1MMASebL8OKCdJ1d1h0gofCmuRajrDkEZu5wA0dZ9sXu5ii
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _CAM_n paths are expected to go through the respective channels of
the CAM RSC. Point them to the correct places.

Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8550.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 41314b214cbe..8970fd6505f5 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1696,21 +1696,21 @@ static struct qcom_icc_bcm bcm_sh1_disp = {
 static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
 	.name = "ACV",
 	.enable_mask = 0x0,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_0 },
 };
 
 static struct qcom_icc_bcm bcm_mc0_cam_ife_0 = {
 	.name = "MC0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_0 },
 };
 
 static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
 	.name = "MM0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM0,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_cam_ife_0 },
 };
@@ -1718,7 +1718,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
 static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM0,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
 		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
@@ -1726,7 +1726,7 @@ static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
 	.name = "SH0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM0,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_cam_ife_0 },
 };
@@ -1734,7 +1734,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
 static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM0,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
 		   &qnm_pcie_cam_ife_0 },
@@ -1743,21 +1743,21 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
 static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
 	.name = "ACV",
 	.enable_mask = 0x0,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM1,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_1 },
 };
 
 static struct qcom_icc_bcm bcm_mc0_cam_ife_1 = {
 	.name = "MC0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM1,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_1 },
 };
 
 static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
 	.name = "MM0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM1,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_cam_ife_1 },
 };
@@ -1765,7 +1765,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
 static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
 		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
@@ -1773,7 +1773,7 @@ static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
 	.name = "SH0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM1,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_cam_ife_1 },
 };
@@ -1781,7 +1781,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
 static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
 		   &qnm_pcie_cam_ife_1 },
@@ -1790,21 +1790,21 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
 static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
 	.name = "ACV",
 	.enable_mask = 0x0,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM2,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_2 },
 };
 
 static struct qcom_icc_bcm bcm_mc0_cam_ife_2 = {
 	.name = "MC0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM2,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_2 },
 };
 
 static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
 	.name = "MM0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM2,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_cam_ife_2 },
 };
@@ -1812,7 +1812,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
 static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM2,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
 		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
@@ -1820,7 +1820,7 @@ static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
 	.name = "SH0",
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM2,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_cam_ife_2 },
 };
@@ -1828,7 +1828,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
 static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.voter_idx = ICC_BCM_VOTER_APPS,
+	.voter_idx = ICC_BCM_VOTER_CAM2,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
 		   &qnm_pcie_cam_ife_2 },

-- 
2.41.0

