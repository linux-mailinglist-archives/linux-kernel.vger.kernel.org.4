Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B663C51F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiK2Q22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiK2Q2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:28:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3305A6EE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 724D6B8167C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A995C433C1;
        Tue, 29 Nov 2022 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669739302;
        bh=yj3dm+baXZXQDY3WA4EOUtzNtXKLG6b/rh4CPOPxd90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nMknn2N4XfA7XlEr6yu/11O8TEbswJLxfQp+ckNc06BhjVN8tbtT4j5Dre++JsVRI
         BFpl2vonqEpEqBexww5VNyzDNjcLn3dA1tmZ5ewp/PpHS7HSNQFcLtqP8b+65fli5+
         SiGtXk5NNFK0lScmlBK16P5MzrECoQXkyoXwuzseZVNVrnMAJ7B3fb0sXntOLJAvRP
         ltQgNwflKBLANISQSOgaHNycoydWEKl1NpRlwtqkGvaeE3L7FWcxO960kJcNkWaBOl
         /FumYPvJ4lbhLwXB2u8ms26ZP3q7faBhNoRRdKYiJZ0bPDC7wUVQcNBd4WUzd8254i
         bVjBWJerdfO+g==
Date:   Wed, 30 Nov 2022 01:28:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip] x86/kprobes: Drop removed INT3 handling code
Message-Id: <20221130012817.638dea0fbf4b8abcd4a70019@kernel.org>
In-Reply-To: <20221128154905.23aa5d07@gandalf.local.home>
References: <166938748740.2964025.7215038423815144481.stgit@devnote3>
        <20221128154905.23aa5d07@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 15:49:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 Nov 2022 23:44:47 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Drop removed INT3 handling code from kprobe_int3_handler() because this
> > case (get_kprobe() doesn't return corresponding kprobe AND the INT3 is
> > removed) must not happen with the kprobe managed INT3, but can happen
> > with the non-kprobe INT3, which should be handled by other callbacks.
> > 
> > For the kprobe managed INT3, the arch_disarm_kprobe() removes the INT3
> > and then calls text_poke_sync(). Since this text_poke_sync() uses IPI
> > to call sync_core() on all online cpus, that ensures that all running
> > INT3 exception handlers have done.
> > And, the unregister_kprobe() will remove the kprobe from the hash table
> > after arch_disarm_kprobe().
> > 
> > Thus, when the kprobe managed INT3 hits, kprobe_int3_handler() should
> > be able to find corresponding kprobe always by get_kprobe(). If it can
> > not find any kprobe, this means that is NOT a kprobe managed INT3.
> > 
> 
> I believe this was fixed by:
> 
>   5c02ece81848d ("x86/kprobes: Fix ordering while text-patching")
> 
> That should be mentioned in the commit log.

Thanks for pointing! Yes, it ensures since it add text_poke_sync()
in arch_arm/disarm_kprobe(). So this is the last part of the
commit 5c02ece81848d.

> 
> Anyway, looks good.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!

> 
> -- Steve
> 
> 
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/x86/kernel/kprobes/core.c |   14 --------------
> >  1 file changed, 14 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 66299682b6b7..33390ed4dcf3 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -986,20 +986,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
> >  			kprobe_post_process(p, regs, kcb);
> >  			return 1;
> >  		}
> > -	}
> > -
> > -	if (*addr != INT3_INSN_OPCODE) {
> > -		/*
> > -		 * The breakpoint instruction was removed right
> > -		 * after we hit it.  Another cpu has removed
> > -		 * either a probepoint or a debugger breakpoint
> > -		 * at this address.  In either case, no further
> > -		 * handling of this interrupt is appropriate.
> > -		 * Back up over the (now missing) int3 and run
> > -		 * the original instruction.
> > -		 */
> > -		regs->ip = (unsigned long)addr;
> > -		return 1;
> >  	} /* else: not a kprobe fault; let the kernel handle it */
> >  
> >  	return 0;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
