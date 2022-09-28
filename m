Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F294F5ED99C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiI1J6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiI1J6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:58:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052338C;
        Wed, 28 Sep 2022 02:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFYpDk2pkfaW/mPcXErY1hp/kv2AvuS9isI2EWP5kirzuzNYlG35eT38Q0pC47g1JMmxXotmV0cRQlr+a7/SLcvfeXQRHJPKfjoKY+yZklbR9lFmQqCWS3VSm4bcYmCcnKMJ2ccX+P6dDN7gNbW8OE+YEMEVOHiZDZdCh8Oj6zlsth6WarXrmrU16R3wWHz+3k05fs5gngx6zc0PFDHhbhfc33v3IG2PuCS5TCt6hu/SIqKkXP+TZgKS1Xuhj4Q9io5KNBqO63m+RlgEoBlWl3g3t6oyelvBxKaKuX5SOTwTPGCptmZGD884wyjUpAqc8uX56fQu6Hy1KMFa2esVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNbrDbsM/bO3QeGdHS8NN8ks8Thznq8UBQMFcTMPqxg=;
 b=ibQ54/I/JUhLHKxHW9dJj6czj9n/oVeKpwWYYXNXFDhc2Z3zAP0B/Y99g4o7DITg2jRpZEvELWS9Ix+XutLUts8LD5UwqLFxUh7XPI4fAACc00CqSF5clEs2pfqo/fyOFFy8jH6dEopcn37yYrQgjeQ70Tr2bVnhpoAH7j01U6bGFEo2GaGIusd3mdU8h7iQ9kJxl9yLwkRQVrpwLHYxekQ9dt1si9OMPCToBETDnItD4hQe6/qoin+JZrLCY/6fYG/6NONjlRFOQPxzyBo3Oq7AW1SvBbUyXC8zN9VpziLPDibWo9hh8+3KRYvxPndYvBLVySjNU3uy82gaAdT53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNbrDbsM/bO3QeGdHS8NN8ks8Thznq8UBQMFcTMPqxg=;
 b=2y9kJzZ4AQ3P3+88Y38wMxFYmNsLKDd23DmB8O/qXl+U4VlZy/VenKf0Otb5JifGFU2tCKm5NlDXf8TjrL/EPI4kYExIVu3O+JU9ihRdtw+felUhGNJMWciY3yoQuKA2hNpv0zYJQshPzJv7Bso9B/+BH/5lCK0YFCZYqW9A1ks=
Received: from MW4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:303:16d::25)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:58:30 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::bb) by MW4PR02CA0026.outlook.office365.com
 (2603:10b6:303:16d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 09:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 09:58:29 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:58:20 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
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
Subject: [PATCH v3 00/15] perf mem/c2c: Add support for AMD
Date:   Wed, 28 Sep 2022 15:27:50 +0530
Message-ID: <20220928095805.596-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|MW3PR12MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: f6012ae3-7cf0-4198-5071-08daa137ff02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jamH+NJdlejKJLkwbyVsnTPjpKtUItTxuR40w6h7QTxwdUmxOII85+x/2qtmVn5zrmnJtuch3Mmd0kpHlcZnEHyzH7+BOt4k9mjO8GnqeaeJeDOff9CEzeLAUC9GmstRpVvB8Zws4VAKcB2+H1QBCiq+LlMLAbdF3KnBXbeJkwRBqYlNKLIcprhcCAgjDEJBjzQtgTN4XkpP4sKI7zqGTVB8t/jfzh002qHIIeLYFi2MYqKPjbzKN1IJ250otJFjDaZZKOfC3b0LJs1T9ibF8WX/r5KP0QxYF16qZofPSvOLzDn08kFGlv6K/mCnzo/47TFOjpENfps1b+3fSMaycvOtDs4qJZkCscmXzUxubWeMG1F+Tk1NIct/XGm1V2YtHl/k3aubHcaofqLaJh5PGsNrVJD8OCnR6vIFtPEgTeEUTRI8zAnOK327D6ATPpAYVp7qcTsFONZsyDuf3ASbPsQcgbgajVVgH/VhWvnnDGHLi6XT5nkcsAk7Av+5C4tR0JtDMhJQZ++W1ECHvPy+mEzYZFqLB5+I2PyRJj5+cc3/7QTugx//lV38L+lOLAV0hHWgYwjQhNdGh2rZBdAKYX1tPgM6B2WbjAIdFpSxAzj4LvpSYmsKH8EqMMgUHS0rrYT1dwRDq+nuf0uyDzKCLTtjutTEMo01YtXHwV2ZfOUye9CRnHLRI7SHmukCIljY1aekI4QDNy7+++ER69KZYj2zMWAFCWxrYh7YqzJze+3ycJFCdYq/vjs/KlBlIHjYNH+/PqOR/tFz/CBGlKmAz/0sz4w29a7NDVAUqZrHdT7/kmUdpAxP1YfTcXlp29J14mAG0FLxDX1Xocum8s2oDpV6PIoukkhNFfjaOKvPED4v2ciD4Y7vt8v2ROgWcKtH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(110136005)(316002)(54906003)(478600001)(7696005)(8936002)(4326008)(36756003)(966005)(70206006)(70586007)(8676002)(1076003)(5660300002)(7416002)(6666004)(26005)(41300700001)(2616005)(2906002)(44832011)(336012)(426003)(47076005)(40460700003)(186003)(16526019)(83380400001)(40480700001)(86362001)(82740400003)(36860700001)(356005)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:58:29.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6012ae3-7cf0-4198-5071-08daa137ff02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf mem and c2c tools are wrappers around perf record with mem load/
store events. IBS tagged load/store sample provides most of the
information needed for these tools. Enable support for these tools on
AMD Zen processors based on IBS Op pmu.

There are some limitations though: Only load/store micro-ops provide
mem/c2c information. Whereas, IBS does not have a way to choose a
particular type of micro-op to tag. This results in many non-LS
micro-ops being tagged which appear as N/A in the perf report. IBS,
being an uncore pmu from kernel point of view[1], does not support per
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

Prepared on queue/perf/core (cce6a2d7e0e49).

v2: https://lore.kernel.org/all/20220616113638.900-1-ravi.bangoria@amd.com
v2->v3:
 - Use sample_flags instead of __PERF_SAMPLE_*_EARLY varients
 - Make PERF_SAMPLE_WEIGHT independent of PERF_SAMPLE_DATA_SRC
 - Add a patch to reverse sync PERF_MEM_SNOOPX_PEER from tools
   to kernel uapi header
 - Add Acked-by: Jiri Olsa for tool side unchanged patches

Also, a recent patch[2] to test perf mem fails on AMD because of
aforementioned limitations.

[1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
[2]: https://lore.kernel.org/lkml/20220924133408.1125903-1-leo.yan%40linaro.org


Ravi Bangoria (15):
  perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
  perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
  perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
  perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
  perf/x86/amd: Support PERF_SAMPLE_ADDR
  perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
  perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file
  perf tool: Sync include/uapi/linux/perf_event.h header
  perf tool: Sync arch/x86/include/asm/amd-ibs.h header
  perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
  perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
  perf mem/c2c: Add load store event mappings for AMD
  perf mem/c2c: Avoid printing empty lines for unsupported events
  perf mem: Use more generic term for LFB
  perf script: Add missing fields in usage hint

 arch/x86/events/amd/ibs.c                | 345 ++++++++++++++++++++++-
 arch/x86/include/asm/amd-ibs.h           |  16 ++
 include/uapi/linux/perf_event.h          |   6 +-
 kernel/events/core.c                     |   3 +-
 tools/arch/x86/include/asm/amd-ibs.h     |  16 ++
 tools/include/uapi/linux/perf_event.h    |   4 +-
 tools/perf/Documentation/perf-c2c.txt    |  14 +-
 tools/perf/Documentation/perf-mem.txt    |   3 +-
 tools/perf/Documentation/perf-record.txt |   1 +
 tools/perf/arch/x86/util/mem-events.c    |  31 +-
 tools/perf/builtin-c2c.c                 |   1 +
 tools/perf/builtin-mem.c                 |   1 +
 tools/perf/builtin-script.c              |   7 +-
 tools/perf/util/mem-events.c             |  17 +-
 14 files changed, 438 insertions(+), 27 deletions(-)

-- 
2.31.1

