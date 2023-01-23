Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D59678AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjAWWol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjAWWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:44:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544572BF3E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CB20B80ED5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04028C433EF;
        Mon, 23 Jan 2023 22:44:33 +0000 (UTC)
Date:   Mon, 23 Jan 2023 17:44:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, erhard_f@mailbox.org,
        ndesaulniers@google.com, mhiramat@kernel.org, sandipan.das@amd.com
Subject: Re: [PATCH 3/3] x86/static_call: Add support for Jcc tail-calls
Message-ID: <20230123174431.4421dfdf@gandalf.local.home>
In-Reply-To: <20230123210607.173715335@infradead.org>
References: <20230123205915.751729592@infradead.org>
        <20230123210607.173715335@infradead.org>
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

On Mon, 23 Jan 2023 21:59:18 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Clang likes to create conditional tail calls like:
> 
> 0000000000000350 <amd_pmu_add_event>:
> 350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
> 355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
> 35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
> 363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4
> 

Just to confirm, as it's not clear if this is the static call site or one
of the functions that is being called.

I'm guessing that this is an issue because clang optimizes the static call
site, right?

> Teach the in-line static call text patching about this.
> 
> Notably, since there is no conditional-ret, in that caes patch the Jcc

					      "in that case"

-- Steve

> to point at an empty stub function that does the ret -- or the return
> thunk when needed.
> 
> Reported-by: "Erhard F." <erhard_f@mailbox.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/static_call.c |   50 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
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
> @@ -25,12 +26,40 @@ static const u8 xor5rax[] = { 0x2e, 0x2e
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
> +     ANNOTATE_NOENDBR
> +     ANNOTATE_RETPOLINE_SAFE
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
> @@ -57,6 +86,20 @@ static void __ref __static_call_transfor
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
> @@ -68,9 +111,9 @@ static void __ref __static_call_transfor
>  	text_poke_bp(insn, code, size, emulate);
>  }
>  
> -static void __static_call_validate(void *insn, bool tail, bool tramp)
> +static void __static_call_validate(u8 *insn, bool tail, bool tramp)
>  {
> -	u8 opcode = *(u8 *)insn;
> +	u8 opcode = insn[0];
>  
>  	if (tramp && memcmp(insn+5, tramp_ud, 3)) {
>  		pr_err("trampoline signature fail");
> @@ -79,7 +122,8 @@ static void __static_call_validate(void
>  
>  	if (tail) {
>  		if (opcode == JMP32_INSN_OPCODE ||
> -		    opcode == RET_INSN_OPCODE)
> +		    opcode == RET_INSN_OPCODE ||
> +		    __is_Jcc(insn))
>  			return;
>  	} else {
>  		if (opcode == CALL_INSN_OPCODE ||
> 

