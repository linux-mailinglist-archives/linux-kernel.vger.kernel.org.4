Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22662BD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiKPMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiKPMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:21:41 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A14CCFE;
        Wed, 16 Nov 2022 04:19:04 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:49124.1136556408
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 467FD1002A6;
        Wed, 16 Nov 2022 20:19:01 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-787c977d48-25qs2 with ESMTP id a3e05bda80234194b94086a8bb2ac2a2 for rostedt@goodmis.org;
        Wed, 16 Nov 2022 20:19:02 CST
X-Transaction-ID: a3e05bda80234194b94086a8bb2ac2a2
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/4] kernel/trace/kprobe: Use new APIs to process kprobe arguments
Date:   Wed, 16 Nov 2022 20:25:16 +0800
Message-Id: <1668601516-4332-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace probe introduces new APIs to process probe arguments, so
kprobe shall remove old implementations and turn to those new
APIs.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/trace_kprobe.c | 125 +++---------------------------------
 1 file changed, 10 insertions(+), 115 deletions(-)

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
-- 
2.25.1

