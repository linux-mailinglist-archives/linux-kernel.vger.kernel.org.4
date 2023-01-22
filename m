Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7919B676BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAVIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:46:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940D1CF51
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:46:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313A26069B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 08:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D78C433EF;
        Sun, 22 Jan 2023 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674377167;
        bh=7iOUJI/0jxYncPSrWHDSBcUotII9giiF4noCHmXq/7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fAP+RaG0dGhk/7jKzst8ex6eX6t7wP26ate4XumfGjyxTG857OQnBsf5WkR4+M24j
         /O5mtGEF6ZwQK5UqUn8hpLfPUPISZcsMP3EXZR34BFI8TRwVKxe6krWjwHsBqaQ3dx
         yvEhLyu3pP5fiXuQiGG8j6/Drnq5Tiy1iwnNdLu0mM61Yp9Z4oQuBbOixqmhyU6ITN
         Sevd+TqPE0F0vHO+umqW711X5rMUt1mhRk4o/7F86A7e+KqE1niGTJZIEw8+z8YdL2
         53WNte5DP2dU234VYsi1gPVWRlyWCoouuoEjGpGW2Sjf1hNqMaWwGWSv99P86IxK8r
         t1oxODWTnZWSw==
Date:   Sun, 22 Jan 2023 17:46:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-Id: <20230122174603.2a0d1597ff90ab37da7b50d0@kernel.org>
In-Reply-To: <Y8qr62sZF4HevL75@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
        <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
        <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
        <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
        <Y8p4CnJU6T7+17Sw@hirez.programming.kicks-ass.net>
        <Y8qr62sZF4HevL75@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 15:57:47 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 20, 2023 at 12:16:26PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 20, 2023 at 11:20:53AM +0530, Sandipan Das wrote:
> > 
> > > With the combination of defconfig+kvm_guest.config+localyesconfig, the only
> > > thing that made a difference was the compiler optimization choice. The kernel
> > > boots up with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y but not with
> > > CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Both Clang 15 and 16 kernel builds are affected.
> > 
> > *groan*..
> > 
> > 0000000000000350 <amd_pmu_add_event>:
> > 350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
> > 355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
> > 35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
> > 363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4
> > 
> > and static_call() can't deal with Jcc, I wonder why we've not seen that
> > before -- this isn't totally idiotic code-gen and esp. clang is known to
> > do this (see the retpoline thing).
> > 
> > Let me see if I can do something about that.
> 
> Here, this makes my qemu/kvm happy enough to complain about not having a
> root device to mount :-)
> 
> Let me go try booting it for real.

Thanks Peter, this fix looks good to me too.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> ---
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index f4b87f08f5c5..29832c338cdc 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -184,6 +184,37 @@ void int3_emulate_ret(struct pt_regs *regs)
>  	unsigned long ip = int3_emulate_pop(regs);
>  	int3_emulate_jmp(regs, ip);
>  }
> +
> +static __always_inline
> +void int3_emulate_jcc(struct pt_regs *regs, u8 cc, unsigned long ip, unsigned long disp)
> +{
> +	static const unsigned long jcc_mask[6] = {
> +		[0] = X86_EFLAGS_OF,
> +		[1] = X86_EFLAGS_CF,
> +		[2] = X86_EFLAGS_ZF,
> +		[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
> +		[4] = X86_EFLAGS_SF,
> +		[5] = X86_EFLAGS_PF,
> +	};
> +
> +	bool invert = cc & 1;
> +	bool match;
> +
> +	if (cc < 0xc) {
> +		match = regs->flags & jcc_mask[cc >> 1];
> +	} else {
> +		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
> +			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
> +		if (cc >= 0xe)
> +			match = match || (regs->flags & X86_EFLAGS_ZF);
> +	}
> +
> +	if ((match && !invert) || (!match && invert))
> +		ip += disp;
> +
> +	int3_emulate_jmp(regs, ip);
> +}
> +
>  #endif /* !CONFIG_UML_X86 */
>  
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 7d8c3cbde368..cd632a0171b4 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1772,6 +1772,11 @@ void text_poke_sync(void)
>  	on_each_cpu(do_sync_core, NULL, 1);
>  }
>  
> +/*
> + * NOTE: crazy scheme to allow patching Jcc.d32 but not increase the size of
> + * this thing. When len == 6 everything is prefixed with 0x0f and we map
> + * opcode to Jcc.d8, using len to distinguish.
> + */
>  struct text_poke_loc {
>  	/* addr := _stext + rel_addr */
>  	s32 rel_addr;
> @@ -1893,6 +1898,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
>  		int3_emulate_jmp(regs, (long)ip + tp->disp);
>  		break;
>  
> +	case 0x70 ... 0x7f: /* Jcc */
> +		int3_emulate_jcc(regs, tp->opcode & 0xf, (long)ip, tp->disp);
> +		break;
> +
>  	default:
>  		BUG();
>  	}
> @@ -1966,16 +1975,26 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * Second step: update all but the first byte of the patched range.
>  	 */
>  	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> -		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
> +		u8 old[POKE_MAX_OPCODE_SIZE+1] = { tp[i].old, };
> +		u8 _new[POKE_MAX_OPCODE_SIZE+1];
> +		const u8 *new = tp[i].text;
>  		int len = tp[i].len;
>  
>  		if (len - INT3_INSN_SIZE > 0) {
>  			memcpy(old + INT3_INSN_SIZE,
>  			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
>  			       len - INT3_INSN_SIZE);
> +
> +			if (len == 6) {
> +				_new[0] = 0x0f;
> +				memcpy(_new + 1, new, 5);
> +				new = _new;
> +			}
> +
>  			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
> -				  (const char *)tp[i].text + INT3_INSN_SIZE,
> +				  new + INT3_INSN_SIZE,
>  				  len - INT3_INSN_SIZE);
> +
>  			do_sync++;
>  		}
>  
> @@ -2003,8 +2022,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  		 * The old instruction is recorded so that the event can be
>  		 * processed forwards or backwards.
>  		 */
> -		perf_event_text_poke(text_poke_addr(&tp[i]), old, len,
> -				     tp[i].text, len);
> +		perf_event_text_poke(text_poke_addr(&tp[i]), old, len, new, len);
>  	}
>  
>  	if (do_sync) {
> @@ -2021,10 +2039,15 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * replacing opcode.
>  	 */
>  	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> -		if (tp[i].text[0] == INT3_INSN_OPCODE)
> +		u8 byte = tp[i].text[0];
> +
> +		if (tp[i].len == 6)
> +			byte = 0x0f;
> +
> +		if (byte == INT3_INSN_OPCODE)
>  			continue;
>  
> -		text_poke(text_poke_addr(&tp[i]), tp[i].text, INT3_INSN_SIZE);
> +		text_poke(text_poke_addr(&tp[i]), &byte, INT3_INSN_SIZE);
>  		do_sync++;
>  	}
>  
> @@ -2042,9 +2065,11 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
>  			       const void *opcode, size_t len, const void *emulate)
>  {
>  	struct insn insn;
> -	int ret, i;
> +	int ret, i = 0;
>  
> -	memcpy((void *)tp->text, opcode, len);
> +	if (len == 6)
> +		i = 1;
> +	memcpy((void *)tp->text, opcode+i, len-i);
>  	if (!emulate)
>  		emulate = opcode;
>  
> @@ -2055,6 +2080,13 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
>  	tp->len = len;
>  	tp->opcode = insn.opcode.bytes[0];
>  
> +	if (is_jcc32(&insn)) {
> +		/*
> +		 * Map Jcc.d32 onto Jcc.d8 and use len to distinguish.
> +		 */
> +		tp->opcode = insn.opcode.bytes[1] - 0x10;
> +	}
> +
>  	switch (tp->opcode) {
>  	case RET_INSN_OPCODE:
>  	case JMP32_INSN_OPCODE:
> @@ -2071,7 +2103,6 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
>  		BUG_ON(len != insn.length);
>  	}
>  
> -
>  	switch (tp->opcode) {
>  	case INT3_INSN_OPCODE:
>  	case RET_INSN_OPCODE:
> @@ -2080,6 +2111,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
>  	case CALL_INSN_OPCODE:
>  	case JMP32_INSN_OPCODE:
>  	case JMP8_INSN_OPCODE:
> +	case 0x70 ... 0x7f: /* Jcc */
>  		tp->disp = insn.immediate.value;
>  		break;
>  
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index b36f3c367cb2..f2b2f7545ecb 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -464,50 +464,26 @@ static void kprobe_emulate_call(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_call);
>  
> -static nokprobe_inline
> -void __kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
> +static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
>  {
>  	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
>  
> -	if (cond)
> -		ip += p->ainsn.rel32;
> +	ip += p->ainsn.rel32;
>  	int3_emulate_jmp(regs, ip);
>  }
> -
> -static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
> -{
> -	__kprobe_emulate_jmp(p, regs, true);
> -}
>  NOKPROBE_SYMBOL(kprobe_emulate_jmp);
>  
> -static const unsigned long jcc_mask[6] = {
> -	[0] = X86_EFLAGS_OF,
> -	[1] = X86_EFLAGS_CF,
> -	[2] = X86_EFLAGS_ZF,
> -	[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
> -	[4] = X86_EFLAGS_SF,
> -	[5] = X86_EFLAGS_PF,
> -};
> -
>  static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
>  {
> -	bool invert = p->ainsn.jcc.type & 1;
> -	bool match;
> -
> -	if (p->ainsn.jcc.type < 0xc) {
> -		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
> -	} else {
> -		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
> -			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
> -		if (p->ainsn.jcc.type >= 0xe)
> -			match = match || (regs->flags & X86_EFLAGS_ZF);
> -	}
> -	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
> +	int3_emulate_jcc(regs, p->ainsn.jcc.type,
> +			 regs->ip - INT3_INSN_SIZE + p->ainsn.size,
> +			 p->ainsn.rel32);
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_jcc);
>  
>  static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
>  {
> +	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
>  	bool match;
>  
>  	if (p->ainsn.loop.type != 3) {	/* LOOP* */
> @@ -535,7 +511,9 @@ static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
>  	else if (p->ainsn.loop.type == 1)	/* LOOPE */
>  		match = match && (regs->flags & X86_EFLAGS_ZF);
>  
> -	__kprobe_emulate_jmp(p, regs, match);
> +	if (match)
> +		ip += p->ainsn.rel32;
> +	int3_emulate_jmp(regs, ip);
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_loop);
>  
> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index 2ebc338980bc..deb909f2b62f 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -9,6 +9,7 @@ enum insn_type {
>  	NOP = 1,  /* site cond-call */
>  	JMP = 2,  /* tramp / site tail-call */
>  	RET = 3,  /* tramp / site cond-tail-call */
> +	JCC = 4,
>  };
>  
>  /*
> @@ -25,12 +26,38 @@ static const u8 xor5rax[] = { 0x2e, 0x2e, 0x2e, 0x31, 0xc0 };
>  
>  static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
>  
> +static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
> +{
> +	u8 ret = 0;
> +
> +	if (insn[0] == 0x0f) {
> +		u8 tmp = insn[1];
> +		if ((tmp & 0xf0) == 0x80)
> +			ret = tmp;
> +	}
> +
> +	return ret;
> +}
> +
> +extern void __static_call_return(void);
> +
> +asm (".global __static_call_return\n\t"
> +     ".type __static_call_return, @function\n\t"
> +     ASM_FUNC_ALIGN "\n\t"
> +     "__static_call_return:\n\t"
> +     "ret; int3\n\t"
> +     ".size __static_call_return, . - __static_call_return \n\t");
> +
>  static void __ref __static_call_transform(void *insn, enum insn_type type,
>  					  void *func, bool modinit)
>  {
>  	const void *emulate = NULL;
>  	int size = CALL_INSN_SIZE;
>  	const void *code;
> +	u8 op, buf[6];
> +
> +	if ((type == JMP || type == RET) && (op = __is_Jcc(insn)))
> +		type = JCC;
>  
>  	switch (type) {
>  	case CALL:
> @@ -57,6 +84,20 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
>  		else
>  			code = &retinsn;
>  		break;
> +
> +	case JCC:
> +		if (!func) {
> +			func = __static_call_return;
> +			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
> +				func = x86_return_thunk;
> +		}
> +
> +		buf[0] = 0x0f;
> +		__text_gen_insn(buf+1, op, insn+1, func, 5);
> +		code = buf;
> +		size = 6;
> +
> +		break;
>  	}
>  
>  	if (memcmp(insn, code, size) == 0)
> @@ -79,7 +120,8 @@ static void __static_call_validate(void *insn, bool tail, bool tramp)
>  
>  	if (tail) {
>  		if (opcode == JMP32_INSN_OPCODE ||
> -		    opcode == RET_INSN_OPCODE)
> +		    opcode == RET_INSN_OPCODE ||
> +		    __is_Jcc(insn))
>  			return;
>  	} else {
>  		if (opcode == CALL_INSN_OPCODE ||


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
