Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC06AD338
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCGARI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGARG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:17:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156BC567AA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:17:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p20so12347624plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678148224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vkKpFoGZ+5lhaySQp4dtxoanu41mkOChhlNDvdqeo0=;
        b=T9inNMKTJQ+PiMEjBeNsr0hD3vUy8au1y5CA8L3HVn4W2lW3ez/s8EewH0RswQ0SCp
         kR0/13VWXzthjz4nRnXG9qXEwVhnO83kC+77sXOp96rEzfhBwbEbDuTBzoIQEYssSVLy
         KonQxN2a823Ha1S1Uw5oYDUYYWcP2T8tNLNMYtKSUCj78DwYbspevgJbINJWjFLwKJKl
         nvcA2YahedT8NI1l9AKWvO2iwiCiOUJKkPG3g+KuMlt1pNw+fvTyjaRQF2nOGtTBXR2h
         jpD2HQXzvTfxYeW5XQrd8hUbl2UZuncJWnjEQ+Jzs3AwTtz8nzmRm3t4guh6POnwZyvc
         twLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vkKpFoGZ+5lhaySQp4dtxoanu41mkOChhlNDvdqeo0=;
        b=vMwzZ6xUeGrhtzIeTuCwe4Dhl0UNl+Y6aXClS8GPU+GaTM5jVZpkHU/YK7WKCgirtC
         mwCNKPm51yIpYtA56cFGaVu3VEowjM636H40gKLVcfnoMkTkQjzx86UIpl6vJ5J2ckmo
         RxyVqjcjX2bAB7GblqKU6RpWGG5caIQWEFBKiG3WM6L00CX2Euncm2L+Npj/rCtas12E
         QXrFEe/qBLOov34EPdCZsHW0zAAujuE2oRMMOTXD5fk6Tdpxk0fUl0MgwFhLHv3ASepE
         QsQFXESL19hKrhxUc2WRPGOfbeTkawkFMVFvAGtIFRdasbLBXsYabVmjY2t1NXeR9PRr
         s8XA==
X-Gm-Message-State: AO0yUKW2zTqspXSaJ+9xjXBxnIDz4JGbBJHLsQiBjy37VUKSSlLmaaHd
        nW599KPDgCpgiWmk3+Ac9lfJHIngGqmUNhLuBbkjbTiEsqp2Wa/JceIXrYOb
X-Google-Smtp-Source: AK7set+GtYDMQ7ycRITNAmRQeXNwwJCWTU5HqQKdv2jt8XcCpJs6QDostciaUhOxSlbV5IVUo32AuMDoLZbOdmhEpZU=
X-Received: by 2002:a17:902:ab4f:b0:19b:5233:51c6 with SMTP id
 ij15-20020a170902ab4f00b0019b523351c6mr4890025plb.0.1678148223882; Mon, 06
 Mar 2023 16:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
In-Reply-To: <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Mar 2023 16:16:52 -0800
Message-ID: <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start of Lore thread:
https://lore.kernel.org/lkml/20230303231133.1486085-1-eranian@google.com/

On Mon, Mar 6, 2023 at 4:01=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Mar 03, 2023 at 03:11:33PM -0800, Stephane Eranian wrote:
>
> > The problem is located in the __resctrl_sched_in() routine which rewrit=
es
> > the active closid via the PQR_ASSOC register. Because this is an expens=
ive
> > operation, the kernel only does it when the context switch involves tas=
ks
> > with different CLOSID. And to check that, it needs to access the curren=
t
> > task's closid field using current->closid. current is actually a macro
> > that reads the per-cpu variable pcpu_hot.current_task.
> >
> > After an investigation by compiler experts, the problem has been tracke=
d down
> > to the usage of the get_current() macro in the __resctrl_sched_in() cod=
e and
> > in particular the per-cpu macro:
> >
> > static __always_inline struct task_struct *get_current(void)
> > {
> >         return this_cpu_read_stable(pcpu_hot.current_task);
> > }
> >
> > And as per percpu.h:
> >
> > /*
> >  * this_cpu_read() makes gcc load the percpu variable every time it is
> >  * accessed while this_cpu_read_stable() allows the value to be cached.
> >  * this_cpu_read_stable() is more efficient and can be used if its valu=
e
> >  * is guaranteed to be valid across cpus.  The current users include
> >  * get_current() and get_thread_info() both of which are actually
> >  * per-thread variables implemented as per-cpu variables and thus
> >  * stable for the duration of the respective task.
> >  */
> >
> > The _stable version of the macro allows the value to be cached, meaning=
 it
> > does not force a reload.
>
> Right, so afaict the difference between this_cpu_read() and
> this_cpu_read_stable() is the volatile qualifier.
>
> this_cpu_read() is asm volatile(), while this_cpu_read_stable() and
> raw_cpu_read() are both an unqualified asm().
>
> Now, afaiu we're inlining all of this into __switch_to(), which has
> raw_cpu_write(pcpu_hot.current_task, next_p).
>
> And I suppose what the compiler is doing is lifting the 'current' load
> over that store, but how is it allowed that? I thought C was supposed to
> have PO consistency, That raw_cpu_write() should be seen as a store to
> to pcpu_hot.current_task, why can it lift a load over the store?
>
> Specifically, percpu_to_op() has a "+m" output constaint while
> percpu_stable_op() has a "p" input constraint on the same address.

I definitely think the issue is specific to "p" constraints.
https://godbolt.org/z/34YeG6WbY is the test case I reduced which I
think demonstrates the issue.

https://reviews.llvm.org/D145416
-> click "Show Older Changes" for the ongoing discussion.

I don't have a satisfactory answer yet, but am looking into this.

>
> Compiler folks help?



--=20
Thanks,
~Nick Desaulniers
