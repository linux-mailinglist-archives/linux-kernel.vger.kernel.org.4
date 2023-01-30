Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B36805CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjA3GAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjA3GAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:00:52 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE7244A7;
        Sun, 29 Jan 2023 22:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX9booGBqV11rio9PW3+rSCHJgthhpc4nfGHVuSgcXqZtW24Nu2iH2uHTzJ3LWzd5OZ/SIlwb2lv+KAGKITXWbPrG4DZU1k0iJg9PPxPONJQLMaCg+fvDpcjgLwwpM8bW5lzQX2nJsMc7IeMVjTUytrvRMzp5qeMQaL3ylqfNYJQUEbQbTluTIFE9cgLfMImOAtzF1TcUphEa5nXzQ4+wA0CCStBTn7hb5m33MB1CW3f/u56SLmAeBo+Izu9WXz6F6l1oifgOHeSMqruF1YEtdTaOFAqCHH/swdNJUILaTrR72drRZqT/AdoJrcc5pa9ILG+GzKqbI1wArrNf/1c4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7HNIjTiTSdl2saigDfeXxkG03D0mjn7wwZNYGXKYR8=;
 b=c6/hfsiDgMUkpeSW3PyTSNop6ClBZSYppZBOE+neXeDACs451v8Le15dR+GMuqAhaBX1bPClFyRjrRVMMXNmXZoDQ6jKN7A2IvQGSVUcdcKjW73ioaeAer0mO6o3lA3xqo9icYcz0N0awlWOG2XztqRA7YvQvHnQ7Unm45ZiWAcOPg51Q3eVuFp8jCqVzxIqWOo208qybd8PG5ZxyCWgsjWoeEj0O7t/W8MMTkSx50Bzomzmvszoewice3cHrht/4mvmbKCOhd+sHkdl28zeQcb62R0oJ/XmwTua3cBMd3isb8zYIdDUQdQW5cDSeP2QKF1FjJwJ1OZrIc6sUGxbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7HNIjTiTSdl2saigDfeXxkG03D0mjn7wwZNYGXKYR8=;
 b=x1HY45fnv7KpJFPsOrCA1de2uLYsBkyzDjQJ1mISz3r4df7cm9q7i8F0qOp2WY2sASKVM1yRHnJyavi/AoSLwbgZCwi1nEE5LfYWwtHWexGUxeHRiyeiI8aHh9pTZYQc74FHeZXlKE5Aff9EAfHnnTTTfXmF97Z5N1hSF9r7fzg=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:00:49 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::e6) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 06:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 06:00:49 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 00:00:40 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <james.clark@arm.com>,
        <irogers@google.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 1/2] perf script: Show branch speculation info
Date:   Mon, 30 Jan 2023 11:29:15 +0530
Message-ID: <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1675057032.git.sandipan.das@amd.com>
References: <cover.1675057032.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ff8333-becf-4819-9f92-08db02875614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SU8n/1j5w+3fGafnZ7HXnn40PPhCRDCtxwGWt0ZDYNUQ0bVzB5z3b8M9TX5YpRAfQiofeNH0L7NK6BE+jPFmK/oPP7yeeeYCQqii59rM/OY+CSOnA02BMJAPNyxyuMuYXgus7QFALjugD11MkhxGGafd4IVggza+JFPDRPmRw4+CtUSL99XKS+gw0270jb01Q51ACGMtWHQy3iCHr9SL/UCB4pwHQsD2on4r0x0D9f7bD/0AGeyLKUzm0pbslqPxn5fYVXHQ2eRZL3hPA9/EyKabpVIq/mtQJz6ZOtu+VNcvwAFapvdDeLAcXrQbE7ehZs2sy+m5e2XihgkyAkWGv7V2n3liRkkmEexSqjZem5wWHhCQWrnOVd/pMB2ngdO2ilH7mGII9K1U+xf4m5/jAOXym8ex4hMyLRelppUeswO6TRVE4vPmrrdeKHdNWq7UobhwhCNb9I/bXIFQdB2h+vUwOlusGtcRmjoek40KQ0HjvhiYgmoRGexYyuLEl3PZKqfUNe0JhLwyT0J8tM/rHep9K2HjUcZc5Lgvo077u/CVbiMAA/Xti+Gdsd3Z/09YcjJUlMBfdBhy7OHMrlA7wRdA8LORb8wZjgENIXpkpuGD6CcJfnrv52WeF9gNe4DnJDBkh3UNTd6Pt2jVoKFUj9qRpCXsJEtzg6K9rHeKkY0RVSqleA+jdyJc8DzB9Nyy67Q0qYV1n25i2fz6g0Thvy/4CqeDSM/qcWqsMAI9VfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(8676002)(426003)(47076005)(36860700001)(70586007)(70206006)(2616005)(82740400003)(81166007)(41300700001)(336012)(82310400005)(356005)(26005)(186003)(7696005)(6666004)(8936002)(16526019)(86362001)(316002)(4326008)(7416002)(44832011)(36756003)(40460700003)(110136005)(2906002)(478600001)(40480700001)(5660300002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:00:49.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ff8333-becf-4819-9f92-08db02875614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the branch speculation info if provided by the branch recording
hardware feature. This can be useful for optimizing code further.

The speculation info is appended to the end of the list of fields so any
existing tools that use "/" as a delimiter for access fields via an index
remain unaffected. Also show "-" instead of "N/A" when speculation info
is unavailable because "/" is used as the field separator.

E.g.

  $ perf record -j any,u,save_type ./test_branch
  $ perf script --fields brstacksym

Before:

  [...]
  check_match+0x60/strcmp+0x0/P/-/-/0/CALL
  do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL
  [...]

After:

  [...]
  check_match+0x60/strcmp+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
  [...]

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/builtin-script.c |  5 +++--
 tools/perf/util/branch.c    | 15 +++++++++++++++
 tools/perf/util/branch.h    |  2 ++
 tools/perf/util/evsel.c     | 15 ++++++++++++---
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..782319e8fe6a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -880,12 +880,13 @@ mispred_str(struct branch_entry *br)
 
 static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 {
-	return fprintf(fp, "/%c/%c/%c/%d/%s ",
+	return fprintf(fp, "/%c/%c/%c/%d/%s/%s ",
 		       mispred_str(br),
 		       br->flags.in_tx ? 'X' : '-',
 		       br->flags.abort ? 'A' : '-',
 		       br->flags.cycles,
-		       get_branch_type(br));
+		       get_branch_type(br),
+		       br->flags.spec ? branch_spec_desc(br->flags.spec) : "-");
 }
 
 static int perf_sample__fprintf_brstack(struct perf_sample *sample,
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 6d38238481d3..378f16a24751 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -212,3 +212,18 @@ int branch_type_str(struct branch_type_stat *st, char *bf, int size)
 
 	return printed;
 }
+
+const char *branch_spec_desc(int spec)
+{
+	const char *branch_spec_outcomes[PERF_BR_SPEC_MAX] = {
+		"N/A",
+		"SPEC_WRONG_PATH",
+		"NON_SPEC_CORRECT_PATH",
+		"SPEC_CORRECT_PATH",
+	};
+
+	if (spec >= 0 && spec < PERF_BR_SPEC_MAX)
+		return branch_spec_outcomes[spec];
+
+	return NULL;
+}
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 3ed792db1125..e41bfffe2217 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -89,4 +89,6 @@ const char *get_branch_type(struct branch_entry *e);
 void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
 int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
 
+const char *branch_spec_desc(int spec);
+
 #endif /* _PERF_BRANCH_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8550638587e5..019e53db03b3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2319,7 +2319,10 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 	 * 		abort:1		//transaction abort
 	 * 		cycles:16	//cycle count to last branch
 	 * 		type:4		//branch type
-	 * 		reserved:40
+	 * 		spec:2		//branch speculation info
+	 * 		new_type:4	//additional branch type
+	 * 		priv:3		//privilege level
+	 * 		reserved:31
 	 * 	}
 	 * }
 	 *
@@ -2335,7 +2338,10 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 3, 1);
 		new_val |= bitfield_swap(value, 4, 16);
 		new_val |= bitfield_swap(value, 20, 4);
-		new_val |= bitfield_swap(value, 24, 40);
+		new_val |= bitfield_swap(value, 24, 2);
+		new_val |= bitfield_swap(value, 26, 4);
+		new_val |= bitfield_swap(value, 30, 3);
+		new_val |= bitfield_swap(value, 33, 31);
 	} else {
 		new_val = bitfield_swap(value, 63, 1);
 		new_val |= bitfield_swap(value, 62, 1);
@@ -2343,7 +2349,10 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 60, 1);
 		new_val |= bitfield_swap(value, 44, 16);
 		new_val |= bitfield_swap(value, 40, 4);
-		new_val |= bitfield_swap(value, 0, 40);
+		new_val |= bitfield_swap(value, 38, 2);
+		new_val |= bitfield_swap(value, 34, 4);
+		new_val |= bitfield_swap(value, 31, 3);
+		new_val |= bitfield_swap(value, 0, 31);
 	}
 
 	return new_val;
-- 
2.34.1

