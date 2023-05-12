Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488A7005C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjELKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjELKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:40:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1FFA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gJ+bA78d7jWesX/mLHWzb/x8ZRjp6m+KT9TC6A+dNDM=; b=lDVFPjpyOQsVKN3Nw2OOr58yDn
        ZI4xnV+eYXd40YbGRbr6A/npZR5mTy4/zksJ0VKz5CQN2g/9L0kiCk/S3/Ni9UT/4/u0XtfeDbd2J
        9qlvYLcNxfs+TpNJqBD2bkzVQiCEZEpe4lEGlr6sw66N49ijDOIlem6lGmsW/Yl9iqut6hkLK6tmW
        ohbLmSt5ye24eFam7ztwDE+6L48ulfkFJPnhGZSNrMfXz+b6y5bl7GazSCRvp1hFrduMr6LYVNhqc
        AtaDMoockUa2HWaAUG5P/8TW4Fr/7YFxfeBkg+M1d5wvFI4cl4FISDEck6jn2BtsXhPvpK02GAHSu
        Z0dZR0ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxQC8-0097md-1I;
        Fri, 12 May 2023 10:40:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A73B3000DC;
        Fri, 12 May 2023 12:40:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3CFC2C7DB768; Fri, 12 May 2023 12:40:13 +0200 (CEST)
Date:   Fri, 12 May 2023 12:40:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/wait: Fix a kthread_park race with wait_woken()
Message-ID: <20230512104013.GA2319858@hirez.programming.kicks-ass.net>
References: <20230406194053.876844-1-arve@android.com>
 <20230511214144.1924757-1-jstultz@google.com>
 <20230511223124.GJ2296992@hirez.programming.kicks-ass.net>
 <CANDhNCp-na5EE2o9furCtnm1Fz_WAaHpWh24e1sbwc-U+=ktog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCp-na5EE2o9furCtnm1Fz_WAaHpWh24e1sbwc-U+=ktog@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:52:24PM -0700, John Stultz wrote:
> On Thu, May 11, 2023 at 3:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, May 11, 2023 at 09:41:30PM +0000, John Stultz wrote:
> > > From: Arve Hjønnevåg <arve@android.com>
> > >
> > > kthread_park and wait_woken have a similar race that kthread_stop and
> > > wait_woken used to have before it was fixed in
> > > cb6538e740d7543cd989128625cf8cac4b471e0a. Extend that fix to also cover
> >
> >   cb6538e740d7 ("sched/wait: Fix a kthread race with wait_woken()")
> >
> > > kthread_park.
> > >
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Ben Segall <bsegall@google.com>
> > > Cc: Mel Gorman <mgorman@suse.de>
> > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Signed-off-by: Arve Hjønnevåg <arve@android.com>
> > > Signed-off-by: John Stultz <jstultz@google.com>
> > > ---
> > > This seemingly slipped by, so I wanted to resend it
> > > for review.
> > > ---
> > >  kernel/sched/wait.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> > > index 133b74730738..a9cf49da884b 100644
> > > --- a/kernel/sched/wait.c
> > > +++ b/kernel/sched/wait.c
> > > @@ -425,9 +425,9 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
> > >  }
> > >  EXPORT_SYMBOL(autoremove_wake_function);
> > >
> > > -static inline bool is_kthread_should_stop(void)
> > > +static inline bool is_kthread_should_stop_or_park(void)
> > >  {
> > > -     return (current->flags & PF_KTHREAD) && kthread_should_stop();
> > > +     return (current->flags & PF_KTHREAD) && (kthread_should_stop() || kthread_should_park());
> > >  }
> > >
> > >  /*
> >
> > That's a bit sad; that two function calls for checking two consecutive
> > bits in the same word :-(
> >
> > If we move this to kthread.c and write it like:
> >
> >         kthread = __to_kthread(current);
> >         if (!kthread)
> >                 return false;
> >
> >         return test_bit(KTHREAD_SHOULD_STOP, &kthread->flags) ||
> >                test_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> >
> > Then the compiler should be able to merge the two bits in a single load
> > and test due to constant_test_bit() -- do check though.
> 
> Hrm. Apologies, as it's been awhile since I've looked at disassembled
> asm, so I may be wrong, but I don't think that's happening here.
> 
> With the logic above I'm seeing it build as:
> 0000000000000a50 <kthread_should_stop_or_park>:
>      a50:       65 48 8b 14 25 00 00    mov    %gs:0x0,%rdx
>      a57:       00 00
>      a59:       48 8b 8a 78 0a 00 00    mov    0xa78(%rdx),%rcx
>      a60:       31 c0                   xor    %eax,%eax
>      a62:       48 85 c9                test   %rcx,%rcx
>      a65:       74 11                   je     a78  <kthread_should_stop_or_park+0x28>
>      a67:       f6 42 2e 20             testb  $0x20,0x2e(%rdx)
>      a6b:       74 0b                   je     a78  <kthread_should_stop_or_park+0x28>
>      a6d:       48 8b 01                mov    (%rcx),%rax
>      a70:       48 d1 e8                shr    %rax
>      a73:       83 e0 01                and    $0x1,%eax
>      a76:       74 05                   je     a7d  <kthread_should_stop_or_park+0x2d>
>      a78:       e9 00 00 00 00          jmp    a7d  <kthread_should_stop_or_park+0x2d>
>      a7d:       48 8b 01                mov    (%rcx),%rax
>      a80:       48 c1 e8 02             shr    $0x2,%rax
>      a84:       83 e0 01                and    $0x1,%eax
>      a87:       e9 00 00 00 00          jmp    a8c  <kthread_should_stop_or_park+0x3c>
>      a8c:       0f 1f 40 00             nopl   0x0(%rax)

Moo, where is that optimization pass when you need it ;-)

If we forgo test_bit() and write it plainly it seems to work:

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 7e6751b29101..36f94616cae5 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -164,6 +164,15 @@ bool __kthread_should_park(struct task_struct *k)
 }
 EXPORT_SYMBOL_GPL(__kthread_should_park);
 
+bool kthread_should_stop_or_park(void)
+{
+	struct kthread *kthread = __to_kthread(current);
+	if (!kthread)
+		return false;
+
+	return kthread->flags & (BIT(KTHREAD_SHOULD_STOP) | BIT(KTHREAD_SHOULD_PARK));
+}
+
 /**
  * kthread_should_park - should this kthread park now?
  *


0000000000001850 <kthread_should_stop_or_park>:
    1850:       f3 0f 1e fa             endbr64
    1854:       65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     1859: R_X86_64_32S      pcpu_hot
    185d:       48 8b 88 08 06 00 00    mov    0x608(%rax),%rcx
    1864:       31 d2                   xor    %edx,%edx
    1866:       48 85 c9                test   %rcx,%rcx
    1869:       74 0c                   je     1877 <kthread_should_stop_or_park+0x27>
    186b:       f6 40 2e 20             testb  $0x20,0x2e(%rax)
    186f:       74 06                   je     1877 <kthread_should_stop_or_park+0x27>
    1871:       f6 01 06                testb  $0x6,(%rcx)
    1874:       0f 95 c2                setne  %dl
    1877:       89 d0                   mov    %edx,%eax
    1879:       e9 00 00 00 00          jmp    187e <kthread_should_stop_or_park+0x2e>  187a: R_X86_64_PLT32    __x86_return_thunk-0x4
