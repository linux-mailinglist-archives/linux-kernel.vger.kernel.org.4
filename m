Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42663325A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiKVBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiKVBsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:48:01 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C97EB43878;
        Mon, 21 Nov 2022 17:47:52 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:53652.639706311
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id A20421002FD;
        Tue, 22 Nov 2022 09:47:50 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-6cffbd87dd-pzsb9 with ESMTP id 600d615db5d243e2ab4ab964d2683b5b for mhiramat@kernel.org;
        Tue, 22 Nov 2022 09:47:50 CST
X-Transaction-ID: 600d615db5d243e2ab4ab964d2683b5b
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <54007834-9218-eb10-aabe-dc8d9e1793b4@189.cn>
Date:   Tue, 22 Nov 2022 09:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] kernel/trace: Introduce new APIs to process probe
 arguments
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <1668601507-4289-1-git-send-email-chensong_2000@189.cn>
 <20221122070139.7c5006b290d76f012f1d977a@kernel.org>
Content-Language: en-US
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20221122070139.7c5006b290d76f012f1d977a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/22 06:01, Masami Hiramatsu (Google) 写道:
> Hi Song,
> 
> On Wed, 16 Nov 2022 20:25:07 +0800
> Song Chen <chensong_2000@189.cn> wrote:
> 
>> Introduce 3 new APIs:
>> 1. trace_probe_get_data_size: get arguments' data size
>> 2. trace_probe_store_args: store aruguments into ring buffer
>> 3. trace_probe_print_args: print arguments into trace file
> 
> Ah, I meant that split the patches into
> 
> Introduce trace_probe_get_data_size() and use it in *probes
> Introduce trace_probe_store_args() and use it in *probes
> Introduce trace_probe_print_args and use it in *probes
> 
> Then we can easily understand by its meaning.
> 
> Can you reform this series again?
> 
> Thank you,
> 

understood, will do , thanks.

/Song

>>
>> Those APIs are going to merge similar implementations respectively
>> in kprobe/uprobe/eprobe.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
>>   kernel/trace/trace_probe.c        | 305 ++++++++++++++++++++++++++++++
>>   kernel/trace/trace_probe.h        |   5 +
>>   kernel/trace/trace_probe_common.h |  69 +++++++
>>   kernel/trace/trace_probe_user.h   |  95 ++++++++++
>>   4 files changed, 474 insertions(+)
>>   create mode 100644 kernel/trace/trace_probe_common.h
>>   create mode 100644 kernel/trace/trace_probe_user.h
>>
>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>> index 36dff277de46..303f057bd2f7 100644
>> --- a/kernel/trace/trace_probe.c
>> +++ b/kernel/trace/trace_probe.c
>> @@ -12,6 +12,9 @@
>>   #define pr_fmt(fmt)	"trace_probe: " fmt
>>   
>>   #include "trace_probe.h"
>> +#include "trace_probe_kernel.h"
>> +#include "trace_probe_user.h"
>> +#include "trace_probe_common.h"
>>   
>>   #undef C
>>   #define C(a, b)		b
>> @@ -1218,3 +1221,305 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
>>   
>>   	return ret;
>>   }
>> +
>> +/* From the 2nd stage, routine is same */
>> +static nokprobe_inline int
>> +process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>> +			   void *dest, void *base, int flags)
>> +{
>> +	struct fetch_insn *s3 = NULL;
>> +	int total = 0, ret = 0, i = 0;
>> +	u32 loc = 0;
>> +	unsigned long lval = val;
>> +	int is_uprobe = flags & TRACE_EVENT_FL_UPROBE;
>> +
>> +stage2:
>> +	/* 2nd stage: dereference memory if needed */
>> +	do {
>> +		if (code->op == FETCH_OP_DEREF) {
>> +			lval = val;
>> +			ret = probe_mem_read(&val, (void *)val + code->offset,
>> +					     sizeof(val));
>> +		} else if (code->op == FETCH_OP_UDEREF) {
>> +			lval = val;
>> +			ret = probe_mem_read_user(&val,
>> +				 (void *)val + code->offset, sizeof(val));
>> +		} else
>> +			break;
>> +		if (ret)
>> +			return ret;
>> +		code++;
>> +	} while (1);
>> +
>> +	s3 = code;
>> +stage3:
>> +	/* 3rd stage: store value to buffer */
>> +	if (unlikely(!dest)) {
>> +		if (code->op == FETCH_OP_ST_STRING) {
>> +			if (is_uprobe)
>> +				ret = user_fetch_store_strlen(val + code->offset);
>> +			else
>> +				ret = kern_fetch_store_strlen(val + code->offset);
>> +			code++;
>> +			goto array;
>> +		} else if (code->op == FETCH_OP_ST_USTRING) {
>> +			if (is_uprobe)
>> +				ret += user_fetch_store_strlen_user(val + code->offset);
>> +			else
>> +				ret += kern_fetch_store_strlen_user(val + code->offset);
>> +			code++;
>> +			goto array;
>> +		} else
>> +			return -EILSEQ;
>> +	}
>> +
>> +	switch (code->op) {
>> +	case FETCH_OP_ST_RAW:
>> +		fetch_store_raw(val, code, dest);
>> +		break;
>> +	case FETCH_OP_ST_MEM:
>> +		probe_mem_read(dest, (void *)val + code->offset, code->size);
>> +		break;
>> +	case FETCH_OP_ST_UMEM:
>> +		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
>> +		break;
>> +	case FETCH_OP_ST_STRING:
>> +		loc = *(u32 *)dest;
>> +		if (is_uprobe)
>> +			ret = user_fetch_store_string(val + code->offset, dest, base);
>> +		else
>> +			ret = kern_fetch_store_string(val + code->offset, dest, base);
>> +		break;
>> +	case FETCH_OP_ST_USTRING:
>> +		loc = *(u32 *)dest;
>> +		if (is_uprobe)
>> +			ret = user_fetch_store_string_user(val + code->offset, dest, base);
>> +		else
>> +			ret = kern_fetch_store_string_user(val + code->offset, dest, base);
>> +		break;
>> +	default:
>> +		return -EILSEQ;
>> +	}
>> +	code++;
>> +
>> +	/* 4th stage: modify stored value if needed */
>> +	if (code->op == FETCH_OP_MOD_BF) {
>> +		fetch_apply_bitfield(code, dest);
>> +		code++;
>> +	}
>> +
>> +array:
>> +	/* the last stage: Loop on array */
>> +	if (code->op == FETCH_OP_LP_ARRAY) {
>> +		total += ret;
>> +		if (++i < code->param) {
>> +			code = s3;
>> +			if (s3->op != FETCH_OP_ST_STRING &&
>> +			    s3->op != FETCH_OP_ST_USTRING) {
>> +				dest += s3->size;
>> +				val += s3->size;
>> +				goto stage3;
>> +			}
>> +			code--;
>> +			val = lval + sizeof(char *);
>> +			if (dest) {
>> +				dest += sizeof(u32);
>> +				*(u32 *)dest = update_data_loc(loc, ret);
>> +			}
>> +			goto stage2;
>> +		}
>> +		code++;
>> +		ret = total;
>> +	}
>> +
>> +	return code->op == FETCH_OP_END ? ret : -EILSEQ;
>> +}
>> +
>> +static unsigned long get_event_field(struct fetch_insn *code, void *rec)
>> +{
>> +	struct ftrace_event_field *field = code->data;
>> +	unsigned long val;
>> +	void *addr;
>> +
>> +	addr = rec + field->offset;
>> +
>> +	if (is_string_field(field)) {
>> +		switch (field->filter_type) {
>> +		case FILTER_DYN_STRING:
>> +			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
>> +			break;
>> +		case FILTER_RDYN_STRING:
>> +			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
>> +			break;
>> +		case FILTER_STATIC_STRING:
>> +			val = (unsigned long)addr;
>> +			break;
>> +		case FILTER_PTR_STRING:
>> +			val = (unsigned long)(*(char *)addr);
>> +			break;
>> +		default:
>> +			WARN_ON_ONCE(1);
>> +			return 0;
>> +		}
>> +		return val;
>> +	}
>> +
>> +	switch (field->size) {
>> +	case 1:
>> +		if (field->is_signed)
>> +			val = *(char *)addr;
>> +		else
>> +			val = *(unsigned char *)addr;
>> +		break;
>> +	case 2:
>> +		if (field->is_signed)
>> +			val = *(short *)addr;
>> +		else
>> +			val = *(unsigned short *)addr;
>> +		break;
>> +	case 4:
>> +		if (field->is_signed)
>> +			val = *(int *)addr;
>> +		else
>> +			val = *(unsigned int *)addr;
>> +		break;
>> +	default:
>> +		if (field->is_signed)
>> +			val = *(long *)addr;
>> +		else
>> +			val = *(unsigned long *)addr;
>> +		break;
>> +	}
>> +	return val;
>> +}
>> +
>> +/* Note that we don't verify it, since the code does not come from user space */
>> +static int
>> +process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>> +		   void *base, int flags)
>> +{
>> +	struct pt_regs *regs = rec;
>> +	unsigned long val;
>> +	int is_uprobe = flags & TRACE_EVENT_FL_UPROBE;
>> +
>> +retry:
>> +	/* 1st stage: get value from context */
>> +	switch (code->op) {
>> +	case FETCH_OP_REG:
>> +		val = regs_get_register(regs, code->param);
>> +		break;
>> +	case FETCH_OP_STACK:
>> +		if (is_uprobe)
>> +			val = get_user_stack_nth(regs, code->param);
>> +		else
>> +			val = regs_get_kernel_stack_nth(regs, code->param);
>> +		break;
>> +	case FETCH_OP_STACKP:
>> +		if (is_uprobe)
>> +			val = user_stack_pointer(regs);
>> +		else
>> +			val = kernel_stack_pointer(regs);
>> +		break;
>> +	case FETCH_OP_RETVAL:
>> +		val = regs_return_value(regs);
>> +		break;
>> +	case FETCH_OP_IMM:
>> +		val = code->immediate;
>> +		break;
>> +	case FETCH_OP_COMM:
>> +		val = (unsigned long)current->comm;
>> +		break;
>> +	case FETCH_OP_DATA:
>> +		val = (unsigned long)code->data;
>> +		break;
>> +#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
>> +	case FETCH_OP_ARG:
>> +		val = regs_get_kernel_argument(regs, code->param);
>> +		break;
>> +#endif
>> +	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
>> +		code++;
>> +		goto retry;
>> +	case FETCH_OP_TP_ARG:
>> +		val = get_event_field(code, rec);
>> +		break;
>> +	default:
>> +		return -EILSEQ;
>> +	}
>> +	code++;
>> +
>> +	return process_fetch_insn_bottom(code, val, dest, base, flags);
>> +}
>> +NOKPROBE_SYMBOL(process_fetch_insn)
>> +
>> +/* Sum up total data length for dynamic arrays (strings) */
>> +int trace_probe_get_data_size(struct trace_probe *tp, struct pt_regs *regs)
>> +{
>> +	struct probe_arg *arg;
>> +	int i, len, ret = 0;
>> +	struct trace_event_call *call = trace_probe_event_call(tp);
>> +
>> +	for (i = 0; i < tp->nr_args; i++) {
>> +		arg = tp->args + i;
>> +		if (unlikely(arg->dynamic)) {
>> +			len = process_fetch_insn(arg->code, regs, NULL, NULL, call->flags);
>> +			if (len > 0)
>> +				ret += len;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +void trace_probe_store_args(void *data, struct trace_probe *tp, void *rec,
>> +		 int header_size, int maxlen)
>> +{
>> +	struct probe_arg *arg;
>> +	void *base = data - header_size;
>> +	void *dyndata = data + tp->size;
>> +	u32 *dl;	/* Data location */
>> +	int ret, i;
>> +	struct trace_event_call *call = trace_probe_event_call(tp);
>> +
>> +	for (i = 0; i < tp->nr_args; i++) {
>> +		arg = tp->args + i;
>> +		dl = data + arg->offset;
>> +		/* Point the dynamic data area if needed */
>> +		if (unlikely(arg->dynamic))
>> +			*dl = make_data_loc(maxlen, dyndata - base);
>> +		ret = process_fetch_insn(arg->code, rec, dl, base, call->flags);
>> +		if (unlikely(ret < 0 && arg->dynamic)) {
>> +			*dl = make_data_loc(0, dyndata - base);
>> +		} else {
>> +			dyndata += ret;
>> +			maxlen -= ret;
>> +		}
>> +	}
>> +}
>> +
>> +int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
>> +		 u8 *data, void *field)
>> +{
>> +	void *p;
>> +	int i, j;
>> +
>> +	for (i = 0; i < nr_args; i++) {
>> +		struct probe_arg *a = args + i;
>> +
>> +		trace_seq_printf(s, " %s=", a->name);
>> +		if (likely(!a->count)) {
>> +			if (!a->type->print(s, data + a->offset, field))
>> +				return -ENOMEM;
>> +			continue;
>> +		}
>> +		trace_seq_putc(s, '{');
>> +		p = data + a->offset;
>> +		for (j = 0; j < a->count; j++) {
>> +			if (!a->type->print(s, p, field))
>> +				return -ENOMEM;
>> +			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
>> +			p += a->type->size;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
>> index de38f1c03776..4f044047b748 100644
>> --- a/kernel/trace/trace_probe.h
>> +++ b/kernel/trace/trace_probe.h
>> @@ -343,6 +343,11 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
>>   bool trace_probe_match_command_args(struct trace_probe *tp,
>>   				    int argc, const char **argv);
>>   int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
>> +int trace_probe_get_data_size(struct trace_probe *tp, struct pt_regs *regs);
>> +void trace_probe_store_args(void *data, struct trace_probe *tp, void *rec,
>> +		 int header_size, int maxlen);
>> +int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
>> +		 u8 *data, void *field);
>>   
>>   #define trace_probe_for_each_link(pos, tp)	\
>>   	list_for_each_entry(pos, &(tp)->event->files, list)
>> diff --git a/kernel/trace/trace_probe_common.h b/kernel/trace/trace_probe_common.h
>> new file mode 100644
>> index 000000000000..b8d77447fe0c
>> --- /dev/null
>> +++ b/kernel/trace/trace_probe_common.h
>> @@ -0,0 +1,69 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __TRACE_PROBE_COMMON_H_
>> +#define __TRACE_PROBE_COMMON_H_
>> +
>> +#define FAULT_STRING "(fault)"
>> +
>> +static nokprobe_inline void
>> +fetch_store_raw(unsigned long val, struct fetch_insn *code, void *buf)
>> +{
>> +	switch (code->size) {
>> +	case 1:
>> +		*(u8 *)buf = (u8)val;
>> +		break;
>> +	case 2:
>> +		*(u16 *)buf = (u16)val;
>> +		break;
>> +	case 4:
>> +		*(u32 *)buf = (u32)val;
>> +		break;
>> +	case 8:
>> +		//TBD: 32bit signed
>> +		*(u64 *)buf = (u64)val;
>> +		break;
>> +	default:
>> +		*(unsigned long *)buf = val;
>> +	}
>> +}
>> +
>> +static nokprobe_inline void
>> +fetch_apply_bitfield(struct fetch_insn *code, void *buf)
>> +{
>> +	switch (code->basesize) {
>> +	case 1:
>> +		*(u8 *)buf <<= code->lshift;
>> +		*(u8 *)buf >>= code->rshift;
>> +		break;
>> +	case 2:
>> +		*(u16 *)buf <<= code->lshift;
>> +		*(u16 *)buf >>= code->rshift;
>> +		break;
>> +	case 4:
>> +		*(u32 *)buf <<= code->lshift;
>> +		*(u32 *)buf >>= code->rshift;
>> +		break;
>> +	case 8:
>> +		*(u64 *)buf <<= code->lshift;
>> +		*(u64 *)buf >>= code->rshift;
>> +		break;
>> +	}
>> +}
>> +
>> +static nokprobe_inline int
>> +probe_mem_read_user(void *dest, void *src, size_t size)
>> +{
>> +	const void __user *uaddr =  (__force const void __user *)src;
>> +
>> +	return copy_from_user_nofault(dest, uaddr, size);
>> +}
>> +
>> +static nokprobe_inline int
>> +probe_mem_read(void *dest, void *src, size_t size)
>> +{
>> +#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>> +	if ((unsigned long)src < TASK_SIZE)
>> +		return probe_mem_read_user(dest, src, size);
>> +#endif
>> +	return copy_from_kernel_nofault(dest, src, size);
>> +}
>> +#endif /* __TRACE_PROBE_COMMON_H_ */
>> diff --git a/kernel/trace/trace_probe_user.h b/kernel/trace/trace_probe_user.h
>> new file mode 100644
>> index 000000000000..2104ccb44d56
>> --- /dev/null
>> +++ b/kernel/trace/trace_probe_user.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __TRACE_PROBE_USER_H_
>> +#define __TRACE_PROBE_USER_H_
>> +
>> +#define FAULT_STRING "(fault)"
>> +
>> +/*
>> + * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
>> + * length and relative data location.
>> + */
>> +static nokprobe_inline int
>> +user_fetch_store_string(unsigned long addr, void *dest, void *base)
>> +{
>> +	long ret;
>> +	u32 loc = *(u32 *)dest;
>> +	int maxlen  = get_loc_len(loc);
>> +	u8 *dst = get_loc_data(dest, base);
>> +	void __user *src = (void __force __user *) addr;
>> +
>> +	if (unlikely(!maxlen))
>> +		return -ENOMEM;
>> +
>> +	if (addr == FETCH_TOKEN_COMM)
>> +		ret = strlcpy(dst, current->comm, maxlen);
>> +	else
>> +		ret = strncpy_from_user(dst, src, maxlen);
>> +	if (ret >= 0) {
>> +		if (ret == maxlen)
>> +			dst[ret - 1] = '\0';
>> +		else
>> +			/*
>> +			 * Include the terminating null byte. In this case it
>> +			 * was copied by strncpy_from_user but not accounted
>> +			 * for in ret.
>> +			 */
>> +			ret++;
>> +		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static nokprobe_inline int
>> +user_fetch_store_string_user(unsigned long addr, void *dest, void *base)
>> +{
>> +	return user_fetch_store_string(addr, dest, base);
>> +}
>> +
>> +/* Return the length of string -- including null terminal byte */
>> +static nokprobe_inline int
>> +user_fetch_store_strlen(unsigned long addr)
>> +{
>> +	int len;
>> +	void __user *vaddr = (void __force __user *) addr;
>> +
>> +	if (addr == FETCH_TOKEN_COMM)
>> +		len = strlen(current->comm) + 1;
>> +	else
>> +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
>> +
>> +	return (len > MAX_STRING_SIZE) ? 0 : len;
>> +}
>> +
>> +static nokprobe_inline int
>> +user_fetch_store_strlen_user(unsigned long addr)
>> +{
>> +	return user_fetch_store_strlen(addr);
>> +}
>> +
>> +#ifdef CONFIG_STACK_GROWSUP
>> +static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
>> +{
>> +	return addr - (n * sizeof(long));
>> +}
>> +#else
>> +static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
>> +{
>> +	return addr + (n * sizeof(long));
>> +}
>> +#endif
>> +
>> +static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
>> +{
>> +	unsigned long ret;
>> +	unsigned long addr = user_stack_pointer(regs);
>> +
>> +	addr = adjust_stack_addr(addr, n);
>> +
>> +	if (copy_from_user(&ret, (void __force __user *) addr, sizeof(ret)))
>> +		return 0;
>> +
>> +	return ret;
>> +}
>> +
>> +#endif /* __TRACE_PROBE_USER_H_ */
>> -- 
>> 2.25.1
>>
> 
> 
