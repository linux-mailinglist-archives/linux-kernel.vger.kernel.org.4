Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791D727F50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbjFHLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjFHLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:46:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAE0E46;
        Thu,  8 Jun 2023 04:45:46 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QcMj31jWBz18Lnh;
        Thu,  8 Jun 2023 19:40:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 19:45:28 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH] drivers/perf: hisi: Don't migrate perf to the CPU going to teardown
Date:   Thu, 8 Jun 2023 19:43:26 +0800
Message-ID: <20230608114326.27649-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver needs to migrate the perf context if the current using CPU going
to teardown. By the time calling the cpuhp::teardown() callback the
cpu_online_mask() hasn't updated yet and still includes the CPU going to
teardown. In current driver's implementation we may migrate the context
to the teardown CPU and leads to the below calltrace:

...
[  368.104662][  T932] task:cpuhp/0         state:D stack:    0 pid:   15 ppid:     2 flags:0x00000008
[  368.113699][  T932] Call trace:
[  368.116834][  T932]  __switch_to+0x7c/0xbc
[  368.120924][  T932]  __schedule+0x338/0x6f0
[  368.125098][  T932]  schedule+0x50/0xe0
[  368.128926][  T932]  schedule_preempt_disabled+0x18/0x24
[  368.134229][  T932]  __mutex_lock.constprop.0+0x1d4/0x5dc
[  368.139617][  T932]  __mutex_lock_slowpath+0x1c/0x30
[  368.144573][  T932]  mutex_lock+0x50/0x60
[  368.148579][  T932]  perf_pmu_migrate_context+0x84/0x2b0
[  368.153884][  T932]  hisi_pcie_pmu_offline_cpu+0x90/0xe0 [hisi_pcie_pmu]
[  368.160579][  T932]  cpuhp_invoke_callback+0x2a0/0x650
[  368.165707][  T932]  cpuhp_thread_fun+0xe4/0x190
[  368.170316][  T932]  smpboot_thread_fn+0x15c/0x1a0
[  368.175099][  T932]  kthread+0x108/0x13c
[  368.179012][  T932]  ret_from_fork+0x10/0x18
...

Use function cpumask_any_but() to find one correct active cpu to fixes
this issue.

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 0bc8dc36aff5..14f8b4b03337 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -683,7 +683,7 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	pcie_pmu->on_cpu = -1;
 	/* Choose a new CPU from all online cpus. */
-	target = cpumask_first(cpu_online_mask);
+	target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids) {
 		pci_err(pcie_pmu->pdev, "There is no CPU to set\n");
 		return 0;
-- 
2.30.0

