Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41A86EE3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjDYOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjDYOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:23:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACC14F45;
        Tue, 25 Apr 2023 07:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EncdYgsis/VNTIAlVG53laiQqidGodQJPdoveFUPkAkiFNYUFZiIkMO7GfWUc+1uuA5ZNc3aexGrVdll5csTNzkgmnaL+CWXU0HPCPUxowrDxalrcql1i6uKqg9y309lSxpveIreL/NQNHfSke68vO4nNOMV6aQuhWKxmJfWYOztxZ5az1TqI1t/MvsWshjOur64QYKGZ8lc6jFFLGnNREPLG3BuC1sncrMeLMZ1JN1O/bAptBTIMiHmi/ARbAJLNiUTDQiS53NzXNyjYTOHHNqx4l5HZ2YrabB/Bc6/ZaleClV2TyIKvWrtDQWORGBIRVaFHmTWAojXUvCP60cEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENUa4WVdsSyDxj2PLQUxM1UrTaIEriqaav56h+/4/1s=;
 b=nQ+0K4mKrNNjbeROb8nTrZ1R+kgWa9C/qzxYZKYX4AJYeHq+183FFpzznieha23KxnvjrKvTWltStDjYuojFWrSbyEujrXG4Z40gEjGrXv4nG8pNcX0v12Wu3ugcLYDItjQ68u316ETvHHRb0GCFX7uhub0PN3cFcM+WmSbGeW1f68+ZptAS4n5zsb3dEoDM8mhx7SV7QcIpMyYJHQoDGPqA38LB7yy4hPMVNWS0x9iEyKBA/TFhayRn+ulHDdaG4wHmO7jhgK2egNvhUKptwSJGpExyadT6Dg32QrDV/lWlAiKWO/kaBOfesNdtDCd0l/Aluqtq3vk9cXYDRmHb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENUa4WVdsSyDxj2PLQUxM1UrTaIEriqaav56h+/4/1s=;
 b=lUsBYImuH7EAGJqttqVn6BSYSXK8g77Bf2+QwfUACz22P67P5VrJa81Mv85XKjPWuJ8/CicIzBkK2Imur4mp3oBILu7ZYPxVQh9tMuz7AJVKSy3iYE+eaeIk7ZHXLldhvTff3W5Zy8x5iLkOngTPy9ZYDF989z66Nzw79cqZwJ0=
Received: from BN9PR03CA0944.namprd03.prod.outlook.com (2603:10b6:408:108::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:22:53 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::2b) by BN9PR03CA0944.outlook.office365.com
 (2603:10b6:408:108::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 14:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Tue, 25 Apr 2023 14:22:53 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 09:22:46 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
        <maddy@linux.ibm.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 2/3] perf/ibs: Fix interface via core pmu events
Date:   Tue, 25 Apr 2023 19:52:04 +0530
Message-ID: <20230425142205.762-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425142205.762-1-ravi.bangoria@amd.com>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 152c692a-8fc3-4809-4c95-08db45988eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqciOYbLkdzBYA87jVec1sUwclYdMu0JKNZWNYyGzPJoWD8C/PPWSlEnVZFQlCEZR9qA+QvuWnHKisyL9oTxoTG7rnmUxtOny0MmeghFpBb5W6/T5KIsXbGk9OQ+8TLJymNra4TkYkFSQ8eUPL4VsWW91Euon1t1PWGpBe61/ZAzuMPi+RrLqICXjRpHKTl5QLUpwsP3sCtKZeP4bVQIoHK9TsnK4JsTnIWR03aUBhTaIjCnIrY3C7juOJU+yzp0Cf2+ASL5VJzlGhGzN5BDqlK277VyK5R8/s0DOJyP+qctMVBJ9bE2e4ZBmqbMlO2bQQEy+Dm+BHj8djvGozDFME0V45DKbODSuO5vQ2tS+A6AY+WKLkL9pwWi16FXPd3zn7S9Y5tLdZ015/0BUZkRPDoBnhknBj0stLzHH1l+DIZTRXe9g/BjHkb/s/4omE/WHEvCm1DXsvm1zn45qwbP6I1N+ro212fBVCZCQpjwGc1zTX22Ke9MAOX8DdZggHwoWjAPUmMboQMhxSME1a5kSF+1SU1V5wSHCehXjUjNKF/1TS77Xn9arQm5wfupSIXADktQSDA1mRBwM0xt0ka7kzQWRCOhYGYmTPfam9VzZBriPjdiYyXI7199Q/MoOnTqN34x2I5xX46cGrDsHApXlXyrdVLANlXlnv95NOkohQYPdvyt1x1/pZZYR/1RPzkfLJ2tai0FfqK/w7e9+UrlxNdmpZWn7cbBq6LoTgLXE2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(54906003)(478600001)(83380400001)(2616005)(426003)(336012)(36860700001)(36756003)(40480700001)(26005)(1076003)(47076005)(186003)(16526019)(82740400003)(356005)(81166007)(82310400005)(40460700003)(7696005)(41300700001)(316002)(70206006)(70586007)(6916009)(4326008)(7416002)(2906002)(44832011)(8676002)(8936002)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:22:53.4049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152c692a-8fc3-4809-4c95-08db45988eb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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

Although, IBS pmus can be invoked via their own interface, indirect
IBS invocation via core pmu events is also supported with fixed set
of events: cpu-cycles:p, r076:p (same as cpu-cycles:p) and r0C1:p
(micro-ops) for user convenience.

This indirect IBS invocation is broken since commit 66d258c5b048
("perf/core: Optimize perf_init_event()"), which added RAW pmu under
'pmu_idr' list and thus if event_init() fails with RAW pmu, it started
returning error instead of trying other pmus.

Forward precise events from core pmu to IBS by overwriting 'type' and
'config' in the kernel copy of perf_event_attr. Overwriting will cause
perf_init_event() to retry with updated 'type' and 'config', which will
automatically forward event to IBS pmu.

Without patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  Error:
  The r076:p event is not supported.

With patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]

Searching for the right pmu by iterating over all pmus is no longer
required since all pmus now *must* be present in the 'pmu_idr' list.
So, remove linear searching code.

Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c        |  2 +-
 arch/x86/events/amd/ibs.c         | 53 +++++++++++++++----------------
 arch/x86/include/asm/perf_event.h |  2 ++
 kernel/events/core.c              | 10 ------
 4 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bccea57dee81..abadd5f23425 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -374,7 +374,7 @@ static int amd_pmu_hw_config(struct perf_event *event)
 
 	/* pass precise event sampling to ibs: */
 	if (event->attr.precise_ip && get_ibs_caps())
-		return -ENOENT;
+		return forward_event_to_ibs(event);
 
 	if (has_branch_stack(event) && !x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 64582954b5f6..371014802191 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -190,7 +190,7 @@ static struct perf_ibs *get_ibs_pmu(int type)
 }
 
 /*
- * Use IBS for precise event sampling:
+ * core pmu config -> IBS config
  *
  *  perf record -a -e cpu-cycles:p ...    # use ibs op counting cycle count
  *  perf record -a -e r076:p ...          # same as -e cpu-cycles:p
@@ -199,25 +199,9 @@ static struct perf_ibs *get_ibs_pmu(int type)
  * IbsOpCntCtl (bit 19) of IBS Execution Control Register (IbsOpCtl,
  * MSRC001_1033) is used to select either cycle or micro-ops counting
  * mode.
- *
- * The rip of IBS samples has skid 0. Thus, IBS supports precise
- * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
- * rip is invalid when IBS was not able to record the rip correctly.
- * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
- *
  */
-static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
+static int core_pmu_ibs_config(struct perf_event *event, u64 *config)
 {
-	switch (event->attr.precise_ip) {
-	case 0:
-		return -ENOENT;
-	case 1:
-	case 2:
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		switch (event->attr.config) {
@@ -243,22 +227,37 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
+/*
+ * The rip of IBS samples has skid 0. Thus, IBS supports precise
+ * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
+ * rip is invalid when IBS was not able to record the rip correctly.
+ * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
+ */
+int forward_event_to_ibs(struct perf_event *event)
+{
+	u64 config = 0;
+
+	if (!event->attr.precise_ip || event->attr.precise_ip > 2)
+		return -EOPNOTSUPP;
+
+	if (!core_pmu_ibs_config(event, &config)) {
+		event->attr.type = perf_ibs_op.pmu.type;
+		event->attr.config = config;
+	}
+	return -ENOENT;
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
 	u64 max_cnt, config;
-	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
-	if (perf_ibs) {
-		config = event->attr.config;
-	} else {
-		perf_ibs = &perf_ibs_op;
-		ret = perf_ibs_precise_event(event, &config);
-		if (ret)
-			return ret;
-	}
+	if (!perf_ibs)
+		return -ENOENT;
+
+	config = event->attr.config;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..fc86248215e2 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -475,8 +475,10 @@ struct pebs_xmm {
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
+extern int forward_event_to_ibs(struct perf_event *event);
 #else
 static inline u32 get_ibs_caps(void) { return 0; }
+static inline int forward_event_to_ibs(struct perf_event *event) { return -ENOENT; }
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 151299940d9a..232121a6d1e2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11648,16 +11648,6 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		goto unlock;
 	}
 
-	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
-		ret = perf_try_init_event(pmu, event);
-		if (!ret)
-			goto unlock;
-
-		if (ret != -ENOENT) {
-			pmu = ERR_PTR(ret);
-			goto unlock;
-		}
-	}
 fail:
 	pmu = ERR_PTR(-ENOENT);
 unlock:
-- 
2.40.0

