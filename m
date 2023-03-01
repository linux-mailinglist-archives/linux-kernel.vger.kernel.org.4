Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027BC6A733B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCASQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCASQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:16:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFD158AD;
        Wed,  1 Mar 2023 10:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+m9Yf48esCqB5xDhJvtDVE6GSrUE9mpdVW6X9Ywpb8RMHJm9fXFGKpl5T+v4FA2DCCXRcUTSV37ntyNxyChGCFh7BIjCTQzQCHRccFxVmxrE528QPTO5xSGXEqO6CE2SBxhvUrTuRa5xLohSRu+Vefs5XQCQMQg+7wb0GuS76/62cFQokabfxXEYkBSZ8SitpAewFcDmpzQfEar6jdptthF/vyqU6ajem66TXdXbXzRh5Qjae4hTKTpViXO7liJtydMs0lGqLrvhL4YZjcY7q/yua0ZNIJsSXnqiFlhls2PEy0brXiFfQgrjzKX7R8LEU0uYrWa35ZPZApWnRVvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av3iifGqJWAU8Fwi4pNL1YOE3xLkY7VzhKFRBPffpw4=;
 b=TOUvWtrkJmGBYJ0aYZdIGyZO4KJQoAUgEc77Jeau9jXWRldM94VEowarCei0+mNVfUnrNt2IFarmYRaMspbCclPWVoaik+vPCmNXa6HP6uvpEyxEzZ0h+Bc9rH0nOnQdM67NbMaT5LflA18MdpC2ebd4u+GTTAmJeGg3HhC+3y3nt/yjRcV2L8+Gjmly0Bzt0noTdPwVm+RCYp2ybM2LoEnrKoVt1mNhxDIVq158nukJ17on86XVUafWLT26KmK56j2k2oWYIse311E42XjhBChG0FASc+9QBiryO6zycubmzFw3GgtaMZiQxaLcbImLWLJ23n7PMowBepiRQ0Az5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
Received: from DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 18:15:57 +0000
Received: from DS1PEPF0000E64E.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::fa) by DM6PR11CA0054.outlook.office365.com
 (2603:10b6:5:14c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 18:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64E.mail.protection.outlook.com (10.167.18.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 18:15:56 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 12:15:51 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <ananth.narayan@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [RFC PATCH v2 1/2] perf/x86/rapl: Fix energy-cores event
Date:   Wed, 1 Mar 2023 18:14:48 +0000
Message-ID: <20230301181449.14647-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301181449.14647-1-wyes.karny@amd.com>
References: <20230301181449.14647-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64E:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 13389130-d14d-493e-c35a-08db1a8100db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu9VoXvpu8Ynp6kM8r6JbKr7JASKO3FJ51xqxz07gsC5ZhGGeHGlQzuftIw8W1XIVRpIsaOPCFc9h3oZF2s0Oqdg760gJUQLkMGbptH3tGi4lJMjZDfJH1NqFX1/tB9OB4OmRiAVUOCZZFiV+1vhMK2A8ax07Bxj9JSGyOM9xfNhbLB58wHp8SdFL/kdaF89wLvJlMGpYmoDxeEKwVD9pLHjad4WfSf/0t0fyV92hpXGQISbydMBy1zULJDGYCGGHpIp8kLpOlFULOBZtIIaIZPBQf2BiSmpJd+8EzFBJgJfVUjNqdUA6/NjNVlV9+NwQd0YBiXxTljUkmZMCZZarlkjU5+PIqsMn//KoE+H+oTkzNYm1G/dcP+2IqJbW8ls4YDM8YUjkveSgdSsTppdq7vd6fqASAO25pHIYh1XgR8nhZ5OYhPNbp+8Sjhuh/KAuVdOXCZsCVJ5esX/gwUd5j+NOlpSN4RaUcziuf6dWNHNw7YZz6mzuTxf6c4tegwvoNIic+FaSepLqjrrAFnn9dDPceFduc4oJzkksXWHKmS8aqm5/Cbqr6M63wVFJH3L0TRr1OD5czgsO5434rIUasus2mqsKso/UtRbXFa9sIXk9TzbRKVhwn3F+iK8UiOKUWkNNw/uR0KZ0ewRIK5cAY0qQLDph4XAqwHoDnWlOPfMFUxFDYRXnJZXH5G8lcfSqaMtTx49tJflpApvb8r0kobQBuTtxuJzxNr/LEBJPCm3ETmg/swxvd/vNditn2w/ye+DJsbEqp+r0HhtKIWDkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(54906003)(316002)(47076005)(110136005)(426003)(336012)(478600001)(83380400001)(966005)(7696005)(1076003)(2616005)(40460700003)(186003)(26005)(6666004)(16526019)(5660300002)(8936002)(86362001)(356005)(921005)(2906002)(41300700001)(70206006)(70586007)(7416002)(44832011)(40480700001)(36860700001)(8676002)(82740400003)(4326008)(81166007)(197533005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:15:56.9781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13389130-d14d-493e-c35a-08db1a8100db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For quite some time, energy-cores event is broken, because RAPL PMU
assumes all the events on this PMU are uncore and sets rapl_cpu_mask
with the first available CPU on the die. Therefore, for energy-cores
event if we read MSR form pmu->cpu, it's wrong. But the following two
changes helped to hide this issue.

- commit 704e2f5b700d ("perf stat: Use affinity for enabling/disabling
  events")
- commit e64cd6f73ff5 ("perf/x86: Use PMUEF_READ_CPU_PKG in uncore
  events")

These two changes together acted as a workaround for energy-cores event.
First change affined perf events to respective CPUs whereas the second
change helped to pick the local CPU to read the MSR. In this way, MSRs
were read from the correct CPU. This works unless it's the first
reading.  For the first reading the second patch doesn't apply and we
get wrong readings. Stephane reported this issue when a patch to enable
AMD energy-cores RAPL event was posted [1].

The right way to fix the issue is to get rid of RAPL being considered an
uncore event. That is a larger change. To enable current RAPL usage,
work around the issue by conditionally remove the
`PERF_EV_CAP_READ_ACTIVE_PKG` flag for energy-cores event. Also, use the
event's CPU instead for PMU's CPU to read the MSR.

[1]: https://lore.kernel.org/lkml/CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com/#t

Fixes: e64cd6f73ff5 ("perf/x86: Use PMUEF_READ_CPU_PKG in uncore events")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 arch/x86/events/rapl.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 52e6e7ed4f78..e6a0c077daf5 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -343,14 +343,15 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
 	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
 
 	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
 	bit = cfg - 1;
 
+	if (bit != PERF_RAPL_PP0)
+		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+
 	/* check event supported */
 	if (!(rapl_cntr_mask & (1 << bit)))
 		return -EINVAL;
@@ -363,7 +364,15 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	pmu = cpu_to_rapl_pmu(event->cpu);
 	if (!pmu)
 		return -EINVAL;
-	event->cpu = pmu->cpu;
+
+	/*
+	 * FIXME: RAPL PMU considers events are uncore and MSRs can be read from
+	 * the first available CPU of the die. But this is not true for energy-cores
+	 * event. Therefore as a workaround don't consider pmu->cpu here for PERF_RAPL_PP0.
+	 */
+	if (event->event_caps & PERF_EV_CAP_READ_ACTIVE_PKG)
+		event->cpu = pmu->cpu;
+
 	event->pmu_private = pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
-- 
2.34.1

