Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C6644815
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiLFPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiLFPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:34:07 -0500
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AB52B26B;
        Tue,  6 Dec 2022 07:34:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=16;SR=0;TI=SMTPD_---0VWhZY-U_1670340840;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWhZY-U_1670340840)
          by smtp.aliyun-inc.com;
          Tue, 06 Dec 2022 23:34:01 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [RFC PATCH 2/2] ACPI: APEI: separate synchronous error handling into task work
Date:   Tue,  6 Dec 2022 23:33:54 +0800
Message-Id: <20221206153354.92394-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Arm64 platform, errors could be signaled by synchronous interrupt, e.g.
when an error is detected by a background scrubber, or signaled by
synchronous exception, e.g. when an uncorrected error is consumed. Both
synchronous and asynchronous error are queued and handled by a dedicated
kthread in workqueue.

commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
synchronous errors") keep track of whether memory_failure() work was
queued, and make task_work pending to flush out the workqueue so that the
work for synchronous error is processed before returning to user-space.
The trick ensures that the corrupted page is unmapped and poisoned. And
after returning to user-space, the task starts at current instruction which
triggering a page fault and kernel will send sigbus due to
VM_FAULT_HWPOISON.

Although the task could be killed by page fault, the memory failure is
handled in a kthread context so that the hwpoison-aware mechanisms, e.g.
PF_MCE_EARLY, early kill, does not work as expected.

To this end, separate synchronous and asynchronous error handling into
different paths like X86 does:

- task work for synchronous error.
- and workqueue for asynchronous error.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 118 ++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a420759fce2d..f13c298f47e6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -421,46 +421,80 @@ static void ghes_clear_estatus(struct ghes *ghes,
 		ghes_ack_error(ghes->generic_v2);
 }
 
-/*
- * Called as task_work before returning to user-space.
- * Ensure any queued work has been done before we return to the context that
- * triggered the notification.
+/**
+ * struct mce_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                fine tune action taken
+ *
+ * Structure to pass task work to be handled before
+ * returning to userspace via task_work_add().
  */
-static void ghes_kick_task_work(struct callback_head *head)
+struct mce_task_work {
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
+	struct mce_task_work *twcb =
+		container_of(twork, struct mce_task_work, twork);
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	kfree(twcb);
 
-	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
-	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		memory_failure_queue_kick(estatus_node->task_work_cpu);
+	if (!ret)
+		return;
+	/*
+	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
+	 * to the current process with the proper error info,
+	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
+	 *
+	 * In both cases, no further processing is required.
+	 */
+	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
 
-	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
-	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
+	pr_err("Memory error not recovered");
+	force_sig(SIGBUS);
 }
 
-static bool ghes_do_memory_failure(u64 physical_addr, int flags)
+static void ghes_do_memory_failure(u64 physical_addr, int flags)
 {
 	unsigned long pfn;
+	struct mce_task_work *twcb;
 
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
 	}
 
-	memory_failure_queue(pfn, flags);
-	return true;
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
+	} else {
+		memory_failure_queue(pfn, flags);
+	}
+
+	return;
 }
 
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 				       int sev)
 {
 	int flags = -1;
@@ -468,7 +502,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
+		return;
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
@@ -478,15 +512,12 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 		flags = (gdata->flags & CPER_SEC_SYNC) ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
-
-	return false;
+		ghes_do_memory_failure(mem_err->physical_addr, flags);
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-	bool queued = false;
 	int sec_sev, i;
 	char *p;
 
@@ -494,7 +525,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 
 	sec_sev = ghes_severity(gdata->error_severity);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
-		return false;
+		return;
 
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
@@ -510,7 +541,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			ghes_do_memory_failure(err_info->physical_fault_addr, 0);
 			p += err_info->length;
 			continue;
 		}
@@ -524,7 +555,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		p += err_info->length;
 	}
 
-	return queued;
+	return;
 }
 
 /*
@@ -622,7 +653,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
-static bool ghes_do_proc(struct ghes *ghes,
+static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
@@ -630,7 +661,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 	guid_t *sec_type;
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
-	bool queued = false;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -648,13 +678,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			ghes_handle_memory_failure(gdata, sev);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			ghes_handle_arm_hw_error(gdata, sev);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
@@ -664,8 +694,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 					       gdata->error_data_length);
 		}
 	}
-
-	return queued;
 }
 
 static void __ghes_print_estatus(const char *pfx,
@@ -961,9 +989,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	bool task_work_pending;
 	u32 len, node_len;
-	int ret;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -978,26 +1004,15 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
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
-
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+			      node_len);
 		llnode = next;
 	}
 }
@@ -1057,7 +1072,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
-	estatus_node->task_work.func = NULL;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 
 	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
-- 
2.20.1.12.g72788fdb

