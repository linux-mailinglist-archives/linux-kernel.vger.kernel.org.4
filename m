Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8B5B3C94
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiIIQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiIIQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:02:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9B11C169
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:02:13 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id b136so3360678yba.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=DQbTmUrdrgDTvMmvyU9EuQQznosHCNDpYSf+XCcrSrw=;
        b=ZGrlqpty6dTHcA0AGjeGbNjw2MRTqt5szBBhpVQ4dkAsz27E+xJBinSUjpum6sOJ74
         KUZIDyDTlEwKWlVEOqzVoPwsgYo6xRs2omL0jr9x673C7t9bWdmM231kaPxOkEpsERNk
         sUlQeM1/QWZrA4nzRANgMA3UJkLeBZnQOHmgqtekadzWeed3VlEw+rQY6cYq9FkJGlyk
         eS/uEeop/qmLnkiU9Ys8shAx2VjqIgYTIQI6dvC+LcponoNKz/e7KU3mEKjps86U/s0V
         EW2m8zRsZ3OQ1M1GTcpCTPJF6NkaKVoEl9GprcuZylB1npUnqKSwkuU5ir52s1OYBMdH
         XORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DQbTmUrdrgDTvMmvyU9EuQQznosHCNDpYSf+XCcrSrw=;
        b=RNMV2CvA5GJRhSFMRvwuiC5BqgBMh+rs3rG7eBsRfegY8ocG5NMyXcnw6p4135ebIg
         /CXxwv/H3d2Z8ecw17+OZ4lGNku8doQoMO7+lIA/BseZfYD60nu52RFJtbr4jqDaz9k6
         iWplxD/3gi25wVy9yPHLqs8mvIUdox3TFhDqXX7OY9dEU1vpdeizywEBnPTyiomzOsuP
         LNxVTaJq0rfbv2ZGbOSAxyoqaleGjwr/v88rX7cWaUU9ODY4uDFipdfU6WAhcOthrp6C
         BOo6zZ0JpvF+5Y+KTEhjE6phi8o8z3xmRDWxxrnfTsljzKJ6sVgTxGBjg46Jveuha3Ab
         6SPQ==
X-Gm-Message-State: ACgBeo39GzIMRlDk5wNefXNmafitwX3hQ7sNcSOPFgg0tAY7+p/2F6fV
        DudxxJxkAi9OMZ3Wde/T2nukzlOiakU2cfHqmWO3mg==
X-Google-Smtp-Source: AA6agR5Nq64ZM2y3FbQ4HLpbzNHvKJZ/Snb2eh+Dl0Jr1a7cLwUO5zAkkKuGlWLxpWXb/VD567UKIjM3qf4+35Bz7gg=
X-Received: by 2002:a25:cc8d:0:b0:6a8:40cb:d730 with SMTP id
 l135-20020a25cc8d000000b006a840cbd730mr12446545ybf.119.1662739332705; Fri, 09
 Sep 2022 09:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-29-surenb@google.com>
 <34dd5656-dc3c-6a20-5390-04d05c619fdc@linux.ibm.com>
In-Reply-To: <34dd5656-dc3c-6a20-5390-04d05c619fdc@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:02:01 -0700
Message-ID: <CAJuCfpGn=Xhc3SnrK2ei1WPoFPaW00xZkS9MebN9Zxfv9joPoA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 28/28] kernel/fork: throttle call_rcu() calls
 in vm_area_free
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 9, 2022 at 8:19 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > call_rcu() can take a long time when callback offloading is enabled.
> > Its use in the vm_area_free can cause regressions in the exit path when
> > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > a list and free them in groups using one call_rcu() call per group.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h       |  1 +
> >  include/linux/mm_types.h | 11 ++++++-
> >  kernel/fork.c            | 68 +++++++++++++++++++++++++++++++++++-----
> >  mm/init-mm.c             |  3 ++
> >  mm/mmap.c                |  1 +
> >  5 files changed, 75 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a3cbaa7b9119..81dff694ac14 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -249,6 +249,7 @@ void setup_initial_init_mm(void *start_code, void *=
end_code,
> >  struct vm_area_struct *vm_area_alloc(struct mm_struct *);
> >  struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
> >  void vm_area_free(struct vm_area_struct *);
> > +void drain_free_vmas(struct mm_struct *mm);
> >
> >  #ifndef CONFIG_MMU
> >  extern struct rb_root nommu_region_tree;
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 36562e702baf..6f3effc493b1 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -412,7 +412,11 @@ struct vm_area_struct {
> >                       struct vm_area_struct *vm_next, *vm_prev;
> >               };
> >  #ifdef CONFIG_PER_VMA_LOCK
> > -             struct rcu_head vm_rcu; /* Used for deferred freeing. */
> > +             struct {
> > +                     struct list_head vm_free_list;
> > +                     /* Used for deferred freeing. */
> > +                     struct rcu_head vm_rcu;
> > +             };
> >  #endif
> >       };
> >
> > @@ -573,6 +577,11 @@ struct mm_struct {
> >                                         */
> >  #ifdef CONFIG_PER_VMA_LOCK
> >               int mm_lock_seq;
> > +             struct {
> > +                     struct list_head head;
> > +                     spinlock_t lock;
> > +                     int size;
> > +             } vma_free_list;
> >  #endif
> >
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b443ba3a247a..7c88710aed72 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -483,26 +483,75 @@ struct vm_area_struct *vm_area_dup(struct vm_area=
_struct *orig)
> >  }
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> > -static void __vm_area_free(struct rcu_head *head)
> > +static inline void __vm_area_free(struct vm_area_struct *vma)
> >  {
> > -     struct vm_area_struct *vma =3D container_of(head, struct vm_area_=
struct,
> > -                                               vm_rcu);
> >       /* The vma should either have no lock holders or be write-locked.=
 */
> >       vma_assert_no_reader(vma);
> >       kmem_cache_free(vm_area_cachep, vma);
> >  }
> > -#endif
> > +
> > +static void vma_free_rcu_callback(struct rcu_head *head)
> > +{
> > +     struct vm_area_struct *first_vma;
> > +     struct vm_area_struct *vma, *vma2;
> > +
> > +     first_vma =3D container_of(head, struct vm_area_struct, vm_rcu);
> > +     list_for_each_entry_safe(vma, vma2, &first_vma->vm_free_list, vm_=
free_list)
>
> Is that safe to walk the list against concurrent calls to
> list_splice_init(), or list_add()?

I think it is. drain_free_vmas() moves the to-be-destroyed and already
isolated VMAs from mm->vma_free_list into to_destroy list and then
passes that list to vma_free_rcu_callback(). At this point the list of
VMAs passed to vma_free_rcu_callback() is not accessible either from
mm (VMAs were isolated before vm_area_free() was called) or from
drain_free_vmas() since they were already removed from
mm->vma_free_list. Does that make sense?

>
> > +             __vm_area_free(vma);
> > +     __vm_area_free(first_vma);
> > +}
> > +
> > +void drain_free_vmas(struct mm_struct *mm)
> > +{
> > +     struct vm_area_struct *first_vma;
> > +     LIST_HEAD(to_destroy);
> > +
> > +     spin_lock(&mm->vma_free_list.lock);
> > +     list_splice_init(&mm->vma_free_list.head, &to_destroy);
> > +     mm->vma_free_list.size =3D 0;
> > +     spin_unlock(&mm->vma_free_list.lock);
> > +
> > +     if (list_empty(&to_destroy))
> > +             return;
> > +
> > +     first_vma =3D list_first_entry(&to_destroy, struct vm_area_struct=
, vm_free_list);
> > +     /* Remove the head which is allocated on the stack */
> > +     list_del(&to_destroy);
> > +
> > +     call_rcu(&first_vma->vm_rcu, vma_free_rcu_callback);
> > +}
> > +
> > +#define VM_AREA_FREE_LIST_MAX        32
> > +
> > +void vm_area_free(struct vm_area_struct *vma)
> > +{
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     bool drain;
> > +
> > +     free_anon_vma_name(vma);
> > +
> > +     spin_lock(&mm->vma_free_list.lock);
> > +     list_add(&vma->vm_free_list, &mm->vma_free_list.head);
> > +     mm->vma_free_list.size++;
> > +     drain =3D mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
> > +     spin_unlock(&mm->vma_free_list.lock);
> > +
> > +     if (drain)
> > +             drain_free_vmas(mm);
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> > +
> > +void drain_free_vmas(struct mm_struct *mm) {}
> >
> >  void vm_area_free(struct vm_area_struct *vma)
> >  {
> >       free_anon_vma_name(vma);
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -     call_rcu(&vma->vm_rcu, __vm_area_free);
> > -#else
> >       kmem_cache_free(vm_area_cachep, vma);
> > -#endif
> >  }
> >
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >  static void account_kernel_stack(struct task_struct *tsk, int account)
> >  {
> >       if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> > @@ -1137,6 +1186,9 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >       INIT_LIST_HEAD(&mm->mmlist);
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       WRITE_ONCE(mm->mm_lock_seq, 0);
> > +     INIT_LIST_HEAD(&mm->vma_free_list.head);
> > +     spin_lock_init(&mm->vma_free_list.lock);
> > +     mm->vma_free_list.size =3D 0;
> >  #endif
> >       mm_pgtables_bytes_init(mm);
> >       mm->map_count =3D 0;
> > diff --git a/mm/init-mm.c b/mm/init-mm.c
> > index 8399f90d631c..7b6d2460545f 100644
> > --- a/mm/init-mm.c
> > +++ b/mm/init-mm.c
> > @@ -39,6 +39,9 @@ struct mm_struct init_mm =3D {
> >       .mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       .mm_lock_seq    =3D 0,
> > +     .vma_free_list.head =3D LIST_HEAD_INIT(init_mm.vma_free_list.head=
),
> > +     .vma_free_list.lock =3D  __SPIN_LOCK_UNLOCKED(init_mm.vma_free_li=
st.lock),
> > +     .vma_free_list.size =3D 0,
> >  #endif
> >       .user_ns        =3D &init_user_ns,
> >       .cpu_bitmap     =3D CPU_BITS_NONE,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 1edfcd384f5e..d61b7ef84ba6 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3149,6 +3149,7 @@ void exit_mmap(struct mm_struct *mm)
> >       }
> >       mm->mmap =3D NULL;
> >       mmap_write_unlock(mm);
> > +     drain_free_vmas(mm);
> >       vm_unacct_memory(nr_accounted);
> >  }
> >
>
