Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19B25FCE37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJLWM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJLWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D579FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE0E61631
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B779C433D6;
        Wed, 12 Oct 2022 22:11:24 +0000 (UTC)
Date:   Wed, 12 Oct 2022 18:11:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing: Fixes for 6.1
Message-ID: <20221012181123.7a510a66@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Of course after my pull request is accepted for the merge window, I
discover a nasty bug in the code (and I added a couple of small fixes
as well)

Tracing fixes for 6.1:

- Found that the synthetic events were using strlen/strscpy() on values
  that could have come from userspace, and that is bad.
  Consolidate the string logic of kprobe and eprobe and extend it to
  the synthetic events to safely process string addresses.

- Clean up content of text dump in ftrace_bug() where the output does not
  make char reads into signed and sign extending the byte output.

- Fix some kernel docs in the ring buffer code.


Please pull the latest trace-v6.1-1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.1-1

Tag SHA1: fd385f94a89bf0296a7bfebecb02bcc46594111c
Head SHA1: 0934ae9977c27133449b6dd8c6213970e7eece38


Jiapeng Chong (1):
      ring-buffer: Fix kernel-doc

Steven Rostedt (Google) (3):
      tracing: Move duplicate code of trace_kprobe/eprobe.c into header
      tracing: Add "(fault)" name injection to kernel probes
      tracing: Fix reading strings from synthetic events

Zheng Yejian (1):
      ftrace: Fix char print issue in print_ip_ins()

----
 kernel/trace/ftrace.c             |   5 +-
 kernel/trace/ring_buffer.c        |   6 +-
 kernel/trace/trace_eprobe.c       |  60 ++------------------
 kernel/trace/trace_events_synth.c |  23 ++++++--
 kernel/trace/trace_kprobe.c       |  60 ++------------------
 kernel/trace/trace_probe_kernel.h | 115 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 146 insertions(+), 123 deletions(-)
 create mode 100644 kernel/trace/trace_probe_kernel.h
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83362a155791..75c16215d065 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2028,7 +2028,6 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 static void print_ip_ins(const char *fmt, const unsigned char *p)
 {
 	char ins[MCOUNT_INSN_SIZE];
-	int i;
 
 	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
 		printk(KERN_CONT "%s[FAULT] %px\n", fmt, p);
@@ -2036,9 +2035,7 @@ static void print_ip_ins(const char *fmt, const unsigned char *p)
 	}
 
 	printk(KERN_CONT "%s", fmt);
-
-	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
-		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);
+	pr_cont("%*phC", MCOUNT_INSN_SIZE, ins);
 }
 
 enum ftrace_bug_type ftrace_bug_type;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c3f354cfc5ba..199759c73519 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -885,7 +885,7 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
 }
 
 /**
- * ring_buffer_nr_pages_dirty - get the number of used pages in the ring buffer
+ * ring_buffer_nr_dirty_pages - get the number of used pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
  * @cpu: The cpu of the ring_buffer to get the number of pages from
  *
@@ -5305,7 +5305,7 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
 /**
- * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
+ * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
  * @cpu: The CPU buffer to be reset
  */
@@ -5375,7 +5375,7 @@ void ring_buffer_reset(struct trace_buffer *buffer)
 EXPORT_SYMBOL_GPL(ring_buffer_reset);
 
 /**
- * rind_buffer_empty - is the ring buffer empty?
+ * ring_buffer_empty - is the ring buffer empty?
  * @buffer: The ring buffer to test
  */
 bool ring_buffer_empty(struct trace_buffer *buffer)
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index c08bde9871ec..5dd0617e5df6 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -16,6 +16,7 @@
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
+#include "trace_probe_kernel.h"
 
 #define EPROBE_EVENT_SYSTEM "eprobes"
 
@@ -456,29 +457,14 @@ NOKPROBE_SYMBOL(process_fetch_insn)
 static nokprobe_inline int
 fetch_store_strlen_user(unsigned long addr)
 {
-	const void __user *uaddr =  (__force const void __user *)addr;
-
-	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
+	return kern_fetch_store_strlen_user(addr);
 }
 
 /* Return the length of string -- including null terminal byte */
 static nokprobe_inline int
 fetch_store_strlen(unsigned long addr)
 {
-	int ret, len = 0;
-	u8 c;
-
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if (addr < TASK_SIZE)
-		return fetch_store_strlen_user(addr);
-#endif
-
-	do {
-		ret = copy_from_kernel_nofault(&c, (u8 *)addr + len, 1);
-		len++;
-	} while (c && ret == 0 && len < MAX_STRING_SIZE);
-
-	return (ret < 0) ? ret : len;
+	return kern_fetch_store_strlen(addr);
 }
 
 /*
@@ -488,21 +474,7 @@ fetch_store_strlen(unsigned long addr)
 static nokprobe_inline int
 fetch_store_string_user(unsigned long addr, void *dest, void *base)
 {
-	const void __user *uaddr =  (__force const void __user *)addr;
-	int maxlen = get_loc_len(*(u32 *)dest);
-	void *__dest;
-	long ret;
-
-	if (unlikely(!maxlen))
-		return -ENOMEM;
-
-	__dest = get_loc_data(dest, base);
-
-	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-
-	return ret;
+	return kern_fetch_store_string_user(addr, dest, base);
 }
 
 /*
@@ -512,29 +484,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 static nokprobe_inline int
 fetch_store_string(unsigned long addr, void *dest, void *base)
 {
-	int maxlen = get_loc_len(*(u32 *)dest);
-	void *__dest;
-	long ret;
-
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if ((unsigned long)addr < TASK_SIZE)
-		return fetch_store_string_user(addr, dest, base);
-#endif
-
-	if (unlikely(!maxlen))
-		return -ENOMEM;
-
-	__dest = get_loc_data(dest, base);
-
-	/*
-	 * Try to get string again, since the string can be changed while
-	 * probing.
-	 */
-	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-
-	return ret;
+	return kern_fetch_store_string(addr, dest, base);
 }
 
 static nokprobe_inline int
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 5e8c07aef071..e310052dc83c 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -17,6 +17,8 @@
 /* for gfp flag names */
 #include <linux/trace_events.h>
 #include <trace/events/mmflags.h>
+#include "trace_probe.h"
+#include "trace_probe_kernel.h"
 
 #include "trace_synth.h"
 
@@ -409,6 +411,7 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 {
 	unsigned int len = 0;
 	char *str_field;
+	int ret;
 
 	if (is_dynamic) {
 		u32 data_offset;
@@ -417,19 +420,27 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 		data_offset += event->n_u64 * sizeof(u64);
 		data_offset += data_size;
 
-		str_field = (char *)entry + data_offset;
-
-		len = strlen(str_val) + 1;
-		strscpy(str_field, str_val, len);
+		len = kern_fetch_store_strlen((unsigned long)str_val);
 
 		data_offset |= len << 16;
 		*(u32 *)&entry->fields[*n_u64] = data_offset;
 
+		ret = kern_fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
+
 		(*n_u64)++;
 	} else {
 		str_field = (char *)&entry->fields[*n_u64];
 
-		strscpy(str_field, str_val, STR_VAR_LEN_MAX);
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+		if ((unsigned long)str_val < TASK_SIZE)
+			ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
+		else
+#endif
+			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
+
+		if (ret < 0)
+			strcpy(str_field, FAULT_STRING);
+
 		(*n_u64) += STR_VAR_LEN_MAX / sizeof(u64);
 	}
 
@@ -462,7 +473,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		val_idx = var_ref_idx[field_pos];
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
-		len = strlen(str_val) + 1;
+		len = kern_fetch_store_strlen((unsigned long)str_val);
 
 		fields_size += len;
 	}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23f7f0ec4f4c..5a75b039e586 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -20,6 +20,7 @@
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
+#include "trace_probe_kernel.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
@@ -1223,29 +1224,14 @@ static const struct file_operations kprobe_profile_ops = {
 static nokprobe_inline int
 fetch_store_strlen_user(unsigned long addr)
 {
-	const void __user *uaddr =  (__force const void __user *)addr;
-
-	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
+	return kern_fetch_store_strlen_user(addr);
 }
 
 /* Return the length of string -- including null terminal byte */
 static nokprobe_inline int
 fetch_store_strlen(unsigned long addr)
 {
-	int ret, len = 0;
-	u8 c;
-
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if (addr < TASK_SIZE)
-		return fetch_store_strlen_user(addr);
-#endif
-
-	do {
-		ret = copy_from_kernel_nofault(&c, (u8 *)addr + len, 1);
-		len++;
-	} while (c && ret == 0 && len < MAX_STRING_SIZE);
-
-	return (ret < 0) ? ret : len;
+	return kern_fetch_store_strlen(addr);
 }
 
 /*
@@ -1255,21 +1241,7 @@ fetch_store_strlen(unsigned long addr)
 static nokprobe_inline int
 fetch_store_string_user(unsigned long addr, void *dest, void *base)
 {
-	const void __user *uaddr =  (__force const void __user *)addr;
-	int maxlen = get_loc_len(*(u32 *)dest);
-	void *__dest;
-	long ret;
-
-	if (unlikely(!maxlen))
-		return -ENOMEM;
-
-	__dest = get_loc_data(dest, base);
-
-	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-
-	return ret;
+	return kern_fetch_store_string_user(addr, dest, base);
 }
 
 /*
@@ -1279,29 +1251,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 static nokprobe_inline int
 fetch_store_string(unsigned long addr, void *dest, void *base)
 {
-	int maxlen = get_loc_len(*(u32 *)dest);
-	void *__dest;
-	long ret;
-
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if ((unsigned long)addr < TASK_SIZE)
-		return fetch_store_string_user(addr, dest, base);
-#endif
-
-	if (unlikely(!maxlen))
-		return -ENOMEM;
-
-	__dest = get_loc_data(dest, base);
-
-	/*
-	 * Try to get string again, since the string can be changed while
-	 * probing.
-	 */
-	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-
-	return ret;
+	return kern_fetch_store_string(addr, dest, base);
 }
 
 static nokprobe_inline int
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
new file mode 100644
index 000000000000..77dbd9ff9782
--- /dev/null
+++ b/kernel/trace/trace_probe_kernel.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TRACE_PROBE_KERNEL_H_
+#define __TRACE_PROBE_KERNEL_H_
+
+#define FAULT_STRING "(fault)"
+
+/*
+ * This depends on trace_probe.h, but can not include it due to
+ * the way trace_probe_tmpl.h is used by trace_kprobe.c and trace_eprobe.c.
+ * Which means that any other user must include trace_probe.h before including
+ * this file.
+ */
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+kern_fetch_store_strlen_user(unsigned long addr)
+{
+	const void __user *uaddr =  (__force const void __user *)addr;
+	int ret;
+
+	ret = strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
+	/*
+	 * strnlen_user_nofault returns zero on fault, insert the
+	 * FAULT_STRING when that occurs.
+	 */
+	if (ret <= 0)
+		return strlen(FAULT_STRING) + 1;
+	return ret;
+}
+
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+kern_fetch_store_strlen(unsigned long addr)
+{
+	int ret, len = 0;
+	u8 c;
+
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if (addr < TASK_SIZE)
+		return kern_fetch_store_strlen_user(addr);
+#endif
+
+	do {
+		ret = copy_from_kernel_nofault(&c, (u8 *)addr + len, 1);
+		len++;
+	} while (c && ret == 0 && len < MAX_STRING_SIZE);
+
+	/* For faults, return enough to hold the FAULT_STRING */
+	return (ret < 0) ? strlen(FAULT_STRING) + 1 : len;
+}
+
+static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
+{
+	if (ret >= 0) {
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
+	} else {
+		strscpy(__dest, FAULT_STRING, len);
+		ret = strlen(__dest) + 1;
+	}
+}
+
+/*
+ * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+kern_fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	const void __user *uaddr =  (__force const void __user *)addr;
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+	long ret;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
+	set_data_loc(ret, dest, __dest, base, maxlen);
+
+	return ret;
+}
+
+/*
+ * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
+ * length and relative data location.
+ */
+static nokprobe_inline int
+kern_fetch_store_string(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+	long ret;
+
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if ((unsigned long)addr < TASK_SIZE)
+		return kern_fetch_store_string_user(addr, dest, base);
+#endif
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	/*
+	 * Try to get string again, since the string can be changed while
+	 * probing.
+	 */
+	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
+	set_data_loc(ret, dest, __dest, base, maxlen);
+
+	return ret;
+}
+
+#endif /* __TRACE_PROBE_KERNEL_H_ */
