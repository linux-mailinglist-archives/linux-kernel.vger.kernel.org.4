Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01314687D48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjBBM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBBM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:26:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F834ED09;
        Thu,  2 Feb 2023 04:26:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaGLfHO6wCIG+KNDx7Sdwq3s7QphbTO3EGUvlskf2sKIJ4t2FSnS7SB0/1vaaSwlF/SxNM+dSiD+BWWptu66iv9sMtfcUQlJkEn+QuqFELlvCaDFSdFsNY4HwNINYuem0uBaSJENxdHiQJjpHhvVD05anbjESW28rvF29vLLfw3CMANTK5OAbbvq84eR1Mof1HS9vjToBr9jDILLDOj/13ILjsU6CtObAwJJnThc0dJYqjiidhEAemMhAXFFx5B1n5MkgNLu0YbeEA4srI2qM+FQlWHfakGRaqEMvcY8RdZjYIPYqWVqAh3OpChJPKUAUnJpsGzbBPSD77Kt/MW+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7HNIjTiTSdl2saigDfeXxkG03D0mjn7wwZNYGXKYR8=;
 b=l/cBVN23ZmghTWMczOQ+h0EwLqIVlytXkd6K0uMXS1eeP2PpJsOdCsIybKGnHgZkh2Wy3OwWuBIXbFOvqpCv4ME0gZ23ERQ0pzOkeqIpOG9AV6ExA+85VIwzbfUj9tuqZiZJjr9Kb5PGJFKwmP2MruaIbBRZjNCAihUXS5ZFnZZjCJl/lnuqxX2Fup38SpqMB/sTZ4+TUXyKRhzxpWjBDpjArf3ZB5LnBGSUVKKCrWbXdJRe4RsN9TU46G/BCYrvSQkaDa+jRhNYRNa533HvrNtE1b9TXE5rBUgt18rl/kTCQVazhCDG0gsyke/gBLXgWu8Kw9gJMxwBieTlMHgimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7HNIjTiTSdl2saigDfeXxkG03D0mjn7wwZNYGXKYR8=;
 b=X+ljoKhes/fTKZkwdGnCDi2TlScxxeVsPGSI4Rwa8f5RNhDSQPZjGhZHpuYLXwfwt56CdCh8qUbratyGf54zx9Fi3buaauUU+08KgQglumHhiHwexFwjRJZQrHiIPpyxjZGm/yStZS/aXrfP8uyly4nT85ITCo0XITQncmQwBV4=
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 12:26:51 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::2e) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Thu, 2 Feb 2023 12:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 12:26:51 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 06:26:44 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <james.clark@arm.com>,
        <irogers@google.com>, <eranian@google.com>, <maddy@linux.ibm.com>,
        <kjain@linux.ibm.com>, <tmricht@linux.ibm.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 1/4] perf script: Show branch speculation info
Date:   Thu, 2 Feb 2023 17:56:14 +0530
Message-ID: <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675333809.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1675333809.git.sandipan.das@amd.com>
References: <cover.1675333809.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 44850ec6-4f31-4254-a28d-08db0518c2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dRcbPDb8+3u3WLva+mEP/CpB1DD6yDSkztLzxHd/WtHTSJIySydzE9Y6i24iT4nWaU1XVNLvcXEBreaygiH0SGT3YOFBFgvWpshrGsWvl+1N/xwaHhcPd0uzl3Q8fqy9GvPAkdXAUYdGOFazdMBUO3U9NudoQur4QyjcxRjUwno5XDb7Om9KjlNP4cXtn5W9f2alZB4lUj0bn0ceUGMtek/nOZuAnnJ07qgadCJ08rtwMM880zFvFZFEBwPyls05ax9/PaVoWZVMLqB9IXtmmgMHy/itjOnp4FvKYCrQJ/2hIkrgmqJUcMTaIDOygqR3p3XqxaSN9NOgltM7H2kNe+MAnm3S6zSIYuGMhJJ2FiQfgcImwJHLMTDaSDrCInDAVKIewtNFNs79+W+r2GGhnbJoSaCvsk7SzsNQdYGKE3Qqhh3VJ4NT5xV2LigqaOdKugTXhCjZ4SFwV2pHp1YzUIbCRdnQ4NUQ4tid8Tjv+TsWQdyg4xnrA0nupngnvSPTTnPQKAH+5LoePuugNPzr5Qr5sI65ZeXkqS00LhMJ7XCwZLo5mzVh1I+4lMpWXb8u8p8s2wMKCP5WzjlSt+KLDRt2muy3wFxrHMdMuFkM89Le1c+JSX4Lc4fV+E7g/qedR4odR7G5zQbJV9Y7UX+bNpM8ik/K6788hhv7ozQ6TcwxoSowcRTDtD8dbZy131Qz6FUXIdMg/BE80Lc1HXUNYDJ9MPo6pkmfg3wZElOpsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(70206006)(70586007)(8676002)(356005)(86362001)(36756003)(40460700003)(81166007)(4326008)(6666004)(336012)(426003)(83380400001)(186003)(26005)(16526019)(36860700001)(2616005)(41300700001)(8936002)(82310400005)(5660300002)(110136005)(54906003)(316002)(47076005)(82740400003)(7416002)(478600001)(2906002)(44832011)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:26:51.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44850ec6-4f31-4254-a28d-08db0518c2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

