Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299A6CB44D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC1CuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjC1CuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:50:00 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCA1FCF;
        Mon, 27 Mar 2023 19:49:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 506F61A00AF3;
        Tue, 28 Mar 2023 10:50:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YYhYTM_4EMY7; Tue, 28 Mar 2023 10:50:03 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A877B1A00805;
        Tue, 28 Mar 2023 10:50:02 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH v4] remoteproc: remove unnecessary (void*) conversions
Date:   Tue, 28 Mar 2023 10:49:07 +0800
Message-Id: <20230328024907.29791-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230328015749.1608-1-yuzhe@nfschina.com>
References: <20230328015749.1608-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=2.6 required=5.0 tests=RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303272213.jOYrwBZu-lkp@intel.com/
Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---

v3->v4:
 Drop wrong modifies
---
 drivers/remoteproc/da8xx_remoteproc.c   | 12 ++++++------
 drivers/remoteproc/mtk_scp.c            | 12 ++++++------
 drivers/remoteproc/qcom_q6v5_adsp.c     | 10 +++++-----
 drivers/remoteproc/qcom_q6v5_mss.c      |  8 ++++----
 drivers/remoteproc/qcom_q6v5_pas.c      | 14 +++++++-------
 drivers/remoteproc/qcom_wcnss.c         | 10 +++++-----
 drivers/remoteproc/xlnx_r5_remoteproc.c | 16 ++++++++--------
 7 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 98e0be9476a4..768217f0f5cd 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -84,7 +84,7 @@ struct da8xx_rproc {
  */
 static irqreturn_t handle_event(int irq, void *p)
 {
-	struct rproc *rproc = (struct rproc *)p;
+	struct rproc *rproc = p;
 
 	/* Process incoming buffers on all our vrings */
 	rproc_vq_interrupt(rproc, 0);
@@ -104,8 +104,8 @@ static irqreturn_t handle_event(int irq, void *p)
  */
 static irqreturn_t da8xx_rproc_callback(int irq, void *p)
 {
-	struct rproc *rproc = (struct rproc *)p;
-	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
+	struct rproc *rproc = p;
+	struct da8xx_rproc *drproc = rproc->priv;
 	u32 chipsig;
 
 	chipsig = readl(drproc->chipsig);
@@ -133,7 +133,7 @@ static irqreturn_t da8xx_rproc_callback(int irq, void *p)
 static int da8xx_rproc_start(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
-	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
+	struct da8xx_rproc *drproc = rproc->priv;
 	struct clk *dsp_clk = drproc->dsp_clk;
 	struct reset_control *dsp_reset = drproc->dsp_reset;
 	int ret;
@@ -183,7 +183,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
 /* kick a virtqueue */
 static void da8xx_rproc_kick(struct rproc *rproc, int vqid)
 {
-	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
+	struct da8xx_rproc *drproc = rproc->priv;
 
 	/* Interrupt remote proc */
 	writel(SYSCFG_CHIPSIG2, drproc->chipsig);
@@ -360,7 +360,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 static int da8xx_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
-	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
+	struct da8xx_rproc *drproc = rproc->priv;
 	struct device *dev = &pdev->dev;
 
 	/*
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 0861b76f185f..e1d93e63d7df 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -74,8 +74,8 @@ static void scp_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
 
 static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
 {
-	struct mtk_scp *scp = (struct mtk_scp *)priv;
-	struct scp_run *run = (struct scp_run *)data;
+	struct mtk_scp *scp = priv;
+	struct scp_run *run = data;
 
 	scp->run.signaled = run->signaled;
 	strscpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
@@ -498,7 +498,7 @@ static int scp_parse_fw(struct rproc *rproc, const struct firmware *fw)
 
 static int scp_start(struct rproc *rproc)
 {
-	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
+	struct mtk_scp *scp = rproc->priv;
 	struct device *dev = scp->dev;
 	struct scp_run *run = &scp->run;
 	int ret;
@@ -587,7 +587,7 @@ static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 
 static void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
-	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
+	struct mtk_scp *scp = rproc->priv;
 
 	return scp->data->scp_da_to_va(scp, da, len);
 }
@@ -627,7 +627,7 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
 
 static int scp_stop(struct rproc *rproc)
 {
-	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
+	struct mtk_scp *scp = rproc->priv;
 	int ret;
 
 	ret = clk_prepare_enable(scp->clk);
@@ -829,7 +829,7 @@ static int scp_probe(struct platform_device *pdev)
 	if (!rproc)
 		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
 
-	scp = (struct mtk_scp *)rproc->priv;
+	scp = rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
 	scp->data = of_device_get_match_data(dev);
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 08d8dad22ca7..d546ab9dc141 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -321,7 +321,7 @@ static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
 
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int ret;
 
 	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
@@ -379,7 +379,7 @@ static int adsp_map_carveout(struct rproc *rproc)
 
 static int adsp_start(struct rproc *rproc)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int ret;
 	unsigned int val;
 
@@ -469,7 +469,7 @@ static void qcom_adsp_pil_handover(struct qcom_q6v5 *q6v5)
 
 static int adsp_stop(struct rproc *rproc)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int handover;
 	int ret;
 
@@ -492,7 +492,7 @@ static int adsp_stop(struct rproc *rproc)
 
 static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int offset;
 
 	offset = da - adsp->mem_reloc;
@@ -696,7 +696,7 @@ static int adsp_probe(struct platform_device *pdev)
 	rproc->has_iommu = desc->has_iommu;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
-	adsp = (struct qcom_adsp *)rproc->priv;
+	adsp = rproc->priv;
 	adsp->dev = &pdev->dev;
 	adsp->rproc = rproc;
 	adsp->info_name = desc->sysmon_name;
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index ab053084f7a2..e7a67c8c16a0 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1562,7 +1562,7 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 
 static int q6v5_start(struct rproc *rproc)
 {
-	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	struct q6v5 *qproc = rproc->priv;
 	int xfermemop_ret;
 	int ret;
 
@@ -1604,7 +1604,7 @@ static int q6v5_start(struct rproc *rproc)
 
 static int q6v5_stop(struct rproc *rproc)
 {
-	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	struct q6v5 *qproc = rproc->priv;
 	int ret;
 
 	ret = qcom_q6v5_request_stop(&qproc->q6v5, qproc->sysmon);
@@ -1662,7 +1662,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 
 static unsigned long q6v5_panic(struct rproc *rproc)
 {
-	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	struct q6v5 *qproc = rproc->priv;
 
 	return qcom_q6v5_panic(&qproc->q6v5);
 }
@@ -1977,7 +1977,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	rproc->auto_boot = false;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
-	qproc = (struct q6v5 *)rproc->priv;
+	qproc = rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
 	qproc->hexagon_mdt_image = "modem.mdt";
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 0871108fb4dc..8eec88119fdd 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -186,7 +186,7 @@ static int adsp_shutdown_poll_decrypt(struct qcom_adsp *adsp)
 
 static int adsp_unprepare(struct rproc *rproc)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 
 	/*
 	 * adsp_load() did pass pas_metadata to the SCM driver for storing
@@ -203,7 +203,7 @@ static int adsp_unprepare(struct rproc *rproc)
 
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int ret;
 
 	/* Store firmware handle to be used in adsp_start() */
@@ -244,7 +244,7 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 
 static int adsp_start(struct rproc *rproc)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int ret;
 
 	ret = qcom_q6v5_prepare(&adsp->q6v5);
@@ -360,7 +360,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
 
 static int adsp_stop(struct rproc *rproc)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int handover;
 	int ret;
 
@@ -390,7 +390,7 @@ static int adsp_stop(struct rproc *rproc)
 
 static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 	int offset;
 
 	offset = da - adsp->mem_reloc;
@@ -405,7 +405,7 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iom
 
 static unsigned long adsp_panic(struct rproc *rproc)
 {
-	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	struct qcom_adsp *adsp = rproc->priv;
 
 	return qcom_q6v5_panic(&adsp->q6v5);
 }
@@ -683,7 +683,7 @@ static int adsp_probe(struct platform_device *pdev)
 	rproc->auto_boot = desc->auto_boot;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
-	adsp = (struct qcom_adsp *)rproc->priv;
+	adsp = rproc->priv;
 	adsp->dev = &pdev->dev;
 	adsp->rproc = rproc;
 	adsp->minidump_id = desc->minidump_id;
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 9d4d04fff8c6..0fc317265064 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -154,7 +154,7 @@ static const struct wcnss_data pronto_v3_data = {
 
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
-	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	struct qcom_wcnss *wcnss = rproc->priv;
 	int ret;
 
 	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
@@ -227,7 +227,7 @@ static void wcnss_configure_iris(struct qcom_wcnss *wcnss)
 
 static int wcnss_start(struct rproc *rproc)
 {
-	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	struct qcom_wcnss *wcnss = rproc->priv;
 	int ret, i;
 
 	mutex_lock(&wcnss->iris_lock);
@@ -293,7 +293,7 @@ static int wcnss_start(struct rproc *rproc)
 
 static int wcnss_stop(struct rproc *rproc)
 {
-	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	struct qcom_wcnss *wcnss = rproc->priv;
 	int ret;
 
 	if (wcnss->state) {
@@ -320,7 +320,7 @@ static int wcnss_stop(struct rproc *rproc)
 
 static void *wcnss_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
-	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	struct qcom_wcnss *wcnss = rproc->priv;
 	int offset;
 
 	offset = da - wcnss->mem_reloc;
@@ -566,7 +566,7 @@ static int wcnss_probe(struct platform_device *pdev)
 	}
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
-	wcnss = (struct qcom_wcnss *)rproc->priv;
+	wcnss = rproc->priv;
 	wcnss->dev = &pdev->dev;
 	wcnss->rproc = rproc;
 	platform_set_drvdata(pdev, wcnss);
diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 2db57d394155..5dbc12bdc29e 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -242,7 +242,7 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 	struct reserved_mem *rmem;
 	int i, num_mem_regions;
 
-	r5_core = (struct zynqmp_r5_core *)rproc->priv;
+	r5_core = rproc->priv;
 	num_mem_regions = r5_core->rmem_count;
 
 	for (i = 0; i < num_mem_regions; i++) {
@@ -363,7 +363,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	size_t bank_size;
 	char *bank_name;
 
-	r5_core = (struct zynqmp_r5_core *)rproc->priv;
+	r5_core = rproc->priv;
 	dev = r5_core->dev;
 	num_banks = r5_core->tcm_bank_count;
 
@@ -432,7 +432,7 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	u32 pm_domain_id;
 	char *bank_name;
 
-	r5_core = (struct zynqmp_r5_core *)rproc->priv;
+	r5_core = rproc->priv;
 	dev = r5_core->dev;
 
 	/* Go through zynqmp banks for r5 node */
@@ -502,7 +502,7 @@ static int add_tcm_banks(struct rproc *rproc)
 	struct zynqmp_r5_core *r5_core;
 	struct device *dev;
 
-	r5_core = (struct zynqmp_r5_core *)rproc->priv;
+	r5_core = rproc->priv;
 	if (!r5_core)
 		return -EINVAL;
 
@@ -595,7 +595,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 	u32 pm_domain_id;
 	int i;
 
-	r5_core = (struct zynqmp_r5_core *)rproc->priv;
+	r5_core = rproc->priv;
 
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
@@ -649,7 +649,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	}
 
 	r5_rproc->auto_boot = false;
-	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
+	r5_core = r5_rproc->priv;
 	r5_core->dev = cdev;
 	r5_core->np = dev_of_node(cdev);
 	if (!r5_core->np) {
@@ -978,12 +978,12 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 
 static void zynqmp_r5_cluster_exit(void *data)
 {
-	struct platform_device *pdev = (struct platform_device *)data;
+	struct platform_device *pdev = data;
 	struct zynqmp_r5_cluster *cluster;
 	struct zynqmp_r5_core *r5_core;
 	int i;
 
-	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
+	cluster = platform_get_drvdata(pdev);
 	if (!cluster)
 		return;
 
-- 
2.11.0

