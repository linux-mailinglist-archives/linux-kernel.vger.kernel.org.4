Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989E74EE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGKMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjGKMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252C1BDA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso92303421fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077932; x=1691669932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENero7XyX59cqDszQyZ8QZ9Rysgsxy+Mo9A4mpZ7Eqk=;
        b=KHyEHm+tJx3VBlbOg/AVhqFd6LSeT4bypyfJh6NZMf7suyafR9dEotXeecE+oWMruW
         BPm02GWKwKR39rKj7P4g0cggQR9tyxuP0dhkK3YxTlVRcZOBSWBATSAh+npZ6qAqETgF
         WhYVo70EgfG6oI9rGpcet5UnG8HiJfrugWwfeH22MRF81U8Q0hY7Bn7dT+x7/6hKhDP2
         X8plo5gjNUOVa6pbyIk8Zjbw05uTrU1YXMLwiWPQmqcBWS6pEG/bVFGs5D1kb3jDH7LE
         EK0NmhnTAw5RByCl0P5cuDRqtITSF2OtDaIhULLQi5kpENVT6efY8f2Ft77VLfRK7/t8
         2jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077932; x=1691669932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENero7XyX59cqDszQyZ8QZ9Rysgsxy+Mo9A4mpZ7Eqk=;
        b=A96hniln7k9XhKRQRwj24YW2xhdMVoHTffwnQoyeqeaTdXOc0Ej14b5oSd9lg3D634
         nHZer3t77bAImp/rr7qLK80c1CZFlTf+dky487yHP1cm50qTYkbC07eRjlmQuwyqVvos
         w4vJIOFE4uiXNGg2iLewfRx70MTFVRmOzcvlO+/R8oanyXuHProk53n2IpJCwNbMvhFb
         eMaUTQXKhC01Jwl1KzWnzuj10Sfk/UwOFdaU4/QN3loBWfeBXfQ0z5ZGAfRiBUiTedXG
         Wbv8+PMFQuY4EM8Gm/PuNNpUecHiLPTJfACmsdKEj3CIlGOSo2w+ePsiY2Osz3+c3z0C
         5PLQ==
X-Gm-Message-State: ABy/qLYN02n5c5O4YnF0Sd2GT+2/NLzHhsZrlT0xm4bToFL3bx7rdb4A
        Na+tZJTLurlC2pc229wPYiDdVF59BGx+JllorwunjA==
X-Google-Smtp-Source: APBJJlH3y1SufcmTDm7AK4HIqvEPLg64zSgN7+zqhyp+kJrr3al7aoMlXIhBqGI5kYWQWjk+ZRzmhw==
X-Received: by 2002:a05:651c:1027:b0:2b6:cf18:7397 with SMTP id w7-20020a05651c102700b002b6cf187397mr12754848ljm.5.1689077932289;
        Tue, 11 Jul 2023 05:18:52 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:18 +0200
Subject: [PATCH 19/53] interconnect: qcom: sdx55: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-19-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=5432;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=R92aM77XVZAqKQuJtDwodh3d1IHCkhMpDQVlwb6kTv0=;
 b=ASDIVUzeQZ9QMHjM49gGjQWUBVfYt6YMoSX818QYw/+a/Q3qoJ8RNZ/VHzK4anO+KxSqsbUHf
 f4DOgaD4pyaAUjtd9IwCjIMLH32BgKxrDiIBpbODkXdiH8kIQKg0fnh
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

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdx55.c | 180 +++++++++++++++++++++++++++++++++-----
 1 file changed, 159 insertions(+), 21 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 2b5e8873eaa5..968b7b953912 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -642,27 +642,165 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
-DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_sys_tcu_cfg);
-DEFINE_QBCM(bcm_pn5, "PN5", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3,
-	    &qns_aggre_noc);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qhm_qdss_bam, &xm_qdss_etr);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_memnoc_pcie);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_ipa, &xm_ipa2pcie_slv);
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_pn0 = {
+	.name = "PN0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qhm_snoc_cfg },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xm_apps_rdwr },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qns_memnoc_snoc, &qns_sys_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_snoc_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_pn1 = {
+	.name = "PN1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xm_sdc1 },
+};
+
+static struct qcom_icc_bcm bcm_pn2 = {
+	.name = "PN2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qhm_audio, &qhm_spmi_fetcher1 },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_pn3 = {
+	.name = "PN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qhm_blsp1, &qhm_qpic },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_pn5 = {
+	.name = "PN5",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 5,
+	.nodes = { &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3, &qns_aggre_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qhm_qdss_bam, &xm_qdss_etr },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv },
+};
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,

-- 
2.41.0

