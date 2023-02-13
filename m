Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9334A6952ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBMVTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjBMVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:19:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941931EFEC;
        Mon, 13 Feb 2023 13:19:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut2TRBBJ1x8biSwS4XfxDGJnEG5b1GHBLwnfVBHovI0Y/qCiGvjxmsYecJ3jKqoorPPYls6B4YN4nQthwj+ZLrZ44YnWxaQb+TXzx1cNVdsPBtGxjpxG1TopJOvDVdRepu3Ms4ULtIXlUIzjkVGmRB2iTuvFwyxUM133ilhvFb32HxRmZC2Wl82+t9Z6V4j2DWQQgCbaCVEXDFdMOcsA/kUc3iLeaMdYKhfd7pA1ItqxgzZVSViIAeTCKknW8dYDlMBARhD3hZXZD4HmWPzDQZvR/vAQVCO/bLKTGNDVkgLWIe4UfWpMI82HuRXGu77GizZt+VuxTHIbBD38vxf3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U730ZNKaXlQrp/qwV/UMY6SyptWLyLa942t+MsaPtws=;
 b=Y5Dkw5nWvhZuDIdFWWJWSM7PsCUxN/o0x+NPClKv/6cJbIc+k9WucNSs2KutY/GAJ1qPl0b7HySsnqBVMzZs35G7Jaw4C2xuzooBT+g+/jmWbHxfeJjck0PGppPsEdyZt6uvksKz/i03zrHlTnvhPSJZLUjv/DAeSXKwS/nXBstIDVRfrED5/5m/Qyp+Sv8xQhGA8d084NUBLfkPwUs8ZvWbEpsGMPm8pqRr3+bnTufYk827wPUAdXe4dd8w7jNNg5w9GivUMlKC3gtnCGzoTzCIL/geIu6vLFuEJwivE8s/M2LVkSzvHapphmYOxHBa5zLeh/R+QVMguvRcJJXjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U730ZNKaXlQrp/qwV/UMY6SyptWLyLa942t+MsaPtws=;
 b=mTyBkEOiiQnOFobZRvXtCI2STP5Q0nz3rU7gCaKoFVoemd5BhsUSrJoGdGEajAP/1mZzLtwTZsRYe2Cq7ULDXRASVTHvNkkxZs6XDxQEUmVAA5tq8DXiHRTXciq1nCYRpFEGX+hJVbsuRc7RdUbY65MxAWr3qYlc37u4FTmbz5I=
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 21:18:54 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::dc) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 21:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 21:18:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:52 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Feb 2023 15:18:51 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 2/3] drivers: remoteproc: xilinx: fix carveout names
Date:   Mon, 13 Feb 2023 13:18:25 -0800
Message-ID: <20230213211825.3507034-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213211825.3507034-1-tanmay.shah@amd.com>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a28862a-be09-4d4a-efa8-08db0e07e935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOuWHyn9URXpbjxobJAxm2TNOl6tlWUqVQyx0lzHlALG1KngE0MBnSXSG4X4808Ex9HBAKQcFVacvvjNNZG9/eElyPFSHyv/YM4mWzi4FPEmBG8T8xggexWW/E3zGCdVJTEkre3gZ0uHN5ZzROumlbokC6YsO/jmyubu98wFOyHkgnMiv1b1UmTIiQ84BO6ZfYcm5ZCVJ8mbPQKFB2smSqQlgQ061unCZqjT2jliJi8WYOYYax4iHC5wVb/uRTfk7qOeGLFIDo8rM1lGwICU660WB2xHInN+4frL0xbghF/5OdIxFGTFhQTQOvhWh19jTjJca4MJ9XGZzgHSF+dKsnr4MEEpQEOXc2fmlBTPdISB7C1fMFVXNV5LCLN3FYVfL86isY5Cw7vmmo+uyaeD7r/Sp3PsM/KMSRHwkB4IriYusVYwd5EARf51RtM6dCnj6Aa/23BlUoka7h5fphpjJ2hb5L2MapPkUBFjlr2YmR9bvHCdjoL56shoaxHRUnSE0tXODbEXGwa/y3ViBUyeoMeH1q5PgPg1pbqriYk85k5nmWQrUvn/dJA1+TK8dvR1vGavRSoHrvvFet/PynJ7e9KnjiS2CSGEbMWz6wV82ckAkmYeVUkOShMlWCViaKQJDXvLmhz4QtPoLXFXyckQ+jnUkSelK93NABTnHcJPyK7wIZV3SIxFxAaPuDvpsjK2ZdTRwkP1c8M6RC+xA+ghbHd1nYeWw5+vh8hpRZfjhLlz2M+8JFe1angiJWG6PzY4CYs8D2RnHOzjot4koUb5aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(186003)(26005)(6666004)(478600001)(336012)(966005)(70586007)(70206006)(4326008)(8676002)(2616005)(54906003)(6636002)(1076003)(316002)(110136005)(83380400001)(5660300002)(41300700001)(44832011)(8936002)(36860700001)(82740400003)(2906002)(356005)(81166007)(86362001)(36756003)(82310400005)(426003)(47076005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:18:54.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a28862a-be09-4d4a-efa8-08db0e07e935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the unit address is appended to node name of memory-region,
then adding rproc carveouts fails as node name and unit-address
both are passed as carveout name (i.e. vdev0vring0@xxxxxxxx). However,
only node name is expected by remoteproc framework. This patch moves
memory-region node parsing from driver probe to prepare and
only passes node-name and not unit-address

Fixes: 6b291e8020a8 ("drivers: remoteproc: Add Xilinx r5 remoteproc driver")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changelog:
  - This is first version of this change, however posting as part of the series
    that has version v3. The v2 of the series could be found at following link.

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/

 drivers/remoteproc/xlnx_r5_remoteproc.c | 87 ++++++-------------------
 1 file changed, 20 insertions(+), 67 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 2db57d394155..81af2dea56c2 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -61,8 +61,6 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
  * @np: device node of RPU instance
  * @tcm_bank_count: number TCM banks accessible to this RPU
  * @tcm_banks: array of each TCM bank data
- * @rmem_count: Number of reserved mem regions
- * @rmem: reserved memory region nodes from device tree
  * @rproc: rproc handle
  * @pm_domain_id: RPU CPU power domain id
  */
@@ -71,8 +69,6 @@ struct zynqmp_r5_core {
 	struct device_node *np;
 	int tcm_bank_count;
 	struct mem_bank_data **tcm_banks;
-	int rmem_count;
-	struct reserved_mem **rmem;
 	struct rproc *rproc;
 	u32 pm_domain_id;
 };
@@ -239,21 +235,31 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 {
 	struct rproc_mem_entry *rproc_mem;
 	struct zynqmp_r5_core *r5_core;
+	struct device_node *rmem_np;
 	struct reserved_mem *rmem;
 	int i, num_mem_regions;
 
 	r5_core = (struct zynqmp_r5_core *)rproc->priv;
-	num_mem_regions = r5_core->rmem_count;
+
+	num_mem_regions = of_property_count_elems_of_size(r5_core->np, "memory-region",
+							  sizeof(phandle));
 
 	for (i = 0; i < num_mem_regions; i++) {
-		rmem = r5_core->rmem[i];
 
-		if (!strncmp(rmem->name, "vdev0buffer", strlen("vdev0buffer"))) {
+		rmem_np = of_parse_phandle(r5_core->np, "memory-region", i);
+
+		rmem = of_reserved_mem_lookup(rmem_np);
+		if (!rmem) {
+			of_node_put(rmem_np);
+			return -EINVAL;
+		}
+
+		if (!strcmp(rmem_np->name, "vdev0buffer")) {
 			/* Init reserved memory for vdev buffer */
 			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
 								 rmem->size,
 								 rmem->base,
-								 rmem->name);
+								 rmem_np->name);
 		} else {
 			/* Register associated reserved memory regions */
 			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
@@ -261,16 +267,20 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 							 rmem->size, rmem->base,
 							 zynqmp_r5_mem_region_map,
 							 zynqmp_r5_mem_region_unmap,
-							 rmem->name);
+							 rmem_np->name);
 		}
 
-		if (!rproc_mem)
+		if (!rproc_mem) {
+			of_node_put(rmem_np);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, rproc_mem);
 
 		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
 			rmem->name, rmem->base, rmem->size);
+
+		of_node_put(rmem_np);
 	}
 
 	return 0;
@@ -726,59 +736,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
 	return 0;
 }
 
-/**
- * zynqmp_r5_get_mem_region_node()
- * parse memory-region property and get reserved mem regions
- *
- * @r5_core: pointer to zynqmp_r5_core type object
- *
- * Return: 0 for success and error code for failure.
- */
-static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
-{
-	struct device_node *np, *rmem_np;
-	struct reserved_mem **rmem;
-	int res_mem_count, i;
-	struct device *dev;
-
-	dev = r5_core->dev;
-	np = r5_core->np;
-
-	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
-							sizeof(phandle));
-	if (res_mem_count <= 0) {
-		dev_warn(dev, "failed to get memory-region property %d\n",
-			 res_mem_count);
-		return 0;
-	}
-
-	rmem = devm_kcalloc(dev, res_mem_count,
-			    sizeof(struct reserved_mem *), GFP_KERNEL);
-	if (!rmem)
-		return -ENOMEM;
-
-	for (i = 0; i < res_mem_count; i++) {
-		rmem_np = of_parse_phandle(np, "memory-region", i);
-		if (!rmem_np)
-			goto release_rmem;
-
-		rmem[i] = of_reserved_mem_lookup(rmem_np);
-		if (!rmem[i]) {
-			of_node_put(rmem_np);
-			goto release_rmem;
-		}
-
-		of_node_put(rmem_np);
-	}
-
-	r5_core->rmem_count = res_mem_count;
-	r5_core->rmem = rmem;
-	return 0;
-
-release_rmem:
-	return -EINVAL;
-}
-
 /*
  * zynqmp_r5_core_init()
  * Create and initialize zynqmp_r5_core type object
@@ -806,10 +763,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
 
-		ret = zynqmp_r5_get_mem_region_node(r5_core);
-		if (ret)
-			dev_warn(dev, "memory-region prop failed %d\n", ret);
-
 		/* Initialize r5 cores with power-domains parsed from dts */
 		ret = of_property_read_u32_index(r5_core->np, "power-domains",
 						 1, &r5_core->pm_domain_id);
-- 
2.25.1

