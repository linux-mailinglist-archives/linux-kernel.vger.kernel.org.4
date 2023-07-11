Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0D74EE57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGKMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjGKMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCE2123
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so75053591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077937; x=1691669937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRPaR1Jrm+Xt/Lxwe/KmFq2H4dkDCMVkZkPsoE74AQQ=;
        b=uo42ikCEyM96nQTx7Dg0eHMmVtXkXtSKv0dSHNWnyLDBZIg+1hJW+mS8n4I3oQvPu7
         2lnz6jhMXEecXctLkK4OJWizFRx2BBTpCSGf9cowXHlK/R4+9006M1r4His1RZJVYCgS
         cZ1iQ5JrQgPKH6NHs9GL1qSlxioAhwq4TS45vQSl5jkuEoJhB8YZFeNXtTSy+OriNW0N
         R1gtJM/wEqZ9XYCOvrGqqILlFL+BXED1IQk/xyK6+6tZ4VDH4a88B+/YDY5P0DG3c5YE
         rsm/gM5fITu3IDbw+mw5Yg18OeBQGequEO8iwdf3DhWUF06T3Lp+DABDpmGufxs8bMPY
         fRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077937; x=1691669937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRPaR1Jrm+Xt/Lxwe/KmFq2H4dkDCMVkZkPsoE74AQQ=;
        b=Z4Oc7Ut4B0U19lNKdcnQYSAGlNavduCI97Je3lEf7FcAN3bXbS/8fTsY8WHIpe023i
         JpqE6lr4nZxU1aTH10uxd39XPO30sAWI/DO8w5wgMAYTiFCj0+lhRQ7bhD9zKBtq/uTJ
         dIx9A2Ht43AKdW9fTWEjQUFtywzkAEYOwx0xc0giZXZXgtjKldsED3EWV77X9hbfCMse
         kwSozaRWnpKlNmZBjP+3WotmonwfLfdKVF7C2IeZ3v0kbz15DcqqdezhXCS0LycxZ2kx
         LKoOcN9p2RZaiu5HjS6t+ob3KW3+xPOXEEDL2LfqQU3NJymC9Ti9KK4cIzqU8JPo3kKd
         vt5Q==
X-Gm-Message-State: ABy/qLZAfoytQngdaBZYrOkuV0+5/tHJJ+WrEKwgcoP2TmjQozcsQSDf
        jp6v0EdqxjfPRu+hQXmuPkBd0g==
X-Google-Smtp-Source: APBJJlHwSqGbpJar9CdqFG/7mWBkmFmqhNNnGrifNQOJJo0Isoz2UrPs/ocU5kbib1MNWJJMD86dwg==
X-Received: by 2002:a2e:3312:0:b0:2b6:a05a:c5c with SMTP id d18-20020a2e3312000000b002b6a05a0c5cmr12866809ljc.1.1689077937612;
        Tue, 11 Jul 2023 05:18:57 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:22 +0200
Subject: [PATCH 23/53] interconnect: qcom: sm8250: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-23-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=8980;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=t1pXtAGd50MXkyw2HwnChg2QcAcq+w7wwZSL8zvgYig=;
 b=FydPpyU0pYwqg60zuq5IyJ2PVzg0/iI6p7cPUx2AhRjBtXFm4HCWdX8PH8cssELO0FQQeKi8R
 aLRJXDCAkZ/Cn+szJAWmIJVylzJysAFfMd4IfaZZo3XfSrzDEpCb9q9
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
 drivers/interconnect/qcom/sm8250.c | 294 +++++++++++++++++++++++++++++++++----
 1 file changed, 267 insertions(+), 27 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index d4123799c2c6..8cb032ac34bf 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1394,33 +1394,273 @@ static struct qcom_icc_node qup2_core_slave = {
 	.buswidth = 4,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup0_core_master, &qup1_core_master, &qup2_core_master);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_video0, &qnm_video1, &qnm_video_cvp);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &chm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_ahb2phy1, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_cx_rdpm, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_ipc_router, &qhs_lpass_cfg, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_pcie_modem_cfg, &qhs_pdm, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qup0, &qhs_qup1, &qhs_qup2, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_tcsr, &qhs_tlmm0, &qhs_tlmm1, &qhs_tlmm2, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie_modem);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie_0, &xs_pcie_1);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_gemnoc_pcie);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_gemnoc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc);
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &ebi },
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
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
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
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 3,
+	.nodes = { &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1 },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 3,
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup2_core_master },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 5,
+	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_video0, &qnm_video1, &qnm_video_cvp },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 52,
+	.nodes = { &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy0,
+		   &qhs_ahb2phy1,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mmcx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_ipc_router,
+		   &qhs_lpass_cfg,
+		   &qhs_mnoc_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_pcie_modem_cfg,
+		   &qhs_pdm,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qspi,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_qup2,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm0,
+		   &qhs_tlmm1,
+		   &qhs_tlmm2,
+		   &qhs_tsif,
+		   &qhs_ufs_card_cfg,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_usb3_1,
+		   &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &qns_cnoc_a2noc,
+		   &srvc_cnoc
+	},
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
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_co2 = {
+	.name = "CO2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_pcie_modem },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn12,

-- 
2.41.0

