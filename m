Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61E6D8495
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDERLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDERLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:11:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9AE41;
        Wed,  5 Apr 2023 10:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3T6PUUaHYQ3DKbfl7KmIigtsD7R9fMhTIh+D/CdU6T0EwPEC+rk42bt1RXX6pDD+LiTf7OjqV2vCEIXUU6qZcmUesywpJiBC8GO3kuXtFNKhbpXn9BSFIs3Dx2gj6xAnr3ju7jrO6SepyD6wH7iG0K2o2TQomYh1SCEanzE1DSUr4PoYPx7cgcDEy08rwCVLXRQz83phY3xK/BPyGN63Mfc1aMKGGWaYxhCfvXp5/zkA8ctmqwBM8kILPGKd4xYhLsdG5otb3vNjCsdWwGzSB1+Z9Z1gwWaF45FFETO4+s/RtyTs8P48AguYkyxniOIaxN43Bc7kW/BSYjtJ9l6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw/UkqzM/nfWdUW1S/607qN2PLx+HL7/kXnBiDGew+g=;
 b=cMp9MVo+HZi6IjOSEhQ7ohdoKO9mo83PgvpnAmCWHh2dC4+fY1/85l9wbxaG47WaKnWsuKoXVRQeZUd5msPqJlcSywAHX4IC9xwWvoKyZziCWjgFDUygYUpxcfD9ME/My1EbspFHmTFdfCDCobldKLQNajGbmNa8n4dCH5LLPUKo8MHaVwRf16PLYUH5md8saNqCWdVsZ7di6D5t7odCu/Fa1dCm1QW2hVCMLmyC3ln2M29bZQaTNTiXr6mepL9f+gYMjB3xiWOOaI/vfjxCgYgnf16rWf/diSSO2gZ1BDyZpSnaNHB0G2cWpsjgq1rQMyqQqCN5MLXavntnftWFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw/UkqzM/nfWdUW1S/607qN2PLx+HL7/kXnBiDGew+g=;
 b=KCEWCVeoa5ZSEjvz8Lqt4HI76FyWxg8RzmNXcHu2mCQy/b+YtClK9xIBf5rRUwgVidmHQCPqIHA9t75ugBeI/1gYxx+SU53MyCachs9rL3oeoVyh4qYT+3WOH/+4B2Idrcz9B1cPpYWm4cT2K6jsWeJlbd+pafR0OLQoqTGnWik=
Received: from DS7PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:3b5::10)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 17:09:51 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::4b) by DS7PR03CA0035.outlook.office365.com
 (2603:10b6:5:3b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Wed, 5 Apr 2023 17:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Wed, 5 Apr 2023 17:09:51 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 12:09:44 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <puwen@hygon.cn>
Subject: [RFC PATCH v2 1/4] perf: Read cache instance ID when building cache topology
Date:   Wed, 5 Apr 2023 22:39:03 +0530
Message-ID: <20230405170906.2510-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405170906.2510-1-kprateek.nayak@amd.com>
References: <20230405170906.2510-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|CH0PR12MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c157ac-bbc9-48f3-56cc-08db35f8918c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNz5ky2JXWcD6xf65ivUxi6HP827aPfVJreU7/ceFkmKhTOpRdfsParctcYY7GnLTZHMr/Go0obXG20S1OP2tH3ctMNxR0NfE2jX8noK1FgQ1iH6E7OoSYL7zLQ5xkWcFYjdl3VW3dzxLBcuJrWhmFZdQLCjJfJM+QL+sfAh7vGP48eiJWW95XcvDIuGuP/1GAZ7vzYwk1RL978e0U9Kqn+VKJJ5cfElzXfbP2bbvEbnc+1gmzXZjzvdto0Jg00Z4haEWgv1Wq0SxvtIdrF1kMkmURyMw/05wjrRlduiDHNLbbuILhX/2fRXOcin9Gl0M/nrv1DzTRKs8HloX4kJBqtRhPBYY8hViho5kqoRA4Upj8WYxfTgUWzr5z2nvPM5dKzBi8w6S+Rp9DxGAKAZmL9f7VjczCIvHHZDPlxMIun920t9lIWPWtA0XcOPlCNySFx8kCukGdaOy3PqBvCuSJdJBNNe4J3tboUMhJ43nZvxgKSurgMyfhK2SzSwnGOl8EvCWyW1j/oKu0HeNuS5tBqglcNpAwpaKkq3ENdSoS9zXEvuIBIOFN3KiziweKKiIhKGPLJoyi8g/X/69sKcO69etDBT79UwFfPj5XW7n474MotJPatbt9lqF7xo1TWuLRrlBOc5ZiUhw8mtKRg1wQVMOujw8d1vDfmuzOwmXIchp1B0kWLozUrBsv4ukE6nGTRHRxGJagOw/rJyOGGfsowBHivFhNIGzGmZlPEsgXPnxIeRwoz1Pa6rog/NPa+l
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(82310400005)(107886003)(16526019)(186003)(26005)(8676002)(1076003)(426003)(478600001)(336012)(41300700001)(2616005)(70586007)(316002)(47076005)(4326008)(356005)(7696005)(40460700003)(36756003)(82740400003)(81166007)(70206006)(54906003)(110136005)(5660300002)(7416002)(86362001)(2906002)(36860700001)(8936002)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 17:09:51.2331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c157ac-bbc9-48f3-56cc-08db35f8918c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU cache level data currently stores cache level, type, line size,
associativity, sets, total cache size, and the CPUs sharing the cache.
Also read and store the cache instance ID from
"/sys/devices/system/cpu/cpuX/cache/indexY/id" in the cache level data
on kernels where the file exits. If the file does not exist, id will be
set to 0.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org> # Error Handling
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
o v1->v2
  - Handle case where the cache instance ID might not be exposed so perf
    can continue to work on older kernels.
---
 tools/perf/util/env.h    |  1 +
 tools/perf/util/header.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

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
index 404d816ca124..a938738f8775 100644
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
 
@@ -1157,6 +1160,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	char path[PATH_MAX], file[PATH_MAX];
 	struct stat st;
 	size_t len;
+	int ret;
 
 	scnprintf(path, PATH_MAX, "devices/system/cpu/cpu%d/cache/index%d/", cpu, level);
 	scnprintf(file, PATH_MAX, "%s/%s", sysfs__mountpoint(), path);
@@ -1168,6 +1172,16 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	if (sysfs__read_int(file, (int *) &cache->level))
 		return -1;
 
+	scnprintf(file, PATH_MAX, "%s/id", path);
+	ret = sysfs__read_int(file, (int *) &cache->id);
+
+	/*
+	 * Set cache->id to 0 if the read fails. This enables perf to
+	 * work on older kernels where the id may be missing.
+	 */
+	if (ret)
+		cache->id = 0;
+
 	scnprintf(file, PATH_MAX, "%s/coherency_line_size", path);
 	if (sysfs__read_int(file, (int *) &cache->line_size))
 		return -1;
-- 
2.34.1

