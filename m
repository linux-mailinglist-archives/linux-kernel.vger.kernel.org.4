Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C266B548
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjAPBgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAPBgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:36:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B093AAE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmwi8TdyZScqIT4cW6XgxHKcLRuHouMxzLeW6IKozLNwoTApNUrFVpxSraInYlTOU+QSj4Q01dFFJ0ae/sk2/qktXorr1HZFBY1fArhmGOzf0eitkLcvEvPpKENrTz0asAjECvQ2nt3Due+SfFyvNvbu5Ouwgfnzp39/g+sqAw5pAqOSAjNocW4ihXs1oovEezUvwxIw8ZXYHXohSpt5RzE1M8UkF25if1bzBTbRtkaX8/B0yHXayUKZi5F7RcGRZx7XZbE08/1fBHyF6hwAXwlQh2gQywh0yxkHsL11FtoKWPSVtUUMIoWMmMf8RBGgMymESIZ1XyC0WiUzJSIzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0PxIGChyU6FXH1ZIImGlO6Bwsh4qwdClGT9qFmQFcs=;
 b=iiU0dVOHMa6CXfpZ9zANCBeg3ogk04IsJIW54ZhIWVI4SO/2z5RWD+CjK6JSvUfdzbbx8NPGXLBJE044ye4UgjL3F2aDjEuD3IIhN9bDC2L4p9clqzz1ssDW559Fdar7P9pmdlgPeVZOTT8SUhrs4ik29y0/EU+3tesTdTuXVkg4VjeqSZR1Cp7DHldNPWpXLMf88rPM0wxYRuxMUFCacGNq5VS4Gi46pknf/L5jN+WYmcg2+fVceWzo4DfAw43WzFVLL774etii99886HQKqc5XC9rQvSfdXjCm44B8ZPmwkgtujegHRYFS0TbzPMJOnVrGlObAM72copAFFAs25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0PxIGChyU6FXH1ZIImGlO6Bwsh4qwdClGT9qFmQFcs=;
 b=wJkJ6YvEp79NrTgLlynDFn9N9HJVc/0xoIno3z9oQXLMc/WTZEuAluQPlSbkWqB+7U0WbIKK8+9JaE7fWbm6MXeBwwUYJrwd5O/QYYVM+hqISgZDoUdFBtyb0cQZNEYIIW8k6N3GL/cB6AS4YL29FLPwKzgWmxfrX+bRlkk5SP0=
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 01:36:29 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::1f) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 01:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 01:36:29 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 15 Jan
 2023 19:36:20 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     = <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        --cc=Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
CC:     Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V1 0/1] sched/numa: Enhance vma scanning
Date:   Mon, 16 Jan 2023 07:05:33 +0530
Message-ID: <cover.1673610485.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|CH0PR12MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: d3886441-2d5d-4cfe-76a5-08daf7621737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzo3qx9iRz6mSoRu8Txjqu/HK6MvxR8gBKejv2/X7dhKVB/S/LSJfnZWNIjuwAmL6wpEGdndPMGGNtzM68q0wXE//2r5kxJkroWo4uKZSGs2iru6DZl4utCstm6GCfCGAhw1j3FWWao0T1MmjiNM3WpY+SRNqIM3Icg9cGAGYf3ApL3OiU/Bc94w3ipe5WpqBgxYbLfAxAto8PHKJWOc3HuW9AJfA6VI16aNaMAcYIQHxK2lB/s9GsMpU8C+a4rULkF83wMzLeOHwTrsTB716KMI4EV6wtHX40ITLGcUfebMravsnVopUrmXt+Bb1L1XdQMOv80u1QIW6ZuBSy71ua7y4XTTlKAXYrQhuTU5DzLVtkuaDgJtp79KhhtSTE5w9Dw7g5wA6QaLl0G1WQ/Isz4DYsvK9D8odqlDc2BqVURHyIDQkMCgI00epzg/KmDk0LGXDGwS8U9bOtu2GIQdY78BhvddujUmpwUSFfVM0trE7WfovM70dVJ8tYn5AZdZfh52iq1ipU2aFaZ4UX6V8QSBaxoogDv8Z96XU1FHDBGDSmz1a3JBCuiY8aA48qQ6zDdGgny/CsV84jTZsn0gauHjZtQdZx93m1mdfaP7rZ4i+3PGWh4HuS/QRjfJyIkOBMLGV2flFKRzl3OlfKDiZu1VmHLCaLfINLX1zem5wnZv+L+VKDA32eBUR8JjL2ETnmLLs+OZ2UFVzBRIMXKpAcWbpkhgGJmzTlR8M4BgGkEuMNbstewE7jfPYmA5Ycwzfc/FN0oUW8itV3Lcq+6bU+Gcd1Kb8LNt7zOmb1toSWSryBUnIF6G6eq4I4xvhpe9+i2eL6M0JyTh/uHYcolhZfxbMacyUxMqWVhmk+iiqp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(30864003)(2906002)(7416002)(8936002)(5660300002)(82740400003)(83380400001)(336012)(70586007)(70206006)(8676002)(4326008)(36756003)(316002)(6636002)(110136005)(41300700001)(7696005)(40460700003)(966005)(2616005)(26005)(82310400005)(186003)(16526019)(47076005)(921005)(81166007)(356005)(6666004)(36860700001)(426003)(478600001)(40480700001)(83996005)(36900700001)(2101003)(579004)(383094003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 01:36:29.2994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3886441-2d5d-4cfe-76a5-08daf7621737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The patchset proposes one of the enhancements to numa vma scanning
suggested by Mel.

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

Approach in patchset:

1) Tracks atmost 4 threads which recently accessed vma, scan only if that
thread accessed the vma. (note: used only unsigned int. Experiments showed
tracking 8 unique PIDs had more overhead)

2) First 2 times unconditionaly allow threads to scan vmas to preserve
original intention of scanning.

3) If there are more than 4 threads (i.e. more than PIDs we could remember)
by default allow scanning because we might have potentially missed recording
whether current thread had any interest in the vma.
(less accurate and debatable heuristics)

With this patchset we see reduction in considerable amount of scanning
overhead (AutoNuma cost) with some enchmark improving the performance,
and others with almost no regression.

Things to ponder over (and Future TODO):
==========================================
- Do we have to consider clearing PID if it is not accessed "recently"
- Current scan period is not changed in the patchset, so we do see frequent
 tries to scan. Relaxing scan period dynamically could improve results
further.

Results Summary:
================
The result is obtained by running mmtests with below configs
config-workload-kernbench-max
config-io-dbench4-async
config-numa-autonumabench
config-hpc-nas-mpi-full

There is a significant reduction in AutoNuma cost.

SUT:
2 socket AMD Milan System
Thread(s) per core:  2
Core(s) per socket:  64
Socket(s):           2

256GB memory per socket amounting to 512GB in total
NPS1 NUMA configuration where each socket is a NUMA node

$ numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
node 0 size: 257538 MB
node 0 free: 255739 MB
node 1 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
node 1 size: 255978 MB
node 1 free: 249680 MB
node distances:
node   0   1
  0:  10  32
  1:  32  10

Detailed Result:
(Note:
1. All rows with 0.00 and 100% from both the side removed
2. Some of the duplicate run/path info is trimmed.
3. SIS results omitted.

kernbench
=============
                          6_1_base_config       6_1_final_config
                   workload-kernbench-max workload-kernbench-max
Min       user-256    22120.65 (   0.00%)    22477.15 (  -1.61%)
Min       syst-256     9975.63 (   0.00%)     8880.00 (  10.98%)
Min       elsp-256      161.24 (   0.00%)      157.45 (   2.35%)
Amean     user-256    22179.56 (   0.00%)    22558.57 *  -1.71%*
Amean     syst-256    10034.72 (   0.00%)     8913.83 *  11.17%*
Amean     elsp-256      161.52 (   0.00%)      157.69 *   2.37%*
Stddev    user-256      101.82 (   0.00%)       82.51 (  18.97%)
Stddev    syst-256       87.56 (   0.00%)       54.31 (  37.97%)
Stddev    elsp-256        0.35 (   0.00%)        0.27 (  24.12%)
CoeffVar  user-256        0.46 (   0.00%)        0.37 (  20.33%)
CoeffVar  syst-256        0.87 (   0.00%)        0.61 (  30.17%)
CoeffVar  elsp-256        0.22 (   0.00%)        0.17 (  22.28%)
Max       user-256    22297.13 (   0.00%)    22642.13 (  -1.55%)
Max       syst-256    10135.31 (   0.00%)     8976.48 (  11.43%)
Max       elsp-256      161.92 (   0.00%)      157.98 (   2.43%)
BAmean-50 user-256    22120.65 (   0.00%)    22477.15 (  -1.61%)
BAmean-50 syst-256     9975.63 (   0.00%)     8880.00 (  10.98%)
BAmean-50 elsp-256      161.24 (   0.00%)      157.45 (   2.35%)
BAmean-95 user-256    22120.77 (   0.00%)    22516.79 (  -1.79%)
BAmean-95 syst-256     9984.42 (   0.00%)     8882.51 (  11.04%)
BAmean-95 elsp-256      161.32 (   0.00%)      157.54 (   2.34%)
BAmean-99 user-256    22120.77 (   0.00%)    22516.79 (  -1.79%)
BAmean-99 syst-256     9984.42 (   0.00%)     8882.51 (  11.04%)
BAmean-99 elsp-256      161.32 (   0.00%)      157.54 (   2.34%)

                6_1_base_config6_1_final_config
                workload-kernbench-maxworkload-kernbench-max
Duration User       66548.20    67685.44
Duration System     30118.43    26756.19
Duration Elapsed      506.13      495.18

                                6_1_base_config6_1_final_config
                                workload-kernbench-maxworkload-kernbench-max
Ops Minor Faults                  1883340576.00  1883195171.00
Ops Major Faults                          88.00          42.00
Ops Normal allocs                 1743174614.00  1742916379.00
Ops Sector Reads                      173600.00       11928.00
Ops Sector Writes                   21099684.00    21480472.00
Ops Page migrate success              111429.00       73693.00
Ops Compaction cost                      115.66          76.49
Ops NUMA alloc hit                1738966281.00  1738692743.00
Ops NUMA alloc local              1738966104.00  1738692456.00
Ops NUMA base-page range updates      401910.00      322972.00
Ops NUMA PTE updates                  401910.00      322972.00
Ops NUMA hint faults                  112231.00       76987.00
Ops NUMA hint local faults %             802.00        3294.00
Ops NUMA hint local percent                0.71           4.28
Ops NUMA pages migrated               111429.00       73693.00
Ops AutoNUMA cost                        566.09         388.60

dbench
=========
Runtime options
Run: dbench -D [...]/testdisk/data/6_1_base_config-io-dbench4-async --warmup 0 -t 180 --loadfile [...]/sources/dbench-781852c2b38a-installed/share//client-tiny.txt --show-execute-time 1 2 4 ... 256
dbench4 Loadfile Execution Time

dbench4 Latency
                             6_1_base_config       6_1_final_config
                            io-dbench4-async       io-dbench4-async
Min       latency-1          0.37 (   0.00%)        0.35 (   4.09%)
Min       latency-2          0.38 (   0.00%)        0.40 (  -6.60%)
Min       latency-4          0.51 (   0.00%)        0.49 (   2.97%)
Min       latency-8          0.69 (   0.00%)        0.62 (   9.17%)
Min       latency-16         1.11 (   0.00%)        0.99 (  10.57%)
Min       latency-32         1.96 (   0.00%)        1.98 (  -0.66%)
Min       latency-64         5.73 (   0.00%)       32.03 (-458.86%)
Min       latency-128       17.60 (   0.00%)       17.79 (  -1.09%)
Min       latency-256       24.71 (   0.00%)       24.06 (   2.66%)
Amean     latency-1          2.18 (   0.00%)        0.46 *  78.72%*
Amean     latency-2          4.52 (   0.00%)        0.54 *  88.10%*
Amean     latency-4          9.99 (   0.00%)        0.97 *  90.34%*
Amean     latency-8         13.62 (   0.00%)        1.02 *  92.48%*
Amean     latency-16        14.11 (   0.00%)        4.07 *  71.16%*
Amean     latency-32        21.18 (   0.00%)       45.50 *-114.84%*
Amean     latency-64        61.19 (   0.00%)       58.78 *   3.95%*
Amean     latency-128       56.48 (   0.00%)       54.86 *   2.86%*
Amean     latency-256       81.08 (   0.00%)       80.03 *   1.30%*
Stddev    latency-1          6.85 (   0.00%)        0.17 (  97.56%)
Stddev    latency-2         10.51 (   0.00%)        0.19 (  98.19%)
Stddev    latency-4         14.51 (   0.00%)        1.61 (  88.91%)
Stddev    latency-8         15.71 (   0.00%)        2.04 (  87.00%)
Stddev    latency-16        16.36 (   0.00%)       10.60 (  35.21%)
Stddev    latency-32        19.95 (   0.00%)       25.89 ( -29.78%)
Stddev    latency-64        18.64 (   0.00%)       16.95 (   9.07%)
Stddev    latency-128       17.61 (   0.00%)       19.64 ( -11.52%)
Stddev    latency-256       32.23 (   0.00%)       32.94 (  -2.19%)
CoeffVar  latency-1        313.68 (   0.00%)       35.95 (  88.54%)
CoeffVar  latency-2        232.70 (   0.00%)       35.35 (  84.81%)
CoeffVar  latency-4        145.21 (   0.00%)      166.58 ( -14.72%)
CoeffVar  latency-8        115.34 (   0.00%)      199.35 ( -72.85%)
CoeffVar  latency-16       115.92 (   0.00%)      260.45 (-124.68%)
CoeffVar  latency-32        94.21 (   0.00%)       56.90 (  39.59%)
CoeffVar  latency-64        30.47 (   0.00%)       28.84 (   5.33%)
CoeffVar  latency-128       31.19 (   0.00%)       35.80 ( -14.80%)
CoeffVar  latency-256       39.75 (   0.00%)       41.15 (  -3.53%)
Max       latency-1         34.43 (   0.00%)        2.43 (  92.95%)
Max       latency-2         34.71 (   0.00%)        2.94 (  91.53%)
Max       latency-4         35.80 (   0.00%)       13.44 (  62.47%)
Max       latency-8         36.29 (   0.00%)       23.73 (  34.61%)
Max       latency-16        64.87 (   0.00%)       76.11 ( -17.32%)
Max       latency-32       133.05 (   0.00%)      123.88 (   6.89%)
Max       latency-64       150.48 (   0.00%)      198.68 ( -32.02%)
Max       latency-128      101.89 (   0.00%)      140.66 ( -38.05%)
Max       latency-256      326.53 (   0.00%)      357.54 (  -9.50%)
BAmean-50 latency-1          0.42 (   0.00%)        0.41 (   3.49%)
BAmean-50 latency-2          0.44 (   0.00%)        0.48 (  -9.16%)
BAmean-50 latency-4          0.60 (   0.00%)        0.55 (   8.02%)
BAmean-50 latency-8          0.80 (   0.00%)        0.75 (   6.60%)
BAmean-50 latency-16         1.57 (   0.00%)        1.08 (  31.38%)
BAmean-50 latency-32         3.83 (   0.00%)       25.03 (-553.42%)
BAmean-50 latency-64        47.76 (   0.00%)       47.49 (   0.56%)
BAmean-50 latency-128       42.90 (   0.00%)       40.81 (   4.89%)
BAmean-50 latency-256       62.90 (   0.00%)       64.40 (  -2.39%)
BAmean-95 latency-1          0.67 (   0.00%)        0.44 (  33.70%)
BAmean-95 latency-2          2.93 (   0.00%)        0.52 (  82.40%)
BAmean-95 latency-4          8.67 (   0.00%)        0.65 (  92.46%)
BAmean-95 latency-8         12.45 (   0.00%)        0.79 (  93.62%)
BAmean-95 latency-16        12.42 (   0.00%)        1.93 (  84.44%)
BAmean-95 latency-32        18.63 (   0.00%)       43.09 (-131.27%)
BAmean-95 latency-64        59.09 (   0.00%)       56.46 (   4.44%)
BAmean-95 latency-128       54.56 (   0.00%)       52.33 (   4.08%)
BAmean-95 latency-256       76.21 (   0.00%)       74.98 (   1.61%)
BAmean-99 latency-1          1.82 (   0.00%)        0.45 (  75.36%)
BAmean-99 latency-2          4.18 (   0.00%)        0.52 (  87.49%)
BAmean-99 latency-4          9.70 (   0.00%)        0.84 (  91.36%)
BAmean-99 latency-8         13.37 (   0.00%)        0.81 (  93.92%)
BAmean-99 latency-16        13.54 (   0.00%)        3.36 (  75.21%)
BAmean-99 latency-32        20.20 (   0.00%)       44.75 (-121.58%)
BAmean-99 latency-64        60.48 (   0.00%)       57.76 (   4.49%)
BAmean-99 latency-128       55.97 (   0.00%)       53.94 (   3.63%)
BAmean-99 latency-256       78.60 (   0.00%)       77.39 (   1.54%)

dbench4 Throughput (misleading but traditional)
                     6_1_base_config       6_1_final_config
                    io-dbench4-async       io-dbench4-async
Min       1        813.26 (   0.00%)      808.06 (  -0.64%)
Min       2       1348.40 (   0.00%)     1373.40 (   1.85%)
Min       4       2250.91 (   0.00%)     2349.87 (   4.40%)
Min       8       3419.43 (   0.00%)     3467.44 (   1.40%)
Min       16      5191.34 (   0.00%)     5808.41 (  11.89%)
Min       32      7798.01 (   0.00%)     7461.17 (  -4.32%)
Min       64      6056.72 (   0.00%)     6566.36 (   8.41%)
Min       128     6103.45 (   0.00%)     6455.82 (   5.77%)
Min       256     7409.77 (   0.00%)     7317.59 (  -1.24%)
Hmean     1        820.42 (   0.00%)      829.23 *   1.07%*
Hmean     2       1433.43 (   0.00%)     1429.61 *  -0.27%*
Hmean     4       2281.21 (   0.00%)     2364.06 *   3.63%*
Hmean     8       3493.67 (   0.00%)     3512.71 *   0.54%*
Hmean     16      5354.84 (   0.00%)     6069.95 *  13.35%*
Hmean     32      8060.95 (   0.00%)     8147.90 *   1.08%*
Hmean     64      6579.22 (   0.00%)     7151.69 *   8.70%*
Hmean     128     7340.59 (   0.00%)     7531.74 *   2.60%*
Hmean     256     7685.46 (   0.00%)     7758.75 *   0.95%*
Stddev    1          2.62 (   0.00%)        5.61 (-114.51%)
Stddev    2         28.63 (   0.00%)       12.60 (  55.98%)
Stddev    4          7.58 (   0.00%)       12.24 ( -61.45%)
Stddev    8         36.99 (   0.00%)       76.05 (-105.62%)
Stddev    16       100.33 (   0.00%)      101.59 (  -1.26%)
Stddev    32       216.04 (   0.00%)      599.98 (-177.71%)
Stddev    64      1101.72 (   0.00%)      198.64 (  81.97%)
Stddev    128      233.31 (   0.00%)      191.10 (  18.09%)
Stddev    256      474.44 (   0.00%)      220.54 (  53.52%)
CoeffVar  1          0.32 (   0.00%)        0.68 (-112.23%)
CoeffVar  2          2.00 (   0.00%)        0.88 (  55.84%)
CoeffVar  4          0.33 (   0.00%)        0.52 ( -55.79%)
CoeffVar  8          1.06 (   0.00%)        2.16 (-104.44%)
CoeffVar  16         1.87 (   0.00%)        1.67 (  10.67%)
CoeffVar  32         2.68 (   0.00%)        7.33 (-173.51%)
CoeffVar  64        16.42 (   0.00%)        2.78 (  83.10%)
CoeffVar  128        3.17 (   0.00%)        2.54 (  20.13%)
CoeffVar  256        6.15 (   0.00%)        2.84 (  53.84%)
Max       1        824.86 (   0.00%)      835.60 (   1.30%)
Max       2       1478.26 (   0.00%)     1445.52 (  -2.21%)
Max       4       2300.81 (   0.00%)     2437.53 (   5.94%)
Max       8       3536.60 (   0.00%)     3924.47 (  10.97%)
Max       16      5726.97 (   0.00%)     6188.43 (   8.06%)
Max       32      8589.30 (   0.00%)     9179.96 (   6.88%)
Max       64     10975.99 (   0.00%)     7353.65 ( -33.00%)
Max       128     7585.49 (   0.00%)     7818.70 (   3.07%)
Max       256     9583.72 (   0.00%)     8450.29 ( -11.83%)
BHmean-50 1        822.25 (   0.00%)      834.01 (   1.43%)
BHmean-50 2       1457.81 (   0.00%)     1435.25 (  -1.55%)
BHmean-50 4       2287.80 (   0.00%)     2369.75 (   3.58%)
BHmean-50 8       3524.24 (   0.00%)     3550.48 (   0.74%)
BHmean-50 16      5426.84 (   0.00%)     6154.63 (  13.41%)
BHmean-50 32      8254.63 (   0.00%)     8705.67 (   5.46%)
BHmean-50 64      7058.18 (   0.00%)     7311.16 (   3.58%)
BHmean-50 128     7457.52 (   0.00%)     7605.17 (   1.98%)
BHmean-50 256     7914.05 (   0.00%)     7874.19 (  -0.50%)
BHmean-95 1        820.74 (   0.00%)      830.01 (   1.13%)
BHmean-95 2       1437.22 (   0.00%)     1432.28 (  -0.34%)
BHmean-95 4       2282.12 (   0.00%)     2364.73 (   3.62%)
BHmean-95 8       3497.46 (   0.00%)     3515.13 (   0.51%)
BHmean-95 16      5360.61 (   0.00%)     6080.68 (  13.43%)
BHmean-95 32      8074.70 (   0.00%)     8187.13 (   1.39%)
BHmean-95 64      6608.51 (   0.00%)     7177.60 (   8.61%)
BHmean-95 128     7394.83 (   0.00%)     7576.42 (   2.46%)
BHmean-95 256     7700.43 (   0.00%)     7768.59 (   0.89%)
BHmean-99 1        820.50 (   0.00%)      829.47 (   1.09%)
BHmean-99 2       1434.42 (   0.00%)     1430.26 (  -0.29%)
BHmean-99 4       2281.50 (   0.00%)     2364.22 (   3.63%)
BHmean-99 8       3494.52 (   0.00%)     3513.23 (   0.54%)
BHmean-99 16      5356.37 (   0.00%)     6072.71 (  13.37%)
BHmean-99 32      8064.00 (   0.00%)     8156.38 (   1.15%)
BHmean-99 64      6585.62 (   0.00%)     7158.54 (   8.70%)
BHmean-99 128     7356.65 (   0.00%)     7545.32 (   2.56%)
BHmean-99 256     7688.68 (   0.00%)     7762.38 (   0.96%)

dbench4 Per-VFS Operation latency Latency

                6_1_base_config6_1_final_config
                io-dbench4-asyncio-dbench4-async
Duration User        1979.58     2097.00
Duration System     19522.29    19246.17
Duration Elapsed     1643.53     1642.83

                                6_1_base_config6_1_final_config
                                io-dbench4-asyncio-dbench4-async
Ops Minor Faults                      410528.00      362832.00
Ops Normal allocs                  418149664.00   440830731.00
Ops Sector Reads                        1132.00          28.00
Ops Sector Writes                  811726764.00   868601700.00
Ops Page migrate success               41282.00       16565.00
Ops Compaction cost                       42.85          17.19
Ops NUMA alloc hit                 407380422.00   428784879.00
Ops NUMA alloc local               407380245.00   428784630.00
Ops NUMA base-page range updates       83253.00       43358.00
Ops NUMA PTE updates                   83253.00       43358.00
Ops NUMA hint faults                   81229.00       30774.00
Ops NUMA hint local faults %           24325.00       13842.00
Ops NUMA hint local percent               29.95          44.98
Ops NUMA pages migrated                41282.00       16565.00
Ops AutoNUMA cost                        407.51         154.49

autonumabench
                                         6_1_base_config       6_1_final_config
                                      numa-autonumabench     numa-autonumabench
Min       syst-NUMA01                  126.65 (   0.00%)       15.45 (  87.80%)
Min       syst-NUMA01_THREADLOCAL        0.19 (   0.00%)        0.14 (  26.32%)
Min       syst-NUMA02                    0.71 (   0.00%)        0.73 (  -2.82%)
Min       syst-NUMA02_SMT                0.57 (   0.00%)        0.59 (  -3.51%)
Min       elsp-NUMA01                  241.41 (   0.00%)      286.88 ( -18.84%)
Min       elsp-NUMA01_THREADLOCAL        1.05 (   0.00%)        1.03 (   1.90%)
Min       elsp-NUMA02                    2.94 (   0.00%)        3.03 (  -3.06%)
Min       elsp-NUMA02_SMT                3.31 (   0.00%)        3.11 (   6.04%)
Amean     syst-NUMA01                  199.02 (   0.00%)       17.55 *  91.18%*
Amean     syst-NUMA01_THREADLOCAL        0.21 (   0.00%)        0.19 *   8.16%*
Amean     syst-NUMA02                    0.85 (   0.00%)        0.79 *   6.59%*
Amean     syst-NUMA02_SMT                0.63 (   0.00%)        0.63 *   0.00%*
Amean     elsp-NUMA01                  257.78 (   0.00%)      309.43 * -20.04%*
Amean     elsp-NUMA01_THREADLOCAL        1.06 (   0.00%)        1.04 *   2.42%*
Amean     elsp-NUMA02                    3.24 (   0.00%)        3.12 *   3.62%*
Amean     elsp-NUMA02_SMT                3.58 (   0.00%)        3.44 *   4.15%*
Stddev    syst-NUMA01                   41.05 (   0.00%)        1.68 (  95.92%)
Stddev    syst-NUMA01_THREADLOCAL        0.01 (   0.00%)        0.03 (-148.57%)
Stddev    syst-NUMA02                    0.11 (   0.00%)        0.06 (  44.44%)
Stddev    syst-NUMA02_SMT                0.03 (   0.00%)        0.03 (  -8.16%)
Stddev    elsp-NUMA01                   12.69 (   0.00%)       15.71 ( -23.79%)
Stddev    elsp-NUMA01_THREADLOCAL        0.01 (   0.00%)        0.01 ( -14.02%)
Stddev    elsp-NUMA02                    0.23 (   0.00%)        0.05 (  76.35%)
Stddev    elsp-NUMA02_SMT                0.29 (   0.00%)        0.26 (   9.56%)
CoeffVar  syst-NUMA01                   20.63 (   0.00%)        9.56 (  53.68%)
CoeffVar  syst-NUMA01_THREADLOCAL        5.50 (   0.00%)       14.88 (-170.66%)
CoeffVar  syst-NUMA02                   12.77 (   0.00%)        7.59 (  40.52%)
CoeffVar  syst-NUMA02_SMT                4.98 (   0.00%)        5.39 (  -8.16%)
CoeffVar  elsp-NUMA01                    4.92 (   0.00%)        5.08 (  -3.13%)
CoeffVar  elsp-NUMA01_THREADLOCAL        0.65 (   0.00%)        0.76 ( -16.85%)
CoeffVar  elsp-NUMA02                    7.16 (   0.00%)        1.76 (  75.47%)
CoeffVar  elsp-NUMA02_SMT                7.98 (   0.00%)        7.53 (   5.65%)
Max       syst-NUMA01                  264.54 (   0.00%)       19.81 (  92.51%)
Max       syst-NUMA01_THREADLOCAL        0.22 (   0.00%)        0.23 (  -4.55%)
Max       syst-NUMA02                    0.99 (   0.00%)        0.89 (  10.10%)
Max       syst-NUMA02_SMT                0.67 (   0.00%)        0.69 (  -2.99%)
Max       elsp-NUMA01                  273.51 (   0.00%)      325.28 ( -18.93%)
Max       elsp-NUMA01_THREADLOCAL        1.07 (   0.00%)        1.05 (   1.87%)
Max       elsp-NUMA02                    3.63 (   0.00%)        3.20 (  11.85%)
Max       elsp-NUMA02_SMT                4.12 (   0.00%)        3.73 (   9.47%)
BAmean-50 syst-NUMA01                  167.44 (   0.00%)       15.93 (  90.49%)
BAmean-50 syst-NUMA01_THREADLOCAL        0.20 (   0.00%)        0.17 (  15.00%)
BAmean-50 syst-NUMA02                    0.75 (   0.00%)        0.74 (   0.89%)
BAmean-50 syst-NUMA02_SMT                0.60 (   0.00%)        0.60 (   0.55%)
BAmean-50 elsp-NUMA01                  245.37 (   0.00%)      293.30 ( -19.53%)
BAmean-50 elsp-NUMA01_THREADLOCAL        1.06 (   0.00%)        1.03 (   2.52%)
BAmean-50 elsp-NUMA02                    3.04 (   0.00%)        3.07 (  -0.88%)
BAmean-50 elsp-NUMA02_SMT                3.36 (   0.00%)        3.18 (   5.36%)
BAmean-95 syst-NUMA01                  188.10 (   0.00%)       17.17 (  90.87%)
BAmean-95 syst-NUMA01_THREADLOCAL        0.21 (   0.00%)        0.19 (  10.40%)
BAmean-95 syst-NUMA02                    0.82 (   0.00%)        0.77 (   5.88%)
BAmean-95 syst-NUMA02_SMT                0.62 (   0.00%)        0.62 (   0.54%)
BAmean-95 elsp-NUMA01                  255.16 (   0.00%)      306.79 ( -20.24%)
BAmean-95 elsp-NUMA01_THREADLOCAL        1.06 (   0.00%)        1.03 (   2.52%)
BAmean-95 elsp-NUMA02                    3.17 (   0.00%)        3.11 (   2.05%)
BAmean-95 elsp-NUMA02_SMT                3.49 (   0.00%)        3.39 (   3.10%)
BAmean-99 syst-NUMA01                  188.10 (   0.00%)       17.17 (  90.87%)
BAmean-99 syst-NUMA01_THREADLOCAL        0.21 (   0.00%)        0.19 (  10.40%)
BAmean-99 syst-NUMA02                    0.82 (   0.00%)        0.77 (   5.88%)
BAmean-99 syst-NUMA02_SMT                0.62 (   0.00%)        0.62 (   0.54%)
BAmean-99 elsp-NUMA01                  255.16 (   0.00%)      306.79 ( -20.24%)
BAmean-99 elsp-NUMA01_THREADLOCAL        1.06 (   0.00%)        1.03 (   2.52%)
BAmean-99 elsp-NUMA02                    3.17 (   0.00%)        3.11 (   2.05%)
BAmean-99 elsp-NUMA02_SMT                3.49 (   0.00%)        3.39 (   3.10%)

                6_1_base_config6_1_final_config
                numa-autonumabenchnuma-autonumabench
Duration User      313803.42   325078.49
Duration System      1405.42      134.62
Duration Elapsed     1872.08     2226.35

                                6_1_base_config6_1_final_config
                                numa-autonumabenchnuma-autonumabench
Ops Minor Faults                   239730038.00    57780527.00
Ops Major Faults                         195.00         195.00
Ops Normal allocs                   59157241.00    49821996.00
Ops Sector Reads                       31644.00       31900.00
Ops Sector Writes                      49096.00       51068.00
Ops Page migrate success             7552783.00         275.00
Ops Compaction cost                     7839.79           0.29
Ops NUMA alloc hit                  58997125.00    49605390.00
Ops NUMA alloc local                58979133.00    49603280.00
Ops NUMA base-page range updates    97494921.00        1239.00
Ops NUMA PTE updates                97494921.00        1239.00
Ops NUMA hint faults                98707853.00        1061.00
Ops NUMA hint local faults %        78220667.00         782.00
Ops NUMA hint local percent               79.24          73.70
Ops NUMA pages migrated              7552783.00         275.00
Ops AutoNUMA cost                     494365.23           5.32

Runtime options
Run: OpenMPI Environment
Run:  NAS_OPENMPI_VERSION=openmpi
Run:  PATH=/usr/lib64/mpi/gcc/openmpi/bin:$PATH
Run:  LD_LIBRARY_PATH=/usr/lib64/mpi/gcc/openmpi/lib64
Run: mpirun --use-hwthread-cpus --allow-run-as-root --allow-run-as-root -np 256 ./bin/sp.D.256
...
nas-mpi-bt NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       bt.D      240.02 (   0.00%)      240.23 (  -0.09%)
Amean     bt.D      240.23 (   0.00%)      241.24 *  -0.42%*
Stddev    bt.D        0.30 (   0.00%)        1.71 (-463.35%)
CoeffVar  bt.D        0.13 (   0.00%)        0.71 (-461.00%)
Max       bt.D      240.58 (   0.00%)      243.21 (  -1.09%)
BAmean-50 bt.D      240.02 (   0.00%)      240.23 (  -0.09%)
BAmean-95 bt.D      240.06 (   0.00%)      240.25 (  -0.08%)
BAmean-99 bt.D      240.06 (   0.00%)      240.25 (  -0.08%)

nas-mpi-bt Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-bt.D       1627.17 (   0.00%)     1554.96 (   4.44%)
Min       elspd-bt.D      244.09 (   0.00%)      244.22 (  -0.05%)
Amean     sys-bt.D       1636.36 (   0.00%)     1570.90 *   4.00%*
Amean     elspd-bt.D      244.34 (   0.00%)      245.33 *  -0.41%*
Stddev    sys-bt.D          8.10 (   0.00%)       22.38 (-176.31%)
Stddev    elspd-bt.D        0.35 (   0.00%)        1.78 (-405.43%)
CoeffVar  sys-bt.D          0.49 (   0.00%)        1.42 (-187.83%)
CoeffVar  elspd-bt.D        0.14 (   0.00%)        0.73 (-403.39%)
Max       sys-bt.D       1642.44 (   0.00%)     1596.48 (   2.80%)
Max       elspd-bt.D      244.74 (   0.00%)      247.38 (  -1.08%)
BAmean-50 sys-bt.D       1627.17 (   0.00%)     1554.96 (   4.44%)
BAmean-50 elspd-bt.D      244.09 (   0.00%)      244.22 (  -0.05%)
BAmean-95 sys-bt.D       1633.33 (   0.00%)     1558.11 (   4.61%)
BAmean-95 elspd-bt.D      244.13 (   0.00%)      244.30 (  -0.07%)
BAmean-99 sys-bt.D       1633.33 (   0.00%)     1558.11 (   4.61%)
BAmean-99 elspd-bt.D      244.13 (   0.00%)      244.30 (  -0.07%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User      181648.82   182614.64
Duration System      4910.66     4714.35
Duration Elapsed      742.88      745.28

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                   380489860.00    75510645.00
Ops Major Faults                         302.00         292.00
Ops Swap Ins                               0.00           0.00
Ops Normal allocs                   26303147.00    26030593.00
Ops Sector Reads                       33988.00       33904.00
Ops Sector Writes                      41932.00       40896.00
Ops Page migrate success              284339.00        5343.00
Ops Page migrate failure                   1.00           0.00
Ops Compaction cost                      295.14           5.55
Ops NUMA alloc hit                  26169335.00    25898920.00
Ops NUMA alloc local                26169335.00    25898920.00
Ops NUMA base-page range updates   354977260.00    49183327.00
Ops NUMA PTE updates               354977260.00    49183327.00
Ops NUMA hint faults               354078577.00    49085315.00
Ops NUMA hint local faults %       353643387.00    49076300.00
Ops NUMA hint local percent               99.88          99.98
Ops NUMA pages migrated               284339.00        5343.00
Ops AutoNUMA cost                    1772883.13      245770.96

nas-mpi-cg NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       cg.D      156.35 (   0.00%)      142.08 (   9.13%)
Amean     cg.D      157.57 (   0.00%)      142.59 *   9.50%*
Stddev    cg.D        1.89 (   0.00%)        0.48 (  74.93%)
CoeffVar  cg.D        1.20 (   0.00%)        0.33 (  72.30%)
Max       cg.D      159.75 (   0.00%)      143.02 (  10.47%)
BAmean-50 cg.D      156.35 (   0.00%)      142.08 (   9.13%)
BAmean-95 cg.D      156.47 (   0.00%)      142.38 (   9.01%)
BAmean-99 cg.D      156.47 (   0.00%)      142.38 (   9.01%)

nas-mpi-cg Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-cg.D       2484.08 (   0.00%)     2262.29 (   8.93%)
Min       elspd-cg.D      164.10 (   0.00%)      149.84 (   8.69%)
Amean     sys-cg.D       2518.20 (   0.00%)     2296.84 *   8.79%*
Amean     elspd-cg.D      165.32 (   0.00%)      150.40 *   9.02%*
Stddev    sys-cg.D         40.64 (   0.00%)       30.83 (  24.14%)
Stddev    elspd-cg.D        1.96 (   0.00%)        0.50 (  74.38%)
CoeffVar  sys-cg.D          1.61 (   0.00%)        1.34 (  16.83%)
CoeffVar  elspd-cg.D        1.18 (   0.00%)        0.33 (  71.84%)
Max       sys-cg.D       2563.17 (   0.00%)     2321.56 (   9.43%)
Max       elspd-cg.D      167.58 (   0.00%)      150.80 (  10.01%)
BAmean-50 sys-cg.D       2484.08 (   0.00%)     2262.29 (   8.93%)
BAmean-50 elspd-cg.D      164.10 (   0.00%)      149.84 (   8.69%)
BAmean-95 sys-cg.D       2495.72 (   0.00%)     2284.47 (   8.46%)
BAmean-95 elspd-cg.D      164.19 (   0.00%)      150.20 (   8.52%)
BAmean-99 sys-cg.D       2495.72 (   0.00%)     2284.47 (   8.46%)
BAmean-99 elspd-cg.D      164.19 (   0.00%)      150.20 (   8.52%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User      118328.59   107542.39
Duration System      7555.79     6891.65
Duration Elapsed      501.43      456.77

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                   115149790.00    32917253.00
Ops Major Faults                          25.00          26.00
Ops Normal allocs                   23369629.00    23011001.00
Ops Sector Reads                         436.00         540.00
Ops Sector Writes                      39728.00       39280.00
Ops Page migrate success              353217.00         686.00
Ops Compaction cost                      366.64           0.71
Ops NUMA alloc hit                  23250676.00    22895722.00
Ops NUMA alloc local                23250672.00    22895722.00
Ops NUMA base-page range updates   106418880.00     9823982.00
Ops NUMA PTE updates               106418880.00     9823982.00
Ops NUMA hint faults                91920469.00     9686971.00
Ops NUMA hint local faults %        91283239.00     9685903.00
Ops NUMA hint local percent               99.31          99.99
Ops NUMA pages migrated               353217.00         686.00
Ops AutoNUMA cost                     460353.99       48503.64

nas-mpi-ep NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       ep.D        8.44 (   0.00%)        8.65 (  -2.49%)
Amean     ep.D        8.65 (   0.00%)        9.35 *  -8.10%*
Stddev    ep.D        0.27 (   0.00%)        0.85 (-218.35%)
CoeffVar  ep.D        3.10 (   0.00%)        9.14 (-194.51%)
Max       ep.D        8.95 (   0.00%)       10.30 ( -15.08%)
BAmean-50 ep.D        8.44 (   0.00%)        8.65 (  -2.49%)
BAmean-95 ep.D        8.50 (   0.00%)        8.87 (  -4.41%)
BAmean-99 ep.D        8.50 (   0.00%)        8.87 (  -4.41%)

nas-mpi-ep Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-ep.D         31.16 (   0.00%)       20.49 (  34.24%)
Min       elspd-ep.D        9.91 (   0.00%)       10.16 (  -2.52%)
Amean     sys-ep.D         31.47 (   0.00%)       27.28 *  13.30%*
Amean     elspd-ep.D       10.20 (   0.00%)       10.89 *  -6.73%*
Stddev    sys-ep.D          0.36 (   0.00%)        6.04 (-1591.77%)
Stddev    elspd-ep.D        0.29 (   0.00%)        0.86 (-196.95%)
CoeffVar  sys-ep.D          1.13 (   0.00%)       22.12 (-1851.38%)
CoeffVar  elspd-ep.D        2.84 (   0.00%)        7.91 (-178.23%)
Max       sys-ep.D         31.86 (   0.00%)       32.03 (  -0.53%)
Max       elspd-ep.D       10.49 (   0.00%)       11.84 ( -12.87%)
BAmean-50 sys-ep.D         31.16 (   0.00%)       20.49 (  34.24%)
BAmean-50 elspd-ep.D        9.91 (   0.00%)       10.16 (  -2.52%)
BAmean-95 sys-ep.D         31.27 (   0.00%)       24.91 (  20.35%)
BAmean-95 elspd-ep.D       10.06 (   0.00%)       10.41 (  -3.53%)
BAmean-99 sys-ep.D         31.27 (   0.00%)       24.91 (  20.35%)
BAmean-99 elspd-ep.D       10.06 (   0.00%)       10.41 (  -3.53%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User        6689.32     7231.16
Duration System        95.70       83.00
Duration Elapsed       35.58       37.36

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                     3171011.00     2958900.00
Ops Major Faults                          21.00          21.00
Ops Normal allocs                    1735733.00     1725659.00
Ops Sector Reads                          24.00          24.00
Ops Sector Writes                      37008.00       37620.00
Ops NUMA alloc hit                   1620169.00     1618267.00
Ops NUMA alloc local                 1620169.00     1618267.00
Ops NUMA base-page range updates     1343733.00     1061345.00
Ops NUMA PTE updates                 1343733.00     1061345.00
Ops NUMA hint faults                 1158152.00      945501.00
Ops NUMA hint local faults %         1158144.00      945501.00
Ops NUMA pages migrated                    7.00           0.00
Ops AutoNUMA cost                       5800.17        4734.93

nas-mpi-is NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       is.D        5.05 (   0.00%)        5.02 (   0.59%)
Amean     is.D        5.19 (   0.00%)        5.22 *  -0.45%*
Stddev    is.D        0.13 (   0.00%)        0.28 (-122.86%)
CoeffVar  is.D        2.44 (   0.00%)        5.41 (-121.86%)
Max       is.D        5.29 (   0.00%)        5.54 (  -4.73%)
BAmean-50 is.D        5.05 (   0.00%)        5.02 (   0.59%)
BAmean-95 is.D        5.14 (   0.00%)        5.05 (   1.75%)
BAmean-99 is.D        5.14 (   0.00%)        5.05 (   1.75%)

nas-mpi-is Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-is.D        370.08 (   0.00%)      364.28 (   1.57%)
Min       elspd-is.D        9.05 (   0.00%)        8.91 (   1.55%)
Amean     sys-is.D        377.93 (   0.00%)      381.63 *  -0.98%*
Amean     elspd-is.D        9.13 (   0.00%)        9.10 *   0.29%*
Stddev    sys-is.D          6.97 (   0.00%)       23.90 (-243.13%)
Stddev    elspd-is.D        0.07 (   0.00%)        0.24 (-240.87%)
CoeffVar  sys-is.D          1.84 (   0.00%)        6.26 (-239.80%)
CoeffVar  elspd-is.D        0.77 (   0.00%)        2.62 (-241.87%)
Max       sys-is.D        383.37 (   0.00%)      408.90 (  -6.66%)
Max       elspd-is.D        9.18 (   0.00%)        9.37 (  -2.07%)
BAmean-50 sys-is.D        370.08 (   0.00%)      364.28 (   1.57%)
BAmean-50 elspd-is.D        9.05 (   0.00%)        8.91 (   1.55%)
BAmean-95 sys-is.D        375.22 (   0.00%)      368.00 (   1.92%)
BAmean-95 elspd-is.D        9.11 (   0.00%)        8.97 (   1.48%)
BAmean-99 sys-is.D        375.22 (   0.00%)      368.00 (   1.92%)
BAmean-99 elspd-is.D        9.11 (   0.00%)        8.97 (   1.48%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User        4762.89     4747.01
Duration System      1134.94     1146.02
Duration Elapsed       32.11       31.81

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                    66496004.00    47159682.00
Ops Major Faults                          21.00          21.00
Ops Normal allocs                   23449077.00    22990132.00
Ops Sector Reads                         384.00         384.00
Ops Sector Writes                      38040.00       35828.00
Ops Page migrate success             1938622.00     1485033.00
Ops Compaction cost                     2012.29        1541.46
Ops NUMA alloc hit                  23337713.00    22880414.00
Ops NUMA alloc local                23337713.00    22880414.00
Ops NUMA base-page range updates    45446261.00    25594500.00
Ops NUMA PTE updates                45446261.00    25594500.00
Ops NUMA hint faults                44834767.00    25501047.00
Ops NUMA hint local faults %        42555580.00    24013161.00
Ops NUMA hint local percent               94.92          94.17
Ops NUMA pages migrated              1938622.00     1485033.00
Ops AutoNUMA cost                     224528.79      127712.61

nas-mpi-lu NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       lu.D      183.79 (   0.00%)      183.22 (   0.31%)
Amean     lu.D      183.96 (   0.00%)      183.43 *   0.29%*
Stddev    lu.D        0.25 (   0.00%)        0.19 (  26.01%)
CoeffVar  lu.D        0.14 (   0.00%)        0.10 (  25.80%)
Max       lu.D      184.25 (   0.00%)      183.55 (   0.38%)
BAmean-50 lu.D      183.79 (   0.00%)      183.22 (   0.31%)
BAmean-95 lu.D      183.82 (   0.00%)      183.38 (   0.24%)
BAmean-99 lu.D      183.82 (   0.00%)      183.38 (   0.24%)

nas-mpi-lu Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-lu.D        755.87 (   0.00%)      636.36 (  15.81%)
Min       elspd-lu.D      187.61 (   0.00%)      187.18 (   0.23%)
Amean     sys-lu.D        766.88 (   0.00%)      649.63 *  15.29%*
Amean     elspd-lu.D      187.86 (   0.00%)      187.28 *   0.31%*
Stddev    sys-lu.D          9.69 (   0.00%)       12.13 ( -25.19%)
Stddev    elspd-lu.D        0.28 (   0.00%)        0.11 (  61.93%)
CoeffVar  sys-lu.D          1.26 (   0.00%)        1.87 ( -47.79%)
CoeffVar  elspd-lu.D        0.15 (   0.00%)        0.06 (  61.81%)
Max       sys-lu.D        774.09 (   0.00%)      660.14 (  14.72%)
Max       elspd-lu.D      188.16 (   0.00%)      187.39 (   0.41%)
BAmean-50 sys-lu.D        755.87 (   0.00%)      636.36 (  15.81%)
BAmean-50 elspd-lu.D      187.61 (   0.00%)      187.18 (   0.23%)
BAmean-95 sys-lu.D        763.28 (   0.00%)      644.38 (  15.58%)
BAmean-95 elspd-lu.D      187.71 (   0.00%)      187.22 (   0.26%)
BAmean-99 sys-lu.D        763.28 (   0.00%)      644.38 (  15.58%)
BAmean-99 elspd-lu.D      187.71 (   0.00%)      187.22 (   0.26%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User      140870.85   140812.35
Duration System      2302.38     1950.50
Duration Elapsed      572.07      570.59

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                   159164134.00    36327663.00
Ops Major Faults                          22.00          23.00
Ops Normal allocs                   12766911.00    12701365.00
Ops Sector Reads                         392.00         432.00
Ops Sector Writes                      40336.00       39988.00
Ops Page migrate success               49476.00        5899.00
Ops Compaction cost                       51.36           6.12
Ops NUMA alloc hit                  12641163.00    12586537.00
Ops NUMA alloc local                12641163.00    12586537.00
Ops NUMA base-page range updates   146297502.00    23468561.00
Ops NUMA PTE updates               146297502.00    23468561.00
Ops NUMA hint faults               146195881.00    23366950.00
Ops NUMA hint local faults %       146121976.00    23360847.00
Ops NUMA hint local percent               99.95          99.97
Ops NUMA pages migrated                49476.00        5899.00
Ops AutoNUMA cost                     732004.43      116999.14

nas-mpi-mg NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       mg.D       32.10 (   0.00%)       31.87 (   0.72%)
Amean     mg.D       32.14 (   0.00%)       31.88 *   0.79%*
Stddev    mg.D        0.04 (   0.00%)        0.02 (  34.24%)
CoeffVar  mg.D        0.11 (   0.00%)        0.07 (  33.72%)
Max       mg.D       32.17 (   0.00%)       31.91 (   0.81%)
BAmean-50 mg.D       32.10 (   0.00%)       31.87 (   0.72%)
BAmean-95 mg.D       32.12 (   0.00%)       31.87 (   0.78%)
BAmean-99 mg.D       32.12 (   0.00%)       31.87 (   0.78%)

nas-mpi-mg Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-mg.D        477.89 (   0.00%)      418.76 (  12.37%)
Min       elspd-mg.D       35.88 (   0.00%)       35.62 (   0.72%)
Amean     sys-mg.D        484.38 (   0.00%)      420.00 *  13.29%*
Amean     elspd-mg.D       35.98 (   0.00%)       35.74 *   0.68%*
Stddev    sys-mg.D          5.70 (   0.00%)        1.16 (  79.67%)
Stddev    elspd-mg.D        0.11 (   0.00%)        0.13 ( -18.57%)
CoeffVar  sys-mg.D          1.18 (   0.00%)        0.28 (  76.55%)
CoeffVar  elspd-mg.D        0.31 (   0.00%)        0.37 ( -19.38%)
Max       sys-mg.D        488.60 (   0.00%)      421.06 (  13.82%)
Max       elspd-mg.D       36.10 (   0.00%)       35.88 (   0.61%)
BAmean-50 sys-mg.D        477.89 (   0.00%)      418.76 (  12.37%)
BAmean-50 elspd-mg.D       35.88 (   0.00%)       35.62 (   0.72%)
BAmean-95 sys-mg.D        482.27 (   0.00%)      419.47 (  13.02%)
BAmean-95 elspd-mg.D       35.92 (   0.00%)       35.66 (   0.71%)
BAmean-99 sys-mg.D        482.27 (   0.00%)      419.47 (  13.02%)
BAmean-99 elspd-mg.D       35.92 (   0.00%)       35.66 (   0.71%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User       25080.64    25066.21
Duration System      1454.59     1261.44
Duration Elapsed      115.21      114.28

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                   179027668.00    68883081.00
Ops Major Faults                          21.00          21.00
Ops Normal allocs                   23768625.00    23750979.00
Ops Sector Reads                          88.00          88.00
Ops Sector Writes                      38272.00       37544.00
Ops Page migrate success               12059.00        1774.00
Ops Compaction cost                       12.52           1.84
Ops NUMA alloc hit                  23643850.00    23634234.00
Ops NUMA alloc local                23643849.00    23634234.00
Ops NUMA base-page range updates   155287026.00    45123410.00
Ops NUMA PTE updates               155287026.00    45123410.00
Ops NUMA hint faults               155055287.00    44908778.00
Ops NUMA hint local faults %       155037730.00    44906752.00
Ops NUMA hint local percent               99.99         100.00
Ops NUMA pages migrated                12059.00        1774.00
Ops AutoNUMA cost                     776363.67      224859.79

nas-mpi-sp NAS Time
                      6_1_base_config       6_1_final_config
                     hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sp.D      408.19 (   0.00%)      409.12 (  -0.23%)
Amean     sp.D      408.32 (   0.00%)      409.82 *  -0.37%*
Stddev    sp.D        0.13 (   0.00%)        0.63 (-400.26%)
CoeffVar  sp.D        0.03 (   0.00%)        0.15 (-398.42%)
Max       sp.D      408.44 (   0.00%)      410.33 (  -0.46%)
BAmean-50 sp.D      408.19 (   0.00%)      409.12 (  -0.23%)
BAmean-95 sp.D      408.25 (   0.00%)      409.56 (  -0.32%)
BAmean-99 sp.D      408.25 (   0.00%)      409.56 (  -0.32%)

nas-mpi-sp Wall Time
                            6_1_base_config       6_1_final_config
                           hpc-nas-mpi-full       hpc-nas-mpi-full
Min       sys-sp.D       4120.36 (   0.00%)     3820.43 (   7.28%)
Min       elspd-sp.D      412.02 (   0.00%)      413.00 (  -0.24%)
Amean     sys-sp.D       4187.54 (   0.00%)     3970.32 *   5.19%*
Amean     elspd-sp.D      412.20 (   0.00%)      413.64 *  -0.35%*
Stddev    sys-sp.D         65.82 (   0.00%)      132.28 (-100.95%)
Stddev    elspd-sp.D        0.20 (   0.00%)        0.57 (-181.53%)
CoeffVar  sys-sp.D          1.57 (   0.00%)        3.33 (-111.94%)
CoeffVar  elspd-sp.D        0.05 (   0.00%)        0.14 (-180.55%)
Max       sys-sp.D       4251.92 (   0.00%)     4070.68 (   4.26%)
Max       elspd-sp.D      412.42 (   0.00%)      414.08 (  -0.40%)
BAmean-50 sys-sp.D       4120.36 (   0.00%)     3820.43 (   7.28%)
BAmean-50 elspd-sp.D      412.02 (   0.00%)      413.00 (  -0.24%)
BAmean-95 sys-sp.D       4155.35 (   0.00%)     3920.14 (   5.66%)
BAmean-95 elspd-sp.D      412.10 (   0.00%)      413.43 (  -0.32%)
BAmean-99 sys-sp.D       4155.35 (   0.00%)     3920.14 (   5.66%)
BAmean-99 elspd-sp.D      412.10 (   0.00%)      413.43 (  -0.32%)


                6_1_base_config6_1_final_config
                hpc-nas-mpi-fullhpc-nas-mpi-full
Duration User      302843.74   304665.29
Duration System     12564.12    11912.42
Duration Elapsed     1246.11     1249.45

                                6_1_base_config6_1_final_config
                                hpc-nas-mpi-fullhpc-nas-mpi-full
Ops Minor Faults                   383084930.00    65419151.00
Ops Major Faults                          76.00          21.00
Ops Normal allocs                   22711498.00    22411009.00
Ops Sector Reads                       13799.00         256.00
Ops Sector Writes                      44632.00       42080.00
Ops Page migrate success              299748.00        8317.00
Ops Page migrate failure                   1.00           0.00
Ops Compaction cost                      311.14           8.63
Ops NUMA alloc hit                  22593673.00    22286577.00
Ops NUMA alloc local                22593274.00    22286577.00
Ops NUMA base-page range updates   360559234.00    42879377.00
Ops NUMA PTE updates               360559234.00    42879377.00
Ops NUMA hint faults               360428916.00    42781996.00
Ops NUMA hint local faults %       359952878.00    42767934.00
Ops NUMA hint local percent               99.87          99.97
Ops NUMA pages migrated               299748.00        8317.00
Ops AutoNUMA cost                    1804674.19      214210.29

[1] sched/numa: Process Adaptive autoNUMA 
Link: https://lore.kernel.org/lkml/20220128052851.17162-1-bharata@amd.com/T/
Raghavendra K T (1):
  sched/numa: Enhance vma scanning logic

 include/linux/mm_types.h |  2 ++
 kernel/sched/fair.c      | 32 ++++++++++++++++++++++++++++++++
 mm/memory.c              | 21 +++++++++++++++++++++
 3 files changed, 55 insertions(+)

-- 
2.34.1

