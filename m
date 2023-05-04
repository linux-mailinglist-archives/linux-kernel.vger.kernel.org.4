Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491AC6F6968
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjEDLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEDLBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:01:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A14ED4;
        Thu,  4 May 2023 04:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDQAJ9TC+Aux8zq3KUDxBJkB0EOEgMxdlIspSXg2W5lcArUtcy7f73J11btddaFnt58agAwMRcY7E/digFVDmMLZa8UMj43ArwTH6Mk8jbBzZEUX5nDuz1kJ4apOJDXhKPbwUIdwnGACbsAHL5rcF1BIprDwdO6wgj10hPEHvZqFCD9VU/yWJ4Mi+PMXUhBvpMveZzseBxJpXYNnG+cr/Jmn6tR1r1eMPIDcGJyx+LsbDvh9tP+nLg8V4wA7gb5rPrvBB86jqaRVuR0aufVPoMsUffH9IV+evyXQACHNdZ+47duMzXcE5zdwH5ZgafEtmJFfE8e7jbio+VaMMJ3YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjIMf0WwqOSKautQ5XEl0597lZH4zy7aFU6o3samyys=;
 b=LEiAg0SBspu9y2r+SvNBoKauqKKsvjr3tQFiwKjm8x9SD2fsfU9S+gcNEv97O+pir/Kj8+NSN6MSro602sQEV+MC8Ss8tuQTzXZStsasHNZlUE9b+fhWnhVFOZMSDIG+dJEwy9rIjpGgzfHKJFXv/AoKJMOTpw0hw9QytKiJPcI/aDk8xi3jjVfLFVO7z5ArG5wbDXDk+e4pMGqQgyu1dw8NXsZxr12mVfhX2JShHr5+GsqvOyMpd4m3yH9otpI+RlsOxX4I1o/y4/1UtL5JyZiUyYj4Eb8i/UwQGFn91YWVe8NoMBtg3vYwal+yG3FMZjgGMiNWflYPaDJAhaPtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjIMf0WwqOSKautQ5XEl0597lZH4zy7aFU6o3samyys=;
 b=VlpDelMP535soWvLFJVasIOTfNef6e65FyJVwJZhdGIHVTlG0ibeRvZZ6Msg6HmEbl3hD1rmtdCtddqY0kJQKkc89n+HnCDhJC6FDvhJSkNSxoYH5f3xROTsCQfadXoSmt6FgOG0QmmV5fFMAM7M0aU1ca/ID4pT2XGgU93+VfI=
Received: from BYAPR11CA0062.namprd11.prod.outlook.com (2603:10b6:a03:80::39)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Thu, 4 May
 2023 11:01:30 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:80:cafe::42) by BYAPR11CA0062.outlook.office365.com
 (2603:10b6:a03:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 11:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 11:01:30 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 06:00:35 -0500
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
Subject: [PATCH v4 1/4] perf/core: Rework forwarding of {task|cpu}-clock events
Date:   Thu, 4 May 2023 16:30:00 +0530
Message-ID: <20230504110003.2548-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504110003.2548-1-ravi.bangoria@amd.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 573ad5bb-c92b-49b9-9e73-08db4c8eea3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNrUAM7yH0tiKZSEHetLYwN11NipmbTNNJRPLUwIXtEiPwnzjhAphccj1os3nvoLcEt+czvuBlVT1es7GniHOSrtlAaDJ6PZijzgqzBCg/FZ5kPI3iJNVUQTozUFyzxpuoZD6WrReQFEMGC1Y+EiZqD2gttc37rfzzLh4Oa350n3cFETkeNTt6dTBbvcC00HhU6rXZiCM4qq0ZMu1m2zN7JxsfeIa/ItsvE1UzIdmaZKSipznfV4yHo2H0jDQW4eGMk8SFgCBJ9ZEDDOOrGENTntwWizkKxgja9risz0IGul0SPMFUvprBImiWeSFh8sUp4k+XGc5gCpM2SGifpeiojRkQWx9Wq9HWTZPn2Z0fbf7Z6Ypb7Qulq91tr/P0778OPIYfjk+sSb3UOg7s7oIlxnMJMma6ETl9jkCnzfSxtHCmvxtwnuwGV+T9Mrplyp7pWWSM4VFVPfxjN1lN/MfcDvrmyeDiqXmShwy9Q03eS4yA/v9cA7jXHv5SlU9io6YPX10G7ekqO91gAtRzLq5WTBxO5VFp36bl8vNWTyqfZSjNnMhzQ7BTxQhhakwHLn2zcztr8IdCQKHkiaplt2ONJ6ihJ/llcrTeSoyrdDjPIJcT7qd5IiTYaXXivWgfafSHfI0xkLrTHd/qg27ELRd51cgJqxA0IR+vyl++0eS9wX8N4nu2+ltPX+NdgedS8GWlu+wDwRH6WZJOcaZljAvfgY4RoTdgZUXrb9DmiPPzE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(7416002)(41300700001)(5660300002)(44832011)(336012)(2616005)(8676002)(8936002)(426003)(36860700001)(86362001)(83380400001)(40460700003)(40480700001)(47076005)(2906002)(7696005)(82310400005)(54906003)(1076003)(26005)(6666004)(81166007)(36756003)(82740400003)(478600001)(356005)(6916009)(70586007)(4326008)(70206006)(186003)(316002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:01:30.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 573ad5bb-c92b-49b9-9e73-08db4c8eea3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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
 include/linux/perf_event.h | 10 +++++
 kernel/events/core.c       | 77 ++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..5c8a748f51ac 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -295,6 +295,8 @@ struct perf_event_pmu_context;
 
 struct perf_output_handle;
 
+#define PMU_NULL_DEV	((void *)(~0))
+
 /**
  * struct pmu - generic performance monitoring unit
  */
@@ -827,6 +829,14 @@ struct perf_event {
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
index 435815d3be3f..0695bb9fbbb6 100644
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
+	.dev		= PMU_NULL_DEV,
 
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
+	.dev		= PMU_NULL_DEV,
 
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
+	if (pmu_bus_running && !pmu->dev) {
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
@@ -11499,12 +11498,13 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	return ret;
 
 free_dev:
-	device_del(pmu->dev);
-	put_device(pmu->dev);
+	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
+		device_del(pmu->dev);
+		put_device(pmu->dev);
+	}
 
 free_idr:
-	if (pmu->type != PERF_TYPE_SOFTWARE)
-		idr_remove(&pmu_idr, pmu->type);
+	idr_remove(&pmu_idr, pmu->type);
 
 free_pdc:
 	free_percpu(pmu->pmu_disable_count);
@@ -11525,9 +11525,8 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	if (pmu->type != PERF_TYPE_SOFTWARE)
-		idr_remove(&pmu_idr, pmu->type);
-	if (pmu_bus_running) {
+	idr_remove(&pmu_idr, pmu->type);
+	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
 		device_del(pmu->dev);
@@ -11601,6 +11600,12 @@ static struct pmu *perf_init_event(struct perf_event *event)
 
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
@@ -13640,8 +13645,8 @@ void __init perf_event_init(void)
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
@@ -13684,7 +13689,7 @@ static int __init perf_event_sysfs_init(void)
 		goto unlock;
 
 	list_for_each_entry(pmu, &pmus, entry) {
-		if (!pmu->name || pmu->type < 0)
+		if (pmu->dev)
 			continue;
 
 		ret = pmu_dev_alloc(pmu);
-- 
2.40.0

