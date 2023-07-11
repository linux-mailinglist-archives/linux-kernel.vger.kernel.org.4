Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E274EEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGKMVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGKMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:20:21 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0523173C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso92181931fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077944; x=1691669944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRzxUcdMoRzU/LXIG+2IxlKEBjvc8egBZ1+dv+HI/9k=;
        b=KNwsSgSJ0RCWerTq2l0NgpZIRuuw7PsBTxI5c6Ndgf26vdQdCPgwqaLrGbrX7gi7u/
         hd6Gmb1L2OYsin016iRytfvd4ELO6QJiZl3HllKMwx86BxR4GFzFZXfYMcPrOife6SeO
         VCgkDYZNpYC/YOkN3cmsGAxkBwqSw5mNpwz5fM+cPwJsX74Dp4a0UmODRDKYExvGgc02
         i/unQuEdbkohioW7+sBJSMGCUlpg2coM+ypDrc932FXGHVtofY6nVjNLUPZwYBucO8ju
         XFqRIwUf86VYUBcisAsTg9Rp/qCjZZSSgJf0Vpb9uvLgXllsCkvzqECDHM8oTqXLm51a
         RTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077944; x=1691669944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRzxUcdMoRzU/LXIG+2IxlKEBjvc8egBZ1+dv+HI/9k=;
        b=QDQK8Ld19deaSmhJmWm7qo3K5xU7gAdRqjPT/4SYeb3/jN0G5xxcjxfnzPbq28EbrZ
         HjZQ3bUxqkpalB9OdgNj6j4mZk8E4Heu7iVQ3CY6AR3ZeTd+RFgYVN1rho2Ki9UYPOf4
         fakPyJOuPKqh9gdMt1/VL50MFe4gRhXdI2FLDvqbH53rtRPCeIs5e49CK/rfzqd37DTy
         jxBF7ZrtaAAvSSiFx8S7x+iGJ6FNOkqH3kItCfLU0ltmLuyQksfxzbnOixeWQsSbVguD
         YxDPtUEtCqLXx265psRU59Mn6EkbGXZaYGbLAMx8PnVRiBdqVMjcwo1L6t4zawWZBcx3
         oqnw==
X-Gm-Message-State: ABy/qLbgZ9FvBvvQDqcYoWa+ZwrqtUIZERZlPEjuTHvQJveWlLCgrGyX
        n4bINpvCcQ2Gql8iwYTZxrkhTw==
X-Google-Smtp-Source: APBJJlGm4l3SDY3FAD1xMbvG78kbxLaZxFbnK1Hc/KGD1onAb8jdyRkMROx7sIOthEkHnHs9C+VP9A==
X-Received: by 2002:a2e:b166:0:b0:2b7:117:e54 with SMTP id a6-20020a2eb166000000b002b701170e54mr13803718ljm.4.1689077944002;
        Tue, 11 Jul 2023 05:19:04 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:27 +0200
Subject: [PATCH 28/53] interconnect: qcom: sc7280: Explicitly assign
 voter_idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-28-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=5586;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nax1GmT400+SDmWYx677ggaJz8Q417oAUImc//sqRBI=;
 b=QZfN5DzZ+sQyvhBt7DAVOOwH1qwd9tG7nKc4auZp5i3QPCjza8KgAr17dKeTznGx/lQwfE2k4
 gz3cbp2Cj8GB79VtLFoHEG9heBFxwEzRP59H5YWT+IFj7RrJXX/vZaj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/interconnect/qcom/sc7280.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 971f538bc98a..bb8b31612501 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1284,12 +1284,14 @@ static struct qcom_icc_node srvc_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
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
@@ -1297,12 +1299,14 @@ static struct qcom_icc_bcm bcm_ce0 = {
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 47,
 	.nodes = { &qnm_cnoc3_cnoc2, &xm_qdss_dap,
 		   &qhs_ahb2phy0, &qhs_ahb2phy1,
@@ -1331,6 +1335,7 @@ static struct qcom_icc_bcm bcm_cn1 = {
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 6,
 	.nodes = { &qhs_lpass_cfg, &qhs_pdm,
 		   &qhs_qspi, &qhs_sdc1,
@@ -1339,12 +1344,14 @@ static struct qcom_icc_bcm bcm_cn2 = {
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_bcm bcm_co3 = {
 	.name = "CO3",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_nsp },
 };
@@ -1352,6 +1359,7 @@ static struct qcom_icc_bcm bcm_co3 = {
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
@@ -1359,24 +1367,28 @@ static struct qcom_icc_bcm bcm_mc0 = {
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qxm_camnoc_hf, &qxm_mdp0 },
 };
 
 static struct qcom_icc_bcm bcm_mm4 = {
 	.name = "MM4",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_bcm bcm_mm5 = {
 	.name = "MM5",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 3,
 	.nodes = { &qnm_video0, &qxm_camnoc_icp,
 		   &qxm_camnoc_sf },
@@ -1385,6 +1397,7 @@ static struct qcom_icc_bcm bcm_mm5 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1392,6 +1405,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1399,24 +1413,28 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_cmpnoc },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &chm_apps },
 };
@@ -1424,54 +1442,63 @@ static struct qcom_icc_bcm bcm_sh4 = {
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxs_pimem },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &xs_qdss_stm },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &xm_pcie3_0 },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &xm_pcie3_1 },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_pcie_mem_noc },
 };

-- 
2.41.0

