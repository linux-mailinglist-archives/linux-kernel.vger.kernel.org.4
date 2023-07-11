Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC674EE16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGKMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGKMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BA170B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso88497571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077918; x=1691669918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEtASMz6mSJMTniK/9HNLuhx5dET0HPcdtQEWkrRrz8=;
        b=pi8u64CUTpTqMGfFhKOiDDuZjG0Ve92SxZJGnCVp/Sm6vB4SQNUN6Ki0gEbjNlKnwd
         31yLxOzPMMpOuPkE1XOSoEmVNrIAp2jDfRr2Zc3TQ3n2tRdBcQ4DUVFVZj/mg+kCuzNM
         9X8Q+bd73Ji7/GNX7VgzBCVbzmu56x/w3nD4kTzHtfxbptVP2qvG2kIkMpTP9FmCYKP+
         snWESdUD41U/IJ+VX4hvmgzvzjRBrkaFdtp85JqHd8pV2v3LiF5HSIo1jrNWA87bVyRD
         X0MAHzw6B3dVWhxLrFbYhdVRGI4ksHeVewunuKxQvBI0MjDFYhaVM1XEaYgzMoactaxw
         IJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077918; x=1691669918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEtASMz6mSJMTniK/9HNLuhx5dET0HPcdtQEWkrRrz8=;
        b=ihmunq8NDgFc5B0OqWJd41T7Xggf2KY3om7ohaMVEhRUE3X3ZNlIBN/jnQ0MYHrrOX
         w4lBwQINGXrZjY2iWXDub3GoaHKEBoXLQwBRNM2/vSTQhsTgQlUrUJyy8/PvMPYn8fc3
         coj2xzKfkIc6uWaz8dm5cnfWcc36zUBZu3MOgHO+oABNjY/h847KMMeDXcIOonyYOFY2
         qAo3ds/1oru2LUbTyilzUeeQruMiO386Av7poUKsHyqaa4MwWOSkhoIj9KdrwKyRN1Op
         kw4Sk0ehItJM87UuqGkX0vfeqNRsBffAkzBfl078pFFLx9MIhqJwYSnHmXuXMbvHX1S7
         5ZZw==
X-Gm-Message-State: ABy/qLZA5tSaDo0OTUXt28WOi9/bQmnh3/u+o7MQBJY+uo67meS544OK
        WjxVUf5a+vGkxYZA/TAwKv/eYQ==
X-Google-Smtp-Source: APBJJlHzeFn9oxlHzON5QG5W0pyWJDTwk8+shJhaY2bmLp9kXlGdL/ocX/rMhrY7S+H/1jkyTGO06g==
X-Received: by 2002:a05:651c:120e:b0:2b6:9bd3:840e with SMTP id i14-20020a05651c120e00b002b69bd3840emr14899513lja.21.1689077918164;
        Tue, 11 Jul 2023 05:18:38 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:08 +0200
Subject: [PATCH 09/53] interconnect: qcom: sdx55: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-9-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=22083;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DfvVOVIJtBrOMDPH5uxDCesHNBsdiS2Js6MQ8bXhn3w=;
 b=eT0LvUJhmLKsKNSJml7cLtTJ25fwA5ZUjjQXGVbYrJ9bR2dWLhT4vlK4FMuFijkpTq2D50mOh
 hv2kBcQRx9QCjUMYaVQBlkk/HC4/kOEGkW10lPE0xHV+5LMWnLS4WY1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdx55.c | 681 ++++++++++++++++++++++++++++++++++----
 1 file changed, 623 insertions(+), 58 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 130a828c3873..2b5e8873eaa5 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -18,64 +18,629 @@
 #include "icc-rpmh.h"
 #include "sdx55.h"
 
-DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
-DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
-DEFINE_QNODE(xm_apps_rdwr, SDX55_MASTER_AMPSS_M0, 1, 16, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhm_audio, SDX55_MASTER_AUDIO, 1, 4, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_blsp1, SDX55_MASTER_BLSP_1, 1, 4, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_qdss_bam, SDX55_MASTER_QDSS_BAM, 1, 4, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qhm_qpic, SDX55_MASTER_QPIC, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
-DEFINE_QNODE(qhm_snoc_cfg, SDX55_MASTER_SNOC_CFG, 1, 4, SDX55_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qhm_spmi_fetcher1, SDX55_MASTER_SPMI_FETCHER, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
-DEFINE_QNODE(qnm_aggre_noc, SDX55_MASTER_ANOC_SNOC, 1, 8, SDX55_SLAVE_PCIE_0, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_USB3, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qnm_ipa, SDX55_MASTER_IPA, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_TLMM, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qnm_memnoc, SDX55_MASTER_MEM_NOC_SNOC, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS,  SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(qnm_memnoc_pcie, SDX55_MASTER_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_SLAVE_PCIE_0);
-DEFINE_QNODE(qxm_crypto, SDX55_MASTER_CRYPTO_CORE_0, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
-DEFINE_QNODE(xm_emac, SDX55_MASTER_EMAC, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_ipa2pcie_slv, SDX55_MASTER_IPA_PCIE, 1, 8, SDX55_SLAVE_PCIE_0);
-DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
-DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
-DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
-DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
-DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
-DEFINE_QNODE(qns_sys_pcie, SDX55_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhs_aop, SDX55_SLAVE_AOP, 1, 4);
-DEFINE_QNODE(qhs_aoss, SDX55_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_apss, SDX55_SLAVE_APPSS, 1, 4);
-DEFINE_QNODE(qhs_audio, SDX55_SLAVE_AUDIO, 1, 4);
-DEFINE_QNODE(qhs_blsp1, SDX55_SLAVE_BLSP_1, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SDX55_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SDX55_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SDX55_SLAVE_CNOC_DDRSS, 1, 4);
-DEFINE_QNODE(qhs_ecc_cfg, SDX55_SLAVE_ECC_CFG, 1, 4);
-DEFINE_QNODE(qhs_emac_cfg, SDX55_SLAVE_EMAC_CFG, 1, 4);
-DEFINE_QNODE(qhs_imem_cfg, SDX55_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SDX55_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mss_cfg, SDX55_SLAVE_CNOC_MSS, 1, 4);
-DEFINE_QNODE(qhs_pcie_parf, SDX55_SLAVE_PCIE_PARF, 1, 4);
-DEFINE_QNODE(qhs_pdm, SDX55_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_prng, SDX55_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SDX55_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qpic, SDX55_SLAVE_QPIC, 1, 4);
-DEFINE_QNODE(qhs_sdc1, SDX55_SLAVE_SDCC_1, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SDX55_SLAVE_SNOC_CFG, 1, 4, SDX55_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spmi_fetcher, SDX55_SLAVE_SPMI_FETCHER, 1, 4);
-DEFINE_QNODE(qhs_spmi_vgi_coex, SDX55_SLAVE_SPMI_VGI_COEX, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SDX55_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm, SDX55_SLAVE_TLMM, 1, 4);
-DEFINE_QNODE(qhs_usb3, SDX55_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_usb3_phy, SDX55_SLAVE_USB3_PHY_CFG, 1, 4);
-DEFINE_QNODE(qns_aggre_noc, SDX55_SLAVE_ANOC_SNOC, 1, 8, SDX55_MASTER_ANOC_SNOC);
-DEFINE_QNODE(qns_snoc_memnoc, SDX55_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDX55_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SDX55_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SDX55_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_pcie, SDX55_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(xs_qdss_stm, SDX55_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SDX55_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node acm_tcu = {
+	.name = "acm_tcu",
+	.id = SDX55_MASTER_TCU_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_LLCC,
+		   SDX55_SLAVE_MEM_NOC_SNOC,
+		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SDX55_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node xm_apps_rdwr = {
+	.name = "xm_apps_rdwr",
+	.id = SDX55_MASTER_AMPSS_M0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_LLCC,
+		   SDX55_SLAVE_MEM_NOC_SNOC,
+		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_audio = {
+	.name = "qhm_audio",
+	.id = SDX55_MASTER_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_blsp1 = {
+	.name = "qhm_blsp1",
+	.id = SDX55_MASTER_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SDX55_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 28,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qhm_qpic = {
+	.name = "qhm_qpic",
+	.id = SDX55_MASTER_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 5,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_AUDIO
+	},
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SDX55_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qhm_spmi_fetcher1 = {
+	.name = "qhm_spmi_fetcher1",
+	.id = SDX55_MASTER_SPMI_FETCHER,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP
+	},
+};
+
+static struct qcom_icc_node qnm_aggre_noc = {
+	.name = "qnm_aggre_noc",
+	.id = SDX55_MASTER_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 30,
+	.links = { SDX55_SLAVE_PCIE_0,
+		   SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QDSS_STM,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_APPSS,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_ipa = {
+	.name = "qnm_ipa",
+	.id = SDX55_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 27,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_QDSS_STM,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc = {
+	.name = "qnm_memnoc",
+	.id = SDX55_MASTER_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 29,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_TLMM,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QDSS_STM,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_APPSS,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc_pcie = {
+	.name = "qnm_memnoc_pcie",
+	.id = SDX55_MASTER_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SDX55_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP
+	},
+};
+
+static struct qcom_icc_node xm_emac = {
+	.name = "xm_emac",
+	.id = SDX55_MASTER_EMAC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ipa2pcie_slv = {
+	.name = "xm_ipa2pcie_slv",
+	.id = SDX55_MASTER_IPA_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node xm_pcie = {
+	.name = "xm_pcie",
+	.id = SDX55_MASTER_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SDX55_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 28,
+	.links = { SDX55_SLAVE_SNOC_CFG,
+		   SDX55_SLAVE_EMAC_CFG,
+		   SDX55_SLAVE_USB3,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_SPMI_FETCHER,
+		   SDX55_SLAVE_QDSS_CFG,
+		   SDX55_SLAVE_PDM,
+		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX55_SLAVE_TCSR,
+		   SDX55_SLAVE_CNOC_DDRSS,
+		   SDX55_SLAVE_SPMI_VGI_COEX,
+		   SDX55_SLAVE_QPIC,
+		   SDX55_SLAVE_OCIMEM,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_USB3_PHY_CFG,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_BLSP_1,
+		   SDX55_SLAVE_SDCC_1,
+		   SDX55_SLAVE_CNOC_MSS,
+		   SDX55_SLAVE_PCIE_PARF,
+		   SDX55_SLAVE_ECC_CFG,
+		   SDX55_SLAVE_AUDIO,
+		   SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_PRNG,
+		   SDX55_SLAVE_CRYPTO_0_CFG,
+		   SDX55_SLAVE_TCU,
+		   SDX55_SLAVE_CLK_CTL,
+		   SDX55_SLAVE_IMEM_CFG
+	},
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SDX55_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 5,
+	.links = { SDX55_SLAVE_AOSS,
+		   SDX55_SLAVE_IPA_CFG,
+		   SDX55_SLAVE_ANOC_SNOC,
+		   SDX55_SLAVE_AOP,
+		   SDX55_SLAVE_AUDIO
+	},
+};
+
+static struct qcom_icc_node xm_usb3 = {
+	.name = "xm_usb3",
+	.id = SDX55_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SDX55_SLAVE_EBI_CH0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SDX55_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX55_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node qns_memnoc_snoc = {
+	.name = "qns_memnoc_snoc",
+	.id = SDX55_SLAVE_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_MEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_sys_pcie = {
+	.name = "qns_sys_pcie",
+	.id = SDX55_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = SDX55_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SDX55_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SDX55_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_audio = {
+	.name = "qhs_audio",
+	.id = SDX55_SLAVE_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_blsp1 = {
+	.name = "qhs_blsp1",
+	.id = SDX55_SLAVE_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SDX55_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SDX55_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SDX55_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ecc_cfg = {
+	.name = "qhs_ecc_cfg",
+	.id = SDX55_SLAVE_ECC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emac_cfg = {
+	.name = "qhs_emac_cfg",
+	.id = SDX55_SLAVE_EMAC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SDX55_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SDX55_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SDX55_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_parf = {
+	.name = "qhs_pcie_parf",
+	.id = SDX55_SLAVE_PCIE_PARF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SDX55_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SDX55_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SDX55_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qpic = {
+	.name = "qhs_qpic",
+	.id = SDX55_SLAVE_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SDX55_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SDX55_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX55_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spmi_fetcher = {
+	.name = "qhs_spmi_fetcher",
+	.id = SDX55_SLAVE_SPMI_FETCHER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spmi_vgi_coex = {
+	.name = "qhs_spmi_vgi_coex",
+	.id = SDX55_SLAVE_SPMI_VGI_COEX,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SDX55_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SDX55_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.id = SDX55_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_phy = {
+	.name = "qhs_usb3_phy",
+	.id = SDX55_SLAVE_USB3_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_aggre_noc = {
+	.name = "qns_aggre_noc",
+	.id = SDX55_SLAVE_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qns_snoc_memnoc = {
+	.name = "qns_snoc_memnoc",
+	.id = SDX55_SLAVE_SNOC_MEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX55_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SDX55_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SDX55_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie = {
+	.name = "xs_pcie",
+	.id = SDX55_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SDX55_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SDX55_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);

-- 
2.41.0

