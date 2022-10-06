Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5965F6ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJFPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJFPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:43:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6642076973;
        Thu,  6 Oct 2022 08:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET1Kr7+K2x92o+q3nKUZ0uQisRs5EeO+11FakoEjO7p87zUPT0oQU5wixR5zo+zw14FG1PjW54nQpwdTQ4WJTFsaRDrvEnHzJR9jw/qX4uXnclQYC5/E+N1NLrtEDHKpSRZutnowYtsrje4dCRFlvng+CaBD66AHDRnPGHtMC7of+z1kMYZreNuJMXLopPfbylNuTcvQ6H0Fg1JiHEQl0GK3jyWJ9wu+xQLXS87BsTqHdeV7/O6kwHUMDIf9H06Pt2Iga8Uc+Xbqy9wI3bwAOkO4aAAh1QB1FAUs0a4C1RdBqBHeo637r/8L1cUhqzzyq3u2W7GRLrsLYxabpIYxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjT8lIRZZT1YGaUrfaAQ4QclCCAZBaS8PUwwqfSom3s=;
 b=AVE5dCGXi7gYvDJzOn87km4I9tUSYWCQ1c0DC9I3rb6ZViEenQdThTt/SQYa7guWoEpfNpziQafx0Hc4nJKsAYfirD9Ocbqubyop+Xzotbv8+JRwUAe9nfD1G1uBTn5oiTvuAakj7YfFP5sAl9RyyI0MMPJ3wBFzPQwMPHMOwwnfamz23hMzt0eNzHyNw+vAEECavjEv2gjkBMjvnxFPfBC0MRHTufY8/g2L3U4H6Amu3P+B/EF8/jhhtjUTGHp36rRTeWip8wTCN2fciCAjx0YiFGh93t3238JM+hF4+fwYCa60t8FN5dlEsnFKaXFX77xpQeQvVJCFmAuiUQ3iSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjT8lIRZZT1YGaUrfaAQ4QclCCAZBaS8PUwwqfSom3s=;
 b=fBX+9Lrtc7tDiWbPsK1S5m8QbHAO08ct99xfqYNdzpWH5QsqhvBjLivNcG1mC7S2oirUkZ0ZV2g0ESt3PlpcMLt3NW60RViwi9Kr2hwsPfn9OwB8JQG+UoZ5BP6cUVWm4fCx4V4URmHJ/XUj8Ncrt8+W0BbZ/7WCtlDHNPpcoww=
Received: from MW4PR03CA0311.namprd03.prod.outlook.com (2603:10b6:303:dd::16)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 15:43:19 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::f0) by MW4PR03CA0311.outlook.office365.com
 (2603:10b6:303:dd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 15:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:43:19 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:42:13 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 0/8] perf mem/c2c: Add support for AMD (tools changes)
Date:   Thu, 6 Oct 2022 21:09:38 +0530
Message-ID: <20221006153946.7816-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: f694c0ca-c61e-453c-c435-08daa7b17e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezhnIYDOSL5tIFB3ziVgBl6VnDChFZzBpwCH20H3UztCttLHPe+Ph1myPwJ55A3/SEiFfIHgnKTu7jMXu7d/VwFQ8a6bglxMlpStSyYI5QhlbzDFJ+N5QnCalIZQXYwn7W3HEt7nYsS7WNTVFXdMedUaErXl1qSnTy4ccQKx7xousc1recIiMdQjWzt4mGg31jcI74S68c2bLJnkbwfTPSpzRxr12E48OSf0UOZ0xVOLYZOYxHXjIvvra6prfvcxhfWcUqQIxx+jua4Oz1syzEl+BX4QHANjlg4aJwn7MedchgmHTw5AH4NEXZyCIeqnhRtHA4o1SyvTF0W1GnsC7XjHWW/EoBC3cZFllYy4BaVoPvv2UZfKihpG1zRetimLxM6vUCNy4AFiSPT8UeDdD9jNXw7noKj7nDvmQsNI3qzuZqErfuuKBVNX3KiQQSKabcEUA5Wl2o8fA+B7wAYxL5R9bbwe/wHRKKJA8Uy0yEPSH01EXh+5PGvKQM+CSLekY9iRL0kJEfjJn4cQmM06SYZ3fEYbgfXsAtgFkalRoamSegeqT+T6DU1aOoWqwpn4YdoCGq2iIjNzvelMMMN2w6Lq+DbsNmXr1aNKRYJ2av1uNeqfZi+Brm1+KvPpNYMDp4AeeSuLGVKfIo72ncPCpwc0ehs3wQ1kF8d9z4I/N1cLfhE2H/4TFJGRGD+bXai77EijvE+XgpTePyWOdEbdHm1YYBS93lXlyUD93ePNcxh0iKfwq7gkHPoKCkWPgy4Lsk9/G7tzSlByKDJYw3DQJclNIorSFSqC3iP77Wjsb6MGYTXZy1zX9W/HjOfg91RwzztNTqOw0bwTi90uj+aZOquqFA5G1pcxGZpv3AeRHrON6/4SnPy2afcsDnuf9utq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(82740400003)(70586007)(70206006)(2906002)(44832011)(26005)(41300700001)(8676002)(4326008)(356005)(81166007)(40460700003)(86362001)(5660300002)(8936002)(7416002)(478600001)(426003)(47076005)(82310400005)(36860700001)(336012)(54906003)(110136005)(83380400001)(16526019)(966005)(1076003)(186003)(316002)(6666004)(2616005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:43:19.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f694c0ca-c61e-453c-c435-08daa7b17e26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel side of changes are already present in tip/perf/core except
one patch to rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL[1].

Original description:

Perf mem and c2c tools are wrappers around perf record with mem load/
store events. IBS tagged load/store sample provides most of the
information needed for these tools. Enable support for these tools on
AMD Zen processors based on IBS Op pmu.

There are some limitations though: Only load/store micro-ops provide
mem/c2c information. Whereas, IBS does not have a way to choose a
particular type of micro-op to tag. This results in many non-LS
micro-ops being tagged which appear as N/A in the perf report. IBS,
being an uncore pmu from kernel point of view[2], does not support per
process monitoring. Thus, perf mem/c2c on AMD are currently supported
in per-cpu mode only.

Example:
  $ sudo ./perf mem record -- -c 10000
  ^C[ perf record: Woken up 227 times to write data ]
  [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]

  $ sudo ./perf mem report -F mem,sample,snoop
  Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
  Memory access                  Samples  Snoop
  N/A                             700620  N/A
  L1 hit                          126675  N/A
  L2 hit                             424  N/A
  L3 hit                             664  HitM
  L3 hit                              10  N/A
  Local RAM hit                        2  N/A
  Remote RAM (1 hop) hit            8558  N/A
  Remote Cache (1 hop) hit             3  N/A
  Remote Cache (1 hop) hit             2  HitM
  Remote Cache (2 hops) hit            10  HitM
  Remote Cache (2 hops) hit             6  N/A
  Uncached hit                         4  N/A

Prepared on top of acme/perf/core (3b1913adb188)

v3: https://lore.kernel.org/lkml/20220928095805.596-1-ravi.bangoria@amd.com
v3->v4:
 - Rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL for tools part.

[1]: https://lore.kernel.org/lkml/f6268268-b4e9-9ed6-0453-65792644d953@amd.com
[2]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com


Ravi Bangoria (8):
  perf tool: Sync include/uapi/linux/perf_event.h header
  perf tool: Sync arch/x86/include/asm/amd-ibs.h header
  perf mem: Add support for printing PERF_MEM_LVLNUM_{CXL|IO}
  perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
  perf mem/c2c: Add load store event mappings for AMD
  perf mem/c2c: Avoid printing empty lines for unsupported events
  perf mem: Print "LFB/MAB" for PERF_MEM_LVLNUM_LFB
  perf script: Add missing fields in usage hint

 tools/arch/x86/include/asm/amd-ibs.h     | 16 ++++++++++++
 tools/include/uapi/linux/perf_event.h    |  4 ++-
 tools/perf/Documentation/perf-c2c.txt    | 14 ++++++++---
 tools/perf/Documentation/perf-mem.txt    |  3 ++-
 tools/perf/Documentation/perf-record.txt |  1 +
 tools/perf/arch/x86/util/mem-events.c    | 31 ++++++++++++++++++++++--
 tools/perf/builtin-c2c.c                 |  1 +
 tools/perf/builtin-mem.c                 |  1 +
 tools/perf/builtin-script.c              |  7 +++---
 tools/perf/util/mem-events.c             | 17 +++++++------
 10 files changed, 77 insertions(+), 18 deletions(-)

-- 
2.37.3

