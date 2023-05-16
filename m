Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D0704900
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjEPJUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjEPJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:20:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0D2D62
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy9M1aCiJg3F4/ncx2e90ML0EibSw2U6E3tNlBgDtIyzFIxohJ7c98bfbvoR9cYa422gHq13DO3i0ipk9dHF1Lvo+ZQgv8E1XyXjktSfUtt7X522XelM9yhp/aSC1TlghAQuz1TWpy7C2yvf2Epe/aaSdyHJ7Cw6zGpuqXgB/iuAGxc7EroVaq6gTmnUfdi65qngUY6XANoPWwzF7Gjz/muaOAdzWqaKjWeTMxoWtXlF1gATnBTrhRCvUqnYhiwxzkMcxlEStN1JSfZdQ/4FJu5cSnSe7YWD4J1KE03wTctQxMg9J7MQr8buOREJwtKo/WG18iPXooOsf1OqndsoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1WXSUYd+HiGhScMKNHeuzdBVI7PkfMZuf3z4QEOvPc=;
 b=Wtcqh9hkp2FOKTT+o2LhwoaRmo4uG1+YBu2GoK49oANX6W+r97CZGBWhbbuJbZcfgOAdnkT4uLopoDqTC2hm10KNAk3awDw35b8XP0tLFktxEzQwp6JoGCgRcZBt9t+Mt8NtibGLeye3hry4bWmINLW5Y27ydA56eBPrfgOmm4iB2xs8WPiBpAm9QDL4/0SLiWYrZZ0x6CC+gX7Vv68Rp7EQLz7q/eePi/I7nlvyWqs492ZnafqaR/+iD30jA7ep5V+IxZkoku20BczdrnO9gs5zN3pfEo1XJ6k+z4qi9il/KRJHhNxemoZl8TU88aB7nJZQ9yE6v68EJj9DuhdeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1WXSUYd+HiGhScMKNHeuzdBVI7PkfMZuf3z4QEOvPc=;
 b=MJzIPQUvfTSenwAsJ3bBIs36n7hFa5bY/k1xndnHUh9wfhFzfO0ZxqLbf9KJzDi2RjTm+TuP1oIX6w8worB0oJirs84JDOSwV+guhPG+NWgntzcVc5sqV5LvVWNAOY8EMjabybb9YXu8e+APo7HjhhZOJSnK+aIpnctSX9vLrwc=
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:19:28 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::5) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 09:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 09:19:27 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 04:19:19 -0500
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
        Aithal Srikanth <sraithal@amd.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V2 0/1] sched/numa: Fix disjoint set vma scan regression
Date:   Tue, 16 May 2023 14:49:31 +0530
Message-ID: <cover.1684228065.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8e42e6-897c-45e4-6548-08db55eea610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVKOwCNqqAUntYbL+JLzLcyk5aVbf+ALgNLrXYC+hhnLC5AAXs6DIYsYAd0jzbnkuiiQh3GC2l9eevDfBLmy4lCB1t6ZS6FikFnMp68wzAX/8Fycsw1pPuuIZynPAkqULy1QUiVzhK5d1Ka5JoYMIvNXPzhZmJaFroANIBaHBTcNg+e4IB/gvKilmSoSJAvSFEI5eMLfL0gMeZ74gzeFSfb26rLEpiblW2Q4Ig2aMyd17A2VTS2wtgvQeMC/1plF0kOdxxY1/6N0Pnu+EbLxiz1erHbWp5NN9Ahvz+fEXBezeaeg6CzTqarf9/03f/7gVZMiA/WjZVBTraS4g99t+u4vl8SzPep6/Nv2JCBUA09+QG8Qkqm4zRD7zs0FOhKjbxggh7axoXRTyvZwTJ6WrspMMzgoElIdyKVcIJsCSV6Uc8/kRwouZm03tDH7IQWtKUlpc8lfzzfU8AQ8a5faO77+ifkmrcJhjcnkceVsFu7EZrVTobQi3iPV5aDCImCknbnFL/rPvtDTEtTW683Z0QUcq2kQwJbo4Xrn11lSKyCWkdq5NWCIQ5GTsJnS2DGVSPTxeLfha5WEKwoJbfkGdippapm9ObwmsCXIHu7vRI7bmbVne25ID8fBDE8NRrfC2JSQwDUkZjO8Ii6cyYdxpOG8qLJAsdFYk1HjpzfEbJiF22hP9YQsEiTtf82+h0cEXQ9NSTZzCJ1Ot4w6tzuC95uk+yhReB6h9ZC8r0F+pDSF5jWq6HKxGDBtMGEclwKm6d4XjRqLE+bZKNbHMDBronznpx8LhsazHZl6PHHa2ERmKE0uAf6OcWut4+o5ofSl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(36756003)(2906002)(66899021)(336012)(426003)(8936002)(5660300002)(8676002)(7416002)(40460700003)(41300700001)(40480700001)(316002)(70206006)(70586007)(478600001)(54906003)(110136005)(6666004)(7696005)(186003)(16526019)(82740400003)(356005)(81166007)(26005)(36860700001)(47076005)(82310400005)(2616005)(83380400001)(966005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:19:27.9258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e42e6-897c-45e4-6548-08db55eea610
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

While this had improved significant system time overhead, there were corner
cases, which genuinely need some relaxation for e.g., concern raised by
PeterZ where unfairness amongst the thread belonging to disjoint set of vmas,
that can potentially amplify the side effects of vma regions belonging to some
of the tasks being left unscanned.

[1] had handled that issue by allowing first two scans at mm level
(mm->numa_scan_seq) unconditionally. But that was not enough.

One of the test that exercise similar side effect is numa01_THREAD_ALLOC where
allocation happen by main thread and it is divided into memory chunks of 24MB
to be continuously bzeroed.

(this is run default by LKP tests while numa01 is run default in mmtests which
operate on full 3GB region by each thread)

While RFC [2] tried to address this issue, the logic had more heuristics.
After posting [2], [3] also confirmed same regression.

The current patch addresses the same issue in a more accurate way as
follows:

(1) Any disjoint vma which is not associated with a task, that tries to
scan is now allowed to induce prot_none faults. Total number of such
unconditional scans allowed per vma is derived based on the exact vma size
as follows:

total scans allowed = 1/2 * vma_size / scan_size.

(2) Total scans already done is maintained using a per vma scan counter.

(3) For a very long running task, this scan counter is reset after 16
times whole mm of task scanning took place (using mm->numa_scan_seq).

With above patch, numa01_THREAD_ALLOC regression reported is resolved,
but please note that with [1] there was a drastic decrease in system time
for mmtest numa01, this patch adds back some of the system time.

Summary: numa scan enhancement patch [1] togethor with the current patchset
improves overall system time by filtering unnecessary numa scan
while still retaining necessary scanning in some corner cases which
involves disjoint set vmas.

(Mel, PeterZ this patch looks more precise handling of the issue) 

Your comments/Ideas are welcome.

Changes since V1:
1) Rewrite entire logic based on actual vma size than heuristics
2) Added Reported-by kernel test robot and internal LKP test
3) Rebased to 6.4.-rc1 (ba0ad6ed89)

Result:
SUT: Milan w/ 2 numa nodes 256 cpus

Run of numa01_THREAD__ALLOC 6.4.0-rc1 (that has w/ numascan enhancement)
		base-numascan		base			base+fix
real		1m3.025s		1m24.163s		1m3.551s
user		213m44.232s		251m3.638s		219m55.662s
sys		6m26.598s		0m13.056s		2m35.767s
		
numa_hit 		5478165		4395752		4907431
numa_local	        5478103		4395366		4907044
numa_other	             62		    386		    387
numa_pte_updates	1989274		  11606		1265014
numa_hint_faults	1756059		    515		1135804
numa_hint_faults_local	 971500		    486		 558076
numa_pages_migrated	 784211		     29		 577728

Below is the mmtest autonuma performance
autonuma
===========
base: 6.4.0-rc1+
					base w/o numascan      	base(=w/ numascan)    base + fix

 
Amean     syst-NUMA01                  247.46 (   0.00%)       18.52 *  92.51%*      148.18 *  40.12%*
Amean     syst-NUMA01_THREADLOCAL        0.23 (   0.00%)        0.21 *   5.06%*        0.22 *   1.90%*
Amean     syst-NUMA02                    0.70 (   0.00%)        0.70 *   1.02%*        0.73 *  -3.46%*
Amean     syst-NUMA02_SMT                0.59 (   0.00%)        0.59 *   0.00%*        0.58 *   2.42%*
Amean     elsp-NUMA01                  309.54 (   0.00%)      284.57 *   8.07%*      306.84 *   0.87%*
Amean     elsp-NUMA01_THREADLOCAL        1.02 (   0.00%)        1.02 *   0.42%*        1.04 *  -1.53%*
Amean     elsp-NUMA02                    3.22 (   0.00%)        3.55 * -10.21%*        3.32 *  -3.15%*
Amean     elsp-NUMA02_SMT                3.71 (   0.00%)        3.86 *  -4.08%*        3.74 *  -0.69%*

Duration User      383183.43   294971.18   357446.52
Duration System      1743.53      140.85     1048.57
Duration Elapsed     2232.09     2062.33     2214.44

Ops NUMA alloc hit                  57057379.00    43378289.00    51885613.00
Ops NUMA alloc local                57055256.00    43377265.00    51884407.00
Ops NUMA base-page range updates   137882746.00       25895.00    83600214.00
Ops NUMA PTE updates               137882746.00       25895.00    83600214.00
Ops NUMA hint faults               139609832.00       22651.00    84634363.00
Ops NUMA hint local faults %       113091055.00       18200.00    65809169.00
Ops NUMA hint local percent               81.01          80.35          77.76
Ops NUMA pages migrated             13415929.00        1798.00     9638327.00
Ops AutoNUMA cost                     699269.24         113.47      423940.14

links:
[1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
[2] https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
[3] https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/

Note: I have updated patch-1 with appropriate log required for the commit, so some of
above result/info is duplicated.

Raghavendra K T (1):
  sched/numa: Fix disjoint set vma scan regression

 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 41 ++++++++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.34.1

