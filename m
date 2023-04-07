Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6784E6DAC30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjDGL0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbjDGLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:25:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4E7AB9;
        Fri,  7 Apr 2023 04:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFCGXpS0L4KdhIujZ6URuABzglZda8Qm55mjlmOPvSBFxcOIWY6Cs5aB1Ugob737Lv85c/WXqW/MXXjjD1FaF+sUZnPTQE8sYZcjFh6doLK8BcUfjijxP1cu/Bd9rzowQHG9bvpsaVvVw4WAbb80XcwVC9Rqxukk6EPtY1CB6gw9lMIZl/qd5BJCNs2pGfiIFwZy1n61G1HbHRj26HdqSys7I0CrhYL3OslnRQXKqVK0RMarNQFLq4ninVH6FLxZoOGhjL3ZsKHEbB93874Q2YkoMMbpDUsbtNKA/HZYFkjUHKk/BINCdPsPgpAqCzH3V/1uY/dJJ9DKRmfKN1OWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmWy5tspYc7/X9LKoRB2FsBY5LWz4o17tJyK3yN/H34=;
 b=j1Uawg2+6QFo6CruhOuL0IFWaGPABB+D+EwM9HeQNKKd+XgUY8jE23vOnrLadkkOc3ac3YdaS/+znZ9oWBKye08oxszoqZb9JxL8gdr2YrlKAzklQEnZ+QX4c++QCytbgAeFxCO3PTOmT6wO1LBm9fNYV0lhgWB+Cpn4QU7c9dAMQy7VHWil3PcS6NdKtfgZ33dT2Zq/wAuVn1fN0yk1Nf1i1MUZB7fOBj4mcBUjYv+OS+vuFm9DAR8xS8xN/PXEa8q9pPRXF9IP5SVJ5CoyZ4x76DsniNta8LqVQ9NXVuxJ2sCioesMGVagpW5Sa+rPdNBD/Gfs66N5f1mcouUUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmWy5tspYc7/X9LKoRB2FsBY5LWz4o17tJyK3yN/H34=;
 b=yz9jTbhZDIo95FH60foxKzJF8vrWxNd8Npv9tbvY6lKVvASgGg9yXEMyPCZNgFaDSDoU1tPV2y1PbqsOgoTDI4YD2QAH9InTeTf/HzJ1OL+5mOFgqWGinSZ0GJeAykr5XGL8gteEaWh4Dg9Tug6iimTJh/PgA67D1gOIYGejogc=
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 11:25:45 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::53) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.18 via Frontend
 Transport; Fri, 7 Apr 2023 11:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Fri, 7 Apr 2023 11:25:44 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:38 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 3/9] perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
Date:   Fri, 7 Apr 2023 16:54:53 +0530
Message-ID: <20230407112459.548-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1e6c51-504b-4687-d8e1-08db375ad40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hw6QSg2ma2Ysb8oP4Wt5rxvt4ne5OwAJsIezIdmh2Sd2fEbCK+oryDaCxm6YWX4rYt/ojfA48c5mJ+ukOQRFpaj4zI7hLnIHOD2d/ZUODztVXF1dffVlNmgFEFJxWYZtXD/vkjSzmJYd7elubN1syKN5p2mlzjvIEAW19WXQCG0yvdcmpKVXLaR7RK35p1/+FiVcV9stq39lmFOWK/slfTFDsJLkSwKlsp75dFhhGRZZ5hqJzZGB33Go9ABHdAqVA2UY44TdQhNUvRHeSbNkPkqEmQuWKlAuOMvlDTry3NK+BjN7w04D7Gju9NH1+yvIKGfa/xgr9afW7HDM69Ku6A9YbN67F3bcBtlYL529zeFab1FV9YnuM7Yf0qNIbVZdS7r+a1JmIm92gehwVg5n6KGS4gK9L5f2JECrq/SQuLxjz9QPVkSRvFi7YDY/y2JaXtivKZpR8nmdPHLMrK9pyOPTQjlsZNI4cmY8kZel36JGlAGxHWDEJ71U/eVZ6+0io704j8xdEeD2veKe0uVzsbHetAOa8YaK1KMtRLhX6cR19KTssxlOqmnlA3naVKOasgCKvjawZIowXaFKwzEhmAfJaYDk0Nlv2sy+u+cjz5/A1YzUKxyF1kdv1HCBufoXz/B8+obtn5HJXLzMJRZMuIUOabA5ZOO3vfimxulPYCoyOK/uQtzeX0jif5oYQlWfrL1CgjsQ4n7C9W82f2UzG5uxWon9hMTa1CJMS9YxHU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(110136005)(316002)(54906003)(478600001)(83380400001)(40460700003)(336012)(47076005)(36756003)(1076003)(40480700001)(26005)(426003)(186003)(6666004)(2616005)(356005)(81166007)(86362001)(36860700001)(82740400003)(82310400005)(16526019)(7696005)(70586007)(70206006)(4326008)(8936002)(8676002)(2906002)(41300700001)(7416002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:25:44.5781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1e6c51-504b-4687-d8e1-08db375ad40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
limitations. Mainly:

1. mem_lvl_num doesn't allow setting multiple sources whereas old API
   allows it. Setting multiple data sources is useful because IBS on
   pre-zen4 uarch doesn't provide fine granular DataSrc details (there
   is only one such DataSrc(2h) though).
2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
   c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
   prints mem_lvl and mem_lvl_num both if both are set, which is ugly.

1st one can be handled by using ANY_CACHE with HOPS_0. 2nd is purely
perf tool specific issue and should be fixed separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 156 +++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 88 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 64582954b5f6..b6b833f5da50 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -703,38 +703,63 @@ static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
 	return op_data2->data_src_lo;
 }
 
-static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
-				 union ibs_op_data3 *op_data3,
-				 struct perf_sample_data *data)
+#define	L(x)		(PERF_MEM_S(LVL, x) | PERF_MEM_S(LVL, HIT))
+#define	LN(x)		PERF_MEM_S(LVLNUM, x)
+#define	REM		PERF_MEM_S(REMOTE, REMOTE)
+#define	HOPS(x)		PERF_MEM_S(HOPS, x)
+
+static u64 g_data_src[8] = {
+	[IBS_DATA_SRC_LOC_CACHE]	  = L(L3) | L(REM_CCE1) | LN(ANY_CACHE) | HOPS(0),
+	[IBS_DATA_SRC_DRAM]		  = L(LOC_RAM) | LN(RAM),
+	[IBS_DATA_SRC_REM_CACHE]	  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
+	[IBS_DATA_SRC_IO]		  = L(IO) | LN(IO),
+};
+
+#define RMT_NODE_BITS			(1 << IBS_DATA_SRC_DRAM)
+#define RMT_NODE_APPLICABLE(x)		(RMT_NODE_BITS & (1 << x))
+
+static u64 g_zen4_data_src[32] = {
+	[IBS_DATA_SRC_EXT_LOC_CACHE]	  = L(L3) | LN(L3),
+	[IBS_DATA_SRC_EXT_NEAR_CCX_CACHE] = L(REM_CCE1) | LN(ANY_CACHE) | REM | HOPS(0),
+	[IBS_DATA_SRC_EXT_DRAM]		  = L(LOC_RAM) | LN(RAM),
+	[IBS_DATA_SRC_EXT_FAR_CCX_CACHE]  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
+	[IBS_DATA_SRC_EXT_PMEM]		  = LN(PMEM),
+	[IBS_DATA_SRC_EXT_IO]		  = L(IO) | LN(IO),
+	[IBS_DATA_SRC_EXT_EXT_MEM]	  = LN(CXL),
+};
+
+#define ZEN4_RMT_NODE_BITS		((1 << IBS_DATA_SRC_EXT_DRAM) | \
+					 (1 << IBS_DATA_SRC_EXT_PMEM) | \
+					 (1 << IBS_DATA_SRC_EXT_EXT_MEM))
+#define ZEN4_RMT_NODE_APPLICABLE(x)	(ZEN4_RMT_NODE_BITS & (1 << x))
+
+static __u64 perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
+				  union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
 {
 	union perf_mem_data_src *data_src = &data->data_src;
 	u8 ibs_data_src = perf_ibs_data_src(op_data2);
 
 	data_src->mem_lvl = 0;
+	data_src->mem_lvl_num = 0;
 
 	/*
 	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
 	 * memory accesses. So, check DcUcMemAcc bit early.
 	 */
-	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
+		return L(UNC) | LN(UNC);
 
 	/* L1 Hit */
-	if (op_data3->dc_miss == 0) {
-		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss == 0)
+		return L(L1) | LN(L1);
 
 	/* L2 Hit */
 	if (op_data3->l2_miss == 0) {
 		/* Erratum #1293 */
 		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
-		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
-			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
-			return;
-		}
+		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc))
+			return L(L2) | LN(L2);
 	}
 
 	/*
@@ -744,82 +769,36 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	if (data_src->mem_op != PERF_MEM_OP_LOAD)
 		goto check_mab;
 
-	/* L3 Hit */
 	if (ibs_caps & IBS_CAPS_ZEN4) {
-		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
-			return;
-		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
-					    PERF_MEM_LVL_HIT;
-			return;
-		}
-	}
+		u64 val = g_zen4_data_src[ibs_data_src];
 
-	/* A peer cache in a near CCX */
-	if (ibs_caps & IBS_CAPS_ZEN4 &&
-	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
-		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+		if (!val)
+			goto check_mab;
 
-	/* A peer cache in a far CCX */
-	if (ibs_caps & IBS_CAPS_ZEN4) {
-		if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
-		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && ZEN4_RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-	}
 
-	/* DRAM */
-	if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
-		if (op_data2->rmt_node == 0)
-			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
-		else
-			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
-		return;
-	}
+		return val;
+	} else {
+		u64 val = g_data_src[ibs_data_src];
 
-	/* PMEM */
-	if (ibs_caps & IBS_CAPS_ZEN4 && ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
-		}
-		return;
-	}
+		if (!val)
+			goto check_mab;
 
-	/* Extension Memory */
-	if (ibs_caps & IBS_CAPS_ZEN4 &&
-	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-		return;
-	}
 
-	/* IO */
-	if (ibs_data_src == IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_IO;
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
-		if (op_data2->rmt_node) {
-			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
-			/* IBS doesn't provide Remote socket detail */
-			data_src->mem_hops = PERF_MEM_HOPS_1;
-		}
-		return;
+		return val;
 	}
 
 check_mab:
@@ -830,12 +809,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
 	 * MAB only when IBS fails to provide DataSrc.
 	 */
-	if (op_data3->dc_miss_no_mab_alloc) {
-		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss_no_mab_alloc)
+		return L(LFB) | LN(LFB);
 
-	data_src->mem_lvl = PERF_MEM_LVL_NA;
+	/* Don't set HIT with NA */
+	return PERF_MEM_S(LVL, NA) | LN(NA);
 }
 
 static bool perf_ibs_cache_hit_st_valid(void)
@@ -925,7 +903,9 @@ static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
 				  union ibs_op_data2 *op_data2,
 				  union ibs_op_data3 *op_data3)
 {
-	perf_ibs_get_mem_lvl(op_data2, op_data3, data);
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->val |= perf_ibs_get_mem_lvl(op_data2, op_data3, data);
 	perf_ibs_get_mem_snoop(op_data2, data);
 	perf_ibs_get_tlb_lvl(op_data3, data);
 	perf_ibs_get_mem_lock(op_data3, data);
-- 
2.34.1

