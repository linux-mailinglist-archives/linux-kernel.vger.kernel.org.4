Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CED706F49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEQRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEQRYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:24:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285CAD11;
        Wed, 17 May 2023 10:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZpTPuEPObJnIqAfdr7f5kGmNPNWaGJodTeS49t7tf53jRIBbccB1Nq9fqoUT5R7bI/K7ZYeFYf8V62CXESVrWxv4DCzLh/fEviDEoJNttaweNSQR9TXlNFH0f4RuJ6Hhsr6x6K3wVYUrb9MXojMiOAmfQKTjFL9IhiExaU7rNnRBq+L7dU/F4fsANtFSDRiBKLHPv1M4wvbrw49BID687l95nDn0nlNBUOFK4GjzbTxZpknx055xQWZmcIo8psTzCcu8JLGjTm2nvfFmSxg1NhV49L12R1a2tdUT5M2YxpdrJHCsLj7xnB5T+001SVaHEpWtmaM9hCKZ/wmrf9TdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUKL6xxFoGMWe5My1o4CNKxLmdNtoRw7F68Hky6CXJs=;
 b=VYUA4DCr3xhPo7kjxm5gaydTw+tXVLslPBLCD49/yaWHcGsPpWEvtSEDiEsGKhn8IvmHhlMo2iwu1Q+FsRSZUaTg6qDipN9DfiwOGOydgzP5N2WesjyjTMx8Qd8SDbPzX1zEnPEnO66bqYmP5zssja7prh7ducGYYPBbqFdSCLsjX06U0+gNDf/4z5nGPYo2AGm9m+GcjjOYrzf5naoqOOkcp5LP/9/smlei1R5Dxqpk/MCtMS7GUEil4b9EkYFLEGshNNPfq6IkVIUE+7ptBY8hCpmdZRBL9m0AKsSYn+lvcym9ciCPbY+4sRtgyWqdciwH3mkFQpIFhZuogtJqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUKL6xxFoGMWe5My1o4CNKxLmdNtoRw7F68Hky6CXJs=;
 b=W08E0Hz5+z3B7qrhGer2CHjCMbiC809U5ScofNQqKMqrTfSM+KiRiDnWbRSxmb8OVkXcCBkBt7H9JBVs/+MGKRhOTn68EP56ON1vr5QOdu9F3nUnXY98ws/wJgUpcZ95Wgq0XNGo1PtAuf2NjnnZGdSLTnYwDI5sfidE2PxLY50=
Received: from MWH0EPF00056D16.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1d) by BY5PR12MB4131.namprd12.prod.outlook.com
 (2603:10b6:a03:212::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 17:23:47 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWH0EPF00056D16.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.3 via Frontend
 Transport; Wed, 17 May 2023 17:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 17:23:47 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 12:23:40 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <irogers@google.com>, <puwen@hygon.cn>
Subject: [PATCH v4 1/5] perf: Extract building cache level for a CPU into separate function
Date:   Wed, 17 May 2023 22:57:41 +0530
Message-ID: <20230517172745.5833-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517172745.5833-1-kprateek.nayak@amd.com>
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: a53fb641-9b2e-423c-2b88-08db56fb7919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EW/wOhQlkJdQh/YRBUL2lCtHa+XwIodO3CsbUm7YSCkYyppClYLuGerNIM82AYEZaqUYzehiy5N+qLMcw3AChAojC36Nla9rcveYDSzNb5kCbf6XTlfHoBAHRb+MF9jVlp9yB28D0VBTlzLUdZ7iTZNrR1LDeUIlMZzXpmVeJUCFnYhu+FstFvf5CFOqEJr5/IDFvw98jdlYvjFmZs2hLgG/nGGxDa9xkMbf7C2h8kI30NpfpI8vmc+HzTwbEWYJmmKD9ZY83N7uf9wyr32lV36N7ebvC/hEma3EkkTOaVTFoV9ldAO/+1JFu+kKKn1HAZIxN25onILDKl9QIYMh2P4xgofXUR4jaQOoXV8ff82BLxekVLgLf5CSFhW+CwmlqR4g/jqe9u6u+qim5jkZsooTt/ICA6eol+S7czA+vSmf28uXOnXNFQ2Up9qmNoR8ltf4K4GxSQynCRBQHrYf+1zYXyBoYxvFZL8wvxTdeIk30X58ZU4U9f7C+8UrDjyRMYk6OpO2RUG+m+TgSA4WnAMXBPJE/IcaH9h1JrSZINCFqM4VhQrYXbrEF+ZjqXW7gxMP8ronVljJR2WdSGhLg3FGkPByUEICWmoUE2WxGLYrOUZl88NUASIpzn5xUCkSFsyipO7aB+yKhacajsaxYzuvHBX3kIhR4Kel32ynzoedlDAj+LAL77m1FEqhUHfviG1dM/gnxC/NVz027ms0/S09u13nMAmT5ucCrgaS54LJiWoEpN5FC3yYnPpxowvYK+XsN56nM3dzv1rRI3qU0G/MAsTBYQKrUXNYA1t9+tM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(426003)(107886003)(83380400001)(336012)(186003)(7696005)(478600001)(110136005)(54906003)(2616005)(1076003)(26005)(16526019)(82310400005)(8936002)(2906002)(8676002)(7416002)(5660300002)(36756003)(81166007)(40460700003)(41300700001)(356005)(82740400003)(4326008)(70586007)(70206006)(40480700001)(316002)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:23:47.0123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53fb641-9b2e-423c-2b88-08db56fb7919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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

build_caches() builds the complete cache topology of the system by
iterating over all CPU, building and comparing cache levels of each CPU,
keeping only the unique ones at the end.

Extract the unit that build the cache levels for a single CPU into a
separate function. Expose this function, and the MAX_CACHE_LVL value to
be used elsewhere in perf too.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:
o v3->v4:
  - No changes
---
 tools/perf/util/header.c | 62 +++++++++++++++++++++++++---------------
 tools/perf/util/header.h |  4 +++
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 276870221ce0..560871736764 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1213,38 +1213,54 @@ static void cpu_cache_level__fprintf(FILE *out, struct cpu_cache_level *c)
 	fprintf(out, "L%d %-15s %8s [%s]\n", c->level, c->type, c->size, c->map);
 }
 
-#define MAX_CACHE_LVL 4
-
-static int build_caches(struct cpu_cache_level caches[], u32 *cntp)
+/*
+ * Build caches levels for a particular CPU from the data in
+ * /sys/devices/system/cpu/cpu<cpu>/cache/
+ * The cache level data is stored in caches[] from index at
+ * *cntp.
+ */
+int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp)
 {
-	u32 i, cnt = 0;
-	u32 nr, cpu;
 	u16 level;
 
-	nr = cpu__max_cpu().cpu;
+	for (level = 0; level < MAX_CACHE_LVL; level++) {
+		struct cpu_cache_level c;
+		int err;
+		u32 i;
 
-	for (cpu = 0; cpu < nr; cpu++) {
-		for (level = 0; level < MAX_CACHE_LVL; level++) {
-			struct cpu_cache_level c;
-			int err;
+		err = cpu_cache_level__read(&c, cpu, level);
+		if (err < 0)
+			return err;
 
-			err = cpu_cache_level__read(&c, cpu, level);
-			if (err < 0)
-				return err;
+		if (err == 1)
+			break;
 
-			if (err == 1)
+		for (i = 0; i < *cntp; i++) {
+			if (cpu_cache_level__cmp(&c, &caches[i]))
 				break;
+		}
 
-			for (i = 0; i < cnt; i++) {
-				if (cpu_cache_level__cmp(&c, &caches[i]))
-					break;
-			}
+		if (i == *cntp) {
+			caches[*cntp] = c;
+			*cntp = *cntp + 1;
+		} else
+			cpu_cache_level__free(&c);
+	}
 
-			if (i == cnt)
-				caches[cnt++] = c;
-			else
-				cpu_cache_level__free(&c);
-		}
+	return 0;
+}
+
+static int build_caches(struct cpu_cache_level caches[], u32 *cntp)
+{
+	u32 nr, cpu, cnt = 0;
+
+	nr = cpu__max_cpu().cpu;
+
+	for (cpu = 0; cpu < nr; cpu++) {
+		int ret = build_caches_for_cpu(cpu, caches, &cnt);
+
+		if (ret)
+			return ret;
 	}
 	*cntp = cnt;
 	return 0;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 59eeb4a32ac5..7c16a250e738 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -179,7 +179,11 @@ int do_write(struct feat_fd *fd, const void *buf, size_t size);
 int write_padded(struct feat_fd *fd, const void *bf,
 		 size_t count, size_t count_aligned);
 
+#define MAX_CACHE_LVL 4
+
 int is_cpu_online(unsigned int cpu);
+int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
+
 /*
  * arch specific callback
  */
-- 
2.25.1

