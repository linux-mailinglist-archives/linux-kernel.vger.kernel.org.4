Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCA6FA27C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjEHImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEHImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:42:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A449C106
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3dau9NZQA65e3ZXs1Pf8nmC4wrJMBg0ZeyKmaoTb4ONtJ5KHbPDT4fGW2Wji4Sc2iUeY6fzs+OwOPa0djdqq6P8k9desU9XzfhredxOIFKnezpJzS9aYSRH9Zjhlkd0Mpe/YR/L0QyzLa5HUAe4e6HQbwHz+HDNbXovqPHhKr9Okw22q+zVj6QwLRvczS36LoItY0Nkue8aQEmjeFUnJLNeudrDnsxAzwAwWxw/QmiPugFtR7d8vDDIv0B6YZBhPQ3Mrh0CrZbLRJHeXstK8LWOQ3hzGgRIFldM2vGliW2cTMc65d+nW0nq+WmLdZ1QxWR5Lse7VKldp8Wj/9RJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxs9iZYoPs7rKu1hF4Uk7jh0uZRFQVJdzdvBdXvsJjA=;
 b=bixLojfHlMMLgr+cuLvvHsTNDZaklbYE5k7gSH9ZQoTBOfeb5jqBzWgL+VSp5a9NNpELY4eCdEHomYHCAAY0/YMJMx9VWWPWKAkrIOyM1LqIFzDBKyvTvOcm9CgE18ynNvwPoaZtPo8aVnkcjsPbaq4M+LRrFOrCO46sCCpSzfcAFUB/RRXYyf5DgQ/s2/O93Zsy0NB2x1YbmvjvZq744szH73woyN0kG95nYRPQisDHbqi67gsaMzuoT7EEIRP8oqIZR75X6FceTfgAmQK+Tq5Q+fkVxNzOygFnyVXiw1BTYAfd6JWm4PE2cPJw4d8EvRaicSxoVBd5Inb8J4Xokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxs9iZYoPs7rKu1hF4Uk7jh0uZRFQVJdzdvBdXvsJjA=;
 b=HfJX41zHgL6rz6SSMAsH59v357FeAO9UsG8hLrPikOsjZeq1kDZ3V7dB8eHOOdeNRsT+nUlTBRCBrxp7yscawE+d5059iMGYP6rlG34MTeqcj/0oQEaTiIW5jY8RtTmItcfYkIAOuV3t0jgYOe5Rjajge6rLrrppHa1WgKlkUMM=
Received: from DM6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:5:174::29)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:42:08 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::5f) by DM6PR21CA0019.outlook.office365.com
 (2603:10b6:5:174::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.4 via Frontend
 Transport; Mon, 8 May 2023 08:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 08:42:08 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 03:42:02 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <yongxuan.wang@sifive.com>,
        <pierre.gondois@arm.com>, <vincent.chen@sifive.com>,
        <greentime.hu@sifive.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <palmer@rivosinc.com>, <puwen@hygon.cn>
Subject: [PATCH 1/2] drivers: base: cacheinfo: Fix shared_cpu_map changes in event of CPU hotplug
Date:   Mon, 8 May 2023 14:11:14 +0530
Message-ID: <20230508084115.1157-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508084115.1157-1-kprateek.nayak@amd.com>
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 649e920b-7ec1-43a0-df88-08db4fa01bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2+XnUYRWsonQWpbVhbAwonz05O9DwtLtEgwagHZmJe0jNWgsFeCYwkmnFupzvUzzld3whVssmTAJ8iSrWiiMam4Ckk1PlSC/tBb2UEnZ6mt/WiCjI/kmWBdSuEQZFeldg4RGt1qefe6BUPdULve5m4L+nYzq9qTerQvJQ3uCeS/XDJYdbEqNqq+QS0VADYhh3+H73VKnN7ZTSfn4eC+kYaq7gemt06v4HqK7AXcgUS8ba3c5yeeE51QvNyGPXpJrbmDORL/zwZYRfcq4uUWDPESjYMu4tq75J7HR32WLfiABonwA1nyEF9DG11InNB3VW5jsO7qqa20k1zCH/UzxGlUAmdukqdkFHUXoTHw4XFxyJsoqHKCPxyaIJkcQgCnwAfYELGM3ll6mChFStZ4+3Ai7L3SaRENYPUKqKc3Vd85ndt2s2veKexR/3hspeAfnaUOY49IT0qRLM+DgvibVyLsUxCXqtdRrbpLt1WOgJ1O+30dXjmVZ8fZ5G0+ODZs53otc3ZUvjY1pmxefF60YKFyh+qY66yttrKVBH054Jk0cijgWE/LlUQ7ocOQywOjqbAJltZTWnddaSBfYmQfv5GS7N1N2iR/XNuAvD/kK5gyl3sB766Frp3A/Mmj7mwUdVFrw8tbZ50W++CWsU5t3p4FpRaRaWbRktYs9RLXp15W0NZK0w/ErTjRAYZL7wcK9n0ExDE0nGmEaVOnn2L/vduC206w67oTQaZSYWlwJIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(6666004)(54906003)(316002)(70206006)(6916009)(4326008)(70586007)(7696005)(478600001)(82310400005)(40480700001)(8936002)(5660300002)(8676002)(2906002)(7416002)(41300700001)(356005)(82740400003)(81166007)(16526019)(186003)(107886003)(1076003)(26005)(36860700001)(47076005)(336012)(83380400001)(426003)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 08:42:08.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649e920b-7ec1-43a0-df88-08db4fa01bdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building the shared_cpu_map, check if the cache level and cache
type matches. On certain systems that build the cache topology based on
the instance ID, there are cases where the same ID may repeat across
multiple cache levels, leading inaccurate topology.

In event of CPU offlining, the cache_shared_cpu_map_remove() does not
consider if IDs at same level are being compared. As a result, when same
IDs repeat across different cache levels, the CPU going offline is not
removed from all the shared_cpu_map.

Below is the output of cache topology of CPU8 and it's SMT sibling after
CPU8 is offlined on a dual socket 3rd Generation AMD EPYC processor
(2 x 64C/128T) running kernel release v6.3:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu136/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu136/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list: 9-15,136-143

CPU8 is removed from index0 (L1i) but remains in the shared_cpu_list of
index1 (L1d) and index2 (L2). Since L1i, L1d, and L2 are shared by the
SMT siblings, and they have the same cache instance ID, CPU 2 is only
removed from the first index with matching ID which is index1 (L1i) in
this case. With this fix, the results are as expected when performing
the same experiment on the same system:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu136/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index1/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index2/shared_cpu_list: 136
    /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list: 9-15,136-143

When rebuilding topology, the same problem appears as
cache_shared_cpu_map_setup() implements a similar logic. Consider the
same 3rd Generation EPYC processor: CPUs in Core 1, that share the L1
and L2 caches, have L1 and L2 instance ID as 1. For all the CPUs on
the second chiplet, the L3 ID is also 1 leading to grouping on CPUs from
Core 1 (1, 17) and the entire second chiplet (8-15, 24-31) as CPUs
sharing one cache domain. This went undetected since x86 processors
depended on arch specific populate_cache_leaves() method to repopulate
the shared_cpus_map when CPU came back online until kernel release
v6.3-rc5.

Fixes: 198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared caches at different levels")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/base/cacheinfo.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index bba3482ddeb8..d1ae443fd7a0 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -388,6 +388,16 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 				continue;/* skip if itself or no cacheinfo */
 			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);
+
+				/*
+				 * Comparing cache IDs only makes sense if the leaves
+				 * belong to the same cache level of same type. Skip
+				 * the check if level and type do not match.
+				 */
+				if (sib_leaf->level != this_leaf->level ||
+				    sib_leaf->type != this_leaf->type)
+					continue;
+
 				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 					cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
 					cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
@@ -419,6 +429,16 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);
+
+				/*
+				 * Comparing cache IDs only makes sense if the leaves
+				 * belong to the same cache level of same type. Skip
+				 * the check if level and type do not match.
+				 */
+				if (sib_leaf->level != this_leaf->level ||
+				    sib_leaf->type != this_leaf->type)
+					continue;
+
 				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
-- 
2.34.1

