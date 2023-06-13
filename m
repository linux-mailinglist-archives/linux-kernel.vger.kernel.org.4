Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2015972DE62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjFMJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbjFMJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1E10E4;
        Tue, 13 Jun 2023 02:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQNGDdHzc8oU5Iz1SYtVXqAnGtfRe8r7/EvXD6HC6Rm/bpFWpHYpey9s5533stX0q7FxhQqm1Z+3abjXyqXLOI/jox7hII3Uo6V2qiU0I4clCpbLZucxAg5+WodZLbekicQEzlBsqCwTixvf3jS1kcPTb6h4BAFyqsnOi+Ck4e5+EWSphXJo4C3N1PtTHP08qlKUjudNtHEcFYYp4u8Jy4RqDvxvd3b19ujiEZ4utHvtyDe8xwYlPYGUOhlq4Fpv+gN4NobYnQ+ZR/XJMdrfly8oMSr0Nuz94OYliu0dyC1W/xznQ45/07OXG1XEhWwHKGioK6rBUl8e7TBEiLyTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRIWRkPm34LgJCVmwG6rhCTw+kwSUrOUTFR4e7Z1f6I=;
 b=ZGPWExE+IQASygZi25bUdIuWNWLnw2q/vMnQpsyQ/BAexZOijUCSAuLVZfPUMPuMgomOg4ZdHgeYZhDxqJZ6k/jm1AUJINEa/jeUfKzAifHbQyDT3swZKpb84ZvJBra0R83eiz+pnhE2KQI11wxb5wy6052rQx/iv/wbwmKvenvJiwoda7muzeBRKWBOECAvtb2Josz3njS3dK1VAvwYfuuLZc7bP0Z1iaswV533Ms0KukT0agRSpiQWhaAqKSpe8ESg17/A4qPdC0I8bf1tm8k2k0/hNd0VAhP6o7geftT68Cih60d7ZPA7ua/YCkFsBQB+Jtt7kQnk6PHZxmhIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRIWRkPm34LgJCVmwG6rhCTw+kwSUrOUTFR4e7Z1f6I=;
 b=AEbH42+R/i9w5Kl2P4Fpac8ncICxSRuLrupUsQ1yGn0tzm6m2ht0b9E4ZOW/4FfyX+JmTBo3YTqRzIU/N28c9HNFdeDZZkt/3jD+PL5kyuWR+rSFdNO+vE92SVVGYgR+gvB9NMyGCDqVQQVWpziSCu/lhDZQeno2uE+yxRi6ZeQ=
Received: from SA1PR03CA0017.namprd03.prod.outlook.com (2603:10b6:806:2d3::13)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 09:56:15 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::81) by SA1PR03CA0017.outlook.office365.com
 (2603:10b6:806:2d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 09:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 09:56:15 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 04:56:09 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <alisaidi@amazon.com>, <leo.yan@linaro.org>, <maddy@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 3/4] perf mem amd: Fix perf_pmus__num_mem_pmus()
Date:   Tue, 13 Jun 2023 15:25:05 +0530
Message-ID: <20230613095506.547-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613095506.547-1-ravi.bangoria@amd.com>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a26752-9e61-4f07-74a8-08db6bf46d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is6/Qs35sgvwQTTt5W0aw09kyQnpXTZK8WgF/6i9pMcz8ajG9SpkCxKmn+PSkZYENoP3Arl97i2PMFLRdEiA+HSx7Z5Igs/wz6PqO0EttwERctWzK8fTInhY4VBVz8XmU/4/vm4Kzo6USWOGFIz43vn1USTUNHW7wgemdLSgni7JujIz1Ksn0W6Bl1Wanfk9esh7WM9fwXXarUleaX5tb3JDOl0sfxywW2TqkSryazP8PUqluNY9bhYrkoY5IDNdb6HABMVr1t0xfLqa3s18y/wPu2ASxUV82GCSS0YmlsjY3wTW8Mf0PcUcEqgERh0tc9BWXoOguED2mqyID5OYZTfS14po2gy/3qZSMW3puh6Wt/cxs34/57BN1NZDsGmNhtyUY97Pb2aI2ZWQLepr6FoMSzoVwmWMz8Dc14xJ1kR30oG/KSkXTRBne24M8Osc15iEemNC4CMFWKoRI65yDN3Wm+auoT/+9iooYzXvYxJEKqim8KvW1dFNdlzLWhZO28FZzAyfkPAnTajwkzeIx2ucYK9M3nMbun8Y9N38c16t9eMIr6qFMZ3tPbZYjkbFYGrdWcBVeNtE8/8ZAyQeLxKFLtIxN6XakrN/18bpy9QskgJdUsKvTdNpzQKAfUDk2VeHimofVdyiM0Cqd6VfO7ADN/YXGyUHkVo8/P/HCIf85Mo/NRg4DjdC9IB7TnlmgLxfpYYN20C1I/L4O2fXbQuMqLg8xTbtMiaq5/fTopb86I840RcLhAUbykRX8RHbhFQ00Y4OL5KVb1LK86VXy12p8at6I/pQBtMa0GMA0YXTbmE0aef60nZJtZ4B69aU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(6666004)(36756003)(47076005)(83380400001)(426003)(336012)(2616005)(82310400005)(86362001)(82740400003)(356005)(1076003)(26005)(81166007)(40480700001)(36860700001)(16526019)(186003)(2906002)(5660300002)(54906003)(8676002)(44832011)(8936002)(316002)(7416002)(41300700001)(6916009)(4326008)(70206006)(70586007)(478600001)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:15.3137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a26752-9e61-4f07-74a8-08db6bf46d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD cpus does not contain hybrid cores. Also, perf mem/c2c on AMD
internally uses IBS OP PMU, not the core PMU.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/pmu.c | 15 +++++++++++++++
 tools/perf/util/pmus.c         |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 3c0de3370d7e..8a20d28d9927 100644
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
@@ -168,3 +170,16 @@ char *pmu_find_alias_name(const char *name)
 
 	return __pmu_find_alias_name(name);
 }
+
+int perf_pmus__num_mem_pmus(void)
+{
+	/*
+	 * AMD does not have hybrid cores and also uses IBS OP
+	 * pmu for perf mem/c2c.
+	 */
+	if (x86__is_amd_cpu())
+		return 1;
+
+	/* Intel uses core pmus for perf mem/c2c */
+	return perf_pmus__num_core_pmus();
+}
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index e505d2fef828..0ed943932945 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -240,7 +240,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 	return NULL;
 }
 
-int perf_pmus__num_mem_pmus(void)
+int __weak perf_pmus__num_mem_pmus(void)
 {
 	/* All core PMUs are for mem events. */
 	return perf_pmus__num_core_pmus();
-- 
2.40.1

