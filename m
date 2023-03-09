Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EF26B20F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCIKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCIKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:12:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B678FE63CE;
        Thu,  9 Mar 2023 02:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hecRw/DP21YIvdI9nhFD0pVSIGfM21k6Lf3PrXYvpaXk0XWWmaM+ZumUYx7Iuym24/+bLoQN9rme0NdAHrrXjhv0aew5GDUKtYddLRRMEv8QPHxLrEk4g6Ai5Jc2RZG1mDrWUkn60xcnr+8e57OBTt1nENVR38EY97pFxvP00jfLV9TmpV/q2WTdoKnjtGAv5J62+wtQiVOvCyquYtJ6M0UYHrvsF0SfaUBrYdZh73dCexBQeGmM9BSkfJB9MjwbqNWt4rL/4gw8cubCW0g2C7OcpAnJq9ayoQB1nm9E36Ipv4FNbwc8qIkK7Dz21IDOXq1cqj7YeWHjx+uKWVjlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXFNOHaSqp2WhZvg3ozwniSBg72BBUMaMUTA+Aikp5Y=;
 b=NmBIGWRZ+2Sz6yu6Mv+fHILggoiFswVGB7MqDWWkU+skargp0E2KIaLyqGWDKEJPttNsDENvFNvUO/tnsSXyWUUxwAYySwybfjqZhr4XUYHnrSCNz78ErxCftZLjAyJhhJ7cbjIcRDV7bVKzShROAq3wG5s40DW4NpQaPTWlpVtj+ojt6g2eKWwuksR2WLqdDAGYl+g1GMykc6444BrzNFZE2xcfvkLYiMpYiyOg5l0v62qmfLhiva6XTSY6kRJLhV9vr+29oz0Y7iwM+XMUXOdjWULnQkFeUHUc8I7pVzTW0TBP/E7nF0VUfqQFFQX/UpE28gYLo3ti5SukHdtDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXFNOHaSqp2WhZvg3ozwniSBg72BBUMaMUTA+Aikp5Y=;
 b=ZN4q0ayE8uUBoxpsH57+VAcXcChbY9zomjsTcEnPVEPlsubTbrAw7xHOz4dkzLebrmNFweW/TFe5/y2v4N59CzRx+OjT3ml6NfyP0xxe9K/6M8xQ7RG4fsJ6oRzM8zL4//Q99zCIQzlunUFe9z25O2iGTQG2wgo8DXlnoiCEoWM=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 10:12:26 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::fe) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Thu, 9 Mar 2023 10:12:25 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 04:12:19 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
Date:   Thu, 9 Mar 2023 15:41:10 +0530
Message-ID: <20230309101111.444-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309101111.444-1-ravi.bangoria@amd.com>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 021cb43f-fd76-43cf-4f73-08db2086c81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4r6qcVczdc8RfER9wfmBd0/UNaNQg7FXBPSpT8WiVr4gtzkLfqME0FLXE4dsNWi9EOMaZodotrHsWC82Ff/fbVTA5iJMEObHAS//lsxTIZcc7bJq/PieI+GByHXTZvNQFkk7BzNGXT6dN9tmpmd5wFjfNef/vHPAyTqz5CHceCeAw5mUOkA1qmfhBPQZZ03K4U0wDVAO2W8Xic+Q+XKaSRBOK78HSuu3OPJE7B7fwhT18kLXR4BJIz1zIyj1jTWzkzDe8b8mUz9ba/E+BvIS7+/m80+Wi90S9cNzFEVV/Kst5C53sjkbBfU0a+wrIDPEI0r5MQLcYm60i9I+QR4iYOGRgzbnNw86hguNMC4gn1J4XKH9yYdOz61XzOhoF5VB6poBEXfEw0ryEqFTFtwmuJvS1xhB7BDd8k4nCf8xfEK0ubaZSy4/YU9PGxLMRDjS65xMJLXZsPg4egGnT2ShKka+tVbHKOua2//s/241QrBzA9uE2rISZxz/VvwwWQC+JZvkNjsd81Hav8JrSMhBJpmQ4daq6zwcM7hkAiyNH6CJSL/3U6yfUvQvxl1b4t4dtjfxGbQf6Fu/VeSi0Ikw4LsVgw9pJE2IwsgrlvsaHYEprsBTdVbNiOKfsgogBm2npT2i7JsAe7tXmU4PWV8F3KqGJTb8nbDGOgLSoHyobqLyTl3svXGbPSWKBDq740xcrx+STNnkOiMPXQ8Cu7ensYBhemK3HB128io2NoK/5SQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(8676002)(4326008)(70586007)(70206006)(6916009)(83380400001)(2616005)(16526019)(186003)(82310400005)(47076005)(40480700001)(336012)(81166007)(356005)(36756003)(36860700001)(82740400003)(54906003)(478600001)(40460700003)(6666004)(7696005)(86362001)(316002)(426003)(1076003)(26005)(2906002)(8936002)(5660300002)(7416002)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:12:25.7346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021cb43f-fd76-43cf-4f73-08db2086c81d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although, IBS pmu can be invoked via it's own interface, indirect
IBS invocation via core pmu event is also supported with fixed set
of events: cpu-cycles:p, r076:p (same as cpu-cycles:p) and r0C1:p
(micro-ops) for user convenience.

This indirect IBS invocation is broken since commit 66d258c5b048
("perf/core: Optimize perf_init_event()"), which added RAW pmu
under pmu_idr list and thus if event_init() fails with RAW pmu,
it started returning error instead of trying other pmus.

Fix it by trying to open event on all pmus if event_init() on user
requested pmu returns -ESRCH.

Without patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  Error:
  The r076:p event is not supported.

With patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]

Note that there is no notion of forward pmu mapping. i.e. kernel doesn't
know which specific pmu(or a set of pmus) the event should be forwarded
to. As of now, only AMD core pmu forwards a set of events to IBS pmu
when precise_ip attribute is set and thus trying with all pmus works.
But if more pmus starts returning -ESRCH, some sort of forward pmu
mapping needs to be introduced through which the event can directly
get forwarded to only mapped pmus. Otherwise, trying all pmus can
inadvertently open event on wrong pmu.

Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c | 11 ++++++++---
 kernel/events/core.c       | 10 +++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b198b62f..81d67b899371 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -371,10 +371,15 @@ static inline int amd_has_nb(struct cpu_hw_events *cpuc)
 static int amd_pmu_hw_config(struct perf_event *event)
 {
 	int ret;
+	u64 dummy;
 
-	/* pass precise event sampling to ibs: */
-	if (event->attr.precise_ip && get_ibs_caps())
-		return -ENOENT;
+	if (event->attr.precise_ip) {
+		/* pass precise event sampling to ibs by returning -ESRCH */
+		if (get_ibs_caps() && !ibs_core_pmu_event(event, &dummy))
+			return -ESRCH;
+		else
+			return -ENOENT;
+	}
 
 	if (has_branch_stack(event) && !x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..e990c71ba34a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11639,18 +11639,26 @@ static struct pmu *perf_init_event(struct perf_event *event)
 			goto again;
 		}
 
+		/*
+		 * pmu->event_init() should return -ESRCH only when it
+		 * wants to forward the event to other pmu.
+		 */
+		if (ret == -ESRCH)
+			goto try_all;
+
 		if (ret)
 			pmu = ERR_PTR(ret);
 
 		goto unlock;
 	}
 
+try_all:
 	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
 			goto unlock;
 
-		if (ret != -ENOENT) {
+		if (ret != -ENOENT && ret != -ESRCH) {
 			pmu = ERR_PTR(ret);
 			goto unlock;
 		}
-- 
2.39.2

