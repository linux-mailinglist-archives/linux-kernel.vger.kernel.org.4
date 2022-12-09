Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82961648072
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLIJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:54:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183051C25;
        Fri,  9 Dec 2022 01:54:18 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NT5tq0QhnzRpsT;
        Fri,  9 Dec 2022 17:53:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Dec
 2022 17:53:46 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <cuibixuan@linux.alibaba.com>, <lvying6@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC PATCH v2 1/1] ACPI: APEI: Make memory_failure() triggered by synchronization errors execute in the current context
Date:   Fri, 9 Dec 2022 17:54:07 +0800
Message-ID: <20221209095407.383211-2-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221209095407.383211-1-lvying6@huawei.com>
References: <20221209095407.383211-1-lvying6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory uncorrected error which is detected by an external component and
notified via an IRQ, can be called asynchronization error. If an error is
detected as a result of user-space process accessing a corrupt memory
location, the CPU may take an abort. On arm64 this is a
'synchronous external abort', and on a firmware first system it is notified
via NOTIFY_SEA, this can be called synchronization error.

Currently, synchronization error and asynchronization error both use
memory_failure_queue to schedule memory_failure() exectute in kworker
context. Commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue
for synchronous errors") make task_work pending to flush out the queue,
cancel_work_sync() in memory_failure_queue_kick() will make
memory_failure() exectute in kworker context first which will get
synchronization error info from kfifo, so task_work later will get nothing
from kfifo which doesn't work as expected. Even worse, synchronization
error notification has NMI like properties, (it can interrupt IRQ-masked
code), task_work may get wrong kfifo entry from interrupted
asynchronization error which is notified by IRQ.

Since the memory_failure() triggered by a synchronous exception is
executed in the kworker context, the early_kill mode of memory_failure()
will send wrong si_code by SIGBUS signal: current process is kworker
thread, the actual user-space process accessing the corrupt memory location
will be collected by find_early_kill_thread(), and then send SIGBUS with
BUS_MCEERR_AO si_code to the actual user-space process instead of
BUS_MCEERR_AR. The machine-manager(kvm) use the si_code: BUS_MCEERR_AO for
'action optional' early notifications, and BUS_MCEERR_AR for
'action required' synchronous/late notifications.

Make memory_failure() triggered by synchronization errors execute in the
current context, we do not need workqueue for synchronization error
anymore, use task_work handle synchronization errors directly. Since,
synchronization errors and asynchronization errors share the same kfifo,
use MF_ACTION_REQUIRED flag to distinguish them. And the asynchronization
error keeps the same as before.

Currently, it's hard to distinguish synchronization error in APEI. It
can be determined that the SEA report synchronization error, so
currently only the synchronization error reported by SEA is distinguished
and handled in current context.

Signed-off-by: Lv Ying <lvying6@huawei.com>
---
 drivers/acpi/apei/ghes.c | 20 +++++++++-------
 mm/memory-failure.c      | 50 +++++++++++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9952f3a792ba..19d62ec2177f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -423,8 +423,8 @@ static void ghes_clear_estatus(struct ghes *ghes,
 
 /*
  * Called as task_work before returning to user-space.
- * Ensure any queued work has been done before we return to the context that
- * triggered the notification.
+ * Ensure any queued corrupt page in synchronous errors has been handled before
+ * we return to the user context that triggered the notification.
  */
 static void ghes_kick_task_work(struct callback_head *head)
 {
@@ -461,7 +461,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, int notify_type)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -475,7 +475,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = (notify_type == ACPI_HEST_NOTIFY_SEA) ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -483,7 +483,8 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev,
+		int notify_type)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	bool queued = false;
@@ -510,7 +511,9 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr,
+					(notify_type == ACPI_HEST_NOTIFY_SEA) ?
+					MF_ACTION_REQUIRED : 0);
 			p += err_info->length;
 			continue;
 		}
@@ -631,6 +634,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	int notify_type = ghes->generic->notify.type;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -648,13 +652,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			queued = ghes_handle_memory_failure(gdata, sev, notify_type);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			queued = ghes_handle_arm_hw_error(gdata, sev, notify_type);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bead6bccc7f2..82238ec86acd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2204,7 +2204,11 @@ struct memory_failure_cpu {
 static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
 
 /**
- * memory_failure_queue - Schedule handling memory failure of a page.
+ * memory_failure_queue
+ * - Schedule handling memory failure of a page for asynchronous error, memory
+ *   failure page will be executed in kworker thread
+ * - put corrupt memory info into kfifo for synchronous error, task_work will
+ *   handle them before returning to the user
  * @pfn: Page Number of the corrupted page
  * @flags: Flags for memory failure handling
  *
@@ -2217,6 +2221,11 @@ static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
  * happen outside the current execution context (e.g. when
  * detected by a background scrubber)
  *
+ * This function can also be used in synchronous errors which was detected as a
+ * result of user-space accessing a corrupt memory location, just put memory
+ * error info into kfifo, and then, task_work get and handle it in current
+ * execution context instead of scheduling kworker to handle it
+ *
  * Can run in IRQ context.
  */
 void memory_failure_queue(unsigned long pfn, int flags)
@@ -2230,9 +2239,10 @@ void memory_failure_queue(unsigned long pfn, int flags)
 
 	mf_cpu = &get_cpu_var(memory_failure_cpu);
 	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
-	if (kfifo_put(&mf_cpu->fifo, entry))
-		schedule_work_on(smp_processor_id(), &mf_cpu->work);
-	else
+	if (kfifo_put(&mf_cpu->fifo, entry)) {
+		if (!(entry.flags & MF_ACTION_REQUIRED))
+			schedule_work_on(smp_processor_id(), &mf_cpu->work);
+	} else
 		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
 	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
@@ -2240,12 +2250,15 @@ void memory_failure_queue(unsigned long pfn, int flags)
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);
 
-static void memory_failure_work_func(struct work_struct *work)
+/*
+ * (a)synchronous error info should be consumed by the corresponding handler
+ */
+static void __memory_failure_work_func(struct work_struct *work, bool sync)
 {
 	struct memory_failure_cpu *mf_cpu;
 	struct memory_failure_entry entry = { 0, };
 	unsigned long proc_flags;
-	int gotten;
+	int gotten, ret;
 
 	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
@@ -2256,22 +2269,31 @@ static void memory_failure_work_func(struct work_struct *work)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
-		else
-			memory_failure(entry.pfn, entry.flags);
+		else {
+			if (sync && (entry.flags & MF_ACTION_REQUIRED)) {
+				ret = memory_failure(entry.pfn, entry.flags);
+				if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
+					return;
+
+				pr_err("Memory error not recovered");
+				force_sig(SIGBUS);
+			} else if (!sync && !(entry.flags & MF_ACTION_REQUIRED))
+				memory_failure(entry.pfn, entry.flags);
+		}
 	}
 }
 
-/*
- * Process memory_failure work queued on the specified CPU.
- * Used to avoid return-to-userspace racing with the memory_failure workqueue.
- */
+static void memory_failure_work_func(struct work_struct *work)
+{
+	__memory_failure_work_func(work, false);
+}
+
 void memory_failure_queue_kick(int cpu)
 {
 	struct memory_failure_cpu *mf_cpu;
 
 	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
+	__memory_failure_work_func(&mf_cpu->work, true);
 }
 
 static int __init memory_failure_init(void)
-- 
2.36.1

