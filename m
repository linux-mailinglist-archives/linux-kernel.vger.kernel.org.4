Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7126A6C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCAMUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:20:21 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F81ABD3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOr64tsdLffsGwbyJqYUfZuu0ARwZewcI1iIiv2Vyf+xEYM6sCoD73RTZsZismL/Xrk5tPBQbEFw7anV6EOepBx6bVWOQbIa032bCZu1sCrztnM6PKvQrB7VjCyjeovbZ1661MErha68OHJXI+HiWeU8ekakObjhQ9Mm/MUzeU59w/mSjmd7xoSb4P1IyJEiyMbxLMU1dJXB6g7C3Iq1Dxy6JXiaakZONhd0uBX0X8ZyzrVzPD9Akt/VwvUZWUtUQV09dNdSPpVXeidrprOW6j01sYmC0JYq3sa/Dou72jQvmtEUdCzt5UtwoNdyiHQGtcR6ydurwzBLuzBwtYgIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tqoZdEcQN/yTFom55aJZUc6e6tkxd3G0FXhe8xYlv4=;
 b=ZOUohbxKKsQMtS7YJ7DiM7jylXNfAWRGFDFcCHC+qju5KbpwK82ZvgEgblMGrhoonz6XIeVhSspNTY8UcgmcR5CtzLlkpxHivoXImL+xgqZ336jbbGN185eKM4H8WX2bOrvj2AEGcFks7wO5BA/XRLh8mKc524D7nIWupG2yEXQJApq93pCiYEp1kCxH+QueXeenfSD2804z6aVi1k8o7lJBO3ujT6vmV34X1AcndaEY5tzFnuQ+CuncYp9ZBaY/dFu1NXL6U15sIYoKwfyQLFcFTC+GeI0HKeCwd75bzmbd7oZ7V2O8jdAZReHVGRkL4znbNwRa/R8A2lJC4NyQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tqoZdEcQN/yTFom55aJZUc6e6tkxd3G0FXhe8xYlv4=;
 b=vNAMps2oHz8XBkQTcE+vL/P2PVW7chJkQ2XKA0yxuZHjjc5oLMUQhIzq5Qbjuxo8yTuGjEoRfbSn6nTnwo4EzV+6zMwbzPsV+OOlWsnu5/XziUY8E2ojQ2myqAnUD4HJR9Q0/DC3FuY9m4sd2FYpMWh1yZ6JqBLiodrx9KuAbx0=
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 12:20:15 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::16) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 12:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 12:20:15 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 06:20:07 -0600
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
Subject: [PATCH REBASE V3 0/4] sched/numa: Enhance vma scanning
Date:   Wed, 1 Mar 2023 17:48:59 +0530
Message-ID: <cover.1677672277.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdff911-7a47-4fc0-a235-08db1a4f5071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOywno2p2HEuI3SXuz+woe4abwAjBA5cKm4/YQPOJaqerSkHqGVLZN//P3GBMGIIyE9T/CyW1oK39pHXurpKuw+O9L2p01FU9uPuPNGvbDIzwfi+noJ+X6MkTFJk1VYYLjW6NjHy059joK5GjVMbCalmVZgqbji/m+pkQByze4SJA2MDTAkhJehuN63i+aJ5KLHhq+4Ajb8lhFt2M4SMUTf/7sCXlWUkk6OKHclirc4B/XwAfKmpQDlBXlqyxhyeCBSefyw1RnERYaLVtYjtzSIe1aCbA0ZH58bwx3L/2ayUoc7Oy/aWHAr0hUewbtNlWXS97s3huBHdjpYA08CARBjvsSYwl7jpefksv8NPOGfRvdjsbiejLf+ZLUaxSOtYRVH2BNr2CkIOxko8Kur2N3ywMW+IBdwyCupDO6S5itnJVGGqOtNh8eHIeYa+D5V+uqx1O4ziNVqTo5hq416zPyMWLPGNBfd8CT+oE8dYey2NW5ynvw0OUSw3QL10MlGbgQebG4o+xY1loB11MW4wzUaHHRV4FUWI37rtbwk7cS6kAsLdCHYtbW+gtCDdd3EahWQQmH5txRBrrNpMOjqdq3l+9OQ0iYXWnQhhk0aHzvZ7Ay+B/wMB/BLzMHaxL2BBz3vFeehcZxkjwj09KDu4c9VrqEz995zi9uSq/G8+8uNdRPsBHxa+J3QQfDhAtxE+LB5N8rqF5DhqZJQCZQmPONxcsNy+oizL8o5AjMKa5zwXzZJ2jlXViyexkkhwzrRM1whfO78oX4VThSIJaE3oPqjKFKeAy5mJpg6dD9eBQLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(36756003)(54906003)(316002)(426003)(336012)(47076005)(110136005)(478600001)(83380400001)(6666004)(7696005)(966005)(2616005)(16526019)(186003)(26005)(8936002)(356005)(41300700001)(2906002)(5660300002)(40460700003)(70206006)(70586007)(8676002)(36860700001)(40480700001)(4326008)(82740400003)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:20:15.6795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdff911-7a47-4fc0-a235-08db1a4f5071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

Reposting the rebased patchset to akpm mm-unstable tree (March 1) 

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


Results:
Summary: Huge autonuma cost reduction seen in mmtest. Kernbench improvement 
is more than 5% and huge system time (80%+) improvement from mmtest autonuma.
(dbench had huge std deviation to post)

kernbench
===========
                      6.2.0-mmunstable-base  6.2.0-mmunstable-patched
Amean     user-256    22002.51 (   0.00%)    22649.95 *  -2.94%*
Amean     syst-256    10162.78 (   0.00%)     8214.13 *  19.17%*
Amean     elsp-256      160.74 (   0.00%)      156.92 *   2.38%*

Duration User       66017.43    67959.84
Duration System     30503.15    24657.03
Duration Elapsed      504.61      493.12

                      6.2.0-mmunstable-base  6.2.0-mmunstable-patched
Ops NUMA alloc hit                1738835089.00  1738780310.00
Ops NUMA alloc local              1738834448.00  1738779711.00
Ops NUMA base-page range updates      477310.00      392566.00
Ops NUMA PTE updates                  477310.00      392566.00
Ops NUMA hint faults                   96817.00       87555.00
Ops NUMA hint local faults %           10150.00        2192.00
Ops NUMA hint local percent               10.48           2.50
Ops NUMA pages migrated                86660.00       85363.00
Ops AutoNUMA cost                        489.07         442.14

autonumabench
===============
                      6.2.0-mmunstable-base  6.2.0-mmunstable-patched
Amean     syst-NUMA01                  399.50 (   0.00%)       52.05 *  86.97%*
Amean     syst-NUMA01_THREADLOCAL        0.21 (   0.00%)        0.22 *  -5.41%*
Amean     syst-NUMA02                    0.80 (   0.00%)        0.78 *   2.68%*
Amean     syst-NUMA02_SMT                0.65 (   0.00%)        0.68 *  -3.95%*
Amean     elsp-NUMA01                  313.26 (   0.00%)      313.11 *   0.05%*
Amean     elsp-NUMA01_THREADLOCAL        1.06 (   0.00%)        1.08 *  -1.76%*
Amean     elsp-NUMA02                    3.19 (   0.00%)        3.24 *  -1.52%*
Amean     elsp-NUMA02_SMT                3.72 (   0.00%)        3.61 *   2.92%*

Duration User      396433.47   324835.96
Duration System      2808.70      376.66
Duration Elapsed     2258.61     2258.12

                      6.2.0-mmunstable-base  6.2.0-mmunstable-patched
Ops NUMA alloc hit                  59921806.00    49623489.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                59920880.00    49622594.00
Ops NUMA base-page range updates   152259275.00       50075.00
Ops NUMA PTE updates               152259275.00       50075.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults               154660352.00       39014.00
Ops NUMA hint local faults %       138550501.00       23139.00
Ops NUMA hint local percent               89.58          59.31
Ops NUMA pages migrated              8179067.00       14147.00
Ops AutoNUMA cost                     774522.98         195.69

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

