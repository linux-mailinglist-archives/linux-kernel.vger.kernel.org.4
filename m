Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33D74EE20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGKMTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGKMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4A1981
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:44 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so89282791fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077922; x=1691669922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfW26KKCakGr0XnW62JQjJbOzU1ICw/ACEt2aDpEhhQ=;
        b=ZBe4RJLdyVEwRjDLGVL37BqiJihEH8dcHIGFoNoP53fepXEUEHPazj2optgiPpgDXq
         OdKdh2jstG/ncih0MMIjtx2om7tMicl3quJn0nMeX764gMNxFWaHZfBfsHjQ6hwxtQax
         /NFuKVxYTrIt+7nd863pxfvZvgjrXM9BgNqqsnV3eW7hkfyAhhmGVMfvFDgo2h+Wz3Xb
         Ltk3pwoI4HigFte7hlumgUj5VyEgG/ucW1eSFchj4PvdKH0/Nri2xGxrIjCsEWIBZ60J
         l8Fhgg5mb/Jj+MUfB9U9OJ+sFNZcHGINeuIVqFYl974kKFYwOoI2JfQ8uA40szZ6suyH
         In5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077922; x=1691669922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfW26KKCakGr0XnW62JQjJbOzU1ICw/ACEt2aDpEhhQ=;
        b=VNM1w8sNZtoPD+/mO0FFNd42wsPrT7v8xzIa2QgZAB0RMh0hzH/gbv5vV9x+y+R1WM
         DKfnJOY2PITbhDwnv7y+uf7ibR9mQBS57MAgZkOdETRS07NmfC8XfV8X/x2okIeCBaFR
         YrPl1G4iqfoNrinMXY7OPDqXL+zBrp9qwHruZeO9rhHWUhzvQHqtdFPluuZPHdT5BHUC
         WojqVkAqMGBgKTf8CImo0oNMLYtf3H4ol0LXF9EOfk17K06z3qKHihaKkHkgJBTs3rk7
         +QV8gGewtaipAiwhaz1CaZH8gHl6SUNxcVgVBFBszvM4bAPlFwmt6OMnxO5c8IK8j+Mv
         moEw==
X-Gm-Message-State: ABy/qLb3iQ4bxCAZ7emxh9YdwVEZgAmXGlxOkQDRICdiUa1xUUu2AtDz
        tyk90/X8ZULAc+YxJgFMWEsNoQ==
X-Google-Smtp-Source: APBJJlGjqK6wxgBWvk7wjffI7rDDPzNgRkzRueCgjqxFVJlk+Lc9jO82Pp0ypzk3j9HauFpXPx8qyw==
X-Received: by 2002:a2e:9b4f:0:b0:2b0:297c:cbdf with SMTP id o15-20020a2e9b4f000000b002b0297ccbdfmr14155619ljj.1.1689077922606;
        Tue, 11 Jul 2023 05:18:42 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:11 +0200
Subject: [PATCH 12/53] interconnect: qcom: sm8150: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-12-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=43197;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KfeJu81yzM9UtZk6tkFn5rt1KeKxy7YZJdapT6RtiNw=;
 b=T8eC75GAZGawcHThG7JAbyPR4AmdmaoW8EFm/joEvmxnDDGfl888D7MR5q96nD7rk7l8HkAu1
 ciO7wLacAWOB6/b+0WKlSa2N3GcscOr0fn9I/hrc1p+Cydc2QUslnxb
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
 drivers/interconnect/qcom/sm8150.c | 1401 ++++++++++++++++++++++++++++++++----
 1 file changed, 1263 insertions(+), 138 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index c5ab29322164..29f16899cf5d 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -15,144 +15,1269 @@
 #include "icc-rpmh.h"
 #include "sm8150.h"
 
-DEFINE_QNODE(qhm_a1noc_cfg, SM8150_MASTER_A1NOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(qhm_qup0, SM8150_MASTER_QUP_0, 1, 4, SM8150_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_emac, SM8150_MASTER_EMAC, 1, 8, SM8150_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_ufs_mem, SM8150_MASTER_UFS_MEM, 1, 8, SM8150_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_usb3_0, SM8150_MASTER_USB3, 1, 8, SM8150_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_usb3_1, SM8150_MASTER_USB3_1, 1, 8, SM8150_A1NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_a2noc_cfg, SM8150_MASTER_A2NOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qhm_qdss_bam, SM8150_MASTER_QDSS_BAM, 1, 4, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qspi, SM8150_MASTER_QSPI, 1, 4, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qup1, SM8150_MASTER_QUP_1, 1, 4, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qup2, SM8150_MASTER_QUP_2, 1, 4, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_sensorss_ahb, SM8150_MASTER_SENSORS_AHB, 1, 4, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_tsif, SM8150_MASTER_TSIF, 1, 4, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qnm_cnoc, SM8150_MASTER_CNOC_A2NOC, 1, 8, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_crypto, SM8150_MASTER_CRYPTO_CORE_0, 1, 8, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_ipa, SM8150_MASTER_IPA, 1, 8, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_pcie3_0, SM8150_MASTER_PCIE, 1, 8, SM8150_SLAVE_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(xm_pcie3_1, SM8150_MASTER_PCIE_1, 1, 8, SM8150_SLAVE_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(xm_qdss_etr, SM8150_MASTER_QDSS_ETR, 1, 8, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_sdc2, SM8150_MASTER_SDCC_2, 1, 8, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_sdc4, SM8150_MASTER_SDCC_4, 1, 8, SM8150_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SM8150_MASTER_CAMNOC_HF0_UNCOMP, 1, 32, SM8150_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_hf1_uncomp, SM8150_MASTER_CAMNOC_HF1_UNCOMP, 1, 32, SM8150_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_sf_uncomp, SM8150_MASTER_CAMNOC_SF_UNCOMP, 1, 32, SM8150_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qnm_npu, SM8150_MASTER_NPU, 1, 32, SM8150_SLAVE_CDSP_MEM_NOC);
-DEFINE_QNODE(qhm_spdm, SM8150_MASTER_SPDM, 1, 4, SM8150_SLAVE_CNOC_A2NOC);
-DEFINE_QNODE(qnm_snoc, SM8150_SNOC_CNOC_MAS, 1, 8, SM8150_SLAVE_TLMM_SOUTH, SM8150_SLAVE_CDSP_CFG, SM8150_SLAVE_SPSS_CFG, SM8150_SLAVE_CAMERA_CFG, SM8150_SLAVE_SDCC_4, SM8150_SLAVE_SDCC_2, SM8150_SLAVE_CNOC_MNOC_CFG, SM8150_SLAVE_EMAC_CFG, SM8150_SLAVE_UFS_MEM_CFG, SM8150_SLAVE_TLMM_EAST, SM8150_SLAVE_SSC_CFG, SM8150_SLAVE_SNOC_CFG, SM8150_SLAVE_NORTH_PHY_CFG, SM8150_SLAVE_QUP_0, SM8150_SLAVE_GLM, SM8150_SLAVE_PCIE_1_CFG, SM8150_SLAVE_A2NOC_CFG, SM8150_SLAVE_QDSS_CFG, SM8150_SLAVE_DISPLAY_CFG, SM8150_SLAVE_TCSR, SM8150_SLAVE_CNOC_DDRSS, SM8150_SLAVE_RBCPR_MMCX_CFG, SM8150_SLAVE_NPU_CFG, SM8150_SLAVE_PCIE_0_CFG, SM8150_SLAVE_GRAPHICS_3D_CFG, SM8150_SLAVE_VENUS_CFG, SM8150_SLAVE_TSIF, SM8150_SLAVE_IPA_CFG, SM8150_SLAVE_CLK_CTL, SM8150_SLAVE_AOP, SM8150_SLAVE_QUP_1, SM8150_SLAVE_AHB2PHY_SOUTH, SM8150_SLAVE_USB3_1, SM8150_SLAVE_SERVICE_CNOC, SM8150_SLAVE_UFS_CARD_CFG, SM8150_SLAVE_QUP_2, SM8150_SLAVE_RBCPR_CX_CFG, SM8150_SLAVE_TLMM_WEST, SM8150_SLAVE_A1NOC_CFG, SM8150_SLAVE_AOSS, SM8150
 _SLAVE_PRNG, SM8150_SLAVE_VSENSE_CTRL_CFG, SM8150_SLAVE_QSPI, SM8150_SLAVE_USB3, SM8150_SLAVE_SPDM_WRAPPER, SM8150_SLAVE_CRYPTO_0_CFG, SM8150_SLAVE_PIMEM_CFG, SM8150_SLAVE_TLMM_NORTH, SM8150_SLAVE_RBCPR_MX_CFG, SM8150_SLAVE_IMEM_CFG);
-DEFINE_QNODE(xm_qdss_dap, SM8150_MASTER_QDSS_DAP, 1, 8, SM8150_SLAVE_TLMM_SOUTH, SM8150_SLAVE_CDSP_CFG, SM8150_SLAVE_SPSS_CFG, SM8150_SLAVE_CAMERA_CFG, SM8150_SLAVE_SDCC_4, SM8150_SLAVE_SDCC_2, SM8150_SLAVE_CNOC_MNOC_CFG, SM8150_SLAVE_EMAC_CFG, SM8150_SLAVE_UFS_MEM_CFG, SM8150_SLAVE_TLMM_EAST, SM8150_SLAVE_SSC_CFG, SM8150_SLAVE_SNOC_CFG, SM8150_SLAVE_NORTH_PHY_CFG, SM8150_SLAVE_QUP_0, SM8150_SLAVE_GLM, SM8150_SLAVE_PCIE_1_CFG, SM8150_SLAVE_A2NOC_CFG, SM8150_SLAVE_QDSS_CFG, SM8150_SLAVE_DISPLAY_CFG, SM8150_SLAVE_TCSR, SM8150_SLAVE_CNOC_DDRSS, SM8150_SLAVE_CNOC_A2NOC, SM8150_SLAVE_RBCPR_MMCX_CFG, SM8150_SLAVE_NPU_CFG, SM8150_SLAVE_PCIE_0_CFG, SM8150_SLAVE_GRAPHICS_3D_CFG, SM8150_SLAVE_VENUS_CFG, SM8150_SLAVE_TSIF, SM8150_SLAVE_IPA_CFG, SM8150_SLAVE_CLK_CTL, SM8150_SLAVE_AOP, SM8150_SLAVE_QUP_1, SM8150_SLAVE_AHB2PHY_SOUTH, SM8150_SLAVE_USB3_1, SM8150_SLAVE_SERVICE_CNOC, SM8150_SLAVE_UFS_CARD_CFG, SM8150_SLAVE_QUP_2, SM8150_SLAVE_RBCPR_CX_CFG, SM8150_SLAVE_TLMM_WEST, SM8150_SLAVE_A1NOC_
 CFG, SM8150_SLAVE_AOSS, SM8150_SLAVE_PRNG, SM8150_SLAVE_VSENSE_CTRL_CFG, SM8150_SLAVE_QSPI, SM8150_SLAVE_USB3, SM8150_SLAVE_SPDM_WRAPPER, SM8150_SLAVE_CRYPTO_0_CFG, SM8150_SLAVE_PIMEM_CFG, SM8150_SLAVE_TLMM_NORTH, SM8150_SLAVE_RBCPR_MX_CFG, SM8150_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qhm_cnoc_dc_noc, SM8150_MASTER_CNOC_DC_NOC, 1, 4, SM8150_SLAVE_GEM_NOC_CFG, SM8150_SLAVE_LLCC_CFG);
-DEFINE_QNODE(acm_apps, SM8150_MASTER_AMPSS_M0, 2, 32, SM8150_SLAVE_ECC, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(acm_gpu_tcu, SM8150_MASTER_GPU_TCU, 1, 8, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(acm_sys_tcu, SM8150_MASTER_SYS_TCU, 1, 8, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qhm_gemnoc_cfg, SM8150_MASTER_GEM_NOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_GEM_NOC, SM8150_SLAVE_MSS_PROC_MS_MPU_CFG);
-DEFINE_QNODE(qnm_cmpnoc, SM8150_MASTER_COMPUTE_NOC, 2, 32, SM8150_SLAVE_ECC, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_gpu, SM8150_MASTER_GRAPHICS_3D, 2, 32, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_mnoc_hf, SM8150_MASTER_MNOC_HF_MEM_NOC, 2, 32, SM8150_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, SM8150_MASTER_MNOC_SF_MEM_NOC, 1, 32, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_pcie, SM8150_MASTER_GEM_NOC_PCIE_SNOC, 1, 16, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SM8150_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8150_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SM8150_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8150_SLAVE_LLCC);
-DEFINE_QNODE(qxm_ecc, SM8150_MASTER_ECC, 2, 32, SM8150_SLAVE_LLCC);
-DEFINE_QNODE(llcc_mc, SM8150_MASTER_LLCC, 4, 4, SM8150_SLAVE_EBI_CH0);
-DEFINE_QNODE(qhm_mnoc_cfg, SM8150_MASTER_CNOC_MNOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qxm_camnoc_hf0, SM8150_MASTER_CAMNOC_HF0, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_hf1, SM8150_MASTER_CAMNOC_HF1, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_sf, SM8150_MASTER_CAMNOC_SF, 1, 32, SM8150_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SM8150_MASTER_MDP_PORT0, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp1, SM8150_MASTER_MDP_PORT1, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, SM8150_MASTER_ROTATOR, 1, 32, SM8150_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus0, SM8150_MASTER_VIDEO_P0, 1, 32, SM8150_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus1, SM8150_MASTER_VIDEO_P1, 1, 32, SM8150_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus_arm9, SM8150_MASTER_VIDEO_PROC, 1, 8, SM8150_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qhm_snoc_cfg, SM8150_MASTER_SNOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, SM8150_A1NOC_SNOC_MAS, 1, 16, SM8150_SLAVE_SNOC_GEM_NOC_SF, SM8150_SLAVE_PIMEM, SM8150_SLAVE_OCIMEM, SM8150_SLAVE_APPSS, SM8150_SNOC_CNOC_SLV, SM8150_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_aggre2_noc, SM8150_A2NOC_SNOC_MAS, 1, 16, SM8150_SLAVE_SNOC_GEM_NOC_SF, SM8150_SLAVE_PIMEM, SM8150_SLAVE_OCIMEM, SM8150_SLAVE_APPSS, SM8150_SNOC_CNOC_SLV, SM8150_SLAVE_PCIE_0, SM8150_SLAVE_PCIE_1, SM8150_SLAVE_TCU, SM8150_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_gemnoc, SM8150_MASTER_GEM_NOC_SNOC, 1, 8, SM8150_SLAVE_PIMEM, SM8150_SLAVE_OCIMEM, SM8150_SLAVE_APPSS, SM8150_SNOC_CNOC_SLV, SM8150_SLAVE_TCU, SM8150_SLAVE_QDSS_STM);
-DEFINE_QNODE(qxm_pimem, SM8150_MASTER_PIMEM, 1, 8, SM8150_SLAVE_SNOC_GEM_NOC_GC, SM8150_SLAVE_OCIMEM);
-DEFINE_QNODE(xm_gic, SM8150_MASTER_GIC, 1, 8, SM8150_SLAVE_SNOC_GEM_NOC_GC, SM8150_SLAVE_OCIMEM);
-DEFINE_QNODE(qns_a1noc_snoc, SM8150_A1NOC_SNOC_SLV, 1, 16, SM8150_A1NOC_SNOC_MAS);
-DEFINE_QNODE(srvc_aggre1_noc, SM8150_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(qns_a2noc_snoc, SM8150_A2NOC_SNOC_SLV, 1, 16, SM8150_A2NOC_SNOC_MAS);
-DEFINE_QNODE(qns_pcie_mem_noc, SM8150_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16, SM8150_MASTER_GEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(srvc_aggre2_noc, SM8150_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qns_camnoc_uncomp, SM8150_SLAVE_CAMNOC_UNCOMP, 1, 32);
-DEFINE_QNODE(qns_cdsp_mem_noc, SM8150_SLAVE_CDSP_MEM_NOC, 2, 32, SM8150_MASTER_COMPUTE_NOC);
-DEFINE_QNODE(qhs_a1_noc_cfg, SM8150_SLAVE_A1NOC_CFG, 1, 4, SM8150_MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SM8150_SLAVE_A2NOC_CFG, 1, 4, SM8150_MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_ahb2phy_south, SM8150_SLAVE_AHB2PHY_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_aop, SM8150_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(qhs_aoss, SM8150_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_camera_cfg, SM8150_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SM8150_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_compute_dsp, SM8150_SLAVE_CDSP_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SM8150_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mmcx, SM8150_SLAVE_RBCPR_MMCX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mx, SM8150_SLAVE_RBCPR_MX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SM8150_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SM8150_SLAVE_CNOC_DDRSS, 1, 4, SM8150_MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_display_cfg, SM8150_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_emac_cfg, SM8150_SLAVE_EMAC_CFG, 1, 4);
-DEFINE_QNODE(qhs_glm, SM8150_SLAVE_GLM, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SM8150_SLAVE_GRAPHICS_3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_imem_cfg, SM8150_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SM8150_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mnoc_cfg, SM8150_SLAVE_CNOC_MNOC_CFG, 1, 4, SM8150_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(qhs_npu_cfg, SM8150_SLAVE_NPU_CFG, 1, 4);
-DEFINE_QNODE(qhs_pcie0_cfg, SM8150_SLAVE_PCIE_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_pcie1_cfg, SM8150_SLAVE_PCIE_1_CFG, 1, 4);
-DEFINE_QNODE(qhs_phy_refgen_north, SM8150_SLAVE_NORTH_PHY_CFG, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SM8150_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_prng, SM8150_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SM8150_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qspi, SM8150_SLAVE_QSPI, 1, 4);
-DEFINE_QNODE(qhs_qupv3_east, SM8150_SLAVE_QUP_2, 1, 4);
-DEFINE_QNODE(qhs_qupv3_north, SM8150_SLAVE_QUP_1, 1, 4);
-DEFINE_QNODE(qhs_qupv3_south, SM8150_SLAVE_QUP_0, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SM8150_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_sdc4, SM8150_SLAVE_SDCC_4, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SM8150_SLAVE_SNOC_CFG, 1, 4, SM8150_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spdm, SM8150_SLAVE_SPDM_WRAPPER, 1, 4);
-DEFINE_QNODE(qhs_spss_cfg, SM8150_SLAVE_SPSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_ssc_cfg, SM8150_SLAVE_SSC_CFG, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SM8150_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm_east, SM8150_SLAVE_TLMM_EAST, 1, 4);
-DEFINE_QNODE(qhs_tlmm_north, SM8150_SLAVE_TLMM_NORTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm_south, SM8150_SLAVE_TLMM_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm_west, SM8150_SLAVE_TLMM_WEST, 1, 4);
-DEFINE_QNODE(qhs_tsif, SM8150_SLAVE_TSIF, 1, 4);
-DEFINE_QNODE(qhs_ufs_card_cfg, SM8150_SLAVE_UFS_CARD_CFG, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SM8150_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3_0, SM8150_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_usb3_1, SM8150_SLAVE_USB3_1, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SM8150_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8150_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(qns_cnoc_a2noc, SM8150_SLAVE_CNOC_A2NOC, 1, 8, SM8150_MASTER_CNOC_A2NOC);
-DEFINE_QNODE(srvc_cnoc, SM8150_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(qhs_llcc, SM8150_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_memnoc, SM8150_SLAVE_GEM_NOC_CFG, 1, 4, SM8150_MASTER_GEM_NOC_CFG);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM8150_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_ecc, SM8150_SLAVE_ECC, 1, 32);
-DEFINE_QNODE(qns_gem_noc_snoc, SM8150_SLAVE_GEM_NOC_SNOC, 1, 8, SM8150_MASTER_GEM_NOC_SNOC);
-DEFINE_QNODE(qns_llcc, SM8150_SLAVE_LLCC, 4, 16, SM8150_MASTER_LLCC);
-DEFINE_QNODE(srvc_gemnoc, SM8150_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ebi, SM8150_SLAVE_EBI_CH0, 4, 4);
-DEFINE_QNODE(qns2_mem_noc, SM8150_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SM8150_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_hf, SM8150_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8150_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SM8150_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qhs_apss, SM8150_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qns_cnoc, SM8150_SNOC_CNOC_SLV, 1, 8, SM8150_SNOC_CNOC_MAS);
-DEFINE_QNODE(qns_gemnoc_gc, SM8150_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM8150_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_gemnoc_sf, SM8150_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM8150_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SM8150_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(qxs_pimem, SM8150_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SM8150_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_pcie_0, SM8150_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(xs_pcie_1, SM8150_SLAVE_PCIE_1, 1, 8);
-DEFINE_QNODE(xs_qdss_stm, SM8150_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SM8150_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = SM8150_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SM8150_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_emac = {
+	.name = "xm_emac",
+	.id = SM8150_MASTER_EMAC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM8150_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM8150_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = SM8150_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SM8150_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM8150_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SM8150_MASTER_QSPI,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SM8150_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SM8150_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_sensorss_ahb = {
+	.name = "qhm_sensorss_ahb",
+	.id = SM8150_MASTER_SENSORS_AHB,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_tsif = {
+	.name = "qhm_tsif",
+	.id = SM8150_MASTER_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = SM8150_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM8150_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM8150_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM8150_MASTER_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SM8150_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SM8150_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM8150_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SM8150_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = SM8150_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
+	.name = "qxm_camnoc_hf1_uncomp",
+	.id = SM8150_MASTER_CAMNOC_HF1_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = SM8150_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qnm_npu = {
+	.name = "qnm_npu",
+	.id = SM8150_MASTER_NPU,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_spdm = {
+	.name = "qhm_spdm",
+	.id = SM8150_MASTER_SPDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SM8150_SNOC_CNOC_MAS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 50,
+	.links = { SM8150_SLAVE_TLMM_SOUTH,
+		   SM8150_SLAVE_CDSP_CFG,
+		   SM8150_SLAVE_SPSS_CFG,
+		   SM8150_SLAVE_CAMERA_CFG,
+		   SM8150_SLAVE_SDCC_4,
+		   SM8150_SLAVE_SDCC_2,
+		   SM8150_SLAVE_CNOC_MNOC_CFG,
+		   SM8150_SLAVE_EMAC_CFG,
+		   SM8150_SLAVE_UFS_MEM_CFG,
+		   SM8150_SLAVE_TLMM_EAST,
+		   SM8150_SLAVE_SSC_CFG,
+		   SM8150_SLAVE_SNOC_CFG,
+		   SM8150_SLAVE_NORTH_PHY_CFG,
+		   SM8150_SLAVE_QUP_0,
+		   SM8150_SLAVE_GLM,
+		   SM8150_SLAVE_PCIE_1_CFG,
+		   SM8150_SLAVE_A2NOC_CFG,
+		   SM8150_SLAVE_QDSS_CFG,
+		   SM8150_SLAVE_DISPLAY_CFG,
+		   SM8150_SLAVE_TCSR,
+		   SM8150_SLAVE_CNOC_DDRSS,
+		   SM8150_SLAVE_RBCPR_MMCX_CFG,
+		   SM8150_SLAVE_NPU_CFG,
+		   SM8150_SLAVE_PCIE_0_CFG,
+		   SM8150_SLAVE_GRAPHICS_3D_CFG,
+		   SM8150_SLAVE_VENUS_CFG,
+		   SM8150_SLAVE_TSIF,
+		   SM8150_SLAVE_IPA_CFG,
+		   SM8150_SLAVE_CLK_CTL,
+		   SM8150_SLAVE_AOP,
+		   SM8150_SLAVE_QUP_1,
+		   SM8150_SLAVE_AHB2PHY_SOUTH,
+		   SM8150_SLAVE_USB3_1,
+		   SM8150_SLAVE_SERVICE_CNOC,
+		   SM8150_SLAVE_UFS_CARD_CFG,
+		   SM8150_SLAVE_QUP_2,
+		   SM8150_SLAVE_RBCPR_CX_CFG,
+		   SM8150_SLAVE_TLMM_WEST,
+		   SM8150_SLAVE_A1NOC_CFG,
+		   SM8150_SLAVE_AOSS,
+		   SM8150_SLAVE_PRNG,
+		   SM8150_SLAVE_VSENSE_CTRL_CFG,
+		   SM8150_SLAVE_QSPI,
+		   SM8150_SLAVE_USB3,
+		   SM8150_SLAVE_SPDM_WRAPPER,
+		   SM8150_SLAVE_CRYPTO_0_CFG,
+		   SM8150_SLAVE_PIMEM_CFG,
+		   SM8150_SLAVE_TLMM_NORTH,
+		   SM8150_SLAVE_RBCPR_MX_CFG,
+		   SM8150_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SM8150_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 51,
+	.links = { SM8150_SLAVE_TLMM_SOUTH,
+		   SM8150_SLAVE_CDSP_CFG,
+		   SM8150_SLAVE_SPSS_CFG,
+		   SM8150_SLAVE_CAMERA_CFG,
+		   SM8150_SLAVE_SDCC_4,
+		   SM8150_SLAVE_SDCC_2,
+		   SM8150_SLAVE_CNOC_MNOC_CFG,
+		   SM8150_SLAVE_EMAC_CFG,
+		   SM8150_SLAVE_UFS_MEM_CFG,
+		   SM8150_SLAVE_TLMM_EAST,
+		   SM8150_SLAVE_SSC_CFG,
+		   SM8150_SLAVE_SNOC_CFG,
+		   SM8150_SLAVE_NORTH_PHY_CFG,
+		   SM8150_SLAVE_QUP_0,
+		   SM8150_SLAVE_GLM,
+		   SM8150_SLAVE_PCIE_1_CFG,
+		   SM8150_SLAVE_A2NOC_CFG,
+		   SM8150_SLAVE_QDSS_CFG,
+		   SM8150_SLAVE_DISPLAY_CFG,
+		   SM8150_SLAVE_TCSR,
+		   SM8150_SLAVE_CNOC_DDRSS,
+		   SM8150_SLAVE_CNOC_A2NOC,
+		   SM8150_SLAVE_RBCPR_MMCX_CFG,
+		   SM8150_SLAVE_NPU_CFG,
+		   SM8150_SLAVE_PCIE_0_CFG,
+		   SM8150_SLAVE_GRAPHICS_3D_CFG,
+		   SM8150_SLAVE_VENUS_CFG,
+		   SM8150_SLAVE_TSIF,
+		   SM8150_SLAVE_IPA_CFG,
+		   SM8150_SLAVE_CLK_CTL,
+		   SM8150_SLAVE_AOP,
+		   SM8150_SLAVE_QUP_1,
+		   SM8150_SLAVE_AHB2PHY_SOUTH,
+		   SM8150_SLAVE_USB3_1,
+		   SM8150_SLAVE_SERVICE_CNOC,
+		   SM8150_SLAVE_UFS_CARD_CFG,
+		   SM8150_SLAVE_QUP_2,
+		   SM8150_SLAVE_RBCPR_CX_CFG,
+		   SM8150_SLAVE_TLMM_WEST,
+		   SM8150_SLAVE_A1NOC_CFG,
+		   SM8150_SLAVE_AOSS,
+		   SM8150_SLAVE_PRNG,
+		   SM8150_SLAVE_VSENSE_CTRL_CFG,
+		   SM8150_SLAVE_QSPI,
+		   SM8150_SLAVE_USB3,
+		   SM8150_SLAVE_SPDM_WRAPPER,
+		   SM8150_SLAVE_CRYPTO_0_CFG,
+		   SM8150_SLAVE_PIMEM_CFG,
+		   SM8150_SLAVE_TLMM_NORTH,
+		   SM8150_SLAVE_RBCPR_MX_CFG,
+		   SM8150_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc_dc_noc = {
+	.name = "qhm_cnoc_dc_noc",
+	.id = SM8150_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_GEM_NOC_CFG,
+		   SM8150_SLAVE_LLCC_CFG
+	},
+};
+
+static struct qcom_icc_node acm_apps = {
+	.name = "acm_apps",
+	.id = SM8150_MASTER_AMPSS_M0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM8150_SLAVE_ECC,
+		   SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node acm_gpu_tcu = {
+	.name = "acm_gpu_tcu",
+	.id = SM8150_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node acm_sys_tcu = {
+	.name = "acm_sys_tcu",
+	.id = SM8150_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg = {
+	.name = "qhm_gemnoc_cfg",
+	.id = SM8150_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_SERVICE_GEM_NOC,
+		   SM8150_SLAVE_MSS_PROC_MS_MPU_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SM8150_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM8150_SLAVE_ECC,
+		   SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SM8150_MASTER_GRAPHICS_3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM8150_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM8150_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM8150_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_LLCC,
+		   SM8150_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM8150_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM8150_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qxm_ecc = {
+	.name = "qxm_ecc",
+	.id = SM8150_MASTER_ECC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM8150_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SM8150_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0 = {
+	.name = "qxm_camnoc_hf0",
+	.id = SM8150_MASTER_CAMNOC_HF0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1 = {
+	.name = "qxm_camnoc_hf1",
+	.id = SM8150_MASTER_CAMNOC_HF1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SM8150_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SM8150_MASTER_MDP_PORT0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp1 = {
+	.name = "qxm_mdp1",
+	.id = SM8150_MASTER_MDP_PORT1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SM8150_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus0 = {
+	.name = "qxm_venus0",
+	.id = SM8150_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus1 = {
+	.name = "qxm_venus1",
+	.id = SM8150_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 = {
+	.name = "qxm_venus_arm9",
+	.id = SM8150_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SM8150_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM8150_A1NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SM8150_SLAVE_SNOC_GEM_NOC_SF,
+		   SM8150_SLAVE_PIMEM,
+		   SM8150_SLAVE_OCIMEM,
+		   SM8150_SLAVE_APPSS,
+		   SM8150_SNOC_CNOC_SLV,
+		   SM8150_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM8150_A2NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 9,
+	.links = { SM8150_SLAVE_SNOC_GEM_NOC_SF,
+		   SM8150_SLAVE_PIMEM,
+		   SM8150_SLAVE_OCIMEM,
+		   SM8150_SLAVE_APPSS,
+		   SM8150_SNOC_CNOC_SLV,
+		   SM8150_SLAVE_PCIE_0,
+		   SM8150_SLAVE_PCIE_1,
+		   SM8150_SLAVE_TCU,
+		   SM8150_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc = {
+	.name = "qnm_gemnoc",
+	.id = SM8150_MASTER_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 6,
+	.links = { SM8150_SLAVE_PIMEM,
+		   SM8150_SLAVE_OCIMEM,
+		   SM8150_SLAVE_APPSS,
+		   SM8150_SNOC_CNOC_SLV,
+		   SM8150_SLAVE_TCU,
+		   SM8150_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM8150_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_SNOC_GEM_NOC_GC,
+		   SM8150_SLAVE_OCIMEM
+	},
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM8150_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8150_SLAVE_SNOC_GEM_NOC_GC,
+		   SM8150_SLAVE_OCIMEM
+	},
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM8150_A1NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8150_A1NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SM8150_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM8150_A2NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8150_A2NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SM8150_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8150_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SM8150_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = SM8150_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qns_cdsp_mem_noc = {
+	.name = "qns_cdsp_mem_noc",
+	.id = SM8150_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SM8150_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SM8150_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_ahb2phy_south = {
+	.name = "qhs_ahb2phy_south",
+	.id = SM8150_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SM8150_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM8150_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM8150_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM8150_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute_dsp = {
+	.name = "qhs_compute_dsp",
+	.id = SM8150_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM8150_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mmcx = {
+	.name = "qhs_cpr_mmcx",
+	.id = SM8150_SLAVE_RBCPR_MMCX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SM8150_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM8150_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SM8150_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM8150_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emac_cfg = {
+	.name = "qhs_emac_cfg",
+	.id = SM8150_SLAVE_EMAC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = SM8150_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM8150_SLAVE_GRAPHICS_3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM8150_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM8150_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SM8150_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_npu_cfg = {
+	.name = "qhs_npu_cfg",
+	.id = SM8150_SLAVE_NPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SM8150_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SM8150_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_phy_refgen_north = {
+	.name = "qhs_phy_refgen_north",
+	.id = SM8150_SLAVE_NORTH_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM8150_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM8150_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM8150_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SM8150_SLAVE_QSPI,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_east = {
+	.name = "qhs_qupv3_east",
+	.id = SM8150_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_north = {
+	.name = "qhs_qupv3_north",
+	.id = SM8150_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_south = {
+	.name = "qhs_qupv3_south",
+	.id = SM8150_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM8150_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SM8150_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SM8150_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spdm = {
+	.name = "qhs_spdm",
+	.id = SM8150_SLAVE_SPDM_WRAPPER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spss_cfg = {
+	.name = "qhs_spss_cfg",
+	.id = SM8150_SLAVE_SPSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ssc_cfg = {
+	.name = "qhs_ssc_cfg",
+	.id = SM8150_SLAVE_SSC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM8150_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_east = {
+	.name = "qhs_tlmm_east",
+	.id = SM8150_SLAVE_TLMM_EAST,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_north = {
+	.name = "qhs_tlmm_north",
+	.id = SM8150_SLAVE_TLMM_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_south = {
+	.name = "qhs_tlmm_south",
+	.id = SM8150_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_west = {
+	.name = "qhs_tlmm_west",
+	.id = SM8150_SLAVE_TLMM_WEST,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tsif = {
+	.name = "qhs_tsif",
+	.id = SM8150_SLAVE_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_card_cfg = {
+	.name = "qhs_ufs_card_cfg",
+	.id = SM8150_SLAVE_UFS_CARD_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM8150_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM8150_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_1 = {
+	.name = "qhs_usb3_1",
+	.id = SM8150_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM8150_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM8150_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SM8150_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SM8150_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SM8150_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_memnoc = {
+	.name = "qhs_memnoc",
+	.id = SM8150_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8150_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SM8150_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_ecc = {
+	.name = "qns_ecc",
+	.id = SM8150_SLAVE_ECC,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc = {
+	.name = "qns_gem_noc_snoc",
+	.id = SM8150_SLAVE_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_MASTER_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM8150_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8150_MASTER_LLCC },
+};
+
+static struct qcom_icc_node srvc_gemnoc = {
+	.name = "srvc_gemnoc",
+	.id = SM8150_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM8150_SLAVE_EBI_CH0,
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns2_mem_noc = {
+	.name = "qns2_mem_noc",
+	.id = SM8150_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM8150_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8150_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM8150_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM8150_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SM8150_SNOC_CNOC_SLV,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_SNOC_CNOC_MAS },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM8150_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8150_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM8150_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8150_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM8150_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM8150_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SM8150_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SM8150_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SM8150_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM8150_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM8150_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);

-- 
2.41.0

