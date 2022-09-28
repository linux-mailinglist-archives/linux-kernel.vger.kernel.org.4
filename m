Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B715ED9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiI1KC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiI1KCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B37AA34C;
        Wed, 28 Sep 2022 03:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqDN6swDzqUnzGqx6UtyAWc/qmLR/29IMSytxxdo2+KG3+y+NNtC3PiUCGOZ9JS4sN/oxNh3PJF/5dxOBFjjfjYgOyZo37rhemJPxxXTA4jmUefy9sVEDzfI/WEssRWcLJH4Eznza7Tia5CBFh1X2/4XWs16bmLJEnepCOmh0ImyIH4laq5R4MVU0tBzVvyrTOfLTOwr0hVj6rirE245/sTIbA1qHBNtvxGOPHTStkjYRtJO8PQUhOcklPi/lrC6axZ+0CSTfLmZE+5sa5VMzqPKdsRgTIa4kV679514xPKc9bCdHpP/w7+d71n4lNFhXzS6k9h7laEdbR9BxXJwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTsT7cAYA+WlHIbaZPVbX7EluZt2r2wLmzxX3NQIMaI=;
 b=JuM1wphDUwh6h3mlnMocH4z75tpeIPPSSFCp3FafyYaSt9Z0F10AQatQaPpeqhyrD6ehLy8LvcWZTux1bjY8DR3kXh4Ub6dHUPB6zChAVnv2tYQkiFH5tQkLQdjKyVxlqAMJi88b/VTaI7SQ1WSNYXI/Rqzb5V/pxTjR8X0RgEqYH82EQKZLzZaXmb2OxmD7NBnFpiS7KrtLUR/i3fdK7bs5IlHM8g5QAp9rKHl/LuB6FeiU92wZ/77WwCnzkCBGzGa5SmzwdvR6n4bZIjwbijI9pkIi9cU1h7joOY1OWxyFPgkVemPS+DZV2uqTS6mvkEwv2neGGnKdVO8ozFHWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTsT7cAYA+WlHIbaZPVbX7EluZt2r2wLmzxX3NQIMaI=;
 b=dB3+B6LpOuI4Js3DgzAnH3DwdO66Nu1GHefQCayxyeswoC+GPM1wTUHGyu28zFh54VqFfRYukmyI61ReeiC3J0NpWHXjkYoGTjzoW7YcYH06xpXLbd9cRAPWpBS5ywFyDxJ8x1UXyep79xTVF4UlMqInNqlbAZn01NP4pZjqUr8=
Received: from MW4PR04CA0226.namprd04.prod.outlook.com (2603:10b6:303:87::21)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:01:27 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e1) by MW4PR04CA0226.outlook.office365.com
 (2603:10b6:303:87::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 10:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:01:26 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:00:46 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
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
Subject: [PATCH v3 11/15] perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
Date:   Wed, 28 Sep 2022 15:28:01 +0530
Message-ID: <20220928095805.596-12-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 584fa6dc-1a38-4a03-f4c7-08daa1386881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQSw7ugoExJfrVZDpo6EUzwnTt6wRCdF1gy71BqOsbHFdxEm9SnMQmmRibQ+LU6MwEfUODUDgA1LFqdNd5Zuqc+LNDp9h2c7rQEbr5wBVvKKdycEBi/Q9KURFih4WRu1xCwdGbnVNjLHvXEB3fU6YbEbO9Hqv3P0NyTuaMagrUYvh3zQ48oF+ietPgpvQ8JbNzWMDK89Ilj3cZ4dDFlkw7emsfV5Z8eOBC8r/aIO3YZohpa/refKLQGzarjM1aignuQoCGw5sAppXlu81s3Jrbi44fpG29GRGo0HZKyszo7szvRGHoahBgI3GoEIxUNcsS8ZnyP3ZN5PF9wczTljlDVMFctlB+SL94sFegiawXzrR4hwVXFNerwu78BKV4H08pJaQqElHkyYKRgc4IYDbjHGQptGbrsa+WuYS/lGgdqgV86FKc30jOzgaRbgOgWzJHqW80nhMfObN3r0dpBA8wNZ2vjFmcZ1WY7V4mVgeBITTe9OpIMTmTlHwtchxd7aXzYeTGOvjvr65g7ezd8fJbZ28Hz2uLm8P/uvZcDC3tU7L0IrF4IOv5cTo7uOkCN2YL6mUmrGiKoDl+5I76OsRc6xgtjBAVDWWYBgrwSJwQP+7JaJshRdlMixWzDVMQd7r/WjZAywUA53ud24KlWKDtjsJd/tV6HGoo+Y/BCqDKj9ZIPkj7ufFkivFBxWB0a5+ntwraXOM7uk94kMzEMYT24bUg+7qrQNVvRawF90VSWLYVnD7qORKCn4cJX6H5XHXa0Mj6Y2MnwlSf1mCDnWezxTvuXfkTvCaEC1ffgNFIOqiOD7w4lhY8LuJLXLuxrjnvrn+nCapjms6GWMYmoguA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(82310400005)(40460700003)(86362001)(16526019)(336012)(44832011)(41300700001)(36756003)(5660300002)(186003)(36860700001)(40480700001)(2906002)(316002)(1076003)(7416002)(2616005)(356005)(54906003)(7696005)(8936002)(70586007)(478600001)(81166007)(6666004)(4326008)(82740400003)(8676002)(110136005)(70206006)(26005)(16393002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:01:26.7590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584fa6dc-1a38-4a03-f4c7-08daa1386881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf sets PERF_SAMPLE_WEIGHT flag only for mem load events.
Set it for combined load-store event as well which will enable recording
of load latency by default on arch that does not support independent
mem load event.

Also document missing -W in perf-record man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 1 +
 tools/perf/builtin-c2c.c                 | 1 +
 tools/perf/builtin-mem.c                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 099817ef5150..86d6c93a9552 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -407,6 +407,7 @@ is enabled for all the sampling events. The sampled branch type is the same for
 The various filters must be specified as a comma separated list: --branch-filter any_ret,u,k
 Note that this feature may not be available on all processors.
 
+-W::
 --weight::
 Enable weightened sampling. An additional weight is recorded per sample and can be
 displayed with the weight and local_weight sort keys.  This currently works for TSX
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 653e13b5037e..a222268cca3a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3284,6 +3284,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		 */
 		if (e->tag) {
 			e->record = true;
+			rec_argv[i++] = "-W";
 		} else {
 			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
 			e->record = true;
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9e435fd23503..f7dd8216de72 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -122,6 +122,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	    (mem->operation & MEM_OPERATION_LOAD) &&
 	    (mem->operation & MEM_OPERATION_STORE)) {
 		e->record = true;
+		rec_argv[i++] = "-W";
 	} else {
 		if (mem->operation & MEM_OPERATION_LOAD) {
 			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
-- 
2.31.1

