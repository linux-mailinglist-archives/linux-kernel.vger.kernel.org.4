Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F31768E91B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBHHgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjBHHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:36:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B3C3526C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFsHU2nIbnA1YOEyHuVOm0BP6NvWju3MnzR7wYw0cElde7Ctk2WX4c6+KAj39MzFx2+gzU5B85mu51ZENZVyQA/dr+0mXqoduuK7Otu4EdE8liWNucTOhnZVUbSYk0iQu/Ivixa/vhDtFsi/6I3olZoPrBUwwHDeTG6Jh/YekhRrGV0joUltX55e04Lv1v4ekeOF4xlyE1QIdwkXNi5udmL6b4xQ3D1jgxvMQI7GDcwDhAvowrpE+6gBHfc2o9RgwdbBcc98qY+vVN/b1lH9E5Uz5t80yrHuPSf9Pk2qQuODiPKX0rGg6rnhb/foWnVIVwHi7DsN9nnYZ44HzfNp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WScjuiD+NlhfwdB7IMKNJgvHjVhl8rbyZaVnip7/3iE=;
 b=e9+g+pWDgzfgh75rDuhsYHkoymkyjeZWZRzw5YY2O2EiGq+0bfoPiC7A+nxWQCAD42nBXJJ/RiX2mlmXk6wfyv9b+iRBEztgBjw3+OCf3YfglAv5s+LCqBvhalrDCdPLvO+UmioQmKG8gNu7Owl9OD145UcbJPJLoGeEmIsve18Tc9ZXJWAONgb8koXBGDuD1tzBR50UmyVDL8zzoEC67qfFVJWUjNMYu0YgSejEx0KbAvEf+Cbi6aD6vagYxw5wW+Do430j2ZM4SpR4t7TXcwMma9NcjWnq9FaKxo5YdotH1LfntO2Li+5Vzr7G3w5VMtwg05FZqUERsCipFTpayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WScjuiD+NlhfwdB7IMKNJgvHjVhl8rbyZaVnip7/3iE=;
 b=29AEoNQZjGwMQZI5O4PYx+npWYHeSUlEGRPbgiWBleqIjzxGJF7nvMj+nhQ9YSz5CC6PygmmzxnlOEYcBTHOTkMWNgvByN//AwJDEZwRIpYwq2ji40dGdBBWgGY/FqqBUngxfEc/HYibgtSVjUXTB4s3Ab2K6uD4GoleoqD6SG0=
Received: from BN0PR04CA0206.namprd04.prod.outlook.com (2603:10b6:408:e9::31)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:36:28 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::6b) by BN0PR04CA0206.outlook.office365.com
 (2603:10b6:408:e9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 07:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:36:28 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:36:23 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Date:   Wed, 8 Feb 2023 13:05:28 +0530
Message-ID: <20230208073533.715-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: bb20eab4-35b7-4ff7-7118-08db09a7307e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2drfrGFXSNK+sJL/WKsavuDmlgBklMTc6Tjd6RGY3uyHxvm7NHJ5CiRjUNfux6flS/MFZC2gvE708v30PVp9YNpBtTOR9QHW6EMb51+9wOczIiUwnVGiXcVPWDw6Qf2lA13FLc9AjHQn9SOwwfsyNWEzLCfwacUfKcDqwhSUBIU7xRoimCNk9CODHacbvSghX7JGpz+joQlYbm68Rvpx50sKmUpFBxOJiVCKhW/HK0kpRD3i8SFHwZvuBbkXvOhtKML4V/n7hU2u44XauZu+uH+sQocoyO0X3tMlNfYkaDRunp4DRa6IfWu47ccahFRMX6bLTf3kI2C90qHrcM/VqWLofq1tKPOCCEC3uEnqFeLMAKafix296sce0p9vd9oGFuQwUborNBW2PJU+3LAukwKTcLbAM0bf20+34TTKfeN0l0lgwVmGWAU4IPUnkoY2grB24lJw2k2bCt94016J5nd7In1BtkSxBwRMGO4PDG3mVgYGNphacOCKTZyjPOFMXeNj8bwTI/qrNyzz+1nBVavLslG4t+3l2m8X9u7z1+QunWV59v/TxQRUoYhGSDRo6KS99ZxwoSOxmjwAi87TiIkzdC1tZhjG6QOPVipSvqntNCrmQ+Gry780D7P/uMkvialMaMkAmw2UFSUqhHVuiFvIBsVH9YvGJxpmL4eSZSsSXS3PoWagIrb/19vIoqvRdv8zuMQ7/zBziBYvcuP5Cu0yzBjCubfaeVAeo4qSYjD2xKCBDwYnh8rtSCFrgg0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(83380400001)(36860700001)(86362001)(2906002)(356005)(36756003)(41300700001)(7416002)(30864003)(5660300002)(8936002)(82310400005)(40480700001)(40460700003)(186003)(26005)(16526019)(47076005)(4326008)(426003)(2616005)(1076003)(336012)(316002)(70586007)(110136005)(54906003)(8676002)(70206006)(478600001)(7696005)(66899018)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:36:28.0369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb20eab4-35b7-4ff7-7118-08db09a7307e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some hardware platforms can provide information about memory accesses
that can be used to do optimal page and task placement on NUMA
systems. AMD processors have a hardware facility called Instruction-
Based Sampling (IBS) that can be used to gather specific metrics
related to instruction fetch and execution activity. This facility
can be used to perform memory access profiling based on statistical
sampling.

This RFC is a proof-of-concept implementation where the access
information obtained from the hardware is used to drive NUMA balancing.
With this it is no longer necessary to scan the address space and
introduce NUMA hint faults to build task-to-page association. Hence
the approach taken here is to replace the address space scanning plus
hint faults with the access information provided by the hardware.
The access samples obtained from hardware are fed to NUMA balancing
as fault-equivalents. The rest of the NUMA balancing logic that
collects/aggregates the shared/private/local/remote faults and does
pages/task migrations based on the faults is retained except that
accesses replace faults.

This early implementation is an attempt to get a working solution
only and as such a lot of TODOs exist:

- Perf uses IBS and we are using the same IBS for access profiling here.
  There needs to be a proper way to make the use mutually exclusive.
- Is tying this up with NUMA balancing a reasonable approach or
  should we look at a completely new approach?
- When accesses replace faults in NUMA balancing, a few things have
  to be tuned differently. All such decision points need to be
  identified and appropriate tuning needs to be done.
- Hardware provided access information could be very useful for driving
  hot page promotion in tiered memory systems. Need to check if this
  requires different tuning/heuristics apart from what NUMA balancing
  already does.
- Some of the values used to program the IBS counters like the sampling
  period etc may not be the optimal or ideal values. The sample period
  adjustment follows the same logic as scan period modification which
  may not be ideal. More experimentation is required to fine-tune all
  these aspects.
- Currently I am acting (i,e., attempt to migrate a page) on each sampled
  access. Need to check if it makes sense to delay it and do batched page
  migration.

This RFC is mainly about showing how hardware provided access
information could be used for NUMA balancing but I have run a
few basic benchmarks from mmtests to check if this is any severe
regression/overhead to any of those. Some benchmarks show some
improvement, some show no significant change and a few regress.
I am hopeful that with more appropriate tuning there is scope for
futher improvement here especially for workloads for which NUMA
matters.

FWIW, here are the numbers in brief:
(1st column is default kernel, 2nd column is with this patchset)

kernbench
=========
                                6.2.0-rc5              6.2.0-rc5-ibs
Amean     user-512    19385.27 (   0.00%)    18140.69 *   6.42%*
Amean     syst-512    21620.40 (   0.00%)    19984.87 *   7.56%*
Amean     elsp-512       95.91 (   0.00%)       88.60 *   7.62%*

Duration User       19385.45    18140.89
Duration System     21620.90    19985.37
Duration Elapsed       96.52       89.20

Ops NUMA alloc hit                 552153976.00   499596610.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local               552152782.00   499595620.00
Ops NUMA base-page range updates      758004.00           0.00
Ops NUMA PTE updates                  758004.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                  215654.00     1797848.00
Ops NUMA hint local faults %            2054.00     1775103.00
Ops NUMA hint local percent                0.95          98.73
Ops NUMA pages migrated               213600.00       22745.00
Ops AutoNUMA cost                       1087.63        8989.67

autonumabench
=============
Amean     syst-NUMA01                90516.91 (   0.00%)    65272.04 *  27.89%*
Amean     syst-NUMA01_THREADLOCAL        0.26 (   0.00%)        0.27 *  -3.80%*
Amean     syst-NUMA02                    1.10 (   0.00%)        1.02 *   7.24%*
Amean     syst-NUMA02_SMT                0.74 (   0.00%)        0.90 * -21.77%*
Amean     elsp-NUMA01                  747.73 (   0.00%)      625.29 *  16.37%*
Amean     elsp-NUMA01_THREADLOCAL        1.07 (   0.00%)        1.07 *  -0.13%*
Amean     elsp-NUMA02                    1.75 (   0.00%)        1.72 *   1.96%*
Amean     elsp-NUMA02_SMT                3.03 (   0.00%)        3.04 *  -0.47%*

Duration User     1312937.34  1148196.94
Duration System    633634.59   456921.29
Duration Elapsed     5289.47     4427.82

Ops NUMA alloc hit                1115625106.00   704004226.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local               599879745.00   459968338.00
Ops NUMA base-page range updates    74310268.00           0.00
Ops NUMA PTE updates                74310268.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults               110504178.00    27624054.00
Ops NUMA hint local faults %        54257985.00    17310888.00
Ops NUMA hint local percent               49.10          62.67
Ops NUMA pages migrated             11399016.00     7983717.00
Ops AutoNUMA cost                     553257.64      138271.96

tbench4 Latency
===============
Amean     latency-1           0.08 (   0.00%)        0.08 *   1.43%*
Amean     latency-2           0.10 (   0.00%)        0.11 *  -2.75%*
Amean     latency-4           0.14 (   0.00%)        0.13 *   4.31%*
Amean     latency-8           0.14 (   0.00%)        0.14 *  -0.94%*
Amean     latency-16          0.20 (   0.00%)        0.19 *   8.01%*
Amean     latency-32          0.24 (   0.00%)        0.20 *  12.92%*
Amean     latency-64          0.34 (   0.00%)        0.28 *  18.30%*
Amean     latency-128         1.71 (   0.00%)        1.44 *  16.04%*
Amean     latency-256         0.52 (   0.00%)        0.69 * -32.26%*
Amean     latency-512         3.27 (   0.00%)        5.32 * -62.62%*
Amean     latency-1024        0.00 (   0.00%)        0.00 *   0.00%*
Amean     latency-2048        0.00 (   0.00%)        0.00 *   0.00%*

tbench4 Throughput
==================
Hmean     1         504.57 (   0.00%)      496.80 *  -1.54%*
Hmean     2        1006.46 (   0.00%)      990.04 *  -1.63%*
Hmean     4        1855.11 (   0.00%)     1933.76 *   4.24%*
Hmean     8        3711.49 (   0.00%)     3582.32 *  -3.48%*
Hmean     16       6707.58 (   0.00%)     6674.46 *  -0.49%*
Hmean     32      13146.81 (   0.00%)    12649.49 *  -3.78%*
Hmean     64      20922.72 (   0.00%)    22605.55 *   8.04%*
Hmean     128     33637.07 (   0.00%)    37870.35 *  12.59%*
Hmean     256     54083.12 (   0.00%)    50257.25 *  -7.07%*
Hmean     512     72455.66 (   0.00%)    53141.88 * -26.66%*
Hmean     1024   124413.95 (   0.00%)   117398.40 *  -5.64%*
Hmean     2048   124481.61 (   0.00%)   124892.12 *   0.33%*

Ops NUMA alloc hit                2092196681.00  2007852353.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local              2092193601.00  2007849231.00
Ops NUMA base-page range updates      298999.00           0.00
Ops NUMA PTE updates                  298999.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                  287539.00     4499166.00
Ops NUMA hint local faults %           98931.00     4349685.00
Ops NUMA hint local percent               34.41          96.68
Ops NUMA pages migrated               169086.00      149476.00
Ops AutoNUMA cost                       1443.00       22498.67

Duration User       23999.54    24476.30
Duration System    160480.07   164366.91
Duration Elapsed     2685.19     2685.69

netperf-udp
===========
Hmean     send-64         226.57 (   0.00%)      225.41 *  -0.51%*
Hmean     send-128        450.89 (   0.00%)      448.90 *  -0.44%*
Hmean     send-256        899.63 (   0.00%)      898.02 *  -0.18%*
Hmean     send-1024      3510.63 (   0.00%)     3526.24 *   0.44%*
Hmean     send-2048      6493.15 (   0.00%)     6493.27 *   0.00%*
Hmean     send-3312      9778.22 (   0.00%)     9801.03 *   0.23%*
Hmean     send-4096     11523.43 (   0.00%)    11490.57 *  -0.29%*
Hmean     send-8192     18666.11 (   0.00%)    18686.99 *   0.11%*
Hmean     send-16384    28112.56 (   0.00%)    28223.81 *   0.40%*
Hmean     recv-64         226.57 (   0.00%)      225.41 *  -0.51%*
Hmean     recv-128        450.88 (   0.00%)      448.90 *  -0.44%*
Hmean     recv-256        899.63 (   0.00%)      898.01 *  -0.18%*
Hmean     recv-1024      3510.61 (   0.00%)     3526.21 *   0.44%*
Hmean     recv-2048      6493.07 (   0.00%)     6493.15 *   0.00%*
Hmean     recv-3312      9777.95 (   0.00%)     9800.85 *   0.23%*
Hmean     recv-4096     11522.87 (   0.00%)    11490.47 *  -0.28%*
Hmean     recv-8192     18665.83 (   0.00%)    18686.56 *   0.11%*
Hmean     recv-16384    28112.13 (   0.00%)    28223.73 *   0.40%*

Duration User          48.52       48.74
Duration System       931.24      925.83
Duration Elapsed     1934.05     1934.79

Ops NUMA alloc hit                  60042365.00    60144256.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                60042305.00    60144228.00
Ops NUMA base-page range updates        6630.00           0.00
Ops NUMA PTE updates                    6630.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                    5709.00       26249.00
Ops NUMA hint local faults %            3030.00       25130.00
Ops NUMA hint local percent               53.07          95.74
Ops NUMA pages migrated                 2500.00        1119.00
Ops AutoNUMA cost                         28.64         131.27

netperf-udp-rr
==============
Hmean     1   132319.16 (   0.00%)   130621.99 *  -1.28%*

Duration User           9.92        9.97
Duration System       118.02      119.26
Duration Elapsed      432.12      432.91

Ops NUMA alloc hit                    289650.00      289222.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                  289642.00      289222.00
Ops NUMA base-page range updates           1.00           0.00
Ops NUMA PTE updates                       1.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                       1.00          51.00
Ops NUMA hint local faults %               0.00          45.00
Ops NUMA hint local percent                0.00          88.24
Ops NUMA pages migrated                    1.00           6.00
Ops AutoNUMA cost                          0.01           0.26

netperf-tcp-rr
==============
Hmean     1   118141.46 (   0.00%)   115515.41 *  -2.22%*

Duration User           9.59        9.52
Duration System       120.32      121.66
Duration Elapsed      432.20      432.49

Ops NUMA alloc hit                    291257.00      290927.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                  291233.00      290923.00
Ops NUMA base-page range updates           2.00           0.00
Ops NUMA PTE updates                       2.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                       2.00          46.00
Ops NUMA hint local faults %               0.00          42.00
Ops NUMA hint local percent                0.00          91.30
Ops NUMA pages migrated                    2.00           4.00
Ops AutoNUMA cost                          0.01           0.23

dbench
======
dbench4 Latency

Amean     latency-1          2.13 (   0.00%)       10.92 *-411.44%*
Amean     latency-2         12.03 (   0.00%)        8.17 *  32.07%*
Amean     latency-4         21.12 (   0.00%)        9.60 *  54.55%*
Amean     latency-8         41.20 (   0.00%)       33.59 *  18.45%*
Amean     latency-16        76.85 (   0.00%)       75.84 *   1.31%*
Amean     latency-32        91.68 (   0.00%)       90.26 *   1.55%*
Amean     latency-64       124.61 (   0.00%)      113.31 *   9.07%*
Amean     latency-128      140.14 (   0.00%)      126.29 *   9.89%*
Amean     latency-256      155.63 (   0.00%)      142.11 *   8.69%*
Amean     latency-512      258.60 (   0.00%)      243.13 *   5.98%*

dbench4 Throughput (misleading but traditional)

Hmean     1        987.47 (   0.00%)      938.07 *  -5.00%*
Hmean     2       1750.10 (   0.00%)     1697.08 *  -3.03%*
Hmean     4       2990.33 (   0.00%)     3023.23 *   1.10%*
Hmean     8       3557.38 (   0.00%)     3863.32 *   8.60%*
Hmean     16      2705.90 (   0.00%)     2660.48 *  -1.68%*
Hmean     32      2954.08 (   0.00%)     3101.59 *   4.99%*
Hmean     64      3061.68 (   0.00%)     3206.15 *   4.72%*
Hmean     128     2867.74 (   0.00%)     3080.21 *   7.41%*
Hmean     256     2585.58 (   0.00%)     2875.44 *  11.21%*
Hmean     512     1777.80 (   0.00%)     1777.79 *  -0.00%*

Duration User        2359.02     2246.44
Duration System     18927.83    16856.91
Duration Elapsed     1901.54     1901.44

Ops NUMA alloc hit                 240556255.00   255283721.00
Ops NUMA alloc miss                   408851.00       62903.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local               240547816.00   255264974.00
Ops NUMA base-page range updates      204316.00           0.00
Ops NUMA PTE updates                  204316.00           0.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                  201101.00      287642.00
Ops NUMA hint local faults %          104199.00      153547.00
Ops NUMA hint local percent               51.81          53.38
Ops NUMA pages migrated                96158.00      134083.00
Ops AutoNUMA cost                       1008.76        1440.76

Bharata B Rao (5):
  x86/ibs: In-kernel IBS driver for page access profiling
  x86/ibs: Drive NUMA balancing via IBS access data
  x86/ibs: Enable per-process IBS from sched switch path
  x86/ibs: Adjust access faults sampling period
  x86/ibs: Delay the collection of HW-provided access info

 arch/x86/events/amd/ibs.c        |   6 +
 arch/x86/include/asm/msr-index.h |  12 ++
 arch/x86/mm/Makefile             |   1 +
 arch/x86/mm/ibs.c                | 250 +++++++++++++++++++++++++++++++
 include/linux/migrate.h          |   1 +
 include/linux/mm.h               |   2 +
 include/linux/mm_types.h         |   3 +
 include/linux/sched.h            |   4 +
 include/linux/vm_event_item.h    |  12 ++
 kernel/sched/core.c              |   1 +
 kernel/sched/debug.c             |  10 ++
 kernel/sched/fair.c              | 142 ++++++++++++++++--
 kernel/sched/sched.h             |   9 ++
 mm/memory.c                      |  92 ++++++++++++
 mm/vmstat.c                      |  12 ++
 15 files changed, 544 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/mm/ibs.c

-- 
2.25.1

