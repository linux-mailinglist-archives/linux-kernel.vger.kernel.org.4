Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61AD6A1146
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBWUec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBWUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:34:30 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9EE1EBCF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:34:25 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536c2a1cc07so212034937b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5E7QcOom432WfEB2tmrrxUq3oMwXLGBGrJE5okH/nk=;
        b=Bjdh4smkRYXHxyJxf+ZPmX1mSDOmm08FE7XfZXgXnwbjIj0Tr92u5+3ShwG8tiACzc
         Pof9mljBUaqOQTUVIM1dPEXeIO1n+vfqVjaajcfSb8uDjDpKkcLttKpyU2C/2S7lm+mf
         q42lTgGSPo9zGGLJRWqST8W0nNri4Cxbg2MLkL5MQ6ukmU00c89ISaqbm900QLcuYhEk
         e1er6rludgb8W/NHr6xfiascVRAJzEMxgbqRxRdgHwX2szDjjBMtfu1HahnMjBS55yLo
         r4VLNPUnUIUZes9CuFCJgSxvTSuqgxT8D/GUbu3fifQqAgmc+BacynLKLTXkq8fdqCqW
         2X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5E7QcOom432WfEB2tmrrxUq3oMwXLGBGrJE5okH/nk=;
        b=mJ/Tw8sNFcNOtg9lhFnHy/4AcKiyADnTT29e0CNFc05pAyRNwlkg8UGoj42FOgCoCj
         H45Bkqk2AMNn86ch2yyGctLhqeSKtBT6wRjHFaom7KjAKr8oodHZs2CgSaD8/eNK3NNB
         ZaxkXa6qI9aPSO8+5+CMd9Pidd5sZxklN/Jsy8VL+XbPiYTA3AOPH5ub7Xwug/Shcqfq
         WnzFoq5dCV/OqSiuOo/z7G5BK/SsUx9XdD7N2BntXAYOzg8EEyPpgdVvsKoagC8MatBe
         HPsEirwPup1517FZPE3GLdkAoleiLDVTakd3yBtG1H09qH/jx+BtlsCtuiVKZuc05E1X
         WsFQ==
X-Gm-Message-State: AO0yUKURkGhIQF61+IZqOONguOMxIwGx9tplMzKjxm4CtKhGoJjWS3SE
        rPFM2uNgyWe5pj+I6WJ9KYMrF7Ga1IrIBO1/9nVVoA==
X-Google-Smtp-Source: AK7set9Te/5uWtt5zt1fQaHwXqFRJISgrOCqlFEddaHqmIZQDT7I+U9PTLYweByzGpk4rUIUZlowo03Z5xLHHDmLpLE=
X-Received: by 2002:a5b:b07:0:b0:9fe:1493:8b8 with SMTP id z7-20020a5b0b07000000b009fe149308b8mr2417322ybp.6.1677184464289;
 Thu, 23 Feb 2023 12:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-25-surenb@google.com>
 <20230223200800.5cydej7s2ybafuaf@revolver>
In-Reply-To: <20230223200800.5cydej7s2ybafuaf@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Feb 2023 12:34:13 -0800
Message-ID: <CAJuCfpFaDA6vW1MwbCSM8xoUoVMiERiLtTZd-u7Jc4qn0a-w0w@mail.gmail.com>
Subject: Re: [PATCH v3 24/35] mm: introduce vma detached flag
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
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

On Thu, Feb 23, 2023 at 12:08 PM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
>
> Can we change this to active/inactive?  I think there is potential for
> reusing this functionality to even larger degrees and that name would
> fit better and would still make sense in this context.
>
> ie: vma_mark_active() and vma_mark_inactive() ?

Those names sound too generic (not obvious what active/inactive
means), while detached/isolated I think is more clear and specific.
Does not really make a huge difference to me but maybe you can come up
with better naming that addresses my concern and meets your usecase?

>
> * Suren Baghdasaryan <surenb@google.com> [230216 00:18]:
> > Per-vma locking mechanism will search for VMA under RCU protection and
> > then after locking it, has to ensure it was not removed from the VMA
> > tree after we found it. To make this check efficient, introduce a
> > vma->detached flag to mark VMAs which were removed from the VMA tree.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h       | 11 +++++++++++
> >  include/linux/mm_types.h |  3 +++
> >  mm/mmap.c                |  2 ++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f4f702224ec5..3f98344f829c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -693,6 +693,14 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> >       VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> >  }
> >
> > +static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
> > +{
> > +     /* When detaching vma should be write-locked */
> > +     if (detached)
> > +             vma_assert_write_locked(vma);
> > +     vma->detached = detached;
> > +}
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > @@ -701,6 +709,8 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
> >  static inline void vma_end_read(struct vm_area_struct *vma) {}
> >  static inline void vma_start_write(struct vm_area_struct *vma) {}
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
> > +static inline void vma_mark_detached(struct vm_area_struct *vma,
> > +                                  bool detached) {}
> >
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> > @@ -712,6 +722,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> >       vma->vm_mm = mm;
> >       vma->vm_ops = &dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > +     vma_mark_detached(vma, false);
> >       vma_init_lock(vma);
> >  }
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index e268723eaf44..939f4f5a1115 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -511,6 +511,9 @@ struct vm_area_struct {
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       int vm_lock_seq;
> >       struct rw_semaphore lock;
> > +
> > +     /* Flag to indicate areas detached from the mm->mm_mt tree */
> > +     bool detached;
> >  #endif
> >
> >       /*
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 801608726be8..adf40177e68f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -593,6 +593,7 @@ static inline void vma_complete(struct vma_prepare *vp,
> >
> >       if (vp->remove) {
> >  again:
> > +             vma_mark_detached(vp->remove, true);
> >               if (vp->file) {
> >                       uprobe_munmap(vp->remove, vp->remove->vm_start,
> >                                     vp->remove->vm_end);
> > @@ -2267,6 +2268,7 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
> >       if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
> >               return -ENOMEM;
> >
> > +     vma_mark_detached(vma, true);
> >       if (vma->vm_flags & VM_LOCKED)
> >               vma->vm_mm->locked_vm -= vma_pages(vma);
> >
> > --
> > 2.39.1
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
