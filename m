Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA074EE60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjGKMVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjGKMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:20:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4971992
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso92182921fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077948; x=1691669948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThAQrJ7R6+CZY+eIpZjoNgSk7Z3cW6pivMcCj9NSePU=;
        b=yEA79tCQes54jRaZ6ASR8H7F38odOn675WNwWSqj8OJBRLPONSninEwMhmXhf01X0J
         JLleC+GJnQGvg3d1luLcrWvLje+OcwJfBa7YPE+4LgMpiC7KunXpbtSt9UcoTw9GvRtv
         kqngKcWyEBdIer9QZDJlj8LBiE4v0jyjvjOkDzoHlQ0B2GNRuQBotbpbBowZo1Wacee/
         Sbhpg0iNW8RPqLMBT9yWCI/sWR56ZsDOTt+z98Ba9/0rVyP5Cp4LFSFa5tSNwktNh9LA
         3vQx8GhXDNfdS8SgzGuj3/ujKUNGgXhjkr4+01kWXrEbohYWNcOkckvYKIqKZmjU8jVs
         ld1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077948; x=1691669948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThAQrJ7R6+CZY+eIpZjoNgSk7Z3cW6pivMcCj9NSePU=;
        b=Upv1uBM2H9zM4M1tWOsOqAtvt+5eg+kNdPXs4vE6jfFL6ms+BnWbf7XMwEyiiqNjhE
         KFzY6qU3xR/iAh/TA0T7D7a1nNaSIujYo5B/1EYRksEdDVDgtAJ8JtUrt54Alt2/mugR
         ifHBjne5yssYiwWsKSdGBdTUKrJiw0XLIvP+nM+lZYKBUka9DdOI5IOuLU4jNWzC+ql/
         Jf3SGIIJnbs5q5BKMwcPRZsX9ZE0h2xNMARYiyACP3mUcpoLPhK4ZYJy/izyfxWoL1iN
         1pKHhHMTELBJAhBAoajaqQrWY1sJPuue8CZjvsTGC6XYqjvQSzWLOu1nVqaEruJzn/Fl
         byaQ==
X-Gm-Message-State: ABy/qLYnkEJYOsBl+UmKlGjNG/6rgGtF6hLxXMphPnflUmE9osHilgxg
        5DbjtniEalzk2v+D32iG8dNYDQ==
X-Google-Smtp-Source: APBJJlHjlE3XyAPhdo9Z/l+hS80ePSXlcykvRRoBhAB69p2Uq0MlTDx8wJzohqfTtFhO+jIyi/jzbQ==
X-Received: by 2002:a2e:96c6:0:b0:2b6:eb8c:af06 with SMTP id d6-20020a2e96c6000000b002b6eb8caf06mr13118656ljj.8.1689077948016;
        Tue, 11 Jul 2023 05:19:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:30 +0200
Subject: [PATCH 31/53] interconnect: qcom: sm8450: Explicitly assign
 voter_idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-31-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=5852;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=I0m5AL+30JxxsGRzPqVcr4YQAJm2OVM5Cn2T0SByiyw=;
 b=WvhVcfnpVCw2fiB0NJVs0AmEGvXFtkSXcpGBzJbdk2JMg7zxPWG3lUNV9rCQc50aIayKpYc40
 5xw4Gnu63tTCAUQIB5T6KtLbd7AU/VloMGOHlznCeW79Pic5gSqvTfE
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

To avoid confusion, explicitly assign the BCM voter index.

Note the assignment may be incorrect, but this commit brings no
functional change.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index e64c214b4020..989ae24f2be9 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1338,12 +1338,14 @@ static struct qcom_icc_node qns_mem_noc_sf_disp = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = 0x8,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_crypto },
 };
@@ -1352,6 +1354,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = 0x1,
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 55,
 	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
 		   &qhs_ahb2phy0, &qhs_ahb2phy1,
@@ -1386,6 +1389,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
 };
@@ -1393,6 +1397,7 @@ static struct qcom_icc_bcm bcm_co0 = {
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
@@ -1400,6 +1405,7 @@ static struct qcom_icc_bcm bcm_mc0 = {
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf },
 };
@@ -1407,6 +1413,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 12,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_mdp,
@@ -1420,6 +1427,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1428,6 +1436,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1436,6 +1445,7 @@ static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
@@ -1443,6 +1453,7 @@ static struct qcom_icc_bcm bcm_qup2 = {
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc },
 };
@@ -1450,6 +1461,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 7,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &qnm_nsp_gemnoc, &qnm_pcie,
@@ -1460,6 +1472,7 @@ static struct qcom_icc_bcm bcm_sh1 = {
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_gemnoc_sf },
 };
@@ -1467,6 +1480,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 4,
 	.nodes = { &qhm_gic, &qxm_pimem,
 		   &xm_gic, &qns_gemnoc_gc },
@@ -1474,24 +1488,28 @@ static struct qcom_icc_bcm bcm_sn1 = {
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_lpass_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_pcie_mem_noc },
 };
@@ -1499,18 +1517,21 @@ static struct qcom_icc_bcm bcm_sn7 = {
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
 
 static struct qcom_icc_bcm bcm_mc0_disp = {
 	.name = "MC0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
 
 static struct qcom_icc_bcm bcm_mm0_disp = {
 	.name = "MM0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf_disp },
 };
@@ -1518,6 +1539,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
 static struct qcom_icc_bcm bcm_mm1_disp = {
 	.name = "MM1",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 3,
 	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
 		   &qns_mem_noc_sf_disp },
@@ -1525,6 +1547,7 @@ static struct qcom_icc_bcm bcm_mm1_disp = {
 
 static struct qcom_icc_bcm bcm_sh0_disp = {
 	.name = "SH0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc_disp },
 };
@@ -1532,6 +1555,7 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
 	.enable_mask = 0x1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_pcie_disp },
 };

-- 
2.41.0

