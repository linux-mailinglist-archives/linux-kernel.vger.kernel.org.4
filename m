Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10763B3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiK1UtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiK1UtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:49:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E52E20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:49:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEC01B80FEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635F9C433D7;
        Mon, 28 Nov 2022 20:49:08 +0000 (UTC)
Date:   Mon, 28 Nov 2022 15:49:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip] x86/kprobes: Drop removed INT3 handling code
Message-ID: <20221128154905.23aa5d07@gandalf.local.home>
In-Reply-To: <166938748740.2964025.7215038423815144481.stgit@devnote3>
References: <166938748740.2964025.7215038423815144481.stgit@devnote3>
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

On Fri, 25 Nov 2022 23:44:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Drop removed INT3 handling code from kprobe_int3_handler() because this
> case (get_kprobe() doesn't return corresponding kprobe AND the INT3 is
> removed) must not happen with the kprobe managed INT3, but can happen
> with the non-kprobe INT3, which should be handled by other callbacks.
> 
> For the kprobe managed INT3, the arch_disarm_kprobe() removes the INT3
> and then calls text_poke_sync(). Since this text_poke_sync() uses IPI
> to call sync_core() on all online cpus, that ensures that all running
> INT3 exception handlers have done.
> And, the unregister_kprobe() will remove the kprobe from the hash table
> after arch_disarm_kprobe().
> 
> Thus, when the kprobe managed INT3 hits, kprobe_int3_handler() should
> be able to find corresponding kprobe always by get_kprobe(). If it can
> not find any kprobe, this means that is NOT a kprobe managed INT3.
> 

I believe this was fixed by:

  5c02ece81848d ("x86/kprobes: Fix ordering while text-patching")

That should be mentioned in the commit log.

Anyway, looks good.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve



> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 66299682b6b7..33390ed4dcf3 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -986,20 +986,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
>  			kprobe_post_process(p, regs, kcb);
>  			return 1;
>  		}
> -	}
> -
> -	if (*addr != INT3_INSN_OPCODE) {
> -		/*
> -		 * The breakpoint instruction was removed right
> -		 * after we hit it.  Another cpu has removed
> -		 * either a probepoint or a debugger breakpoint
> -		 * at this address.  In either case, no further
> -		 * handling of this interrupt is appropriate.
> -		 * Back up over the (now missing) int3 and run
> -		 * the original instruction.
> -		 */
> -		regs->ip = (unsigned long)addr;
> -		return 1;
>  	} /* else: not a kprobe fault; let the kernel handle it */
>  
>  	return 0;

