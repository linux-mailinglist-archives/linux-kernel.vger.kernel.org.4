Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245845F6AED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiJFPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiJFPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:45:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DA34999;
        Thu,  6 Oct 2022 08:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUaaYr8mPXRKorHU1q2HOfgoIgrP55BiSsAov06wWh0l9LP29SU5JB56WFyW4VP2cAcVGv7mIyia2lUL9rYkz2oGwwIchwGAActK3UofRCIYZxHcjwWCqy14EXwxpYelkvQ7wJgUR1e2YrbdjczYS4TPNuVxWkIP6Iw2UUsrcgsPpv5SBCfHFDJmPaabQxZ0g6Y96iZQg+O1feBEGbvr7VpMgCc119YdfiXg/Q1YSstZSPAKZ6aLo4uqwusF8PxYGjYK+DWTpwUrfRlLDgyaT/QStkOsCMYjR7jzgJvBUlQy5qu+erPEzozzatsrHm4zaUCDMfWMvkyYiA9/J/0STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crGp8LoGEngcYe7IBhi76gjownsZdMuHky8kCKMdi7k=;
 b=cagVReGbN2FdD70i5BpZi5lfawTOeKEcHLxzPLn9vdwkyrUXFS1A1z1RAnw5shnaGnqGmv+X2pZKvd62dPhPBVsxi7MFfH3z0uVxbrbjs8ZLAvZUyO57UDMSftNX+GSlIooZ0brvLvyVG1xMSbCiANPVS85DNU2/DVKi69rFm5vUl3ZofRCRCE4z7/sYav6k2nR9Nwxd2ZCltwe4j31SpfWj6nFtfxXwRtp638Ixkmzr3VjDrdlxllR4X+EGzULPuwGBkPZ2dmxc8tEUE2iT8VBCd0zHT76bE8ZVycgz0gauRJJqwOqIid73xxKpXlebEZPEyO3GCpprwtjj6YUUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crGp8LoGEngcYe7IBhi76gjownsZdMuHky8kCKMdi7k=;
 b=2HARIK9D+aqkuKqORHVfc4Ep5FCBs4Q08GkeRW4/WyOyGJlVmntKK1cJ5g43hzL8328Wsb+zcz8zdwVJrCYXydFEnkzzLqrTJ1B+IsGKRaPvwICSM2/iCJcOpr6hdaE9AS1wpH5uGf5qEbCuagy8xYRO35dCKDqRLrRRtfy4SVI=
Received: from MW2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:907:1::36)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 15:44:57 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::62) by MW2PR16CA0059.outlook.office365.com
 (2603:10b6:907:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Thu, 6 Oct 2022 15:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:44:56 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:44:14 -0500
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
Subject: [PATCH v4 4/8] perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
Date:   Thu, 6 Oct 2022 21:09:42 +0530
Message-ID: <20221006153946.7816-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: afaf9685-725d-4b5e-c432-08daa7b1b81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaixgDqe5DLb6et3UQPnOvHvrwU/AyJVFtrcnTfTn9edgdQACAT+4Srny+NOwbLpfs6P/sCUCu3YUO7asWRHAEcb970mq2zjN2ksukuDZevgewKc9P+iZY+//zAOJ5LuzdmyGH4ZkxkvsUfAGIJTh89JuULuRBauxOQbRvvtMPQpphxIDk+7frboZuP6Y8WZd2l4JueCF5MAdvgyxMsmi7TEZjLxnUHlgUIwhaYM2kY/PLyALTFUnhg+utEDV5v6r6S8zGv4ppMgXUpGiHXcHrUl3mnIOA1rYY+3efAzFce+wwARJlwCBcmhCzEQ4BiEtN8btwrR/Un/8/mHmpq9ZcwcwBGpj3kZO/0XHAOO/cycpMB9FoyT/qOCcF2it8EKQ5Cx/bNsgby/WwexRejSPkFGwlJpmNLwofe3C/KHnqRw/woFKuhi1c56y2O+CKASazAdU1YSvMesHfGG9IIhDjHVWLR9y1/muOcy6wLw+mAd2BXwzeCtKA55kz2UVHpgENu9mxHgy9da4pofUGFOJxI5beDT1cqdFe48K+uEhDCbrvL0tZIVry9kV0Qv/7fMyKBfhG7a6wHSLj4Go8oMjtF+gGsOv6GAYxd5ebexnsGXSvMlRSXZ/MnrhI0xxYWjyGeQZGTxDJalr5SQmJxAtPCfqDEvopLeWi2XJlj2cOIWy3s41vqmFnZDgH0KktDS1yS62zUKAZ+ZHaXQ3IHCRV/wV2cessrwWpvKV5QUTOY68hoklrZAuFt3QFfN3ia4LB3VEJhi7EJncttiF8dMOAixdOV+U2ViI7JZClZ0RzOA73v9kmYDsljDXWC7pP4MWPLrUIOvn9U3iiRtFnAKE9my8itc/7K2XFQ+nSLIL+CHimnm6iraAtRltyt5w07i
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(8936002)(7416002)(70206006)(316002)(36756003)(54906003)(8676002)(81166007)(478600001)(41300700001)(86362001)(44832011)(70586007)(5660300002)(4326008)(110136005)(36860700001)(16526019)(356005)(26005)(2616005)(1076003)(47076005)(40460700003)(186003)(336012)(6666004)(82740400003)(426003)(7696005)(40480700001)(82310400005)(16393002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:44:56.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afaf9685-725d-4b5e-c432-08daa7b1b81d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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
index 378f497f4be3..e41ae950fdc3 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -411,6 +411,7 @@ is enabled for all the sampling events. The sampled branch type is the same for
 The various filters must be specified as a comma separated list: --branch-filter any_ret,u,k
 Note that this feature may not be available on all processors.
 
+-W::
 --weight::
 Enable weightened sampling. An additional weight is recorded per sample and can be
 displayed with the weight and local_weight sort keys.  This currently works for TSX
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f35a47b2dbe4..a9190458d2d5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3281,6 +3281,7 @@ static int perf_c2c__record(int argc, const char **argv)
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
2.37.3

