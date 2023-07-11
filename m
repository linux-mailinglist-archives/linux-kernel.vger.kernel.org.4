Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C074EE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjGKMTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGKMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F11718
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso89242321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077919; x=1691669919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l6b6se32Kc+k6vmo6Kx64L3cfKba2fLAWlauFUYNJQ=;
        b=OtESIzTechxwfKQF4vdMTdLHpGRZf3+tOcRrKD45lbr807ErTNtGmee94+BHTi6NFg
         K9i1H3Aaipy46SkHM20GOnWQqqpq8zJSxlskCAUB2YwS4PMDq7IJpqeSJ/JiMfkl+T0m
         QZDbp2md9vQQeHmIQViLKK80n9WruicZqPfZb/WwTDIczzEHV0ToPQQMOYEqRai9FyMB
         GLNp4bhKfSelxD0/hN7JNlGahOooTeAp2KLdeq0+pqcS3tOFK866/WgYSLuvH2e0Axj5
         krWIBM/mnRQQm4Hty082X1iXKFEV8JqK4K2Ww8uqrGYsuHeWs0AF1GMumBKSzIR/ikjN
         qFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077919; x=1691669919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l6b6se32Kc+k6vmo6Kx64L3cfKba2fLAWlauFUYNJQ=;
        b=PEAksC1+abqCaMdfb2xL1YrSx24Srt4Awa7lcuY3ArkCKUyFfBKfOgIzai3eym1uZ3
         ksoVfBKC+uLOFaqoD+YKSYhWGQ1LRPP+c6uWDu1cJNuKYNNmlgh8RMy2cy6hGrTWpWrh
         GNV/HJgW5FdhMhpfsa1Rr/LXYXeGON2Wlbf5yOQyYmLw11Bf0W3Em3gk5nk1ls8pZyGP
         5xxw786zJp1/gmLyt4QtTyXMhq13e/HbSsDDeaaWFMp/+ieJvIkn2/XpRr7R3EcwmDbQ
         QpddI4eGExzmV11Eqst+Z9EvqpK9EfEVnhkHpx7+9TsmTM45o9Eo/HfkbbRgL8cOsre7
         kNGg==
X-Gm-Message-State: ABy/qLa7wXBBFlSpZRO7JWCIUHVhn2ZALSINQzB2OngOCb856zPktrVu
        ths2UwNmsNq9VcZO0Fe9P2qfIaZQ7mcaIzKuEuTmRQ==
X-Google-Smtp-Source: APBJJlHTiIwOR4Gh/URRrbP1ZKro3XtA/Uy4eVS1aSwXxsscTsJZu+nmqYhm5t3ZUXmDzGEK9vFoPw==
X-Received: by 2002:a05:651c:120c:b0:2b5:80e0:f18e with SMTP id i12-20020a05651c120c00b002b580e0f18emr13904640lja.3.1689077919508;
        Tue, 11 Jul 2023 05:18:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:09 +0200
Subject: [PATCH 10/53] interconnect: qcom: sdx65: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-10-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=20861;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Atb806ycN2p4ZV3kQEetNQMYYysNjcCZbT7AH3nl6w0=;
 b=h3fQTqSs52o/JOpIqVi3C5ad1i5Fhw2YHzPt9XKqy0iG4IfGtHdU4Bt3LSr8CtD4Uka0SKTn5
 GYMw65afihsCsW9mJSeiqEPKxu3TN8C2hBy4r2sMh/6r5fK+5RAL8Ui
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
 drivers/interconnect/qcom/sdx65.c | 643 ++++++++++++++++++++++++++++++++++----
 1 file changed, 588 insertions(+), 55 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index b16d31d53e9b..bebed036fe7a 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -14,61 +14,594 @@
 #include "icc-rpmh.h"
 #include "sdx65.h"
 
-DEFINE_QNODE(llcc_mc, SDX65_MASTER_LLCC, 1, 4, SDX65_SLAVE_EBI1);
-DEFINE_QNODE(acm_tcu, SDX65_MASTER_TCU_0, 1, 8, SDX65_SLAVE_LLCC, SDX65_SLAVE_MEM_NOC_SNOC, SDX65_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SDX65_MASTER_SNOC_GC_MEM_NOC, 1, 16, SDX65_SLAVE_LLCC);
-DEFINE_QNODE(xm_apps_rdwr, SDX65_MASTER_APPSS_PROC, 1, 16, SDX65_SLAVE_LLCC, SDX65_SLAVE_MEM_NOC_SNOC, SDX65_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhm_audio, SDX65_MASTER_AUDIO, 1, 4, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_blsp1, SDX65_MASTER_BLSP_1, 1, 4, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_qdss_bam, SDX65_MASTER_QDSS_BAM, 1, 4, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_TCU);
-DEFINE_QNODE(qhm_qpic, SDX65_MASTER_QPIC, 1, 4, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qhm_snoc_cfg, SDX65_MASTER_SNOC_CFG, 1, 4, SDX65_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qhm_spmi_fetcher1, SDX65_MASTER_SPMI_FETCHER, 1, 4, SDX65_SLAVE_AOSS, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(qnm_aggre_noc, SDX65_MASTER_ANOC_SNOC, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_APPSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_PCIE_0, SDX65_SLAVE_QDSS_STM, SDX65_SLAVE_TCU);
-DEFINE_QNODE(qnm_ipa, SDX65_MASTER_IPA, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_PCIE_0, SDX65_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_memnoc, SDX65_MASTER_MEM_NOC_SNOC, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_APPSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_IMEM, SDX65_SLAVE_QDSS_STM, SDX65_SLAVE_TCU);
-DEFINE_QNODE(qnm_memnoc_pcie, SDX65_MASTER_MEM_NOC_PCIE_SNOC, 1, 8, SDX65_SLAVE_PCIE_0);
-DEFINE_QNODE(qxm_crypto, SDX65_MASTER_CRYPTO, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_ipa2pcie_slv, SDX65_MASTER_IPA_PCIE, 1, 8, SDX65_SLAVE_PCIE_0);
-DEFINE_QNODE(xm_pcie, SDX65_MASTER_PCIE_0, 1, 8, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_qdss_etr, SDX65_MASTER_QDSS_ETR, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_BLSP_1, SDX65_SLAVE_CLK_CTL, SDX65_SLAVE_CRYPTO_0_CFG, SDX65_SLAVE_CNOC_DDRSS, SDX65_SLAVE_ECC_CFG, SDX65_SLAVE_IMEM_CFG, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_CNOC_MSS, SDX65_SLAVE_PCIE_PARF, SDX65_SLAVE_PDM, SDX65_SLAVE_PRNG, SDX65_SLAVE_QDSS_CFG, SDX65_SLAVE_QPIC, SDX65_SLAVE_SDCC_1, SDX65_SLAVE_SNOC_CFG, SDX65_SLAVE_SPMI_FETCHER, SDX65_SLAVE_SPMI_VGI_COEX, SDX65_SLAVE_TCSR, SDX65_SLAVE_TLMM, SDX65_SLAVE_USB3, SDX65_SLAVE_USB3_PHY_CFG, SDX65_SLAVE_SNOC_MEM_NOC_GC, SDX65_SLAVE_IMEM, SDX65_SLAVE_TCU);
-DEFINE_QNODE(xm_sdc1, SDX65_MASTER_SDCC_1, 1, 8, SDX65_SLAVE_AOSS, SDX65_SLAVE_AUDIO, SDX65_SLAVE_IPA_CFG, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(xm_usb3, SDX65_MASTER_USB3, 1, 8, SDX65_SLAVE_ANOC_SNOC);
-DEFINE_QNODE(ebi, SDX65_SLAVE_EBI1, 1, 4);
-DEFINE_QNODE(qns_llcc, SDX65_SLAVE_LLCC, 1, 16, SDX65_MASTER_LLCC);
-DEFINE_QNODE(qns_memnoc_snoc, SDX65_SLAVE_MEM_NOC_SNOC, 1, 8, SDX65_MASTER_MEM_NOC_SNOC);
-DEFINE_QNODE(qns_sys_pcie, SDX65_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SDX65_MASTER_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhs_aoss, SDX65_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_apss, SDX65_SLAVE_APPSS, 1, 4);
-DEFINE_QNODE(qhs_audio, SDX65_SLAVE_AUDIO, 1, 4);
-DEFINE_QNODE(qhs_blsp1, SDX65_SLAVE_BLSP_1, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SDX65_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SDX65_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SDX65_SLAVE_CNOC_DDRSS, 1, 4);
-DEFINE_QNODE(qhs_ecc_cfg, SDX65_SLAVE_ECC_CFG, 1, 4);
-DEFINE_QNODE(qhs_imem_cfg, SDX65_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SDX65_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_mss_cfg, SDX65_SLAVE_CNOC_MSS, 1, 4);
-DEFINE_QNODE(qhs_pcie_parf, SDX65_SLAVE_PCIE_PARF, 1, 4);
-DEFINE_QNODE(qhs_pdm, SDX65_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_prng, SDX65_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SDX65_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qpic, SDX65_SLAVE_QPIC, 1, 4);
-DEFINE_QNODE(qhs_sdc1, SDX65_SLAVE_SDCC_1, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SDX65_SLAVE_SNOC_CFG, 1, 4, SDX65_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spmi_fetcher, SDX65_SLAVE_SPMI_FETCHER, 1, 4);
-DEFINE_QNODE(qhs_spmi_vgi_coex, SDX65_SLAVE_SPMI_VGI_COEX, 1, 4);
-DEFINE_QNODE(qhs_tcsr, SDX65_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm, SDX65_SLAVE_TLMM, 1, 4);
-DEFINE_QNODE(qhs_usb3, SDX65_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_usb3_phy, SDX65_SLAVE_USB3_PHY_CFG, 1, 4);
-DEFINE_QNODE(qns_aggre_noc, SDX65_SLAVE_ANOC_SNOC, 1, 8, SDX65_MASTER_ANOC_SNOC);
-DEFINE_QNODE(qns_snoc_memnoc, SDX65_SLAVE_SNOC_MEM_NOC_GC, 1, 16, SDX65_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SDX65_SLAVE_IMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SDX65_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_pcie, SDX65_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(xs_qdss_stm, SDX65_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SDX65_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SDX65_MASTER_LLCC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node acm_tcu = {
+	.name = "acm_tcu",
+	.id = SDX65_MASTER_TCU_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SDX65_SLAVE_LLCC,
+		   SDX65_SLAVE_MEM_NOC_SNOC,
+		   SDX65_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SDX65_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node xm_apps_rdwr = {
+	.name = "xm_apps_rdwr",
+	.id = SDX65_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX65_SLAVE_LLCC,
+		   SDX65_SLAVE_MEM_NOC_SNOC,
+		   SDX65_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_audio = {
+	.name = "qhm_audio",
+	.id = SDX65_MASTER_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_blsp1 = {
+	.name = "qhm_blsp1",
+	.id = SDX65_MASTER_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SDX65_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 26,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_BLSP_1,
+		   SDX65_SLAVE_CLK_CTL,
+		   SDX65_SLAVE_CRYPTO_0_CFG,
+		   SDX65_SLAVE_CNOC_DDRSS,
+		   SDX65_SLAVE_ECC_CFG,
+		   SDX65_SLAVE_IMEM_CFG,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_CNOC_MSS,
+		   SDX65_SLAVE_PCIE_PARF,
+		   SDX65_SLAVE_PDM,
+		   SDX65_SLAVE_PRNG,
+		   SDX65_SLAVE_QDSS_CFG,
+		   SDX65_SLAVE_QPIC,
+		   SDX65_SLAVE_SDCC_1,
+		   SDX65_SLAVE_SNOC_CFG,
+		   SDX65_SLAVE_SPMI_FETCHER,
+		   SDX65_SLAVE_SPMI_VGI_COEX,
+		   SDX65_SLAVE_TCSR,
+		   SDX65_SLAVE_TLMM,
+		   SDX65_SLAVE_USB3,
+		   SDX65_SLAVE_USB3_PHY_CFG,
+		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX65_SLAVE_IMEM,
+		   SDX65_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qhm_qpic = {
+	.name = "qhm_qpic",
+	.id = SDX65_MASTER_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 4,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_ANOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SDX65_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qhm_spmi_fetcher1 = {
+	.name = "qhm_spmi_fetcher1",
+	.id = SDX65_MASTER_SPMI_FETCHER,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_ANOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_aggre_noc = {
+	.name = "qnm_aggre_noc",
+	.id = SDX65_MASTER_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 29,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_APPSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_BLSP_1,
+		   SDX65_SLAVE_CLK_CTL,
+		   SDX65_SLAVE_CRYPTO_0_CFG,
+		   SDX65_SLAVE_CNOC_DDRSS,
+		   SDX65_SLAVE_ECC_CFG,
+		   SDX65_SLAVE_IMEM_CFG,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_CNOC_MSS,
+		   SDX65_SLAVE_PCIE_PARF,
+		   SDX65_SLAVE_PDM,
+		   SDX65_SLAVE_PRNG,
+		   SDX65_SLAVE_QDSS_CFG,
+		   SDX65_SLAVE_QPIC,
+		   SDX65_SLAVE_SDCC_1,
+		   SDX65_SLAVE_SNOC_CFG,
+		   SDX65_SLAVE_SPMI_FETCHER,
+		   SDX65_SLAVE_SPMI_VGI_COEX,
+		   SDX65_SLAVE_TCSR,
+		   SDX65_SLAVE_TLMM,
+		   SDX65_SLAVE_USB3,
+		   SDX65_SLAVE_USB3_PHY_CFG,
+		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX65_SLAVE_IMEM,
+		   SDX65_SLAVE_PCIE_0,
+		   SDX65_SLAVE_QDSS_STM,
+		   SDX65_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_ipa = {
+	.name = "qnm_ipa",
+	.id = SDX65_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 26,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_BLSP_1,
+		   SDX65_SLAVE_CLK_CTL,
+		   SDX65_SLAVE_CRYPTO_0_CFG,
+		   SDX65_SLAVE_CNOC_DDRSS,
+		   SDX65_SLAVE_ECC_CFG,
+		   SDX65_SLAVE_IMEM_CFG,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_CNOC_MSS,
+		   SDX65_SLAVE_PCIE_PARF,
+		   SDX65_SLAVE_PDM,
+		   SDX65_SLAVE_PRNG,
+		   SDX65_SLAVE_QDSS_CFG,
+		   SDX65_SLAVE_QPIC,
+		   SDX65_SLAVE_SDCC_1,
+		   SDX65_SLAVE_SNOC_CFG,
+		   SDX65_SLAVE_SPMI_FETCHER,
+		   SDX65_SLAVE_TCSR,
+		   SDX65_SLAVE_TLMM,
+		   SDX65_SLAVE_USB3,
+		   SDX65_SLAVE_USB3_PHY_CFG,
+		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX65_SLAVE_IMEM,
+		   SDX65_SLAVE_PCIE_0,
+		   SDX65_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc = {
+	.name = "qnm_memnoc",
+	.id = SDX65_MASTER_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 27,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_APPSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_BLSP_1,
+		   SDX65_SLAVE_CLK_CTL,
+		   SDX65_SLAVE_CRYPTO_0_CFG,
+		   SDX65_SLAVE_CNOC_DDRSS,
+		   SDX65_SLAVE_ECC_CFG,
+		   SDX65_SLAVE_IMEM_CFG,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_CNOC_MSS,
+		   SDX65_SLAVE_PCIE_PARF,
+		   SDX65_SLAVE_PDM,
+		   SDX65_SLAVE_PRNG,
+		   SDX65_SLAVE_QDSS_CFG,
+		   SDX65_SLAVE_QPIC,
+		   SDX65_SLAVE_SDCC_1,
+		   SDX65_SLAVE_SNOC_CFG,
+		   SDX65_SLAVE_SPMI_FETCHER,
+		   SDX65_SLAVE_SPMI_VGI_COEX,
+		   SDX65_SLAVE_TCSR,
+		   SDX65_SLAVE_TLMM,
+		   SDX65_SLAVE_USB3,
+		   SDX65_SLAVE_USB3_PHY_CFG,
+		   SDX65_SLAVE_IMEM,
+		   SDX65_SLAVE_QDSS_STM,
+		   SDX65_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_memnoc_pcie = {
+	.name = "qnm_memnoc_pcie",
+	.id = SDX65_MASTER_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SDX65_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_ANOC_SNOC
+	},
+};
+
+static struct qcom_icc_node xm_ipa2pcie_slv = {
+	.name = "xm_ipa2pcie_slv",
+	.id = SDX65_MASTER_IPA_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node xm_pcie = {
+	.name = "xm_pcie",
+	.id = SDX65_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SDX65_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 26,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_BLSP_1,
+		   SDX65_SLAVE_CLK_CTL,
+		   SDX65_SLAVE_CRYPTO_0_CFG,
+		   SDX65_SLAVE_CNOC_DDRSS,
+		   SDX65_SLAVE_ECC_CFG,
+		   SDX65_SLAVE_IMEM_CFG,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_CNOC_MSS,
+		   SDX65_SLAVE_PCIE_PARF,
+		   SDX65_SLAVE_PDM,
+		   SDX65_SLAVE_PRNG,
+		   SDX65_SLAVE_QDSS_CFG,
+		   SDX65_SLAVE_QPIC,
+		   SDX65_SLAVE_SDCC_1,
+		   SDX65_SLAVE_SNOC_CFG,
+		   SDX65_SLAVE_SPMI_FETCHER,
+		   SDX65_SLAVE_SPMI_VGI_COEX,
+		   SDX65_SLAVE_TCSR,
+		   SDX65_SLAVE_TLMM,
+		   SDX65_SLAVE_USB3,
+		   SDX65_SLAVE_USB3_PHY_CFG,
+		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
+		   SDX65_SLAVE_IMEM,
+		   SDX65_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SDX65_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 4,
+	.links = { SDX65_SLAVE_AOSS,
+		   SDX65_SLAVE_AUDIO,
+		   SDX65_SLAVE_IPA_CFG,
+		   SDX65_SLAVE_ANOC_SNOC
+	},
+};
+
+static struct qcom_icc_node xm_usb3 = {
+	.name = "xm_usb3",
+	.id = SDX65_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_SLAVE_ANOC_SNOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SDX65_SLAVE_EBI1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SDX65_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX65_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_memnoc_snoc = {
+	.name = "qns_memnoc_snoc",
+	.id = SDX65_SLAVE_MEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_MASTER_MEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_sys_pcie = {
+	.name = "qns_sys_pcie",
+	.id = SDX65_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_MASTER_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SDX65_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SDX65_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_audio = {
+	.name = "qhs_audio",
+	.id = SDX65_SLAVE_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_blsp1 = {
+	.name = "qhs_blsp1",
+	.id = SDX65_SLAVE_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SDX65_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SDX65_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SDX65_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ecc_cfg = {
+	.name = "qhs_ecc_cfg",
+	.id = SDX65_SLAVE_ECC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SDX65_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SDX65_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SDX65_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_parf = {
+	.name = "qhs_pcie_parf",
+	.id = SDX65_SLAVE_PCIE_PARF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SDX65_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SDX65_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SDX65_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qpic = {
+	.name = "qhs_qpic",
+	.id = SDX65_SLAVE_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SDX65_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SDX65_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX65_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spmi_fetcher = {
+	.name = "qhs_spmi_fetcher",
+	.id = SDX65_SLAVE_SPMI_FETCHER,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spmi_vgi_coex = {
+	.name = "qhs_spmi_vgi_coex",
+	.id = SDX65_SLAVE_SPMI_VGI_COEX,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SDX65_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SDX65_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.id = SDX65_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_phy = {
+	.name = "qhs_usb3_phy",
+	.id = SDX65_SLAVE_USB3_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_aggre_noc = {
+	.name = "qns_aggre_noc",
+	.id = SDX65_SLAVE_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX65_MASTER_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qns_snoc_memnoc = {
+	.name = "qns_snoc_memnoc",
+	.id = SDX65_SLAVE_SNOC_MEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX65_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SDX65_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SDX65_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie = {
+	.name = "xs_pcie",
+	.id = SDX65_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SDX65_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SDX65_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
 DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);

-- 
2.41.0

