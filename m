Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3345E6B4D03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCJQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCJQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:29:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55812C80E;
        Fri, 10 Mar 2023 08:25:54 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AGPlF5129735;
        Fri, 10 Mar 2023 10:25:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678465547;
        bh=q+8Yl/6InXdDAnhHvdi1hjsTSt6lHYD86fu2XQzRTyw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cvom2RRwBDW/ek2zKD2qZOI15lTNgbF9R607biR92A47wnlC0A+oaOmabvAEKyb4u
         Ay7JSrEEODWg2s55CdH0lHc62+SOFRmD2vBfLDkV2lA7xaq6YKl28npb20tRILtKjN
         9pijGnWuVuyysKjfG5POBnYGiUvuMel7DYzhyaj0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AGPlEf002512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 10:25:47 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 10:25:46 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 10:25:46 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AGPk58031095;
        Fri, 10 Mar 2023 10:25:46 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v7 1/3] remoteproc: k3-r5: Simplify cluster mode setting usage
Date:   Fri, 10 Mar 2023 21:55:42 +0530
Message-ID: <20230310162544.3468365-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310162544.3468365-1-devarsht@ti.com>
References: <20230310162544.3468365-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 57 +++++++++++++-----------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 0481926c6975..c2ec0f432921 100644
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
@@ -1700,12 +1695,6 @@ static int k3_r5_probe(struct platform_device *pdev)
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
 
@@ -1716,6 +1705,20 @@ static int k3_r5_probe(struct platform_device *pdev)
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

