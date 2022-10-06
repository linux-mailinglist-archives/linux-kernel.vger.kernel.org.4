Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023D5F6AF6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiJFPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiJFPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:46:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A6D8304D;
        Thu,  6 Oct 2022 08:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAFwnOzH61wtUe8zkTBI1UNwDrIjHXUIyS+2uRTmyHMKEiiRo7UCOXGDDlY5Yk7OFmHKp0lXsPhcdxX3bqgIpzPRJtMG0SQfpedjT8WZ9BXh5yWEEfBtSMj0mHXKJVYofLO1bl2VAZpKBW8I4iUK3OGZNwZilLV2VOThQRJGyqjkVHrDOv2W9Ru7LHAIWlcdN3k5GsdE0H6UF5n/x+6MTkjRnlgAryl6+ruMYxa+2uydKnzYpRDp9JFoeKNTlG+zo3r6a39D3di9KqoQLD9S+0F9Zu/i3T3KswYyUdZ+4xzJBV2IerJyFvBblL1MY+fh6PdlLb9Ncy6UW8ZpxuOR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgLo7cI1iZbqJUYmxI2Da3ewoNyCgzG7pC9Wz2vg5So=;
 b=E8SqS+XNZ6Mid4Dmx/hMvKDOZMBhVnOrwNUA4fCqire6LAq2bmHUlD6kraga6AWet9pAd6aFhZgBOJAWKqCNu2FpNVwg0ifAbbq4iXnF/GY1tewZoQ1U6DUIKYRgVWqW5kzvoTnRlNeKu6nqhZWrdYH1KRxHil+QxJ0jt0TVUGOhCKeNSdNqFDsdT/ZknCrJTEVm9ylT9EJbBPTZFfBUlgxfDlmsipqB0REITneTjGs1U6u68u7IcVki49Lvodcw9YRc1i2xjel85n51rsnbCIBUK68U6an2biYVmPoG7gkOUUN4R99aE8qhkG9DT4H160pj3tGGSAV0wmshhuqTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgLo7cI1iZbqJUYmxI2Da3ewoNyCgzG7pC9Wz2vg5So=;
 b=4crB3zB8NJO6zDCJeMq4e0vEYzGFogBSiT2GU+wvOwj/bYfzrtM9oL3WHmcEBUaLzww+/g5zfBwDbmc+pSy3ytytwwUIBPSx7w9DCJhdM27heaHCDzPTkkyWTVwxUiuQnkmzv+9JFJZR5qInwNOjMyU1lj8wa6lERQBGV+oBA+8=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 15:45:58 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::8c) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 15:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:45:57 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:45:22 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 7/8] perf mem: Print "LFB/MAB" for PERF_MEM_LVLNUM_LFB
Date:   Thu, 6 Oct 2022 21:09:45 +0530
Message-ID: <20221006153946.7816-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006153946.7816-1-ravi.bangoria@amd.com>
References: <20221006153946.7816-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ec4e63-2647-4ede-4c28-08daa7b1dcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc/DabkhHFmxa6Q3YVuguDaURdtrHa2clfVvoh5LdbEd89chS8ZIZGtSZzbg+SYXP7Mp09oFgoReNRp7DPAWH7EGul+aZUuSiRLrV2txq8WtLIDYYU7QLYjArgboXK/rW+z0HYilQorxX9sGdu4qLPoLTCai/ZBdKwxmeNL7JmvqiqAOC39LgPgLYE/9JaMAE6QEOmJu4DwSKUc6QN1zJRflLXvQ0XklNr4JO7i3ObjhfMXFKzfSljfdcLRJsqKx1vymSYNWPH498fICDGu7b8fr5SiM12FFV7YkD8Cm1vmOuaVYQQbz37SWBsVNGA2gjmaF8I+HymfGoYAma1VtWz+ITv6vY+DqFg6bMkpk7NIhW0/Qc+lxkyf2jZz7PI69KBaTQFgWQOydfx0TXtJKNn/YV53qPoYXUR4oHYknMDVtNJl8WUwJBYQTXm9bQ18sPeBYof22Z8OlYGiksjs1fJF2cQxiQJ/kOUZ/IRMEjcWHxW4YFkKYKx5mcSBhV4JxXPlUj5fsn3ukGm0a683pXRePyTsR9OkdpiRl0ZyI3+RFN9p1YfWwnJ/e7PzEZCu+YdFMSResum0uWe7XFh/YCqOh6SS8YxDwnnTewMlWBBTzuqta75n2Hy4S4GZD/eR6ESGGsXUdG4/RO0v2Sm/TwoRW50nbQu9Dnd5srQP3V2ixsyzV1MQo1+Lzb/taSwtsjRDDXFCLwbrUQ1XGSroce5kyrp9VoabCMBRmWhffHcVVVV0N+TtkFNpiZM7Ns2RAVXADAoOya9464ekBEfuq6cPHKQZl9SjqSck5n9skZbY24TpeMDj7B8cDe3GhSqiK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(186003)(16526019)(426003)(336012)(47076005)(356005)(81166007)(86362001)(82310400005)(54906003)(36860700001)(82740400003)(8936002)(41300700001)(7416002)(5660300002)(44832011)(316002)(110136005)(40480700001)(8676002)(70586007)(70206006)(4326008)(26005)(7696005)(2616005)(1076003)(40460700003)(2906002)(6666004)(478600001)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:45:57.8587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ec4e63-2647-4ede-4c28-08daa7b1dcb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A hw component to track outstanding L1 Data Cache misses is called
LFB (Line Fill Buffer) on Intel and Arm. However similar component
exists on other arch with different names, for ex, it's called MAB
(Miss Address Buffer) on AMD. Use 'LFB/MAB' instead of just 'LFB'.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 6c7feecd2e04..b3a91093069a 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -282,7 +282,7 @@ static const char * const mem_lvl[] = {
 	"HIT",
 	"MISS",
 	"L1",
-	"LFB",
+	"LFB/MAB",
 	"L2",
 	"L3",
 	"Local RAM",
@@ -298,7 +298,7 @@ static const char * const mem_lvlnum[] = {
 	[PERF_MEM_LVLNUM_CXL] = "CXL",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
-	[PERF_MEM_LVLNUM_LFB] = "LFB",
+	[PERF_MEM_LVLNUM_LFB] = "LFB/MAB",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
 	[PERF_MEM_LVLNUM_PMEM] = "PMEM",
 	[PERF_MEM_LVLNUM_NA] = "N/A",
-- 
2.37.3

