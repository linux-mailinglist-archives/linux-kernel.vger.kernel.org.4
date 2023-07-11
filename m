Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68074EE46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjGKMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGKMTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201811BE7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so21723511fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077934; x=1691669934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Vw4FtG4zRR57g9WoHWXO4Qcw1T4jkj9L0gpd97EQyk=;
        b=SSiWED6OzT1YGYq7KdQSP1rqSfIzblkcofNjFQaUzgzTBwu4PMQFQwkfCMNKlizLag
         /Ip6SDqPb2fj9v4MQvEgl4fsUgjNmGpFouBz1EJ2J8cSKkc046JNBDmClAEBCxDuFvl6
         ABF7mql6SUIzyKR+hvTDgw3KPZ7TJjZc9JPxuuKhdcmkPwWWR5jZ7sWdslKxkrksrz3x
         4BN8pGS1x5MFvSerkJS+ypGUSCw0TEEbH+QtDu+WVi7HUpdfdSMlJlJ1VeasLnK8a7aE
         OtM4/Bkv7Kp9+nuH4WdcqzRExtGEfQEnw6mr96upgUu3J1UbeBPGZt9ZSflrQLzbEfSw
         Qq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077934; x=1691669934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Vw4FtG4zRR57g9WoHWXO4Qcw1T4jkj9L0gpd97EQyk=;
        b=YmD31CiF2pldPQcpAw+m9/tMq11eqiNHb3pJFzVWEE3ySp/rJ0YwPq9HMKrN8sAFVa
         2zZr9MaL4O+SbIJx5gsbG3c7t8OH8qHasGIiwbf7EeHW/MmVQsEcMTZltdLkJvOoAm8M
         3bkLY2J00ET+hpawrMYaPeC54pE33eFgj7KYGOBMnHEyegqw4P2E45829F/leAAbZBiD
         H3/r8hPfkjqqg6Roice095/PPmitTVp0Sy4e0QiA8JCEHxshCk0f527wfNgndMkRCFSL
         GadRfIyacJFl+8/Is3Wnti7tfsi1wc42zHNhOvbHoVd4mR92oNFhKPxC8BenkiNhbzVV
         UErg==
X-Gm-Message-State: ABy/qLbSiwnRTWGQ6f5UVs8bnEE+Sl/p4Unyf8dti8QvC3aS6vn/kAqX
        3n5Z+prYMHMx3cua5rifwRYXqA==
X-Google-Smtp-Source: APBJJlFd6xxi0jWcMf8Uz9Yp9lV3UbJTk/sHJdeUl0ChUXuew+JuD1OxeIskWHLyrnD85o/uVqPpiA==
X-Received: by 2002:a05:651c:10ab:b0:2b6:9e1d:cd0f with SMTP id k11-20020a05651c10ab00b002b69e1dcd0fmr7630001ljn.12.1689077933764;
        Tue, 11 Jul 2023 05:18:53 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:19 +0200
Subject: [PATCH 20/53] interconnect: qcom: sdx65: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-20-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=6218;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Fdsj7Q8qluuHDSxo4HSyUvvKfsGRHI1pvdy6XHDDsKo=;
 b=9lSQq6+ZIpxll0H/JERMHh/63NXuDH5sC5z5byZrPdLmDqG6Y8+4slb8XxQ7q3ZYznonHtN9K
 qAJ9iEaVbg2AqKcaNU5XSSrczELv5nOez3VrH5wqLB4XEs8xCQ1p/a1
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
 drivers/interconnect/qcom/sdx65.c | 205 ++++++++++++++++++++++++++++++++++----
 1 file changed, 185 insertions(+), 20 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index bebed036fe7a..881a39c172e3 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -603,26 +603,191 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_pn0, "PN0", true, &qhm_snoc_cfg, &qhs_aoss, &qhs_apss, &qhs_audio, &qhs_blsp1, &qhs_clk_ctl, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_ecc_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mss_cfg, &qhs_pcie_parf, &qhs_pdm, &qhs_prng, &qhs_qdss_cfg, &qhs_qpic, &qhs_sdc1, &qhs_snoc_cfg, &qhs_spmi_fetcher, &qhs_spmi_vgi_coex, &qhs_tcsr, &qhs_tlmm, &qhs_usb3, &qhs_usb3_phy, &srvc_snoc);
-DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
-DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
-DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
-DEFINE_QBCM(bcm_pn4, "PN4", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_sh1, "SH1", false, &qns_memnoc_snoc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_sys_tcu_cfg);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &qhm_qdss_bam, &xm_qdss_etr);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_memnoc);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc_pcie);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_ipa, &xm_ipa2pcie_slv);
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_pn0 = {
+	.name = "PN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 26,
+	.nodes = { &qhm_snoc_cfg,
+		   &qhs_aoss,
+		   &qhs_apss,
+		   &qhs_audio,
+		   &qhs_blsp1,
+		   &qhs_clk_ctl,
+		   &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_ecc_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mss_cfg,
+		   &qhs_pcie_parf,
+		   &qhs_pdm,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qpic,
+		   &qhs_sdc1,
+		   &qhs_snoc_cfg,
+		   &qhs_spmi_fetcher,
+		   &qhs_spmi_vgi_coex,
+		   &qhs_tcsr,
+		   &qhs_tlmm,
+		   &qhs_usb3,
+		   &qhs_usb3_phy,
+		   &srvc_snoc
+	},
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
+static struct qcom_icc_bcm bcm_pn3 = {
+	.name = "PN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qhm_blsp1, &qhm_qpic },
+};
+
+static struct qcom_icc_bcm bcm_pn4 = {
+	.name = "PN4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
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
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_memnoc_snoc },
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
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qhm_qdss_bam, &xm_qdss_etr },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 4,
+	.nodes = { &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv },
+};
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,

-- 
2.41.0

