Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A456F4EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjECCGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECCGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:06:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329719BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiUXIGO3bIuyJchNTc5BUNychdGgmmSybh86F7TWJqFX7sKX0cKOfkW09eitGXA/RmpRcz6v+jwZwYwqSh3jF84Aw0LXxQ6rObjSokpPAy5kW07wz8xV9gRrXmBb/kWdLrKTmasdmO7pIzZ6iTDhRg1AC0UBVvGpedFiOH+xqHgGAufu0S36rOwGcCpVuxTxox1eyKMhi+qQ82SJAfgEW7lcsEbS3T8qjXjVuPThtlFV3o9K3msoeiZCf5nx4E7eK+0Zs5pZz8s9iGg7H017dQ5yVn7d9sh8XsvwOL3zxvyWCSCnr/9PsY2XIZfNNeXxCKVZiz5noUdhMjrL7mx6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyfi0p53XLzoOqNzXhDqFrnK0JYBQ16gUA75fR7KPTE=;
 b=bxs5wrNL+kvU5rAWCQy8ViBlASIQpUQORiHSCdpYNqgNLJz27D98U+r9D9FeR3L1XQfVVYWCn3ZD0PInQfKzcR04PV7riDDCZUbsX6n0LcJebka226TesO7WJihWTVMbarAt4JvPfCZejF09bnZAqYKwOl7gfRd6RslLO6HTtnby6T/tS8bUfKrrx8kzW3kRy7z4rnlvA+fV6+EL5qhZeys2xzBixB8Xc46bTRIlGKDqknViq2qHxusmlJgLmBUxzFHjGZu2Cg85kdXT+rnofkbb0gwiXkpjph39hUQS3tImzcFiS592EZQtx8+2ojTpQVDCAV4Cxcdz7/DxSnyC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyfi0p53XLzoOqNzXhDqFrnK0JYBQ16gUA75fR7KPTE=;
 b=pGVP4j35sX9sCc0uQkRxpeZoJixeEhlxEk5K3XChoXiu2DeTyTNhOZM+Mq6ZE3IwgjopuqaxQuCG1buWVIVrZSHXX9x50zJStLTVkm0pXgYt56Lz+3lTwznF8qrXRfmf783E2KRkIb7PtJkq05ZuHpr3Ggyc71dc/2ydZ2Q9bXs=
Received: from DS7PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:3b8::18)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 02:06:32 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::38) by DS7PR03CA0013.outlook.office365.com
 (2603:10b6:5:3b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21 via Frontend
 Transport; Wed, 3 May 2023 02:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 02:06:32 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 21:06:27 -0500
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V1 0/2] sched/numa: Disjoint set vma scan improvements
Date:   Wed, 3 May 2023 07:35:47 +0530
Message-ID: <cover.1683033105.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9ff4ae-5827-4fd5-0e41-08db4b7b0412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ro4YOLd/qniRzLeA1NfVlFhTg2MN+HQ5Y4NcEcQ003iBmGs6CyNlEQ12w6M537j4F4ut8VZsyUx9e4D+XRJY6d/BZDdpmvq1w1Y9V9yzqwnPuQrAv39wfK+QTDUNQ+sNllo6AhtLu8oW9oH6GbFQhDqOopT1+cNmJRhiJIBNnp1/ncPUjJ0M3XcPVP8AKC0q2g3I2N9x4G7r/3hM5nx5L/aDTMhBjLJshZJv9A+GncfMd2SKHYwHreL94g7V7yLQNWGVeXEG6mz/VP4bjvSDNWqW9nNji6EVQu7aO+FVLekKSZpxvzavHY49sjFMOR26gKrOVHU15DL5+5Pj/e794vK5VatytWtsDiW7cUIhM/U7jgYVSYibh/pSVHvLTnvP1zyLjEf40mb6nmROKvXgU7mLMdeNtmPiNTnHa4CV3n2ltz+uJawLxMnl1elkEYcryGYVi+DoAm6Nr4T0wPeENs3uiPxp1PuOAOH/SWxULHcL+YfJAAAgaMOm6Uxrxdh0BTr+Q5IO1cUldtKxJwmP6H31r4n880YB6qsRBuhJU6TPGyWcQxAUAwRK/4ciHmMPjjEPykXcWN9AGWd7hQBNBp/fQXvy5Hyjm7cXrb314+Pj4DGpHBQBmCsp8gZYimAQBQRbzcT77VRjHc692Ay76kB8B/5XbcmZiYuqfAIka5ToiNviBEkWdt31QyccNde2urAzSCmD1Dz65ZCgDbRZ3Fyr4gURXR1SE566DxCCPoqEWCg3BsFolQLQ/Z582cH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(110136005)(966005)(8936002)(8676002)(4326008)(186003)(70206006)(36756003)(7696005)(316002)(478600001)(41300700001)(16526019)(6666004)(70586007)(26005)(54906003)(47076005)(336012)(2616005)(426003)(5660300002)(2906002)(36860700001)(40480700001)(7416002)(66899021)(81166007)(356005)(82740400003)(83380400001)(40460700003)(82310400005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 02:06:32.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9ff4ae-5827-4fd5-0e41-08db4b7b0412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

With the numa scan enhancements [1], only the threads which had previously
accessed vma are allowed to scan.
While this has improved significant system time overhead, there are corner
cases, which genuinely needs some relaxation for e.g., concern raised by
PeterZ where unfairness amongst the threadbelonging to disjoint set of VMSs
can potentially amplify the side effects of vma regions belonging to some of
the tasks being left unscanned.

Currently that is handled by allowing first two scans at mm level
(mm->numa_scan_seq) unconditionally.

One of the test that exercise similar side effect is numa01_THREAD_ALLOC where
allocation happen by main thread and it is divided into memory chunks of 24MB
to be continuously bzeroed.

(this is run default by LKP tests while numa01 is run default in mmtests which
operate on full 3GB region by each thread)

So to address this issue, proposal here is:
1) Have per vma scan counter that gets incremented for every successful scan
(which potentially scans 256MB or sysctl_scan_size)
2) Do unconditional scan for first few times (To be precise, half of the window
  calculated for scanning normally otherwise)
3) Do reset of the counter when whole mm is scanned (this needs remembering
mm->numa_scan_sequece) at vma level

With this patch I am seeing good improvement in numa01_THREAD_ALLOC case, 
but please note that with [1] there was a drastic decrease in system time when
benchmarks run, this patch adds back some of the system time.

Your comments/Ideas are welcome.

Result:
SUT: Milan w/ 2 numa nodes 256 cpus

Manaul run of numa01_THREAD__ALLOC
Base 11-apr-next
	w/numascan 	w/o numascan	numascan+patch

real	1m33.579s	1m2.042s	1m11.738s
user	280m46.032s	213m38.647s	231m40.226s
sys	0m18.061s	6m54.963s	4m43.174s
		
numa_hit		5813057	6166060	6146064
numa_local 		5812546	6165471 6145573
numa_other 		511	589	491
numa_pte_updates 	0	2098276	1248398
numa_hint_faults 	10	1768382	982034
numa_hint_faults_local 	10	981824	625424
numa_pages_migrated 	0	786558	356604

Below is the mmtest kernbench and autonuma performance

kernbench
===========
Base 11-apr-next
			w/numascan      	w/o numascan    	numascan+patch

Amean     user-256    23873.01 (   0.00%)    23688.21 *   0.77%*    23948.47 *  -0.32%*
Amean     syst-256     4990.73 (   0.00%)     5113.32 *  -2.46%*     4800.86 *   3.80%*
Amean     elsp-256      150.67 (   0.00%)      150.52 *   0.10%*      150.63 *   0.03%*

Duration User       71628.53    71074.04    71855.31
Duration System     14985.61    15354.33    14416.72
Duration Elapsed      472.69      473.24      473.72

Ops NUMA alloc hit                1739476674.00  1739443601.00  1739591558.00
Ops NUMA alloc local              1739534231.00  1739519795.00  1739647666.00
Ops NUMA base-page range updates      485073.00      673766.00      733129.00
Ops NUMA PTE updates                  485073.00      673766.00      733129.00
Ops NUMA hint faults                  107776.00      181920.00      186250.00
Ops NUMA hint local faults %            1789.00        6165.00       10889.00
Ops NUMA hint local percent                1.66           3.39           5.85
Ops NUMA pages migrated               105987.00      175755.00      175356.00
Ops AutoNUMA cost                        544.29         917.66         939.71

autonumabench
===============
					 w/numascan      	w/o numascan    	numascan+patch
Amean     syst-NUMA01                   33.10 (   0.00%)      571.68 *-1627.21%*      219.51 *-563.21%*
Amean     syst-NUMA01_THREADLOCAL        0.23 (   0.00%)        0.22 *   4.38%*        0.22 *   5.00%*
Amean     syst-NUMA02                    0.81 (   0.00%)        0.75 *   7.76%*        0.76 *   6.00%*
Amean     syst-NUMA02_SMT                0.68 (   0.00%)        0.73 *  -7.79%*        0.65 *   3.58%*
Amean     elsp-NUMA01                  299.71 (   0.00%)      333.24 * -11.19%*      329.60 *  -9.97%*
Amean     elsp-NUMA01_THREADLOCAL        1.06 (   0.00%)        1.06 *   0.00%*        1.06 *  -0.68%*
Amean     elsp-NUMA02                    3.29 (   0.00%)        3.23 *   1.95%*        3.18 *   3.51%*
Amean     elsp-NUMA02_SMT                3.75 (   0.00%)        3.38 *   9.86%*        3.79 *  -0.95%*

Duration User      321693.29   437210.09   376657.80
Duration System       244.25     4014.23     1548.57
Duration Elapsed     2165.83     2395.53     2373.46


Ops NUMA alloc hit                  49608099.00    62272320.00    55815229.00
Ops NUMA alloc local                49585747.00    62236996.00    55812601.00
Ops NUMA base-page range updates        1571.00   202868357.00    96006221.00
Ops NUMA PTE updates                    1571.00   202868357.00    96006221.00
Ops NUMA hint faults                    1203.00   204902318.00    97246909.00
Ops NUMA hint local faults %             981.00   187233695.00    81136933.00
Ops NUMA hint local percent               81.55          91.38          83.43
Ops NUMA pages migrated                  222.00    10011134.00     6060787.00
Ops AutoNUMA cost                          6.03     1026121.88      487021.74

Notes: Implementation considered/tried
1) Limit the disjoint set vma scan to 4 (hardcoded) = 1GB per whole mm scan
2) Current PID reset window = 4 * sysctl_scan_delay is changed to
8 * sysctl_scan_delay (to ensure some random overlapping overtime in scanning)


links:
[1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t

Raghavendra K T (2):
  sched/numa: Introduce per vma scan counter
  sched/numa: Introduce per vma numa_scan_seq

 include/linux/mm_types.h |  2 ++
 kernel/sched/fair.c      | 44 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1

