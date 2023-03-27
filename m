Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80C16CA8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjC0P2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjC0P2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:28:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBC11D;
        Mon, 27 Mar 2023 08:28:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSZ8K024960;
        Mon, 27 Mar 2023 10:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679930915;
        bh=M/QhegHV0Q4kDE/iTuCWgzgOGM693VqyfQk/DupvKQI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d1D9Hr7zsZMCGbvF8b62oooRexFEgvfpARIVyKUuz5Vi5zvSQK45VSCkIwqxbxI2Q
         QQW7doJxTs7cUUii24hP/bByYEHgqZvsmyKQdvsLKFrCdGUKS3ui+7xNuEtJxUGk1d
         eQHOty25u/2EvgDkMNiaupR48UnAjz+xJkMVjQ/g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RFSZ26008974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:28:35 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:28:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:28:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSYWC004003;
        Mon, 27 Mar 2023 10:28:34 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v8 1/3] remoteproc: k3-r5: Simplify cluster mode setting usage
Date:   Mon, 27 Mar 2023 20:58:30 +0530
Message-ID: <20230327152832.923480-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327152832.923480-1-devarsht@ti.com>
References: <20230327152832.923480-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the validity of mode against SoC supported modes right
at the probe to minimize the usage of same check further in the code.

Set default value of cluster-mode only if cluster-mode device tree property
is empty.

In case devicetree provided cluster-mode property is invalid For e.g. using
CLUSTER_MODE_SINGLECPU on any SoC other than am64x then return error.

If firmware has set the PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY flag then
what it means is that only CLUSTER_MODE_SINGLECPU is possible to use [1]
and hence there is no need to check for soc_data->single_cpu_mode first and
then checking cluster mode.

PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE flag can be set directly for
CLUSTER_MODE_SINGLECPU without checking for soc_data->single_cpu_mode since
that check has already been done during probe.

For IPC-only mode, directly override cluster mode as per config flag set by
bootloader without checking for soc specific data. This because config
flag would already have been validated by firmware when bootloader was
setting it.

Link:
[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/PROC_BOOT.html?highlight=singlecore_only#arm-r5

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V1->V6: No changelog (Patch introduced in V6)
V6->V7:
- Override to appropriate cluster mode per firmware status flag directly
  without checking for soc_data
- Set appropriate mode as default if not provided in DT
- Check mode validity against SoC data during probe
- Rebase on top of 6.3 linux-next
V7->V8:
- Override cluster mode without using soc_data for IPC only mode as
  suggested in review
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 76 +++++++++++++-----------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 0481926c6975..fd035a83c816 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -852,38 +852,33 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
 	dev_dbg(dev, "boot_vector = 0x%llx, cfg = 0x%x ctrl = 0x%x stat = 0x%x\n",
 		boot_vec, cfg, ctrl, stat);
 
-	/* check if only Single-CPU mode is supported on applicable SoCs */
-	if (cluster->soc_data->single_cpu_mode) {
-		single_cpu =
-			!!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
-		if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
-			dev_err(cluster->dev, "split-mode not permitted, force configuring for single-cpu mode\n");
-			cluster->mode = CLUSTER_MODE_SINGLECPU;
-		}
-		goto config;
+	single_cpu = !!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
+	lockstep_en = !!(stat & PROC_BOOT_STATUS_FLAG_R5_LOCKSTEP_PERMITTED);
+
+	/* Override to single CPU mode if set in status flag */
+	if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
+		dev_err(cluster->dev, "split-mode not permitted, force configuring for single-cpu mode\n");
+		cluster->mode = CLUSTER_MODE_SINGLECPU;
 	}
 
-	/* check conventional LockStep vs Split mode configuration */
-	lockstep_en = !!(stat & PROC_BOOT_STATUS_FLAG_R5_LOCKSTEP_PERMITTED);
+	/* Override to split mode if lockstep enable bit is not set in status flag */
 	if (!lockstep_en && cluster->mode == CLUSTER_MODE_LOCKSTEP) {
 		dev_err(cluster->dev, "lockstep mode not permitted, force configuring for split-mode\n");
 		cluster->mode = CLUSTER_MODE_SPLIT;
 	}
 
-config:
 	/* always enable ARM mode and set boot vector to 0 */
 	boot_vec = 0x0;
 	if (core == core0) {
 		clr_cfg = PROC_BOOT_CFG_FLAG_R5_TEINIT;
-		if (cluster->soc_data->single_cpu_mode) {
-			/*
-			 * Single-CPU configuration bit can only be configured
-			 * on Core0 and system firmware will NACK any requests
-			 * with the bit configured, so program it only on
-			 * permitted cores
-			 */
-			if (cluster->mode == CLUSTER_MODE_SINGLECPU)
-				set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
+		/*
+		 * Single-CPU configuration bit can only be configured
+		 * on Core0 and system firmware will NACK any requests
+		 * with the bit configured, so program it only on
+		 * permitted cores
+		 */
+		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
+			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
 		} else {
 			/*
 			 * LockStep configuration bit is Read-only on Split-mode
@@ -1108,12 +1103,12 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 	struct k3_r5_cluster *cluster = kproc->cluster;
 	struct k3_r5_core *core = kproc->core;
 	struct device *cdev = core->dev;
-	bool r_state = false, c_state = false;
+	bool r_state = false, c_state = false, lockstep_en = false, single_cpu = false;
 	u32 ctrl = 0, cfg = 0, stat = 0, halted = 0;
 	u64 boot_vec = 0;
 	u32 atcm_enable, btcm_enable, loczrama;
 	struct k3_r5_core *core0;
-	enum cluster_mode mode;
+	enum cluster_mode mode = cluster->mode;
 	int ret;
 
 	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
@@ -1147,13 +1142,14 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
 	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
 	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
-	if (cluster->soc_data->single_cpu_mode) {
-		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
-				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
-	} else {
-		mode = cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP ?
-				CLUSTER_MODE_LOCKSTEP : CLUSTER_MODE_SPLIT;
-	}
+	single_cpu = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ? 1 : 0;
+	lockstep_en = cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP ? 1 : 0;
+
+	if (single_cpu)
+		mode = CLUSTER_MODE_SINGLECPU;
+	if (lockstep_en)
+		mode = CLUSTER_MODE_LOCKSTEP;
+
 	halted = ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT;
 
 	/*
@@ -1700,12 +1696,6 @@ static int k3_r5_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	cluster->dev = dev;
-	/*
-	 * default to most common efuse configurations - Split-mode on AM64x
-	 * and LockStep-mode on all others
-	 */
-	cluster->mode = data->single_cpu_mode ?
-				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
 	cluster->soc_data = data;
 	INIT_LIST_HEAD(&cluster->cores);
 
@@ -1716,6 +1706,20 @@ static int k3_r5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (ret == -EINVAL) {
+		/*
+		 * default to most common efuse configurations - Split-mode on AM64x
+		 * and LockStep-mode on all others
+		 */
+		cluster->mode = data->single_cpu_mode ?
+					CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
+	}
+
+	if (cluster->mode == CLUSTER_MODE_SINGLECPU && !data->single_cpu_mode) {
+		dev_err(dev, "Cluster mode = %d is not supported on this SoC\n", cluster->mode);
+		return -EINVAL;
+	}
+
 	num_cores = of_get_available_child_count(np);
 	if (num_cores != 2) {
 		dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
-- 
2.34.1

