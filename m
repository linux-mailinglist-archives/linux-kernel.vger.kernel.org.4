Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E64737B39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFUGY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjFUGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:24:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A510D;
        Tue, 20 Jun 2023 23:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2fdRd8vlZShAdd9Cd6zhczOqiWbmR8SlhDgRhqsiHrW/3nFqAPJjBfUvvRiG4BbkQLl1qQ5BNtmQZKkqdiXTJ67LRK6/B2iwAHiTWBuTdOWVvos0Ii6F7DR8IOduKzlKQyxENR7H0Af3CCRzwF6CoUWJdWsVWXNJNZJwKB8G+k1qUc/TUOetol4oxo/+pbUeua6WEL99yKhoRBSUkoHmGTrrslBDQGXhW2Gn2pRexYFbiw0NApJnIa4udij7wGyhOHl+Vp9/dDJ0eM5cFHAUYfhwdjfN9derqMmfgl1GY30341NU76TqUkrugcbxxU2bEr7HySSF6H5Uq7kGiVZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZCdxOHeFsGY/FOe6Ubi+ys0VU+5rjw6+PC6S7RAuMI=;
 b=LxdMc+AVi3a6pjrMHdhZVDKQ/GMY5zeONvS5R1BZrM8IRQhqUupdH040DFDtf6wvxnklir96xEe09d+RykzFbawLuySseneLFCHCBTZKOtkZQ2pQ7h2sTReCAVZRoyPhTIRjTcW9bidfUh7WdfBrnaEDMz8Ulc/9UoET7g0a2SqpjjHHQhOwe++/E3qgNEJOH4gB8y5n0AirxkFhWftudKKdJ47GLWxXqE8NZ5z87sBOTdUldhAg12Py6xZkzsmoGE/j9tuR+oAIaSw8HYIJyt6HtqZ82hG77IAGFqk27Uvf1VhgrT5nymUByjdA+2AI+zAgp+jRS/m9+TUREdq61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZCdxOHeFsGY/FOe6Ubi+ys0VU+5rjw6+PC6S7RAuMI=;
 b=Jjk985qX+4mjf125tvQlRVqMQkVAU2TNFQjX8zbrL2pM7x60mvOzSRm2GE6Wk0QwN/N14mx2BXhoq6fxuS8sa8QyKny7QWyENtau9WwjjqiSdVgiqTa1lpgK/w0lx6bWru2KElKsEWFnb1od5NJ1LRpeFv0W8BSAMEg0wkH+/ZE=
Received: from DM6PR06CA0007.namprd06.prod.outlook.com (2603:10b6:5:120::20)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 06:24:21 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::fe) by DM6PR06CA0007.outlook.office365.com
 (2603:10b6:5:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 06:24:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 01:24:15 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <irogers@google.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH] perf evsel amd: Fix IBS error message
Date:   Wed, 21 Jun 2023 11:53:59 +0530
Message-ID: <20230621062359.201-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
References: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: b28738cd-6f85-4352-38d8-08db72202647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcRg2PfJ0cH7GBz3QrPXqMkSgFXUkIIIQKes/Ni7kmRO/25kqojv63Mio04Yzxxbi+OEJKwmUS3NcHKxYzEXeAKheKgPfRaAJSDP4g52BCe9nUUb7BKFRDN8rey2CFVY5rBUz78HGzAlYZkaiXcgWrWsXwokCPGIrAzc7+SXT7X7uS5/Y/siUn4/d9Yl0EgaxtHa/tDxpLZ4wcZZ7qgIU1Aws8DKOgc3z+7gmJzKgotEqrSU4/YmZ9/4A5gkzvZMs0nWyRM9iFaGi5DTgLinOq2CEUwZESKObiyuvZGvms9AJ13T8YoZrNf1f9z5U9VjZMa+wjtXgSMqGdtJhnPFpb+jjq3z1yMSq7H52ytUW6pVTTBnwR9O2zdxYw5hsOz/Ud/wZZv0QLf6gQJP6DWu2y+S4k+8lZ/RcCfZsmXdV/FkuADwBH6Cf7MjeF1jZDBUNNHu6EY1XUXr2a5jer7Vk0t1kr4rsLx0qrK8X4Vqx9t0kLsOnXIVAWTCWBYFSUEJ77rJpWgdwPkLnm/ZLIDtSx4o8ON8tQ8cOoaeqSvJIc0ZyKUgZ7KT6GZFjIXXAMmmp73Gib0EFgvz0a6htwCCOIVYkvZLrHo8WUQ66q6Lg+b0JnPNqcuJEuSmreqbOm5jxcGyqcYHkuqzbMNoAXyVK/yt6oiqiz5DiL6qFazNp7BfJgNdj2uXFXhtsDO6qZr7alFhEr74QiM8Zl3k3+QLOD4qLfd0YJRQo3vN1ufVXgMOfJZ4sRwTbyZyJalBwJWploilAB5MxkvIN+0Ng8SzJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(40480700001)(82740400003)(36756003)(356005)(82310400005)(86362001)(40460700003)(4326008)(316002)(44832011)(6916009)(26005)(1076003)(186003)(966005)(5660300002)(54906003)(8936002)(70586007)(16526019)(426003)(7696005)(6666004)(41300700001)(336012)(15650500001)(2906002)(36860700001)(47076005)(8676002)(478600001)(2616005)(83380400001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 06:24:20.8685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28738cd-6f85-4352-38d8-08db72202647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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

AMD IBS can do per-process profiling[1] and is no longer restricted to
per-cpu or systemwide only. Remove stale error message.

Before:
  $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
  Error:
  AMD IBS may only be available in system-wide/per-cpu mode.
  Try using -a, or -C and workload affinity

After:
  $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid
  argument) for event (ibs_op//).
  /bin/dmesg | grep -i perf may provide additional information.

[1] https://git.kernel.org/torvalds/c/30093056f7b2

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/evsel.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 356c07f03be6..65b0b70830f0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3092,14 +3092,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
 					evsel__name(evsel));
-		if (is_amd(arch, cpuid)) {
-			if (is_amd_ibs(evsel)) {
-				if (evsel->core.attr.exclude_kernel)
-					return scnprintf(msg, size,
+		if (is_amd(arch, cpuid) && is_amd_ibs(evsel)) {
+			if (evsel->core.attr.exclude_kernel) {
+				return scnprintf(msg, size,
 	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
-				if (!evsel->core.system_wide)
-					return scnprintf(msg, size,
-	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
 			}
 		}
 
-- 
2.41.0

