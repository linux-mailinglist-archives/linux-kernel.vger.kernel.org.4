Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7006E2C70
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNW0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDNW0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:26:16 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955AEB4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:26:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fe82d8bf5so54538517b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681511175; x=1684103175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zo5vi/OUyjW18FHtcym6cirbr2/eIzRlQ1LRqhG3GY=;
        b=GWKNzmUVOGiLIAfUwSiBRxsKt4GwKIfy+0j6OAsN0mqsgAgWNRJ9wlEjLL3ugCNS78
         6hxjzhZxO3qRxioyxewdPISwbWiGfGAsDaO69CseW+1hR0N7sOz9BCAhxYqQfhy/5VI/
         +QyBz7BkxLno38LWBDkV4GYqen4AXCI+v7IllOan2OEZUTWT5ZGe+DeaMborbwZeDG/D
         Wa7RR9O+TCtZhLqlf+Pj5pfwks+oFcVghutImp63URcO+O9eIul/3M0xdw2LwNf7Rk6u
         5i7YXqH2cD1FUPsFakkd9pQnPmT6hyX71kWbHJWgzzJzzb22lMl3RJY+ivzBmKWEbYjG
         YN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511175; x=1684103175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zo5vi/OUyjW18FHtcym6cirbr2/eIzRlQ1LRqhG3GY=;
        b=AzZ6NmWtWVlUULbdzpiSg1Kd0CtGHE5k2qnLFzsfvEV/2Kg04X6GCvq3uXHtKWKkyv
         97gPVLoeByvTkrveMTCLqoj0pGAVseaJfslNcoGlAEwLq+zGG6C3ijZtCnZcFM+m4UwM
         meZdM2FgR8N69nn+IO5ghVJiRR+Ek2MYU8yT4lJu7BfgHbeyhPVc5oTT+E9eWvdbnVaS
         4i7w5vWrdR3i7RCmsgSwWAd1pzggil6FtOqqQlYqp6xywQfCgL4wPu6kx9ZzIR8TwGA8
         Ce7Ac9umHJ/i+F5qG2+dVLLaclGY4w6JzKXaBAwVHrjmAQq2WdP8XP87VbUEOE/oNyIv
         5+fw==
X-Gm-Message-State: AAQBX9fdx8W6FU4EAEvyz+ZlWFyoShYA73eK+AA+qbFwAkeIKCtjDBEF
        hchFA5yc655EGJseTjZbtp7VnUQR3rWh+DHl0IZX7A==
X-Google-Smtp-Source: AKy350a6izrIjhN/n8CfqBd++qEYoiOYfIqd1Czw5zeeiDH3YQmm42V3W+2ubr9idRCr1myaN3sI9FZr9eUCHvlZrIA=
X-Received: by 2002:a81:d44c:0:b0:54e:d618:f86c with SMTP id
 g12-20020a81d44c000000b0054ed618f86cmr4751086ywl.1.1681511174586; Fri, 14 Apr
 2023 15:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230414175444.1837474-1-surenb@google.com> <ZDnJ1dOU2tpK6l68@x1n>
 <CAJuCfpFc2SohkkJnEFqZD-uCpSS9sUzToPcQXOR6dHTTE0Ty5w@mail.gmail.com>
In-Reply-To: <CAJuCfpFc2SohkkJnEFqZD-uCpSS9sUzToPcQXOR6dHTTE0Ty5w@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 15:26:03 -0700
Message-ID: <CAJuCfpFq0N2BZi5tQRacw2+SSaxwyfLXsPGLMXDyuBt3cqffxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: do not increment pgfault stats when page fault
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

On Fri, Apr 14, 2023 at 3:14=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Apr 14, 2023 at 2:47=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > Hi, Suren,
>
> Hi Peter,
>
> >
> > On Fri, Apr 14, 2023 at 10:54:44AM -0700, Suren Baghdasaryan wrote:
> > > If the page fault handler requests a retry, we will count the fault
> > > multiple times.  This is a relatively harmless problem as the retry p=
aths
> > > are not often requested, and the only user-visible problem is that th=
e
> > > fault counter will be slightly higher than it should be.  Nevertheles=
s,
> > > userspace only took one fault, and should not see the fact that the
> > > kernel had to retry the fault multiple times.
> > >
> > > Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking ope=
rations")
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > > Patch applies cleanly over linux-next and mm-unstable
> > >
> > >  mm/memory.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 1c5b231fe6e3..d88f370eacd1 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5212,17 +5212,16 @@ vm_fault_t handle_mm_fault(struct vm_area_str=
uct *vma, unsigned long address,
> > >
> > >       __set_current_state(TASK_RUNNING);
> > >
> > > -     count_vm_event(PGFAULT);
> > > -     count_memcg_event_mm(vma->vm_mm, PGFAULT);
> > > -
> > >       ret =3D sanitize_fault_flags(vma, &flags);
> > >       if (ret)
> > > -             return ret;
> > > +             goto out;
> > >
> > >       if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> > >                                           flags & FAULT_FLAG_INSTRUCT=
ION,
> > > -                                         flags & FAULT_FLAG_REMOTE))
> > > -             return VM_FAULT_SIGSEGV;
> > > +                                         flags & FAULT_FLAG_REMOTE))=
 {
> > > +             ret =3D VM_FAULT_SIGSEGV;
> > > +             goto out;
> > > +     }
> > >
> > >       /*
> > >        * Enable the memcg OOM handling for faults triggered in user
> > > @@ -5253,6 +5252,11 @@ vm_fault_t handle_mm_fault(struct vm_area_stru=
ct *vma, unsigned long address,
> > >       }
> > >
> > >       mm_account_fault(regs, address, flags, ret);
> >
> > Here is the mm_account_fault() function taking care of some other
> > accountings.  Perhaps good to put things into it?
>
> That seems appropriate. Let me take a closer look.
>
> >
> > It also already ignores invalid faults:
> >
> >         if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> >                 return;
>
> Can there be a case of (!VM_FAULT_ERROR && VM_FAULT_RETRY) - basically
> we need to retry but no errors happened? If so then this condition
> would double-count pagefaults in such cases. If such return code is
> impossible then it's the same as checking for VM_FAULT_RETRY.
>
> >
> > I see that you may also want to account for sigbus, however I really do=
n't
> > know why.  Explanations would be great when it would matter.  So far it
> > makes sense to me if we skip both RETRY or ERROR cases.
>
> Accounting in case of a sigbus is not affected by this patch I think.
> We account for sigbus or any other error cases because there was a
> pagefault and we need to account for it. Whether we failed to handle
> it or not should not affect the count. We skip the retry case because
> we know the same fault will be retried. If we don't skip then we will
> double-count this fault.

mm_account_fault() has a nice comment explaining why it skips errors
and that now makes sense to me. Let me move the accounting there and
see if others agree that's the right place.

>
> >
> > > +out:
> > > +     if (!(ret & VM_FAULT_RETRY)) {
> > > +             count_vm_event(PGFAULT);
> > > +             count_memcg_event_mm(vma->vm_mm, PGFAULT);
> >
> > There is one thing worth noticing is here vma may or may not be valid
> > depending on the retval of the fault.
> >
> > RETRY is exactly one of the cases that accessing vma may be unsafe due =
to
> > releasing of mmap read lock.  The other one is the recently added
> > VM_FAULT_COMPLETE.  So if we want to move this chunk (or any vma refere=
nce)
> > to be later we need to consider a valid vma / mm being there first, or
> > we're prone to accessing a vma that has already been released, I think.
>
> Good catch! I think you are right and I should have stored vma->vm_mm
> in the beginning and used it when calling count_memcg_event_mm().
> I'll prepare a new patch which handles this correctly.
> Thanks,
> Suren.
>
> >
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.40.0.634.g4ca3ef3211-goog
> > >
> > >
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
