Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0376BE1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCQHZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCQHZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:25:05 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7E67833;
        Fri, 17 Mar 2023 00:25:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Ve21xwA_1679037894;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ve21xwA_1679037894)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 15:24:55 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     tony.luck@intel.com, naoya.horiguchi@nec.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com,
        justin.he@arm.com, akpm@linux-foundation.org, ardb@kernel.org,
        ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, rafael@kernel.org,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
Subject: [PATCH v3 2/2] ACPI: APEI: handle synchronous exceptions in task work
Date:   Fri, 17 Mar 2023 15:24:43 +0800
Message-Id: <20230317072443.3189-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware errors could be signaled by synchronous interrupt, e.g.  when an
error is detected by a background scrubber, or signaled by synchronous
exception, e.g. when an uncorrected error is consumed. Both synchronous and
asynchronous error are queued and handled by a dedicated kthread in
workqueue.

commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
synchronous errors") keep track of whether memory_failure() work was
queued, and make task_work pending to flush out the workqueue so that the
work for synchronous error is processed before returning to user-space.
The trick ensures that the corrupted page is unmapped and poisoned. And
after returning to user-space, the task starts at current instruction which
triggering a page fault in which kernel will send SIGBUS to current process
due to VM_FAULT_HWPOISON.

However, the memory failure recovery for hwpoison-aware mechanisms does not
work as expected. For example, hwpoison-aware user-space processes like
QEMU register their customized SIGBUS handler and enable early kill mode by
seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
the process by sending a SIGBUS signal in memory failure with wrong
si_code: the actual user-space process accessing the corrupt memory
location, but its memory failure work is handled in a kthread context, so
it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
process instead of BUS_MCEERR_AR in kill_proc().

To this end, separate synchronous and asynchronous error handling into
different paths like X86 platform does:

- task work for synchronous errors.
- and workqueue for asynchronous errors.

Then for synchronous errors, the current context in memory failure is
exactly belongs to the task consuming poison data and it will send SIBBUS
with proper si_code.

Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 114 ++++++++++++++++++++++-----------------
 include/acpi/ghes.h      |   3 --
 mm/memory-failure.c      |  13 -----
 3 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cccd96596efe..1901ee3498c4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -452,45 +452,79 @@ static void ghes_clear_estatus(struct ghes *ghes,
 }
 
 /*
- * Called as task_work before returning to user-space.
- * Ensure any queued work has been done before we return to the context that
- * triggered the notification.
+ * struct sync_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                fine tune action taken
+ *
+ * Structure to pass task work to be handled before
+ * ret_to_user via task_work_add().
  */
-static void ghes_kick_task_work(struct callback_head *head)
+struct sync_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void memory_failure_cb(struct callback_head *twork)
 {
-	struct acpi_hest_generic_status *estatus;
-	struct ghes_estatus_node *estatus_node;
-	u32 node_len;
+	int ret;
+	struct sync_task_work *twcb =
+		container_of(twork, struct sync_task_work, twork);
 
-	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
-	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		memory_failure_queue_kick(estatus_node->task_work_cpu);
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	kfree(twcb);
 
-	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
-	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
+	if (!ret)
+		return;
+
+	/*
+	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
+	 * to the current process with the proper error info,
+	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
+	 *
+	 * In both cases, no further processing is required.
+	 */
+	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err("Memory error not recovered");
+	force_sig(SIGBUS);
 }
 
-static bool ghes_do_memory_failure(u64 physical_addr, int flags)
+static void ghes_do_memory_failure(u64 physical_addr, int flags)
 {
 	unsigned long pfn;
+	struct sync_task_work *twcb;
 
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		return false;
+		return;
 
 	pfn = PHYS_PFN(physical_addr);
 	if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 		"Invalid address in generic error data: %#llx\n",
 		physical_addr);
-		return false;
+		return;
+	}
+
+	if (flags == MF_ACTION_REQUIRED && current->mm) {
+		twcb = kmalloc(sizeof(*twcb), GFP_ATOMIC);
+		if (!twcb)
+			return;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return;
 	}
 
 	memory_failure_queue(pfn, flags);
-	return true;
 }
 
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 				       int sev, bool sync)
 {
 	int flags = -1;
@@ -498,7 +532,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
+		return;
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
@@ -508,16 +542,15 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+		ghes_do_memory_failure(mem_err->physical_addr, flags);
 
-	return false;
+	return;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+static void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				       int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-	bool queued = false;
 	int sec_sev, i;
 	char *p;
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
@@ -526,7 +559,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 
 	sec_sev = ghes_severity(gdata->error_severity);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
-		return false;
+		return;
 
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
@@ -542,7 +575,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -555,8 +588,6 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				    error_type);
 		p += err_info->length;
 	}
-
-	return queued;
 }
 
 /*
@@ -654,7 +685,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
-static bool ghes_do_proc(struct ghes *ghes,
+static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
@@ -662,7 +693,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 	guid_t *sec_type;
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
-	bool queued = false;
 	bool sync = is_hest_sync_notify(ghes);
 
 	sev = ghes_severity(estatus->error_severity);
@@ -681,13 +711,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+			ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
@@ -697,8 +727,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 					       gdata->error_data_length);
 		}
 	}
-
-	return queued;
 }
 
 static void __ghes_print_estatus(const char *pfx,
@@ -1000,9 +1028,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	bool task_work_pending;
 	u32 len, node_len;
-	int ret;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -1017,25 +1043,14 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
-		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
+		ghes_do_proc(estatus_node->ghes, estatus);
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
 			if (ghes_print_estatus(NULL, generic, estatus))
 				ghes_estatus_cache_add(generic, estatus);
 		}
-
-		if (task_work_pending && current->mm) {
-			estatus_node->task_work.func = ghes_kick_task_work;
-			estatus_node->task_work_cpu = smp_processor_id();
-			ret = task_work_add(current, &estatus_node->task_work,
-					    TWA_RESUME);
-			if (ret)
-				estatus_node->task_work.func = NULL;
-		}
-
-		if (!estatus_node->task_work.func)
-			gen_pool_free(ghes_estatus_pool,
-				      (unsigned long)estatus_node, node_len);
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+			      node_len);
 
 		llnode = next;
 	}
@@ -1096,7 +1111,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
-	estatus_node->task_work.func = NULL;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 
 	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 3c8bba9f1114..e5e0c308d27f 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -35,9 +35,6 @@ struct ghes_estatus_node {
 	struct llist_node llnode;
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes;
-
-	int task_work_cpu;
-	struct callback_head task_work;
 };
 
 struct ghes_estatus_cache {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fae9baf3be16..6ea8c325acb3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2355,19 +2355,6 @@ static void memory_failure_work_func(struct work_struct *work)
 	}
 }
 
-/*
- * Process memory_failure work queued on the specified CPU.
- * Used to avoid return-to-userspace racing with the memory_failure workqueue.
- */
-void memory_failure_queue_kick(int cpu)
-{
-	struct memory_failure_cpu *mf_cpu;
-
-	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
-}
-
 static int __init memory_failure_init(void)
 {
 	struct memory_failure_cpu *mf_cpu;
-- 
2.20.1.12.g72788fdb

