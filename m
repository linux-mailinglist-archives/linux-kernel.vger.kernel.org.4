Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1673A628
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFVQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFVQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:34:19 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CBD1BD8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:34:18 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 35MGXcO02980495
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 22 Jun 2023 09:33:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 35MGXcO02980495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023061001; t=1687451619;
        bh=V/krA/FiwLB04skP64ycol5Kjyh+0K7zIpQefk1QiZs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=EWOxaldq07Pt6TwvXZON8Dpx2IybTpBkVqHOdCQqAcQfBsoSaGybQxMizhtQVztAG
         uw07hug8x8XN8mPlWt/El16C0AfjosOEgDQkiK1L3EYd2TTWAPwtQ5djT8MF0Wp+6G
         evS551sSjxCMCPZ12ZGGnCKivqbqh9QOpTpi9mK3JYOoXkKlvB40mko8PXutveDi+l
         bTOw+KuwuGhPYl3O1sMvMQXRzDEBNyFjXRt+LMY7o2vHnZU4LjC8X+3miNkRVNqF0b
         kJ8JqTqdCOHgSbXoV8LGqogmDd+l3pc3YNp954WivP968IJMncts9IhPozT5auffV5
         e2MS8NMT4eOVQ==
Date:   Thu, 22 Jun 2023 09:33:36 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brian Gerst <brgerst@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, xin3.li@Intel.com
CC:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86: Rewrite ret_from_fork() in C
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2gpT-TN8Ffbhd1Frw3Yui=JMbW6jnELVQ6GKbY_+5=ctg@mail.gmail.com>
References: <20230622120750.5549-1-brgerst@gmail.com> <20230622120750.5549-3-brgerst@gmail.com> <20230622132904.GR4253@hirez.programming.kicks-ass.net> <CAMzpN2gpT-TN8Ffbhd1Frw3Yui=JMbW6jnELVQ6GKbY_+5=ctg@mail.gmail.com>
Message-ID: <A3B8E321-A218-4B4A-BE05-F6FE15E34D7F@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 22, 2023 9:04:03 AM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Thu, Jun 22, 2023 at 9:29=E2=80=AFAM Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>>
>> On Thu, Jun 22, 2023 at 08:07:50AM -0400, Brian Gerst wrote:
>> > When kCFI is enabled, special handling is needed for the indirect cal=
l
>> > to the kernel thread function=2E  Rewrite the ret_from_fork() functio=
n in
>> > C so that the compiler can properly handle the indirect call=2E
>> >
>> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>> > Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>>
>> This is much nicer indeed=2E I'll take these patches into my series and
>> repost later today if you don't mind=2E
>
>Yes, that's fine=2E
>
>> One little niggle below=2E=2E
>>
>> > ---
>>
>> > diff --git a/arch/x86/entry/entry_64=2ES b/arch/x86/entry/entry_64=2E=
S
>> > index f31e286c2977=2E=2E5ee32e7e29e8 100644
>> > --- a/arch/x86/entry/entry_64=2ES
>> > +++ b/arch/x86/entry/entry_64=2ES
>> > @@ -284,36 +284,21 @@ SYM_FUNC_END(__switch_to_asm)
>> >   * r12: kernel thread arg
>> >   */
>> >  =2Epushsection =2Etext, "ax"
>> > +SYM_CODE_START(ret_from_fork_asm)
>> >       UNWIND_HINT_END_OF_STACK
>> >       ANNOTATE_NOENDBR // copy_thread
>> >       CALL_DEPTH_ACCOUNT
>> >
>> > +     /* return address for the stack unwinder */
>> > +     pushq   $swapgs_restore_regs_and_return_to_usermode
>> > +     UNWIND_HINT_FUNC
>> >
>> > +     movq    %rax, %rdi              /* prev */
>> > +     movq    %rsp, %rsi              /* regs */
>> > +     movq    %rbx, %rdx              /* fn */
>> > +     movq    %r12, %rcx              /* fn_arg */
>> > +     jmp     ret_from_fork
>> > +SYM_CODE_END(ret_from_fork_asm)
>> >  =2Epopsection
>> >
>> >  =2Emacro DEBUG_ENTRY_ASSERT_IRQS_OFF
>>
>> > diff --git a/arch/x86/kernel/process=2Ec b/arch/x86/kernel/process=2E=
c
>> > index dac41a0072ea=2E=2Ef5dbfebac076 100644
>> > --- a/arch/x86/kernel/process=2Ec
>> > +++ b/arch/x86/kernel/process=2Ec
>> > @@ -28,6 +28,7 @@
>> >  #include <linux/static_call=2Eh>
>> >  #include <trace/events/power=2Eh>
>> >  #include <linux/hw_breakpoint=2Eh>
>> > +#include <linux/entry-common=2Eh>
>> >  #include <asm/cpu=2Eh>
>> >  #include <asm/apic=2Eh>
>> >  #include <linux/uaccess=2Eh>
>> > @@ -134,6 +135,25 @@ static int set_new_tls(struct task_struct *p, un=
signed long tls)
>> >               return do_set_thread_area_64(p, ARCH_SET_FS, tls);
>> >  }
>> >
>> > +__visible noinstr void ret_from_fork(struct task_struct *prev, struc=
t pt_regs *regs,
>> > +                                  int (*fn)(void *), void *fn_arg)
>>
>> So I had noinstr in my initial patch, but it leads to objtool
>> complaints=2E I suppose we can actually handle tracing and all the othe=
r
>> gunk at this point, so I've removed it=2E
>
>I'm not an expert on noinstr usage, but looking at the other syscall
>functions, instrumentation needs to be disabled before
>syscall_exit_to_user_mode() is called=2E  Perhaps adding an
>instrumentation_begin()/instrumentation_end() pair to this function is
>needed?
>
>Brian Gerst
>

I don't have the code in front of me right now, but how does this affect F=
RED enabling? In the case of FRED, the exit path is much simpler; in the FR=
ED enabling patchset we simply deal with it by alternatives-patching the te=
rminal jump after resetting the stack pointer to the standard FRED user spa=
ce exit stub (which simply pops the user space registers and executes ERETU=
=2E)

I'm assuming this is still valid/possible after your patches, since resett=
ing the stack pointer isn't possible in C, but I wanted to double check=2E
