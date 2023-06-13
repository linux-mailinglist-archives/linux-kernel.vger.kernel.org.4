Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B502772DE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbjFMJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjFMJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A0AC;
        Tue, 13 Jun 2023 02:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye9CjcuHvzkt1UajV0vILjWw9u+mMuBxyKvJwFrlXSACb8jedkuEXIdledBEta0t1Fmn8hSAdk3+rAZY1EOXvNm1Av7LZDw7dJJOghXVXsTStq+X72SAbRDO/yIqb7N0k921IHNLaOhp5pKVguWs2b05t6/bL6SR8cV4zmXfXfq7xU6N2l2jyVdp3EYCibK6C+rGeeDn09Sf8UGfHl2x20k5H4HQqgkFmeFiVV6d2eyeLR7Hz6ULk30uhqO31Q+dAqFtbtDh1BILFB33RuVN7/9L3DlPydxFbp1Q72ELnch9u9QSTiwej4JSteb1ER6mRePqS56Yus3LV3c1vRVAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50vvT41NwDLxyhkBq1NDRLwAEesxjaNVxn51b/c3rug=;
 b=Hh3iyCCgKx0Wl8+afpkQK61M/FSJ1tK21V0YwfFrKRClgJyiQcTSroesDiBsECcDRvE4umSAxWVm6VqBE0qeuyg6E5HQQE0aeE1AaBt71nEk/1e+T2rTmCYSC4IAqxgKAYgAGlqLHN8WCH0OzNsaBXtxOS3rPRbneNMKLRfppb1celxsxmsrxiTk4EHjWWFftG8hDM1FsjF9gJ/A5gv2HFVDep/3dAZgKWBwSEKBWfRCb+nJGVGLOpvN2FxgxESFW41EloAa0NV9mShQz3Bi7DMibdWM3rc8dWgGpCtuvfaSiirgeat6IaNXdn/bLAKdVIuGYCqUuY2HaqCEx52ecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50vvT41NwDLxyhkBq1NDRLwAEesxjaNVxn51b/c3rug=;
 b=JTsrGqxsoBD4AT7VafhEWL0HJXhghGOig+KWiZAt5s0PNPLqMgSh4UotS7mWucgL3e/O5Iq7ChB+IzbMLbV7aYy3R2RtepqicMDRY84k6tBpVbtuNw50m1fqqqEFdAgforLzDTHPJZgUwtWnpGE1teBUWCb3cW5pr9+qrtgq0Dc=
Received: from SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::15)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 09:56:06 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::1f) by SA1P222CA0126.outlook.office365.com
 (2603:10b6:806:3c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 09:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 09:56:04 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 04:55:59 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <alisaidi@amazon.com>, <leo.yan@linaro.org>, <maddy@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 1/4] perf pmus: Describe semantics of 'core_pmus' and 'other_pmus'
Date:   Tue, 13 Jun 2023 15:25:03 +0530
Message-ID: <20230613095506.547-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613095506.547-1-ravi.bangoria@amd.com>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bbad3a-4b32-4eed-c16a-08db6bf46719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lrXD6XhbAkaC8nAX71aqCcDyYSMdlkGM1ESYPQvG1zxZQ71h+09PoL55TozS0n+WBvHEGPsoPpaWDdA0LR1YTD6m/FvN8NA2F4McBcauGoxx2kBdJYHCKYiTShMPZfO7j4tP4kYiQKyNOI3o6bJDnDtO8wmsrz1gldoFD+HnViOLtm0C/HG0UFEVYV7jp1ifppHwfhNwdHqQghKAFJw2lhEYeMv6864gbLUttaqFx9FgDidjDniFxcm+dp+InhiuyGM3ahXhaYqSRmopU9ZAVzX0F8X5wF/wGqOf/yX0RUAVdmxs+l0Bf2cSwmVn0BgeHRGpiq703iFNKV53a6kcAKJxjaZmSJ9V/lKHVvwOD5dWh2hpWh+TEHC8/s+E5LEAeEJ3ZLntsq8Nur2E7Bue5sEChEE4OSZO66nRiTywmJ/pElX4FwwOyTHDLIu3gzm/ooTML2USN4JLEo5ydXzydlBaNu9DHYVva2uUdhNksM/gtRoOksUnIXQeen9hCfqR25RKfONrEeYwuho4vX4wcZKRPGj0l0ub+qPSpsizEol2lBRTb96IgkqwAar1xkRpsRsMbjFWb9qnhkIuhWTH1JFzf0evbNRJdsyA2WoFTe6C4NVatu0q52Cz/HnocgJpcaMeEd5IzbjTWwY5EQq8ujm4OouUYpKMH5Bx5oMzOYxfBwjvmujRR8xQtNYxkhtUfF3mRzywWPrTc/dIJSLDpzDxWIPVMCYbGALSAuRFLzbqYAC6unGYNyKx3YNOuXHp/ACzAeMAPY9oHGq/RNpkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(356005)(86362001)(40480700001)(82310400005)(81166007)(40460700003)(478600001)(82740400003)(41300700001)(54906003)(6666004)(5660300002)(7696005)(8676002)(44832011)(16526019)(70586007)(4326008)(2906002)(6916009)(8936002)(7416002)(316002)(70206006)(2616005)(26005)(1076003)(336012)(426003)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:04.8209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bbad3a-4b32-4eed-c16a-08db6bf46719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'core_pmus' and 'other_pmus' are independent of hw core pmu and uncore
pmus. For example, AMD IBS PMUs are present in each SMT-thread but they
belongs to 'other_pmus'. Add a comment describing what these list
contains and how they are treated.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/pmus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index e1d0a93147e5..e505d2fef828 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -12,6 +12,19 @@
 #include "pmu.h"
 #include "print-events.h"
 
+/*
+ * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
+ *             directory contains "cpus" file. All PMUs belonging to core_pmus
+ *             must have pmu->is_core=1. If there are more than one PMUs in
+ *             this list, perf interprets it as a heterogeneous platform.
+ *             (FWIW, certain ARM platforms having heterogeneous cores uses
+ *             homogeneous PMU in which case it will be treated as homogeneous
+ *             platform by perf because core_pmus will have only one entry.)
+ * other_pmus: All other PMUs which are not part of core_pmus list. Does not
+ *             matter whether it is a per SMT-thread or outside of the core in
+ *             hw. i.e. PMUs belonging to other_pmus must have pmu->is_core=0
+ *             but pmu->is_uncore could be 0 or 1.
+ */
 static LIST_HEAD(core_pmus);
 static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
-- 
2.40.1

