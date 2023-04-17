Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002176E51E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDQUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjDQUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:30:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3071FC2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:29:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f086770a50so12545235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681763398; x=1684355398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNsY/om+mAROto3FUjviflZNhDllR9YU7fZAWFjD/S4=;
        b=3jsA5YcNZFjbuJShlzhdTusHgdyl0Vo2swVZVMT02Vte/u4gDfvHFmITSKVxeR9M6N
         9iRSjpPchuC6DqtRbIje6ux15qxd5J97xRp33/sxavH4InZxjIYTTaFgha6LgGoE1xjT
         6Crgzg6IhEKBTkbFNzjKtLXi67XQFlIlUIPgTuKn7j9Bba73hUCVrxJRXV7xVvGecjHq
         ZfNgjSsqEvw4i02M92CTD9eptdP7i7f+gJlwMT+fhgkalEgU6nZPXzP7PZTHiss7Q6aC
         nDrt0r3cqQtyub9yLRr4yDahZQIZ8KGCzX5k4iuXQMcxm6SDAtd2Xfw5yfLIu6/SyxwP
         HJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681763398; x=1684355398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNsY/om+mAROto3FUjviflZNhDllR9YU7fZAWFjD/S4=;
        b=GNMYyQUdWAm9noqoxwENXagnwJCeXosTI98hS8weGU8T/SalcBaQ2kfB2fPcmxzDge
         CrJff5+NDUFDraLjtOFz/1tlgUQ9l0E+KnB4alEtg/6VWJ7nV9RpJJ7ZaoCmKXBlK7zE
         aoZrP3l9SLjoBfPMYKoPqyRSfQNuCEUTQW+A9k6CKRGM2c01BWi81dSyy6o1eibtc9Dz
         0uEbY+mKTZb2d6cYbtFHw7Vpi2Gm0ICTSaB2LCjTR8eZAGsoHGSRdc6SF6bthu00EOd7
         6oBylD2NN8YdT+tYoOrEj7PpYephiGBUK90OjoZCfj7ahnhjbb4kAmUvtlfk47LVhZz+
         Af2Q==
X-Gm-Message-State: AAQBX9eRUIEcjUBzgjL7lWn0iQyPxJPze2G8JMFAKko/jsuqnPYPMZXW
        D4xtD4fAt8ntgwhd7x67J1KNRdN3hQNKfpUvo4BCLw==
X-Google-Smtp-Source: AKy350bYy3mB/npaRZtWfAg/g4Oif8VApb5XzXGUONnx+3hFrOC06b9giuEnx2hfHJbKBQTc6d4xCUELVtzWff0779k=
X-Received: by 2002:a5d:5254:0:b0:2ef:ae9e:b191 with SMTP id
 k20-20020a5d5254000000b002efae9eb191mr107312wrc.45.1681763398159; Mon, 17 Apr
 2023 13:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
In-Reply-To: <ZD2gsbN2K66oXT69@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Apr 2023 13:29:45 -0700
Message-ID: <CAJuCfpFOSjES2hVM+zZX_i95JBBaZKr6zE9B8tWm_JqROJBPiQ@mail.gmail.com>
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

On Mon, Apr 17, 2023 at 12:40=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> > If the page fault handler requests a retry, we will count the fault
> > multiple times. This is a relatively harmless problem as the retry path=
s
> > are not often requested, and the only user-visible problem is that the
> > fault counter will be slightly higher than it should be.  Nevertheless,
> > userspace only took one fault, and should not see the fact that the
> > kernel had to retry the fault multiple times.
> > Move page fault accounting into mm_account_fault() and skip incomplete
> > faults which will be accounted upon completion.
> >
> > Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transf=
er")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 26 insertions(+), 19 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 01a23ad48a04..c3b709ceeed7 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5080,24 +5080,30 @@ static vm_fault_t __handle_mm_fault(struct vm_a=
rea_struct *vma,
> >   * updates.  However, note that the handling of PERF_COUNT_SW_PAGE_FAU=
LTS should
> >   * still be in per-arch page fault handlers at the entry of page fault=
.
> >   */
> > -static inline void mm_account_fault(struct pt_regs *regs,
> > +static inline void mm_account_fault(struct mm_struct *mm, struct pt_re=
gs *regs,
> >                                   unsigned long address, unsigned int f=
lags,
> >                                   vm_fault_t ret)
> >  {
> >       bool major;
> >
> >       /*
> > -      * We don't do accounting for some specific faults:
> > -      *
> > -      * - Unsuccessful faults (e.g. when the address wasn't valid).  T=
hat
> > -      *   includes arch_vma_access_permitted() failing before reaching=
 here.
> > -      *   So this is not a "this many hardware page faults" counter.  =
We
> > -      *   should use the hw profiling for that.
> > -      *
> > -      * - Incomplete faults (VM_FAULT_RETRY).  They will only be count=
ed
> > -      *   once they're completed.
> > +      * Do not account for incomplete faults (VM_FAULT_RETRY). They wi=
ll be
> > +      * counted upon completion.
> >        */
> > -     if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > +     if (ret & VM_FAULT_RETRY)
> > +             return;
> > +
> > +     /* Register both successful and failed faults in PGFAULT counters=
. */
> > +     count_vm_event(PGFAULT);
> > +     count_memcg_event_mm(mm, PGFAULT);
>
> Is there reason on why vm events accountings need to be explicitly
> different from perf events right below on handling ERROR?
>
> I get the point if this is to make sure ERROR accountings untouched for
> these two vm events after this patch. IOW probably the only concern right
> now is having RETRY counted much more than before (perhaps worse with vma
> locking applied).
>
> But since we're on this, I'm wondering whether we should also align the t=
wo
> events (vm, perf) so they represent in an aligned manner if we'll change =
it
> anyway.  Any future reader will be confused on why they account
> differently, IMHO, so if we need to differenciate we'd better add a comme=
nt
> on why.
>
> I'm wildly guessing the error faults are indeed very rare and probably no=
t
> matter much at all.  I just think the code can be slightly cleaner if
> vm/perf accountings match and easier if we treat everything the same. E.g=
.,
> we can also drop the below "goto out"s too.  What do you think?

I think the rationale might be that vm accounting should account for
*all* events, including failing page faults while for perf, the corner
cases which rarely happen would not have tangible effect.
I don't have a strong position on this issue and kept it as is to
avoid changing the current accounting approach. If we are fine with
such consolidation which would miss failing faults in vm accounting, I
can make the change.
Thanks,
Suren.

>
> Thanks,
>
> > +
> > +     /*
> > +      * Do not account for unsuccessful faults (e.g. when the address =
wasn't
> > +      * valid).  That includes arch_vma_access_permitted() failing bef=
ore
> > +      * reaching here. So this is not a "this many hardware page fault=
s"
> > +      * counter.  We should use the hw profiling for that.
> > +      */
> > +     if (ret & VM_FAULT_ERROR)
> >               return;
> >
> >       /*
> > @@ -5180,21 +5186,22 @@ static vm_fault_t sanitize_fault_flags(struct v=
m_area_struct *vma,
> >  vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long a=
ddress,
> >                          unsigned int flags, struct pt_regs *regs)
> >  {
> > +     /* Copy vma->vm_mm in case mmap_lock is dropped and vma becomes u=
nstable. */
> > +     struct mm_struct *mm =3D vma->vm_mm;
> >       vm_fault_t ret;
> >
> >       __set_current_state(TASK_RUNNING);
> >
> > -     count_vm_event(PGFAULT);
> > -     count_memcg_event_mm(vma->vm_mm, PGFAULT);
> > -
> >       ret =3D sanitize_fault_flags(vma, &flags);
> >       if (ret)
> > -             return ret;
> > +             goto out;
> >
> >       if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> >                                           flags & FAULT_FLAG_INSTRUCTIO=
N,
> > -                                         flags & FAULT_FLAG_REMOTE))
> > -             return VM_FAULT_SIGSEGV;
> > +                                         flags & FAULT_FLAG_REMOTE)) {
> > +             ret =3D VM_FAULT_SIGSEGV;
> > +             goto out;
> > +     }
> >
> >       /*
> >        * Enable the memcg OOM handling for faults triggered in user
> > @@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct =
*vma, unsigned long address,
> >               if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
> >                       mem_cgroup_oom_synchronize(false);
> >       }
> > -
> > -     mm_account_fault(regs, address, flags, ret);
> > +out:
> > +     mm_account_fault(mm, regs, address, flags, ret);
> >
> >       return ret;
> >  }
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
> >
>
> --
> Peter Xu
>
