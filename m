Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532C26D1673
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCaExg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCaExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:53:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C8E38B;
        Thu, 30 Mar 2023 21:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m908diXVpNBPR02hRnIdqRVuHQLQLdpsYQAeMaPee/17tMJv9CK10CFTiqePKiIbjsKmRkR101a2OtzG16YF5mmwHPs3faOKImcVA3eS4Qc6mg5uqE3lkMCgdA9zY3/whxOrGTFM/VUwOmC5zuEU9pterNe0ewyqmmowZnI5JY1YeLt6Jbe9e9QiBqN+FeJbsbUS6sjbNPFQ4LxA2C4zKC9Ebe4nokKi+VdK93TRxD97GWqoopEoeuf7Y3XyaF9ty3pYfS59v57FnrxGQ5jtVlLzwjdxFw2NBmoPnVd0lf3uJUlGv5+88PQ1sADSI94TUsw2YXhUWHKlQHvC2NNkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQk39abSM+KXhb6EpYDPk5kBA6moAeNWpPSTOZkMo9Q=;
 b=cGPMwPieLCQczvOVN258hNffMJnqfY68dgRc89ahSSjb5h0OUtchpHTSq8fBu97bwT3MudeXgoF12fw86FSzn5vKYlk54HTNWxvXNYDxXjQZcpndjB1onddCA+8my2qYHWYEmSf6dEvYYNu9yWcsViUDFJxMo/SNxsNg8v8oBpqTrbIqDBc4LPetZ9px0I5tG4COhxHPqiEa3A1oeReNKoOqBGQtSbl2ChEc/VVvQaF8YY683pxxt02iyW2fNwY4ILxcqqxKm6HCGDV3GFndKUzBQR+pwHvoFmp8IAiku34QYRbh/Wp9+coyff1v2Gv0yHEanj/QIHgr3s984tOZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQk39abSM+KXhb6EpYDPk5kBA6moAeNWpPSTOZkMo9Q=;
 b=kpIH1AVrlBBn9spz17Oq+QKIrDwjdh+18HISZzO9KpISIU1MNaKq8OyEK023e5lUf04M/z3aoQDJ16m3rm2zsi30nBl8PTOyI0cXt+JyCspayHH4d/WkF9u9lY2GKYNxB/kRZUXe3RzaKnH2qsvLtjPMzwqzZxzqTSJaSQTbs20=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Fri, 31 Mar
 2023 04:53:22 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::8d) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 04:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Fri, 31 Mar 2023 04:53:21 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 23:53:16 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>
Subject: [RFC PATCH 3/4] perf: Extract building cache level for a CPU into separate function
Date:   Fri, 31 Mar 2023 10:21:16 +0530
Message-ID: <20230331045117.1266-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331045117.1266-1-kprateek.nayak@amd.com>
References: <20230331045117.1266-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ee7163-413b-4d29-a018-08db31a3da70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTmg1uUobkzwPUTQL6KEDerSvOM1AnvAo4NzGWsD/dofUFY334rO7HkpRygbDSC6+XrST8Homkp/Cqfbsa6X5exxckB1W32gqRD7sz3lvsEojt/69B0GMwsyCV/ytcXZzoAiPBhURUGQvuJT/Mhhyf4q9RnnthuF3tGsBV2nP0jXBEIAnKu8ovP8aVxxIyQBWQA1D1ct/Bn76heut+GqP9surJtJXo9AIwBYGEEbBBh49c93hdA94t9f7dU2uqLnL14SMw4ey9f0gsV8yRBIzjpVeqlFf8Q5dIw57KajyUGVyQJg5DSipemL9gh9tZrQlo4U31JjM8ylfM+J8McpyiqKaAaXAzGYEqbD0a7hVnPqdPUT+jJ8XOvyMhEuods49pNs7N3HIXVY/VAZEa7sy9DHH2pkIeagG8vW3MDboBUL9bTSdwdmX83+Yi1vYzR2upbd4aiZn2jhDBoGWsFD4dg9HLBw7+p5gNAt9F0szgWH8DnokakD8ph5r/IixjB7hUkb8+bS4zpWPtiw7wftWnClfPjgbcmVKSOCrnZPqJdtdN2H1IpWJp11Q0MTGnacKXp3gLNHqOV6NEkaOgvg7GkwrQwaQbKNJGACC0U/xwJ301DaReHEsmYlmn/+AmPj8/ak6+vXCtMir87E65qJRMOkbQfSKvOp25VfHP+3UsE20Dihm0YKZmYikcLCl+bh3tDjYcJJafONmkQe7HfJcnShr2IA0VovllA4VaR/enRH/Ti8SKxCKANydDgUfB3z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(41300700001)(426003)(1076003)(186003)(40480700001)(7696005)(83380400001)(2616005)(336012)(47076005)(478600001)(54906003)(316002)(110136005)(36860700001)(40460700003)(70206006)(4326008)(70586007)(7416002)(5660300002)(2906002)(8676002)(82740400003)(86362001)(81166007)(82310400005)(36756003)(356005)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:53:21.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ee7163-413b-4d29-a018-08db31a3da70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
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
index 50d66092c82b..770b0f624d7c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1220,38 +1220,54 @@ static void cpu_cache_level__fprintf(FILE *out, struct cpu_cache_level *c)
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

