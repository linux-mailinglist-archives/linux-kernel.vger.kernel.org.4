Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6302163BEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiK2LUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiK2LUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:20:21 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51B5B5B4;
        Tue, 29 Nov 2022 03:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd93pVe+JNrs871aCtBMwnRjTXm+ITr+NY2M41wI5jhQZluQc/JhjtDCfJWLfNgGA8J7JhWko1Csa/IE6sS9hlN1MMcGcG8M6roBpi5A6akTxA5OFJRK5JbgdQXuluM1pOPv2JBNAwFmXjcXUIluRSu/cj2PhR4NE1biLSrxzW1AoSCwhsFZgWCg84XXKk9iBs03R4uYUmZ2SOM4Jt5F3wIdi5h18meQQD5HjBSQawtAe2p718qCe01KIPupwduLIwZwR+6/IEeOS3V87jn/ySE/3jwS46fcUv5MiJlKCvQ1m2bk4Ss9/4V8xyc1Ph/D3U5uKcblDerfjaNp1IioNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn2eHAW3+evJNHfYoaB1JSpQ9yt9o0ZFV8ozXDLJipQ=;
 b=dtkE0M7PJxe3xij1rYPy+qZjnc2MAkUWl9xzwHXT4FOQ4PJyrIZx5Row7v6xZrTmyRQvF4WAAlpwnYs9Bx/pvFG4TUwHjY5cx1DaufoXXTwPUgRTHmYaHChmXbGO2wrcAElDkM3DBZPLkYOSu8sldHfGOYQ0GWMNFYbTEAXnPwLFJzhJqKuJn8Ade+4frAFkNXwNWAJ8nWyTXeNcqmFlL0Ac+6UeIq46XvXDReH1Z9rqJZf2l6gouJugpDb8fcj/hvjZhgZ5wUO1Fu9RHAWmTyfwPh6C7sGE9zhtDjSQqWIshWByyWWRoyTkzbnOpjgdNrCvpUzqIGPZFQju7a4Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn2eHAW3+evJNHfYoaB1JSpQ9yt9o0ZFV8ozXDLJipQ=;
 b=g5B7fOaI9T5wQkYcC9hAiQ7D9ptAi91tvbGNrBxAlA+O0I9x+U08hLxKsGnY0+fGmbFdkLQsKhxWcROADqhmTwUcJfPH4PD/OUCDshqrMB9yoOb9T5b3YXQzsktbeA3ApqGUNoSILuTB+JJvutBGAiHajgIBAGHrhzszJE9eYVA=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 11:20:17 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::61) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 11:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.23 via Frontend Transport; Tue, 29 Nov 2022 11:20:17 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 05:20:10 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <kan.liang@linux.intel.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v2 1/2] perf tool: Move pmus list variable to new a file
Date:   Tue, 29 Nov 2022 16:49:45 +0530
Message-ID: <20221129111946.409-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129111946.409-1-ravi.bangoria@amd.com>
References: <20221129111946.409-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9958becf-2adb-452d-59fa-08dad1fbb1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VeKvCP6ZurbUDaVrBDkCpzvh3Tgn9kDjBFAgRaWTd/NUVS0g62ZmC/9Yi1USf+sTEcd+/gn5B5cbooH0XA4uzu228zZSLrN8tQoVigwmeldkCmKMJ92joJ1OUny+uUTZ9Qx0/pt3UkXEuiF+SlomBZkVcey/15JUHi4UeGpEq2TwZEfTDyQsuLn/OjUT5lqlBVNJKXm7FCOfiIKZucHAfN9bhQ8fRToyXK9CRGpQsfrsvkcEN+Dcdfi9khphdeLsgsXA879iEaHx5eK3JjVZQxua9olXlvDg/c5E6kIppwM4Z0qHynznowHrGXasu7rU3N+AyOVsVu9PMxiUg9RE3jS01vJQ9cMqssMvzOogYTTdcuwvNwzTYGst8zUqsvntgsMYLjhdPWdkP5dbGLZ1PBvHPwNmShS+nN7fiyMoTWfi50p2+G2HXYgdknYGhD3u/79lrPwzgwZVsF6gA7A6ZDbycLDxfDVFgpReo2n+mrwkgRPqPG4D3KmmyoC4utnzDrG9D+jtiFkwXBC9M5iwbpY/QQ2qNXvsrgmQEpDjZUYHB8acFLI7t247qWGNpC907/HvrcdldbwjRrW9o0RuCs5Vxt/04W1yQqHlPi9fy1THL+ssjC1WR8qRAgwu7ix41eLX+Voz0XY54Bx1qSPVdMFPjmxbmKxPCkPzgO//SkpOd0EX9v0oIjOdN6YtvGBOMty/Dkaob7oGqp7IVhRhSufJC+ujb00MyT7JlZLHMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(356005)(2906002)(8936002)(81166007)(7416002)(44832011)(40460700003)(83380400001)(82740400003)(86362001)(36860700001)(8676002)(4326008)(336012)(478600001)(316002)(1076003)(426003)(186003)(54906003)(70206006)(70586007)(6916009)(82310400005)(41300700001)(5660300002)(40480700001)(16526019)(7696005)(2616005)(6666004)(26005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 11:20:17.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9958becf-2adb-452d-59fa-08dad1fbb1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

