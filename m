Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE762BD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiKPMWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKPMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:22:08 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E14C192B2;
        Wed, 16 Nov 2022 04:19:18 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:56970.952856087
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id D58DA10013F;
        Wed, 16 Nov 2022 20:19:16 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-787c977d48-59pdt with ESMTP id bb526a9be1f64334901ccff8ad48b6a4 for rostedt@goodmis.org;
        Wed, 16 Nov 2022 20:19:16 CST
X-Transaction-ID: bb526a9be1f64334901ccff8ad48b6a4
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/4] kernel/trace/eprobe: Use new APIs to process eprobe arguments
Date:   Wed, 16 Nov 2022 20:25:30 +0800
Message-Id: <1668601530-4379-1-git-send-email-chensong_2000@189.cn>
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
 kernel/trace/trace_eprobe.c | 194 +-----------------------------------
 1 file changed, 3 insertions(+), 191 deletions(-)

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
-- 
2.25.1

