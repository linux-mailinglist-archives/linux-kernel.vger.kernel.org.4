Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833026B578D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCKB0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCKBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:25:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412613597D;
        Fri, 10 Mar 2023 17:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojg2vNTPUsqI6kJO82AFdctlUt2cusF4N7Qa87TNp4aE2RvANBqFtT7SxBkMrLbp99aszZQbOu3LPQlc3orS3thmcu5wt60DSm5YR26mV0hVH24BZrXXI25dfodZJyrWlQ5f+4tL5hzX11+q0STTj6NUQ6BRPNxWwzAzWbcV9VfDr6C9MMf4NMFOvqpitwnZ8PdqSBMKFh29+yHlsK2FTsELLJVCfWD49lAMzjQwzLd2P3qcSnjmNG3h1ghDhNkVymyQ5DxnlykPVXzNvn5tmW6OaAUVEV42H5LOe4AShI7j44MrFD1/tzRPiXMyLh9Lp1qlwtpzpzUUTUgoGQxENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vD/2v76EIbGDa4I+aXGLqV/uTqnlSXGZ6+pLfr4jEc=;
 b=a5hh9Ks3qM3LkqPXWqF+MfLuRQIk9KuzMNpXok6yoBOhXlW0oxlEmeexQcFmAEn40a+kMFLxi/MGvYB9QmJMDZj/phXR0wPHz64I9syhSi3vXre6uyoetZ5VusYLqFDbfxubO+ppcjw0NZ2fVtyVkJpFrJwSj7cuVOgVijZZq/Ysk1bvSszAfwk6jHGH89UwsbCCxE2QFDMqhb9GGQNEZR7t5NKIwI/WXiHLhp7ynMFx+oLfZK1dDp/YAYkrDw2CsqYlIUt38/bK4vtIm8M40moEu1Kpl1CpN7KEFKyWe0ziDCQ96Hq4MlKYghgIP88asur1RnAUZ9XskvJTbU59hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vD/2v76EIbGDa4I+aXGLqV/uTqnlSXGZ6+pLfr4jEc=;
 b=CnLom7HykY/6ZX9qvnbWOAsOPyPNX5KxHg0saZ6seT7SIex2//sCGvIWsDtwPCKuoVrhsgtBeJ71swyn6k8jRqKqvClyzvsklIqULLKihYQx/LFk+Xv83hdXt1zOhi9ifgvnJhDhiW+c7ks1zzE+DmKBAqCrX7vvzxNzkqFZ9AA=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 01:24:31 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c3) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22 via Frontend
 Transport; Sat, 11 Mar 2023 01:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sat, 11 Mar 2023 01:24:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 19:24:30 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 Mar 2023 19:24:29 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 4/5] drivers: remoteproc: xilinx: fix carveout names
Date:   Fri, 10 Mar 2023 17:24:07 -0800
Message-ID: <20230311012407.1292118-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230311012407.1292118-1-tanmay.shah@amd.com>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf88c9f-e698-499d-72c0-08db21cf5d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGeNEwQnjCgUyRpROEmZfKdAu945Slp71Q8Bg/D/mf7rEfLRLzyxq+ePzPJp2WG4MVlWSsaASnnaQf4l51PmQhD61yYhgcq2ZM3eGABdR6i9q/p7x0dtT25rGyG2J0upejq9yre019vsRD7HKx0bWycrAClunaZJzLVkvFofVRQnuDQriVgH80BnzfJdGwTg9dOhQo04HbyMHingOUmLBClxXkzdYeOefQrxJzYX1vBeE/zO9OdICezp3oiPDXEq3bw2/v0kJlCOjd6AGZzpdekNas2lxAR6pShMs7osYG8piLgtnad186aOKtJt0fyKUbo+AE4fQeudUPPMIasu/LyLMZWX9tKN3n/c8NcmC8n0MXDZ70BkrZjvUKAHi//Ow14C4LiqhxiXQXFuLH2SWZuQLoTmWGgJKZv4oTIK0jots0PU9HvDdZnA90WPHUfLpG4/LvmTFh3s+q22WW2hXXQQ0KFE/YczCBCmP/psT7xIPtAqTyBFZ/ozWGQB0wM747a4r9AF4jpEr8V7wfBPS6I66cWiqHybWl04Fx7w72gW+obK01FZWsncY+TXlJz8FifLjkYN2rxJlLPPEAoppmyMJVKlABh/eJvOYxNMDGKi25ZiQbIuiatIfKJpDZjsYWtQSzoDolRun9lQcq9ttNHM3dK7wE8MCtLlSmtrkJebq6KT59Ao3/KkRTu8ObAvOyaVP6SFzM5WyVqpn012savkM6gpERm7YNiMY5t7e50=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(26005)(2906002)(8936002)(36756003)(4326008)(70206006)(70586007)(8676002)(316002)(110136005)(1076003)(356005)(41300700001)(40480700001)(6636002)(86362001)(478600001)(54906003)(40460700003)(6666004)(36860700001)(81166007)(82740400003)(336012)(186003)(2616005)(426003)(82310400005)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:24:31.0497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf88c9f-e698-499d-72c0-08db21cf5d5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

