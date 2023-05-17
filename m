Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E216706F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEQRZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEQRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:25:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442DFA26B;
        Wed, 17 May 2023 10:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4UPKqeg9ZfTH41c9pR2wnn/NRUhI6qvrpRAogvdRJPN3cadhbtpWQK/hTwWNOzbSVKqB9WtFLUqSFlAVQErjM0adHI+2I0B02mVkYBFgwZEnEvAejEhXqgioybDgKa4fQdm5V0Y2A3eN/5Rdv4+SVm6EqglwNzkSTtUIE5qjOxJJiFpvUxXGAKXoTtd2OwuEneFTA5Gb6oPYphkesLf3PZ3XgCwphaBIsDQw9XlhbbJhEWe8/K4tcow325V8T6GIRiqjtqyOwv2z+G21P1R06/EdyAGebhErh++VJbwyJbBpHsfs6+CkcIl3oFFmNjMgw7k0khk6n0qj5FqqYOJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWKfbZTFo8hzNozSa5JRMqLcwMmzB0RdV5y/1TBzT1w=;
 b=XSNG8FjNNYly27UhXZ/1kAYKM9VjaF68+lwcD2+qR+17k5dHa8HMr/dFroYCdEIhFBlkOuQuhYgiHpPEU1C0wpfmqsdeCSRmtjYb4nEaSGc0JY8QxNZb2+qWM1k6ck0NxogO4rGhBM6rcI1efitzgAFZNrowoF/SBhE5FZi2gYlc6X+B71X6bbG07vSnKZh0QvQ4EpwQNV039/cwEx5a6bQUshDfDZYOF0UUXuyx/nPPAyWJSUOKuQQ38QvszwpxYeSASZ9N7nbqaHVK+qeA1Nvr6nwukpwbXu6f1N6fneyBIeuJbNstqEjqzSNsZ66NU6LnbKdbhzJ16lbSvg5b9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWKfbZTFo8hzNozSa5JRMqLcwMmzB0RdV5y/1TBzT1w=;
 b=xvYcZO8VlACTh9pbgoXml4tr6cdP8Ceu28IHJZNSsRHvlVvVRJXAzYG2AoPMICs1bnkz+c5QWjRjwvNRQJrT2DBH4qaZCVm9mOmnrUrwDkZpr744PS9BbgY8s4DlBdT2rGTxFGrymMA4/Hzik/EeU8/tq1wWckPXjCrFB98xWbk=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 17:25:00 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::66) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 17:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 17:24:59 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 12:24:49 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <irogers@google.com>, <puwen@hygon.cn>
Subject: [PATCH v4 3/5] perf stat: Save cache level information when running perf stat record
Date:   Wed, 17 May 2023 22:57:43 +0530
Message-ID: <20230517172745.5833-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 662edcb3-bc31-4eb9-4066-08db56fba45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z73X3EV6cA4vo2OFbjOGdF1uf0gYA1uEiUQ5g4DUME8RnJGIOK/uqiY2d0t91nsUJx481wDrOJYZwsTRrLaWKaWvGUUZ7yBXXRnWfv7AbevglhYNbNkpIhG7XVcnA4Ntefk2/diaBr5I+k2fh+Zr1u6BEEi0BH7ISGupE2yq/6UvAuL4nn665NIUOxbreZNlqZCYwdsKgympe9/dz6znf6WNP019j4WimVcszuwsgdL4c9HTSaF1fzb9OgXJ3BbjC7QVZBpiHVXoONXhqqRK9z8jKasGUxx5inggK8Zgl6ug+BHsfON6PoaRoyB5PFekT82KR/Fm0X/NohlfPuJ9PFdardYHZ6dQFOX49ZlS3EnlJ2iM8KkwDjlwmayz/IpPSh28s3L9+jJKGUWtgMWqM/Kt0E5ksMMIVPN4vx+x0QqCFcLInDCYyAjcFVfH3slOS5iUhcVfH2xTnS4AemCmRAi7Zm2iW96PHQLjZpyCLffNvhicRKDVzWzzrEAaQhDrKciO9t/C2rQb8FznyiNKBOiCflAAhKzGdQVmlQSpGmXMjXCNiU+nItvMxeZZvkNG8YlincUduKtnosh13ceRMY25oUbTdh/kSrnc9oR4GHgAXrVznqDKQnHCdomjnz+ElUolRSq9g+I4UPQXFDbUyQNdJhtLs8EEHCMEK8iDs8cgW+SNLYeTC1UJzjYLo/Jil58moI8LH/wgQQZvoK44NuUfksagWDft8Z5PwtV++DrLECEedaA7iZF/8RsiJxPk6Fi6akTkjMklvfYqhkJkVpyTiW2Y+2GuqcjXYLWrEDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(478600001)(54906003)(110136005)(41300700001)(316002)(4326008)(70586007)(70206006)(107886003)(1076003)(186003)(8676002)(26005)(7416002)(7696005)(6666004)(16526019)(2906002)(47076005)(336012)(426003)(2616005)(40460700003)(83380400001)(356005)(36860700001)(40480700001)(86362001)(81166007)(82310400005)(36756003)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:24:59.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662edcb3-bc31-4eb9-4066-08db56fba45e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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

When aggregating based on cache-topology, in addition to the aggregation
mode, knowing the cache level at which data is aggregated is necessary to
ensure consistency when running perf stat record and later perf stat
report. Save the cache level for aggregation as a part of the env data
that can be later retrieved when running perf stat report.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:
o v3->v4:
  - Previously part of Patch 2.
---
 tools/lib/perf/include/perf/event.h | 3 ++-
 tools/perf/util/event.c             | 7 ++++---
 tools/perf/util/synthetic-events.c  | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 51b9338f4c11..ba2dcf64f4e6 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -380,7 +380,8 @@ enum {
 	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
 	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
 	PERF_STAT_CONFIG_TERM__SCALE		= 2,
-	PERF_STAT_CONFIG_TERM__MAX		= 3,
+	PERF_STAT_CONFIG_TERM__AGGR_LEVEL	= 3,
+	PERF_STAT_CONFIG_TERM__MAX		= 4,
 };
 
 struct perf_record_stat_config_entry {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 8ae742e32e3c..e8b0666d913c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -135,9 +135,10 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 			config->__val = event->data[i].val;	\
 			break;
 
-		CASE(AGGR_MODE, aggr_mode)
-		CASE(SCALE,     scale)
-		CASE(INTERVAL,  interval)
+		CASE(AGGR_MODE,  aggr_mode)
+		CASE(SCALE,      scale)
+		CASE(INTERVAL,   interval)
+		CASE(AGGR_LEVEL, aggr_level)
 #undef CASE
 		default:
 			pr_warning("unknown stat config term %" PRI_lu64 "\n",
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b2e4afa5efa1..45714a2785fd 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1375,6 +1375,7 @@ int perf_event__synthesize_stat_config(struct perf_tool *tool,
 	ADD(AGGR_MODE,	config->aggr_mode)
 	ADD(INTERVAL,	config->interval)
 	ADD(SCALE,	config->scale)
+	ADD(AGGR_LEVEL,	config->aggr_level)
 
 	WARN_ONCE(i != PERF_STAT_CONFIG_TERM__MAX,
 		  "stat config terms unbalanced\n");
-- 
2.25.1

