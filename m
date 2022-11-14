Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F683628360
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiKNPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiKNPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:00:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265691DA67;
        Mon, 14 Nov 2022 07:00:54 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9stZ6cXnzHw1J;
        Mon, 14 Nov 2022 23:00:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 23:00:51 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <bp@alien8.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <lvying6@huawei.com>
Subject: [PATCH] arm64: fix error unhandling in synchronous External Data Abort
Date:   Mon, 14 Nov 2022 23:19:15 +0800
Message-ID: <20221114151915.167414-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RAS documentation, if we cannot determine the impact
of the error based on the details of the error when an SEA occurs, the
process cannot safely continue to run. Therefore, for unhandled error,
we should signal the system and terminate the process immediately.

2.2 Generating error exceptions:
  "An error exception is generated when a detected error is signaled
  to the PE as an in-band error response to an architecturally-executed
  memory access or cache maintenance operation. This includes any explicit
  data access, instruction fetch, translation table walk, or hardware
  update to the translation tables made by an architecturally-executed
  instruction." [1]

2.3 Taking error exceptions:
  Software is only able to successfully recover execution and make progress
  from a restart address for the exception by executing an Exception Return
  instruction to branch to the instruction at this restart address if all
  of the following are true: [2]
    - The error has not been silently propagated by the PE.
    - At the point when the Exception Return instruction is executed, the
      PE state and memory system state are consistent with the PE having
      executed all of the instructions up to but not including the
      instruction at the restart address, and none afterwards. That is,
      at least one of the following restart conditions is true:
        - The error has been not architecturally consumed by the PE
          andinfected the PE state.
        - Executing the instruction at the restart address will not consume
          the error and will correct any corrupt state by overwriting it
          with the correct value or values

After commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise
with APEI's irq work"), we deferred de SEA process to irq_work.
For example, an memory reading error without valid pa, the process isn't
been terminated. It is not safe.

In this patch, a SIGBUS is force signaled to fix this case.

Note:
RAS documentation: https://developer.arm.com/documentation/ddi0587/latest

Fixes: 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/kernel/acpi.c      |  6 ++++++
 drivers/acpi/apei/apei-base.c |  4 ++++
 drivers/acpi/apei/ghes.c      | 14 +++++++++++---
 include/acpi/apei.h           |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index a5a256e3f9fe..a8cb02ddaf33 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -32,6 +32,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/daifflags.h>
 #include <asm/smp_plat.h>
+#include <asm/traps.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -407,6 +408,11 @@ int apei_claim_sea(struct pt_regs *regs)
 	return err;
 }
 
+void arch_apei_do_unhandled_sea(void)
+{
+	arm64_force_sig_mceerr(BUS_MCEERR_AR, 0, 0, "Unhandled processor error");
+}
+
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
 	memblock_mark_nomap(addr, size);
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 9b52482b4ed5..f372cf872125 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -773,6 +773,10 @@ void __weak arch_apei_report_mem_error(int sev,
 }
 EXPORT_SYMBOL_GPL(arch_apei_report_mem_error);
 
+void __weak arch_apei_do_unhandled_sea(void)
+{
+}
+
 int apei_osc_setup(void)
 {
 	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9952f3a792ba..7da39da4577a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -48,6 +48,7 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <ras/ras_event.h>
+#include <asm/traps.h>
 
 #include "apei-internal.h"
 
@@ -483,11 +484,12 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+				     int sev, int type)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	bool queued = false;
-	int sec_sev, i;
+	int sec_sev, i, unhandled_err_count = 0;
 	char *p;
 
 	log_arm_hw_error(err);
@@ -521,9 +523,14 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 				    "Unhandled processor error type: %s\n",
 				    error_type);
+		unhandled_err_count++;
+
 		p += err_info->length;
 	}
 
+	if (unhandled_err_count && type == ACPI_HEST_NOTIFY_SEA)
+		arch_apei_do_unhandled_sea();
+
 	return queued;
 }
 
@@ -631,6 +638,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	int type = ghes->generic->notify.type;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -654,7 +662,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			queued = ghes_handle_arm_hw_error(gdata, sev, type);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524..663db1f9556f 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -52,6 +52,7 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+void arch_apei_do_unhandled_sea(void);
 
 #endif
 #endif
-- 
2.20.1

