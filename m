Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFA6D1671
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCaEwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCaEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:52:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBEA12BE4;
        Thu, 30 Mar 2023 21:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN09B38D24OAh0R9LSJP9XSCW62yfgMP9pvwKDeXXqFLoznFo0xQhkOuNV0RCHuNX+WWhQPu4wKuvW5urNEx5kWY0ULLXBvq4iNL8gfJj93yDzkqeWMjO6uX7UPN89yUucc+p8CNHjExzxtbXvpittHohKnaIhh5nkz92IDDP+sXWvkM2NqMzLqppQZim6X5kJfCjfgljW0M7NPWNXvIn2oaL6DwSU0AG0ATZ/DXTSnh/P8RbIX10nFqk7pAlTcMVd3pnOEmLOW4CQen4UQeEpU1GQooVeuoZHuuNyXo76xW2ya6wuTP/s88TElNyPuz8bggcW022ruNti/94PBprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j/XYAlV9n62TWN1Qg3lNll2FXzjQKFmsH2WErFF3Do=;
 b=LhkpH2KNDvAHnErypK6m9iXFIzokj2uFGSDcAcALUm0B5RQ1Nb/o/XiYTW7TJGNNHutSmiTCk/3N8v5Q+jxaQuDYm4RfwiGrUFGrJBlv93AfyMrY90mNkvjLIVfMc0iHU6sBZO8N4bmer1Co0xk1tOZGraRwXFTn5po7vvOpSgYKIMEc9Vy1VRKjywKIWRheosrzsszeifuOyOSZv+05DEqpfvmOkoZLQ2Mgf8b5Gr9xLj3KoMymwz6cozuLmVscb1KUIh0wevOPy1jW9jQMKb4FMESR3CxYvtmJxKnFpWK3uPHAr+uoYbyRoCW3zUInqTWB6zxnb4khKpnR548EUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j/XYAlV9n62TWN1Qg3lNll2FXzjQKFmsH2WErFF3Do=;
 b=yLhXb96b3AbWeK4edNoGZPrp5I6Ltmz+gkQpDC3LNXvAp6UYttApYrSpiSAyS5IlhfX+lh6qv1qgJEiK5CRR3F5bxLPXzUDUMmn/OEj5AB/vrYHjeA/lP3v7JQrge60aRSyqPQHtfj8krRVB66sQei87gfLSI4HoJLStRM2LvHM=
Received: from MW4PR03CA0260.namprd03.prod.outlook.com (2603:10b6:303:b4::25)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 04:52:36 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::71) by MW4PR03CA0260.outlook.office365.com
 (2603:10b6:303:b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 04:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Fri, 31 Mar 2023 04:52:36 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 23:52:30 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>
Subject: [RFC PATCH 1/4] perf: Read cache instance ID when building cache topology
Date:   Fri, 31 Mar 2023 10:21:14 +0530
Message-ID: <20230331045117.1266-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331045117.1266-1-kprateek.nayak@amd.com>
References: <20230331045117.1266-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: df257f75-de20-490e-3d50-08db31a3bfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aG+txpsj6KyyxxxLGiUzVf2Ew7b/VDSe0vMb4lwKZPTu+XkmWxDo5/ocIy4Kyg1zdaQkRPUbm/pJnmIit2gZnymjsQkb1tUMotylP2Q7N6Uq+ooR2eY8qft5vywUXDMVMg44Yq5gCt+I/ITSY8qSTc51Ue4/voFhl3LPdcs1NLcpfUujEXCrnG8lYRzfI3tAjBpQZAPdInrcafOt2STEw22te0X+nUClMMUGVeTVWwjNI45/IkVRyYLrXuI28toaQumX7lpmwo/cxqJ56r+wH74gEgVdIyq3vOZOjToX/iKmX9zT7BWgmS7QZlMasKK01AJiXeQPC926966jRkO7Wo7KZXbUPslLyBzkuRtLXxZzEzbuHX4xhPkeZWT9wWvXgCfgs5diZVdc+ci5O+jLRXk6aTc1vhEZVXl/cRegOyviNaq8eqc9JOxSpG2Zvqws/PkUA2x/JVe3zPYcecZQz5VTr263L30MEfWK0dVyONR0dqyn3KmWE5qnzSXjD4CuUZldePMC/7Jv0w8nyzSik+QVR1tSEoVlAWo8QXgWUnl4hcmdX4Soz55X04XgbPkOGYiKUJIuTBmqILKPd03EICj8Xe9QMn33EkAAfB8aYWy9nWCAi2bBulRNrgZyDRPzNmRoV9tXutCPlBLY2PpECAmt75xBYyW2WH/iO+MqjMdvHYyD4sApUEBdOzEa84+wFJXWKCFmfHYqSIhBiXbOsfLQlzGUfp6oUPd3a3k1SPzhu3cCmzaUoOK3feKRoKh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(8936002)(81166007)(356005)(41300700001)(5660300002)(7416002)(36756003)(82310400005)(86362001)(40480700001)(82740400003)(7696005)(1076003)(26005)(6666004)(54906003)(478600001)(36860700001)(2616005)(426003)(336012)(47076005)(16526019)(186003)(4326008)(8676002)(70586007)(70206006)(316002)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:52:36.6726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df257f75-de20-490e-3d50-08db31a3bfad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU cache level data currently stores cache level, type, line size,
associativity, sets, total cache size, and the CPUs sharing the cache.
Also read and store the cache instance ID from
"/sys/devices/system/cpu/cpuX/cache/indexY/id" in the cache level data.
Use instance ID as well when comparing cache levels.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 tools/perf/util/env.h    | 1 +
 tools/perf/util/header.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd9..d761bfae76af 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -17,6 +17,7 @@ struct cpu_topology_map {
 
 struct cpu_cache_level {
 	u32	level;
+	u32	id;
 	u32	line_size;
 	u32	sets;
 	u32	ways;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 404d816ca124..5c3f5d260612 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1131,6 +1131,9 @@ static bool cpu_cache_level__cmp(struct cpu_cache_level *a, struct cpu_cache_lev
 	if (a->level != b->level)
 		return false;
 
+	if (a->id != b->id)
+		return false;
+
 	if (a->line_size != b->line_size)
 		return false;
 
@@ -1168,6 +1171,10 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	if (sysfs__read_int(file, (int *) &cache->level))
 		return -1;
 
+	scnprintf(file, PATH_MAX, "%s/id", path);
+	if (sysfs__read_int(file, (int *) &cache->id))
+		return -1;
+
 	scnprintf(file, PATH_MAX, "%s/coherency_line_size", path);
 	if (sysfs__read_int(file, (int *) &cache->line_size))
 		return -1;
-- 
2.34.1

