Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5374EEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGKMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjGKMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:20:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5301982
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso85620871fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077945; x=1691669945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noMmCZBvzkPt+geogqqNlSAuP/VTDaK1ugC+GgLiOwQ=;
        b=y2CXcq/9nnCStlPiiK9tD5kXOuy6BsQvTWhjKMW3WHAB7azwPpRdWu3PflyjcCrp5/
         09oVf65zpkpzCx6R7ARCbDU9Gcdl1fm8hshqH+MOU2omnOraE/T5yuZUtXvq69wDSZmU
         5A9x7GKIPhsxLC2/ffNCvn1n7K1JWjQy3YJnY8F4akMnYWZjWdE4bd2ME8MeMi1sChsm
         c4ZzEMk1Yxs+/dy2HK1zjJhTVdLgpkT9P6uj0cEAGKzfNp+EnKYMk6S5RZ79ysP39qJS
         iimIljvUkeLKypKg4DrjSXnyrHlqec/KWcKJZxRZBXPJPmTHwSXeNqS9Fjt+0rIc7eB5
         xQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077945; x=1691669945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noMmCZBvzkPt+geogqqNlSAuP/VTDaK1ugC+GgLiOwQ=;
        b=JmOKwNyQb0WjJdeB+Ewt1KOGy5B4QacU6z4If/mUXxuUpVePRm8SIYsDu4W2pXEelV
         CWLiXNtHP6wrdQJHtdVp42MQv1K4i0ZSz3WKkg2kXVe4mUZqRH4ylKFF0SvcOvybooG/
         iiG0VZl3Vk9iDJ3PnQsI6qV9dmZMeCFAgzieBq+pCJWY5GnqQR6xOz06Hx5DUbxme9py
         h9AXTKd44U9QDaRt/CKKUmppiv6wfI0t0dL85PIQa87NK9FInYAnWbxDy7c7gPNeqkUm
         4/m0MW7UKCPjhCsERqWqlgclCL0P2xuwmwRWoB8rI4unu7wtK7E5heXguIcA1/XMTc7O
         MmHQ==
X-Gm-Message-State: ABy/qLa2yzGy2ROWeJQwaHNtxClQORb6Y7BYYFHZvrQhTzSGujgdNQEi
        nGkZ+dSvhfOkn4t+7L2SYr0A2g==
X-Google-Smtp-Source: APBJJlGgYYL8jIGcKvDaodA9YZ9akdAjaQheQ85qs8Jdn54eLFi+kFg58UacEIc6JlFgRXA5bugjqg==
X-Received: by 2002:a2e:b615:0:b0:2b6:a3a0:5f7 with SMTP id r21-20020a2eb615000000b002b6a3a005f7mr12900884ljn.9.1689077945242;
        Tue, 11 Jul 2023 05:19:05 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:28 +0200
Subject: [PATCH 29/53] interconnect: qcom: sc8180x: Explicitly assign
 voter_idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-29-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=4909;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BvLWDzRk2sKY58qxMKk4+8yHkv9gScgVxizsgjWb+5A=;
 b=S4SWkBHlhYTPcaujc0sQmaZQyunPxhvKNOiG/aVsNj2bmQlmh2bfEHjGvop/VE8BQNX0Mqv9z
 syT8aKM70g1Ch4Hy4W1nWDuHW8XsS3yXKDu+KTMKwZD5fD7NOJZJLA8
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

To avoid confusion, explicitly assign the BCM voter index.

Note the assignment may be incorrect, but this commit brings no
functional change.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index c76e3a6a98cd..a811cbf2cd15 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1344,6 +1344,7 @@ static struct qcom_icc_node slv_qup_core_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_ebi }
 };
@@ -1351,6 +1352,7 @@ static struct qcom_icc_bcm bcm_acv = {
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_ebi }
 };
@@ -1358,24 +1360,28 @@ static struct qcom_icc_bcm bcm_mc0 = {
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_qns_llcc }
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_qns_mem_noc_hf }
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_qns_cdsp_mem_noc }
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &mas_qxm_crypto }
 };
@@ -1383,6 +1389,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 57,
 	.nodes = { &mas_qnm_snoc,
 		   &slv_qhs_a1_noc_cfg,
@@ -1445,6 +1452,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 7,
 	.nodes = { &mas_qxm_camnoc_hf0_uncomp,
 		   &mas_qxm_camnoc_hf1_uncomp,
@@ -1457,6 +1465,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 3,
 	.nodes = { &mas_qup_core_0,
 		   &mas_qup_core_1,
@@ -1465,12 +1474,14 @@ static struct qcom_icc_bcm bcm_qup0 = {
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_qns_gem_noc_snoc }
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 6,
 	.nodes = { &mas_qxm_camnoc_sf,
 		   &mas_qxm_rot,
@@ -1483,45 +1494,53 @@ static struct qcom_icc_bcm bcm_mm2 = {
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &mas_acm_apps }
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.nodes = { &slv_qns_gemnoc_sf }
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.nodes = { &slv_qxs_imem }
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.nodes = { &slv_qns_gemnoc_gc }
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.nodes = { &mas_qnm_npu }
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.nodes = { &slv_srvc_aggre1_noc,
 		  &slv_qns_cnoc }
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.nodes = { &slv_qxs_pimem }
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 4,
 	.nodes = { &slv_xs_pcie_0,
 		   &slv_xs_pcie_1,
@@ -1531,18 +1550,21 @@ static struct qcom_icc_bcm bcm_sn8 = {
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &mas_qnm_aggre1_noc }
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &mas_qnm_aggre2_noc }
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_qns_pcie_mem_noc }
 };
@@ -1550,6 +1572,7 @@ static struct qcom_icc_bcm bcm_sn14 = {
 static struct qcom_icc_bcm bcm_sn15 = {
 	.name = "SN15",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &mas_qnm_gemnoc }
 };

-- 
2.41.0

