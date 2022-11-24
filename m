Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2F637C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiKXPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKXPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:03:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C798E0B73
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9121B82833
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B2C433D6;
        Thu, 24 Nov 2022 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669302185;
        bh=cpGjtaqXcv58KmNXyGVazcsWLG0J6bP3QBHqsmZKvZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TujuqCAzW6yjMRflI7y9vbOas9/Dj+Dgf21GRZJ8db9wayGteTTzaaQWc4nHL+iTo
         /AhyUfkeBvxAafpPRbS5/xv45tbDS/S4xFLVOt4YIzWQy8ugruCiinaVaYcsC/e9p3
         xMcBAMaIrdEY6V+T2Een6QUxxwxUQbdAEGLnienBkgQ3x6dimxG5XMm55WjpLFfFcu
         gKYP5+yEJ8Iq8+7U6iov5hyKiJPbG+J2j78eqpeqpzLP+p5SnR3GWNL7mpI8CdA3wb
         ddzSZLar+v1Veoxki25XbxT81rHV0rqycOJefCtH0AXrhS2AI70QLQK0PAvGfHUMUx
         Tpih9q25XgeMg==
Date:   Fri, 25 Nov 2022 00:03:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Questions about kprobe handler
Message-Id: <20221125000302.39d535ea1250c2495e4815db@kernel.org>
In-Reply-To: <1669288280.gcxbuppl5k.naveen@linux.ibm.com>
References: <9b6eb4db-83fe-e6d9-a580-1a11aace84b0@loongson.cn>
        <20221117220915.8b233ec82dc10a84753150b4@kernel.org>
        <7e4143dc-c444-e497-43bb-ac0ba18b6691@loongson.cn>
        <1669288280.gcxbuppl5k.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 17:14:27 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> Jinyang He wrote:
> > 在 2022/11/17 21:09, Masami Hiramatsu (Google) 写道:
> > 
> >> On Thu, 17 Nov 2022 09:07:37 +0800
> >> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>
> >>> Hi KPROBES maintainers,
> >>>
> >>> There are some differences of kprobe handler implementations on various
> >>> archs, the implementations are almost same on arm64, riscv, csky, the
> >>> code logic is clear and understandable. But on mips and loongarch (not
> >>> upstreamed yet), if get_kprobe() returns NULL, what is the purpose of
> >>> the check "if (addr->word != breakpoint_insn.word)", is it necessary?
> >>> Can we just return directly? Please take a look, thank you.
> 
> Are you seeing any problem with that?
> 
> >> Good question!
> >>
> >> This means that when the software breakpoint was hit on that CPU, but
> >> before calling kprobe handler function, the other CPU can remove that
> >> kprobe from hash table, becahse the hash table is not locked.
> >> In that case, the get_kprobe(addr) will return NULL, and the software
> >> breakpoint instruction is already removed (replaced with the original
> >> instruction). Thus it is safe to go back. But this is originally
> >> implemented for x86, which doesn't need stop_machine() to modify the
> >> code. On the other hand, if an architecture which needs stop_machine()
> >> to modify code, the above scenario never happen. In that case, you
> >> don't need this "if" case.
> 
> This has been a problematic area on powerpc. See, for instance, commits:
> - 9ed5df69b79a22 ("powerpc/kprobes: Use probe_address() to read instructions")
> - 21f8b2fa3ca5b0 ("powerpc/kprobes: Ignore traps that happened in real mode")
> 
> I think we should close this race, perhaps by instroducing another 
> synchronize_rcu() in unregister_kprobe(), allowing architectures using 
> stop_machine() to override that. That would be cleaner.
> 
> 
> >>
> >> Thank you,
> >>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/kprobes.c#n323
> >>> 		p = get_kprobe(addr);
> >>> 		if (p) {
> >>> 			...
> >>> 		} else if (addr->word != breakpoint_insn.word) {
> > 
> > Hi,
> > 
> > 
> > Sorry for the late reply, but I think there should be some public
> > comments so that I can get the authoritative response, as offline
> > communication with Tiezhu is always one-sided.
> > 
> > I think the branch you answered here is " if (p)... " rather than
> > "else if (addr->word != breakpoint_insn.word)". It is right if we
> > not use stop_machine here we need this branch. In fact, Tiezhu
> > and Huacai, the maintainer of LoongArch are more concerned
> > about the latter why we need compare with the breakpoint_insn.
> 
> Masami answered why we need the else part comparing the instruction at 
> addr with the breakpoint instruction. It is to check if the breakpoint 
> instruction has been removed since we hit it, but before the processor 
> reached the kprobe handler.
> 
> > 
> > The reason I gave as follows, and I show mips code here,
> > 
> >      p = get_kprobe(addr);
> >      if (!p) {
> >          if (addr->word != breakpoint_insn.word) {
> >              /*
> >               * The breakpoint instruction was removed right
> >               * after we hit it.  Another cpu has removed
> >               * either a probepoint or a debugger breakpoint
> >               * at this address.  In either case, no further
> >               * handling of this interrupt is appropriate.
> >               */
> >              ret = 1;
> >          }
> >          /* Not one of ours: let kernel handle it */
> >          goto no_kprobe;
> >      }
> > 
> > ...
> > int kprobe_exceptions_notify(struct notifier_block *self,
> >                         unsigned long val, void *data)
> > {
> >      struct die_args *args = (struct die_args *)data;
> >      int ret = NOTIFY_DONE;
> > 
> >      switch (val) {
> >      case DIE_BREAK:
> >          if (kprobe_handler(args->regs))
> >              ret = NOTIFY_STOP;
> >          break;
> > ...
> > 
> > The !p means this insn has been moved, and then in most cases the COND
> 
> !p means the kprobe has been removed - there may or may not be another 
> breakpoint instruction at that address.
> 
> > "addr->word != breakpoint_insn.word" is true, we return 1 so that the return
> > value in kprobe_exceptions_notify will be changed to NOTIFY_STOP.
> 
> We do this since we now know that there is no breakpoint at this 
> address, so we should not continue.

I think this depends on how the architecture handles the breakpoint.
It may be shared with the other users and in that case, kprobes can not
determine it can stop notifier chain because another notifier callback
is able to handle such cases.

> 
> > The mips use soft breakpoint like "break hint". How if the original insn
> > is same as breakpoint_insn? That is a few case when COND is false. In that
> > case, it means we should handle it by other handlers and doesn't change 
> > ret to
> > keep NOTIFY_DONE as kprobe_exceptions_notify return value.
> 
> If there is a breakpoint instruction at that address, we should let the 
> kernel continue processing the breakpoint.

Even if there is not a breakpoint instruction at that address at that point,
the breakpoint handler is called means there *was* a breakpoint, which can
be managed by another user. Thus I think it is not correct way to check
it in kprobe_int3_andler on x86.

> 
> > 
> > Is this idea reasonable? Thanks!
> 
> As another data point, you may want to look at kprobe_handler() in 
> arch/powerpc/kernel/kprobes.c . We also handle cases where there is a 
> different type of breakpoint instruction.

Yeah, that looks good example for the arch which uses a specific
breakpoint for kprobes. So good for MIPS too.
Unfortunately it doesn't work for x86 since it shares same int3
instruction among all breakpoint users.

Thank you,

> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
