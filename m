Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB074EE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGKMUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjGKMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1581FC7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso89378401fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077936; x=1691669936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CpIm99p35hKfrhViAqOQ5+gXpJKb9gI8hVZDnX53cw=;
        b=JnVHVIv8G1nXLukfOc6ZeZW/Muwymm3GWmCc2DkexC9JlrhI+aKJYeZ64888FohJ+K
         IzYbwAvy3RAB463nWaEXO0hUADuMurOgrrcrCuy5LBD3WicKDV+xXVkH79nkiazYD+0E
         nZ9ptn8RK1JASW/1rhncLUOs+BS7XuztznTrBhzjXXOWI5e+Ce5JQYeP1CALopnrIjhl
         e6V3BtCaK3WQ0DjKkztT9hIwstQfW5p/6TW1eCSFFgNcyydoz5FXw9smtfz13I9Qg5dY
         VbPgqOuUOY0ibSGw6ljmSusRM6HR1TwGdam6NEp0f1ihs+wQoZ4HdUYyc7lwkbU4yZcG
         6tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077936; x=1691669936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CpIm99p35hKfrhViAqOQ5+gXpJKb9gI8hVZDnX53cw=;
        b=J+jS5ZKQqD50kZeizRK77vc+bDKGAHtDwft9UI9c+UgFrqNmnRkN6Hi2JJcST/sWfC
         cDRjRI1emV0KCcfXNMqW++zQrfo1I/wRjl3W2KS04IM3ECGDcG+l3ZGIw6GXQ5v/rNUd
         UIuJ4SYoflPFXGvEFLmHVdeZx8SJcGTiau7eH2Rxfpg7RE6Ei0+NGdEWaVsdqooGzymC
         4zTdLTBxzOL++jkm8hkUAVlTNmG/7uSIe4ZDEy7Tf9b2zqah9qk5p5E+uqxv5yNV4zig
         LEjQiSddiX5NoHjX4h+fobEFKn0n3LKchtlaN+aN06y5g5/SszP/1y0B1H8Alr2GDI5t
         lP/A==
X-Gm-Message-State: ABy/qLYHmoqNxp9t7A85d6CLk69czV/1982gU0WYpZZgzYgmLPP2xmPT
        2/YVYUZsHMlUu/3tEHsETnXQUQ==
X-Google-Smtp-Source: APBJJlGSv9Xv9xRvERk3JageGrGPS9DSMeFPJs/tf6f7shVV4dAT2v5ySCtEHF6hzZIT0tTBssi6Mg==
X-Received: by 2002:a2e:94c3:0:b0:2b6:dc84:b93e with SMTP id r3-20020a2e94c3000000b002b6dc84b93emr12592653ljh.21.1689077936348;
        Tue, 11 Jul 2023 05:18:56 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:21 +0200
Subject: [PATCH 22/53] interconnect: qcom: sm8150: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-22-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=9494;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OR/aMRqrXjITcvDE45wlMNy7hvzhmiKeqYcGWttjB1Q=;
 b=uF+SFPLd6m6ntYCetsIlLhvgefSm5PCEEzcmxuit4atD5Re3IYmwtv545+LYKXsoSuT1jd13g
 uwfQDDEOZJwAjvrpTHYPMY4jF6Go5mE6iXfc2A93+DlTv7+0QvGxAAx
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

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8150.c | 311 +++++++++++++++++++++++++++++++++----
 1 file changed, 283 insertions(+), 28 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 29f16899cf5d..91f68d91f12a 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1279,34 +1279,289 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_gem_noc_snoc);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qxm_camnoc_sf, &qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_gpu_tcu, &acm_sys_tcu);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh5, "SH5", false, &acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qhm_spdm, &qnm_snoc, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr, &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &xs_pcie_0, &xs_pcie_1);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qxm_pimem, &xm_gic);
-DEFINE_QBCM(bcm_sn14, "SN14", false, &qns_pcie_mem_noc);
-DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_gemnoc);
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
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 7,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_hf1_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_hf0,
+		   &qxm_camnoc_hf1,
+		   &qxm_mdp0,
+		   &qxm_mdp1
+	},
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &acm_gpu_tcu, &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 4,
+	.nodes = { &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh5 = {
+	.name = "SH5",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &acm_apps },
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
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
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
+static struct qcom_icc_bcm bcm_co1 = {
+	.name = "CO1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 53,
+	.nodes = { &qhm_spdm,
+		   &qnm_snoc,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy_south,
+		   &qhs_aop,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mmcx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_emac_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_phy_refgen_north,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qspi,
+		   &qhs_qupv3_east,
+		   &qhs_qupv3_north,
+		   &qhs_qupv3_south,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_spdm,
+		   &qhs_spss_cfg,
+		   &qhs_ssc_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm_east,
+		   &qhs_tlmm_north,
+		   &qhs_tlmm_south,
+		   &qhs_tlmm_west,
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
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 3,
+	.nodes = { &qhm_qup0, &qhm_qup1, &qhm_qup2 },
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
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 3,
+	.nodes = { &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qxm_pimem, &xm_gic },
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn15 = {
+	.name = "SN15",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_qup0,

-- 
2.41.0

