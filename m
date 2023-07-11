Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91374EE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjGKMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGKMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33910CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so87258861fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077917; x=1691669917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssQ8S4pZ8LFjocyWnXanlvgyd7aL7eYHluRwRe/cDDQ=;
        b=KE1Emdsm53LgMg0pN+64o8PgXtDC/cJY8qSk7V9yEeuwB1FKRA0UJWPuHiunm3jAYx
         zsPrCQQO6fEVqr3eQ4RPPzhzZzFioq4qR2YcCt3XiXi5eRoOQWC9muDFpy4OpzbUFsIJ
         eJLBtzJDLseHwFqxysgy9r73kHb7jwzvVKthPPRvlC6cMxIgNb4fyBHEePKoWXYhTXxc
         PLwpXHOoY0c6A0MHRqnaDBgyQiD1RZIKaJqgGdUiKy85SyrS8reNyBr+FdI+jtMmPwfO
         Z3JYpZh0Lyt2NS6BeQhjE73jp66XU2Z/bnUtUC3u4PMrNuozRdLWaHgSKVia9T+Aa9O4
         /6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077917; x=1691669917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssQ8S4pZ8LFjocyWnXanlvgyd7aL7eYHluRwRe/cDDQ=;
        b=i38kgOu//u3YnS0ghe41LpwfpzpK2nONVwN9rh23czFmHzY3Xk7419mbD7H/r50CL2
         P8inYFh8R8JRQ5O3l4CGEDGCaTpjcBUwN6N9y/mma43uAs7IKfgq6wZk9uSy/9BCN7/B
         7d6JsDujNM3nHjDyLSdId/kEJWp4Grv5rqWpqEuZhtbeBsqak006dPJQcqjzU+NwdqxW
         5ylnnpo4S7TLbnvUl7sF8VaNC7JOnMSshaB7VW4Wb13/0ats3CTZh0Jo6pyOsyxUiT/8
         1pbgDjPvwI+otGIXseootOW+lyzrvq1zmyOArW+GAxbEsFuMvKPwvoFOtK+EhRKJj6K/
         rzGw==
X-Gm-Message-State: ABy/qLYfGkDnvM1F+XuaOUDGmd7CafDXu0DsLVERYSRHa06awKy0G4rJ
        A16cEsDGTysJ9e3zAC49QVty3G7G7XNfEpzyPbIGHQ==
X-Google-Smtp-Source: APBJJlGArdugp6DVl8b/q3qh2+bTuPYLV4pXLZC91Umedi2ZrtM6ooZv5aU6TfBBB7ISpO2dMrDz4A==
X-Received: by 2002:a2e:2e17:0:b0:2b6:df00:b3d1 with SMTP id u23-20020a2e2e17000000b002b6df00b3d1mr12295257lju.51.1689077916793;
        Tue, 11 Jul 2023 05:18:36 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:07 +0200
Subject: [PATCH 08/53] interconnect: qcom: sdm845: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-8-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=43630;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KNfiEgG3TyzMX9xEccJ89zpUneCkvrGmifaqFWTB5ZU=;
 b=O8I/wugUASx/V7NKMfFLfXKCCu/uhyHiC1vZLkjvDjANzR0ZDXqW8lhpkEsHjpLEgPD4ZU8xJ
 L4ozSoWtzQJAYhIkizhYFUcmQbbB7n+wNFzAPH1j891XgRU0KERvgVm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/interconnect/qcom/sdm845.c | 1376 ++++++++++++++++++++++++++++++++----
 1 file changed, 1246 insertions(+), 130 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 954e7bd13fc4..5caf6e5aeeca 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -15,136 +15,1252 @@
 #include "icc-rpmh.h"
 #include "sdm845.h"
 
-DEFINE_QNODE(qhm_a1noc_cfg, SDM845_MASTER_A1NOC_CFG, 1, 4, SDM845_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(qhm_qup1, SDM845_MASTER_BLSP_1, 1, 4, SDM845_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_tsif, SDM845_MASTER_TSIF, 1, 4, SDM845_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc2, SDM845_MASTER_SDCC_2, 1, 8, SDM845_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc4, SDM845_MASTER_SDCC_4, 1, 8, SDM845_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_card, SDM845_MASTER_UFS_CARD, 1, 8, SDM845_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_mem, SDM845_MASTER_UFS_MEM, 1, 8, SDM845_SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_pcie_0, SDM845_MASTER_PCIE_0, 1, 8, SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_a2noc_cfg, SDM845_MASTER_A2NOC_CFG, 1, 4, SDM845_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qhm_qdss_bam, SDM845_MASTER_QDSS_BAM, 1, 4, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qhm_qup2, SDM845_MASTER_BLSP_2, 1, 4, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qnm_cnoc, SDM845_MASTER_CNOC_A2NOC, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_crypto, SDM845_MASTER_CRYPTO, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_ipa, SDM845_MASTER_IPA, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_pcie3_1, SDM845_MASTER_PCIE_1, 1, 8, SDM845_SLAVE_ANOC_PCIE_SNOC);
-DEFINE_QNODE(xm_qdss_etr, SDM845_MASTER_QDSS_ETR, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_usb3_0, SDM845_MASTER_USB3_0, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_usb3_1, SDM845_MASTER_USB3_1, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SDM845_MASTER_CAMNOC_HF0_UNCOMP, 1, 32, SDM845_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_hf1_uncomp, SDM845_MASTER_CAMNOC_HF1_UNCOMP, 1, 32, SDM845_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_sf_uncomp, SDM845_MASTER_CAMNOC_SF_UNCOMP, 1, 32, SDM845_SLAVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qhm_spdm, SDM845_MASTER_SPDM, 1, 4, SDM845_SLAVE_CNOC_A2NOC);
-DEFINE_QNODE(qhm_tic, SDM845_MASTER_TIC, 1, 4, SDM845_SLAVE_A1NOC_CFG, SDM845_SLAVE_A2NOC_CFG, SDM845_SLAVE_AOP, SDM845_SLAVE_AOSS, SDM845_SLAVE_CAMERA_CFG, SDM845_SLAVE_CLK_CTL, SDM845_SLAVE_CDSP_CFG, SDM845_SLAVE_RBCPR_CX_CFG, SDM845_SLAVE_CRYPTO_0_CFG, SDM845_SLAVE_DCC_CFG, SDM845_SLAVE_CNOC_DDRSS, SDM845_SLAVE_DISPLAY_CFG, SDM845_SLAVE_GLM, SDM845_SLAVE_GFX3D_CFG, SDM845_SLAVE_IMEM_CFG, SDM845_SLAVE_IPA_CFG, SDM845_SLAVE_CNOC_MNOC_CFG, SDM845_SLAVE_PCIE_0_CFG, SDM845_SLAVE_PCIE_1_CFG, SDM845_SLAVE_PDM, SDM845_SLAVE_SOUTH_PHY_CFG, SDM845_SLAVE_PIMEM_CFG, SDM845_SLAVE_PRNG, SDM845_SLAVE_QDSS_CFG, SDM845_SLAVE_BLSP_2, SDM845_SLAVE_BLSP_1, SDM845_SLAVE_SDCC_2, SDM845_SLAVE_SDCC_4, SDM845_SLAVE_SNOC_CFG, SDM845_SLAVE_SPDM_WRAPPER, SDM845_SLAVE_SPSS_CFG, SDM845_SLAVE_TCSR, SDM845_SLAVE_TLMM_NORTH, SDM845_SLAVE_TLMM_SOUTH, SDM845_SLAVE_TSIF, SDM845_SLAVE_UFS_CARD_CFG, SDM845_SLAVE_UFS_MEM_CFG, SDM845_SLAVE_USB3_0, SDM845_SLAVE_USB3_1, SDM845_SLAVE_VENUS_CFG, SDM845_SLAVE_VSENSE_CTRL_CF
 G, SDM845_SLAVE_CNOC_A2NOC, SDM845_SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(qnm_snoc, SDM845_MASTER_SNOC_CNOC, 1, 8, SDM845_SLAVE_A1NOC_CFG, SDM845_SLAVE_A2NOC_CFG, SDM845_SLAVE_AOP, SDM845_SLAVE_AOSS, SDM845_SLAVE_CAMERA_CFG, SDM845_SLAVE_CLK_CTL, SDM845_SLAVE_CDSP_CFG, SDM845_SLAVE_RBCPR_CX_CFG, SDM845_SLAVE_CRYPTO_0_CFG, SDM845_SLAVE_DCC_CFG, SDM845_SLAVE_CNOC_DDRSS, SDM845_SLAVE_DISPLAY_CFG, SDM845_SLAVE_GLM, SDM845_SLAVE_GFX3D_CFG, SDM845_SLAVE_IMEM_CFG, SDM845_SLAVE_IPA_CFG, SDM845_SLAVE_CNOC_MNOC_CFG, SDM845_SLAVE_PCIE_0_CFG, SDM845_SLAVE_PCIE_1_CFG, SDM845_SLAVE_PDM, SDM845_SLAVE_SOUTH_PHY_CFG, SDM845_SLAVE_PIMEM_CFG, SDM845_SLAVE_PRNG, SDM845_SLAVE_QDSS_CFG, SDM845_SLAVE_BLSP_2, SDM845_SLAVE_BLSP_1, SDM845_SLAVE_SDCC_2, SDM845_SLAVE_SDCC_4, SDM845_SLAVE_SNOC_CFG, SDM845_SLAVE_SPDM_WRAPPER, SDM845_SLAVE_SPSS_CFG, SDM845_SLAVE_TCSR, SDM845_SLAVE_TLMM_NORTH, SDM845_SLAVE_TLMM_SOUTH, SDM845_SLAVE_TSIF, SDM845_SLAVE_UFS_CARD_CFG, SDM845_SLAVE_UFS_MEM_CFG, SDM845_SLAVE_USB3_0, SDM845_SLAVE_USB3_1, SDM845_SLAVE_VENUS_CFG, SDM845_SLAVE_VSENSE_
 CTRL_CFG, SDM845_SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(xm_qdss_dap, SDM845_MASTER_QDSS_DAP, 1, 8, SDM845_SLAVE_A1NOC_CFG, SDM845_SLAVE_A2NOC_CFG, SDM845_SLAVE_AOP, SDM845_SLAVE_AOSS, SDM845_SLAVE_CAMERA_CFG, SDM845_SLAVE_CLK_CTL, SDM845_SLAVE_CDSP_CFG, SDM845_SLAVE_RBCPR_CX_CFG, SDM845_SLAVE_CRYPTO_0_CFG, SDM845_SLAVE_DCC_CFG, SDM845_SLAVE_CNOC_DDRSS, SDM845_SLAVE_DISPLAY_CFG, SDM845_SLAVE_GLM, SDM845_SLAVE_GFX3D_CFG, SDM845_SLAVE_IMEM_CFG, SDM845_SLAVE_IPA_CFG, SDM845_SLAVE_CNOC_MNOC_CFG, SDM845_SLAVE_PCIE_0_CFG, SDM845_SLAVE_PCIE_1_CFG, SDM845_SLAVE_PDM, SDM845_SLAVE_SOUTH_PHY_CFG, SDM845_SLAVE_PIMEM_CFG, SDM845_SLAVE_PRNG, SDM845_SLAVE_QDSS_CFG, SDM845_SLAVE_BLSP_2, SDM845_SLAVE_BLSP_1, SDM845_SLAVE_SDCC_2, SDM845_SLAVE_SDCC_4, SDM845_SLAVE_SNOC_CFG, SDM845_SLAVE_SPDM_WRAPPER, SDM845_SLAVE_SPSS_CFG, SDM845_SLAVE_TCSR, SDM845_SLAVE_TLMM_NORTH, SDM845_SLAVE_TLMM_SOUTH, SDM845_SLAVE_TSIF, SDM845_SLAVE_UFS_CARD_CFG, SDM845_SLAVE_UFS_MEM_CFG, SDM845_SLAVE_USB3_0, SDM845_SLAVE_USB3_1, SDM845_SLAVE_VENUS_CFG, SDM845_SLAVE_VSENS
 E_CTRL_CFG, SDM845_SLAVE_CNOC_A2NOC, SDM845_SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(qhm_cnoc, SDM845_MASTER_CNOC_DC_NOC, 1, 4, SDM845_SLAVE_LLCC_CFG, SDM845_SLAVE_MEM_NOC_CFG);
-DEFINE_QNODE(acm_l3, SDM845_MASTER_APPSS_PROC, 1, 16, SDM845_SLAVE_GNOC_SNOC, SDM845_SLAVE_GNOC_MEM_NOC, SDM845_SLAVE_SERVICE_GNOC);
-DEFINE_QNODE(pm_gnoc_cfg, SDM845_MASTER_GNOC_CFG, 1, 4, SDM845_SLAVE_SERVICE_GNOC);
-DEFINE_QNODE(llcc_mc, SDM845_MASTER_LLCC, 4, 4, SDM845_SLAVE_EBI1);
-DEFINE_QNODE(acm_tcu, SDM845_MASTER_TCU_0, 1, 8, SDM845_SLAVE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC, SDM845_SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qhm_memnoc_cfg, SDM845_MASTER_MEM_NOC_CFG, 1, 4, SDM845_SLAVE_MSS_PROC_MS_MPU_CFG, SDM845_SLAVE_SERVICE_MEM_NOC);
-DEFINE_QNODE(qnm_apps, SDM845_MASTER_GNOC_MEM_NOC, 2, 32, SDM845_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_hf, SDM845_MASTER_MNOC_HF_MEM_NOC, 2, 32, SDM845_SLAVE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, SDM845_MASTER_MNOC_SF_MEM_NOC, 1, 32, SDM845_SLAVE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC, SDM845_SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SDM845_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDM845_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SDM845_MASTER_SNOC_SF_MEM_NOC, 1, 16, SDM845_SLAVE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC);
-DEFINE_QNODE(qxm_gpu, SDM845_MASTER_GFX3D, 2, 32, SDM845_SLAVE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC, SDM845_SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qhm_mnoc_cfg, SDM845_MASTER_CNOC_MNOC_CFG, 1, 4, SDM845_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qxm_camnoc_hf0, SDM845_MASTER_CAMNOC_HF0, 1, 32, SDM845_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_hf1, SDM845_MASTER_CAMNOC_HF1, 1, 32, SDM845_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_camnoc_sf, SDM845_MASTER_CAMNOC_SF, 1, 32, SDM845_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SDM845_MASTER_MDP0, 1, 32, SDM845_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp1, SDM845_MASTER_MDP1, 1, 32, SDM845_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, SDM845_MASTER_ROTATOR, 1, 32, SDM845_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus0, SDM845_MASTER_VIDEO_P0, 1, 32, SDM845_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus1, SDM845_MASTER_VIDEO_P1, 1, 32, SDM845_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus_arm9, SDM845_MASTER_VIDEO_PROC, 1, 8, SDM845_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qhm_snoc_cfg, SDM845_MASTER_SNOC_CFG, 1, 4, SDM845_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, SDM845_MASTER_A1NOC_SNOC, 1, 16, SDM845_SLAVE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_SNOC_MEM_NOC_SF, SDM845_SLAVE_IMEM, SDM845_SLAVE_PIMEM, SDM845_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_aggre2_noc, SDM845_MASTER_A2NOC_SNOC, 1, 16, SDM845_SLAVE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_SNOC_MEM_NOC_SF, SDM845_SLAVE_IMEM, SDM845_SLAVE_PCIE_0, SDM845_SLAVE_PCIE_1, SDM845_SLAVE_PIMEM, SDM845_SLAVE_QDSS_STM, SDM845_SLAVE_TCU);
-DEFINE_QNODE(qnm_gladiator_sodv, SDM845_MASTER_GNOC_SNOC, 1, 8, SDM845_SLAVE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_IMEM, SDM845_SLAVE_PCIE_0, SDM845_SLAVE_PCIE_1, SDM845_SLAVE_PIMEM, SDM845_SLAVE_QDSS_STM, SDM845_SLAVE_TCU);
-DEFINE_QNODE(qnm_memnoc, SDM845_MASTER_MEM_NOC_SNOC, 1, 8, SDM845_SLAVE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_IMEM, SDM845_SLAVE_PIMEM, SDM845_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_pcie_anoc, SDM845_MASTER_ANOC_PCIE_SNOC, 1, 16, SDM845_SLAVE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_SNOC_MEM_NOC_SF, SDM845_SLAVE_IMEM, SDM845_SLAVE_QDSS_STM);
-DEFINE_QNODE(qxm_pimem, SDM845_MASTER_PIMEM, 1, 8, SDM845_SLAVE_SNOC_MEM_NOC_GC, SDM845_SLAVE_IMEM);
-DEFINE_QNODE(xm_gic, SDM845_MASTER_GIC, 1, 8, SDM845_SLAVE_SNOC_MEM_NOC_GC, SDM845_SLAVE_IMEM);
-DEFINE_QNODE(qns_a1noc_snoc, SDM845_SLAVE_A1NOC_SNOC, 1, 16, SDM845_MASTER_A1NOC_SNOC);
-DEFINE_QNODE(srvc_aggre1_noc, SDM845_SLAVE_SERVICE_A1NOC, 1, 4, 0);
-DEFINE_QNODE(qns_pcie_a1noc_snoc, SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC, 1, 16, SDM845_MASTER_ANOC_PCIE_SNOC);
-DEFINE_QNODE(qns_a2noc_snoc, SDM845_SLAVE_A2NOC_SNOC, 1, 16, SDM845_MASTER_A2NOC_SNOC);
-DEFINE_QNODE(qns_pcie_snoc, SDM845_SLAVE_ANOC_PCIE_SNOC, 1, 16, SDM845_MASTER_ANOC_PCIE_SNOC);
-DEFINE_QNODE(srvc_aggre2_noc, SDM845_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qns_camnoc_uncomp, SDM845_SLAVE_CAMNOC_UNCOMP, 1, 32);
-DEFINE_QNODE(qhs_a1_noc_cfg, SDM845_SLAVE_A1NOC_CFG, 1, 4, SDM845_MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SDM845_SLAVE_A2NOC_CFG, 1, 4, SDM845_MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_aop, SDM845_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(qhs_aoss, SDM845_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_camera_cfg, SDM845_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SDM845_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_compute_dsp_cfg, SDM845_SLAVE_CDSP_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SDM845_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SDM845_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_dcc_cfg, SDM845_SLAVE_DCC_CFG, 1, 4, SDM845_MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_ddrss_cfg, SDM845_SLAVE_CNOC_DDRSS, 1, 4);
-DEFINE_QNODE(qhs_display_cfg, SDM845_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_glm, SDM845_SLAVE_GLM, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SDM845_SLAVE_GFX3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_imem_cfg, SDM845_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SDM845_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mnoc_cfg, SDM845_SLAVE_CNOC_MNOC_CFG, 1, 4, SDM845_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(qhs_pcie0_cfg, SDM845_SLAVE_PCIE_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_pcie_gen3_cfg, SDM845_SLAVE_PCIE_1_CFG, 1, 4);
-DEFINE_QNODE(qhs_pdm, SDM845_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_phy_refgen_south, SDM845_SLAVE_SOUTH_PHY_CFG, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SDM845_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_prng, SDM845_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SDM845_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qupv3_north, SDM845_SLAVE_BLSP_2, 1, 4);
-DEFINE_QNODE(qhs_qupv3_south, SDM845_SLAVE_BLSP_1, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SDM845_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_sdc4, SDM845_SLAVE_SDCC_4, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SDM845_SLAVE_SNOC_CFG, 1, 4, SDM845_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spdm, SDM845_SLAVE_SPDM_WRAPPER, 1, 4);
-DEFINE_QNODE(qhs_spss_cfg, SDM845_SLAVE_SPSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SDM845_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm_north, SDM845_SLAVE_TLMM_NORTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm_south, SDM845_SLAVE_TLMM_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_tsif, SDM845_SLAVE_TSIF, 1, 4);
-DEFINE_QNODE(qhs_ufs_card_cfg, SDM845_SLAVE_UFS_CARD_CFG, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SDM845_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3_0, SDM845_SLAVE_USB3_0, 1, 4);
-DEFINE_QNODE(qhs_usb3_1, SDM845_SLAVE_USB3_1, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SDM845_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SDM845_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(qns_cnoc_a2noc, SDM845_SLAVE_CNOC_A2NOC, 1, 8, SDM845_MASTER_CNOC_A2NOC);
-DEFINE_QNODE(srvc_cnoc, SDM845_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(qhs_llcc, SDM845_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_memnoc, SDM845_SLAVE_MEM_NOC_CFG, 1, 4, SDM845_MASTER_MEM_NOC_CFG);
-DEFINE_QNODE(qns_gladiator_sodv, SDM845_SLAVE_GNOC_SNOC, 1, 8, SDM845_MASTER_GNOC_SNOC);
-DEFINE_QNODE(qns_gnoc_memnoc, SDM845_SLAVE_GNOC_MEM_NOC, 2, 32, SDM845_MASTER_GNOC_MEM_NOC);
-DEFINE_QNODE(srvc_gnoc, SDM845_SLAVE_SERVICE_GNOC, 1, 4);
-DEFINE_QNODE(ebi, SDM845_SLAVE_EBI1, 4, 4);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SDM845_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_apps_io, SDM845_SLAVE_MEM_NOC_GNOC, 1, 32);
-DEFINE_QNODE(qns_llcc, SDM845_SLAVE_LLCC, 4, 16, SDM845_MASTER_LLCC);
-DEFINE_QNODE(qns_memnoc_snoc, SDM845_SLAVE_MEM_NOC_SNOC, 1, 8, SDM845_MASTER_MEM_NOC_SNOC);
-DEFINE_QNODE(srvc_memnoc, SDM845_SLAVE_SERVICE_MEM_NOC, 1, 4);
-DEFINE_QNODE(qns2_mem_noc, SDM845_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SDM845_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_hf, SDM845_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SDM845_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SDM845_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qhs_apss, SDM845_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qns_cnoc, SDM845_SLAVE_SNOC_CNOC, 1, 8, SDM845_MASTER_SNOC_CNOC);
-DEFINE_QNODE(qns_memnoc_gc, SDM845_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDM845_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_memnoc_sf, SDM845_SLAVE_SNOC_MEM_NOC_SF, 1, 16, SDM845_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SDM845_SLAVE_IMEM, 1, 8);
-DEFINE_QNODE(qxs_pcie, SDM845_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(qxs_pcie_gen3, SDM845_SLAVE_PCIE_1, 1, 8);
-DEFINE_QNODE(qxs_pimem, SDM845_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SDM845_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_qdss_stm, SDM845_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SDM845_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = SDM845_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SDM845_MASTER_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_tsif = {
+	.name = "qhm_tsif",
+	.id = SDM845_MASTER_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SDM845_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SDM845_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_card = {
+	.name = "xm_ufs_card",
+	.id = SDM845_MASTER_UFS_CARD,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SDM845_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_pcie_0 = {
+	.name = "xm_pcie_0",
+	.id = SDM845_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SDM845_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SDM845_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SDM845_MASTER_BLSP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = SDM845_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SDM845_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SDM845_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SDM845_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_ANOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SDM845_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SDM845_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = SDM845_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = SDM845_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
+	.name = "qxm_camnoc_hf1_uncomp",
+	.id = SDM845_MASTER_CAMNOC_HF1_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = SDM845_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qhm_spdm = {
+	.name = "qhm_spdm",
+	.id = SDM845_MASTER_SPDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qhm_tic = {
+	.name = "qhm_tic",
+	.id = SDM845_MASTER_TIC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 43,
+	.links = { SDM845_SLAVE_A1NOC_CFG,
+		   SDM845_SLAVE_A2NOC_CFG,
+		   SDM845_SLAVE_AOP,
+		   SDM845_SLAVE_AOSS,
+		   SDM845_SLAVE_CAMERA_CFG,
+		   SDM845_SLAVE_CLK_CTL,
+		   SDM845_SLAVE_CDSP_CFG,
+		   SDM845_SLAVE_RBCPR_CX_CFG,
+		   SDM845_SLAVE_CRYPTO_0_CFG,
+		   SDM845_SLAVE_DCC_CFG,
+		   SDM845_SLAVE_CNOC_DDRSS,
+		   SDM845_SLAVE_DISPLAY_CFG,
+		   SDM845_SLAVE_GLM,
+		   SDM845_SLAVE_GFX3D_CFG,
+		   SDM845_SLAVE_IMEM_CFG,
+		   SDM845_SLAVE_IPA_CFG,
+		   SDM845_SLAVE_CNOC_MNOC_CFG,
+		   SDM845_SLAVE_PCIE_0_CFG,
+		   SDM845_SLAVE_PCIE_1_CFG,
+		   SDM845_SLAVE_PDM,
+		   SDM845_SLAVE_SOUTH_PHY_CFG,
+		   SDM845_SLAVE_PIMEM_CFG,
+		   SDM845_SLAVE_PRNG,
+		   SDM845_SLAVE_QDSS_CFG,
+		   SDM845_SLAVE_BLSP_2,
+		   SDM845_SLAVE_BLSP_1,
+		   SDM845_SLAVE_SDCC_2,
+		   SDM845_SLAVE_SDCC_4,
+		   SDM845_SLAVE_SNOC_CFG,
+		   SDM845_SLAVE_SPDM_WRAPPER,
+		   SDM845_SLAVE_SPSS_CFG,
+		   SDM845_SLAVE_TCSR,
+		   SDM845_SLAVE_TLMM_NORTH,
+		   SDM845_SLAVE_TLMM_SOUTH,
+		   SDM845_SLAVE_TSIF,
+		   SDM845_SLAVE_UFS_CARD_CFG,
+		   SDM845_SLAVE_UFS_MEM_CFG,
+		   SDM845_SLAVE_USB3_0,
+		   SDM845_SLAVE_USB3_1,
+		   SDM845_SLAVE_VENUS_CFG,
+		   SDM845_SLAVE_VSENSE_CTRL_CFG,
+		   SDM845_SLAVE_CNOC_A2NOC,
+		   SDM845_SLAVE_SERVICE_CNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SDM845_MASTER_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 42,
+	.links = { SDM845_SLAVE_A1NOC_CFG,
+		   SDM845_SLAVE_A2NOC_CFG,
+		   SDM845_SLAVE_AOP,
+		   SDM845_SLAVE_AOSS,
+		   SDM845_SLAVE_CAMERA_CFG,
+		   SDM845_SLAVE_CLK_CTL,
+		   SDM845_SLAVE_CDSP_CFG,
+		   SDM845_SLAVE_RBCPR_CX_CFG,
+		   SDM845_SLAVE_CRYPTO_0_CFG,
+		   SDM845_SLAVE_DCC_CFG,
+		   SDM845_SLAVE_CNOC_DDRSS,
+		   SDM845_SLAVE_DISPLAY_CFG,
+		   SDM845_SLAVE_GLM,
+		   SDM845_SLAVE_GFX3D_CFG,
+		   SDM845_SLAVE_IMEM_CFG,
+		   SDM845_SLAVE_IPA_CFG,
+		   SDM845_SLAVE_CNOC_MNOC_CFG,
+		   SDM845_SLAVE_PCIE_0_CFG,
+		   SDM845_SLAVE_PCIE_1_CFG,
+		   SDM845_SLAVE_PDM,
+		   SDM845_SLAVE_SOUTH_PHY_CFG,
+		   SDM845_SLAVE_PIMEM_CFG,
+		   SDM845_SLAVE_PRNG,
+		   SDM845_SLAVE_QDSS_CFG,
+		   SDM845_SLAVE_BLSP_2,
+		   SDM845_SLAVE_BLSP_1,
+		   SDM845_SLAVE_SDCC_2,
+		   SDM845_SLAVE_SDCC_4,
+		   SDM845_SLAVE_SNOC_CFG,
+		   SDM845_SLAVE_SPDM_WRAPPER,
+		   SDM845_SLAVE_SPSS_CFG,
+		   SDM845_SLAVE_TCSR,
+		   SDM845_SLAVE_TLMM_NORTH,
+		   SDM845_SLAVE_TLMM_SOUTH,
+		   SDM845_SLAVE_TSIF,
+		   SDM845_SLAVE_UFS_CARD_CFG,
+		   SDM845_SLAVE_UFS_MEM_CFG,
+		   SDM845_SLAVE_USB3_0,
+		   SDM845_SLAVE_USB3_1,
+		   SDM845_SLAVE_VENUS_CFG,
+		   SDM845_SLAVE_VSENSE_CTRL_CFG,
+		   SDM845_SLAVE_SERVICE_CNOC
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SDM845_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 43,
+	.links = { SDM845_SLAVE_A1NOC_CFG,
+		   SDM845_SLAVE_A2NOC_CFG,
+		   SDM845_SLAVE_AOP,
+		   SDM845_SLAVE_AOSS,
+		   SDM845_SLAVE_CAMERA_CFG,
+		   SDM845_SLAVE_CLK_CTL,
+		   SDM845_SLAVE_CDSP_CFG,
+		   SDM845_SLAVE_RBCPR_CX_CFG,
+		   SDM845_SLAVE_CRYPTO_0_CFG,
+		   SDM845_SLAVE_DCC_CFG,
+		   SDM845_SLAVE_CNOC_DDRSS,
+		   SDM845_SLAVE_DISPLAY_CFG,
+		   SDM845_SLAVE_GLM,
+		   SDM845_SLAVE_GFX3D_CFG,
+		   SDM845_SLAVE_IMEM_CFG,
+		   SDM845_SLAVE_IPA_CFG,
+		   SDM845_SLAVE_CNOC_MNOC_CFG,
+		   SDM845_SLAVE_PCIE_0_CFG,
+		   SDM845_SLAVE_PCIE_1_CFG,
+		   SDM845_SLAVE_PDM,
+		   SDM845_SLAVE_SOUTH_PHY_CFG,
+		   SDM845_SLAVE_PIMEM_CFG,
+		   SDM845_SLAVE_PRNG,
+		   SDM845_SLAVE_QDSS_CFG,
+		   SDM845_SLAVE_BLSP_2,
+		   SDM845_SLAVE_BLSP_1,
+		   SDM845_SLAVE_SDCC_2,
+		   SDM845_SLAVE_SDCC_4,
+		   SDM845_SLAVE_SNOC_CFG,
+		   SDM845_SLAVE_SPDM_WRAPPER,
+		   SDM845_SLAVE_SPSS_CFG,
+		   SDM845_SLAVE_TCSR,
+		   SDM845_SLAVE_TLMM_NORTH,
+		   SDM845_SLAVE_TLMM_SOUTH,
+		   SDM845_SLAVE_TSIF,
+		   SDM845_SLAVE_UFS_CARD_CFG,
+		   SDM845_SLAVE_UFS_MEM_CFG,
+		   SDM845_SLAVE_USB3_0,
+		   SDM845_SLAVE_USB3_1,
+		   SDM845_SLAVE_VENUS_CFG,
+		   SDM845_SLAVE_VSENSE_CTRL_CFG,
+		   SDM845_SLAVE_CNOC_A2NOC,
+		   SDM845_SLAVE_SERVICE_CNOC
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc = {
+	.name = "qhm_cnoc",
+	.id = SDM845_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SDM845_SLAVE_LLCC_CFG,
+		   SDM845_SLAVE_MEM_NOC_CFG
+	},
+};
+
+static struct qcom_icc_node acm_l3 = {
+	.name = "acm_l3",
+	.id = SDM845_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDM845_SLAVE_GNOC_SNOC,
+		   SDM845_SLAVE_GNOC_MEM_NOC,
+		   SDM845_SLAVE_SERVICE_GNOC
+	},
+};
+
+static struct qcom_icc_node pm_gnoc_cfg = {
+	.name = "pm_gnoc_cfg",
+	.id = SDM845_MASTER_GNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_SERVICE_GNOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SDM845_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node acm_tcu = {
+	.name = "acm_tcu",
+	.id = SDM845_MASTER_TCU_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
+		   SDM845_SLAVE_LLCC,
+		   SDM845_SLAVE_MEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_memnoc_cfg = {
+	.name = "qhm_memnoc_cfg",
+	.id = SDM845_MASTER_MEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SDM845_SLAVE_MSS_PROC_MS_MPU_CFG,
+		   SDM845_SLAVE_SERVICE_MEM_NOC
+	},
+};
+
+static struct qcom_icc_node qnm_apps = {
+	.name = "qnm_apps",
+	.id = SDM845_MASTER_GNOC_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SDM845_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
+		   SDM845_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SDM845_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
+		   SDM845_SLAVE_LLCC,
+		   SDM845_SLAVE_MEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SDM845_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SDM845_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
+		   SDM845_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qxm_gpu = {
+	.name = "qxm_gpu",
+	.id = SDM845_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
+		   SDM845_SLAVE_LLCC,
+		   SDM845_SLAVE_MEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SDM845_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0 = {
+	.name = "qxm_camnoc_hf0",
+	.id = SDM845_MASTER_CAMNOC_HF0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1 = {
+	.name = "qxm_camnoc_hf1",
+	.id = SDM845_MASTER_CAMNOC_HF1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SDM845_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SDM845_MASTER_MDP0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp1 = {
+	.name = "qxm_mdp1",
+	.id = SDM845_MASTER_MDP1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SDM845_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus0 = {
+	.name = "qxm_venus0",
+	.id = SDM845_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus1 = {
+	.name = "qxm_venus1",
+	.id = SDM845_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 = {
+	.name = "qxm_venus_arm9",
+	.id = SDM845_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SDM845_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SDM845_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SDM845_SLAVE_APPSS,
+		   SDM845_SLAVE_SNOC_CNOC,
+		   SDM845_SLAVE_SNOC_MEM_NOC_SF,
+		   SDM845_SLAVE_IMEM,
+		   SDM845_SLAVE_PIMEM,
+		   SDM845_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SDM845_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 9,
+	.links = { SDM845_SLAVE_APPSS,
+		   SDM845_SLAVE_SNOC_CNOC,
+		   SDM845_SLAVE_SNOC_MEM_NOC_SF,
+		   SDM845_SLAVE_IMEM,
+		   SDM845_SLAVE_PCIE_0,
+		   SDM845_SLAVE_PCIE_1,
+		   SDM845_SLAVE_PIMEM,
+		   SDM845_SLAVE_QDSS_STM,
+		   SDM845_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_gladiator_sodv = {
+	.name = "qnm_gladiator_sodv",
+	.id = SDM845_MASTER_GNOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 8,
+	.links = { SDM845_SLAVE_APPSS,
+		   SDM845_SLAVE_SNOC_CNOC,
+		   SDM845_SLAVE_IMEM,
+		   SDM845_SLAVE_PCIE_0,
+		   SDM845_SLAVE_PCIE_1,
+		   SDM845_SLAVE_PIMEM,
+		   SDM845_SLAVE_QDSS_STM,
+		   SDM845_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc = {
+	.name = "qnm_memnoc",
+	.id = SDM845_MASTER_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 5,
+	.links = { SDM845_SLAVE_APPSS,
+		   SDM845_SLAVE_SNOC_CNOC,
+		   SDM845_SLAVE_IMEM,
+		   SDM845_SLAVE_PIMEM,
+		   SDM845_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_pcie_anoc = {
+	.name = "qnm_pcie_anoc",
+	.id = SDM845_MASTER_ANOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 5,
+	.links = { SDM845_SLAVE_APPSS,
+		   SDM845_SLAVE_SNOC_CNOC,
+		   SDM845_SLAVE_SNOC_MEM_NOC_SF,
+		   SDM845_SLAVE_IMEM,
+		   SDM845_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SDM845_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SDM845_SLAVE_SNOC_MEM_NOC_GC,
+		   SDM845_SLAVE_IMEM
+	},
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SDM845_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SDM845_SLAVE_SNOC_MEM_NOC_GC,
+		   SDM845_SLAVE_IMEM
+	},
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SDM845_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM845_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SDM845_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { 0 },
+};
+
+static struct qcom_icc_node qns_pcie_a1noc_snoc = {
+	.name = "qns_pcie_a1noc_snoc",
+	.id = SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM845_MASTER_ANOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SDM845_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM845_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_pcie_snoc = {
+	.name = "qns_pcie_snoc",
+	.id = SDM845_SLAVE_ANOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM845_MASTER_ANOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SDM845_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = SDM845_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SDM845_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SDM845_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SDM845_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SDM845_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SDM845_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SDM845_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute_dsp_cfg = {
+	.name = "qhs_compute_dsp_cfg",
+	.id = SDM845_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SDM845_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SDM845_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SDM845_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SDM845_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SDM845_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = SDM845_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SDM845_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SDM845_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SDM845_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SDM845_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SDM845_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_gen3_cfg = {
+	.name = "qhs_pcie_gen3_cfg",
+	.id = SDM845_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SDM845_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_phy_refgen_south = {
+	.name = "qhs_phy_refgen_south",
+	.id = SDM845_SLAVE_SOUTH_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SDM845_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SDM845_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SDM845_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_north = {
+	.name = "qhs_qupv3_north",
+	.id = SDM845_SLAVE_BLSP_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qupv3_south = {
+	.name = "qhs_qupv3_south",
+	.id = SDM845_SLAVE_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SDM845_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SDM845_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SDM845_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spdm = {
+	.name = "qhs_spdm",
+	.id = SDM845_SLAVE_SPDM_WRAPPER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spss_cfg = {
+	.name = "qhs_spss_cfg",
+	.id = SDM845_SLAVE_SPSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SDM845_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_north = {
+	.name = "qhs_tlmm_north",
+	.id = SDM845_SLAVE_TLMM_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm_south = {
+	.name = "qhs_tlmm_south",
+	.id = SDM845_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tsif = {
+	.name = "qhs_tsif",
+	.id = SDM845_SLAVE_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_card_cfg = {
+	.name = "qhs_ufs_card_cfg",
+	.id = SDM845_SLAVE_UFS_CARD_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SDM845_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SDM845_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_1 = {
+	.name = "qhs_usb3_1",
+	.id = SDM845_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SDM845_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SDM845_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SDM845_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SDM845_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SDM845_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_memnoc = {
+	.name = "qhs_memnoc",
+	.id = SDM845_SLAVE_MEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDM845_MASTER_MEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qns_gladiator_sodv = {
+	.name = "qns_gladiator_sodv",
+	.id = SDM845_SLAVE_GNOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_MASTER_GNOC_SNOC },
+};
+
+static struct qcom_icc_node qns_gnoc_memnoc = {
+	.name = "qns_gnoc_memnoc",
+	.id = SDM845_SLAVE_GNOC_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_MASTER_GNOC_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_gnoc = {
+	.name = "srvc_gnoc",
+	.id = SDM845_SLAVE_SERVICE_GNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SDM845_SLAVE_EBI1,
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SDM845_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_apps_io = {
+	.name = "qns_apps_io",
+	.id = SDM845_SLAVE_MEM_NOC_GNOC,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SDM845_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM845_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_memnoc_snoc = {
+	.name = "qns_memnoc_snoc",
+	.id = SDM845_SLAVE_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_MASTER_MEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_memnoc = {
+	.name = "srvc_memnoc",
+	.id = SDM845_SLAVE_SERVICE_MEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns2_mem_noc = {
+	.name = "qns2_mem_noc",
+	.id = SDM845_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SDM845_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SDM845_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SDM845_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SDM845_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SDM845_SLAVE_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_MASTER_SNOC_CNOC },
+};
+
+static struct qcom_icc_node qns_memnoc_gc = {
+	.name = "qns_memnoc_gc",
+	.id = SDM845_SLAVE_SNOC_MEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDM845_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_memnoc_sf = {
+	.name = "qns_memnoc_sf",
+	.id = SDM845_SLAVE_SNOC_MEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDM845_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SDM845_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pcie = {
+	.name = "qxs_pcie",
+	.id = SDM845_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pcie_gen3 = {
+	.name = "qxs_pcie_gen3",
+	.id = SDM845_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SDM845_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SDM845_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SDM845_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SDM845_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);

-- 
2.41.0

