Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E365241B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiLTQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiLTQDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:03:02 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0A1869E;
        Tue, 20 Dec 2022 08:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5werpiVlWdI+40AdgOJ0iPNoEBTbdgmsFI/NdN8KfrjH8VuodL496lTg7wVEPCfm7bQGBnbyDeHpxAKqcX+ytnj5yXUBwinty2tKbfa01ok5PL3hGPQi2HZZMmXz5NVJoOJ97p0s0fmtHqXCrfAObQlJ4VVa8tY8w6KXSk+jCu0lRTlvBXrM4lYvICX/Mny1+YpLG8TX8vHzP0I6jHJVHBMxbt7f3kpMR1FZfS4N94k85pCUsU9DM81b8tIEt137EVHQFzSbbrSkBoFP4TcV2faVsTu5qOklF8/mYTW+6z7fyM0RPEQOlzfBLSwtmXu9J/WFfKJZKYZ0UqSRMBobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlbBRuKJsTAuqn1DhWagMB+lf4MGcxVzpTMiAqdG1Oo=;
 b=GISmqvCy/csVR7Y35tX+VWpl1hbIy1qvs2Ww/tTwupPKkKVaSb5jW5fSa2V6uDA2wVjFPTKGoxBpFS1yBXDroXizwW2KGJKipw4cjBxxCdiHtJqJgGOJusfaIUkuoCuW0F2FckihFVsu8ltaYmRB4ehIubBT3kdkLUON2Jo2er6Y5ZA/oSiY2nKcF2iW5t6sjWnmTMtF4fo2aYp/UQA6DIk2TmZsg1wz70TTYYT5n7RvAGTo30YUB9MNEA/17VjfJGHl96wGIkQJW+1DIbmODr2wIeX9CLKYl02qy7aRz1PQxhyd7NviZgvalG3mRnHrXFkD7B7sixkoQh60hTyExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlbBRuKJsTAuqn1DhWagMB+lf4MGcxVzpTMiAqdG1Oo=;
 b=AlPmBs4crAkDJMMc/BmYMIiudaDqM1nFmDzxqdbiaCOzNT4dHt3hdHyyKLqjQxYs5gW6nO9PRMj+bjoI0nfhk3ON46mnQVjhN89OJb8XibkZDkIwMx0g/d/DrZj7/TCLSKifYBARbhLaoOD44DqBjEVl9TpHxJxJqnvi6rPzCwnAzhZDWfCKcJNrFaLzDvXtDy8Zc8vdxpcaGvzeffmghGsKLmCYlxZm8Z1/UyJVZwy/IplPAsXcICOPmipIXn8uxMw7MpUV4x1NU+osEstFTcYZzs19plvmC5SIlqjmqMjyDSEsvg/zoU5U5suACol8YkJqmmVhzVSmUGrxzmgTsQ==
Received: from MW4PR04CA0263.namprd04.prod.outlook.com (2603:10b6:303:88::28)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:02:59 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::62) by MW4PR04CA0263.outlook.office365.com
 (2603:10b6:303:88::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:02:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:02:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:02:57 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:02:53 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM scaling in Tegra234
Date:   Tue, 20 Dec 2022 21:32:31 +0530
Message-ID: <20221220160240.27494-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 84124632-5180-49b1-fb0d-08dae2a3a9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRIk+iTRCA2+y/ZAz4C6rGr+Uj8Uq/Y7BfaGOqg1txxYXthPNtGcW6zJT/8nFGkUuerqpVNsiZzRM4NVV42djJbAMGJmENfERS0nC01dTyhvNHL6UCPOmYgjRQgK/QPDoMxHGT1g9Zgy85hJZa21n5MjhDq0HQd5Cqfa6+UegTm5XML3ivC9xDPLSMnj0ScIcrsQG+tx/r3Z1vRC0d6uDnoZTe2VaiP9o6qEYkTZSLZUHBUqtnvpcWNLoSVBIR0XtALYCz4PiGZCtkLBVmSEGrGdB4qM8RlPY6nf8Ji2Qw/2HHki77wrjHzxmpA7iZMSXjf0BPLr5i0whuULM2qfyywLBQSSt6AR3uOU+YNeQXfhinfmVR8an74hcSj1NKIaqUhWe3Q0daXYzEytI6+jeYyXIh90uzWkp2vgl5hEShvoDRocuVaNUf6LmfqJfenkwLReDaN/dmoaJz5RNSk4V9Lm5VBbVYbpPCQa8mfDwnHRuSQB04zm9bG/ewqHfOI0jyGTJWZ/zISjII8ZOWLyihV5VhyXOI0YmmrYhAlH7RHuuPFTRlAPcwI2r/IlrV7UXMewUXkLvnUvjEG9e+pQX9g3qjPquWMOC4TLwRAZuGkex03DoZ+fm6g7OVcpPqFvD49wsXp43DdyOtaqjCe39J/C1JJ5uyPn6XDt2aV3nvzuOA76N8T0GAKBLy3kumAlNBg8UpdXkp4pQz2hv2sEUOhvU5y8rSd0y2SgDfSmbYs=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(7696005)(36860700001)(40460700003)(316002)(478600001)(82740400003)(7636003)(8676002)(110136005)(4326008)(2616005)(86362001)(921005)(70586007)(36756003)(356005)(70206006)(1076003)(82310400005)(83380400001)(5660300002)(30864003)(40480700001)(8936002)(107886003)(6666004)(426003)(47076005)(336012)(2906002)(186003)(41300700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:02:58.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84124632-5180-49b1-fb0d-08dae2a3a9f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Interconnect framework support to dynamically set the DRAM
bandwidth from different clients. Both the MC and EMC drivers are
added as ICC providers. The path for any request will be:
 MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM

MC clients will request for bandwidth to the MC driver which will
pass the tegra icc node having current request info to the EMC driver.
The EMC driver will send the BPMP Client ID, Client type and bandwidth
request info to the BPMP-FW where the final DRAM freq for achieving the
requested bandwidth is set based on the passed parameters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/mc.c           |  18 ++-
 drivers/memory/tegra/tegra186-emc.c | 166 ++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra234.c     | 101 ++++++++++++++++-
 include/soc/tegra/mc.h              |   7 ++
 include/soc/tegra/tegra-icc.h       |  72 ++++++++++++
 5 files changed, 362 insertions(+), 2 deletions(-)
 create mode 100644 include/soc/tegra/tegra-icc.h

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 592907546ee6..ff887fb03bce 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -17,6 +17,7 @@
 #include <linux/sort.h>
 
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/tegra-icc.h>
 
 #include "mc.h"
 
@@ -779,6 +780,7 @@ const char *const tegra_mc_error_names[8] = {
  */
 static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 {
+	struct tegra_icc_node *tnode;
 	struct icc_node *node;
 	unsigned int i;
 	int err;
@@ -792,7 +794,11 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 	mc->provider.data = &mc->provider;
 	mc->provider.set = mc->soc->icc_ops->set;
 	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
-	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
+	mc->provider.get_bw = mc->soc->icc_ops->get_bw;
+	if (mc->soc->icc_ops->xlate)
+		mc->provider.xlate = mc->soc->icc_ops->xlate;
+	if (mc->soc->icc_ops->xlate_extended)
+		mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
 
 	err = icc_provider_add(&mc->provider);
 	if (err)
@@ -814,6 +820,10 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 		goto remove_nodes;
 
 	for (i = 0; i < mc->soc->num_clients; i++) {
+		tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
+		if (!tnode)
+			return -ENOMEM;
+
 		/* create MC client node */
 		node = icc_node_create(mc->soc->clients[i].id);
 		if (IS_ERR(node)) {
@@ -828,6 +838,12 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 		err = icc_link_create(node, TEGRA_ICC_MC);
 		if (err)
 			goto remove_nodes;
+
+		node->data = tnode;
+		tnode->node = node;
+		tnode->type = mc->soc->clients[i].type;
+		tnode->bpmp_id = mc->soc->clients[i].bpmp_id;
+		tnode->mc = mc;
 	}
 
 	return 0;
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 26e763bde92a..3500ed6ccd8f 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -8,8 +8,11 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <soc/tegra/bpmp.h>
+#include <soc/tegra/tegra-icc.h>
+#include "mc.h"
 
 struct tegra186_emc_dvfs {
 	unsigned long latency;
@@ -29,8 +32,15 @@ struct tegra186_emc {
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
+
+	struct icc_provider provider;
 };
 
+static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra186_emc, provider);
+}
+
 /*
  * debugfs interface
  *
@@ -146,11 +156,150 @@ DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
 			  tegra186_emc_debug_max_rate_get,
 			  tegra186_emc_debug_max_rate_set, "%llu\n");
 
+/*
+ * tegra_emc_icc_set_bw() - Pass MC client info and BW request to BPMP
+ * @src: ICC node for External Memory Controller (EMC)
+ * @dst: ICC node for External Memory (DRAM)
+ *
+ * Passing the MC client info and Banwidth request to BPMP-FW  where
+ * LA and PTSA registers are accessed and the final EMC freq is set based
+ * on client, type, latency and bandwidth.
+ */
+static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra186_emc *emc = to_tegra186_emc(dst->provider);
+	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
+	struct mrq_bwmgr_int_request bwmgr_req = { 0 };
+	struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
+	struct tegra_icc_node *tnode = mc->curr_tnode;
+	struct tegra_bpmp_message msg;
+	int ret = 0;
+
+	/*
+	 * Same Src and Dst node will happen during boot from icc_node_add().
+	 * This can be used to pre-initialize and set bandwidth for all clients
+	 * before their drivers are loaded. We are skipping this case as for us,
+	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
+	 */
+	if (src->id == dst->id)
+		return 0;
+
+	if (mc->curr_tnode->type == TEGRA_ICC_NISO)
+		bwmgr_req.bwmgr_calc_set_req.niso_bw = tnode->node->avg_bw;
+	else
+		bwmgr_req.bwmgr_calc_set_req.iso_bw = tnode->node->avg_bw;
+
+	bwmgr_req.bwmgr_calc_set_req.client_id = tnode->bpmp_id;
+
+	bwmgr_req.cmd = CMD_BWMGR_INT_CALC_AND_SET;
+	bwmgr_req.bwmgr_calc_set_req.mc_floor = tnode->node->peak_bw;
+	bwmgr_req.bwmgr_calc_set_req.floor_unit = BWMGR_INT_UNIT_KBPS;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_BWMGR_INT;
+	msg.tx.data = &bwmgr_req;
+	msg.tx.size = sizeof(bwmgr_req);
+	msg.rx.data = &bwmgr_resp;
+	msg.rx.size = sizeof(bwmgr_resp);
+
+	ret = tegra_bpmp_transfer(emc->bpmp, &msg);
+	if (ret < 0) {
+		dev_err(emc->dev, "BPMP transfer failed: %d\n", ret);
+		goto error;
+	}
+	if (msg.rx.ret < 0) {
+		pr_err("failed to set bandwidth for %u: %d\n",
+		       bwmgr_req.bwmgr_calc_set_req.client_id, msg.rx.ret);
+		ret = -EINVAL;
+	}
+
+error:
+	return ret;
+}
+
+static struct icc_node *
+tegra_emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct icc_provider *provider = data;
+	struct icc_node *node;
+
+	/* External Memory is the only possible ICC route */
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		if (node->id != TEGRA_ICC_EMEM)
+			continue;
+
+		return node;
+	}
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
+{
+	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
+	const struct tegra_mc_soc *soc = mc->soc;
+	struct icc_node *node;
+	int err = 0;
+
+	emc->provider.dev = emc->dev;
+	emc->provider.set = tegra_emc_icc_set_bw;
+	emc->provider.data = &emc->provider;
+	emc->provider.aggregate = soc->icc_ops->aggregate;
+	emc->provider.xlate = tegra_emc_of_icc_xlate;
+	emc->provider.get_bw = tegra_emc_icc_get_init_bw;
+
+	err = icc_provider_add(&emc->provider);
+	if (err)
+		return err;
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto del_provider;
+	}
+
+	node->name = "External Memory Controller";
+	icc_node_add(node, &emc->provider);
+
+	/* link External Memory Controller to External Memory (DRAM) */
+	err = icc_link_create(node, TEGRA_ICC_EMEM);
+	if (err)
+		goto remove_nodes;
+
+	/* create External Memory node */
+	node = icc_node_create(TEGRA_ICC_EMEM);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto remove_nodes;
+	}
+
+	node->name = "External Memory (DRAM)";
+	icc_node_add(node, &emc->provider);
+
+	return 0;
+remove_nodes:
+	icc_nodes_remove(&emc->provider);
+del_provider:
+	icc_provider_del(&emc->provider);
+
+	return err;
+}
+
 static int tegra186_emc_probe(struct platform_device *pdev)
 {
 	struct mrq_emc_dvfs_latency_response response;
 	struct tegra_bpmp_message msg;
 	struct tegra186_emc *emc;
+	struct tegra_mc *mc;
 	unsigned int i;
 	int err;
 
@@ -158,6 +307,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	if (!emc)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, emc);
+	emc->dev = &pdev->dev;
+
 	emc->bpmp = tegra_bpmp_get(&pdev->dev);
 	if (IS_ERR(emc->bpmp))
 		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
@@ -236,6 +388,19 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
 			    emc, &tegra186_emc_debug_max_rate_fops);
 
+	mc = dev_get_drvdata(emc->dev->parent);
+	if (mc && mc->soc->icc_ops) {
+		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
+			err = tegra_emc_interconnect_init(emc);
+			if (!err)
+				return err;
+			dev_err(&pdev->dev, "tegra_emc_interconnect_init failed:%d\n", err);
+			goto put_bpmp;
+		} else {
+			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
+		}
+	}
+
 	return 0;
 
 put_bpmp:
@@ -272,6 +437,7 @@ static struct platform_driver tegra186_emc_driver = {
 		.name = "tegra186-emc",
 		.of_match_table = tegra186_emc_of_match,
 		.suppress_bind_attrs = true,
+		.sync_state = icc_sync_state,
 	},
 	.probe = tegra186_emc_probe,
 	.remove = tegra186_emc_remove,
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 02dcc5748bba..65d4e32ee118 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 2021-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <soc/tegra/mc.h>
@@ -8,11 +8,16 @@
 #include <dt-bindings/memory/tegra234-mc.h>
 
 #include "mc.h"
+#include <soc/tegra/tegra-icc.h>
+#include <linux/interconnect.h>
+#include <linux/of_device.h>
 
 static const struct tegra_mc_client tegra234_mc_clients[] = {
 	{
 		.id = TEGRA234_MEMORY_CLIENT_MGBEARD,
 		.name = "mgbeard",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE,
 		.regs = {
 			.sid = {
@@ -23,6 +28,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEBRD,
 		.name = "mgbebrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF1,
 		.regs = {
 			.sid = {
@@ -33,6 +40,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBECRD,
 		.name = "mgbecrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF2,
 		.regs = {
 			.sid = {
@@ -43,6 +52,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEDRD,
 		.name = "mgbedrd",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF3,
 		.regs = {
 			.sid = {
@@ -52,6 +63,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEAWR,
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.name = "mgbeawr",
 		.sid = TEGRA234_SID_MGBE,
 		.regs = {
@@ -63,6 +76,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEBWR,
 		.name = "mgbebwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF1,
 		.regs = {
 			.sid = {
@@ -73,6 +88,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBECWR,
 		.name = "mgbecwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF2,
 		.regs = {
 			.sid = {
@@ -83,6 +100,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_SDMMCRAB,
 		.name = "sdmmcrab",
+		.bpmp_id = TEGRA_ICC_BPMP_SDMMC_4,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_SDMMC4,
 		.regs = {
 			.sid = {
@@ -93,6 +112,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEDWR,
 		.name = "mgbedwr",
+		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_MGBE_VF3,
 		.regs = {
 			.sid = {
@@ -103,6 +124,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_SDMMCWAB,
 		.name = "sdmmcwab",
+		.bpmp_id = TEGRA_ICC_BPMP_SDMMC_4,
+		.type = TEGRA_ICC_NISO,
 		.sid = TEGRA234_SID_SDMMC4,
 		.regs = {
 			.sid = {
@@ -153,6 +176,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APEDMAR,
 		.name = "apedmar",
+		.bpmp_id = TEGRA_ICC_BPMP_APEDMA,
+		.type = TEGRA_ICC_ISO_AUDIO,
 		.sid = TEGRA234_SID_APE,
 		.regs = {
 			.sid = {
@@ -163,6 +188,8 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APEDMAW,
 		.name = "apedmaw",
+		.bpmp_id = TEGRA_ICC_BPMP_APEDMA,
+		.type = TEGRA_ICC_ISO_AUDIO,
 		.sid = TEGRA234_SID_APE,
 		.regs = {
 			.sid = {
@@ -333,6 +360,77 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	},
 };
 
+/*
+ * tegra234_mc_icc_set() - Pass MC client info to External Memory Controller (EMC)
+ * @src: ICC node for Memory Controller's (MC) Client
+ * @dst: ICC node for Memory Controller (MC)
+ *
+ * Passing the current request info from the MC to the EMC driver using
+ * 'struct tegra_mc'. EMC driver will further send the MC client's request info
+ * to the BPMP-FW where LA and PTSA registers are accessed and the final EMC freq
+ * is set based on client, type, latency and bandwidth.
+ * icc_set_bw() makes set_bw calls for both MC and EMC providers in sequence.
+ * Both the calls are protected by 'mutex_lock(&icc_lock)'. So, the data passed
+ * from MC and EMC won't be updated by concurrent set calls from other clients.
+ */
+static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(dst->provider);
+	struct tegra_icc_node *tnode = src->data;
+
+	/*
+	 * Same Src and Dst node will happen during boot from icc_node_add().
+	 * This can be used to pre-initialize and set bandwidth for all clients
+	 * before their drivers are loaded. We are skipping this case as for us,
+	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
+	 */
+	if (src->id == dst->id)
+		return 0;
+
+	if (tnode->node)
+		mc->curr_tnode = tnode;
+	else
+		pr_err("%s, tegra_icc_node is null\n", __func__);
+
+	return 0;
+}
+
+static struct icc_node*
+tegra234_mc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
+	unsigned int cl_id = spec->args[0];
+	struct icc_node *node;
+
+	list_for_each_entry(node, &mc->provider.nodes, node_list) {
+		if (node->id != cl_id)
+			continue;
+
+		return node;
+	}
+
+	/*
+	 * If a client driver calls devm_of_icc_get() before the MC driver
+	 * is probed, then return EPROBE_DEFER to the client driver.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
+	.xlate = tegra234_mc_of_icc_xlate,
+	.get_bw = tegra234_mc_icc_get_init_bw,
+	.aggregate = icc_std_aggregate,
+	.set = tegra234_mc_icc_set,
+};
+
 const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
@@ -345,6 +443,7 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.icc_ops = &tegra234_mc_icc_ops,
 	.ch_intmask = 0x0000ff00,
 	.global_intstatus_channel_shift = 8,
 	/*
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 51a2263e1bc5..0a32a9eb12a4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
+#include <soc/tegra/tegra-icc.h>
 
 struct clk;
 struct device;
@@ -26,6 +27,8 @@ struct tegra_mc_timing {
 
 struct tegra_mc_client {
 	unsigned int id;
+	unsigned int bpmp_id;
+	enum tegra_icc_client_type type;
 	const char *name;
 	/*
 	 * For Tegra210 and earlier, this is the SWGROUP ID used for IOVA translations in the
@@ -166,8 +169,10 @@ struct tegra_mc_icc_ops {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct icc_node_data *(*xlate_extended)(struct of_phandle_args *spec,
 						void *data);
+	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 };
 
 struct tegra_mc_ops {
@@ -238,6 +243,8 @@ struct tegra_mc {
 	struct {
 		struct dentry *root;
 	} debugfs;
+
+	struct tegra_icc_node *curr_tnode;
 };
 
 int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
diff --git a/include/soc/tegra/tegra-icc.h b/include/soc/tegra/tegra-icc.h
new file mode 100644
index 000000000000..3855d8571281
--- /dev/null
+++ b/include/soc/tegra/tegra-icc.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022-2023 NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef MEMORY_TEGRA_ICC_H
+#define MEMORY_TEGRA_ICC_H
+
+enum tegra_icc_client_type {
+	TEGRA_ICC_NONE,
+	TEGRA_ICC_NISO,
+	TEGRA_ICC_ISO_DISPLAY,
+	TEGRA_ICC_ISO_VI,
+	TEGRA_ICC_ISO_AUDIO,
+	TEGRA_ICC_ISO_VIFAL,
+};
+
+struct tegra_icc_node {
+	struct icc_node *node;
+	struct tegra_mc *mc;
+	u32 bpmp_id;
+	u32 type;
+};
+
+/* ICC ID's for MC client's used in BPMP */
+#define TEGRA_ICC_BPMP_DEBUG		1
+#define TEGRA_ICC_BPMP_CPU_CLUSTER0	2
+#define TEGRA_ICC_BPMP_CPU_CLUSTER1	3
+#define TEGRA_ICC_BPMP_CPU_CLUSTER2	4
+#define TEGRA_ICC_BPMP_GPU		5
+#define TEGRA_ICC_BPMP_CACTMON		6
+#define TEGRA_ICC_BPMP_DISPLAY		7
+#define TEGRA_ICC_BPMP_VI		8
+#define TEGRA_ICC_BPMP_EQOS		9
+#define TEGRA_ICC_BPMP_PCIE_0		10
+#define TEGRA_ICC_BPMP_PCIE_1		11
+#define TEGRA_ICC_BPMP_PCIE_2		12
+#define TEGRA_ICC_BPMP_PCIE_3		13
+#define TEGRA_ICC_BPMP_PCIE_4		14
+#define TEGRA_ICC_BPMP_PCIE_5		15
+#define TEGRA_ICC_BPMP_PCIE_6		16
+#define TEGRA_ICC_BPMP_PCIE_7		17
+#define TEGRA_ICC_BPMP_PCIE_8		18
+#define TEGRA_ICC_BPMP_PCIE_9		19
+#define TEGRA_ICC_BPMP_PCIE_10		20
+#define TEGRA_ICC_BPMP_DLA_0		21
+#define TEGRA_ICC_BPMP_DLA_1		22
+#define TEGRA_ICC_BPMP_SDMMC_1		23
+#define TEGRA_ICC_BPMP_SDMMC_2		24
+#define TEGRA_ICC_BPMP_SDMMC_3		25
+#define TEGRA_ICC_BPMP_SDMMC_4		26
+#define TEGRA_ICC_BPMP_NVDEC		27
+#define TEGRA_ICC_BPMP_NVENC		28
+#define TEGRA_ICC_BPMP_NVJPG_0		29
+#define TEGRA_ICC_BPMP_NVJPG_1		30
+#define TEGRA_ICC_BPMP_OFAA		31
+#define TEGRA_ICC_BPMP_XUSB_HOST	32
+#define TEGRA_ICC_BPMP_XUSB_DEV		33
+#define TEGRA_ICC_BPMP_TSEC		34
+#define TEGRA_ICC_BPMP_VIC		35
+#define TEGRA_ICC_BPMP_APE		36
+#define TEGRA_ICC_BPMP_APEDMA		37
+#define TEGRA_ICC_BPMP_SE		38
+#define TEGRA_ICC_BPMP_ISP		39
+#define TEGRA_ICC_BPMP_HDA		40
+#define TEGRA_ICC_BPMP_VIFAL		41
+#define TEGRA_ICC_BPMP_VI2FAL		42
+#define TEGRA_ICC_BPMP_VI2		43
+#define TEGRA_ICC_BPMP_RCE		44
+#define TEGRA_ICC_BPMP_PVA		45
+
+#endif /* MEMORY_TEGRA_ICC_H */
-- 
2.17.1

