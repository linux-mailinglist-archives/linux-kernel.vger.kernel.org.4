Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133006CA8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjC0P3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjC0P2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:28:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3940D8;
        Mon, 27 Mar 2023 08:28:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RFScIE120981;
        Mon, 27 Mar 2023 10:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679930918;
        bh=zt3pOWn9K5Wouelw0ko0yLSeUY0SgQ9GcrAN3rMCXzU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tVHSk+Diiql53fZa931llJW1Ufy2EAt/ELwjZmLVuV+RPMRrEdJAR6GdDATaLGNPT
         7incKNj2rJ2vAHblYUOOMrykyyTj0SqsuPLknb2P4hr3oh29gXPHsUfV1P6/CN2+YD
         dGEd8yNWXkMfhv7Ajsul2ClvXEA82CRAVX7hvmMI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RFScei098698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:28:38 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:28:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:28:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSbud044504;
        Mon, 27 Mar 2023 10:28:37 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v8 3/3] remoteproc: k3-r5: Use separate compatible string for TI AM62x SoC family
Date:   Mon, 27 Mar 2023 20:58:32 +0530
Message-ID: <20230327152832.923480-4-devarsht@ti.com>
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

AM62 and AM62A SoCs use single core R5F which is a new scenario
different than the one being used with CLUSTER_MODE_SINGLECPU which is
for utilizing a single core from a set of cores available in R5F cluster
present in the SoC.

To support this single core scenario map it with newly defined
CLUSTER_MODE_SINGLECORE and use it when compatible is set to
ti,am62-r5fss.

Also set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE config for
CLUSTER_MODE_SINGLECORE too as it is required by R5 core when it is
being as general purpose core instead of device manager.

For IPC-only mode when config flag PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE
is set, skip overriding to CLUSTER_MODE_SINGLECPU when
CLUSTER_MODE_SINGLECORE is set as same flag is applicable for single
core configuration too.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2:
- Fix indentation and ordering issues as per review comments
V3:
- Change CLUSTER_MODE_NONE value to -1
V4:
- No change
V5:
- No change (fixing typo in email address)
V6:
   - Use CLUSTER_MODE_SINGLECORE for AM62x
   - Set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE for single core.
V7:
   - Simplify and rebase on top of base commit "[PATCH v7] remoteproc: k3-r5: Simplify cluster
     mode setting"
V8:
   - Rebase on top of base commit "[PATCH v8] remoteproc: k3-r5: Simplify
     cluster mode setting"

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 59 +++++++++++++++++++-----
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index fd035a83c816..23fe44d4d7a5 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -71,14 +71,16 @@ struct k3_r5_mem {
 /*
  * All cluster mode values are not applicable on all SoCs. The following
  * are the modes supported on various SoCs:
- *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
- *   LockStep mode   : AM65x, J721E and J7200 SoCs
- *   Single-CPU mode : AM64x SoCs only
+ *   Split mode       : AM65x, J721E, J7200 and AM64x SoCs
+ *   LockStep mode    : AM65x, J721E and J7200 SoCs
+ *   Single-CPU mode  : AM64x SoCs only
+ *   Single-Core mode : AM62x, AM62A SoCs
  */
 enum cluster_mode {
 	CLUSTER_MODE_SPLIT = 0,
 	CLUSTER_MODE_LOCKSTEP,
 	CLUSTER_MODE_SINGLECPU,
+	CLUSTER_MODE_SINGLECORE
 };
 
 /**
@@ -86,11 +88,13 @@ enum cluster_mode {
  * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
  * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
  * @single_cpu_mode: flag to denote if SoC/IP supports Single-CPU mode
+ * @is_single_core: flag to denote if SoC/IP has only single core R5
  */
 struct k3_r5_soc_data {
 	bool tcm_is_double;
 	bool tcm_ecc_autoinit;
 	bool single_cpu_mode;
+	bool is_single_core;
 };
 
 /**
@@ -838,7 +842,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
 
 	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
 	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
-	    cluster->mode == CLUSTER_MODE_SINGLECPU) {
+	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
+	    cluster->mode == CLUSTER_MODE_SINGLECORE) {
 		core = core0;
 	} else {
 		core = kproc->core;
@@ -877,7 +882,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
 		 * with the bit configured, so program it only on
 		 * permitted cores
 		 */
-		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
+		if (cluster->mode == CLUSTER_MODE_SINGLECPU ||
+		    cluster->mode == CLUSTER_MODE_SINGLECORE) {
 			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
 		} else {
 			/*
@@ -1069,6 +1075,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
 
 	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
 	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
+	    cluster->mode == CLUSTER_MODE_SINGLECORE ||
 	    !cluster->soc_data->tcm_is_double)
 		return;
 
@@ -1145,7 +1152,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 	single_cpu = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ? 1 : 0;
 	lockstep_en = cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP ? 1 : 0;
 
-	if (single_cpu)
+	if (single_cpu && mode != CLUSTER_MODE_SINGLECORE)
 		mode = CLUSTER_MODE_SINGLECPU;
 	if (lockstep_en)
 		mode = CLUSTER_MODE_LOCKSTEP;
@@ -1265,9 +1272,12 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 			goto err_add;
 		}
 
-		/* create only one rproc in lockstep mode or single-cpu mode */
+		/* create only one rproc in lockstep, single-cpu or
+		 * single core mode
+		 */
 		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
-		    cluster->mode == CLUSTER_MODE_SINGLECPU)
+		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
+		    cluster->mode == CLUSTER_MODE_SINGLECORE)
 			break;
 	}
 
@@ -1710,19 +1720,33 @@ static int k3_r5_probe(struct platform_device *pdev)
 		/*
 		 * default to most common efuse configurations - Split-mode on AM64x
 		 * and LockStep-mode on all others
+		 * default to most common efuse configurations -
+		 * Split-mode on AM64x
+		 * Single core on AM62x
+		 * LockStep-mode on all others
 		 */
-		cluster->mode = data->single_cpu_mode ?
+		if (!data->is_single_core)
+			cluster->mode = data->single_cpu_mode ?
 					CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
+		else
+			cluster->mode = CLUSTER_MODE_SINGLECORE;
 	}
 
-	if (cluster->mode == CLUSTER_MODE_SINGLECPU && !data->single_cpu_mode) {
+	if  ((cluster->mode == CLUSTER_MODE_SINGLECPU && !data->single_cpu_mode) ||
+	     (cluster->mode == CLUSTER_MODE_SINGLECORE && !data->is_single_core)) {
 		dev_err(dev, "Cluster mode = %d is not supported on this SoC\n", cluster->mode);
 		return -EINVAL;
 	}
 
 	num_cores = of_get_available_child_count(np);
-	if (num_cores != 2) {
-		dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
+	if (num_cores != 2 && !data->is_single_core) {
+		dev_err(dev, "MCU cluster requires both R5F cores to be enabled but num_cores is set to = %d\n",
+			num_cores);
+		return -ENODEV;
+	}
+
+	if (num_cores != 1 && data->is_single_core) {
+		dev_err(dev, "SoC supports only single core R5 but num_cores is set to %d\n",
 			num_cores);
 		return -ENODEV;
 	}
@@ -1764,18 +1788,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
 	.tcm_is_double = false,
 	.tcm_ecc_autoinit = false,
 	.single_cpu_mode = false,
+	.is_single_core = false,
 };
 
 static const struct k3_r5_soc_data j7200_j721s2_soc_data = {
 	.tcm_is_double = true,
 	.tcm_ecc_autoinit = true,
 	.single_cpu_mode = false,
+	.is_single_core = false,
 };
 
 static const struct k3_r5_soc_data am64_soc_data = {
 	.tcm_is_double = true,
 	.tcm_ecc_autoinit = true,
 	.single_cpu_mode = true,
+	.is_single_core = false,
+};
+
+static const struct k3_r5_soc_data am62_soc_data = {
+	.tcm_is_double = false,
+	.tcm_ecc_autoinit = true,
+	.single_cpu_mode = false,
+	.is_single_core = true,
 };
 
 static const struct of_device_id k3_r5_of_match[] = {
@@ -1783,6 +1817,7 @@ static const struct of_device_id k3_r5_of_match[] = {
 	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
 	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
 	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
+	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
 	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
 	{ /* sentinel */ },
 };
-- 
2.34.1

