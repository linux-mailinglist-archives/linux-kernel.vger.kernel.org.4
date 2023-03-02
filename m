Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1B6A7D95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCBJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCBJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:22:53 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E43E614;
        Thu,  2 Mar 2023 01:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e63IN+bELbOPkt/ncHiQl1L2xQ4RmTd7aAwp/5Jd3cPk6RLGd58fi4jVzK0cH9oLCK5Cxq7Bn0FdzL0Z7YlDko56B2TGzZUqpsqrN1Aq495tk+hBXv/1VvfQQFOjJQM6T+6eEIS2vOMrdZLPTW+LQeQm3A7Abw8mG5SK+0TxhVTh+3OyDFxf08wi7UVG+eL55F5TBSxD4anO5xEitM78YtW30RZwT7+Q/u79Akb+LB1s4Yrc5I+FSZfB/jIDxeQSoX14dZoIp+L3LXHE5CUpR+3AAgkqdwsdzZ+IQNkf6oYHZVvnr6Ssauy39HR43XqUHbht55NIigIe/pWZqJ4hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6a+Apy4xxR9XYjqfByndDkuEWQOiLwBPCKBI5f3uuw=;
 b=Q+pMzfqbN3YoxVhK7xu7kY2P3RFyXJlkMpVE7YTlNjLOtVPavep9sGmt4w0hcqT9S9HM/+toyuM3zvNbM+jvgPFPASYX7nJ0vKLkwnJFdOQ6rHVDRLNIDpp9d3DEDILprmH1f9RamahHqFb2PAB+fDoc0OFuQr4us/RfJ3Ii5rmzeAl3NKYvQMSY/HGpIHa73yAp/x3gfZhq6v6XoKcDDafrBWfW5YT/u52i2O/QKTZLAUDFNM4sXO84a2VbmxKtWm8za+vieHqgsVnJy3rrhRdOczOouTjLaTy4GBRLSbWQAAtvsW79j8AdMZD3UXNGNzPS6HFNu4LAJ4cCt3OqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6a+Apy4xxR9XYjqfByndDkuEWQOiLwBPCKBI5f3uuw=;
 b=JshIImEEqltggfivLsZwUwY9Rs1DH1BVSjy5PBJVtUYZIs+x/51rj3E2MBAw4AF8vxBUNHt+Bl2kqvgzlwFPf70eqoiXhNC8Pmz6S/VG67PhxwuagUtdYw4n2fX3wEowZGWWhgTQ/RAPdHbDZn480bFQKj2jMp+vI0ZEyyrZQOI=
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:22:17 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::aa) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 09:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 09:22:17 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 03:22:09 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <eranian@google.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 1/2] perf/ibs: Fix interface via core pmu events
Date:   Thu, 2 Mar 2023 14:51:08 +0530
Message-ID: <20230302092109.367-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302092109.367-1-ravi.bangoria@amd.com>
References: <20230302092109.367-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d259315-10b4-4706-dc1e-08db1aff9dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ESSR1cAhX+JvDxK2cT6Wic6EgtszBFD8hgs5YqqC7ktBDSe4VXOfkJypdWv5bxt+I29smlepZRs46SR+YKf4d8Ixk5z7bVrXSdRcYlLBZWerTtgmiM2e/1bRVM6LIiEVaVhU0AZbZdw9XdA+Efa+QkIhrKF98a2mBy0UXvuKdZZ3Aaxj9li+DXge51acc32J86QsEr2faDJnyXG0Qv+2KkFbFVepvVgNHGkdVaDMxDXG7GDMKoTqvvn77ujBvo/sxeCZ90cj4VhuhXYZXGG9W2HCYCJY0tGVU1FOyKKitP93FvB5iX3u2gnOn147L05lTV7Wh/6Lu0pGw50jMLf4dSZbIJ5pczX6dct2YKY5C/RuVGgHi+M2KVNrHLPLUzOPXRxw6U23HIKACE6Miq6F95XWLwDs9BFwtsy1Z8hv4CXX1IlO5lU890YRGpgIIXrwvLwiFHTHXKnYg5T9vM7XUQWCen+N/cTJd0WLo7fHW9Q/w+Cd4N7DAs9BAD+dzyzaUnd1u37iX+ZSMq3voQTRv4oM9uNM6QLd3rf4BHPaCmPFfN3Vrvo0BBuhb6EfMwXyeInVrQL3v+rK3yP7v/HEc4uQpolGIET35wmG+m/anIS4O0CEQD0JlyAwUvC1FsG2indpMdpvdKNZBDzun5iXmG8cBTO5h08GaXnBNF4KyMs4ll3rmQtRHDqDM0Kiu2dWnREREfiYf+GAnwESr7e3soLxCoM/8W7WEiA2c2u6MU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(83380400001)(426003)(356005)(47076005)(86362001)(40480700001)(36860700001)(81166007)(36756003)(82740400003)(82310400005)(7416002)(8936002)(5660300002)(7696005)(2906002)(336012)(44832011)(41300700001)(8676002)(70586007)(6916009)(478600001)(70206006)(4326008)(54906003)(316002)(16526019)(2616005)(1076003)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:22:17.1247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d259315-10b4-4706-dc1e-08db1aff9dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Fix it by introducing new pmu capability PERF_PMU_CAP_FORWARD_EVENT.
Kernel will try to open event on other pmus if user requested pmu,
having this capability, fails to open event.

Without patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  Error:
  The r076:p event is not supported.

With patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]

This new capability does not have a notion of forward pmu mapping.
i.e. it doesn't know which pmu(or set of pmus) the event should be
forwarded to. As of now, only AMD core pmu forwards a set of events
to IBS pmu when precise_ip attribute is set and thus trying with all
pmus works. But if more pmus start using this capability, some sort
of forward pmu mapping needs to be introduced through which the event
can directly get forwarded to only mapped pmus. Otherwise, trying all
pmus can inadvertently open event on wrong pmu.

Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c   |  5 +++++
 arch/x86/events/core.c       |  2 ++
 arch/x86/events/perf_event.h |  3 +++
 include/linux/perf_event.h   |  1 +
 kernel/events/core.c         | 11 ++++++++---
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b198b62f..f4c67362cfde 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1264,6 +1264,11 @@ static __initconst const struct x86_pmu amd_pmu = {
 	.cpu_dead		= amd_pmu_cpu_dead,
 
 	.amd_nb_constraints	= 1,
+	/*
+	 * Raw events with precise attribute set needs to be
+	 * forwarded to IBS pmu.
+	 */
+	.capabilities		= PERF_PMU_CAP_FORWARD_EVENT,
 };
 
 static ssize_t branches_show(struct device *cdev,
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04bf80e..3f27b44f337a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2156,6 +2156,8 @@ static int __init init_hw_perf_events(void)
 	if (err)
 		goto out1;
 
+	pmu.capabilities |= x86_pmu.capabilities;
+
 	if (!is_hybrid()) {
 		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 		if (err)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d6de4487348c..41e792bb442d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -941,6 +941,9 @@ struct x86_pmu {
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
 	u8 (*get_hybrid_cpu_type)	(void);
+
+	/* Capabilities that needs to be forwarded to pmu->capabilities */
+	int				capabilities;
 };
 
 struct x86_perf_task_context_opt {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..4459e0918e28 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -292,6 +292,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0080
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0100
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
+#define PERF_PMU_CAP_FORWARD_EVENT		0x0400
 
 struct perf_output_handle;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a5a51dfdd622..c3f59d937280 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11633,9 +11633,13 @@ static struct pmu *perf_init_event(struct perf_event *event)
 			goto fail;
 
 		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-			type = event->attr.type;
-			goto again;
+		if (ret == -ENOENT) {
+			if (event->attr.type != type && !extended_type) {
+				type = event->attr.type;
+				goto again;
+			}
+			if (pmu->capabilities & PERF_PMU_CAP_FORWARD_EVENT)
+				goto try_all;
 		}
 
 		if (ret)
@@ -11644,6 +11648,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		goto unlock;
 	}
 
+try_all:
 	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-- 
2.39.2

