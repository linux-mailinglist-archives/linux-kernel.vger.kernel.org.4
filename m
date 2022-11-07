Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527161FEC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiKGTiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKGTiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:38:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC13765D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:38:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d10so11588402pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0nXNO5F4X/OEmXK4qyRkwnY+iEOGE2IttriqghKIjI=;
        b=H0EsCVeOp6uX+lVL8IGvqBrSOYej/AdnZNwBC9spMLX3GFT2aUlp0L1z/MW8YLShWh
         7hdCkB/7BpAsxR0Pr/4d1uVYOCXJmdydMzOmSfkFyTeYmC1H/9KELfR29I3qyo6TLO7k
         fFxETRVZQPvglBN5YSXicLYULHl3PDAE+PMMdN4scg9NC2vdP4qmPwtHY5b03il//QG8
         UNcaYo9q5yDKJ90FivqopuhhzhJXrj5jG1m0AB0j0L3sRF0IzquRQ6ETMV/e0hplthgL
         hlBFp1EZgy0KwEab4VtvFqFSaRNSF5uwd8pSEW3/DNBMtTb5Fcg1IztTf8jovNhkzJBy
         OgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0nXNO5F4X/OEmXK4qyRkwnY+iEOGE2IttriqghKIjI=;
        b=MGgsYV17B+Dgw/EwMWBGZkDF1ay3o7t0KUomyQU2ClzafsIf0xTB6DcRRMY6A9Gdu5
         tcwb4w6W6FPsqfX3ajLnZfCPrDPcLeyy0rFo7gtAsXgSi44MlF7/aeA79f2r1jrPDihZ
         kv0KNZZKPztg4GHyDWAuHU3GTHYHfh6yY17YcYcd0BQMpVdW32ENzutSwV7sHMHLamtm
         p7HWDLnUeNn03Jrs/qrO4TcB1oOj4uYcoYgVfnLDVDmwQ+sMPJXnaJgWDQr6JKVVZsrB
         r4E2888t0rXATHJIpfR54o0WD9ZH73TpZwV9LIo2dq5LQEsecrDjABMMfODEHMq2CkRg
         /eCg==
X-Gm-Message-State: ACrzQf3o7OktdnZ+sgmzzGQlL2BBlEXG0+qdjhUqGuCgnyc/K14DUSf0
        eKCb9xDeyjdBegA4wDoUYzkDN+9QgqBu4kAbsCBYaQ==
X-Google-Smtp-Source: AMsMyM4SAI/mt2eRKPzk+f9Lc7lUfmQBiUXM0dkY2aiLLgowOnkWZkBjpfh6EgPradnfJEKO1GNtMo6lQne9kPMbeYI=
X-Received: by 2002:a63:689:0:b0:46e:be81:566c with SMTP id
 131-20020a630689000000b0046ebe81566cmr45392731pgg.403.1667849928801; Mon, 07
 Nov 2022 11:38:48 -0800 (PST)
MIME-Version: 1.0
References: <1667568213-26227-1-git-send-email-quic_mojha@quicinc.com>
 <CAKwvOdkdeLEvtOmX423oYaWCami0kAFatWe25DdJq7gbmGb+5g@mail.gmail.com> <fda57ad1-bc92-a7ae-53a0-47c2a8467c47@quicinc.com>
In-Reply-To: <fda57ad1-bc92-a7ae-53a0-47c2a8467c47@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Nov 2022 11:38:37 -0800
Message-ID: <CAKwvOdmJcmnKWNSFkzCPKmJ5eVDqJ5u631hWWmEQNwPszMg_Kg@mail.gmail.com>
Subject: Re: [PATCH] gcov: clang: fix the buffer overflow issue
To:     Mukesh Ojha <quic_mojha@quicinc.com>, oberpar@linux.ibm.com
Cc:     nathan@kernel.org, trix@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 12:58 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> Hi Nick,
>
> Thanks for looking into this.
>
> On 11/4/2022 11:18 PM, Nick Desaulniers wrote:
> > On Fri, Nov 4, 2022 at 6:23 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >>
> >> Currently, in clang version of gcov code when module is getting removed
> >> gcov_info_add() incorrectly adds the sfn_ptr->counter to all the
> >> dst->functions and it result in the kernel panic in below crash report.
> >> Fix this by properly handling it.
> >>
> >> [    8.899094][  T599] Unable to handle kernel write to read-only memory at virtual address ffffff80461cc000
> >> [    8.899100][  T599] Mem abort info:
> >> [    8.899102][  T599]   ESR = 0x9600004f
> >> [    8.899103][  T599]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> [    8.899105][  T599]   SET = 0, FnV = 0
> >> [    8.899107][  T599]   EA = 0, S1PTW = 0
> >> [    8.899108][  T599]   FSC = 0x0f: level 3 permission fault
> >> [    8.899110][  T599] Data abort info:
> >> [    8.899111][  T599]   ISV = 0, ISS = 0x0000004f
> >> [    8.899113][  T599]   CM = 0, WnR = 1
> >> [    8.899114][  T599] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000ab8de000
> >> [    8.899116][  T599] [ffffff80461cc000] pgd=18000009ffcde003, p4d=18000009ffcde003, pud=18000009ffcde003, pmd=18000009ffcad003, pte=00600000c61cc787
> >> [    8.899124][  T599] Internal error: Oops: 9600004f [#1] PREEMPT SMP
> >> [    8.899265][  T599] Skip md ftrace buffer dump for: 0x1609e0
> >> ....
> >> ..,
> >> [    8.899544][  T599] CPU: 7 PID: 599 Comm: modprobe Tainted: G S         OE     5.15.41-android13-8-g38e9b1af6bce #1
> >> [    8.899547][  T599] Hardware name: XXX (DT)
> >> [    8.899549][  T599] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> >> [    8.899551][  T599] pc : gcov_info_add+0x9c/0xb8
> >> [    8.899557][  T599] lr : gcov_event+0x28c/0x6b8
> >> [    8.899559][  T599] sp : ffffffc00e733b00
> >> [    8.899560][  T599] x29: ffffffc00e733b00 x28: ffffffc00e733d30 x27: ffffffe8dc297470
> >> [    8.899563][  T599] x26: ffffffe8dc297000 x25: ffffffe8dc297000 x24: ffffffe8dc297000
> >> [    8.899566][  T599] x23: ffffffe8dc0a6200 x22: ffffff880f68bf20 x21: 0000000000000000
> >> [    8.899569][  T599] x20: ffffff880f68bf00 x19: ffffff8801babc00 x18: ffffffc00d7f9058
> >> [    8.899572][  T599] x17: 0000000000088793 x16: ffffff80461cbe00 x15: 9100052952800785
> >> [    8.899575][  T599] x14: 0000000000000200 x13: 0000000000000041 x12: 9100052952800785
> >> [    8.899577][  T599] x11: ffffffe8dc297000 x10: ffffffe8dc297000 x9 : ffffff80461cbc80
> >> [    8.899580][  T599] x8 : ffffff8801babe80 x7 : ffffffe8dc2ec000 x6 : ffffffe8dc2ed000
> >> [    8.899583][  T599] x5 : 000000008020001f x4 : fffffffe2006eae0 x3 : 000000008020001f
> >> [    8.899586][  T599] x2 : ffffff8027c49200 x1 : ffffff8801babc20 x0 : ffffff80461cb3a0
> >> [    8.899589][  T599] Call trace:
> >> [    8.899590][  T599]  gcov_info_add+0x9c/0xb8
> >> [    8.899592][  T599]  gcov_module_notifier+0xbc/0x120
> >> [    8.899595][  T599]  blocking_notifier_call_chain+0xa0/0x11c
> >> [    8.899598][  T599]  do_init_module+0x2a8/0x33c
> >> [    8.899600][  T599]  load_module+0x23cc/0x261c
> >> [    8.899602][  T599]  __arm64_sys_finit_module+0x158/0x194
> >> [    8.899604][  T599]  invoke_syscall+0x94/0x2bc
> >> [    8.899607][  T599]  el0_svc_common+0x1d8/0x34c
> >> [    8.899609][  T599]  do_el0_svc+0x40/0x54
> >> [    8.899611][  T599]  el0_svc+0x94/0x2f0
> >> [    8.899613][  T599]  el0t_64_sync_handler+0x88/0xec
> >> [    8.899615][  T599]  el0t_64_sync+0x1b4/0x1b8
> >> [    8.899618][  T599] Code: f905f56c f86e69ec f86e6a0f 8b0c01ec (f82e6a0c)
> >> [    8.899620][  T599] ---[ end trace ed5218e9e5b6e2e6 ]---
> >>
> >> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >> ---
> >>   kernel/gcov/clang.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> >> index cbb0bed..0aabb9a 100644
> >> --- a/kernel/gcov/clang.c
> >> +++ b/kernel/gcov/clang.c
> >> @@ -271,15 +271,20 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
> >>    */
> >>   void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
> >>   {
> >> -       struct gcov_fn_info *dfn_ptr;
> >> -       struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
> >> -                       struct gcov_fn_info, head);
> >
> > Hi Mukesh,
> > Thanks for the report and patch!
> >
> > Looking closer at the existing implementation, it looks curious to me
> > that we use list_first_entry_or_null() since that may return NULL,
> > which we never check for.  I'm curious if that's safe to remove?
> > Probably, since we haven't had any issues reported thus far.
> >
> >> +       struct gcov_fn_info *sfn_ptr;
> >> +       struct gcov_fn_info *dfn_ptr = list_first_entry_or_null(
> >> +                       &dst->functions, struct gcov_fn_info, head);
> >>
> >> -       list_for_each_entry(dfn_ptr, &dst->functions, head) {
> >> +       list_for_each_entry(sfn_ptr, &src->functions, head) {
> >
> > This seems to be iterating BOTH src and dest, whereas previously we
> > were only iterating dest AFAICT.  Is this correct?  Seems to be a
> > change of behavior, at the least, which seems orthogonal to fixing the
> > panic.
>
> Can you just check the implementation here once ?
>
> https://elixir.bootlin.com/linux/v6.1-rc3/source/kernel/gcov/gcc_4_7.c#L241
>
> By looking at the above link clang version does not seem to doing right ?

Oh, indeed, the GCC variant is looping over BOTH src+dest together,
then the counters.

I expect this patch to change the counter values, but I suspect they
haven't been correct previously and we've only noticed whether
branches were taken vs not.

Thanks for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Peter, can you pick this up?

>
> >
> > Otherwise it sounds like we could just add NULL ptr checks against
> > sfn_ptr outside the loop, and against dfn_ptr inside the loop.
> > Something like this?
> > ```
> > diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> > index cbb0bed958ab..5d4cb801aa9c 100644
> > --- a/kernel/gcov/clang.c
> > +++ b/kernel/gcov/clang.c
> > @@ -275,10 +275,13 @@ void gcov_info_add(struct gcov_info *dst, struct
> > gcov_info *src)
> >          struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
> >                          struct gcov_fn_info, head);
> >
> > -       list_for_each_entry(dfn_ptr, &dst->functions, head) {
> > -               u32 i;
> > +       if (!sfn_ptr)
> > +               return;
> >
> > -               for (i = 0; i < sfn_ptr->num_counters; i++)
> > +       list_for_each_entry(dfn_ptr, &dst->functions, head) {
> > +               if (!dfn_ptr)
> > +                       continue;
> > +               for (u32 i = 0, e = sfn_ptr->num_counters; i != e; ++i)
> >                          dfn_ptr->counters[i] += sfn_ptr->counters[i];
> >          }
> >   }
> > ```
> > Can you test the above hunk or comment on whether it addresses the issue?
>
>
> BTW, it just handles NUL pointer issue and not the one which is
> mentioned here.
>
> "Unable to handle kernel write to read-only memory at virtual address
> ffffff80461cc000"
>
> -Mukesh
>
> >
> >>                  u32 i;
> >>
> >> +               if (!dfn_ptr)
> >> +                       return;
> >> +
> >>                  for (i = 0; i < sfn_ptr->num_counters; i++)
> >>                          dfn_ptr->counters[i] += sfn_ptr->counters[i];
> >> +
> >> +               dfn_ptr = list_next_entry(dfn_ptr, head);
> >>          }
> >>   }
> >>
> >> --
> >> 2.7.4
> >>
> >
> >



-- 
Thanks,
~Nick Desaulniers
