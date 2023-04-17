Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162626E53CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDQVVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjDQVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:21:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EDE3AB3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:21:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f21cdfadbso382242417b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681766490; x=1684358490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skxzpscAsv87Qax/0bgvCnRhsQO+KKAWjy3PoG439VQ=;
        b=gPqjm7ba7fTmREghp9AWYVRFKr58sh4PS4CfZ/Fnori3qEbcxS/KfNJS0XZwsW6GMt
         TXVFCHSJ7Fn8o4+mQUwJuzw8Xp2NiDUo628lJRW5a9v7nuVqXxflBpIPPu+E2tPFnIyN
         W6IiBRfuAApLpYfoMZRm+fp/BqLRT05Yn8x+14P7AKCmF8kchA2oGoMy60I2IKYzf3To
         uIyxyZYfmT9LqIOpcM/u1oXW0kRh5iF94aoioa3wL1b52JC8lpyn0G+URi0+xcWo6fbE
         5HhM/x6usH5b2BLb48d6c5ugHQCrYB2Y6aVkotUvnHFddkvcoumGa35c786bME/oi6p6
         UFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766490; x=1684358490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skxzpscAsv87Qax/0bgvCnRhsQO+KKAWjy3PoG439VQ=;
        b=hxuDSj9WyVBo8QOYMuyZsv4+lAe4ptDCvDgkIgitZW9LemIda7+c5BmjdrgSVvCgr7
         rNsylebVgyglCFdAp/hvoC73XXa3kVjBCsCIxJIMEu7xUqCK5O3orUKfQgU5njgdF3rU
         eJncdL/CJTGkbDy24ebnSYI2aESrLl/WOFS2jh/ASdMQDFpvRPldTbIUV0nevrL8BrJi
         KlMNK5dR3WZdjRB2QMpwAWJrQkAZ2Lj+RQX2bV4rAcMyKVNL1aEvjKiqQiAuAGfhgIsV
         U/bNBr2CL69EaSdEjZTvoocc4hgDTgIMxqkPuekNCDpoETCdCSNlYgPEty9xoGAYvj0Y
         D6ww==
X-Gm-Message-State: AAQBX9d3348lkaENF5iAbBUedtO9VhEkwmTyfxtQluT9RbxCgbsBnkMe
        7Ficb/sT+doC/Xb3mFXIgyBuFCNEm5rbblHPlbP5ZA==
X-Google-Smtp-Source: AKy350blLU+TA2bW6CBbSNbqjHX8LQL1OTHe90yUAeABat6gSKf2OL44RLi4ryGaIDgRHCVtrb0qdgDt2Dwdph7UlPE=
X-Received: by 2002:a81:d441:0:b0:54f:a60c:12eb with SMTP id
 g1-20020a81d441000000b0054fa60c12ebmr9831050ywl.1.1681766490351; Mon, 17 Apr
 2023 14:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
 <CAJuCfpFOSjES2hVM+zZX_i95JBBaZKr6zE9B8tWm_JqROJBPiQ@mail.gmail.com> <ZD22q95Vaex5dfU1@x1n>
In-Reply-To: <ZD22q95Vaex5dfU1@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Apr 2023 14:21:19 -0700
Message-ID: <CAJuCfpEJph_ZDN-XCQZwrNBu+Ss44At+cEQ7MLAtsyGHGbH3PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 2:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 17, 2023 at 01:29:45PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Apr 17, 2023 at 12:40=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> > > > If the page fault handler requests a retry, we will count the fault
> > > > multiple times. This is a relatively harmless problem as the retry =
paths
> > > > are not often requested, and the only user-visible problem is that =
the
> > > > fault counter will be slightly higher than it should be.  Neverthel=
ess,
> > > > userspace only took one fault, and should not see the fact that the
> > > > kernel had to retry the fault multiple times.
> > > > Move page fault accounting into mm_account_fault() and skip incompl=
ete
> > > > faults which will be accounted upon completion.
> > > >
> > > > Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk tr=
ansfer")
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
> > > >  1 file changed, 26 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 01a23ad48a04..c3b709ceeed7 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -5080,24 +5080,30 @@ static vm_fault_t __handle_mm_fault(struct =
vm_area_struct *vma,
> > > >   * updates.  However, note that the handling of PERF_COUNT_SW_PAGE=
_FAULTS should
> > > >   * still be in per-arch page fault handlers at the entry of page f=
ault.
> > > >   */
> > > > -static inline void mm_account_fault(struct pt_regs *regs,
> > > > +static inline void mm_account_fault(struct mm_struct *mm, struct p=
t_regs *regs,
> > > >                                   unsigned long address, unsigned i=
nt flags,
> > > >                                   vm_fault_t ret)
> > > >  {
> > > >       bool major;
> > > >
> > > >       /*
> > > > -      * We don't do accounting for some specific faults:
> > > > -      *
> > > > -      * - Unsuccessful faults (e.g. when the address wasn't valid)=
.  That
> > > > -      *   includes arch_vma_access_permitted() failing before reac=
hing here.
> > > > -      *   So this is not a "this many hardware page faults" counte=
r.  We
> > > > -      *   should use the hw profiling for that.
> > > > -      *
> > > > -      * - Incomplete faults (VM_FAULT_RETRY).  They will only be c=
ounted
> > > > -      *   once they're completed.
> > > > +      * Do not account for incomplete faults (VM_FAULT_RETRY). The=
y will be
> > > > +      * counted upon completion.
> > > >        */
> > > > -     if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > > +     if (ret & VM_FAULT_RETRY)
> > > > +             return;
> > > > +
> > > > +     /* Register both successful and failed faults in PGFAULT coun=
ters. */
>
> [1]
>
> > > > +     count_vm_event(PGFAULT);
> > > > +     count_memcg_event_mm(mm, PGFAULT);
> > >
> > > Is there reason on why vm events accountings need to be explicitly
> > > different from perf events right below on handling ERROR?
> > >
> > > I get the point if this is to make sure ERROR accountings untouched f=
or
> > > these two vm events after this patch. IOW probably the only concern r=
ight
> > > now is having RETRY counted much more than before (perhaps worse with=
 vma
> > > locking applied).
> > >
> > > But since we're on this, I'm wondering whether we should also align t=
he two
> > > events (vm, perf) so they represent in an aligned manner if we'll cha=
nge it
> > > anyway.  Any future reader will be confused on why they account
> > > differently, IMHO, so if we need to differenciate we'd better add a c=
omment
> > > on why.
> > >
> > > I'm wildly guessing the error faults are indeed very rare and probabl=
y not
> > > matter much at all.  I just think the code can be slightly cleaner if
> > > vm/perf accountings match and easier if we treat everything the same.=
 E.g.,
> > > we can also drop the below "goto out"s too.  What do you think?
> >
> > I think the rationale might be that vm accounting should account for
> > *all* events, including failing page faults while for perf, the corner
> > cases which rarely happen would not have tangible effect.
>
> Note that it's not only for perf, but also task_struct.maj_flt|min_flt.
>
> If we check the reasoning of "why ERROR shouldn't be accounted for perf
> events", there're actually something valid in the comment:
>
>          * - Unsuccessful faults (e.g. when the address wasn't valid).  T=
hat
>          *   includes arch_vma_access_permitted() failing before reaching=
 here.
>          *   So this is not a "this many hardware page faults" counter.  =
We
>          *   should use the hw profiling for that.
>
> IMHO it suggests that if someone wants to trap either ERROR or RETRY one
> can use the hardware counters instead.  The same reasoning just sounds
> applicable to vm events too, because vm events are not special in this ca=
se
> to me.
>
> > I don't have a strong position on this issue and kept it as is to
> > avoid changing the current accounting approach. If we are fine with
> > such consolidation which would miss failing faults in vm accounting, I
> > can make the change.
>
> I don't have a strong opinion either.  We used to change this path before
> for perf events and task events and no one complains with the change.  I'=
d
> just bet the same to vm events:
>
> https://lore.kernel.org/all/20200707225021.200906-1-peterx@redhat.com/

Ok, if these rare failures don't change anything then let's
consolidate the code. It should simplify things a bit and will account
faults in a consistent way. I'll post v3 shortly incorporating your
and Matthew's feedbacks. Thanks for the input!

>
> Please feel free to keep it as-is if you still feel unsafe on changing
> ERROR handling.  If so, would you mind slightly modify [1] above explaini=
ng
> why we need ERROR to be accounted for vm accountings with the reasoning?
> Current comment only says "what it does" rather than why.
>
> Thanks,
>
> --
> Peter Xu
>
