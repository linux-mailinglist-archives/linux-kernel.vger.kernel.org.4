Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92262BDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiKPMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiKPMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:22:18 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B68E2409C;
        Wed, 16 Nov 2022 04:19:26 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:34780.1719992925
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 3852B100236;
        Wed, 16 Nov 2022 20:19:24 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-787c977d48-v8sdr with ESMTP id 85b2a3a5754e41a8bbd25d8364e322fe for rostedt@goodmis.org;
        Wed, 16 Nov 2022 20:19:25 CST
X-Transaction-ID: 85b2a3a5754e41a8bbd25d8364e322fe
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH 4/4] kernel/trace/uprobe: Use new APIs to process uprobe arguments
Date:   Wed, 16 Nov 2022 20:25:39 +0800
Message-Id: <1668601539-4422-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace probe introduces new APIs to process probe arguments, so
eprobe shall remove old implementations and turn to those new
APIs.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/trace_probe.c      |   5 +
 kernel/trace/trace_probe.h      |   6 ++
 kernel/trace/trace_probe_user.h |  13 +++
 kernel/trace/trace_uprobe.c     | 177 ++------------------------------
 4 files changed, 31 insertions(+), 170 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 303f057bd2f7..56097d241290 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1443,6 +1443,11 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 	case FETCH_OP_TP_ARG:
 		val = get_event_field(code, rec);
 		break;
+#ifdef CONFIG_UPROBES
+	case FETCH_OP_FOFFS:
+		val = translate_user_vaddr(code->immediate);
+		break;
+#endif
 	default:
 		return -EILSEQ;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 4f044047b748..918466087583 100644
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
diff --git a/kernel/trace/trace_probe_user.h b/kernel/trace/trace_probe_user.h
index 2104ccb44d56..5a69b9074f3c 100644
--- a/kernel/trace/trace_probe_user.h
+++ b/kernel/trace/trace_probe_user.h
@@ -92,4 +92,17 @@ static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
 	return ret;
 }
 
+#ifdef CONFIG_UPROBES
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
+#endif
+
 #endif /* __TRACE_PROBE_USER_H_ */
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

