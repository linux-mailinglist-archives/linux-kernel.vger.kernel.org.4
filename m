Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8003670D29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAQXUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjAQXUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:20:14 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497D8F7FE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:08:44 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4d4303c9de6so290187417b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urcfogXP8/5QcG3eqI+/efCdOfk/1SNX6adzw2Z8FeQ=;
        b=OUKgX7cEG3o2z5mUFzRkTB+81zNGAOtat3KbodR8544SGcTYvYmZErRrA0aSlTNdRA
         gfxEORf6ArfGuhMgJsDq42P4OIj6RSJIqR6GKkcih2eaVq9SGefH1f25NpuV+To6eU6q
         c5HMDU6MJqWdvnMSrFqizfGY+8TnzOeJB4+F6DBGOggu8TCIlRULLttzSmyH7uMbqj2u
         ssf2CbHggwypr/5Iehem8hsWpkh9FQtUaAyeqSxTIyxLgOcJlcb+WnpphcbFsXWmp+YZ
         PuOo3ta9aQEoUxNcIFxLRUl+6XhGJw+fk5paIBHJstlKZzOKv0h0CFitP29+Y4lL7ikx
         rwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urcfogXP8/5QcG3eqI+/efCdOfk/1SNX6adzw2Z8FeQ=;
        b=YtWNKugNJEPh01gEnTklOpfS0Qq6q1HcOViQrGgeuJU/C9cjRoRPm2MMxHUdb7U6IW
         AWbiAghXjNPmbcM91CmHAm2uKc5fQBMw+H9C8TzNPwgkUs5GTj8V5z0peKdnNN1qIREp
         TlqNDq8+jahug4TmrIUfoVWHyzrC7W602k9bHT6eua6PEE5qRyILHldzMiBTqgURjP0m
         fzrBQwce3/lXqQwD6dbDEOg8VBIqX75QndlmFYIqrUzjtUJJUc4BoGZnNC2tOnmGaYad
         K539/lrE0s3wF4FtOp/hMtB1sGi3XgxKAqMPQRG+8A0vjyEmAWRyC5NoSU/4MV7pcYGK
         D5DQ==
X-Gm-Message-State: AFqh2kqGjY4G1YAzJsKjsndkYqNrY2n1ys99SW+0jXox5emsWtwQiR14
        SP/RJ4aPJLZB7Nyslokfl8/x32lafqAXDWT2nk9b4w==
X-Google-Smtp-Source: AMrXdXuirSR0jy63s0DZ+9m/b/wvxTwEF1sI4YVVCYw6Ow14874/Gci5gJMHPrHKDnQjh50N83G8r2p25UXnJQG51P4=
X-Received: by 2002:a0d:fc05:0:b0:3ea:454d:d1ef with SMTP id
 m5-20020a0dfc05000000b003ea454dd1efmr603849ywf.409.1673989722997; Tue, 17 Jan
 2023 13:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz>
In-Reply-To: <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 13:08:30 -0800
Message-ID: <CAJuCfpH4kxx2HkDRD4eFZF+vEujRvS2oa0RVj2Uix0vkrRL-Bg@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Tue, Jan 17, 2023 at 7:04 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:07, Suren Baghdasaryan wrote:
> > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > instead of mmap_lock. Because there are cases when multiple VMAs need
> > to be exclusively locked during VMA tree modifications, instead of the
> > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > locked.
>
> I have to say I was struggling a bit with the above and only understood
> what you mean by reading the patch several times. I would phrase it like
> this (feel free to use if you consider this to be an improvement).
>
> Introduce a per-VMA rw_semaphore. The lock implementation relies on a
> per-vma and per-mm sequence counters to note exclusive locking:
>         - read lock - (implemented by vma_read_trylock) requires the the
>           vma (vm_lock_seq) and mm (mm_lock_seq) sequence counters to
>           differ. If they match then there must be a vma exclusive lock
>           held somewhere.
>         - read unlock - (implemented by vma_read_unlock) is a trivial
>           vma->lock unlock.
>         - write lock - (vma_write_lock) requires the mmap_lock to be
>           held exclusively and the current mm counter is noted to the vma
>           side. This will allow multiple vmas to be locked under a single
>           mmap_lock write lock (e.g. during vma merging). The vma counter
>           is modified under exclusive vma lock.
>         - write unlock - (vma_write_unlock_mm) is a batch release of all
>           vma locks held. It doesn't pair with a specific
>           vma_write_lock! It is done before exclusive mmap_lock is
>           released by incrementing mm sequence counter (mm_lock_seq).
>         - write downgrade - if the mmap_lock is downgraded to the read
>           lock all vma write locks are released as well (effectivelly
>           same as write unlock).

Thanks for the suggestion, Michal. I'll definitely reuse your description.

>
> > VMA lock is placed on the cache line boundary so that its 'count' field
> > falls into the first cache line while the rest of the fields fall into
> > the second cache line. This lets the 'count' field to be cached with
> > other frequently accessed fields and used quickly in uncontended case
> > while 'owner' and other fields used in the contended case will not
> > invalidate the first cache line while waiting on the lock.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h        | 80 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/mm_types.h  |  8 ++++
> >  include/linux/mmap_lock.h | 13 +++++++
> >  kernel/fork.c             |  4 ++
> >  mm/init-mm.c              |  3 ++
> >  5 files changed, 108 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f3f196e4d66d..ec2c4c227d51 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -612,6 +612,85 @@ struct vm_operations_struct {
> >                                         unsigned long addr);
> >  };
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static inline void vma_init_lock(struct vm_area_struct *vma)
> > +{
> > +     init_rwsem(&vma->lock);
> > +     vma->vm_lock_seq = -1;
> > +}
> > +
> > +static inline void vma_write_lock(struct vm_area_struct *vma)
> > +{
> > +     int mm_lock_seq;
> > +
> > +     mmap_assert_write_locked(vma->vm_mm);
> > +
> > +     /*
> > +      * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> > +      * mm->mm_lock_seq can't be concurrently modified.
> > +      */
> > +     mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> > +     if (vma->vm_lock_seq == mm_lock_seq)
> > +             return;
> > +
> > +     down_write(&vma->lock);
> > +     vma->vm_lock_seq = mm_lock_seq;
> > +     up_write(&vma->lock);
> > +}
> > +
> > +/*
> > + * Try to read-lock a vma. The function is allowed to occasionally yield false
> > + * locked result to avoid performance overhead, in which case we fall back to
> > + * using mmap_lock. The function should never yield false unlocked result.
> > + */
> > +static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > +{
> > +     /* Check before locking. A race might cause false locked result. */
> > +     if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > +             return false;
> > +
> > +     if (unlikely(down_read_trylock(&vma->lock) == 0))
> > +             return false;
> > +
> > +     /*
> > +      * Overflow might produce false locked result.
> > +      * False unlocked result is impossible because we modify and check
> > +      * vma->vm_lock_seq under vma->lock protection and mm->mm_lock_seq
> > +      * modification invalidates all existing locks.
> > +      */
> > +     if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > +             up_read(&vma->lock);
> > +             return false;
> > +     }
> > +     return true;
> > +}
> > +
> > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > +{
> > +     up_read(&vma->lock);
> > +}
> > +
> > +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > +{
> > +     mmap_assert_write_locked(vma->vm_mm);
> > +     /*
> > +      * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> > +      * mm->mm_lock_seq can't be concurrently modified.
> > +      */
> > +     VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> > +
> > +static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > +static inline void vma_write_lock(struct vm_area_struct *vma) {}
> > +static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > +             { return false; }
> > +static inline void vma_read_unlock(struct vm_area_struct *vma) {}
> > +static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
> > +
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> >  {
> >       static const struct vm_operations_struct dummy_vm_ops = {};
> > @@ -620,6 +699,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> >       vma->vm_mm = mm;
> >       vma->vm_ops = &dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > +     vma_init_lock(vma);
> >  }
> >
> >  static inline void vma_set_anonymous(struct vm_area_struct *vma)
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index d5cdec1314fe..5f7c5ca89931 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -555,6 +555,11 @@ struct vm_area_struct {
> >       pgprot_t vm_page_prot;
> >       unsigned long vm_flags;         /* Flags, see mm.h. */
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     int vm_lock_seq;
> > +     struct rw_semaphore lock;
> > +#endif
> > +
> >       /*
> >        * For areas with an address space and backing store,
> >        * linkage into the address_space->i_mmap interval tree.
> > @@ -680,6 +685,9 @@ struct mm_struct {
> >                                         * init_mm.mmlist, and are protected
> >                                         * by mmlist_lock
> >                                         */
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +             int mm_lock_seq;
> > +#endif
> >
> >
> >               unsigned long hiwater_rss; /* High-watermark of RSS usage */
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index e49ba91bb1f0..40facd4c398b 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -72,6 +72,17 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
> >       VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >  }
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static inline void vma_write_unlock_mm(struct mm_struct *mm)
> > +{
> > +     mmap_assert_write_locked(mm);
> > +     /* No races during update due to exclusive mmap_lock being held */
> > +     WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +}
> > +#else
> > +static inline void vma_write_unlock_mm(struct mm_struct *mm) {}
> > +#endif
> > +
> >  static inline void mmap_init_lock(struct mm_struct *mm)
> >  {
> >       init_rwsem(&mm->mmap_lock);
> > @@ -114,12 +125,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
> >  static inline void mmap_write_unlock(struct mm_struct *mm)
> >  {
> >       __mmap_lock_trace_released(mm, true);
> > +     vma_write_unlock_mm(mm);
> >       up_write(&mm->mmap_lock);
> >  }
> >
> >  static inline void mmap_write_downgrade(struct mm_struct *mm)
> >  {
> >       __mmap_lock_trace_acquire_returned(mm, false, true);
> > +     vma_write_unlock_mm(mm);
> >       downgrade_write(&mm->mmap_lock);
> >  }
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 5986817f393c..c026d75108b3 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> >                */
> >               *new = data_race(*orig);
> >               INIT_LIST_HEAD(&new->anon_vma_chain);
> > +             vma_init_lock(new);
> >               dup_anon_vma_name(orig, new);
> >       }
> >       return new;
> > @@ -1145,6 +1146,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
> >       seqcount_init(&mm->write_protect_seq);
> >       mmap_init_lock(mm);
> >       INIT_LIST_HEAD(&mm->mmlist);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     WRITE_ONCE(mm->mm_lock_seq, 0);
> > +#endif
> >       mm_pgtables_bytes_init(mm);
> >       mm->map_count = 0;
> >       mm->locked_vm = 0;
> > diff --git a/mm/init-mm.c b/mm/init-mm.c
> > index c9327abb771c..33269314e060 100644
> > --- a/mm/init-mm.c
> > +++ b/mm/init-mm.c
> > @@ -37,6 +37,9 @@ struct mm_struct init_mm = {
> >       .page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
> >       .arg_lock       =  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
> >       .mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     .mm_lock_seq    = 0,
> > +#endif
> >       .user_ns        = &init_user_ns,
> >       .cpu_bitmap     = CPU_BITS_NONE,
> >  #ifdef CONFIG_IOMMU_SVA
> > --
> > 2.39.0
>
> --
> Michal Hocko
> SUSE Labs
