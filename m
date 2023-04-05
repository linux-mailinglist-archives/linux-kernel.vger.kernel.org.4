Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A56D848C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjDERJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjDERJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:09:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600BC6;
        Wed,  5 Apr 2023 10:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzg8gz0zRUK69OVylycLOqxI3juB84FL5tycFQah0adkYd9BxeSUZ+lDbZekWP0R4KoPO4ckG8IPOEMDf3ufy8AMrUt8urcg5tODhpZyd2DOITl/U4kQyIfwgvb7GkCpzHdpTBCd8iniZleJ/UutHJj3b1u5GCcubcrRGcE38K0H5nBXRJEsYE9l7yikfuw/y1h9K+cartgI400u7AL2BkWa46Jt37iI5SnTTqYl+0tLmKoYrrCyGcha/OJczUHje3qPSBPH2UuBNLc8TCuTQXhkpim0GhPIhX2QlaSzGRV955YlAiExxpaoBw6zj8zS8tNWEpYtDA3V2NBgxEk1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0s1pJxci22mhOBC1WAx+g98DOKC8lNRc2Fdm6dbe/w=;
 b=VbBpIzqCkkdok+h6mekmgLNbaTvV4PPjTYyMGP9utpgC2edhxauDpxIPSHJr0JOS7JCzAUTD687YQokQMG1PCaLIGnVS3Rrp90jtEm5tzO7+kfbaY4kouTfuLjYFDooWXEm94R4x0NcZIm9Td0j/1VsiCdYNwhxf63cSA7z+gjPCsH63CWBQFhDk7dDZ3OQMASN0O4omFzw9e3fpAK1WSQaEvyGD30FAC65dwSKTDWnn+oMRMXiTHhhN0b9maCq+ewD+n72ghg/tPSAoNS7BbzupgWFuVHYgY+KbzjRaKBAXWRIKyeJIK7daBHiJec7JYkLe2QD4rXsGtgj5m2F9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0s1pJxci22mhOBC1WAx+g98DOKC8lNRc2Fdm6dbe/w=;
 b=V3xcWYndN352eBsf7sv1sjDLXHm8+JxlBUs/rcD48gzr4946aSrWqTgCH16rhjfkIg8ZtIkmQIfFvbYUXt/KmoDmwbo40wSCo7nVpXRFZ0K+XXtgUL5B6/+ELKUE79iAV4Kc+eChfLpOomBvBa91jNMpntD499SUrS0SrZHF4YE=
Received: from DM6PR06CA0029.namprd06.prod.outlook.com (2603:10b6:5:120::42)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 17:09:26 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::d) by DM6PR06CA0029.outlook.office365.com
 (2603:10b6:5:120::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Wed, 5 Apr 2023 17:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 17:09:26 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 12:09:19 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <puwen@hygon.cn>
Subject: [RFC PATCH v2 0/4] perf stat: Add option to aggregate data based on the cache topology
Date:   Wed, 5 Apr 2023 22:39:02 +0530
Message-ID: <20230405170906.2510-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 158c2aa7-8e50-4da3-8898-08db35f882e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWBAN4aB6qoG4VzGBp03amMKUF61df+NItxUd2rTQXojEWljMQ1CRx/hzdAzxKNJjvrW2zmY9UscXbLhU6CzRmsIY+OtWehPDMAkxg9e6AH1SL/t4Eh7RjrePKnDUaXs1csqKqWKZowRhWTWPK6aL+LI3rvzmJ4CmZPVSSzyKntbcWznHRBUzroC9ts682SRKJj0HWIWPtpCglR8XJ+JElrG7IQoONI8OV4kRW2RhuUHfBSiCqLInjaLUv/9PkxN2Rz/UmkXfpVV+5Ju8o0ShL9zlhZvfMrfibe5+cP+QNLIctQLLFWGglvhyYth/pki3sOz20gvy51Je/uNRlZpFIAhPyITrprsR0fD8akBVjYHFl7o+Qrj4czWVtneTUaEUiIN9OPWMGUCLc4/27SpO2O/n3VreecvT2sSywLg25b1x8Ur9IlL/J2FvIubrsB88NYxbAfS2UBf4KiX5ZxC7Rjy3eIKASWTFK7NMfIFDdcbgvgTZhuN0f75ERpVJhEcM3v+5qKBYDpZGgX54QCu6/9kTAIUV1jE0q04h29kwl68RvlvLC8/M1O8i0JnhO6wJ60t/Jd3Fs2YGPILZSZY3bfR5UHjCpPczr9bwe+G9ezdNyiMz30KdQ/z6mD/PS/FfQAJJ014hwcVCA3kymUS5gFvxxJ7ThavWRhwLUhZGnkh+GLq4SRfmwWPSPh7v4lf+Erqld3CLE+2M4qkoES8sRNG1h0tCp/n+5XkQey3P/LzkouaPgf2qavGlGrFAvyT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(336012)(426003)(36860700001)(6666004)(83380400001)(54906003)(1076003)(316002)(7696005)(186003)(478600001)(16526019)(107886003)(110136005)(26005)(2906002)(2616005)(5660300002)(7416002)(8676002)(36756003)(81166007)(356005)(40460700003)(82310400005)(41300700001)(70586007)(4326008)(82740400003)(86362001)(40480700001)(8936002)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 17:09:26.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c2aa7-8e50-4da3-8898-08db35f882e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

[New in v2]
On a kernel which does not have the cache instance ID in the sysfs, the
cache ID is set to 0. Running perf stat will give the following output
on the same system with cache instance ID hidden:

  $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_remote -- sleep 5
  
   Performance counter stats for 'system wide':
     
  S0-D0-L3-ID0            128             13,277      ls_dmnd_fills_from_sys.ext_cache_remote
  S1-D1-L3-ID0            128              9,822      ls_dmnd_fills_from_sys.ext_cache_remote
     
         5.020718145 seconds time elapsed

This series makes breaking change when saving the cache details of env
for recording and reporting purpose. If there is a better way to do
this, please do let me know.

Following points were not considered when designing this RFC:

- Handling multiple cache types at same level: For example consider a
  case where L1i is thread local but L1d is core-wide. The logic
  currently selects the last cache instance it sees at a particular
  level when iterating over the indices. This may lead to user expecting
  a different result than the one perf reported.

- For the same example as above, where L1i is thread local and L1d is
  core-wide, the record and report might not give consistent result as
  the qsort() function used to sort cache_level_data[] when saving the
  env data is unstable and might not preserve the order for the different
  caches at same level. Since we consider the data for the last set of
  data at the same level, the unstable sort might lead to
  inconsistencies.

I'm seeking some clarification from the community for the above problems
and potential solutions for processors where all CPUs might not share
the same topology structure.

This series cleanly applies on top perf-tool branch from Arnaldo's tree
(https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools)
at:

commit e8d018dd0257 ("Linux 6.3-rc3")

--
Changelog:
o v1->v2
  - Set cache instance ID to 0 if the file cannot be read.
  - Fix cache level parsing function.
  - Updated details in cover letter.
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

