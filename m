Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A82663903
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjAJGD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjAJGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:02:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1948CE1;
        Mon,  9 Jan 2023 21:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehPpLxZ/ZS2WST2ruonfkY+kNksPJF1pu4CRpPyyR9L8abrboGjApfCg4spmqMf+o0MeckrpJ4lUgnHyw4hTk6RHlrquFirIbfsLd3gOdJbefxciRv6HcTRqdaRvmunh96hubClknHbumMrPjP3rZFOQojgJNLp6HfXEcLTTXq3sSCNH/b7jZbrALBBqkCD/rl10N5DKgDLww//WecMw6lfwrTMVVQkpE9yxN5aBzhXgwmscx2akYLwTGCzDH1UrznGx4WFT7GVyKbMyWPdC1+IQEQJJ34yz3jq5bc5EhW9L2yHd5w6VfkOag45VL+Uy8kpQBdHf0y1XfuG9KYb4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsZOsxzlaz0o+ApsGirtAAXdkZUpM6cXKyEOUMEUsRI=;
 b=Bla25pmq9bBG2Lv/yO8MCM0wANr4dWli+6NKjXy+pAfdBzZ42PEpWpR2MexjPf40h/bzvzxW471MnzHqxppFPAg6FFb8qyPMdHlSBSCixQbxouYfJtsRKgEMrqC080ezVrvCcktN6luQs+HvNh+PiMSZBW4sgS0keU66KzZZYPofD+/2JCca2xaKMQiCjNYGw4jpxPDgRzUDHF4KaSItAKaDKmQtVqFVE/lvlg3y3Ydg8M8R9JngwdHpCwIiiWWqAqSkeMLmCTB6ggpUgKopa3MEz1iEtkXRkFbBZYQW/7Yg4Gz6qg/3a6qzyLAsEhIYq9ViuzFxCoEoy7k6WTynLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsZOsxzlaz0o+ApsGirtAAXdkZUpM6cXKyEOUMEUsRI=;
 b=lCLN4qE3aCnlEhsoJteaXSI1ghahErCnbSq7o1gRGt+fGJFqeFn6YFp8EaqiXAueLYecj1+V90uUnk8vSc0MMVDddKhfqjUrVpUIsymn2jGl395yaYgC+vEkToAkfnaofB5XcTfHxB2mvjsZpuYFFLDN+YGIhiGbh1BtgeqtgEg=
Received: from MW4PR04CA0318.namprd04.prod.outlook.com (2603:10b6:303:82::23)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:59:40 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::66) by MW4PR04CA0318.outlook.office365.com
 (2603:10b6:303:82::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 05:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 05:59:40 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 23:59:32 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <kan.liang@linux.intel.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <james.clark@arm.com>,
        <german.gomez@arm.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <alexey.v.bayduraev@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RFC 2/4] perf tool: Refactor perf_event__synthesize_modules()
Date:   Tue, 10 Jan 2023 11:28:57 +0530
Message-ID: <20230110055859.685-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110055859.685-1-ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a45fe0-2340-4a66-b279-08daf2cfdcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pR2K2o7M1su4zFcaYPsWGQGcILkm8HkB8aWeWrDbGoPtdL91QaWFZEBCTe9ZwEBm7Gd2E4DzF+rFipJ5nPs0vhHdAvReYu2wDXP6e9nuosPeWNCUncirBzxjsE4z6KWKo0tHJh1nM+42bUafdgzjugb9vdMF1mDRODxLybLv8DJZ0+3fVy4vpJRYQ/h5oxNDrAsl82GvXxYDfdDTbBvvD0iiJqnaPuHZWq/Q8use2Mtv2Ejf5fhhRoDapNNrQL92vEN/ZQxqQ5tQLhb8sC4AaxEnS0dlsQ1qqjQ7byq7es7H0DoMddTEtZXi7QANuvt0Dq1eyuPyhXQETC9CZ/tHlwd6Rz2Wh8K8vbSR/PVBGi4UBUh1a+E74UrHBzp8/qwrFCNOQo/6Gyh0XbqVkPTrOA+lLfgS1aHxUypQgxShrf77jsih8O44wTk4hpVoMPeJTrK5armxZpQrCEQqbWss92RP8Nh4ymGpe7U8JcSjdMCtS4BxUGs/20+PBheeymLHbVvdZ/edfzL81vWtBpVoRpXuArUFmzJePSMgpgHttj4HeIhz+xsN9E0ajWTKn27CRq+l3rgx6CV+WB04RZ/iH5c64l+S5AJe/Dnwjkwk520GS43ujR6jQndPGXIr0EcpK3RYAcmTHkq9QhXUv8nPErEFmM2EGB/j6kIyntgt5GHOMU1zLgkCPQpAN7iO4VOMyt4weh5yzl6F1VQAA7z164W+1I+KIScx6FKFVClCjO++rzVMciysDCQKjvByIngkqqKn+BHfgYijdRLRhQ7cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(478600001)(6666004)(40480700001)(2616005)(1076003)(336012)(4326008)(26005)(186003)(70206006)(70586007)(8676002)(6916009)(16526019)(54906003)(316002)(7696005)(36860700001)(86362001)(40460700003)(81166007)(82740400003)(356005)(426003)(83380400001)(82310400005)(41300700001)(7416002)(36756003)(5660300002)(44832011)(2906002)(8936002)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 05:59:40.0118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a45fe0-2340-4a66-b279-08daf2cfdcb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event__synthesize_modules() synthesizes MMAP2 and MMAP events.
Split them into separate functions.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/synthetic-events.c | 77 +++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3ab6a92b1a6d..2e145517f192 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -665,6 +665,50 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
 }
 #endif
 
+static void __perf_event__synthesize_modules_mmap2(struct machine *machine,
+						   struct map *map,
+						   union perf_event *event)
+{
+	size_t size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
+
+	event->mmap2.header.type = PERF_RECORD_MMAP2;
+	event->mmap2.header.size = sizeof(event->mmap2)
+				   - sizeof(event->mmap2.filename)
+				   + size
+				   + machine->id_hdr_size;
+
+	memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
+	event->mmap2.start = map->start;
+	event->mmap2.len   = map->end - map->start;
+	event->mmap2.pid   = machine->pid;
+
+	memcpy(event->mmap2.filename, map->dso->long_name,
+	       map->dso->long_name_len + 1);
+
+	perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
+}
+
+static void __perf_event__synthesize_modules_mmap(struct machine *machine,
+						  struct map *map,
+						  union perf_event *event)
+{
+	size_t size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
+
+	event->mmap.header.type = PERF_RECORD_MMAP;
+	event->mmap.header.size = sizeof(event->mmap)
+				  - sizeof(event->mmap.filename)
+				  + size
+				  + machine->id_hdr_size;
+
+	memset(event->mmap.filename + size, 0, machine->id_hdr_size);
+	event->mmap.start = map->start;
+	event->mmap.len   = map->end - map->start;
+	event->mmap.pid   = machine->pid;
+
+	memcpy(event->mmap.filename, map->dso->long_name,
+	       map->dso->long_name_len + 1);
+}
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
@@ -695,35 +739,10 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		if (!__map__is_kmodule(pos))
 			continue;
 
-		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
-			event->mmap2.header.type = PERF_RECORD_MMAP2;
-			event->mmap2.header.size = (sizeof(event->mmap2) -
-						(sizeof(event->mmap2.filename) - size));
-			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
-			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = pos->start;
-			event->mmap2.len   = pos->end - pos->start;
-			event->mmap2.pid   = machine->pid;
-
-			memcpy(event->mmap2.filename, pos->dso->long_name,
-			       pos->dso->long_name_len + 1);
-
-			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
-		} else {
-			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
-			event->mmap.header.type = PERF_RECORD_MMAP;
-			event->mmap.header.size = (sizeof(event->mmap) -
-						(sizeof(event->mmap.filename) - size));
-			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = pos->start;
-			event->mmap.len   = pos->end - pos->start;
-			event->mmap.pid   = machine->pid;
-
-			memcpy(event->mmap.filename, pos->dso->long_name,
-			       pos->dso->long_name_len + 1);
-		}
+		if (symbol_conf.buildid_mmap2)
+			__perf_event__synthesize_modules_mmap2(machine, pos, event);
+		else
+			__perf_event__synthesize_modules_mmap(machine, pos, event);
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
-- 
2.39.0

