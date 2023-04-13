Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F76E137A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDMR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:29:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218BA8A7A;
        Thu, 13 Apr 2023 10:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjZxOVDHW441/hR0NTOiL4r5gPp2+ltJtVflgEDssOkI2ciUl0X0TooY6zrsw7jf1yXdc1ikYr/HI51s7IheW1xs+LTzrDm8SM0lHWswCNWPKrfGdRp/HPJ9/p2QmNCFy3jCyDTg3QyCy3K9dcpfV9K7zRNTdv8B5bQ1BiGlCCVzHP2EmuaTQXNCSCULBFmvHlpe+VfhAa1lXsJ6ZB4yyVTPseAoCFG4RzMvdqKsE0AIZegeAserKBki38TdkmSfBh76UKvCkC77hGZDi0kf2goeB1PtPVfqcAUZSdHcVD9LMqtDB9QsK13mEatpNWuHLf0ucyAyARpSj6tBl1n70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4nhJEVhTwdPuTHkgabLg98XiCAyDoO1eU/L2MHXdQ8=;
 b=IHiRHsAWhdRSlf/wuhpbiETIVCrdcobuysWqaLozAp3+T4IeTFB+rl3o8sVyhArFTjgdCyIN+OiRD+smwhao48mcAYNJQbowM+AJDqopg2WFr2f2r76c6u5klC2lbIhu3TOXR6zdL8MRaI4lEQVRK++H8z4cu8lWVbGdSOGItYBXhutl3bgXxxrVlRnY/x4L3JeTJcIQAmjRpDZ5vwHYK+82yG58GE2XHyh9GA+h1EcI/OMIwr9SHncEdXYAjut1vHDWdnLQdi4CFu7RZQ6YbHfRg+WTrXglmzoHMtJIGZcfiiFPU2067I0c8h8zzK6kV54FR1vqOjE9mUf5COAH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4nhJEVhTwdPuTHkgabLg98XiCAyDoO1eU/L2MHXdQ8=;
 b=hNO/PCbFvzbgHuITl/dGZmSdm9swIstuHub+CbXq9tsExFr1b0qOv+kOH/YHhM3Lrb581DyGN43j6qqaegy2lLSEztVswDRokImCPhjjQidtPd1XvhC3nFX7nKlLPiublnN3vwgNg1BWT6KGrJBkZTIIfJVG5OgqLyiC9ZTB2mA=
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:29:36 +0000
Received: from DS1PEPF0000E63A.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::a3) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 17:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63A.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Thu, 13 Apr 2023 17:29:36 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 12:29:31 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>, <oleksandr@natalenko.name>,
        <bagasdotme@gmail.com>
Subject: [PATCH v2 0/2] arch/x86: Set L2 Cache ID on AMD and Hygon processors
Date:   Thu, 13 Apr 2023 22:59:16 +0530
Message-ID: <20230413172918.1500-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63A:EE_|CH2PR12MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: c210a5a0-b2ba-48dc-05b2-08db3c44a789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO1lcTUNk6MKGVPhAD4D0nJ9Zx83m+FNmn2MjQpVPOqjKbYcH+pdW9CFl+qtsY7/PLHUHZBkQTXyG/VD/VttUOU4YcgooNKxnkH6oyfqE9I25mbO8KQf3YFBLGqTUzKUkvq0HniOgWYN72WqU9AFBodzUfxxk7fMDL4yi2YPlR9LF2MZb5J2QNZCygg0XuJ0Dl55tiEhsCP6D645xyOkHt/jBjKsNCpeC8xlIkFgjqFb7RgturZpW42BJx67+3jTwSF5hcyutbzVYqiXTFVBpOz3qxq1c6Lw+8DyAlF7IoNZh9/hTUAKcExnofSuDFNzLCvW0cc878/ydHRrOwc/WcwyuHbD0Urgh6D6gF0qlkW32Q2rHnVMzmJvFx2kZ9S5K9RxHkRXL+NK30bn3zpiNj1SKQxLkBJtrFyR/bvrSnDJ9AiqzwS575hC+XjWtNMzVxt7eCl7ua3j8o1s0qnah4KLzU6tX5JythCGYFdhjs7WeuE+nvf2bPrk8ZduDC+MChbvWqFsNyqoylybN3RcOGvt90dCyIRPtSDawM+zAByrICk7dfKJ9d6+DL9DN+/44+8IfgWCtrTj26HD3pj3e1aZex6E4DFanZspkYa+jUIH7Ejhbkd2wwif6DnTZqzcVRvOJr/inChPjNkbAYYstmtseOCMECaoxSJDh/Tnul/rm7ITets14BYzdaQJHrXvLHVchxPDUVyTqeVa8vPbvEqs9I7aUmnXy1xEvk/Q6KU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(40460700003)(6916009)(70206006)(70586007)(4326008)(36756003)(2906002)(7416002)(86362001)(81166007)(82740400003)(356005)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(316002)(478600001)(40480700001)(54906003)(1076003)(26005)(336012)(426003)(36860700001)(2616005)(186003)(16526019)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:29:36.8493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c210a5a0-b2ba-48dc-05b2-08db3c44a789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 66558b730f253 ("sched: Add cluster scheduler level for x86")
defined cluster on x86 as the set of threads sharing the same L2 cache.
cluster_id on x86, maps to the l2c_id which currently only Intel
processors set.

This series sets the l2c_id on AMD and Hygon processors with
X86_FEATURE_TOPOEXT, using the extended APIC ID and the
"Cache Properties (L2)" CPUID (0x8000001D EAX). On AMD and Hygon
processors without X86_FEATURE_TOPOEXT, current behavior will continue.

Following are the changes in value reported by
"/sys/devices/system/cpu/cpuX/topology/cluster_id" on a 2P Milan system
(2 x 64C/128T) where L2 is per-core and SMT sibling of CPU (X) is
CPU ((X + 128) % 256).

- tip:x86/core

  $ for i in {0..255}; do\
      echo -n "CPU$i cluster_id: ";\
      cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
    done;

    CPU0 cluster_id: 65535
    CPU1 cluster_id: 65535
    CPU2 cluster_id: 65535
    CPU3 cluster_id: 65535
    CPU4 cluster_id: 65535
    ...
    CPU254 cluster_id: 65535
    CPU255 cluster_id: 65535

- tip:x86/core + this series

  $ for i in {0..255}; do\
      echo -n "CPU$i cluster_id: ";\
      cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
    done;

    CPU0 cluster_id: 0
    CPU1 cluster_id: 1
    CPU2 cluster_id: 2
    CPU3 cluster_id: 3
    CPU4 cluster_id: 4
    CPU5 cluster_id: 5
    CPU6 cluster_id: 6
    CPU7 cluster_id: 7
    CPU8 cluster_id: 8
    ...
    CPU126 cluster_id: 126
    CPU127 cluster_id: 127
    CPU128 cluster_id: 0
    CPU129 cluster_id: 1
    CPU130 cluster_id: 2
    CPU131 cluster_id: 3
    CPU132 cluster_id: 4
    CPU133 cluster_id: 5
    CPU134 cluster_id: 6
    CPU135 cluster_id: 7
    CPU136 cluster_id: 8
    ...
    CPU254 cluster_id: 126
    CPU255 cluster_id: 127

Note: Hygon maintainer Pu Wen <puwen@hygon.cn> has confirmed that the
same strategy of setting l2c_id works for Hygon as well without
requiring any change to the function
(https://lore.kernel.org/lkml/20230411122348.GAZDVRVNvbbS8F5NUB@fat_crate.local/)
Call to the same function has been added in the Hygon topology init path
too. Pu Wen, can you please test this version too and let me know if the
behavior is still as expected.

The series also adds documentation for clusters on x86 platforms and
applies cleanly on top of tip:x86/core at commit ce3ba2af9695
("x86: Suppress KMSAN reports in arch_within_stack_frames()")

---
o v1->v2
  - Improved documentation of cluster based on Peter's suggestion.
  - Renamed cacheinfo_amd_init_l2c_id() to
    cacheinfo_topoext_init_l2c_id() and added the call to same in
    Hygon's topology init path.
  - Collected tags for Patch 1.
---
K Prateek Nayak (2):
  arch/x86: Set L2 Cache ID on AMD and Hygon processors
  x86/Documentation: Add documentation about cluster

 Documentation/x86/topology.rst   | 27 ++++++++++++++++++++++++
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/amd.c        |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 36 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hygon.c      |  1 +
 5 files changed, 66 insertions(+)

-- 
2.34.1

