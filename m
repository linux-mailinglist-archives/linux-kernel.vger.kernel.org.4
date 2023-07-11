Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A074EE10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjGKMTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjGKMSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F3E69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:37 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so87258201fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077915; x=1691669915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkNAVnAk/zegBOyEQBAQe1KoGlAouaOniKS9OiNkMnk=;
        b=TKSZdSFm4c+JiS9BbJufKeqzfVQWjET/dlbxcJ+avqeY5vf5OYRO9CNpugVcxURDGT
         /iZhm8j0MEmtTZcBd//MvU2dFa/uvjzlwbMKJU5BphLpdxU7N691bh2WtA0xCJTLfNiK
         6rXO0cU3Oyi5eKfLIsQMiOZ2BVfTDea20ZdfvtHhkcyLoc+CV/20qJKwkRDCj7nSJacV
         5e1RaqF0DH7WGFF+R4We7levHDio1L8HxXMR+PtRtDis4oOJaYKoGVSurIXKH6MNq5NI
         RuJhlKwOkwyN23xd7BuCjSfCjZ9SMyV7/sx+PN1PR56JHZQvpp2OYN2xyDifRHkRUcjQ
         I3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077915; x=1691669915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkNAVnAk/zegBOyEQBAQe1KoGlAouaOniKS9OiNkMnk=;
        b=M01INyclE/3PB7HCTI24qLFeYUIdOb2DRCDlw+Dm+e6xX8oygLNcIUm02yaxbNGx7v
         F9Mku4wo1kgP06zKsDLXmNeV2lazZRnTsYaXMIyUAYu7B5q+bP1mJRi9sSEhpUWY6DkF
         58m0K4tkvz8Ryl3YX5QvhsmnlHmQEM7xqewBfuM94cBbdGNL1DAi/BA39i+O/p2NX91j
         HQldM6y5OJMBt3174XEXLoJXybkoL3afOwVTORwWzF30Z0fqu/EayElY3v0Rdl+6Ikyj
         cWkTNtd7OInIqdNu5wZ+ULHqal0BFfXBaR4c0QuzXqEm2XKnlTFsxJgad7xmbB0jhRUq
         2Hbw==
X-Gm-Message-State: ABy/qLYIo4mOVWzELNBKxdLPBZ2BIeyleOKZTSjaDyRMG2f9Tc2CXrHE
        nZkKfrEzKwbnGxvSINkEGzrY9w==
X-Google-Smtp-Source: APBJJlGfKaNCj7/LklgxmMzyYcb3WFZR8OvFlLe6oZBeLBLS8a5ZUTUTeSnfXRrSzCShVnMvLpXw/A==
X-Received: by 2002:a2e:7008:0:b0:2b6:e78e:1e58 with SMTP id l8-20020a2e7008000000b002b6e78e1e58mr12492735ljc.5.1689077915240;
        Tue, 11 Jul 2023 05:18:35 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:06 +0200
Subject: [PATCH 07/53] interconnect: qcom: sdm670: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-7-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=34748;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=V+MGY6LePTTXD4nJ5soCKBGeCOExkcBtc/T6Gwor5mI=;
 b=2xqpXi14JeM5h01URD74UzsoKGBByAcM1I9rKvXkXVQMG3GyPUsPuXSZozncT/6FLtFx0c1dY
 RDwPssB6d1QDAen4IUdD5vriLaMYnzT0JLY2HwxsOKYvpdvZlpf8cPH
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
 drivers/interconnect/qcom/sdm670.c | 1145 ++++++++++++++++++++++++++++++++----
 1 file changed, 1029 insertions(+), 116 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index bda955035518..2c2cbe1b5197 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -14,122 +14,1035 @@
 #include "icc-rpmh.h"
 #include "sdm670.h"
 
-DEFINE_QNODE(qhm_a1noc_cfg, SDM670_MASTER_A1NOC_CFG, 1, 4, SDM670_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(qhm_qup1, SDM670_MASTER_BLSP_1, 1, 4, SDM670_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_tsif, SDM670_MASTER_TSIF, 1, 4, SDM670_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_emmc, SDM670_MASTER_EMMC, 1, 8, SDM670_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc2, SDM670_MASTER_SDCC_2, 1, 8, SDM670_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc4, SDM670_MASTER_SDCC_4, 1, 8, SDM670_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_mem, SDM670_MASTER_UFS_MEM, 1, 8, SDM670_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_a2noc_cfg, SDM670_MASTER_A2NOC_CFG, 1, 4, SDM670_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qhm_qdss_bam, SDM670_MASTER_QDSS_BAM, 1, 4, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qhm_qup2, SDM670_MASTER_BLSP_2, 1, 4, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qnm_cnoc, SDM670_MASTER_CNOC_A2NOC, 1, 8, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_crypto, SDM670_MASTER_CRYPTO_CORE_0, 1, 8, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_ipa, SDM670_MASTER_IPA, 1, 8, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_qdss_etr, SDM670_MASTER_QDSS_ETR, 1, 8, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_usb3_0, SDM670_MASTER_USB3, 1, 8, SDM670_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SDM670_MASTER_CAMNOC_HF0_UNCOMP, 1, 32, SDM670_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_hf1_uncomp, SDM670_MASTER_CAMNOC_HF1_UNCOMP, 1, 32, SDM670_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_sf_uncomp, SDM670_MASTER_CAMNOC_SF_UNCOMP, 1, 32, SDM670_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qhm_spdm, SDM670_MASTER_SPDM, 1, 4, SDM670_SLAVE_CNOC_A2NOC);
-DEFINE_QNODE(qnm_snoc, SDM670_MASTER_SNOC_CNOC, 1, 8, SDM670_SLAVE_TLMM_SOUTH, SDM670_SLAVE_CAMERA_CFG, SDM670_SLAVE_SDCC_4, SDM670_SLAVE_SDCC_2, SDM670_SLAVE_CNOC_MNOC_CFG, SDM670_SLAVE_UFS_MEM_CFG, SDM670_SLAVE_GLM, SDM670_SLAVE_PDM, SDM670_SLAVE_A2NOC_CFG, SDM670_SLAVE_QDSS_CFG, SDM670_SLAVE_DISPLAY_CFG, SDM670_SLAVE_TCSR, SDM670_SLAVE_DCC_CFG, SDM670_SLAVE_CNOC_DDRSS, SDM670_SLAVE_SNOC_CFG, SDM670_SLAVE_SOUTH_PHY_CFG, SDM670_SLAVE_GRAPHICS_3D_CFG, SDM670_SLAVE_VENUS_CFG, SDM670_SLAVE_TSIF, SDM670_SLAVE_CDSP_CFG, SDM670_SLAVE_AOP, SDM670_SLAVE_BLSP_2, SDM670_SLAVE_SERVICE_CNOC, SDM670_SLAVE_USB3, SDM670_SLAVE_IPA_CFG, SDM670_SLAVE_RBCPR_CX_CFG, SDM670_SLAVE_A1NOC_CFG, SDM670_SLAVE_AOSS, SDM670_SLAVE_PRNG, SDM670_SLAVE_VSENSE_CTRL_CFG, SDM670_SLAVE_EMMC_CFG, SDM670_SLAVE_BLSP_1, SDM670_SLAVE_SPDM_WRAPPER, SDM670_SLAVE_CRYPTO_0_CFG, SDM670_SLAVE_PIMEM_CFG, SDM670_SLAVE_TLMM_NORTH, SDM670_SLAVE_CLK_CTL, SDM670_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qhm_cnoc, SDM670_MASTER_CNOC_DC_NOC, 1, 4, SDM670_SLAVE_MEM_NOC_CFG, SDM670_SLAVE_LLCC_CFG);
-DEFINE_QNODE(acm_l3, SDM670_MASTER_AMPSS_M0, 1, 16, SDM670_SLAVE_SERVICE_GNOC, SDM670_SLAVE_GNOC_SNOC, SDM670_SLAVE_GNOC_MEM_NOC);
-DEFINE_QNODE(pm_gnoc_cfg, SDM670_MASTER_GNOC_CFG, 1, 4, SDM670_SLAVE_SERVICE_GNOC);
-DEFINE_QNODE(llcc_mc, SDM670_MASTER_LLCC, 2, 4, SDM670_SLAVE_EBI_CH0);
-DEFINE_QNODE(acm_tcu, SDM670_MASTER_TCU_0, 1, 8, SDM670_SLAVE_MEM_NOC_GNOC, SDM670_SLAVE_LLCC, SDM670_SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qhm_memnoc_cfg, SDM670_MASTER_MEM_NOC_CFG, 1, 4, SDM670_SLAVE_SERVICE_MEM_NOC, SDM670_SLAVE_MSS_PROC_MS_MPU_CFG);
-DEFINE_QNODE(qnm_apps, SDM670_MASTER_GNOC_MEM_NOC, 2, 32, SDM670_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_hf, SDM670_MASTER_MNOC_HF_MEM_NOC, 2, 32, SDM670_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, SDM670_MASTER_MNOC_SF_MEM_NOC, 1, 32, SDM670_SLAVE_MEM_NOC_GNOC, SDM670_SLAVE_LLCC, SDM670_SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SDM670_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDM670_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SDM670_MASTER_SNOC_SF_MEM_NOC, 1, 16, SDM670_SLAVE_MEM_NOC_GNOC, SDM670_SLAVE_LLCC);
-DEFINE_QNODE(qxm_gpu, SDM670_MASTER_GRAPHICS_3D, 2, 32, SDM670_SLAVE_MEM_NOC_GNOC, SDM670_SLAVE_LLCC, SDM670_SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qhm_mnoc_cfg, SDM670_MASTER_CNOC_MNOC_CFG, 1, 4, SDM670_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qxm_camnoc_hf0, SDM670_MASTER_CAMNOC_HF0, 1, 32, SDM670_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_hf1, SDM670_MASTER_CAMNOC_HF1, 1, 32, SDM670_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_sf, SDM670_MASTER_CAMNOC_SF, 1, 32, SDM670_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SDM670_MASTER_MDP_PORT0, 1, 32, SDM670_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp1, SDM670_MASTER_MDP_PORT1, 1, 32, SDM670_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, SDM670_MASTER_ROTATOR, 1, 32, SDM670_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus0, SDM670_MASTER_VIDEO_P0, 1, 32, SDM670_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus1, SDM670_MASTER_VIDEO_P1, 1, 32, SDM670_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus_arm9, SDM670_MASTER_VIDEO_PROC, 1, 8, SDM670_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qhm_snoc_cfg, SDM670_MASTER_SNOC_CFG, 1, 4, SDM670_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, SDM670_MASTER_A1NOC_SNOC, 1, 16, SDM670_SLAVE_PIMEM, SDM670_SLAVE_SNOC_MEM_NOC_SF, SDM670_SLAVE_OCIMEM, SDM670_SLAVE_APPSS, SDM670_SLAVE_SNOC_CNOC, SDM670_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_aggre2_noc, SDM670_MASTER_A2NOC_SNOC, 1, 16, SDM670_SLAVE_PIMEM, SDM670_SLAVE_SNOC_MEM_NOC_SF, SDM670_SLAVE_OCIMEM, SDM670_SLAVE_APPSS, SDM670_SLAVE_SNOC_CNOC, SDM670_SLAVE_TCU, SDM670_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_gladiator_sodv, SDM670_MASTER_GNOC_SNOC, 1, 8, SDM670_SLAVE_PIMEM, SDM670_SLAVE_OCIMEM, SDM670_SLAVE_APPSS, SDM670_SLAVE_SNOC_CNOC, SDM670_SLAVE_TCU, SDM670_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_memnoc, SDM670_MASTER_MEM_NOC_SNOC, 1, 8, SDM670_SLAVE_OCIMEM, SDM670_SLAVE_APPSS, SDM670_SLAVE_PIMEM, SDM670_SLAVE_SNOC_CNOC, SDM670_SLAVE_QDSS_STM);
-DEFINE_QNODE(qxm_pimem, SDM670_MASTER_PIMEM, 1, 8, SDM670_SLAVE_OCIMEM, SDM670_SLAVE_SNOC_MEM_NOC_GC);
-DEFINE_QNODE(xm_gic, SDM670_MASTER_GIC, 1, 8, SDM670_SLAVE_OCIMEM, SDM670_SLAVE_SNOC_MEM_NOC_GC);
-DEFINE_QNODE(qns_a1noc_snoc, SDM670_SLAVE_A1NOC_SNOC, 1, 16, SDM670_MASTER_A1NOC_SNOC);
-DEFINE_QNODE(srvc_aggre1_noc, SDM670_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(qns_a2noc_snoc, SDM670_SLAVE_A2NOC_SNOC, 1, 16, SDM670_MASTER_A2NOC_SNOC);
-DEFINE_QNODE(srvc_aggre2_noc, SDM670_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qns_camnoc_uncomp, SDM670_SLAVE_CAMNOC_UNCOMP, 1, 32);
-DEFINE_QNODE(qhs_a1_noc_cfg, SDM670_SLAVE_A1NOC_CFG, 1, 4, SDM670_MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SDM670_SLAVE_A2NOC_CFG, 1, 4, SDM670_MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_aop, SDM670_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(qhs_aoss, SDM670_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_camera_cfg, SDM670_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SDM670_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_compute_dsp_cfg, SDM670_SLAVE_CDSP_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SDM670_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SDM670_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_dcc_cfg, SDM670_SLAVE_DCC_CFG, 1, 4, SDM670_MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_ddrss_cfg, SDM670_SLAVE_CNOC_DDRSS, 1, 4);
-DEFINE_QNODE(qhs_display_cfg, SDM670_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_emmc_cfg, SDM670_SLAVE_EMMC_CFG, 1, 4);
-DEFINE_QNODE(qhs_glm, SDM670_SLAVE_GLM, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SDM670_SLAVE_GRAPHICS_3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_imem_cfg, SDM670_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SDM670_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mnoc_cfg, SDM670_SLAVE_CNOC_MNOC_CFG, 1, 4, SDM670_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(qhs_pdm, SDM670_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_phy_refgen_south, SDM670_SLAVE_SOUTH_PHY_CFG, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SDM670_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_prng, SDM670_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SDM670_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qupv3_north, SDM670_SLAVE_BLSP_2, 1, 4);
-DEFINE_QNODE(qhs_qupv3_south, SDM670_SLAVE_BLSP_1, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SDM670_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_sdc4, SDM670_SLAVE_SDCC_4, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SDM670_SLAVE_SNOC_CFG, 1, 4, SDM670_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spdm, SDM670_SLAVE_SPDM_WRAPPER, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SDM670_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm_north, SDM670_SLAVE_TLMM_NORTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm_south, SDM670_SLAVE_TLMM_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_tsif, SDM670_SLAVE_TSIF, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SDM670_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3_0, SDM670_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SDM670_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SDM670_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(qns_cnoc_a2noc, SDM670_SLAVE_CNOC_A2NOC, 1, 8, SDM670_MASTER_CNOC_A2NOC);
-DEFINE_QNODE(srvc_cnoc, SDM670_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(qhs_llcc, SDM670_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_memnoc, SDM670_SLAVE_MEM_NOC_CFG, 1, 4, SDM670_MASTER_MEM_NOC_CFG);
-DEFINE_QNODE(qns_gladiator_sodv, SDM670_SLAVE_GNOC_SNOC, 1, 8, SDM670_MASTER_GNOC_SNOC);
-DEFINE_QNODE(qns_gnoc_memnoc, SDM670_SLAVE_GNOC_MEM_NOC, 2, 32, SDM670_MASTER_GNOC_MEM_NOC);
-DEFINE_QNODE(srvc_gnoc, SDM670_SLAVE_SERVICE_GNOC, 1, 4);
-DEFINE_QNODE(ebi, SDM670_SLAVE_EBI_CH0, 2, 4);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SDM670_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_apps_io, SDM670_SLAVE_MEM_NOC_GNOC, 1, 32);
-DEFINE_QNODE(qns_llcc, SDM670_SLAVE_LLCC, 2, 16, SDM670_MASTER_LLCC);
-DEFINE_QNODE(qns_memnoc_snoc, SDM670_SLAVE_MEM_NOC_SNOC, 1, 8, SDM670_MASTER_MEM_NOC_SNOC);
-DEFINE_QNODE(srvc_memnoc, SDM670_SLAVE_SERVICE_MEM_NOC, 1, 4);
-DEFINE_QNODE(qns2_mem_noc, SDM670_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SDM670_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_hf, SDM670_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SDM670_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SDM670_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qhs_apss, SDM670_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qns_cnoc, SDM670_SLAVE_SNOC_CNOC, 1, 8, SDM670_MASTER_SNOC_CNOC);
-DEFINE_QNODE(qns_memnoc_gc, SDM670_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDM670_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_memnoc_sf, SDM670_SLAVE_SNOC_MEM_NOC_SF, 1, 16, SDM670_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SDM670_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(qxs_pimem, SDM670_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SDM670_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_qdss_stm, SDM670_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SDM670_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = SDM670_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SDM670_MASTER_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_tsif = {
+	.name = "qhm_tsif",
+	.id = SDM670_MASTER_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_emmc = {
+	.name = "xm_emmc",
+	.id = SDM670_MASTER_EMMC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SDM670_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SDM670_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SDM670_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SDM670_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SDM670_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SDM670_MASTER_BLSP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = SDM670_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SDM670_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SDM670_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SDM670_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SDM670_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = SDM670_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
+	.name = "qxm_camnoc_hf1_uncomp",
+	.id = SDM670_MASTER_CAMNOC_HF1_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = SDM670_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qhm_spdm = {
+	.name = "qhm_spdm",
+	.id = SDM670_MASTER_SPDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SDM670_MASTER_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 38,
+	.links = { SDM670_SLAVE_TLMM_SOUTH,
+		   SDM670_SLAVE_CAMERA_CFG,
+		   SDM670_SLAVE_SDCC_4,
+		   SDM670_SLAVE_SDCC_2,
+		   SDM670_SLAVE_CNOC_MNOC_CFG,
+		   SDM670_SLAVE_UFS_MEM_CFG,
+		   SDM670_SLAVE_GLM,
+		   SDM670_SLAVE_PDM,
+		   SDM670_SLAVE_A2NOC_CFG,
+		   SDM670_SLAVE_QDSS_CFG,
+		   SDM670_SLAVE_DISPLAY_CFG,
+		   SDM670_SLAVE_TCSR,
+		   SDM670_SLAVE_DCC_CFG,
+		   SDM670_SLAVE_CNOC_DDRSS,
+		   SDM670_SLAVE_SNOC_CFG,
+		   SDM670_SLAVE_SOUTH_PHY_CFG,
+		   SDM670_SLAVE_GRAPHICS_3D_CFG,
+		   SDM670_SLAVE_VENUS_CFG,
+		   SDM670_SLAVE_TSIF,
+		   SDM670_SLAVE_CDSP_CFG,
+		   SDM670_SLAVE_AOP,
+		   SDM670_SLAVE_BLSP_2,
+		   SDM670_SLAVE_SERVICE_CNOC,
+		   SDM670_SLAVE_USB3,
+		   SDM670_SLAVE_IPA_CFG,
+		   SDM670_SLAVE_RBCPR_CX_CFG,
+		   SDM670_SLAVE_A1NOC_CFG,
+		   SDM670_SLAVE_AOSS,
+		   SDM670_SLAVE_PRNG,
+		   SDM670_SLAVE_VSENSE_CTRL_CFG,
+		   SDM670_SLAVE_EMMC_CFG,
+		   SDM670_SLAVE_BLSP_1,
+		   SDM670_SLAVE_SPDM_WRAPPER,
+		   SDM670_SLAVE_CRYPTO_0_CFG,
+		   SDM670_SLAVE_PIMEM_CFG,
+		   SDM670_SLAVE_TLMM_NORTH,
+		   SDM670_SLAVE_CLK_CTL,
+		   SDM670_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc = {
+	.name = "qhm_cnoc",
+	.id = SDM670_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SDM670_SLAVE_MEM_NOC_CFG,
+		   SDM670_SLAVE_LLCC_CFG
+	},
+};
+
+static struct qcom_icc_node acm_l3 = {
+	.name = "acm_l3",
+	.id = SDM670_MASTER_AMPSS_M0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDM670_SLAVE_SERVICE_GNOC,
+		   SDM670_SLAVE_GNOC_SNOC,
+		   SDM670_SLAVE_GNOC_MEM_NOC
+	},
+};
+
+static struct qcom_icc_node pm_gnoc_cfg = {
+	.name = "pm_gnoc_cfg",
+	.id = SDM670_MASTER_GNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_SERVICE_GNOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SDM670_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node acm_tcu = {
+	.name = "acm_tcu",
+	.id = SDM670_MASTER_TCU_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
+		   SDM670_SLAVE_LLCC,
+		   SDM670_SLAVE_MEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_memnoc_cfg = {
+	.name = "qhm_memnoc_cfg",
+	.id = SDM670_MASTER_MEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SDM670_SLAVE_SERVICE_MEM_NOC,
+		   SDM670_SLAVE_MSS_PROC_MS_MPU_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_apps = {
+	.name = "qnm_apps",
+	.id = SDM670_MASTER_GNOC_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SDM670_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SDM670_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
+		   SDM670_SLAVE_LLCC,
+		   SDM670_SLAVE_MEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SDM670_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SDM670_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
+		   SDM670_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qxm_gpu = {
+	.name = "qxm_gpu",
+	.id = SDM670_MASTER_GRAPHICS_3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
+		   SDM670_SLAVE_LLCC,
+		   SDM670_SLAVE_MEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SDM670_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0 = {
+	.name = "qxm_camnoc_hf0",
+	.id = SDM670_MASTER_CAMNOC_HF0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1 = {
+	.name = "qxm_camnoc_hf1",
+	.id = SDM670_MASTER_CAMNOC_HF1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SDM670_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SDM670_MASTER_MDP_PORT0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp1 = {
+	.name = "qxm_mdp1",
+	.id = SDM670_MASTER_MDP_PORT1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SDM670_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus0 = {
+	.name = "qxm_venus0",
+	.id = SDM670_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus1 = {
+	.name = "qxm_venus1",
+	.id = SDM670_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 = {
+	.name = "qxm_venus_arm9",
+	.id = SDM670_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SDM670_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SDM670_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SDM670_SLAVE_PIMEM,
+		   SDM670_SLAVE_SNOC_MEM_NOC_SF,
+		   SDM670_SLAVE_OCIMEM,
+		   SDM670_SLAVE_APPSS,
+		   SDM670_SLAVE_SNOC_CNOC,
+		   SDM670_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SDM670_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 7,
+	.links = { SDM670_SLAVE_PIMEM,
+		   SDM670_SLAVE_SNOC_MEM_NOC_SF,
+		   SDM670_SLAVE_OCIMEM,
+		   SDM670_SLAVE_APPSS,
+		   SDM670_SLAVE_SNOC_CNOC,
+		   SDM670_SLAVE_TCU,
+		   SDM670_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_gladiator_sodv = {
+	.name = "qnm_gladiator_sodv",
+	.id = SDM670_MASTER_GNOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 6,
+	.links = { SDM670_SLAVE_PIMEM,
+		   SDM670_SLAVE_OCIMEM,
+		   SDM670_SLAVE_APPSS,
+		   SDM670_SLAVE_SNOC_CNOC,
+		   SDM670_SLAVE_TCU,
+		   SDM670_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc = {
+	.name = "qnm_memnoc",
+	.id = SDM670_MASTER_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 5,
+	.links = { SDM670_SLAVE_OCIMEM,
+		   SDM670_SLAVE_APPSS,
+		   SDM670_SLAVE_PIMEM,
+		   SDM670_SLAVE_SNOC_CNOC,
+		   SDM670_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SDM670_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SDM670_SLAVE_OCIMEM,
+		   SDM670_SLAVE_SNOC_MEM_NOC_GC
+	},
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SDM670_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SDM670_SLAVE_OCIMEM,
+		   SDM670_SLAVE_SNOC_MEM_NOC_GC
+	},
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SDM670_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM670_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SDM670_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SDM670_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM670_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SDM670_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = SDM670_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SDM670_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SDM670_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SDM670_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SDM670_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SDM670_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SDM670_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute_dsp_cfg = {
+	.name = "qhs_compute_dsp_cfg",
+	.id = SDM670_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SDM670_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SDM670_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SDM670_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SDM670_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SDM670_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emmc_cfg = {
+	.name = "qhs_emmc_cfg",
+	.id = SDM670_SLAVE_EMMC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = SDM670_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SDM670_SLAVE_GRAPHICS_3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SDM670_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SDM670_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SDM670_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SDM670_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_phy_refgen_south = {
+	.name = "qhs_phy_refgen_south",
+	.id = SDM670_SLAVE_SOUTH_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SDM670_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SDM670_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SDM670_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_north = {
+	.name = "qhs_qupv3_north",
+	.id = SDM670_SLAVE_BLSP_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_south = {
+	.name = "qhs_qupv3_south",
+	.id = SDM670_SLAVE_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SDM670_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SDM670_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SDM670_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spdm = {
+	.name = "qhs_spdm",
+	.id = SDM670_SLAVE_SPDM_WRAPPER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SDM670_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_north = {
+	.name = "qhs_tlmm_north",
+	.id = SDM670_SLAVE_TLMM_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_south = {
+	.name = "qhs_tlmm_south",
+	.id = SDM670_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tsif = {
+	.name = "qhs_tsif",
+	.id = SDM670_SLAVE_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SDM670_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SDM670_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SDM670_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SDM670_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SDM670_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SDM670_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SDM670_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_memnoc = {
+	.name = "qhs_memnoc",
+	.id = SDM670_SLAVE_MEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM670_MASTER_MEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qns_gladiator_sodv = {
+	.name = "qns_gladiator_sodv",
+	.id = SDM670_SLAVE_GNOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_MASTER_GNOC_SNOC },
+};
+
+static struct qcom_icc_node qns_gnoc_memnoc = {
+	.name = "qns_gnoc_memnoc",
+	.id = SDM670_SLAVE_GNOC_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_MASTER_GNOC_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_gnoc = {
+	.name = "srvc_gnoc",
+	.id = SDM670_SLAVE_SERVICE_GNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SDM670_SLAVE_EBI_CH0,
+	.channels = 2,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SDM670_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_apps_io = {
+	.name = "qns_apps_io",
+	.id = SDM670_SLAVE_MEM_NOC_GNOC,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SDM670_SLAVE_LLCC,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM670_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_memnoc_snoc = {
+	.name = "qns_memnoc_snoc",
+	.id = SDM670_SLAVE_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_MASTER_MEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_memnoc = {
+	.name = "srvc_memnoc",
+	.id = SDM670_SLAVE_SERVICE_MEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns2_mem_noc = {
+	.name = "qns2_mem_noc",
+	.id = SDM670_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SDM670_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM670_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SDM670_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SDM670_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SDM670_SLAVE_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_MASTER_SNOC_CNOC },
+};
+
+static struct qcom_icc_node qns_memnoc_gc = {
+	.name = "qns_memnoc_gc",
+	.id = SDM670_SLAVE_SNOC_MEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM670_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_memnoc_sf = {
+	.name = "qns_memnoc_sf",
+	.id = SDM670_SLAVE_SNOC_MEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM670_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SDM670_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SDM670_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SDM670_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SDM670_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SDM670_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);

-- 
2.41.0

