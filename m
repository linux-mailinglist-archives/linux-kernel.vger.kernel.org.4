Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6C68DCD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjBGPVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBGPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:21:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33E638019
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84F42B819CB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5238CC433EF;
        Tue,  7 Feb 2023 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675783296;
        bh=LqOdVFe4VhEEm7ofCG1fGYiMh90WgS98iGG8MCxOqcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cPaiVphV2xc0g6yuqyA8EhrONxJRqag9UhsiGUgP17scoZCZYQgpZhEc/dXEzcEYI
         AGV+/96Zw81xGVWXRZV/mUV6rR9oSNTvSsWwnWmZm+VB+WcRBxij6QZZhnkX/AggBD
         IRYHqoW5g4N9Jrl6UxfgDN/3SCaSw9ZWzwJExXeN/r29mRV9ZhylCWkuCaArRvwSGf
         W7udHvcgu7I873JoYwTKBWunxCkpAMVYVRLfuRzazSoG9Mv3U3uYmPeE6n96bV8bDN
         E3DrXksAKdITJQ+JV70jB+govDAPRzyaNY/6l2bKLB6OewV8VC/ejd2vZy6i35cuVa
         py8zSN0bDJukQ==
Date:   Wed, 8 Feb 2023 00:21:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Message-Id: <20230208002132.63b70cb9d6e5badad45fb828@kernel.org>
In-Reply-To: <20230207095424.42f4c0147f693a8cef25757c@kernel.org>
References: <20230204210807.3930-1-namit@vmware.com>
        <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
        <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
        <dc964552-dca7-dd83-52a2-283be7f51555@intel.com>
        <20230207095424.42f4c0147f693a8cef25757c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 09:54:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 6 Feb 2023 14:38:16 -0800
> Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > On 2/6/23 11:05, Nadav Amit wrote:
> > >> On 2/4/23 13:08, Nadav Amit wrote:
> > >>> --- a/arch/x86/kernel/kprobes/core.c
> > >>> +++ b/arch/x86/kernel/kprobes/core.c
> > >>> @@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
> > >>>              /* 1 byte conditional jump */
> > >>>              p->ainsn.emulate_op = kprobe_emulate_jcc;
> > >>>              p->ainsn.jcc.type = opcode & 0xf;
> > >>> -             p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> > >>> +             p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
> > >>>              break;
> > >>
> > >> This new code is at least consistent with what the other code in that
> > >> function does with 1-byte immediates.  But, I'm curious what the point
> > >> is about going through the 's8' type.
> > >>
> > >> What's wrong with:
> > >>
> > >>        p->ainsn.rel32 = insn->immediate.value;
> > >>
> > >> ?  Am I missing something subtle?
> > > 
> > > I am not sure why this is considered safe, insn->immediate.value has a
> > > type of insn_value_t, which is signed int, so such casting seems wrong
> > > to me. Do you imply that during decoding the sign-extension should have
> > > been done correctly? Or am I missing something else?
> > 
> > OK, so we've got an assignment which on the left hand side is
> > p->ainsn.rel32 which is a 32-bit signed integer:
> > 
> > struct arch_specific_insn {
> > 	...
> >         s32 rel32;      /* relative offset must be s32, s16, or s8 */
> > 
> > The right hand side is insn->immediate.value.  Its real type is a couple
> > of layers deep, but it boils down to a 'signed int', also 32-bit:
> > 
> > Struct #1:
> > struct insn {
> > 	...
> >         union {
> >                 struct insn_field immediate;
> > 		...
> >         };
> > 
> > Struct #2
> > struct insn_field {
> >         union {
> >                 insn_value_t value;
> >                 insn_byte_t bytes[4];
> >         };
> > 	...
> > 
> > And a typedef:
> > typedef signed int insn_value_t;
> > 
> > So, the proposed code above is effectively this:
> > 
> > 	s32 foo;
> > 	signed int bar;
> > 
> > 	foo = *(s8 *)&bar;
> > 
> > That works just fine as long as the value being represented fits in a
> > single byte.  But, it *certainly* wouldn't work for:
> > 
> > 	s32 foo;
> > 	signed int bar = 128;
> > 
> > 	foo = *(s8 *)&bar;
> > 
> > In this specific case, I think the conditional jump offsets are all from
> > the (entire) second byte of the instruction, so this is _somewhat_ academic.
> 
> NOTE: Since we have checked the opcode is Jcc (0x70 to 0x7f) we ensured that
> the immediate value is 1 byte (rel8 = -128 to +127).
> 
>         case 0x70 ... 0x7f:
>                 /* 1 byte conditional jump */
>                 p->ainsn.emulate_op = kprobe_emulate_jcc;
>                 p->ainsn.jcc.type = opcode & 0xf;
>                 p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
>                 break;
> 
> But I think your have a point. I missed that Nadav is using immediate.value
> instead of immediate.bytes[0]. And from the instruction decoder code, it is
> better to use immediate.value without casting.
> 
> In arch/x86/lib/insn.c:
> 
> int insn_get_immediate(struct insn *insn)
> {
> ...
>         switch (inat_immediate_size(insn->attr)) {
>         case INAT_IMM_BYTE:
>                 insn_field_set(&insn->immediate, get_next(signed char, insn), 1);
>                 break;
> 
> And 
> 
> In arch/x86/include/asm/insn.h:
> 
> static inline void insn_field_set(struct insn_field *p, insn_value_t v,
>                                   unsigned char n)
> {
>         p->value = v;
>         p->nbytes = n;
> }
> 
> Thus the immediate.value should be set correctly. (means we don't have to
> pick up the 1st byte from the value)
> 
> Nadav, can you update your patch to assign immediate.value directly?

BTW, there are many similar casts around there. I'll fix those too.
If we need to be more conservative, 

 p->ainsn.rel32 = (s8)insn->immediate.value;

should work, right?
Or, maybe we can add WARN_ON_ONCE() as

 WARN_ON_ONCE(insn.immediate.nbytes != 1)

Thank you, 

> 
> Thank you,
> 
> > 
> > > Anyhow, after spending too much time on debugging kprobes failures,
> > > I prefer to be more defensive, and not require the code to be “aware”
> > > or rely on member types or the order of implicit casting in C.
> > 
> > Well, the code in the fix requires some awareness of the range of the
> > data type.  The simpler direct assignment:
> > 
> > 	p->ainsn.rel32 = insn->immediate.value;
> > 
> > doesn't require much and works for a wider range of values -- *ALL*
> > 32-bit signed integer values on x86.
> > 
> > I figured I must be missing something.  It would not be the first time
> > that C's type system rules tripped me up.  Why this:
> > 
> > 	foo = *(s8 *)&bar;
> > 
> > Instead of this:
> > 
> > 	foo = bar;
> > 
> > ?  I'm having a hard time of seeing what the advantage is of the 's8'
> > version.
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
