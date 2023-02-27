Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598266A3A42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjB0FDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0FD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:03:28 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301FC67A;
        Sun, 26 Feb 2023 21:03:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VcW98nR_1677474201;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VcW98nR_1677474201)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 13:03:22 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     xiexiuqi@huawei.com, lvying6@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events
Date:   Mon, 27 Feb 2023 13:03:14 +0800
Message-Id: <20230227050315.5670-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two major types of uncorrected recoverable (UCR) errors :

- Action Required (AR): The error is detected and the processor already
  consumes the memory. OS requires to take action (for example, offline
  failure page/kill failure thread) to recover this uncorrectable error.

- Action Optional (AO): The error is detected out of processor execution
  context. Some data in the memory are corrupted. But the data have not
  been consumed. OS is optional to take action to recover this
  uncorrectable error.

The essential difference between AR and AO errors is that AR is a
synchronous event, while AO is an asynchronous event. The hardware will
signal a synchronous exception (Machine Check Exception on X86 and
Synchronous External Abort on Arm64) when an error is detected and the
memory access has been architecturally executed.

When APEI firmware first is enabled, a platform may describe one error
source for the handling of synchronous errors (e.g. MCE or SEA notification
), or for handling asynchronous errors (e.g. SCI or External Interrupt
notification). In other words, we can distinguish synchronous errors by
APEI notification. For AR errors, kernel will kill current process
accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
addition, for AO errors, kernel will notify the process who owns the
poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
However, the GHES driver always sets mf_flags to 0 so that all UCR errors
are handled as AO errors in memory failure.

To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
events.

Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 34ad071a64e9..5d37fb4bca67 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -101,6 +101,19 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
 }
 
+/*
+ * A platform may describe one error source for the handling of synchronous
+ * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
+ * or External Interrupt).
+ */
+static inline bool is_hest_sync_notify(struct ghes *ghes)
+{
+	int notify_type = ghes->generic->notify.type;
+
+	return notify_type == ACPI_HEST_NOTIFY_SEA ||
+	       notify_type == ACPI_HEST_NOTIFY_MCE;
+}
+
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -477,7 +490,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -491,7 +504,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -499,12 +512,14 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	log_arm_hw_error(err);
 
@@ -526,7 +541,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -647,6 +662,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	bool sync = is_hest_sync_notify(ghes);
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -664,13 +680,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			queued = ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.20.1.12.g72788fdb

