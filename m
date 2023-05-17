Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC16706F58
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEQR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEQR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:26:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9683AD26;
        Wed, 17 May 2023 10:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ8mLLf4pzXSedUNlEj174P3vpObkofoH6eqn+SJShrKVKG2tz3r4ll6z8sIJiVZXH0D6q4EBSAqMkBI5Vy8+hUZJLHKzWZh01adlltYsCkhIkZiG30uVBGFScyh/gefvYy6ARAATQMuuksNn2mKzHrZbuV9KbPxqsbqHcU/q9GxbTUVNzdPHQ6jUkmW/r/VXuARMcd8xdUjBi4hTgtRSsD9K9yLZGson4bOCMBFfr8OTMTnxPMzXdrW5wbolWvJAt3MPOdaZhp3f/Bff/iR4rPd2/47v5LpB6ipzuy8EEZyHVwX3W8ePaGChdVTDEWvezzKvS3KuzRH3qqaUcTByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ms27912R17oLg6T5yWBzwDucV8XVdWSaEbwWxH6oqo=;
 b=iKxoZHY3fuFT0tsAd8DnHfuKqeN283lR1b7lp9IP+PBXt1/9MoQbdGFjop2zVoolw/np8tgvNSMMLP1OnLEXA/UfLASuoGx2C0QRSbKc6nQxl/7tkQYrxbHi4FMte4PQVVQYXL9/V+u9/kBHIBxlqLulyrnuF2G4cVScpx0GEPEA5NbG1np4OXcJEUm8oFJGoUTGqgU5v/2z9fW/CC2VBb8hN5qOTZ/QDZyvo/XfKLgdYBOkCGlzp4A3DwQp8b6vxSk7eAgBPcy8O1+LTxOYPgHhdUjpZPKLri9mXs22xGwZU7nQgCNaIi77nrybJOEonNtA0SKooYHs1a35DNEVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ms27912R17oLg6T5yWBzwDucV8XVdWSaEbwWxH6oqo=;
 b=hZ/TQndlX3nA/MGFpA0ArLvBeJlSiUsGZp6rWUga6xKCVSCXplqYR74FDqLRXPJJw7MksXmHn5yUStrhpHMa5WqEmMJ5z2D7IzoR55ZWl68PbfgNx594x4EPvH8m2d9xZBMML90z85SHzoy1CXHDlX3p/fyvuy2hV/ytKkBHbIw=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 17:25:47 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::61) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 17:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 17:25:47 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 12:25:39 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <irogers@google.com>, <puwen@hygon.cn>
Subject: [PATCH v4 4/5] perf stat: Add "--per-cache" aggregation option and document the same
Date:   Wed, 17 May 2023 22:57:44 +0530
Message-ID: <20230517172745.5833-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 7229a8ed-6cf8-4827-3e5c-08db56fbc0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7i8OfwUknZn2LD5cMezebOei5vZJizLrTJTyAUO32z3n8EfvOlQG/l8IiQdIwgI+BpGokmRqvSifG+ExNW6vgj0f4KYnfLrxbEu8Fji+Brc8X78YLKTUEzvtW3n31EhPNDw2qeBNF4sk4e+CFmN2T31kqRspiZ1rs5ZiAR23u8PUHquWdg489x0HQDyPudOf2sTQmlACB2wZMkBZH3o9LFHEL23GpkgLrKdhuqM9JydbE6YvzCI13iJYpZdLMcvDLnVl55KdeTk5C+MfkZ2AOKtKguuvu+mLbyKZTUj7Ikdq7O2X8CJ3OLJdOQwY1wdIewVml2JXuV4Uoczkzy+KulqAMTb+wlooogeLMZzEMz1F8K/IdI9ZMUGNvgqFZu/Wi21enMWIbatVlqa9jCNtIdZzyYwCeUj8tCPcXFdecq93y93zCiCQUZnWpepYDG5JelJrG5T7IyQH1oGlFm70pKRSZ66Yq5Y2cwHA7uQ8X7M1Do/dGLbXuXIIXxGVap15TUldUTvhL7zsyvnziczD+tdcsOl7T1QNrBWQZFBWMbRSr528DmTBiaauwzVSN342EOiRilCkTZEbOLdEtsFIk6Cr+SOWH+6epLqR2NeHk//ABDdIeBouDrQQrtdQgwWI1XsDZ/M0oSV951ibFbNkPmZnRNue4CYhawO7t5PE0nmJcQhasYf98HvGC5zu1ObPpT02G6SsriTJWQqkCnBmIonE41PtoAKcuTRggweZfUxGE1p36beSHA2xC5djQlonw0Z7MnSZK2b91nzZGZ8RA4TuufO2I+1OyRRBqghAf4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(426003)(107886003)(83380400001)(336012)(186003)(6666004)(7696005)(478600001)(110136005)(54906003)(2616005)(1076003)(26005)(16526019)(82310400005)(8936002)(2906002)(8676002)(7416002)(5660300002)(36756003)(81166007)(40460700003)(41300700001)(356005)(82740400003)(4326008)(70586007)(70206006)(40480700001)(316002)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:25:47.4024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7229a8ed-6cf8-4827-3e5c-08db56fbc0db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

This patch adds support for "--per-cache" option for aggregation at a
particular cache level and documents the same. Following is the output
of perf stat with aggregation at L3 for the event
"ls_dmnd_fills_from_sys.ext_cache_remote" on a dual socket
3rd Generation EPYC Processor (2 x 64C/128T - 16 LLCs) when running
hackbench pinned to 4 LLCs:

  $ sudo perf stat --per-cache=L3 -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- \
    taskset -c 0-15,64-79,128-143,192-207 \
    perf bench sched messaging -p -t -l 100000 -g 8

  ...

   Performance counter stats for 'system wide':
  
  S0-D0-L3-ID0             16          9,500,803      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID8             16          6,338,099      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID16            16            355,005      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID24            16             22,067      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID32            16             16,321      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID40            16             11,619      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID48            16              4,238      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID56            16             31,158      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID64            16         28,242,452      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID72            16         22,906,973      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID80            16             72,898      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID88            16             56,907      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID96            16             20,456      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID104           16             40,913      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID112           16             78,113      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID120           16             37,897      ls_dmnd_fills_from_sys.ext_cache_remote

Also support perf stat record and perf stat report with the ability to
specify a different cache level to aggregate data at when running perf
stat report.

  $ sudo perf stat record --per-cache=L2 -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- \
    taskset -c 0-15,64-79,128-143,192-207 \
    perf bench sched messaging -p -t -l 100000 -g 8

  ...

   Performance counter stats for 'system wide':
  
  S0-D0-L2-ID0              2          1,442,061      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID1              2          1,548,994      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID2              2          1,553,557      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID3              2          1,420,122      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID4              2          1,465,461      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID5              2          1,455,153      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID6              2          1,595,237      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID7              2          1,499,321      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID8              2          1,919,025      ls_dmnd_fills_from_sys.ext_cache_remote
  ...
  S1-D1-L2-ID127            2             21,295      ls_dmnd_fills_from_sys.ext_cache_remote

  $ sudo perf stat report --per-cache=L3

   Performance counter stats for 'perf stat record --per-cache=L2 -a -e ls_dmnd_fills_from_sys.ext_cache_remote --\
                                  taskset -c 0-15,64-79,128-143,192-207 \
                                  perf bench sched messaging -p -t -l 100000 -g 8':
  
  S0-D0-L3-ID0             16         11,979,906      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID8             16         14,257,202      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID16            16            377,484      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID24            16             27,224      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID32            16             26,816      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID40            16             14,461      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID48            16             10,499      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID56            16             53,817      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID64            16         27,361,987      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID72            16         37,299,024      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID80            16             84,125      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID88            16             64,561      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID96            16             13,403      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID104           16             20,138      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID112           16             93,220      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID120           16             35,465      ls_dmnd_fills_from_sys.ext_cache_remote

On the above system, the domain covered by S0-D0-L3-ID0 contains
S0-D0-L2-ID0 to S0-D0-L2-ID7, the corresponding count for L3-ID0 is
equal to the sum of counts for L2-ID0 to L2-ID7.

Add documentation for the newly introduced "--per-cache" option.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:
o v3->v4:
  - Previously part of Patch 2.
  - Fixed errors in documentation.
---
 tools/perf/Documentation/perf-stat.txt | 16 ++++++++
 tools/perf/builtin-stat.c              | 56 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29bdcfa93f04..785f0e2bcfac 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -308,6 +308,14 @@ use --per-die in addition to -a. (system-wide).  The output includes the
 die number and the number of online processors on that die. This is
 useful to gauge the amount of aggregation.
 
+--per-cache::
+Aggregate counts per cache instance for system-wide mode measurements.  By
+default, the aggregation happens for the cache level at the highest index
+in the system. To specify a particular level, mention the cache level
+alongside the option in the format [Ll][1-9][0-9]*. For example:
+Using option "--per-cache=l3" or "--per-cache=L3" will aggregate the
+information at the boundary of the level 3 cache in the system.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.  This
 is a useful mode to detect imbalance between physical cores.  To enable this mode,
@@ -379,6 +387,14 @@ Aggregate counts per processor socket for system-wide mode measurements.
 --per-die::
 Aggregate counts per processor die for system-wide mode measurements.
 
+--per-cache::
+Aggregate counts per cache instance for system-wide mode measurements.  By
+default, the aggregation happens for the cache level at the highest index
+in the system. To specify a particular level, mention the cache level
+alongside the option in the format [Ll][1-9][0-9]*. For example: Using
+option "--per-cache=l3" or "--per-cache=L3" will aggregate the
+information at the boundary of the level 3 cache in the system.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b072c4160fe1..7aafea5c7e6c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1100,6 +1100,55 @@ static int parse_hybrid_type(const struct option *opt,
 	return 0;
 }
 
+static int parse_cache_level(const struct option *opt,
+			     const char *str,
+			     int unset __maybe_unused)
+{
+	int level;
+	u32 *aggr_mode = (u32 *)opt->value;
+	u32 *aggr_level = (u32 *)opt->data;
+
+	/*
+	 * If no string is specified, aggregate based on the topology of
+	 * Last Level Cache (LLC). Since the LLC level can change from
+	 * architecture to architecture, set level greater than
+	 * MAX_CACHE_LVL which will be interpreted as LLC.
+	 */
+	if (str == NULL) {
+		level = MAX_CACHE_LVL + 1;
+		goto out;
+	}
+
+	/*
+	 * The format to specify cache level is LX or lX where X is the
+	 * cache level.
+	 */
+	if (strlen(str) != 2 || (str[0] != 'l' && str[0] != 'L')) {
+		pr_err("Cache level must be of form L[1-%d], or l[1-%d]\n",
+		       MAX_CACHE_LVL,
+		       MAX_CACHE_LVL);
+		return -EINVAL;
+	}
+
+	level = atoi(&str[1]);
+	if (level < 1) {
+		pr_err("Cache level must be of form L[1-%d], or l[1-%d]\n",
+		       MAX_CACHE_LVL,
+		       MAX_CACHE_LVL);
+		return -EINVAL;
+	}
+
+	if (level > MAX_CACHE_LVL) {
+		pr_err("perf only supports max cache level of %d.\n"
+		       "Consider increasing MAX_CACHE_LVL\n", MAX_CACHE_LVL);
+		return -EINVAL;
+	}
+out:
+	*aggr_mode = AGGR_CACHE;
+	*aggr_level = level;
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1177,6 +1226,9 @@ static struct option stat_options[] = {
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat_config.aggr_level,
+			    "cache level", "aggregate count at this cache level (Default: LLC)",
+			    parse_cache_level),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
@@ -2200,6 +2252,10 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_stat.aggr_level,
+			    "cache level",
+			    "aggregate count at this cache level (Default: LLC)",
+			    parse_cache_level),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
-- 
2.25.1

