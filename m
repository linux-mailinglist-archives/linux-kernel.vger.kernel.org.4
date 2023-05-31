Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD171756D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjEaE0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjEaE0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:26:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0D139
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhJ/2/dCvHrR40RxgxscDZKUfTc2fKkG/DlWTNpfKxvDxXmumb5LdxCg1cR/s6JOrhWPNwStbmgOMW+TEc/7BYbN+hGC5gmLHrH32R2KCDhxEZPYXTmCB4wi+VywvXUCnRXYIuGdXWudUQZVfiMHozTrI/6WFK1i2S0duUMJLiqhGL8QLKiexBkVtyVcrnfrWbPyniZIPuExIK95FLf8Z9DE1eFl/wq+S4p8DxXxOaUhecB3/4todlRRY03RvKoSUnHyihUTq6M+NOOuGGKmHAC5Fa2ePopp6/jsFb5ORueu1eUyTFsJdYeRzwpcPTf9txY26t2Ar4gW9FNNFfbNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=816920Rf2asBHNPAjMt6+r8ZmC3XEmTn/ze0cKJ+XEk=;
 b=AXJuNHOomSY44yUVugYa0apo/053jn/10TsLuyKdKhzPKH/NDG/kLdP70VjD5TbLG2l5k6C4NItNtTKC6dK2Z/SWaiZd3nLU0TyxLOI6VODusdbbKkbuMEnNJkUDH1StlM+ef6jat49Gw2GFMSNBEl7BlO2aRh89hL3cEdqkdPHJkGTfHOQGOmo4Ah0eRxkNIy8aURejH8vre7wrwKDJ9ZP6HgmSO53nHrM5hpV4F1TYqVpG8AnVWQLnhuUzCAIonmDAiuzQWAjQVlMOPCLqeYUXTKrDwdiBlO2iggNkvzyqmUZvjlyGJax1JTTYWyiOAeNLubnKhjtSTye2TJXvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=816920Rf2asBHNPAjMt6+r8ZmC3XEmTn/ze0cKJ+XEk=;
 b=b64lo1+vuqngt2d5l6Bksdx9XfrhZ1VsJb/l7Zf8ziIg9N8lDhpKO5Q3Txt+gYl2RRgokjTYSmMfH2C0j0U5I+P4m6wjjElswdBsVLZYUv/szm9EQTMjWr1N1ntJnAIIgUpVG4sZzOsYwhRuz61wP+svZcl1n9KuIxvI3j1WSXs=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:25:59 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::de) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:25:58 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:25:53 -0500
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
Subject: [RFC PATCH V3 0/1] sched/numa: Fix disjoint set vma scan regression
Date:   Wed, 31 May 2023 09:55:25 +0530
Message-ID: <cover.1685506205.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 91de0582-5e30-4811-5ad1-08db618f220e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTJJb9TlSSDuxcUtECf8siWDuPQddjfZjg394Q2uKAoeFfL9R38EJyGYFYRSFwL3DNpUzQEV0Nbd6y6L07ExnfajXbVWlj8kUtHyGR59BooJQuGIh3OFfrJs5RUNbJS7WuOzogbwPhcM+OarpXqT9uRhxEz6SPh48rvdHOo+C0toQ+qAvx5qcF32a7LV39sDzH2nqU1owNrkXqikcQqC5eX/wdA0NETK4tOMRXuXlc700PmUqYSji6nwZGJlwWBJvErt5N5lnKE83d2Dr1IICbPkH5tmbyHMAX3hdhOH8wjMHDDMsuVr1+ZpnxGRcM/Zqeugf2qcUgvS8e64Q6yjmD20LSlYh1rSH0kEhfID+reXPf2VXlVcIRnvMQ6LAfa/y9ua50Y1ylQ1qL5D0Musu6LSLZA6+L137JnlixRpwP+O/X3ZJCjud9zdzu129qlvTEtSBgrltwvSLmYZzOGKGS+zn83qP2jiNol1thLe+nSwjcAZaELcRTniFS+j1c6NwoQj7lzCSbpJSYGZA84dtzwErojkHE36L+my5yC7FchQBw+61FcXC46RXpS1ngy4mlaKyIIuzSHujckrsoGVr5XTt6asTRyZU7mrtZWkeSbhItpVGABfE8A5pRPtlWSqabPkSf5IuN+beAdl5+JHiUSn6UrUMPwkZDzrNYcnCvVK3tpqhB+mW0KCJzLxNsDBi7eR/7i6xJ5gGryRbH69K9qYxpdfgi46ZSS5toUfinkVDrMkS5Gf7/Ce3LbA4Kd7DpKg4VVaZ/SCX/ojNCm6d+5OD/YD6vjsvfiiPMMR9O85XborU4NVO9UV+gYhkjLn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(316002)(186003)(2906002)(16526019)(36860700001)(83380400001)(36756003)(2616005)(40460700003)(47076005)(40480700001)(426003)(336012)(6666004)(4326008)(70206006)(70586007)(66899021)(966005)(478600001)(41300700001)(7696005)(356005)(54906003)(82740400003)(81166007)(110136005)(26005)(8676002)(82310400005)(5660300002)(8936002)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:25:58.1859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91de0582-5e30-4811-5ad1-08db618f220e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
that can potentially amplify the side effects, where vma regions belonging
to some of the tasks being left unscanned.

[1] had handled that issue by allowing first two scans at mm level
(mm->numa_scan_seq) unconditionally. But that was not enough.

One of the test that exercise similar side effect is numa01_THREAD_ALLOC where
allocation happen by main thread and it is divided into memory chunks of 24MB
to be continuously bzeroed (for 128 threads on my machine).

This was found in internal LKP run and also reported by [4].

While RFC V1 [2] tried to address this issue, the logic had more heuristics.
RFC V2 [3] was rewritten based on vma_size.

Current implementation drops some of additional logic for long running task
and relooked some of the usage of READ_ONCE/WRITE_ONCE().

The current patch addresses the same issue in a more accurate way as
follows:

(1) Any disjoint vma which is not associated with a task, that tries to
scan is now allowed to induce prot_none faults. Total number of such
unconditional scans allowed per vma is derived based on the exact vma size
as follows:

total scans allowed = 1/2 * vma_size / scan_size.

(2) Total scans already done is maintained using a per vma scan counter.

With above patch, numa01_THREAD_ALLOC regression reported is resolved,
but please note that with [1] there was a drastic decrease in system time
for mmtest numa01, this patch adds back some of the system time.

Summary: numa scan enhancement patch [1] togethor with the current patchset
improves overall system time by filtering unnecessary numa scan
while still retaining necessary scanning in some corner cases which
involves disjoint set vmas.

Your comments/Ideas are welcome.

Changes since:
RFC V2:
1) Drop reset of scan counter that tried to take care of long running workloads
2) Correct usage of READ_ONCE/WRITE_ONCE (Bharata)
3) Base is 6.4.0-rc2

RFC V1:
1) Rewrite entire logic based on actual vma size than heuristics
2) Added Reported-by kernel test robot and internal LKP test
3) Rebased to 6.4.-rc1 (ba0ad6ed89)

Result:
SUT: Milan w/ 2 numa nodes 256 cpus

Run of numa01_THREAD__ALLOC on 6.4.0-rc2 (that has w/ numascan enhancement)
                	base-numascan	base		base+fix
real    		1m1.507s	1m23.259s	1m2.632s
user    		213m51.336s	251m46.363s	220m35.528s
sys     		3m3.397s	0m12.492s	2m41.393s

numa_hit 		5615517		4560123		4963875
numa_local 		5615505		4560024		4963700
numa_other 		12		99		175
numa_pte_updates 	1822797		493		1559111
numa_hint_faults 	1307113		523		1469031
numa_hint_faults_local 	612617		488		884829
numa_pages_migrated 	694370		35		584202

We can see regression in base real time recovered, but with some additional
system time overhead.

Below is the mmtest autonuma performance

autonumabench
===========
(base 6.4.0-rc2 that has numascan enhancement)
					base-numascan		base			base+fix
Amean     syst-NUMA01                  300.46 (   0.00%)       23.97 *  92.02%*       67.18 *  77.64%*
Amean     syst-NUMA01_THREADLOCAL        0.20 (   0.00%)        0.22 *  -9.15%*        0.22 *  -9.15%*
Amean     syst-NUMA02                    0.70 (   0.00%)        0.71 *  -0.61%*        0.70 *   0.41%*
Amean     syst-NUMA02_SMT                0.58 (   0.00%)        0.62 *  -5.38%*        0.61 *  -3.67%*
Amean     elsp-NUMA01                  320.92 (   0.00%)      276.13 *  13.96%*      324.11 *  -0.99%*
Amean     elsp-NUMA01_THREADLOCAL        1.02 (   0.00%)        1.03 *  -1.83%*        1.03 *  -1.83%*
Amean     elsp-NUMA02                    3.16 (   0.00%)        3.93 * -24.20%*        3.14 *   0.81%*
Amean     elsp-NUMA02_SMT                3.82 (   0.00%)        3.87 *  -1.27%*        3.44 *   9.90%*

Duration User      403532.43   279173.53   359098.23
Duration System      2114.31      179.20      481.54
Duration Elapsed     2312.20     2004.48     2335.84

Ops NUMA alloc hit                  55795455.00    45452739.00    45500387.00
Ops NUMA alloc local                55794177.00    45435858.00    45500070.00
Ops NUMA base-page range updates   147858285.00       18601.00    42043107.00
Ops NUMA PTE updates               147858285.00       18601.00    42043107.00
Ops NUMA hint faults               150531983.00       18254.00    42450080.00
Ops NUMA hint local faults %       125691825.00       11964.00    32993313.00
Ops NUMA hint local percent               83.50          65.54          77.72
Ops NUMA pages migrated             13535786.00        2207.00     4654628.00
Ops AutoNUMA cost                     753952.10          91.44      212633.14

Please note there is a system time overhead added for numa01 but we still have very
good improvement w.r.t base without numascan. 

[1] Link: https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
[2] Link: https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
[3] Link: https://lore.kernel.org/lkml/cover.1684228065.git.raghavendra.kt@amd.com/T/
[4] Link: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/

Raghavendra K T (1):
  sched/numa: Fix disjoint set vma scan regression

 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.34.1

