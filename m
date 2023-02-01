Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0854D686122
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBAIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjBAIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:03:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0C29174
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGbLAmYlba3bNN0TSququRzTtkaU0rZX2iP25L0hfTglCJUjQCMW178CCnh1ueSX7P4r+khWdWDiueci39sXZiocJ2YDvM59gc/578gFl/d2G154nQxEDp6/qujNFd6mg3dSpt3CT35jLwdFBn4BR4Ja+vx/kTdx2gVhsq2ecoWVr+AKLvg0Sce3P86QCXFrMWBjh3WiGonKsiDkxugc8le1MjCCJlpbSgHw2Rxmoa83jaxMPrgVJgsmFB4tz0ATim15gkFutmlUnhaGHHn8mVo2yKDBHsHtYRMEmbwWkMZ1RKN+pX6RvnNnGHzS+f53zqL69GSlgkciQyryE9392w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbwc2L6G4vAt5F3dqSFzp6tkddL09DjtEvfATwMBT9Q=;
 b=B1dJg7/JbFDSeo4WORLlDRRedxvYxyk4dO2Ar+tMGczgmnnPjRcS3c1SjtxBD3TM4CpJcfwt6YNx8ZmuVxVMhb/1wdc46JeJnyQOAk3xu6O7B2/djBXykRcWMHcGxRmdJlcQP3ssnWlazCqum+xF5RPAwGGKHKsEkFIZ4HTF1jPkJuJT6Pmwo/Wz1Y7uUKW7nq+pcuQZ17XkXjA2WyykscqHV6laPJy5BzKm74OMtJLTj3mwtQIYsoG2bUQwA2fK8EyHLWWKwL0fpeCUhNVC6qo8c5mm13T4P9LjF5UgdNF0srv1Cf7ugYZkd50D28KoWvmpvdq4S/HyjsfjcXXBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbwc2L6G4vAt5F3dqSFzp6tkddL09DjtEvfATwMBT9Q=;
 b=FuHkiBSsNPSOXUEcDsSa52a8h+5N57ncjUaScLYvU7pNHdE+WYCBhuAVHHYMYij/vTJucAP/0wTSd+ug22UJJPLJ1gbUMjptXZQtXTI/RsqEbbO47S2/43F4SX1cz4Ycg7NeEsyGrtmaORBCGD1riuijKD2YpYL4k2Tv4XxjPGo=
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 08:03:22 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ea) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Wed, 1 Feb 2023 08:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.22 via Frontend Transport; Wed, 1 Feb 2023 08:03:22 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 02:03:18 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [PATCH V2 0/3] sched/numa: Enhance vma scanning 
Date:   Wed, 1 Feb 2023 13:32:19 +0530
Message-ID: <cover.1675159422.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f98d00-6bf0-4637-1047-08db042ac9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bEbwiqL2DalbRW4gW2ZbJPolBAov1cDJaOwatLDjcxwx1gToV2z1UFann5IqVIfrf/FbZ2SzcvwtZ3SmCxwzfORn8mSLrZGejPMm7wlnUpVvBzuUukeIv1JA9/dJSFioHFwiERRzitwEmpqXrbyqvC0V/VZjj90hp3Bjjv6J9h7k0MpzMpB1jLCMtvy/2jVuDIdCbg8UBzEMzN41d98iWldKEBeBN5IpturPK7D0DdHr+IF1BEBYQ3b3LD06oR2Nn7ygb8d4rzFFNLi0w7O3iDvbNR0kIKYjMk2lEAOPlx7EXqQ33CwQWxbSimvFzrkNR2gGFbrrcLSUVncLnunRwSnkpCkYUPU1SliWmgZ+wVDVqv4FTqRAuyJg7rV0Lm8higvH5bLV2EFR2PEApP0pZ9lkhOv+JPNYu1xBritybNS1pjilLzyU+dAypNtiQzneSlfVE1YL79ZSY0KitVlHwI0cX8Gfv613oFzwIk1pTgnduFwJQWhpKRDPig/euOM3g1N/7YdaT3Zm3DR39/V1OuXwKGAA3NApa+JNk+KWw78swkGCudLnorGgh5JEgcylSWdxRn7Ak4T3xEVUaUGVtBGx9STp6NVZbXdEeRHIROEFK8gq7U8ZKllC1ICMN0vPakYCnpZtj5EJwo24vAhu2yz5HWaQKlfxTGSnLXg444QVjcPx2WGnscDYPdCFsIb1dOmc2ijka2QAIiRJ85hSfF8GsS0y7vpG597fJeJn9LQD4j5qSFHltQcr5cpSQ8ewjzg1QIAf2ZTqh5xb46VkhbLBSO9Rm2QMJU5pd2AL+5NpQjBv7hyKOwifqYiACum9USBwie9r7wVrE9bNCZqfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(16526019)(186003)(26005)(82740400003)(40460700003)(36860700001)(2906002)(70586007)(4326008)(54906003)(41300700001)(8936002)(81166007)(40480700001)(356005)(8676002)(336012)(83380400001)(426003)(4743002)(36756003)(47076005)(2616005)(110136005)(82310400005)(5660300002)(316002)(70206006)(478600001)(966005)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 08:03:22.2336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f98d00-6bf0-4637-1047-08db042ac9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The patchset proposes one of the enhancements to numa vma scanning
suggested by Mel. This is continuation of [2]. Though I have removed
RFC, I do think some parts need more feedback and refinement.

Existing mechanism of scan period involves, scan period derived from
per-thread stats. Process Adaptive autoNUMA [1] proposed to gather NUMA 
fault stats at per-process level to capture aplication behaviour better.

During that course of discussion, Mel proposed several ideas to enhance
current numa balancing. One of the suggestion was below

Track what threads access a VMA. The suggestion was to use an unsigned
long pid_mask and use the lower bits to tag approximately what
threads access a VMA. Skip VMAs that did not trap a fault. This would
be approximate because of PID collisions but would reduce scanning of 
areas the thread is not interested in. The above suggestion intends not
to penalize threads that has no interest in the vma, thus reduce scanning
overhead.

About Patchset:
Patch1:
1) VMA scan delay logic added (Mel) where during initial phase of VMA,
we delay the scanning by sysctl_numa_balancing_scan_delay.

2) A new status structure is added (vma_numab) so as to not grow
the vm_area_struct in !NUMA_BALANCING case.

Patch2:
3) last 6 Bits of PID is used as index to remember which PIDs accessed
VMA in fault path. This is further used to restrict scanning of VMA in
scan path.

Please note that first two times scanning is unconditionally allowed
(using numa_scan_seq). But this may need some potential change since
numa_scan_seq is per mm.

Patch3: 
4) Introduce basic patch clearing of accessed PIDs. This is as of now
done at every 4 * sysctl_numa_balancing_scan_delay interval.

This logic may need more experiment/refinement.

Things to ponder over (and Future TODO):
==========================================
- Improvement to clearing accessing PIDs logic (discussed in-detail in
  patch3 itself)

- Current scan period is not changed in the patchset, so we do see frequent
 tries to scan. Relaxing scan period dynamically could improve results
further.

Result Summary:
================
The result is obtained by running mmtests with below configs
config-numa-autonumabench

There is a significant reduction in AutoNuma cost from the benchmark
runs, But some of the results need improvement. I hope working on the
potential changes mentioned in patch3 and hopefuly numa_scan_period
tuning depending on current scanning efiiciency would help. will be
working on that..

SUT:
2 socket AMD Milan System
Thread(s) per core:  2
Core(s) per socket:  64
Socket(s):           2

256GB memory per socket amounting to 512GB in total
NPS1 NUMA configuration where each socket is a NUMA node

autonumabench
                                                   6.1.0                  6.1.0
BAmean-99 syst-NUMA01                  195.84 (   0.00%)       17.79 (  90.91%)
BAmean-99 syst-NUMA01_THREADLOCAL        0.19 (   0.00%)        0.19 (   2.56%)
BAmean-99 syst-NUMA02                    0.85 (   0.00%)        0.85 (   0.00%)
BAmean-99 syst-NUMA02_SMT                0.62 (   0.00%)        0.65 (  -4.30%)
BAmean-99 elsp-NUMA01                  254.95 (   0.00%)      322.69 ( -26.57%)
BAmean-99 elsp-NUMA01_THREADLOCAL        1.04 (   0.00%)        1.05 (  -1.29%)
BAmean-99 elsp-NUMA02                    3.08 (   0.00%)        3.29 (  -6.94%)
BAmean-99 elsp-NUMA02_SMT                3.49 (   0.00%)        3.43 (   1.91%)

                                          6.1.0          6.1.0
Ops NUMA alloc hit                  59210941.00    50772531.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                59200395.00    50771359.00
Ops NUMA base-page range updates    90670863.00       10952.00
Ops NUMA PTE updates                90670863.00       10952.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                92069634.00        9501.00
Ops NUMA hint local faults %        69966984.00        9213.00
Ops NUMA hint local percent               75.99          96.97
Ops NUMA pages migrated              8424631.00         287.00
Ops AutoNUMA cost                     461142.93          47.59

[1] sched/numa: Process Adaptive autoNUMA 
 Link: https://lore.kernel.org/lkml/20220128052851.17162-1-bharata@amd.com/T/
[2] RFC V1:
 Link: https://lore.kernel.org/all/cover.1673610485.git.raghavendra.kt@amd.com/

Changes since RFC V1:
 - Include Mel's vma scan delay patch
 - Change the accessing pid store logic (Thanks Mel)
 - Fencing structure / code to NUMA_BALANCING (David, Mel)
 - Adding clearing access PID logic (Mel)
 - Descriptive change log ( Mike Rapoport)

Mel Gorman (1):
  sched/numa: Apply the scan delay to every vma instead of tasks

Raghavendra K T (2):
  sched/numa: Enhance vma scanning logic
  sched/numa: Reset the accessing PID information periodically

 include/linux/mm.h       | 23 +++++++++++++++++++
 include/linux/mm_types.h |  9 ++++++++
 kernel/fork.c            |  2 ++
 kernel/sched/fair.c      | 49 ++++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c         |  1 +
 mm/memory.c              |  1 +
 6 files changed, 85 insertions(+)

-- 
2.34.1

