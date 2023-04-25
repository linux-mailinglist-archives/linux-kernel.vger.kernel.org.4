Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7F6EE3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjDYOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDYOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:22:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2014443;
        Tue, 25 Apr 2023 07:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaF497Q7CmvbwEUDGQtoI/VxZADO2xtLf4JIvzSz3Im3VNT+TMYidxAZ/TRkANbk7lJGdnxgdNVACM6YirLo3xHIG3EsQMYtHFpbrdt+zghQrFqOSiNhSbfFsPupr3qxGD5LEeQ102aCP4xMFNo8YfuOAALFclA4PlitPY/LmR6tMCbbrquoMb1O89kxa2cIScYqnX1n5id4qSC8ze6GlxNoTYgx3THksufgljb9pVL3Uj9yOq2A4C+jEGPW8Cte2e2CGkDvSzjfsDs8gjnk8++NAWUQiF2M20H5eFvYWYO2QhzlOGi+cPB21Wv2u0Rq6MiYJmYL/eFKIfSngXxvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAGlnOKzdndxDoa1ycxmryr0iolteczMs/OOMC+s/6g=;
 b=cpZhE6IzmL8YT/v/BhQwc5W0fdCgjEJAQmnCnnNzR01kJeZy+wOBDPzRxdch1JFtTl2VzFsNf/IeQjaL4PSmhY+a/YhiFY1DkqD+ViCtuaV5DsPtA3pDduRJOlkmbcdvE6dPg1+/HzfFJVBoWKM7trAfg64xfeUr9CFNJtJdN4m36woltQSoARFVKOCWySjf65YBlobyG7e8cTlvy6KuHCRS8PvlnE2HFA+x/PCQrZr45p0i7Obo9hp5YDcnFdCoJmzZ/UZtFC1FXh82vdox0AAfwdWGMQEUfyN4aSPniR9mefte2Vv6+WaCwxquZ4EWgPl2LOD4PMiOxT7fpeuo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAGlnOKzdndxDoa1ycxmryr0iolteczMs/OOMC+s/6g=;
 b=3+CHztaQwD1JwIN14F89uHKjtcp/MfytpsgOXBHw9US43xSRA0V65xjyLQAMn0Eyf0fXTgEzSHdFE5/eJ7B7WTOPxpNdHrTYcBrILwE8l935Y39p+pBIbdBQME/s+yOtXBBLWrcHTaDlRJgw2N5Woef1ydPYaMj3nVKkeZOIEQ8=
Received: from BN8PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:94::48)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:22:46 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::4f) by BN8PR03CA0035.outlook.office365.com
 (2603:10b6:408:94::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 14:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 14:22:45 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 09:22:38 -0500
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
Subject: [PATCH v3 1/3] perf/core: Rework forwarding of {task|cpu}-clock events
Date:   Tue, 25 Apr 2023 19:52:03 +0530
Message-ID: <20230425142205.762-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: e528259f-295b-4792-846e-08db45988a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGRdMChUpnRUV4xzu64iwl8Jy1T3rwnJ8Q2SJWsx5XM1eWDKTtGmzotU2/ftOHYk8NTZRo+qgs5Ku6ymwM6WwP7UlXd+6VXHdbST3hbBBHukBfoI+lY1kmzrm125JHJ4iYdfB3D6JwSYge07N/EQyQeNIzvAVPbI8v8aFFwp2dUDx1ZjPF4Vc8XwgWJQ6p6CPMtG1rLg6Ht5utO6T52VEDpUax/sKHeQEo5KVXflWzCAx6wQKlnmpn0ZuJmMJDlzI7z86qlAGHNX7DKAhrpCv8+hGGzHnCWAZ4nULLMoCh6IcmQCCA0j2gJLCuLYr3mkaH1ScGXWMAylT56KSPa5QWKkwLfazTGwVVzk4pz5fJa8Em2zNapgRteOLzRQsep/kWFR7D/cYYxNwxrXpqyssY7FJCLd6idrHZxcXT1X4bp3BSWWaZyvF7ySU/Y40vCOwO68vSrbbRT53xN6S+9iAIQ9Rn97aRGXGSP83wvwaWM9anMDOT7TiJwaS443Hnwsx5JOb+FD1yhVbuD3NOEhTBAyRdY9qcMkKDv+muaGwt+833VtSeuP13ExsxtURovnASEWz/f8AqTKxZsooGvAFWh/NzJcOdhXc0j73RUYsjnPfODSs1oykjjBrocx+KeIyPSLKAV17y5zHXybNHFW49T7yKWA2zwILA5z4Cr/ldL2I3wC+OMI6ChqYVuN9DEEVyfrNWH1G0YO6Cf61v+vr2eXnluxIE/T2CrhZRCkZuk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(186003)(40480700001)(40460700003)(54906003)(478600001)(86362001)(36756003)(7696005)(6666004)(82310400005)(2906002)(7416002)(5660300002)(44832011)(8676002)(8936002)(70586007)(70206006)(4326008)(6916009)(81166007)(82740400003)(41300700001)(356005)(316002)(26005)(1076003)(336012)(426003)(2616005)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:22:45.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e528259f-295b-4792-846e-08db45988a39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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

Currently, PERF_TYPE_SOFTWARE is treated specially since task-clock and
cpu-clock events are interfaced through it but internally gets forwarded
to their own pmus.

Rework this by overwriting event->attr.type in perf_swevent_init() which
will cause perf_init_event() to retry with updated type and event will
automatically get forwarded to right pmu. With the change, SW pmu no
longer needs to be treated specially and can be included in 'pmu_idr'
list.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/linux/perf_event.h | 11 ++++++
 kernel/events/core.c       | 69 ++++++++++++++++++++------------------
 2 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..40647d707fb3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -322,6 +322,9 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	/* Skip creating pmu device and sysfs interface. */
+	bool				skip_sysfs_dev;
+
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
@@ -827,6 +830,14 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	/*
+	 * Certain events gets forwarded to another pmu internally by over-
+	 * writing kernel copy of event->attr.type without user being aware
+	 * of it. event->orig_type contains original 'type' requested by
+	 * user.
+	 */
+	__u32				orig_type;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d3be3f..151299940d9a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6647,7 +6647,7 @@ static void perf_sigtrap(struct perf_event *event)
 		return;
 
 	send_sig_perf((void __user *)event->pending_addr,
-		      event->attr.type, event->attr.sig_data);
+		      event->orig_type, event->attr.sig_data);
 }
 
 /*
@@ -9951,6 +9951,9 @@ static void sw_perf_event_destroy(struct perf_event *event)
 	swevent_hlist_put();
 }
 
+static struct pmu perf_cpu_clock; /* fwd declaration */
+static struct pmu perf_task_clock;
+
 static int perf_swevent_init(struct perf_event *event)
 {
 	u64 event_id = event->attr.config;
@@ -9966,7 +9969,10 @@ static int perf_swevent_init(struct perf_event *event)
 
 	switch (event_id) {
 	case PERF_COUNT_SW_CPU_CLOCK:
+		event->attr.type = perf_cpu_clock.type;
+		return -ENOENT;
 	case PERF_COUNT_SW_TASK_CLOCK:
+		event->attr.type = perf_task_clock.type;
 		return -ENOENT;
 
 	default:
@@ -11086,7 +11092,7 @@ static void cpu_clock_event_read(struct perf_event *event)
 
 static int cpu_clock_event_init(struct perf_event *event)
 {
-	if (event->attr.type != PERF_TYPE_SOFTWARE)
+	if (event->attr.type != perf_cpu_clock.type)
 		return -ENOENT;
 
 	if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK)
@@ -11107,6 +11113,7 @@ static struct pmu perf_cpu_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
 	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.skip_sysfs_dev	= true,
 
 	.event_init	= cpu_clock_event_init,
 	.add		= cpu_clock_event_add,
@@ -11167,7 +11174,7 @@ static void task_clock_event_read(struct perf_event *event)
 
 static int task_clock_event_init(struct perf_event *event)
 {
-	if (event->attr.type != PERF_TYPE_SOFTWARE)
+	if (event->attr.type != perf_task_clock.type)
 		return -ENOENT;
 
 	if (event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
@@ -11188,6 +11195,7 @@ static struct pmu perf_task_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
 	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.skip_sysfs_dev	= true,
 
 	.event_init	= task_clock_event_init,
 	.add		= task_clock_event_add,
@@ -11415,31 +11423,31 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		goto unlock;
 
 	pmu->type = -1;
-	if (!name)
-		goto skip_type;
+	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
+		ret = -EINVAL;
+		goto free_pdc;
+	}
+
 	pmu->name = name;
 
-	if (type != PERF_TYPE_SOFTWARE) {
-		if (type >= 0)
-			max = type;
+	if (type >= 0)
+		max = type;
 
-		ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
-		if (ret < 0)
-			goto free_pdc;
+	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto free_pdc;
 
-		WARN_ON(type >= 0 && ret != type);
+	WARN_ON(type >= 0 && ret != type);
 
-		type = ret;
-	}
+	type = ret;
 	pmu->type = type;
 
-	if (pmu_bus_running) {
+	if (pmu_bus_running && !pmu->skip_sysfs_dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
 			goto free_idr;
 	}
 
-skip_type:
 	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
@@ -11481,16 +11489,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-	/*
-	 * Ensure the TYPE_SOFTWARE PMUs are at the head of the list,
-	 * since these cannot be in the IDR. This way the linear search
-	 * is fast, provided a valid software event is provided.
-	 */
-	if (type == PERF_TYPE_SOFTWARE || !name)
-		list_add_rcu(&pmu->entry, &pmus);
-	else
-		list_add_tail_rcu(&pmu->entry, &pmus);
-
+	list_add_rcu(&pmu->entry, &pmus);
 	atomic_set(&pmu->exclusive_cnt, 0);
 	ret = 0;
 unlock:
@@ -11503,8 +11502,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	put_device(pmu->dev);
 
 free_idr:
-	if (pmu->type != PERF_TYPE_SOFTWARE)
-		idr_remove(&pmu_idr, pmu->type);
+	idr_remove(&pmu_idr, pmu->type);
 
 free_pdc:
 	free_percpu(pmu->pmu_disable_count);
@@ -11525,8 +11523,7 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	if (pmu->type != PERF_TYPE_SOFTWARE)
-		idr_remove(&pmu_idr, pmu->type);
+	idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11601,6 +11598,12 @@ static struct pmu *perf_init_event(struct perf_event *event)
 
 	idx = srcu_read_lock(&pmus_srcu);
 
+	/*
+	 * Save original type before calling pmu->event_init() since certain
+	 * pmus overwrites event->attr.type to forward event to another pmu.
+	 */
+	event->orig_type = event->attr.type;
+
 	/* Try parent's PMU first: */
 	if (event->parent && event->parent->pmu) {
 		pmu = event->parent->pmu;
@@ -13640,8 +13643,8 @@ void __init perf_event_init(void)
 	perf_event_init_all_cpus();
 	init_srcu_struct(&pmus_srcu);
 	perf_pmu_register(&perf_swevent, "software", PERF_TYPE_SOFTWARE);
-	perf_pmu_register(&perf_cpu_clock, NULL, -1);
-	perf_pmu_register(&perf_task_clock, NULL, -1);
+	perf_pmu_register(&perf_cpu_clock, "cpu_clock", -1);
+	perf_pmu_register(&perf_task_clock, "task_clock", -1);
 	perf_tp_register();
 	perf_event_init_cpu(smp_processor_id());
 	register_reboot_notifier(&perf_reboot_notifier);
@@ -13684,7 +13687,7 @@ static int __init perf_event_sysfs_init(void)
 		goto unlock;
 
 	list_for_each_entry(pmu, &pmus, entry) {
-		if (!pmu->name || pmu->type < 0)
+		if (pmu->skip_sysfs_dev)
 			continue;
 
 		ret = pmu_dev_alloc(pmu);
-- 
2.40.0

