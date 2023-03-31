Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB16D166E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCaEv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCaEvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:51:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DACA39;
        Thu, 30 Mar 2023 21:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VySECVXM/xG4r8Ndwo3mh3L9gCqovDa+IatwHjcikbAyTTj9tgdJBaVfDxYwutZuDkt1alGqhLaLxFsy98OdcYltxv9Vz5wEOmqqrAE9Sn5u/c6Owbkg7kogHptiDoXOx59vB0H4J5jKhTCQYgUgUZXme1bjmklu0cXRRBo9gSe7aOL9Lvo7o9cUTGwsToM8yfyTJtJRVu1IIYwmLdSLwqKzdiGIpidSRpnnbCm5Nv5V1l8OeTwiWssCuXKPelQH1wkmIr07sx1Ke5sjSFwR+PGcAN2QRaWND2VvIHeC1kAOO+yXq+kEiclWB+YJ/LaS7Mv8Re1ib+RNLL+OuN9WEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPXZzsrgjPC9rinbOL6lMH0d6AShxGxdq4Q6lm1FEiw=;
 b=Jt18bcD4uLLkVzbr6qLantG04QJ0Xh0cc7l3ArJgs31iXtJsiPSOPTsP4yYR7N9VQLs35brPuxcPdVUFEaaVWsL2S00KKM1j+8cCkZ2zWS4cU4D6YYwhgsC6Jnfh9FhYmIdako1IOIm61gkaCqsUkp/SqPN5XcUL2g5+JekWG3/eI7WJ55PKh3NrIIO38aINGEiEzd6Heok1mYCbIsVdQdIulNPyTiGPUmJ/kjZFWRFjHOydyUcv9/yzOIQWffLQUJIjKQugVC0nHmE/EHkmUzsf/00B4YwC7PA+3Xqk3QSFARkIQ1t/680mJvSkWhgM3XuqRK/32UECyHTVBZP7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPXZzsrgjPC9rinbOL6lMH0d6AShxGxdq4Q6lm1FEiw=;
 b=k1eW2ThyVnzdAqxUqUQWDT1eywy6/rGvVqSbNtOU2CR3bnUpdFNae3F1fKygIxEuTPS9EXbzj19YgxfsK0J+6SkONU/idvLV9XZbrTxeGXw+jWOFG+btcX8QwKaAE3dnwdJgONQRl09KlOou16lZ7wOZVVYYwKUylyhLLOpaK6A=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 04:51:49 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::b4) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 04:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 04:51:48 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 23:51:41 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>
Subject: [RFC PATCH 0/4] perf stat: Add option to aggregate data based on the cache topology
Date:   Fri, 31 Mar 2023 10:21:13 +0530
Message-ID: <20230331045117.1266-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ce2c71-983d-4b01-e5b1-08db31a3a31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sM0Q9CNZxZKipd8fe/xX7VY9zKRbfFqezS9bYIMCkSFf6Y+PQcJsFDdDSbCbJmVLtMkmQcCndceaxwFxlr7tsyPW6ZkX/mxr0vczwq78G3BQAfRAzhmkVKIWVG1Nbt+Yakssp1YBmc8ShjRODjtoAWH5XUymk+hddP+11OrmeeRivje76RsUX3F/UXyBaEtGicEZ1MuPKQncv6u+IAz1Cpfv60buTkvQSydK3cv54Mx7JGvO+k99Gg77Yb3ryn7BxRFD2f+iE52Ua2KXrb96yizUPa3J0Pa2VSARJgaSidL3wdRPCvGEiKSiv3/KFbMU2tFiF+Zf02TNsnlEVTfxFQgcgIuwRKLUQGXSwHGMNI48hF9JaYR+H+4+HbdGcOY9+2mTK2Z7Jj8bPpWi3O8N9Q4urPtcc27jeseS5JO210Bxdvc9IYSju5Qjche804iM7jLZ+7EVJpd80GeQg4ejJ+N1qCx4sizRPC0wcjkPOmOsOJVfc0aAIeLvdupF7TQRQTpOyxb3RpEdUGuvAtg34/BhpShkZ9/yerpthIgssJda8X73vT2FGI3uz5oCd9oO72RQTnM8cJ9wExuxNIvTYzsMkzOw5FGun3DhRydeDHl2yU6xdRNmS5/k2TONe9H/OyvUfqblqImyM63vU7se6dSoRwBlXWC9joQrM/Qy0VMyIM+xptP/WefZETLNVlmh+zj2LbTZmBklVV1e5+LUEaSdafKYS+OnfIzSyK9fn4Uu89ScuO1lRXOozVVXUQA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(83380400001)(86362001)(316002)(41300700001)(6666004)(70586007)(70206006)(4326008)(54906003)(110136005)(36756003)(478600001)(426003)(47076005)(336012)(26005)(2906002)(8936002)(8676002)(82740400003)(5660300002)(82310400005)(2616005)(40480700001)(7416002)(36860700001)(1076003)(186003)(16526019)(356005)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:51:48.7545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ce2c71-983d-4b01-e5b1-08db31a3a31f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation behind this feature is to aggregate the data at the LLC level
for chiplet based processors which currently do not expose the chiplet
details in sysfs cpu topology information.

For the completeness of the feature, the series adds ability to
aggregate data at any cache level. Following is the example of the
output on a dual socket Zen3 processor with 2 x 64C/128T containing 8
chiplet per socket.

  $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- sleep 5

   Performance counter stats for 'system wide':

  S0-D0-L3-ID0             16              4,463      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID1             16              2,962      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID2             16              2,592      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID3             16              2,508      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID4             16              1,841      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID5             16              1,764      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID6             16              1,205      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID7             16              5,806      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID8             16              1,461      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID9             16                648      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID10            16              1,443      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID11            16              1,333      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID12            16              1,167      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID13            16                640      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID14            16                601      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID15            16              3,423      ls_dmnd_fills_from_sys.ext_cache_remote

         5.017954593 seconds time elapsed

The series also adds support for perf stat record and perf stat report
to aggregate data at various cache levels. Following is an example of
recording with aggregation at L2 level and reporting the same data with
aggregation at L3 level.

  $ sudo perf stat record --per-cache=L2 -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- sleep 5

   Performance counter stats for 'system wide':

  S0-D0-L2-ID0              2              3,212      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID1              2                240      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID2              2                 10      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID3              2                 13      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID4              2                 13      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID5              2                319      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID6              2                348      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID7              2                648      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L2-ID8              2                284      ls_dmnd_fills_from_sys.ext_cache_remote
  ...
  S1-D1-L2-ID127            2                113      ls_dmnd_fills_from_sys.ext_cache_remote

         5.017958787 seconds time elapsed

  $ sudo perf stat report --per-cache=L3

   Performance counter stats for '/home/amd/dev/linux/tools/perf/perf stat record --per-cache=L2 -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- sleep 5':

  S0-D0-L3-ID0             16              4,803      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID1             16              3,421      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID2             16              1,149      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID3             16              1,220      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID4             16              1,502      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID5             16              6,751      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID6             16              1,600      ls_dmnd_fills_from_sys.ext_cache_remote
  S0-D0-L3-ID7             16              1,985      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID8             16              1,566      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID9             16              1,010      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID10            16              1,337      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID11            16              2,298      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID12            16                314      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID13            16                350      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID14            16                664      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID15            16              3,834      ls_dmnd_fills_from_sys.ext_cache_remote

         5.017958787 seconds time elapsed

The sum of the aggregate at L2 from S0-D0-L2-ID0 to S0-D0-L2-ID7 is
equal to the value for S0-D0-L3-ID0 in perf stat report with aggregation
at L3 level since L3-ID0 contains L2-ID0 to L2-ID7 on the machine.

This series makes breaking change when saving the cache details of env
for recording and reporting purpose. If there is a better way to do
this, please do let me know.

Following points were not considered when designing this RFC:

- Handling multiple cache types at same level, for example L1i and L1d
  both of which are at level 1. The current implementation will retrieve
  the instance ID from the last entry in cache_level_data[] with the
  matching level. This works as long as L1i and L1d cover same set of
  CPUs but will not work for an exotic cache topology.

- If the processor features an exotic cache topology with different
  type of caches at same level covering different set of CPUs, the
  record and report might not give consistent result as the qsort()
  function used to sort cache_level_data[] when saving the env data is
  unstable and might not preserve the order for the different caches at
  same level.

I'm seeking some clarification from the community for the above problems
and potential solutions for processors where all CPUs might not share
the same topology structure.

This series cleanly applies on top perf-tool branch from Arnaldo's tree
(https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools)
at:

commit e8d018dd0257 ("Linux 6.3-rc3")

--
K Prateek Nayak (4):
  perf: Read cache instance ID when building cache topology
  perf: Save cache instance ID when saving cache topology data
  perf: Extract building cache level for a CPU into separate function
  perf: Add option for --per-cache aggregation

 tools/lib/perf/include/perf/cpumap.h          |   5 +
 tools/lib/perf/include/perf/event.h           |   3 +-
 tools/perf/Documentation/perf-stat.txt        |  16 ++
 tools/perf/builtin-stat.c                     | 149 +++++++++++++++++-
 .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  14 ++
 tools/perf/tests/shell/stat+json_output.sh    |  13 ++
 tools/perf/util/cpumap.c                      |  97 ++++++++++++
 tools/perf/util/cpumap.h                      |  17 ++
 tools/perf/util/env.h                         |   1 +
 tools/perf/util/event.c                       |   7 +-
 tools/perf/util/header.c                      |  77 ++++++---
 tools/perf/util/header.h                      |   4 +
 tools/perf/util/stat-display.c                |  16 ++
 tools/perf/util/stat-shadow.c                 |   1 +
 tools/perf/util/stat.h                        |   2 +
 tools/perf/util/synthetic-events.c            |   1 +
 17 files changed, 395 insertions(+), 32 deletions(-)

-- 
2.34.1

