Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1CD6A526F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjB1Eva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Ev1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:51:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7800222D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3YT/O0Mf7SnL7fI9TeSjFK9/uVLF8r+7k9+SYAKn4ktkxksctg9msSwqMeTN8dTdE/ZO/svzaU9r7Xb0l6vRyb18bOk+V8NZhYcMogdoHKZbwkH1BcpEROrIoEuHqzOY629+IvxHYSDn7hlnAznKNnDah2xZZ3EzTNXuoMbC0eG4cTMbCuuYPFDDZgApCmZeYzcgaujKurcwaU1eET/JxPe55cdK2k2fdPuDU69tKlrCV+K9OtzE7q/Kw+uBTvLADpsgHreAgxArsCFdN9hzRn2puYrPN7yPpxMyp7vEaR/gxAul71QXGwi2AM/gWibUyPuCGuvCouNPLqlHrKhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJjOr4LxH4xd7HpJG+mqE6vXZhclHs2b9nG5nJ5aPmY=;
 b=JuyyOTyLBshnz2CBXFzN1d2VoxOGccfHsQDpUI/6pShAqI3SydvlpCGS0yIa+oIWBZbPa70odswKX4DojE8wj38emfXJ/aUorEl30xxEmjEp56MiPPbMU3ZMw5S1jM2MrPInVBSZz8h5wHJV/IgoIElC/B8xIcqW8OQGe9wwU3M7/4wNZtcdTWHX5g3OynNA27FKIKNU1pz/+7h/Y6hO9ILoFAn0pODzvLojkilI8WWOUvqH6RajNV6K1rURV/iJbUbgGu7nAWSQ6rkErrz/zpwXCiCMujaLbFOfgbnQugwSkD/AN24gUiPbCBetwoCUYMBmwzJ2/Dg1GNEHsQfZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJjOr4LxH4xd7HpJG+mqE6vXZhclHs2b9nG5nJ5aPmY=;
 b=0etItS2sxjnFAFaOWlSa4qMzUaBtkPume3i2UG7gB/rB6Yp5N527GYveB9Ud/LmoE9wPdVo7dLhk83OrqQR/L+yNaxi14sZUFKludJgixNeBW4ncOr3QSu77jFIVzyjeqx1K4jK4e6I2K/VRkJMG8BdMtI/q0pLaZok5zVyJL6k=
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Tue, 28 Feb
 2023 04:51:23 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f3) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 04:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 04:51:23 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:50:39 -0600
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
Subject: [PATCH V3 0/4] sched/numa: Enhance vma scanning 
Date:   Tue, 28 Feb 2023 10:20:18 +0530
Message-ID: <cover.1677557481.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: a633e9a3-90a9-450d-e622-08db194770f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oShm75rd8PSzbOSTD+mnkCRAEap/yfvGLOIyyCxBl6vxdoO3vC4gu9IBuvGge8HXLSFVRsVfTf9pis1EbsoslTWysYKCDKjGr279v/aYhdelyP4gSiNlaxXya+em/ogKESBK6+PUBFD6xvw8K+50smXdgDHDhIKjvvYEgZ3M+vYNBzEV7lqmfDJsTp+GUbd9DDvVASQpud7PSdWcz0piDDNL20ypt57TWvXu72pnvbEnFt0aWK5abPm55bjjr9uSI/QS1Ate0UQVSBIjVgDQka/LLfOo3xpZU8VeaTBM83t2PPFazEhbpf3FYdc16Iv6ng1M5lCWBIsu7qSE96sxoERM464K50VZri8Cu7SWdIoL5R2vTpOeDtjAadVVx0zJyb4n+hUHDwPKfJoPRjauW9lXvrCAOdiQQzltCoZpABLeRy6QcernuNXpmLWm9znKFdBwfghBjN1JrhccQIoK2PUoc0Ska3ICnqPyRHXA3DLFECW7tJcrpnOxVzh9BIZM6TCN4JUPQKPqf95lQRdO6fsuRSjtxllmiKU+g3u9NoHVU9LLVAxgeUPHQePMuUaD6CzjMqVguRefu1cx3pDGq5iq0btGcVkmnxDUaqNOY4rUokXnEVO3fnkIUFU5bJ5J3I807C40uWxtsDzaKyXP6pa0PRPgQSm6qpjCZKZeW/QEl9pn7K8BhbnEyBCNEkexYEPZbt92NRXqtNmRsnz7jrIua9a0RQbhsS7JntS3BtCe6Gybla7lgXv8HdWeYQAsMHsAbMvwRsFsoyAcV01//UesPuacjjbD7mOft8+E4aI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(36860700001)(2906002)(81166007)(82740400003)(478600001)(7696005)(82310400005)(4743002)(47076005)(336012)(16526019)(6666004)(26005)(356005)(40480700001)(36756003)(426003)(186003)(966005)(70206006)(70586007)(83380400001)(40460700003)(8676002)(41300700001)(2616005)(4326008)(110136005)(5660300002)(316002)(54906003)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:51:23.0055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a633e9a3-90a9-450d-e622-08db194770f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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
suggested by Mel. This is continuation of [3]. 

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

V3 changes are mostly based on PeterZ comments (details below in
changes)

Summary of patchset:
Current patchset implements:
1. Delay the vma scanning logic for newly created VMA's so that
additional overhead of scanning is not incurred for short lived tasks
(implementation by Mel)

2. Store the information of tasks accessing VMA in 2 windows. It is
regularly cleared in (4*sysctl_numa_balancing_scan_delay) interval.
The above time is derived from experimenting (Suggested by PeterZ) to
balance between frequent clearing vs obsolete access data

3. hash_32 used to encode task index accessing VMA information

4. VMA's acess information is used to skip scanning for the tasks
which had not accessed VMA

Things to ponder over:
==========================================
- Improvement to clearing accessing PIDs logic (discussed in-detail in
  patch3 itself (Done in this patchset by implementing 2 window history)

- Current scan period is not changed in the patchset, so we do see frequent
 tries to scan. Relaxing scan period dynamically could improve results
further.

[1] sched/numa: Process Adaptive autoNUMA 
 Link: https://lore.kernel.org/lkml/20220128052851.17162-1-bharata@amd.com/T/

[2] RFC V1 Link: 
  https://lore.kernel.org/all/cover.1673610485.git.raghavendra.kt@amd.com/

[3] V2 Link:
  https://lore.kernel.org/lkml/cover.1675159422.git.raghavendra.kt@amd.com/

Changes since V2:
patch1: 
 - Renaming of structure, macro to function,
 - Add explanation to heuristics
 - Adding more details from result (PeterZ)
 Patch2:
 - Usage of test and set bit (PeterZ)
 - Move storing access PID info to numa_migrate_prep()
 - Add a note on fainess among tasks allowed to scan
   (PeterZ)
 Patch3:
 - Maintain two windows of access PID information
  (PeterZ supported implementation and Gave idea to extend
   to N if needed)
 Patch4:
 - Apply hash_32 function to track VMA accessing PIDs (PeterZ)

Changes since RFC V1:
 - Include Mel's vma scan delay patch
 - Change the accessing pid store logic (Thanks Mel)
 - Fencing structure / code to NUMA_BALANCING (David, Mel)
 - Adding clearing access PID logic (Mel)
 - Descriptive change log ( Mike Rapoport)

Results:
Summary: Huge autonuma cost reduction seen in mmtest. Kernbench and
dbench improvement is around 5% and huge system time (80%+) improvement
from mmtest autonuma.

kernbench
=============
                                    6.1.0-base                 6.1.0-patched
Amean     user-256    22437.65 (   0.00%)    22622.16 *  -0.82%*
Amean     syst-256     9290.30 (   0.00%)     8763.85 *   5.67%*
Amean     elsp-256      159.36 (   0.00%)      157.44 *   1.20%*

Duration User       67322.16    67876.18
Duration System     27884.89    26306.28
Duration Elapsed      498.95      494.42

Ops NUMA alloc hit                1738904367.00  1738882062.00
Ops NUMA alloc local              1738904104.00  1738881490.00
Ops NUMA base-page range updates      440526.00      272095.00
Ops NUMA PTE updates                  440526.00      272095.00
Ops NUMA hint faults                  109109.00       55630.00
Ops NUMA hint local faults %            5474.00         196.00
Ops NUMA hint local percent                5.02           0.35
Ops NUMA pages migrated               103400.00       55434.00
Ops AutoNUMA cost                        550.59         281.11

autonumabench
===============
                                    6.1.0-base                 6.1.0-patched
Amean     syst-NUMA01                  252.55 (   0.00%)       27.71 *  89.03%*
Amean     syst-NUMA01_THREADLOCAL        0.20 (   0.00%)        0.23 * -12.77%*
Amean     syst-NUMA02                    0.91 (   0.00%)        0.76 *  16.22%*
Amean     syst-NUMA02_SMT                0.67 (   0.00%)        0.67 *  -1.07%*
Amean     elsp-NUMA01                  269.93 (   0.00%)      309.44 * -14.64%*
Amean     elsp-NUMA01_THREADLOCAL        1.05 (   0.00%)        1.07 *  -1.36%*
Amean     elsp-NUMA02                    3.26 (   0.00%)        3.29 *  -0.79%*
Amean     elsp-NUMA02_SMT                3.73 (   0.00%)        3.52 *   5.64%*

Duration User      318683.69   330084.06
Duration System      1780.77      206.14
Duration Elapsed     1954.30     2233.06


Ops NUMA alloc hit                  62237331.00    49179090.00
Ops NUMA alloc local                62235222.00    49177092.00
Ops NUMA base-page range updates    85303091.00       29242.00
Ops NUMA PTE updates                85303091.00       29242.00
Ops NUMA hint faults                87457481.00        8302.00
Ops NUMA hint local faults %        66665145.00        6064.00
Ops NUMA hint local percent               76.23          73.04
Ops NUMA pages migrated              9348511.00        2232.00
Ops AutoNUMA cost                     438062.15          41.76

dbench
========
dbench -t 90 <nproc>

Throughput
#clients             base             	patched			%improvement
1		842.655 MB/sec		922.305 MB/sec		9.45
16              5062.82 MB/sec          5079.85 MB/sec          0.34
64              9408.81 MB/sec          9980.89 MB/sec          6.08
256             7076.59 MB/sec          7590.76 MB/sec          7.26

Mel Gorman (1):
  sched/numa: Apply the scan delay to every new vma

Raghavendra K T (3):
  sched/numa: Enhance vma scanning logic
  sched/numa: implement access PID reset logic
  sched/numa: Use hash_32 to mix up PIDs accessing VMA

 include/linux/mm.h       | 30 +++++++++++++++++++++
 include/linux/mm_types.h |  9 +++++++
 kernel/fork.c            |  2 ++
 kernel/sched/fair.c      | 57 ++++++++++++++++++++++++++++++++++++++++
 mm/memory.c              |  3 +++
 5 files changed, 101 insertions(+)

-- 
2.34.1

