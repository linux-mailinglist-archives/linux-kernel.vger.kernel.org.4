Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693CD730E97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbjFOFSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFOFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:18:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E926A8;
        Wed, 14 Jun 2023 22:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN/E7g92tP2M4WJGlbL+EbHB6uDnk51m9eTg7mKdE5/qG2qeVqyswvAnXPVhYVxwg1HCVmL1HL/L+Nc06ShLvh+t322XyJomZOGS8AZ1zW2eePFnhEijgLboY/u6plULT8SIoJZ/gR/kXZIEHf2c8mkumiE42yhOHtmLqmyP/em2o9BW6Qn1849XAA+8xnVKQOAkhb/i/UwSlgs+ChhPeMRLIxWCvHtJKZ3ZlZuqyatnVifrqTRfHesS1WVLz/7xjialDlXiy04anR2TkP3Ur0TDqo/YYJQsCMbzU528Gn5+ciILdgCcgOZxImkjrwYyV2Ei8LQNeTTb5jNC6Amn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+wgGQffTGtgKzeyUDBvcOyac0L/WKtS3ywSLAIOqjo=;
 b=DVNBEvloaenN3q7vBR9jsoIvba66xS52LSEIuP++2nTM++tyfF+yLI28mD2KfidN8+kArVm061qFPhXvy6804Oc7F6h2qv+fRpSCMbF9298fSe2KwrG30BbPmN8MHLEN9/wQXLgRSJGP2a59YDqyrKHaEwuPATbirqfurYwJnQOD4XYvDW8W76VrOxPTybRsK6h/Vg1adug/vXHeqSiUVeTOcvkXUhrDN8beDlwDUSVAjKvkmuYiINpVBvXl90dXfixXebd6NPoW7t+9/0iJq+p76AyB6QHym6drmpkRBuro96QJuwQ+8AbUkAXIo6o8l0F9jRqnWqE2E+B/9cogIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+wgGQffTGtgKzeyUDBvcOyac0L/WKtS3ywSLAIOqjo=;
 b=RrbmR3TXOY+yU5/2uGu8w/HON+J+K5b+7ooD9NlXJZP4ALjjPwAUwPgk2cjN/H6DBMKJGRQ8scLUdWRKWUX/SHi5+vezYpSVOA6cfwTLFwnHOcAWT2ll7g0OSHRc5VE/dMl2jH//U3pFC7vxZzR/ugm1ueEXy6AJI68AOtzbbzg=
Received: from DM6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:333::33)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Thu, 15 Jun
 2023 05:18:14 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::2d) by DM6PR03CA0100.outlook.office365.com
 (2603:10b6:5:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 05:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 05:18:14 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 00:18:08 -0500
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
Subject: [PATCH v2 2/3] perf mem amd: Fix perf_pmus__num_mem_pmus()
Date:   Thu, 15 Jun 2023 10:46:59 +0530
Message-ID: <20230615051700.1833-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615051700.1833-1-ravi.bangoria@amd.com>
References: <20230615051700.1833-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: ec887821-94e6-4511-f732-08db6d5feb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy7V9Zi2MdRfsHWrqmQ4ziPBcvZpckPGsSDnQRzEeb1NNyagU8JcBrals3xlSUrvByVxhi9Kz/6lYfwy4PZMgvswKZwyYz9BtQiQqIlfdcipemaWuQOlek5jsU+RN69yHUAF5bu8vrVKpsmcIDQo8wxAKAPYveL/4pPJLbNYKioyEI/hNy9o/Uk3udCeNw5s2ixEisHqEZk03/jWFy1KOLIwL4EZaIMeWntoVJmV+R1zZcKvfRKuiXT6XZikFqOoI1F3G8aYpY108G8AG7NP/0fj+I7mLFf7csrr/SYEUqckTndsbCaxGJwPBApxr6ladKbF2jjJhUZHFvl4E8Si2fJ13YBtch79ODF8t9WL16CNdnhHulkK3/A3Rh7N8YsNxFzxN+UwlhkdOqNuWTGKPjnk2YzMSNweAl2fHTuxUivGoGX5TX7WLI/iED16CyTpH7oOOx1LZOZ676PNDRb4BCgfAb27JvIMXPSl6NYBpWmI6G0pZq3bLG7zbo3/ctxSbRdSynSQ1GpESakqHW+x9zASds0e0Q1T6Br8gMgMLL1b7tXBooy5bSKQ31hX/KxrZlFrgqNyb7EfZMZVcUWkSDpvrJX+uxeK7BZJ0XUI3eOkY7MpqMd20mjsIlTKp/AbfPDmLgV2hbxclVtX4UyJTlgNUqeeDRLO5Z6jnJLx7DlScAxQzvvOPawbkNNHr52vfzyzfli7oj+z/X3H+Vf18nByZr2W9pS3t6HSCfFWQ/N89c5HtkzIe8ZCKEZ/TjnILfOi/2rmk+1YzxVQ/UDvrcybXV7aUtE7/Xbuk0GS8aCS5QC/LurC10vJE3uc4T14
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(478600001)(7696005)(36860700001)(1076003)(47076005)(336012)(186003)(426003)(16526019)(83380400001)(36756003)(82310400005)(86362001)(2616005)(82740400003)(26005)(81166007)(356005)(40480700001)(4326008)(70586007)(44832011)(70206006)(6916009)(316002)(8676002)(8936002)(7416002)(5660300002)(41300700001)(2906002)(54906003)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 05:18:14.2235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec887821-94e6-4511-f732-08db6d5feb79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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
index 3c0de3370d7e..f3534a791e79 100644
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
+	/* AMD uses IBS OP pmu for perf mem/c2c */
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

