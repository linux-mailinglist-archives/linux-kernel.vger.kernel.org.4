Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B626CA532
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjC0NJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:09:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB5DF;
        Mon, 27 Mar 2023 06:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZSeSwqxs7ngYjYUjJBvWBI93nBZd84oX44u3RLC6Q6fG6E+CYHSLPebYusZ3qH9z+oTsjAXa7Gpwh3B26RwWzoUyGYvj4Gb4I3vaWSfojr0CZEhLOkRqua8+S9i5+nlBcNUJDqDdT+EbXBXpoHXnr/0hS0iOHCsz/d1cRrPeCVcqiluvJABVOuYPmU4Tjo4GYjZiyQ8DDVjbr6ZpjsIqHGGyppt52fcpYGIwTtDOSe9ebgDFaz8CfsSwosEgaB60MC3QjQGFpL01m+V5PXRTIsczwJxvcZ5rMwxNyHD0bybj3ep7yGXGvODTgUVh7up150BemiXBw3W328qajgCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXwSz+8trieUcjyZhu4nKh9ppzLgxoqpvpONf31AIaI=;
 b=gKWTL2c5lwE9SH5j54YTNFK/0V0RkWXxgL6RDNjiYYCI5t1qOJwAajSibg5RbqpfX4DMzBKMIaRqOdiurFGI1hVEfqHU1Usvc4BCuSpOFvqRalYWnqgVaSpgTrINSTQ+WEJq3dLwNZ4Q1ALq1UIQ4zxE+ZEexJqs74p3AxuxNQez2aXHYvV783mrOezgUBcHvKxCqfK4WvL9RVNStYdkELPOFiqO4j8gc332KbHjWmajZNuzpKzO+hzHS4W9oMKeox1/VaWcnHBGa688neeZy8YIsWQ2o0AJNJz/jLokDKgenB5Wois6De0sPS2mwp99Rj6hvN3wyJnPJJpeXE+isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXwSz+8trieUcjyZhu4nKh9ppzLgxoqpvpONf31AIaI=;
 b=zBNgp5gLCrrcN1VQrxJB7ZpJU0tyW1vCpvfMNjEryHn57S47s8Vt8Q1LB3tbDyXQWxtTxygscbT8TCG2fGXlrSj+AmSFQ7qOEW2qRp3zhXEEC8NgsoEHq6rasD4gNEq/tOZ7bgfVv2/C/OWhWR1SS7yTG0CXpdqhVhpos87LFxs=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 13:09:11 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::55) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 13:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 13:09:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 08:09:04 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <acme@kernel.org>,
        <eranian@google.com>, <kan.liang@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v2] perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
Date:   Mon, 27 Mar 2023 18:38:51 +0530
Message-ID: <20230327130851.1565-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a191dcb-5cbc-43d6-c13f-08db2ec47485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0xlu4ECk8HzAAcRrIZnUgSHSmjPZbv9KJ62r2zGkcWf1no/OUUlyF7lHQSOt2gf3f0v+C7ATtW8zCN5st0bJ/2V7pXYERKQ221/koGTO3rZk0dhLXCq6dXnlLiyEyjvcdbpDuA6LGsA0zCKKwV2EXm0FIu7619rbka/TqtIsh4WSQI8eiH3G8/jGOFOHTuktRjm4bgnM6djUySBflMi4F6Z65wqknT8ZHNREqIXlNwXAg2RDY4h8Evp1BVgbcSOB0kGFAb/+9zmAmCq7qmlwRjgfU/S16fTkzLq1dcUuMFcMQs7webULvbMGN/MoCTU0AwkQi+Q/2RhPtlrHwZJwIAZnBMpzYHSr5y7aPHWvzIQMHkXVxLTV1X0oV9mHbMTlLP5sVPsw5x2ogI7BP8EL6zEFabniAf/suf/mxwVBuXlDWwhiJnKB77bAkP3UuxwpAxk4DkXDpZkcFJnWycnyEk6kxzBzniWpatR4dh0/wE5GFgSpsjqx5t6Zy29gie6Ul0bvPhZqPZBK4Z3Z4vTFrZ/Rd+Fv7p61qmfcTOazdnyvH64BpwflsI7aO9DYP7t8D7oOUBmZ7u0qHvzYjPCY2PnYOV6mb3JNFM0X18mp55Ms2cmuCsK6ihdncL+pehepwX1LY7iSn6yLHVpjVxZ8DKwlVriaFY4XXbVAw1PIjjC/h5QXlFacbwoS4XxNdVZq/U885N8C/VeaaCAF7TaH0sTCfG8u1Eq3eXYYec/CGw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(26005)(16526019)(40480700001)(41300700001)(6666004)(186003)(966005)(7696005)(83380400001)(426003)(336012)(2616005)(47076005)(478600001)(54906003)(110136005)(316002)(36860700001)(40460700003)(4326008)(44832011)(7416002)(2906002)(70206006)(70586007)(8676002)(81166007)(82740400003)(356005)(36756003)(86362001)(82310400005)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:09:10.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a191dcb-5cbc-43d6-c13f-08db2ec47485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Kernel IBS driver wasn't using new PERF_MEM_* APIs due to few of its
limitations. Mainly:

- mem_lvl_num doesn't allow setting multiple sources whereas old API
  allows it. Setting multiple data sources is useful because IBS on
  pre-zen4 uarch doesn't provide fine granular DataSrc details (there
  is only one such DataSrc(2h) though).
- perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
  c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
  prints mem_lvl and mem_lvl_num both if both are set, which is ugly.

1st one can be handled by using ANY_CACHE with HOPS_0. 2nd one is
purely perf tool specific issue and should be fixed separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1: https://lore.kernel.org/r/20230311000642.1270971-1-namhyung@kernel.org
v1->v2:
- In addition to setting new API fields, convert all individual field
  assignments to compile time wrapper macros built using PERF_MEM_S().
  Also convert DataSrc conditional code to array lookups.

 arch/x86/events/amd/ibs.c | 155 +++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 87 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 64582954b5f6..b46e0b725fe5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -703,9 +703,41 @@ static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
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
+#define RMT_NODE_BITS			((1 << IBS_DATA_SRC_DRAM) | \
+					 (1 << IBS_DATA_SRC_IO))
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
+					 (1 << IBS_DATA_SRC_EXT_IO) |\
+					 (1 << IBS_DATA_SRC_EXT_EXT_MEM))
+#define ZEN4_RMT_NODE_APPLICABLE(x)	(RMT_NODE_BITS & (1 << x))
+
+static __u64 perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
+				  union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
 {
 	union perf_mem_data_src *data_src = &data->data_src;
 	u8 ibs_data_src = perf_ibs_data_src(op_data2);
@@ -716,25 +748,19 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
 	 * memory accesses. So, check DcUcMemAcc bit early.
 	 */
-	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
-		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
+		return L(UNC);
 
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
@@ -744,82 +770,36 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
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
+		/* HOPS_1 because IBS doesn't provide remote socket detail */
+		if (op_data2->rmt_node && ZEN4_RMT_NODE_APPLICABLE(ibs_data_src)) {
+			if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM)
+				val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
+			else
+				val |= REM | HOPS(1);
 		}
-	} else {
-		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
-			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
-			return;
-		}
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
@@ -830,12 +810,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
 	 * MAB only when IBS fails to provide DataSrc.
 	 */
-	if (op_data3->dc_miss_no_mab_alloc) {
-		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
-		return;
-	}
+	if (op_data3->dc_miss_no_mab_alloc)
+		return L(LFB) | LN(LFB);
 
 	data_src->mem_lvl = PERF_MEM_LVL_NA;
+	return 0;
 }
 
 static bool perf_ibs_cache_hit_st_valid(void)
@@ -925,7 +904,9 @@ static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
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
2.39.2

