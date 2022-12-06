Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7D643C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLFEdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiLFEd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:33:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94ADEFA;
        Mon,  5 Dec 2022 20:33:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPeeMTBSQXq9qphVngJgsLD2yqK0XPY9F70ag+5V6F9JDxzR6sWA1WvRz//b2wGnuNFTeXfvjl1ffySi4x9xAbjAqQLGGl4IzU9aPC/zjnxg5CfbanuDjLHeHSaPoI+63pnxWUjLX201M8jBEZMhw0qt80qXfZhJi8S0YGf6xL3TjdcH6NFpKSJMOGud5hDW3yuNgJk0BNZTOCba9kTkyiEmObIgRBVRCpj5gvVgmEWoZcS+5YpLZN5Y+Norkl95NRz9VSEgDPjI2596UyBkfHPjaijEmLaZtpH3V2kdB0n1Jhv5VSB8dsMbbPCUZorOAhYLjWtl4Vqi4kgAFxtzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn2eHAW3+evJNHfYoaB1JSpQ9yt9o0ZFV8ozXDLJipQ=;
 b=bbhgRwHlMyo+N/r8pK6qHrb/IdFDlOEG737W4ogDArBZw8GmignmfkaTVy2rzQx1kHVT8LRnzkUJUkCwfe3WsCFJ/HbsVKmj2b+QhK/JLB2tbOcW2++THGmTIAwI9fMoj8QH9PVPbvDQzBH+lqeCnnb4nz81ACSer2y96U1NpTp09I7atAnntw30qnq09AdA0xgOUFC7zoa4F4f/5WYhCTIbwz0QW2IGlyFbJfNoJOd7EbZA8STk0/yztPkQYd1JC22FuK7cyPyZOpF5PrI9AEAGzGk2HXfRE7fyxDV9qsH/9Mp3HgAAI+Zl2wtPErI7lTla3recZZsubVa7Ezjm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn2eHAW3+evJNHfYoaB1JSpQ9yt9o0ZFV8ozXDLJipQ=;
 b=H8/MMOZicbq8K+RApQmR3lF0g9+AT3UAtu5VlmVQXaO9N38iaiMXrlqf5fnkWSb5KzPdZan2wRJ8B1xwsd5jbmpSlqg+NG0hSmy5PxBXqO4ERxkQSZg9IqhcJRZ6vpU23g8Ve+v2W1GedrLaLTZy+4Y74iO/S/aavGmEUvt/9Yo=
Received: from DM6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:5:1c0::45)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 04:33:24 +0000
Received: from DS1PEPF0000E656.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::8c) by DM6PR12CA0032.outlook.office365.com
 (2603:10b6:5:1c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 04:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E656.mail.protection.outlook.com (10.167.18.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Tue, 6 Dec 2022 04:33:24 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 22:33:18 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 1/2] perf tool: Move pmus list variable to new a file
Date:   Tue, 6 Dec 2022 10:02:36 +0530
Message-ID: <20221206043237.12159-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206043237.12159-1-ravi.bangoria@amd.com>
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E656:EE_|MW3PR12MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 85961962-d081-41e6-5fc6-08dad743034e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w86cYIv/Z+UbahURrA9b4StCd67wPs5QIX81TWEibtWKn3+udbYtgyOkF17/l5OeCmtUFhKMqoGN1hfoMlddLlUFfMbT1lPpMsmvxEZanZVs4/iRe3NJ9JmDS3O2PkVGchH5IL0b3vRxdxuhEel9TIdugBudOIuiR61SwukAB/6B9A0F9boC2J2I3KkmT2Xz0Z0Z1SqQ2H3NVHsyxhzHZ9QdvSRL1h7fp0ehEpw+gLBfVdXVZa4ipdGrzjtJVwBToiaGHrQvF/5o21qOnAljy6j2hPirlhxfnLor+muFgdPDP6AYjQvfP6p1had9hhoWVSzcl6JM6GMDLbRw7uN+/ebkAJQyDPuyb74AqBybLqffi6muEvWJ8tZtVWnTnciFvYztYjAJilFcETxi4jf6D6MLkYUVhve4lvrmWxBHFSpNMNNm3Ceqa4LwXgkjFE7fUZ1a4fI0XzQIoOAPryh99sDj1sPS5EMHFwxukeEUVPuX7EsEX50S5SGlcLtp6b8uPqYPZKzvR+/5uP/KMFqMt156y7QJDbllDGdqL7s9HGw3RXC2JsITTyKremzcEFWW/+nwwK2Oc5FAX9jGUPcTZtjBVapLbd5/+6p/ZXLwq7Hcoh12HWQGKsok051wcw/TnQf5VZnWdGPFm0eVERLFp3qgtXkybLMhRKH1f7yBt1xpHuHwTikdvHVFrMYzMugsYcxjflYzw7C8M36Mk30HLbfRdOUdFEPaxBAtkfZfMfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(5660300002)(356005)(86362001)(81166007)(8936002)(2906002)(40460700003)(4326008)(41300700001)(44832011)(7416002)(36860700001)(83380400001)(70586007)(70206006)(54906003)(316002)(6916009)(2616005)(40480700001)(8676002)(478600001)(82310400005)(16526019)(1076003)(336012)(426003)(6666004)(47076005)(186003)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 04:33:24.3813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85961962-d081-41e6-5fc6-08dad743034e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E656.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmus list variable is defined as static variable under pmu.c file.
Introduce new file pmus.c and migrate this variable to it. Also make
it non static so that it can be accessed from outside.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/Build  | 1 +
 tools/perf/util/pmu.c  | 2 +-
 tools/perf/util/pmus.c | 5 +++++
 tools/perf/util/pmus.h | 9 +++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/pmus.c
 create mode 100644 tools/perf/util/pmus.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ab37f588ee8b..d04802bfa23f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -73,6 +73,7 @@ perf-y += trace-event-parse.o
 perf-y += parse-events-flex.o
 perf-y += parse-events-bison.o
 perf-y += pmu.o
+perf-y += pmus.o
 perf-y += pmu-flex.o
 perf-y += pmu-bison.o
 perf-y += pmu-hybrid.o
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e9a4f31926bf..f5e10f41c042 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -22,6 +22,7 @@
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "parse-events.h"
 #include "print-events.h"
 #include "header.h"
@@ -58,7 +59,6 @@ struct perf_pmu_format {
 int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
-static LIST_HEAD(pmus);
 static bool hybrid_scanned;
 
 /*
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
new file mode 100644
index 000000000000..7f3b93c4d229
--- /dev/null
+++ b/tools/perf/util/pmus.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/list.h>
+#include <pmus.h>
+
+LIST_HEAD(pmus);
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
new file mode 100644
index 000000000000..5ec12007eb5c
--- /dev/null
+++ b/tools/perf/util/pmus.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PMUS_H
+#define __PMUS_H
+
+extern struct list_head pmus;
+
+#define perf_pmus__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)
+
+#endif /* __PMUS_H */
-- 
2.38.1

