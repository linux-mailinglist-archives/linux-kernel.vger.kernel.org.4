Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E265656C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiL0Owf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiL0Ow2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:52:28 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0CD6D;
        Tue, 27 Dec 2022 06:52:26 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BREqLCO090278;
        Tue, 27 Dec 2022 08:52:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672152741;
        bh=RcSGEFcVj7pv+eLNj/KmSgYTFlVzg3/GloZZFkQeE5o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TLVQEMAOZzPykaw3yj6H7v8u7o37sn3Yr4IyAWRihXEaCX58N1b+odTe3nQPeOpjq
         jMdiDkkPVIhr+d2ab5aQDHau9K36qzRvl4D+KN6fRrNAVQ6zN8vmb8JQEUgcM9SmUb
         Lvdip8H2adBxNhrkCA3eYdSLro2MHse+LU9CDokg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BREqL6I019929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Dec 2022 08:52:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 08:52:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 08:52:20 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BREqKij071038;
        Tue, 27 Dec 2022 08:52:20 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v5 2/2] remoteproc: k3-r5: Use separate compatible string for TI AM62 SoC family
Date:   Tue, 27 Dec 2022 20:22:16 +0530
Message-ID: <20221227145216.1524-3-devarsht@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221227145216.1524-1-devarsht@ti.com>
References: <20221227145216.1524-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 and AM62A SoCs use single core R5F which is a new scenario
different than the one being used with CLUSTER_MODE_SINGLECPU
which is for utilizing a single core from a set of cores available
in R5F cluster present in the SoC.

To support this single core scenario map it with
newly defined CLUSTER_MODE_NONE and use it when
compatible is set to ti,am62-r5fss.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: Fix indentation and ordering issues as per review comments
V3: Change CLUSTER_MODE_NONE value to -1
V4: No change
V5: No change (fixing typo in email address)
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 57 ++++++++++++++++++------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 0481926c6975..127f1f68e592 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -74,9 +74,11 @@ struct k3_r5_mem {
  *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
  *   LockStep mode   : AM65x, J721E and J7200 SoCs
  *   Single-CPU mode : AM64x SoCs only
+ *   None            : AM62x, AM62A SoCs
  */
 enum cluster_mode {
-	CLUSTER_MODE_SPLIT = 0,
+	CLUSTER_MODE_NONE = -1,
+	CLUSTER_MODE_SPLIT,
 	CLUSTER_MODE_LOCKSTEP,
 	CLUSTER_MODE_SINGLECPU,
 };
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
+	    cluster->mode == CLUSTER_MODE_NONE) {
 		core = core0;
 	} else {
 		core = kproc->core;
@@ -853,7 +858,7 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
 		boot_vec, cfg, ctrl, stat);
 
 	/* check if only Single-CPU mode is supported on applicable SoCs */
-	if (cluster->soc_data->single_cpu_mode) {
+	if (cluster->soc_data->single_cpu_mode || cluster->soc_data->is_single_core) {
 		single_cpu =
 			!!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
 		if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
@@ -1074,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
 
 	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
 	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
+	    cluster->mode == CLUSTER_MODE_NONE ||
 	    !cluster->soc_data->tcm_is_double)
 		return;
 
@@ -1147,7 +1153,9 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
 	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
 	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
-	if (cluster->soc_data->single_cpu_mode) {
+	if (cluster->soc_data->is_single_core) {
+		mode = CLUSTER_MODE_NONE;
+	} else if (cluster->soc_data->single_cpu_mode) {
 		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
 				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
 	} else {
@@ -1271,7 +1279,8 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 
 		/* create only one rproc in lockstep mode or single-cpu mode */
 		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
-		    cluster->mode == CLUSTER_MODE_SINGLECPU)
+		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
+		    cluster->mode == CLUSTER_MODE_NONE)
 			break;
 	}
 
@@ -1704,21 +1713,32 @@ static int k3_r5_probe(struct platform_device *pdev)
 	 * default to most common efuse configurations - Split-mode on AM64x
 	 * and LockStep-mode on all others
 	 */
-	cluster->mode = data->single_cpu_mode ?
+	if (!data->is_single_core)
+		cluster->mode = data->single_cpu_mode ?
 				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
+	else
+		cluster->mode = CLUSTER_MODE_NONE;
+
 	cluster->soc_data = data;
 	INIT_LIST_HEAD(&cluster->cores);
 
-	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
-	if (ret < 0 && ret != -EINVAL) {
-		dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n",
-			ret);
-		return ret;
+	if (!data->is_single_core) {
+		ret = of_property_read_s32(np, "ti,cluster-mode", &cluster->mode);
+		if (ret < 0 && ret != -EINVAL) {
+			dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n", ret);
+			return ret;
+		}
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
@@ -1760,18 +1780,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
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
@@ -1779,6 +1809,7 @@ static const struct of_device_id k3_r5_of_match[] = {
 	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
 	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
 	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
+	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
 	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
 	{ /* sentinel */ },
 };
-- 
2.17.1

