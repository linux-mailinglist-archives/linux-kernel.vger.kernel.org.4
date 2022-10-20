Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B7605C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJTKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:21:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A49337C75F;
        Thu, 20 Oct 2022 03:20:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA2EB1063;
        Thu, 20 Oct 2022 03:20:49 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.5.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE2E23F792;
        Thu, 20 Oct 2022 03:20:40 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
Date:   Thu, 20 Oct 2022 11:19:20 +0100
Message-Id: <20221020101921.1219533-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20221020101921.1219533-1-james.clark@arm.com>
References: <20221020101921.1219533-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Kilroy <andrew.kilroy@arm.com>

Perf report cannot produce callgraphs using dwarf on arm64 where pointer
authentication is enabled.  This is because libunwind and libdw cannot
unmangle instruction pointers that have a pointer authentication code
(PAC) embedded in them.

libunwind and libdw need to be given an instruction mask which they can
use to arrive at the correct return address that does not contain the
PAC.

The bits in the return address that contain the PAC can differ by
process, so this patch adds a new sample field PERF_SAMPLE_ARCH_1
to allow the kernel to send the masks up to userspace perf.

This field can be used in a architecture specific fashion, but on
arm64, it contains the ptrauth mask information. The event will
currently fail to open on architectures other than arm64 if
PERF_SAMPLE_ARCH_1 is set. It will also fail to open on arm64 if
CONFIG_ARM64_PTR_AUTH isn't set, as the data would always be zeros.

Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/perf_event.h | 32 +++++++++++++++++++++++++++++
 arch/arm64/kernel/perf_event.c      | 32 +++++++++++++++++++++++++++++
 include/linux/perf_event.h          | 12 +++++++++++
 include/uapi/linux/perf_event.h     |  4 +++-
 kernel/events/core.c                | 31 ++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 3eaf462f5752..160fdb8fca1c 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -273,4 +273,36 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
 
+#ifdef CONFIG_ARM64_PTR_AUTH
+#define HAS_ARCH_SAMPLE_DATA
+/*
+ * Structure holding masks to help userspace stack unwinding
+ * in the presence of arm64 pointer authentication.
+ */
+struct ptrauth_info {
+	/*
+	 * Bits 0, 1, 2, 3, 4 may be set to on, to indicate which keys are being used
+	 * The APIAKEY, APIBKEY, APDAKEY, APDBKEY, or the APGAKEY respectively.
+	 * Where all bits are off, pointer authentication is not in use for the
+	 * process.
+	 */
+	u64 enabled_keys;
+
+	/*
+	 * The on bits represent which bits in an instruction pointer
+	 * constitute the pointer authentication code.
+	 */
+	u64 insn_mask;
+
+	/*
+	 * The on bits represent which bits in a data pointer constitute the
+	 * pointer authentication code.
+	 */
+	u64 data_mask;
+};
+
+struct arch_sample_data {
+	struct ptrauth_info ptrauth;
+};
+#endif /* CONFIG_ARM64_PTR_AUTH */
 #endif
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..9c209168e055 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1459,3 +1459,35 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 1;
 	userpg->cap_user_time_short = 1;
 }
+
+#ifdef CONFIG_ARM64_PTR_AUTH
+void perf_output_sample_arch_1(struct perf_output_handle *handle,
+			       struct perf_event_header *header,
+			       struct perf_sample_data *data,
+			       struct perf_event *event)
+{
+	perf_output_put(handle, data->arch.ptrauth.enabled_keys);
+	perf_output_put(handle, data->arch.ptrauth.insn_mask);
+	perf_output_put(handle, data->arch.ptrauth.data_mask);
+}
+
+void perf_prepare_sample_arch_1(struct perf_event_header *header,
+				struct perf_sample_data *data,
+				struct perf_event *event,
+				struct pt_regs *regs)
+{
+	int keys_result = ptrauth_get_enabled_keys(current);
+	u64 user_pac_mask = keys_result > 0 ? ptrauth_user_pac_mask() : 0;
+
+	data->arch.ptrauth.enabled_keys = keys_result > 0 ? keys_result : 0;
+	data->arch.ptrauth.insn_mask = user_pac_mask;
+	data->arch.ptrauth.data_mask = user_pac_mask;
+
+	header->size += (3 * sizeof(u64));
+}
+
+int perf_event_open_request_arch_1(void)
+{
+	return 0;
+}
+#endif /* CONFIG_ARM64_PTR_AUTH */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 853f64b6c8c2..f6b0cc93faae 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1065,6 +1065,9 @@ struct perf_sample_data {
 	u64				cgroup;
 	u64				data_page_size;
 	u64				code_page_size;
+#ifdef HAS_ARCH_SAMPLE_DATA
+	struct arch_sample_data		arch;
+#endif
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -1674,6 +1677,15 @@ int perf_event_exit_cpu(unsigned int cpu);
 extern void __weak arch_perf_update_userpage(struct perf_event *event,
 					     struct perf_event_mmap_page *userpg,
 					     u64 now);
+extern void perf_output_sample_arch_1(struct perf_output_handle *handle,
+				      struct perf_event_header *header,
+				      struct perf_sample_data *data,
+				      struct perf_event *event);
+extern void perf_prepare_sample_arch_1(struct perf_event_header *header,
+				       struct perf_sample_data *data,
+				       struct perf_event *event,
+				       struct pt_regs *regs);
+extern int perf_event_open_request_arch_1(void);
 
 #ifdef CONFIG_MMU
 extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 85be78e0e7f6..3c8349111422 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -162,10 +162,12 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_ARCH_1			= 1U << 25,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 26,		/* non-ABI */
 };
 
+#define PERF_SAMPLE_ARM64_PTRAUTH PERF_SAMPLE_ARCH_1
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
 /*
  * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b981b879bcd8..8ca0501d608d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5822,6 +5822,25 @@ void __weak arch_perf_update_userpage(
 {
 }
 
+void __weak perf_output_sample_arch_1(struct perf_output_handle *handle,
+			       struct perf_event_header *header,
+			       struct perf_sample_data *data,
+			       struct perf_event *event)
+{
+}
+
+void __weak perf_prepare_sample_arch_1(struct perf_event_header *header,
+				struct perf_sample_data *data,
+				struct perf_event *event,
+				struct pt_regs *regs)
+{
+}
+
+int __weak perf_event_open_request_arch_1(void)
+{
+	return -EINVAL;
+}
+
 /*
  * Callers need to ensure there can be no nesting of this function, otherwise
  * the seqlock logic goes bad. We can not serialize this because the arch
@@ -7142,6 +7161,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_aux_sample_output(event, handle, data);
 	}
 
+	if (sample_type & PERF_SAMPLE_ARCH_1)
+		perf_output_sample_arch_1(handle, header, data, event);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -7466,6 +7488,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		data->code_page_size = perf_get_page_size(data->ip);
 
+	if (sample_type & PERF_SAMPLE_ARCH_1)
+		perf_prepare_sample_arch_1(header, data, event, regs);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
@@ -12140,6 +12165,12 @@ SYSCALL_DEFINE5(perf_event_open,
 			return err;
 	}
 
+	if (attr.sample_type & PERF_SAMPLE_ARCH_1) {
+		err = perf_event_open_request_arch_1();
+		if (err)
+			return err;
+	}
+
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
-- 
2.28.0

