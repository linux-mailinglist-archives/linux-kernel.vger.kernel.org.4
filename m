Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191C4620CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiKHKAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiKHKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:00:32 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A5EB2871E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:00:27 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:36708.1272434672
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 0C7431002BF;
        Tue,  8 Nov 2022 18:00:18 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-787c977d48-v8sdr with ESMTP id 546c366707c54507a03a5aad793ecf21 for rostedt@goodmis.org;
        Tue, 08 Nov 2022 18:00:26 CST
X-Transaction-ID: 546c366707c54507a03a5aad793ecf21
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH RFC] kernel/trace: move functions in trace_probe_tmpl.h to trace_probe.c
Date:   Tue,  8 Nov 2022 18:05:58 +0800
Message-Id: <1667901958-3991-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found there are simlilar implementation of functions like
process_fetch_insn, fetch_store* and probe_mem* respectively in
kprobe/uprobe/eprobe, they have a lot in common and their differences
can be merged. I have tried this idea in them and passed the selftest,
below is the report:

1, sudo ./ftracetest test.d/kprobe/
[sudo] kylin 的密码：
=== Ftrace unit tests ===
[1] Kprobe dynamic event - adding and removing	[PASS]
......
[12] Kprobe dynamic event - probing module	[UNRESOLVED]
......
[21] Uprobe event parser error log check	[PASS]

2, sudo ./ftracetest test.d/dynevent/
=== Ftrace unit tests ===
[1] Generic dynamic event - add/remove eprobe events	[PASS]
[2] Generic dynamic event - add/remove kprobe events	[PASS]
......

You may have had the same idea at the first place, then turned to
put those functions in trace_probe_tmpl.h for the reason i'm not
aware of. Nevertheless, let me know if you like this idea.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/trace_eprobe.c | 194 +--------------
 kernel/trace/trace_kprobe.c | 125 +---------
 kernel/trace/trace_probe.c  | 468 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  11 +
 kernel/trace/trace_uprobe.c | 177 +-------------
 5 files changed, 499 insertions(+), 476 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5dd0617e5df6..e6de612aa4e0 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -15,8 +15,6 @@
 
 #include "trace_dynevent.h"
 #include "trace_probe.h"
-#include "trace_probe_tmpl.h"
-#include "trace_probe_kernel.h"
 
 #define EPROBE_EVENT_SYSTEM "eprobes"
 
@@ -310,7 +308,7 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	if (print_probe_args(s, tp->args, tp->nr_args,
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
 			     (u8 *)&field[1], field) < 0)
 		goto out;
 
@@ -319,192 +317,6 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	return trace_handle_return(s);
 }
 
-static unsigned long get_event_field(struct fetch_insn *code, void *rec)
-{
-	struct ftrace_event_field *field = code->data;
-	unsigned long val;
-	void *addr;
-
-	addr = rec + field->offset;
-
-	if (is_string_field(field)) {
-		switch (field->filter_type) {
-		case FILTER_DYN_STRING:
-			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
-			break;
-		case FILTER_RDYN_STRING:
-			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
-			break;
-		case FILTER_STATIC_STRING:
-			val = (unsigned long)addr;
-			break;
-		case FILTER_PTR_STRING:
-			val = (unsigned long)(*(char *)addr);
-			break;
-		default:
-			WARN_ON_ONCE(1);
-			return 0;
-		}
-		return val;
-	}
-
-	switch (field->size) {
-	case 1:
-		if (field->is_signed)
-			val = *(char *)addr;
-		else
-			val = *(unsigned char *)addr;
-		break;
-	case 2:
-		if (field->is_signed)
-			val = *(short *)addr;
-		else
-			val = *(unsigned short *)addr;
-		break;
-	case 4:
-		if (field->is_signed)
-			val = *(int *)addr;
-		else
-			val = *(unsigned int *)addr;
-		break;
-	default:
-		if (field->is_signed)
-			val = *(long *)addr;
-		else
-			val = *(unsigned long *)addr;
-		break;
-	}
-	return val;
-}
-
-static int get_eprobe_size(struct trace_probe *tp, void *rec)
-{
-	struct fetch_insn *code;
-	struct probe_arg *arg;
-	int i, len, ret = 0;
-
-	for (i = 0; i < tp->nr_args; i++) {
-		arg = tp->args + i;
-		if (arg->dynamic) {
-			unsigned long val;
-
-			code = arg->code;
- retry:
-			switch (code->op) {
-			case FETCH_OP_TP_ARG:
-				val = get_event_field(code, rec);
-				break;
-			case FETCH_OP_IMM:
-				val = code->immediate;
-				break;
-			case FETCH_OP_COMM:
-				val = (unsigned long)current->comm;
-				break;
-			case FETCH_OP_DATA:
-				val = (unsigned long)code->data;
-				break;
-			case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
-				code++;
-				goto retry;
-			default:
-				continue;
-			}
-			code++;
-			len = process_fetch_insn_bottom(code, val, NULL, NULL);
-			if (len > 0)
-				ret += len;
-		}
-	}
-
-	return ret;
-}
-
-/* Kprobe specific fetch functions */
-
-/* Note that we don't verify it, since the code does not come from user space */
-static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
-{
-	unsigned long val;
-
- retry:
-	switch (code->op) {
-	case FETCH_OP_TP_ARG:
-		val = get_event_field(code, rec);
-		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = (unsigned long)current->comm;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
-	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
-		code++;
-		goto retry;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-	return process_fetch_insn_bottom(code, val, dest, base);
-}
-NOKPROBE_SYMBOL(process_fetch_insn)
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen_user(unsigned long addr)
-{
-	return kern_fetch_store_strlen_user(addr);
-}
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen(unsigned long addr)
-{
-	return kern_fetch_store_strlen(addr);
-}
-
-/*
- * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
- * with max length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string_user(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string_user(addr, dest, base);
-}
-
-/*
- * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
- * length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string(addr, dest, base);
-}
-
-static nokprobe_inline int
-probe_mem_read_user(void *dest, void *src, size_t size)
-{
-	const void __user *uaddr =  (__force const void __user *)src;
-
-	return copy_from_user_nofault(dest, uaddr, size);
-}
-
-static nokprobe_inline int
-probe_mem_read(void *dest, void *src, size_t size)
-{
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if ((unsigned long)src < TASK_SIZE)
-		return probe_mem_read_user(dest, src, size);
-#endif
-	return copy_from_kernel_nofault(dest, src, size);
-}
-
 /* eprobe handler */
 static inline void
 __eprobe_trace_func(struct eprobe_data *edata, void *rec)
@@ -520,7 +332,7 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
 	if (trace_trigger_soft_disabled(edata->file))
 		return;
 
-	dsize = get_eprobe_size(&edata->ep->tp, rec);
+	dsize = trace_probe_get_data_size(&edata->ep->tp, rec);
 
 	entry = trace_event_buffer_reserve(&fbuffer, edata->file,
 					   sizeof(*entry) + edata->ep->tp.size + dsize);
@@ -529,7 +341,7 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
 		return;
 
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
-	store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
+	trace_probe_store_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5a75b039e586..d734602f2898 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -19,8 +19,6 @@
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
-#include "trace_probe_tmpl.h"
-#include "trace_probe_kernel.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
@@ -1218,109 +1216,6 @@ static const struct file_operations kprobe_profile_ops = {
 	.release        = seq_release,
 };
 
-/* Kprobe specific fetch functions */
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen_user(unsigned long addr)
-{
-	return kern_fetch_store_strlen_user(addr);
-}
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen(unsigned long addr)
-{
-	return kern_fetch_store_strlen(addr);
-}
-
-/*
- * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
- * with max length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string_user(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string_user(addr, dest, base);
-}
-
-/*
- * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
- * length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string(unsigned long addr, void *dest, void *base)
-{
-	return kern_fetch_store_string(addr, dest, base);
-}
-
-static nokprobe_inline int
-probe_mem_read_user(void *dest, void *src, size_t size)
-{
-	const void __user *uaddr =  (__force const void __user *)src;
-
-	return copy_from_user_nofault(dest, uaddr, size);
-}
-
-static nokprobe_inline int
-probe_mem_read(void *dest, void *src, size_t size)
-{
-#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	if ((unsigned long)src < TASK_SIZE)
-		return probe_mem_read_user(dest, src, size);
-#endif
-	return copy_from_kernel_nofault(dest, src, size);
-}
-
-/* Note that we don't verify it, since the code does not come from user space */
-static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
-{
-	struct pt_regs *regs = rec;
-	unsigned long val;
-
-retry:
-	/* 1st stage: get value from context */
-	switch (code->op) {
-	case FETCH_OP_REG:
-		val = regs_get_register(regs, code->param);
-		break;
-	case FETCH_OP_STACK:
-		val = regs_get_kernel_stack_nth(regs, code->param);
-		break;
-	case FETCH_OP_STACKP:
-		val = kernel_stack_pointer(regs);
-		break;
-	case FETCH_OP_RETVAL:
-		val = regs_return_value(regs);
-		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = (unsigned long)current->comm;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
-#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	case FETCH_OP_ARG:
-		val = regs_get_kernel_argument(regs, code->param);
-		break;
-#endif
-	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
-		code++;
-		goto retry;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-
-	return process_fetch_insn_bottom(code, val, dest, base);
-}
-NOKPROBE_SYMBOL(process_fetch_insn)
-
 /* Kprobe handler */
 static nokprobe_inline void
 __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
@@ -1336,7 +1231,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = trace_probe_get_data_size(&tk->tp, regs);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tk->tp.size + dsize);
@@ -1346,7 +1241,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	fbuffer.regs = regs;
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	trace_probe_store_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -1377,7 +1272,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = trace_probe_get_data_size(&tk->tp, regs);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tk->tp.size + dsize);
@@ -1388,7 +1283,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = get_kretprobe_retaddr(ri);
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	trace_probe_store_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -1426,7 +1321,7 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	if (print_probe_args(s, tp->args, tp->nr_args,
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
 			     (u8 *)&field[1], field) < 0)
 		goto out;
 
@@ -1461,7 +1356,7 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	if (print_probe_args(s, tp->args, tp->nr_args,
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
 			     (u8 *)&field[1], field) < 0)
 		goto out;
 
@@ -1536,7 +1431,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 	if (hlist_empty(head))
 		return 0;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = trace_probe_get_data_size(&tk->tp, regs);
 	__size = sizeof(*entry) + tk->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -1547,7 +1442,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	trace_probe_store_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -1572,7 +1467,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (hlist_empty(head))
 		return;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = trace_probe_get_data_size(&tk->tp, regs);
 	__size = sizeof(*entry) + tk->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -1583,7 +1478,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = get_kretprobe_retaddr(ri);
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	trace_probe_store_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 36dff277de46..ebee46a991d3 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include "trace_probe.h"
+#include "trace_probe_kernel.h"
 
 #undef C
 #define C(a, b)		b
@@ -1218,3 +1219,470 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 
 	return ret;
 }
+
+/*
+ * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
+ * length and relative data location.
+ */
+static nokprobe_inline int
+user_fetch_store_string(unsigned long addr, void *dest, void *base)
+{
+	long ret;
+	u32 loc = *(u32 *)dest;
+	int maxlen  = get_loc_len(loc);
+	u8 *dst = get_loc_data(dest, base);
+	void __user *src = (void __force __user *) addr;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	if (addr == FETCH_TOKEN_COMM)
+		ret = strlcpy(dst, current->comm, maxlen);
+	else
+		ret = strncpy_from_user(dst, src, maxlen);
+	if (ret >= 0) {
+		if (ret == maxlen)
+			dst[ret - 1] = '\0';
+		else
+			/*
+			 * Include the terminating null byte. In this case it
+			 * was copied by strncpy_from_user but not accounted
+			 * for in ret.
+			 */
+			ret++;
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
+	}
+
+	return ret;
+}
+
+static nokprobe_inline int
+user_fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	return user_fetch_store_string(addr, dest, base);
+}
+
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+user_fetch_store_strlen(unsigned long addr)
+{
+	int len;
+	void __user *vaddr = (void __force __user *) addr;
+
+	if (addr == FETCH_TOKEN_COMM)
+		len = strlen(current->comm) + 1;
+	else
+		len = strnlen_user(vaddr, MAX_STRING_SIZE);
+
+	return (len > MAX_STRING_SIZE) ? 0 : len;
+}
+
+static nokprobe_inline int
+user_fetch_store_strlen_user(unsigned long addr)
+{
+	return user_fetch_store_strlen(addr);
+}
+
+static nokprobe_inline void
+fetch_store_raw(unsigned long val, struct fetch_insn *code, void *buf)
+{
+	switch (code->size) {
+	case 1:
+		*(u8 *)buf = (u8)val;
+		break;
+	case 2:
+		*(u16 *)buf = (u16)val;
+		break;
+	case 4:
+		*(u32 *)buf = (u32)val;
+		break;
+	case 8:
+		//TBD: 32bit signed
+		*(u64 *)buf = (u64)val;
+		break;
+	default:
+		*(unsigned long *)buf = val;
+	}
+}
+
+static nokprobe_inline void
+fetch_apply_bitfield(struct fetch_insn *code, void *buf)
+{
+	switch (code->basesize) {
+	case 1:
+		*(u8 *)buf <<= code->lshift;
+		*(u8 *)buf >>= code->rshift;
+		break;
+	case 2:
+		*(u16 *)buf <<= code->lshift;
+		*(u16 *)buf >>= code->rshift;
+		break;
+	case 4:
+		*(u32 *)buf <<= code->lshift;
+		*(u32 *)buf >>= code->rshift;
+		break;
+	case 8:
+		*(u64 *)buf <<= code->lshift;
+		*(u64 *)buf >>= code->rshift;
+		break;
+	}
+}
+
+static nokprobe_inline int
+probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	const void __user *uaddr =  (__force const void __user *)src;
+
+	return copy_from_user_nofault(dest, uaddr, size);
+}
+
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size)
+{
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if ((unsigned long)src < TASK_SIZE)
+		return probe_mem_read_user(dest, src, size);
+#endif
+	return copy_from_kernel_nofault(dest, src, size);
+}
+
+/* From the 2nd stage, routine is same */
+static nokprobe_inline int
+process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
+			   void *dest, void *base, int flags)
+{
+	struct fetch_insn *s3 = NULL;
+	int total = 0, ret = 0, i = 0;
+	u32 loc = 0;
+	unsigned long lval = val;
+	int is_uprobe = flags & TRACE_EVENT_FL_UPROBE;
+
+stage2:
+	/* 2nd stage: dereference memory if needed */
+	do {
+		if (code->op == FETCH_OP_DEREF) {
+			lval = val;
+			ret = probe_mem_read(&val, (void *)val + code->offset,
+					     sizeof(val));
+		} else if (code->op == FETCH_OP_UDEREF) {
+			lval = val;
+			ret = probe_mem_read_user(&val,
+				 (void *)val + code->offset, sizeof(val));
+		} else
+			break;
+		if (ret)
+			return ret;
+		code++;
+	} while (1);
+
+	s3 = code;
+stage3:
+	/* 3rd stage: store value to buffer */
+	if (unlikely(!dest)) {
+		if (code->op == FETCH_OP_ST_STRING) {
+			if (is_uprobe)
+				ret = user_fetch_store_strlen(val + code->offset);
+			else
+				ret = kern_fetch_store_strlen(val + code->offset);
+			code++;
+			goto array;
+		} else if (code->op == FETCH_OP_ST_USTRING) {
+			if (is_uprobe)
+				ret += user_fetch_store_strlen_user(val + code->offset);
+			else
+				ret += kern_fetch_store_strlen_user(val + code->offset);
+			code++;
+			goto array;
+		} else
+			return -EILSEQ;
+	}
+
+	switch (code->op) {
+	case FETCH_OP_ST_RAW:
+		fetch_store_raw(val, code, dest);
+		break;
+	case FETCH_OP_ST_MEM:
+		probe_mem_read(dest, (void *)val + code->offset, code->size);
+		break;
+	case FETCH_OP_ST_UMEM:
+		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
+		break;
+	case FETCH_OP_ST_STRING:
+		loc = *(u32 *)dest;
+		if (is_uprobe)
+			ret = user_fetch_store_string(val + code->offset, dest, base);
+		else
+			ret = kern_fetch_store_string(val + code->offset, dest, base);
+		break;
+	case FETCH_OP_ST_USTRING:
+		loc = *(u32 *)dest;
+		if (is_uprobe)
+			ret = user_fetch_store_string_user(val + code->offset, dest, base);
+		else
+			ret = kern_fetch_store_string_user(val + code->offset, dest, base);
+		break;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	/* 4th stage: modify stored value if needed */
+	if (code->op == FETCH_OP_MOD_BF) {
+		fetch_apply_bitfield(code, dest);
+		code++;
+	}
+
+array:
+	/* the last stage: Loop on array */
+	if (code->op == FETCH_OP_LP_ARRAY) {
+		total += ret;
+		if (++i < code->param) {
+			code = s3;
+			if (s3->op != FETCH_OP_ST_STRING &&
+			    s3->op != FETCH_OP_ST_USTRING) {
+				dest += s3->size;
+				val += s3->size;
+				goto stage3;
+			}
+			code--;
+			val = lval + sizeof(char *);
+			if (dest) {
+				dest += sizeof(u32);
+				*(u32 *)dest = update_data_loc(loc, ret);
+			}
+			goto stage2;
+		}
+		code++;
+		ret = total;
+	}
+
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
+}
+
+static unsigned long get_event_field(struct fetch_insn *code, void *rec)
+{
+	struct ftrace_event_field *field = code->data;
+	unsigned long val;
+	void *addr;
+
+	addr = rec + field->offset;
+
+	if (is_string_field(field)) {
+		switch (field->filter_type) {
+		case FILTER_DYN_STRING:
+			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
+			break;
+		case FILTER_RDYN_STRING:
+			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
+			break;
+		case FILTER_STATIC_STRING:
+			val = (unsigned long)addr;
+			break;
+		case FILTER_PTR_STRING:
+			val = (unsigned long)(*(char *)addr);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return 0;
+		}
+		return val;
+	}
+
+	switch (field->size) {
+	case 1:
+		if (field->is_signed)
+			val = *(char *)addr;
+		else
+			val = *(unsigned char *)addr;
+		break;
+	case 2:
+		if (field->is_signed)
+			val = *(short *)addr;
+		else
+			val = *(unsigned short *)addr;
+		break;
+	case 4:
+		if (field->is_signed)
+			val = *(int *)addr;
+		else
+			val = *(unsigned int *)addr;
+		break;
+	default:
+		if (field->is_signed)
+			val = *(long *)addr;
+		else
+			val = *(unsigned long *)addr;
+		break;
+	}
+	return val;
+}
+
+#ifdef CONFIG_STACK_GROWSUP
+static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
+{
+	return addr - (n * sizeof(long));
+}
+#else
+static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
+{
+	return addr + (n * sizeof(long));
+}
+#endif
+
+static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long ret;
+	unsigned long addr = user_stack_pointer(regs);
+
+	addr = adjust_stack_addr(addr, n);
+
+	if (copy_from_user(&ret, (void __force __user *) addr, sizeof(ret)))
+		return 0;
+
+	return ret;
+}
+
+static unsigned long translate_user_vaddr(unsigned long file_offset)
+{
+	unsigned long base_addr;
+	struct uprobe_dispatch_data *udd;
+
+	udd = (void *) current->utask->vaddr;
+
+	base_addr = udd->bp_addr - udd->offset;
+	return base_addr + file_offset;
+}
+
+/* Note that we don't verify it, since the code does not come from user space */
+static int
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
+		   void *base, int flags)
+{
+	struct pt_regs *regs = rec;
+	unsigned long val;
+	int is_uprobe = flags & TRACE_EVENT_FL_UPROBE;
+
+retry:
+	/* 1st stage: get value from context */
+	switch (code->op) {
+	case FETCH_OP_REG:
+		val = regs_get_register(regs, code->param);
+		break;
+	case FETCH_OP_STACK:
+		if (is_uprobe)
+			val = get_user_stack_nth(regs, code->param);
+		else
+			val = regs_get_kernel_stack_nth(regs, code->param);
+		break;
+	case FETCH_OP_STACKP:
+		if (is_uprobe)
+			val = user_stack_pointer(regs);
+		else
+			val = kernel_stack_pointer(regs);
+		break;
+	case FETCH_OP_RETVAL:
+		val = regs_return_value(regs);
+		break;
+	case FETCH_OP_IMM:
+		val = code->immediate;
+		break;
+	case FETCH_OP_COMM:
+		val = (unsigned long)current->comm;
+		break;
+	case FETCH_OP_DATA:
+		val = (unsigned long)code->data;
+		break;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	case FETCH_OP_ARG:
+		val = regs_get_kernel_argument(regs, code->param);
+		break;
+#endif
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	case FETCH_OP_TP_ARG:
+		val = get_event_field(code, rec);
+		break;
+	case FETCH_OP_FOFFS:
+		val = translate_user_vaddr(code->immediate);
+		break;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base, flags);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
+/* Sum up total data length for dynamic arrays (strings) */
+int trace_probe_get_data_size(struct trace_probe *tp, struct pt_regs *regs)
+{
+	struct probe_arg *arg;
+	int i, len, ret = 0;
+	struct trace_event_call *call = trace_probe_event_call(tp);
+
+	for (i = 0; i < tp->nr_args; i++) {
+		arg = tp->args + i;
+		if (unlikely(arg->dynamic)) {
+			len = process_fetch_insn(arg->code, regs, NULL, NULL, call->flags);
+			if (len > 0)
+				ret += len;
+		}
+	}
+
+	return ret;
+}
+
+void trace_probe_store_args(void *data, struct trace_probe *tp, void *rec,
+		 int header_size, int maxlen)
+{
+	struct probe_arg *arg;
+	void *base = data - header_size;
+	void *dyndata = data + tp->size;
+	u32 *dl;	/* Data location */
+	int ret, i;
+	struct trace_event_call *call = trace_probe_event_call(tp);
+
+	for (i = 0; i < tp->nr_args; i++) {
+		arg = tp->args + i;
+		dl = data + arg->offset;
+		/* Point the dynamic data area if needed */
+		if (unlikely(arg->dynamic))
+			*dl = make_data_loc(maxlen, dyndata - base);
+		ret = process_fetch_insn(arg->code, rec, dl, base, call->flags);
+		if (unlikely(ret < 0 && arg->dynamic)) {
+			*dl = make_data_loc(0, dyndata - base);
+		} else {
+			dyndata += ret;
+			maxlen -= ret;
+		}
+	}
+}
+
+int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
+		 u8 *data, void *field)
+{
+	void *p;
+	int i, j;
+
+	for (i = 0; i < nr_args; i++) {
+		struct probe_arg *a = args + i;
+
+		trace_seq_printf(s, " %s=", a->name);
+		if (likely(!a->count)) {
+			if (!a->type->print(s, data + a->offset, field))
+				return -ENOMEM;
+			continue;
+		}
+		trace_seq_putc(s, '{');
+		p = data + a->offset;
+		for (j = 0; j < a->count; j++) {
+			if (!a->type->print(s, p, field))
+				return -ENOMEM;
+			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
+			p += a->type->size;
+		}
+	}
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index de38f1c03776..918466087583 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -223,6 +223,12 @@ struct probe_arg {
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
+struct uprobe_dispatch_data {
+	struct trace_uprobe	*tu;
+	unsigned long		bp_addr;
+	unsigned long		offset;
+};
+
 struct trace_uprobe_filter {
 	rwlock_t		rwlock;
 	int			nr_systemwide;
@@ -343,6 +349,11 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
 bool trace_probe_match_command_args(struct trace_probe *tp,
 				    int argc, const char **argv);
 int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
+int trace_probe_get_data_size(struct trace_probe *tp, struct pt_regs *regs);
+void trace_probe_store_args(void *data, struct trace_probe *tp, void *rec,
+		 int header_size, int maxlen);
+int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
+		 u8 *data, void *field);
 
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fb58e86dd117..abce09295f05 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -20,7 +20,6 @@
 
 #include "trace_dynevent.h"
 #include "trace_probe.h"
-#include "trace_probe_tmpl.h"
 
 #define UPROBE_EVENT_SYSTEM	"uprobes"
 
@@ -88,174 +87,10 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-struct uprobe_dispatch_data {
-	struct trace_uprobe	*tu;
-	unsigned long		bp_addr;
-};
-
 static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
 				unsigned long func, struct pt_regs *regs);
 
-#ifdef CONFIG_STACK_GROWSUP
-static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
-{
-	return addr - (n * sizeof(long));
-}
-#else
-static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
-{
-	return addr + (n * sizeof(long));
-}
-#endif
-
-static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
-{
-	unsigned long ret;
-	unsigned long addr = user_stack_pointer(regs);
-
-	addr = adjust_stack_addr(addr, n);
-
-	if (copy_from_user(&ret, (void __force __user *) addr, sizeof(ret)))
-		return 0;
-
-	return ret;
-}
-
-/*
- * Uprobes-specific fetch functions
- */
-static nokprobe_inline int
-probe_mem_read(void *dest, void *src, size_t size)
-{
-	void __user *vaddr = (void __force __user *)src;
-
-	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
-}
-
-static nokprobe_inline int
-probe_mem_read_user(void *dest, void *src, size_t size)
-{
-	return probe_mem_read(dest, src, size);
-}
-
-/*
- * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
- * length and relative data location.
- */
-static nokprobe_inline int
-fetch_store_string(unsigned long addr, void *dest, void *base)
-{
-	long ret;
-	u32 loc = *(u32 *)dest;
-	int maxlen  = get_loc_len(loc);
-	u8 *dst = get_loc_data(dest, base);
-	void __user *src = (void __force __user *) addr;
-
-	if (unlikely(!maxlen))
-		return -ENOMEM;
-
-	if (addr == FETCH_TOKEN_COMM)
-		ret = strlcpy(dst, current->comm, maxlen);
-	else
-		ret = strncpy_from_user(dst, src, maxlen);
-	if (ret >= 0) {
-		if (ret == maxlen)
-			dst[ret - 1] = '\0';
-		else
-			/*
-			 * Include the terminating null byte. In this case it
-			 * was copied by strncpy_from_user but not accounted
-			 * for in ret.
-			 */
-			ret++;
-		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
-	}
-
-	return ret;
-}
-
-static nokprobe_inline int
-fetch_store_string_user(unsigned long addr, void *dest, void *base)
-{
-	return fetch_store_string(addr, dest, base);
-}
-
-/* Return the length of string -- including null terminal byte */
-static nokprobe_inline int
-fetch_store_strlen(unsigned long addr)
-{
-	int len;
-	void __user *vaddr = (void __force __user *) addr;
-
-	if (addr == FETCH_TOKEN_COMM)
-		len = strlen(current->comm) + 1;
-	else
-		len = strnlen_user(vaddr, MAX_STRING_SIZE);
-
-	return (len > MAX_STRING_SIZE) ? 0 : len;
-}
-
-static nokprobe_inline int
-fetch_store_strlen_user(unsigned long addr)
-{
-	return fetch_store_strlen(addr);
-}
-
-static unsigned long translate_user_vaddr(unsigned long file_offset)
-{
-	unsigned long base_addr;
-	struct uprobe_dispatch_data *udd;
-
-	udd = (void *) current->utask->vaddr;
-
-	base_addr = udd->bp_addr - udd->tu->offset;
-	return base_addr + file_offset;
-}
-
-/* Note that we don't verify it, since the code does not come from user space */
-static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
-{
-	struct pt_regs *regs = rec;
-	unsigned long val;
-
-	/* 1st stage: get value from context */
-	switch (code->op) {
-	case FETCH_OP_REG:
-		val = regs_get_register(regs, code->param);
-		break;
-	case FETCH_OP_STACK:
-		val = get_user_stack_nth(regs, code->param);
-		break;
-	case FETCH_OP_STACKP:
-		val = user_stack_pointer(regs);
-		break;
-	case FETCH_OP_RETVAL:
-		val = regs_return_value(regs);
-		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = FETCH_TOKEN_COMM;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
-	case FETCH_OP_FOFFS:
-		val = translate_user_vaddr(code->immediate);
-		break;
-	default:
-		return -EILSEQ;
-	}
-	code++;
-
-	return process_fetch_insn_bottom(code, val, dest, base);
-}
-NOKPROBE_SYMBOL(process_fetch_insn)
-
 static inline void init_trace_uprobe_filter(struct trace_uprobe_filter *filter)
 {
 	rwlock_init(&filter->rwlock);
@@ -1041,7 +876,7 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	if (print_probe_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
+	if (trace_probe_print_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
 		goto out;
 
 	trace_seq_putc(s, '\n');
@@ -1485,6 +1320,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	tu->nhit++;
 
 	udd.tu = tu;
+	udd.offset = tu->offset;
 	udd.bp_addr = instruction_pointer(regs);
 
 	current->utask->vaddr = (unsigned long) &udd;
@@ -1492,11 +1328,11 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
+	dsize = trace_probe_get_data_size(&tu->tp, regs);
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	trace_probe_store_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
@@ -1520,6 +1356,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	tu = container_of(con, struct trace_uprobe, consumer);
 
 	udd.tu = tu;
+	udd.offset = tu->offset;
 	udd.bp_addr = func;
 
 	current->utask->vaddr = (unsigned long) &udd;
@@ -1527,11 +1364,11 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
+	dsize = trace_probe_get_data_size(&tu->tp, regs);
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	trace_probe_store_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);
-- 
2.25.1

