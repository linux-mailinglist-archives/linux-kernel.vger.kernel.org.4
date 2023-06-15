Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B9730F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjFOGNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFOGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:13:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E361FC2;
        Wed, 14 Jun 2023 23:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ39HQHZ1d6As56Xzlf1GTvcdt7RGEVWDjB4JsWEWSkIIR4qyPGO3zmEBYRtESMnARd+jNgyguO+1by417SLExpW9XDm0y4zVlHqkizAx86b7D5eEBRlPU15k4hTK9U1jJ3tL4Sb9cattPGgqZa095Den8v+Lu4C6+CPwJsgk3Pb9xcCBBEWDjRIw2qlHiCEm8p9dyvuoB5a3cRfQQceD2WYiLcZVB3gdV6semvE4VsAhMGpzPfHvdYg3gqh7iJaXirZUAmudnZTyRGuEq61yQi6cpKEopiIGCi1CUhE6Ygdg5TUXXQjQzm1O/AXgxFJEadLGekabMbTYhvAbe/akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMgiCeOszjF5fZvJtp1rctyKtfv/NpiiL+BB2blyvrw=;
 b=mmYiU0oG4eQXq24CvusdWcJPA9dUQFrE7jS7o33qwA2hEOHOu81kd/5pwQuBKUsdzfLwRDFHCKPQXwtzwxvQtnyEIm/UgYM+BbaE+qP0dRiowAKA9vfOPOFzmt6D2rUl4makUaGXNbMTU9gAQ1OoYo9HjKQbH64uLbxmioS/287BvrDMGD3H6jYKomhIR3CstPobXEFgINoLd8eNt3GwehFhqwLW3oIBNuVpMQcr52de+qw1rIoSz4P08K6hpuxQD3BWnyI+3awi4QhEij6SQj4gHUai7AeXyB3oSOvR/GWVoRy1rOavmBfCCzjT7zVCsX/j57dmWPAC0ciQGcz/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMgiCeOszjF5fZvJtp1rctyKtfv/NpiiL+BB2blyvrw=;
 b=jvAOJxmbMNDJVivXGXRjL9bkOZ3vVhiPmK3sZov0Xmj1uUNuPwcbgyipAOFqnupZZACo3+odu4Rz027g7KKlo8MwjNCMlUQG3T/Xa9wWSGUAnNLbSBlo2ncqXfO3glNnyGeB+BL9oXwG+/d0JJcb2iA8At80DuAl6RjsIgrfu3M=
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 06:12:59 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c2) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 06:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 06:12:58 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 01:12:52 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <james.clark@arm.com>, <alisaidi@amazon.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <mark.rutland@arm.com>, <maddy@linux.ibm.com>,
        <tmricht@linux.ibm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2.1 2/3] perf mem amd: Fix perf_pmus__num_mem_pmus()
Date:   Thu, 15 Jun 2023 11:42:38 +0530
Message-ID: <20230615061238.2042-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e63e6d33-6659-b63f-2716-c347aba7f525@amd.com>
References: <e63e6d33-6659-b63f-2716-c347aba7f525@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a36cb81-ca19-413d-a3c0-08db6d679128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRJd7T7SWI12qkVPhPmn/HgpCE5XPgIdBSvCiCKvWeyJGDlbz+SQZmHfGKOlf80yUkAGFYdKKJf7gO9IiclXGuXr6txr/sjMNo2q6AyarzOWTjWAzJPjdDF9AcYcFFd0Ksl76BF4V007e4hHiNzEbbWqm9Btd7heWtXanTr1Y5zLRhnD8yR3ABOZT6F8/VVk7JzI3AWx5j1bLd65Mf0rwboVp/zI6eUbW0/AS8Qi3lGqKzHMhpQF0q/FQJImvzNuPH8FyoPhB2/HtLlYUE7OJusk/gk7G7SPXs580cRuR/i6N6up1Urnak5x7mM3ABIGKaZUXNt1/UmHRcXjrf5UINtnWVrg+uBtoR/7Idqj0bWcJv0mwiR4Bp3rN018dWB1UIsPlLAHh8Kf2cYW4BBI+xmBBRl1k4alxJ0Wf/3OibYRVGbMvtRgARxMJLqzmA2DpQG156PZh8bqG7Y+9jgigAjzh4/4N6LFg8z6/UZlwQZ+Yzo03yJj24ukMFcD8dCZHQt6RUus9LBq7LijM/mExP0vcRmN2pCVOEuOrpY4Iy5ChZLunrVekrWENWAki/QUqQ+KHQcY7BDJ2NWUQ8OHQL/kD/puXm6SsRvAG7pv63sHTiZwhBKV7rx3e8H0YW6vletM00KzwJMR/w/rpUUvV46XJdWGq+z5PHlVOK9QH8kGZ3JX+iHs2/uJRQTNueiDar4q/viLATo3qzTeHDF1Mlfm5zLAQJfL3gemykMBCf7roDkT4OU95jMSSMScEw9/enBMuEotoCCfhZ5zXivzo2AGxUDybaPt9+zWisSrdB1CTQJYqUlbCJmeWiUyFbYr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(44832011)(2906002)(86362001)(82310400005)(7416002)(40480700001)(336012)(7696005)(83380400001)(6666004)(16526019)(36860700001)(186003)(26005)(1076003)(426003)(82740400003)(81166007)(356005)(40460700003)(54906003)(6916009)(70586007)(70206006)(4326008)(316002)(2616005)(5660300002)(8676002)(47076005)(8936002)(478600001)(41300700001)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:12:58.6694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a36cb81-ca19-413d-a3c0-08db6d679128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf mem/c2c on AMD internally uses IBS OP PMU, not the core PMU. Also,
AMD platforms does not have heterogeneous PMUs.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/pmu.c | 12 ++++++++++++
 tools/perf/util/pmus.c         |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 3c0de3370d7e..65d8cdff4d5f 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -14,6 +14,8 @@
 #include "../../../util/intel-bts.h"
 #include "../../../util/pmu.h"
 #include "../../../util/fncache.h"
+#include "../../../util/pmus.h"
+#include "env.h"
 
 struct pmu_alias {
 	char *name;
@@ -168,3 +170,13 @@ char *pmu_find_alias_name(const char *name)
 
 	return __pmu_find_alias_name(name);
 }
+
+int perf_pmus__num_mem_pmus(void)
+{
+	/* AMD uses IBS OP pmu and not a core PMU for perf mem/c2c */
+	if (x86__is_amd_cpu())
+		return 1;
+
+	/* Intel uses core pmus for perf mem/c2c */
+	return perf_pmus__num_core_pmus();
+}
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 8c50ab8894b7..a2032c1b7644 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -242,7 +242,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 	return NULL;
 }
 
-int perf_pmus__num_mem_pmus(void)
+int __weak perf_pmus__num_mem_pmus(void)
 {
 	/* All core PMUs are for mem events. */
 	return perf_pmus__num_core_pmus();
-- 
2.40.1

