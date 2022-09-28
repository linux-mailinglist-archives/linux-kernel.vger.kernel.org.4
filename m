Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208385EDB05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiI1LCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI1LBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:01:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9AF2F;
        Wed, 28 Sep 2022 04:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCbVow0FWR8Nx4pU/bnMht8olmGE8qkA1WdPvOXavU/1ggl3hfphi71ttrg6j4R/WXgvESPTy9pv9w0bQc7JTgMJxQjyfqRfIwKFYt4rxR+W/K29X0zGIdjY5fnHoBYB6NLx/QrCbVovyOgbRZ4b8pnQv/vTxaUKZMfnm6D5arzRd66BnplY0Z/qrnuAaJaTy1qtU+aL2jVJrSLcjijc3JMbElonKaEJDGSPe5eYer3/84nzkSy468uPDEBYj5xsg0sjn2+mSH4LwXoME4UxJ3raZBnpujJXV6/aiVFVOzECmSuWurI+ssoOABd19Ar78QJf+Tt1KqKWXzxxsEMoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym4tP4OTWM1et2CoqxxHLdozNIqkG3Dhs/54p+MIUAA=;
 b=OkwPlCzahOJcJVhxS1azmw2xr3A/UFhE6f+hyCfidkpDJXA1fGAFFxjWAOczzZ9xHmtee+ZfPmVgQeeBuV8Lm8+hXn1I/gpMaSe4Prp3jdLA2zEouhaE65Iq76/Dy4nriEYyIpqVqN3AzgqlK5IiGTNzLCNxkyK6HY6GwPmGx7EILudWHWcA/wjiPe7WBeFcCDcxbLeliWuF0KRF2OGhD+SQvqzM7jc7cmbaS7urA8I3TjOQzz4AWiSTtM5q5Gfeujoge0PRGl8mZ18nKcFWxC8gvpjFfFefrJBMXFcsJwZaPnGQ+B0OjRJYZxtHkC9kQJ5uJ4rRvPld1BGP24wBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym4tP4OTWM1et2CoqxxHLdozNIqkG3Dhs/54p+MIUAA=;
 b=YAOMaI06ubTHaQIhfIVyL3M8U5lb41HCVe4yeYr8MO5L1zTJR8dKU61kbXIP9s2+Hrz9MlxlcS6a51kUn/gnJilYw5ejDpPvI5RjlwwgWJhKYv/NYtQxgjWH5hwNVRi59SgxjCoPA+CKI4P+p37z8xm0AjhVkauNdevYW4UKdCE=
Received: from DM6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:5:134::36)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 11:00:53 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::9c) by DM6PR13CA0059.outlook.office365.com
 (2603:10b6:5:134::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14 via Frontend
 Transport; Wed, 28 Sep 2022 11:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 11:00:53 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 06:00:47 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 2/3] perf script: Show branch speculation info
Date:   Wed, 28 Sep 2022 16:29:39 +0530
Message-ID: <e6abd45ef59027fddec53ac818df430acfccc936.1664356751.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1664356751.git.sandipan.das@amd.com>
References: <cover.1664356751.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|BL1PR12MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: fd97fa07-8c3c-435c-7ec6-08daa140b64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzndABBawJgX341RYX2OVLYD8lHz1uaGkl7u3KVyOuX8k9Y7l5Ip/pCxc/uN5OSVs5THWvcifRnic80Dune3OOtvL5WYx/uT2McZuGkNnoYVtV95gsS584Ze+yWwjNj/FUUvZVBUPNqomTvg961l1Sreq99g06l3QfKyhknDB3Z+q5tLW+RN1NUgdLdRoQVB+oauGyViF1uI3HX7XxkDxpkmQ3ZZG3/hoLm2CFtMzAxLqQH3FEbpvxZ0POtVQH7p+dVwowlhl94marM/dENAe0b0YRAqVU/aTjRC43isj+eJDmTjfZmletDGWHFgpKxqjvhVx72Nbi9YfIt1ePOv1av0JOjCbjsni3eRHRrzc0sjoA+rnIBV/VEjyQIUnSObNUXwoncp95ZHI9gzx0ew6uoEUt44/0sQywVDCrmTs1QojdlfG5BpGqcyjcSJtS6RilClbknRB0g2tBV57FLEDat8Je9KBYueNXtotzaD/+muaip2ZzgZ5l7hThFripu/FLjqtq4RedkRsuLRhKrtbqmTuf1e9TmSLkUtMt+3lL4wqjiE732nBsYRldVq7qQjonqcjBijYupb8bBFYLjsvYl4dnhJZ9uDJbcm27vHcNo6TFiqzdPWS+WJmWZ+X+gfxaFxVIWVKTByQmDjklUyogEmWHx8nbIQve0UCE0BQYsVYdFLivDbCHn1ElP5FnZWP0c19/GSa8Ee9xoHXosAPZQEdCHtMcqmvopxYTz1X7gDjcqQJ6MYxNvs2i/KPBwfmDZDOfNTlHfvFD8xfZ3jNcy3PfPrktVqqi2rBrq+8zA8Uf/mu5hfflINLlxP2fyR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(356005)(82310400005)(426003)(2616005)(81166007)(478600001)(316002)(70586007)(70206006)(336012)(16526019)(8676002)(4326008)(40460700003)(44832011)(2906002)(36756003)(36860700001)(110136005)(41300700001)(82740400003)(6666004)(8936002)(7416002)(5660300002)(83380400001)(186003)(26005)(86362001)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 11:00:53.2891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd97fa07-8c3c-435c-7ec6-08daa140b64e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 tools/perf/util/branch.h    |  5 ++++-
 tools/perf/util/evsel.c     | 15 ++++++++++++---
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 886f53cfa257..5b337f47a4be 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -877,12 +877,13 @@ mispred_str(struct branch_entry *br)
 
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
index f838b23db180..264817c96560 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -24,9 +24,10 @@ struct branch_flags {
 			u64 abort:1;
 			u64 cycles:16;
 			u64 type:4;
+			u64 spec:2;
 			u64 new_type:4;
 			u64 priv:3;
-			u64 reserved:33;
+			u64 reserved:31;
 		};
 	};
 };
@@ -90,4 +91,6 @@ const char *get_branch_type(struct branch_entry *e);
 void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
 int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
 
+const char *branch_spec_desc(int spec);
+
 #endif /* _PERF_BRANCH_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5776bfa70f11..0266e885acb6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2326,7 +2326,10 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
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
@@ -2345,7 +2348,10 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
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
@@ -2353,7 +2359,10 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
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

