Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2696642C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiLEPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiLEPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF89FCB;
        Mon,  5 Dec 2022 07:43:32 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQnls6FkJzqSvC;
        Mon,  5 Dec 2022 23:39:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 23:43:29 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
        <robert.moore@intel.com>, <bp@alien8.de>, <devel@acpica.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <lvying6@huawei.com>, <naoya.horiguchi@nec.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/4] arm64: ghes: handle the case when memory_failure recovery failed
Date:   Tue, 6 Dec 2022 00:00:42 +0800
Message-ID: <20221205160043.57465-4-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221205160043.57465-1-xiexiuqi@huawei.com>
References: <20221205160043.57465-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_failure() may not always recovery successfully. In synchronous 
external data abort case, if memory_failure() recovery failed, we must handle it.

In this case, if the recovery fails, the common helper function
arch_apei_do_recovery_failed() is invoked. For arm64 platform, we just
send a SIGBUS.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/acpi/apei/ghes.c |  3 ++-
 include/linux/mm.h       |  2 +-
 mm/memory-failure.c      | 24 +++++++++++++++++-------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ba0631c54c52..ddc4da603215 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -435,7 +435,8 @@ static void ghes_kick_task_work(struct callback_head *head)
 
 	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
 	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		memory_failure_queue_kick(estatus_node->task_work_cpu);
+		if (memory_failure_queue_kick(estatus_node->task_work_cpu))
+			arch_apei_do_recovery_failed();
 
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 974ccca609d2..126d1395c208 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3290,7 +3290,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
-extern void memory_failure_queue_kick(int cpu);
+extern int memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bead6bccc7f2..b9398f67264a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2240,12 +2240,12 @@ void memory_failure_queue(unsigned long pfn, int flags)
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);
 
-static void memory_failure_work_func(struct work_struct *work)
+static int __memory_failure_work_func(struct work_struct *work)
 {
 	struct memory_failure_cpu *mf_cpu;
 	struct memory_failure_entry entry = { 0, };
 	unsigned long proc_flags;
-	int gotten;
+	int gotten, ret = 0, result;
 
 	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
@@ -2254,24 +2254,34 @@ static void memory_failure_work_func(struct work_struct *work)
 		spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 		if (!gotten)
 			break;
-		if (entry.flags & MF_SOFT_OFFLINE)
+		if (entry.flags & MF_SOFT_OFFLINE) {
 			soft_offline_page(entry.pfn, entry.flags);
-		else
-			memory_failure(entry.pfn, entry.flags);
+		} else {
+			result = memory_failure(entry.pfn, entry.flags);
+			if (ret == 0 && result != 0)
+				ret = result;
+		}
 	}
+
+	return ret;
+}
+
+static void memory_failure_work_func(struct work_struct *work)
+{
+	__memory_failure_work_func(work);
 }
 
 /*
  * Process memory_failure work queued on the specified CPU.
  * Used to avoid return-to-userspace racing with the memory_failure workqueue.
  */
-void memory_failure_queue_kick(int cpu)
+int memory_failure_queue_kick(int cpu)
 {
 	struct memory_failure_cpu *mf_cpu;
 
 	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
 	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
+	return __memory_failure_work_func(&mf_cpu->work);
 }
 
 static int __init memory_failure_init(void)
-- 
2.20.1

