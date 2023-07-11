Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A11C74EE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGKMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjGKMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276610F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso88500841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077928; x=1691669928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV2NOHdhXQJvyF0fc5slrvpV1+3GiCLz+u7Y70t3daI=;
        b=RF7r80co6+7JAiqhVm/o6zgc1sERtm3oKQc+xsMeDyXGrM8h8i8K+DIjqJCr9HQxeu
         ZgRbimW0j8qeKzBSpWEpSBZnV8pTWM3+Rv9BTR9Ii27wvVc4PrdlDsW2xLybxjYTUsqZ
         4Ban1NFmSGZDVMiUYGsX6mlltkSsGqa3o4Dl9HVMq5iiytKEBrnx/iM4lQjUavk0E/CJ
         jm/TRclWD+XzhJolCyG6mXZLbo+l1IRTDvYDsYqz15Ndv9TfALCPsAWHHTLKsJ3vWxCU
         l7xrw7ZmeDy6KkOae/hPlTtRbAemJ9+MtuE7vPQMlSWOFoCwKP84JRQgG8qJnNoRomba
         EOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077928; x=1691669928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV2NOHdhXQJvyF0fc5slrvpV1+3GiCLz+u7Y70t3daI=;
        b=kx4W6VDgrCYQ+by27gZOx8LANij85bES/xjBWbjBcwDmW1JClc/nCpzWiZiq8G3zR3
         RSMIn1iJiqBbeyh19SYTPa9rBAttOI5CRqZC+3oZJ5nakN7O1Cn01M+Hz5GVoZ9U2N8i
         +W4zspor6xW3L7KpDLmXBcdu4GFdHPyoP1IqtShqkvEYV09RWILlqrE8aJF2bfCyVD6O
         BR71kHS3UtDNjUUfKU4+Y42BKyj1FNZUsYRHgv8pXPEshaVJzpE+6516EHMrF5UU+6fQ
         fU82AiR671PYLTHiAUu1E+69h6QjM0xQLL4SBWrZVpdYJjZzjR8BU05N6Sl4NHq5eMIa
         KNqw==
X-Gm-Message-State: ABy/qLbBqQPYxO/TzY+GOiBm6kZ8gvSyYIZP5S09j45/2pA8b6anqfIJ
        y1NaExCp+Oho+Z7RJu7EEFL1bg==
X-Google-Smtp-Source: APBJJlHu2FvrJIoWXBM6wuPl/9utO+3HwVtRyrdEOjehHQCrOn64z/yGaRjMC9VfvdvNvBOrkPgl1A==
X-Received: by 2002:a2e:740a:0:b0:2b6:c4be:8397 with SMTP id p10-20020a2e740a000000b002b6c4be8397mr12824468ljc.20.1689077928500;
        Tue, 11 Jul 2023 05:18:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:15 +0200
Subject: [PATCH 16/53] interconnect: qcom: sc7180: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-16-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=8531;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=z5wK9eZaguqOGRFKwow1eBaPyqCaSpkZDfuYMwlOGz0=;
 b=lkxrf35BwbC2UuSnZtJLbD7icxmUVnr1eFa3xKWoGtYaeSGTrASIhgtVs6IhS77YPHhrUs2Fc
 SoppQwAXXkxCIZzArfY9UH+aAKHJtmGnPz5Svdxl7lBSSWYA/U/o9JM
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
 drivers/interconnect/qcom/sc7180.c | 279 +++++++++++++++++++++++++++++++++----
 1 file changed, 255 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index d1b0427f8781..3629dee4448b 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1235,30 +1235,261 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aop, &qhs_aoss, &qhs_boot_rom, &qhs_camera_cfg, &qhs_camera_nrt_throttle_cfg, &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl, &qhs_cpr_cx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_display_rt_throttle_cfg, &qhs_display_throttle_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_mss_cfg, &qhs_npu_cfg, &qhs_npu_dma_throttle_cfg, &qhs_npu_dsp_throttle_cfg, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg, &qhs_qm_mpu_cfg, &qhs_qup0, &qhs_qup1, &qhs_security, &qhs_snoc_cfg, &qhs_tcsr, &qhs_tlmm_1, &qhs_tlmm_2, &qhs_tlmm_3, &qhs_ufs_mem_cfg, &qhs_usb3, &qhs_venus_cfg, &qhs_venus_throttle_cfg, &qhs_vsense_ctrl_cfg, &srvc_cnoc);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qhm_mnoc_cfg, &qxm_mdp0, &qxm_rot, &qxm_venus0, &qxm_venus_arm9);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &acm_sys_tcu);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup_core_master_1, &qup_core_master_2);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &acm_apps0);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_gemnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_cn1, "CN1", false, &qhm_qspi, &xm_sdc2, &xm_emmc, &qhs_ahb2phy2, &qhs_emmc_cfg, &qhs_pdm, &qhs_qspi, &qhs_sdc2);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qxm_pimem, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
-DEFINE_QBCM(bcm_co3, "CO3", false, &qxm_npu_dsp);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qnm_gemnoc);
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
+	.keepalive = false,
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
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 48,
+	.nodes = { &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy0,
+		   &qhs_aop,
+		   &qhs_aoss,
+		   &qhs_boot_rom,
+		   &qhs_camera_cfg,
+		   &qhs_camera_nrt_throttle_cfg,
+		   &qhs_camera_rt_throttle_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_display_rt_throttle_cfg,
+		   &qhs_display_throttle_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_mss_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_npu_dma_throttle_cfg,
+		   &qhs_npu_dsp_throttle_cfg,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qm_cfg,
+		   &qhs_qm_mpu_cfg,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_security,
+		   &qhs_snoc_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm_1,
+		   &qhs_tlmm_2,
+		   &qhs_tlmm_3,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3,
+		   &qhs_venus_cfg,
+		   &qhs_venus_throttle_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 8,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_hf1_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qhm_mnoc_cfg,
+		   &qxm_mdp0,
+		   &qxm_rot,
+		   &qxm_venus0,
+		   &qxm_venus_arm9
+	},
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &acm_sys_tcu },
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
+	.num_nodes = 2,
+	.nodes = { &qup_core_master_1, &qup_core_master_2 },
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
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &acm_apps0 },
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
+	.nodes = { &qns_cdsp_gemnoc },
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
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 8,
+	.nodes = { &qhm_qspi,
+		   &xm_sdc2,
+		   &xm_emmc,
+		   &qhs_ahb2phy2,
+		   &qhs_emmc_cfg,
+		   &qhs_pdm,
+		   &qhs_qspi,
+		   &qhs_sdc2
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 2,
+	.nodes = { &qxm_pimem, &qns_gemnoc_gc },
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
+static struct qcom_icc_bcm bcm_co3 = {
+	.name = "CO3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_npu_dsp },
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
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
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
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_cn1,

-- 
2.41.0

