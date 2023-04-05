Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDAA6D8494
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjDERLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDERLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:11:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642065267;
        Wed,  5 Apr 2023 10:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCn4htMqTesnins94FAAIlf57CEkqTzXS3WhKA6oBDi5cDtGGTCqNrXVAlDmM7IYn3BlsQXm3TuzNBF27B/+b+RKxNjQ0Qdu2VWcEAe32gfQeJ3DkKj8WT7P1a+nQsu7DUur610T9MSd7bFfOJxqFXqPx0Ngx0xD7dmZ7RP/jVX5NtOIf5esHgWYEXLBiRdAGEfzBa6dTROVqxdYDkhK8/osOabvTZ0Sj6kEVVmYtyjZwWfVbYazv0hbbEpBgFKlj39G4O6mY26gbkTE7mPft/a+n9qzsWSpnkHYJPd3HI5FxlnEcV4q3loiP0VBraup48KZNTtC6XGFOv9gz7BURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsijeJZmyWCxn6PdG9cXAL0f0bD/ZUsY4mEzR+dEJm8=;
 b=BuXr2Ys+nm3fBrv4gTnoHwHBKiyt05pZV0SPouFrMPh29Wc3+8hCtfBMBp90ua4Ukr+PioATp8dXC5321noU6WDRu3QMymJeXNCMsVu77lHQHAAN/V8l9PukTPSBx2PeA2CFdPzqm4BWT/OAcmjYjBb17WO98EgEvBeQ+uXykiyqU05ckg6Zvkqr80IKay5enc274thvUkduz+cU3Gf7+n9rJXnGLdH6kf85HCd7wbIV4gNcLSFsYxMPplrshz9pw7whpx79qRKMQXARkL8aZbSg68xuQYOfdqDkw4GhYsxqzQ1P49tyqxhe5tlAN0c4wKPiicxkiK2wrJ8fGapXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsijeJZmyWCxn6PdG9cXAL0f0bD/ZUsY4mEzR+dEJm8=;
 b=G1Yehnx74yb7gsNkvHwpbPEVNPxiUj4NlsLKiXWEXKyBpfgYkGC2yqTHf8tvyQOA/9ah0a0+nQ3ixLfCy0tgdihcNzFfhe//aGgaYkDTMb+4UkLclpc+EyNKY18YCg39ZFRQuWgDmDrt2oJcuP3BzStRfDoHSZOrQZ2vRx+wT3s=
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Wed, 5 Apr
 2023 17:10:41 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::e7) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Wed, 5 Apr 2023 17:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Wed, 5 Apr 2023 17:10:41 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 12:10:34 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <puwen@hygon.cn>
Subject: [RFC PATCH v2 3/4] perf: Extract building cache level for a CPU into separate function
Date:   Wed, 5 Apr 2023 22:39:05 +0530
Message-ID: <20230405170906.2510-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405170906.2510-1-kprateek.nayak@amd.com>
References: <20230405170906.2510-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: f96774c6-1933-4249-7201-08db35f8af78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjIwu8BNzJEVN+ImpgUYS9i22FHLFKnCaweIVe7xtjAClVLcItNGoKr1EULWoeHDhdwo434g4/jgOus7GXg496ANDuVe8uNfFs0LMnKGTmFI4Uu/exHj8DVRqDKuLjJpyNYNwt75oSPU85XOsTCZOzBxiETwI92eD/qZ3mTpqkySUfL40JP9HIMC6s3LQ+D689DaBn+vSIAULKXC+CLPIB6KsH8LqW8iurfT8IVNDIjhZJ5Ccr4q71SF0t/qVbmNVboQqnixVUO3T8Twb2yaMzGXhgRgXEcSfMmsGnlIIhEY598O2Qu9QL3eaa+POK5N4LUB2vzyFVGBdspiHrlta+T81iPcwYFvOIHLZHLjmrjo3NHVmoNK6Ed0mTxgNMOzbkRl0g63RejyOkYmybgpW9i2f8WbKW5KKjPhoP/TlOhYyugPSj95judgMwJjAL4nyrDdTbUjZj3RuiZVYbZ8ehASWyGOgLHazzTmIEOLDmI21I6nFjP3qdamG+t/iLHmNtnQlBuFfpEu8l6GfMk8AziMQWVfH+HsX78zprPoj1+sDRTG3MScE4xUuQ9TEiW0cFf8AW7HQsQS9qvmnJNttJgnHmAnio+gZPnv01xM2hN6UaKhwfIjk4FrdRpOGq4+GkyOHgkgF1i/rG5UUSlE3OEdsa9X0fKa3epVK7inYl+AFE0PHPr6zOsJyDBgxgw8G1Lmc/GkpWkiJy+TNArC1KMuJQZboY3Ii5BDqy2D/C3jMkqdfQUSwt/Xd/wQlY+C
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(356005)(81166007)(7416002)(36860700001)(426003)(47076005)(2616005)(82310400005)(83380400001)(36756003)(54906003)(316002)(478600001)(7696005)(40480700001)(86362001)(40460700003)(26005)(6666004)(16526019)(186003)(107886003)(8936002)(82740400003)(41300700001)(8676002)(110136005)(336012)(1076003)(70206006)(70586007)(4326008)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 17:10:41.4812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96774c6-1933-4249-7201-08db35f8af78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_caches() builds the complete cache topology of the system by
iterating over all CPU, building and comparing cache levels of each CPU,
keeping only the unique ones at the end.

Extract the function that build the cache levels for a single CPU into
a separate function. Expose this function to be used elsewhere in perf
too.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 tools/perf/util/header.c | 62 +++++++++++++++++++++++++---------------
 tools/perf/util/header.h |  4 +++
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2daaee5065ef..357879dd8333 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1227,38 +1227,54 @@ static void cpu_cache_level__fprintf(FILE *out, struct cpu_cache_level *c)
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
index e3861ae62172..94cf2ffb6e60 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -177,7 +177,11 @@ int do_write(struct feat_fd *fd, const void *buf, size_t size);
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
2.34.1

