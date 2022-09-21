Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B55BF260
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiIUApY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIUApK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:45:10 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133378237
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:45:08 -0700 (PDT)
Received: from localhost.localdomain (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 17C913F637;
        Wed, 21 Sep 2022 02:45:06 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] clk: qcom: smd: Add SM6375 clocks
Date:   Wed, 21 Sep 2022 02:44:58 +0200
Message-Id: <20220921004458.151842-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921004458.151842-1-konrad.dybcio@somainline.org>
References: <20220921004458.151842-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controlling SMD RPM clocks on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v1:
- changed the compatible to match the style used in the file

 drivers/clk/qcom/clk-smd-rpm.c   | 46 ++++++++++++++++++++++++++++++--
 include/linux/soc/qcom/smd-rpm.h |  1 +
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 56096123081c..fea505876855 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1119,13 +1119,54 @@ static const struct rpm_smd_clk_desc rpm_clk_sm6115 = {
 	.num_clks = ARRAY_SIZE(sm6115_clks),
 };
 
+/* SM6375 */
+DEFINE_CLK_SMD_RPM(sm6375, mmnrt_clk, mmnrt_a_clk, QCOM_SMD_RPM_MMXI_CLK, 0);
+DEFINE_CLK_SMD_RPM(sm6375, mmrt_clk, mmrt_a_clk, QCOM_SMD_RPM_MMXI_CLK, 1);
+DEFINE_CLK_SMD_RPM(qcm2290, hwkm_clk, hwkm_a_clk, QCOM_SMD_RPM_HWKM_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcm2290, pka_clk, pka_a_clk, QCOM_SMD_RPM_PKA_CLK, 0);
+DEFINE_CLK_SMD_RPM_BRANCH(sm6375, bimc_freq_log, bimc_freq_log_a, QCOM_SMD_RPM_MISC_CLK, 4, 1);
+static struct clk_smd_rpm *sm6375_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &sdm660_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC] = &sdm660_bi_tcxo_a,
+	[RPM_SMD_SNOC_CLK] = &sm6125_snoc_clk,
+	[RPM_SMD_SNOC_A_CLK] = &sm6125_snoc_a_clk,
+	[RPM_SMD_BIMC_CLK] = &msm8916_bimc_clk,
+	[RPM_SMD_BIMC_A_CLK] = &msm8916_bimc_a_clk,
+	[RPM_SMD_QDSS_CLK] = &sm6125_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &sm6125_qdss_a_clk,
+	[RPM_SMD_CNOC_CLK] = &sm6125_cnoc_clk,
+	[RPM_SMD_CNOC_A_CLK] = &sm6125_cnoc_a_clk,
+	[RPM_SMD_IPA_CLK] = &msm8976_ipa_clk,
+	[RPM_SMD_IPA_A_CLK] = &msm8976_ipa_a_clk,
+	[RPM_SMD_QUP_CLK] = &sm6125_qup_clk,
+	[RPM_SMD_QUP_A_CLK] = &sm6125_qup_a_clk,
+	[RPM_SMD_MMRT_CLK] = &sm6375_mmrt_clk,
+	[RPM_SMD_MMRT_A_CLK] = &sm6375_mmrt_a_clk,
+	[RPM_SMD_MMNRT_CLK] = &sm6375_mmnrt_clk,
+	[RPM_SMD_MMNRT_A_CLK] = &sm6375_mmnrt_a_clk,
+	[RPM_SMD_SNOC_PERIPH_CLK] = &sm6125_snoc_periph_clk,
+	[RPM_SMD_SNOC_PERIPH_A_CLK] = &sm6125_snoc_periph_a_clk,
+	[RPM_SMD_SNOC_LPASS_CLK] = &sm6125_snoc_lpass_clk,
+	[RPM_SMD_SNOC_LPASS_A_CLK] = &sm6125_snoc_lpass_a_clk,
+	[RPM_SMD_CE1_CLK] = &msm8992_ce1_clk,
+	[RPM_SMD_CE1_A_CLK] = &msm8992_ce1_a_clk,
+	[RPM_SMD_HWKM_CLK] = &qcm2290_hwkm_clk,
+	[RPM_SMD_HWKM_A_CLK] = &qcm2290_hwkm_a_clk,
+	[RPM_SMD_PKA_CLK] = &qcm2290_pka_clk,
+	[RPM_SMD_PKA_A_CLK] = &qcm2290_pka_a_clk,
+	[RPM_SMD_BIMC_FREQ_LOG] = &sm6375_bimc_freq_log,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_sm6375 = {
+	.clks = sm6375_clks,
+	.num_clks = ARRAY_SIZE(sm6375_clks),
+};
+
 /* QCM2290 */
 DEFINE_CLK_SMD_RPM_XO_BUFFER(qcm2290, ln_bb_clk2, ln_bb_clk2_a, 0x2, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(qcm2290, rf_clk3, rf_clk3_a, 6, 38400000);
 
 DEFINE_CLK_SMD_RPM(qcm2290, qpic_clk, qpic_a_clk, QCOM_SMD_RPM_QPIC_CLK, 0);
-DEFINE_CLK_SMD_RPM(qcm2290, hwkm_clk, hwkm_a_clk, QCOM_SMD_RPM_HWKM_CLK, 0);
-DEFINE_CLK_SMD_RPM(qcm2290, pka_clk, pka_a_clk, QCOM_SMD_RPM_PKA_CLK, 0);
 DEFINE_CLK_SMD_RPM(qcm2290, cpuss_gnoc_clk, cpuss_gnoc_a_clk,
 		   QCOM_SMD_RPM_MEM_CLK, 1);
 DEFINE_CLK_SMD_RPM(qcm2290, bimc_gpu_clk, bimc_gpu_a_clk,
@@ -1195,6 +1236,7 @@ static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-sdm660",  .data = &rpm_clk_sdm660  },
 	{ .compatible = "qcom,rpmcc-sm6115",  .data = &rpm_clk_sm6115  },
 	{ .compatible = "qcom,rpmcc-sm6125",  .data = &rpm_clk_sm6125  },
+	{ .compatible = "qcom,rpmcc-sm6375",  .data = &rpm_clk_sm6375  },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 82c9d489833a..3ab8c07f71c0 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -41,6 +41,7 @@ struct qcom_smd_rpm;
 #define QCOM_SMD_RPM_HWKM_CLK	0x6d6b7768
 #define QCOM_SMD_RPM_PKA_CLK	0x616b70
 #define QCOM_SMD_RPM_MCFG_CLK	0x6766636d
+#define QCOM_SMD_RPM_MMXI_CLK	0x69786d6d
 
 int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 		       int state,
-- 
2.37.3

