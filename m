Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B115730E96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbjFOFSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFOFSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:18:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36D26A9;
        Wed, 14 Jun 2023 22:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjPpirw3E9l1PS9RKhS/i4I3tzqqbRHkiZegqZJ4SG0BTbhriaZFzO61IQ5cvtqcmLwDpyuLjw0nkLUuu+lpQ1+s6daqRRLQhNMYtyZb0g6NsuRCL54BhoJ7WJCaEABAUICK7pZK9Uai+rBGhj1eSbjW0jnM8dnm28CPPGuJ5IaPnOgN0DzPK7Dte2b+5gmaoMxfAiq0b+CUsHJfvvWm/COYj33/Efqd2vQ/NJ42e0ycBAt20jOtnpbua79MzEEkfWes5nExHl1QFFnV9kAlFvOtI8WQyS/wo5m2+tmdCCI2sgRmVsmiB06gqUWZ23DYvNU8RRy03dytLQUQAiTyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCFmqI6LFRRN5iXAA6H3rlmNwPH2Cf57pOCtTL7JlJ4=;
 b=hOXuhY6KWN/uNnGSQvmBhVNysCK3+ImWJsqRGMhRGNTTDo3Ksbg63Hher34KQk4QsejtYNsIdEQXjj+lsxkUzElTTVWZyBAXa+iYYohF+5MbrXyZGNuJCYhPGDqWOVUERw0qXscL88uxXLsgbNO82JWX22V4NcoFGgaMF6YqVhGbM9x9ME8DGRSmw9cJLNzQdiLj/wdm6KaM0igLzLJUCp2y3EptYvGOidg52Sx4irrqNkDbwJdNAl2jEVn5NzJrB+pcP4fqeu/604+kyLuvL7rF49vwUJxjYZFkoIB+IXGj+DsKgNXVT6GHsAyTZM9tLXlzyfqHiIbJRN7DsxkWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCFmqI6LFRRN5iXAA6H3rlmNwPH2Cf57pOCtTL7JlJ4=;
 b=yNvYf7QKCXxSJUmf37Acf942nF2FoG9C9IW1LXNVzCcjYG7bJ6Gdp2fgq6g3vZHQwaNabiHL9JwLJNeFml4BFpQdtDxFgkHb3SyAHp+bSpNnLmKknwhIx69VWgkm7GtF5vIYysiLZGs++8/ryEJobeDhyr1jdjb2MXWZoLgWCmE=
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 05:18:10 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::7b) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 05:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 05:18:09 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 00:17:19 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <james.clark@arm.com>, <alisaidi@amazon.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <mark.rutland@arm.com>, <maddy@linux.ibm.com>,
        <tmricht@linux.ibm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 1/3] perf pmus: Describe semantics of 'core_pmus' and 'other_pmus'
Date:   Thu, 15 Jun 2023 10:46:58 +0530
Message-ID: <20230615051700.1833-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615051700.1833-1-ravi.bangoria@amd.com>
References: <20230615051700.1833-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: fa87494f-759b-4bf6-567c-08db6d5fe8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XApnXqnM3IzIUpIysOh6qh08EroIfhf3xoHkmPoCtXlV4tXROtpC4XahSey4IsaKVoFKDdbyFG2+T3Hj9aP0TM7hMYjiGIoRoJow6q+wDpFC+bu3UIka/7A9uvvf5JDte2kGTfATeCzBOw8GW4fSHDDFe34vDTUs33YObinhVZ9CTyTpd7uA5ICtU5gxeQLopO/g56Dy0pfw8N7Z8sn2j5iM1rLFxsLkkhQRL+hOA25wMPNpI0xoEYjyHQXNOF97A8+8Mtlzb4AzxjRlCjUGXvSnzHbA+dTxg0GS6/L6azO5lhZjQnT/6A66R7QIG+NjK81S9eY/XiC6kkl+rlpxZRIiyrTweZglAev+q2gQzkg6zV1OwnP1cwzY64e5SYOqDpO+My7IzZwNpKgqRO7toljHrTTGpeKgIfIqOK39l6x18p36fyXQEvARYcogracak0A2roCyPA4qVjCKd8wkV8ODTKwqo/8IbjEDBDa5AYX+CCwG/nfVK5sAo1IVueobfpfsnMfBY5yCrBq3W4sFZEzM8MhbNBm1kuebvE1XCEUVa55xqZuCeG2SS8mb4TDY3S3X+UrK8XAJAWMvVnfYZood5kojGI0AXqykQFm29bfVwpMf/MKVklBgk3iTryU5pHmo6tUu3pRTvhzqy/lV8s3AhMo6jhRYzsf1BVQl27fM5D1ns9V7i1Cw2qo/cpBSnNKJSD/gw+2IY1IrP2PaVNazqbppjLP4ShXgU2Pchnb5FtDrksZ6+O5TLNQdIP1SoVpH/VnJo7ruVywy5mtLiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(426003)(336012)(186003)(40480700001)(44832011)(2906002)(47076005)(16526019)(7416002)(2616005)(36860700001)(41300700001)(8936002)(7696005)(26005)(40460700003)(8676002)(316002)(54906003)(6666004)(82740400003)(36756003)(478600001)(81166007)(356005)(82310400005)(4326008)(86362001)(70206006)(6916009)(70586007)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 05:18:09.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa87494f-759b-4bf6-567c-08db6d5fe8a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notion of 'core_pmus' and 'other_pmus' are independent of hw core and
uncore pmus. For example, AMD IBS PMUs are present in each SMT-thread
but they belongs to 'other_pmus'. Add a comment describing what these
list contains and how they are treated.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/pmus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index e1d0a93147e5..8c50ab8894b7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -12,6 +12,21 @@
 #include "pmu.h"
 #include "print-events.h"
 
+/*
+ * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
+ *             directory contains "cpus" file. All PMUs belonging to core_pmus
+ *             must have pmu->is_core=1. If there are more than one PMU in
+ *             this list, perf interprets it as a heterogeneous platform.
+ *             (FWIW, certain ARM platforms having heterogeneous cores uses
+ *             homogeneous PMU, and thus they are treated as homogeneous
+ *             platform by perf because core_pmus will have only one entry)
+ * other_pmus: All other PMUs which are not part of core_pmus list. It doesn't
+ *             matter whether PMU is present per SMT-thread or outside of the
+ *             core in the hw. For e.g., an instance of AMD ibs_fetch// and
+ *             ibs_op// PMUs is present in each hw SMT thread, however they
+ *             are captured under other_pmus. PMUs belonging to other_pmus
+ *             must have pmu->is_core=0 but pmu->is_uncore could be 0 or 1.
+ */
 static LIST_HEAD(core_pmus);
 static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
-- 
2.40.1

