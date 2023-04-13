Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85636E06D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDMGVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMGVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:21:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8696583;
        Wed, 12 Apr 2023 23:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqmzevPjQS09i8q6qHxDeuyc3y5laToVb1CZ7cyxGKjvFfuF6jnzuydhoHbYYdmSHdQHqtLbs1zn+h+iRzjGrK/ahsS+gcSDZPO7MV6jjsDvcskpbGvd+3a3UTKZKZDMDZnG7mgO6dq0c+c5PUhlThubVS0FfqX7CY9zhaglypCEzyDb6I9VtwRVdCtVNHNA92RHo/clqx8jeIrs2ID3xAtu1dT5XW/+xOpHZo1CPQQshilLtiYFCkJxH2pC03kHqX/lsfwS4XvWzUKJ1LDTyx55XEgx9vANy/RvYlwAGM6S61jbtkvGVjSn6/UvBS2zE9jwVcaUdpigB1jmo89eCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7qD4n9rjXboiSJ4b95GF+BVTS4RwCauIQyilA+ybTA=;
 b=Wu17e8CwDthemRR+YRV7/zs0rVa7rrMekNwdDxxjJBPDFzy60wuS1yFyyDSjZNWiUCNHdd9ZdyTEJeaLMlAnj1vQoQIYJ8ql4X9BJ4+239ed8OwaYPEHQBFT4mgowA6vjjt+KycyYjrC5lQG0jx2COjYE6XsKDIl2jRJ1vSjMx29MY5k99DSCm1Gg1vI5rJXzyKf1OunuW1RFYattJnnJ46JQstxVmLRWQECOerPnLaj0+nOs/lwxIiYVMyMAaBU9rkcvF0ttrCYI9qH8fMsJzgjwbrxweQaqF012zdqHcpOxm14wIHO/6D7n+peGdnsV46q9zsGnea8dIiU/EboDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7qD4n9rjXboiSJ4b95GF+BVTS4RwCauIQyilA+ybTA=;
 b=Znm4ooIBpDS5JBVt/HY6u1qkJa7ukD7iSLmC0RZRq+QPKEjqr2/AulCppsQj0f66b1+GqTQ63BigdvbMXv1QTsB1Pys23JluDSSv9R9BvV/EeqDFULn3oVwQuYmton4CYMKr2TeZXdmnGesj/lr2OZjN8m2+HTiT9hdVEIq6CPc=
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 06:21:31 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::78) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 06:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Thu, 13 Apr 2023 06:21:31 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 01:21:25 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <puwen@hygon.cn>
Subject: [RFC PATCH v3 1/2] perf: Extract building cache level for a CPU into separate function
Date:   Thu, 13 Apr 2023 11:50:05 +0530
Message-ID: <20230413062006.1056-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413062006.1056-1-kprateek.nayak@amd.com>
References: <20230413062006.1056-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: dd95779d-342c-410a-8c9b-08db3be752b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGD3+PsxOXEt/IyFfG//5lG+sL02wm5K+SiwaOQN1HcKb7YbOhMPHpdD7idpZRAGkzTKbfO+dFBEGUSo/6mDV+ueQROcm2Lc1jR7VkoArNdHZKfINRYhMJJ+FSPVpjeONQtrFmJQCx3ZOfVeSbQgvViNFNbnO+BD6nx6sWPDZ1ekQt0x8znhvuV9wcvEdlsTcgnkDAsKeL2X+LFELifdyBNaadCK10gOQZ8jwyv+jsTCOHcdYAzSOPBd1nFVduINuLE6H4oudKA4ZUu1GJjvHi5Q1HQk7WbeCF1eoqqArqPW6Z7rqa9n9LtC5cLOs0XBjBE83V5TVBWSyds71rWCzGErg+EPhuzLgkzagPB5x1jkJ0yf/OHksfDSFQpSDE95LIKc59qFM8IyFozJM7+01qmopVxemdx9YnTKirOUkXtUrTKgDSNrR8ABVDj67k1P0m6rCKMUTQLXe4wyU7DME7tdbzX0bw4QudAwXP1CFNdBl74JQJ7FZinPPQGtxonPWArW8UQcja2+t1k7J7O+Z9uVgKqqRoiI0Tw72OlVzd8VJJa3/ko/X7W9xqhh0E21XSoX1vuvb+bRXS8QvKFbg2PAWELA19U3Y0cngTka8ineWN87REb2P6f6VQJZW+bUuaIEAVAtw5SrFKvhVPWbcEurji9QVYlXje58ESvWUDyZ7U6S7ay2EAyziGlFxshG5KSghHYiwGfmFMLP4N7Qw5MY83pz2UJ74PufnVUTKaODdmlaA1H6qUOD1ysrlyoE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(316002)(4326008)(82740400003)(70206006)(70586007)(2616005)(47076005)(426003)(336012)(5660300002)(41300700001)(82310400005)(7696005)(6666004)(36756003)(86362001)(40460700003)(107886003)(54906003)(40480700001)(26005)(186003)(16526019)(1076003)(2906002)(83380400001)(7416002)(8676002)(8936002)(36860700001)(478600001)(356005)(110136005)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 06:21:31.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd95779d-342c-410a-8c9b-08db3be752b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
o v2->v3
  - Patch 3 from previous series with a comment over the new
    build_caches_for_cpu() method.

o v1->v2
  - No Changes.
---
 tools/perf/util/header.c | 62 +++++++++++++++++++++++++---------------
 tools/perf/util/header.h |  4 +++
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 404d816ca124..5c5a9d23979b 100644
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

