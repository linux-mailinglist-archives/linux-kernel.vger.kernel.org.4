Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145796A60E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjB1VEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1VEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:04:05 -0500
Received: from outbound.mail.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E154449D;
        Tue, 28 Feb 2023 13:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqHT3vcVQoKYWjumlOQ9lDSbkC0iXbOY3mHRlUrnlRkV2E6GFALy/qKdo7Fef5rWGJxnK28O/Vy9d1NClPF9h91ttSs6hFTCI0RqxK8Pw/uBACM5k8/qEzUcvSGs4lz49Mc/yku5tR/ADHl1ZOYqzjNKpc0wQ2KL0udidRkleCLTj6QpDvKYNVha/GKGekv02WnKcInecC9pc5zEbeHZS/mP4UPKq0kXRcBVvZJJB3BBbXJpZzvHLNL2jpOKUZoh/WaYNmd2fPynxxohMJyygizM0yYsg+S0AXrxMerT6o190eVLGzixIyr2AgsrS8epTwNqIBNgwIMM+QDrpOvahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxwlWXOooBFl8B1lTIGYMMLzVp5Ju0ytT94PSyoReNc=;
 b=Qwr+gk00pyp5wW19KiQ1rEgXO8XcnR2p92OmB/M5cvf69YhM4k53CwivthOPAqrDHmMxXpFNt+3Y2PCGba/K6Vzt18R0cQUpgxMCpspalXK3pkyge9NGh1nTE/lhpiZmK+fR4Z5ud65N0YMJhHHjcXlFLUnJixaDPc0ZSgrIEQRYGa2bq0nX5tUR+dEQQhcFE9DsWLiGrvH2q2y7VTuAHxZ99YgcUEjgB1+gc3ino1nCZD3BmzKDjj6nsiH9pkm1jTfIUWdg2+wu754R95F2dkRonbpHVsWg9yL0E9AIiYgwFT79TnclL6GUUiKkln6Cu6rfSpLGx9e6tgdqBkEvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxwlWXOooBFl8B1lTIGYMMLzVp5Ju0ytT94PSyoReNc=;
 b=gV+nIDp0MRXbmv/wFaCbvLeL4yo+pvnYuTWhohCqPPdExZ3zNfss4BeTPPE6BPrYl8qAJ6ZGMzXlS+fQTztV/5fk6hPS1+EFgZCePXpHZJzwqBwiNXfEceH7axnjG2bZWTypOeTRtHpkAvX+fW7GpGV5BBuzggtZhHc4BgOvo6I=
Received: from MN2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:208:23e::13)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Tue, 28 Feb 2023 21:02:54 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::46) by MN2PR14CA0008.outlook.office365.com
 (2603:10b6:208:23e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 21:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Tue, 28 Feb 2023 21:02:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 15:02:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 13:02:24 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 15:02:24 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 4/5] drivers: remoteproc: xilinx: fix carveout names
Date:   Tue, 28 Feb 2023 13:02:15 -0800
Message-ID: <20230228210216.447373-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228210216.447373-1-tanmay.shah@amd.com>
References: <20230228210216.447373-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d2639b-12d4-4880-02fe-08db19cf2987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lR6BE5+pnGv8JcHlBB6RI+xhCJHPqKLG9GR5ZxQ/HpFocI1wf3spUvf3iTExvKW+gvidifcnvSeK6jhR86ZEqOtqmVP6naVPLtaF0MCcm74+eTpAHG32F37s/4wMPJuf6e1ZdKo1F1dOHiQ1cj2lulQuUyQOHcxIUSGDKWUnqIVbKVlKiQJmZt4ot7WdUp0VfHMIA4vOunFLzRwizEeEPV7IK3dTn0UWZDW8X3ksCdmDv5JJCv194ItUmhvd8NY5n3gYdV3KRrPPyIOOtQOrl/vPSfPJkVXUIJGofd9YOkAsd+D62onrD2XqTw4pY3Fs9zD6zKooyhQs5bs7PUrAhyXC67mpJw7TLeYmThHUTA3eAfYajjVPwygDPQafNV+36lLTNIrRNwMQp9wp458Amyxhr5dkXL2kmxLWyzzUG+JH8HGLJvxLdLzxE3phT1+ZKWvXnN3dHR9uZ9rZfwl9a6fvY2XgoJ7s2oz5yMT5f6rZ9DNC0jm1sq6ZhhjbTyHpvTTu1Smwf5DUrCnz/BF3ByyCHiyx821fLcGjNe6pAnyZ9EM9dxsnex1/TQN2f4+TRiC9EajrWxruK5QQqxAV3l/oZIftKREbKOD7zWZnids1AweQ2AQG6w4uMFoR/j5SD1iFwXL/Q/cOG85hhTI1M3YuVcUPO9nTpSV/Nub1v+keCOmkvTd9oJmHzlmshf6szooVcbXDMQ51ydzn4qWa+u42X85Mkg5vxDtoN4gHoKE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(86362001)(70206006)(40480700001)(41300700001)(8936002)(5660300002)(8676002)(44832011)(2906002)(356005)(36860700001)(82740400003)(81166007)(4326008)(6666004)(54906003)(6636002)(478600001)(316002)(70586007)(82310400005)(40460700003)(83380400001)(47076005)(110136005)(186003)(426003)(2616005)(336012)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:02:54.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d2639b-12d4-4880-02fe-08db19cf2987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v4:
  - use of_phandle_iterator_next to get memory-region nodes

Changes in v3:
  - split patch and add fixes tag
  - fix memory-region carveout names

 drivers/remoteproc/xlnx_r5_remoteproc.c | 90 ++++++-------------------
 1 file changed, 20 insertions(+), 70 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 2db57d394155..5dd007622603 100644
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
@@ -239,21 +235,29 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 {
 	struct rproc_mem_entry *rproc_mem;
 	struct zynqmp_r5_core *r5_core;
+	struct of_phandle_iterator it;
 	struct reserved_mem *rmem;
-	int i, num_mem_regions;
+	int i = 0;
 
 	r5_core = (struct zynqmp_r5_core *)rproc->priv;
-	num_mem_regions = r5_core->rmem_count;
 
-	for (i = 0; i < num_mem_regions; i++) {
-		rmem = r5_core->rmem[i];
+	/* Register associated reserved memory regions */
+	of_phandle_iterator_init(&it, r5_core->np, "memory-region", NULL, 0);
 
-		if (!strncmp(rmem->name, "vdev0buffer", strlen("vdev0buffer"))) {
+	while (of_phandle_iterator_next(&it) == 0) {
+		rmem = of_reserved_mem_lookup(it.node);
+		if (!rmem) {
+			of_node_put(it.node);
+			dev_err(&rproc->dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+
+		if (!strcmp(it.node->name, "vdev0buffer")) {
 			/* Init reserved memory for vdev buffer */
 			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
 								 rmem->size,
 								 rmem->base,
-								 rmem->name);
+								 it.node->name);
 		} else {
 			/* Register associated reserved memory regions */
 			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
@@ -261,16 +265,19 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 							 rmem->size, rmem->base,
 							 zynqmp_r5_mem_region_map,
 							 zynqmp_r5_mem_region_unmap,
-							 rmem->name);
+							 it.node->name);
 		}
 
-		if (!rproc_mem)
+		if (!rproc_mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, rproc_mem);
 
 		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
-			rmem->name, rmem->base, rmem->size);
+			it.node->name, rmem->base, rmem->size);
+		i++;
 	}
 
 	return 0;
@@ -726,59 +733,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
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
@@ -806,10 +760,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
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

