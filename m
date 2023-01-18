Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C2670FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjARBNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjARBNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:13:13 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935D03C2E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:07:09 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4e4a6af2d99so128450497b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+UzsDlXlC7t5BIJkt4S1C9pOgCAtRZ1rD2tVfs3+9vM=;
        b=HR7OBma7oNcSAgyQdahWkS/+GYEiMo2K7u7SH7XKaEtDUcUden1EUbI6LD9VVF7J1x
         W7lI2euLfggvfs2V0JWHWkHe3qxzN6ohS9ExKzTaJMGOQSZuOKR9RScixndA7s2QYaQ6
         HfUWv9VD3eHjySCGt6xoaLyVVtj2EEONzfERHlbh0iPGw2sCO/lcesCY2eTVPQRoMJb+
         gqR21sjs3J+x5zerViL5YkWvVAzNFkjnCi2vD95FzbGwg3CJYzMrtPoGRP4w9LZjSUIu
         gRLpF7+BYQnoKYJBu29968t+KMhHg8v34Cty12VpH/W2gIUx8Z32jLwQzC5wkSaXhVBr
         /4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UzsDlXlC7t5BIJkt4S1C9pOgCAtRZ1rD2tVfs3+9vM=;
        b=Ou/F4nyyDKsg+aL+NPV0Umxp5z2J2LRkP3hK/Kgj0G8FOXbdMlQkJHfIm6EGzp3BNt
         /COSP8zv8SogQGoScNIbEyPn550Me3sALBipcpdJ9+lAsyNB7U9lA/7uiPYRcZ2jnifa
         uxHSIFnUF1+wNYLxr1svNGLhVucX8+C2rBO3fs9uHu3xzwJaZPibBo3VtTaTsS2QYwv/
         f9MO75rB+3eK1gV+YLGowUUqegJ59u5rhmc824eiY6aR3uaJcBW5eMPbCgQ0i9dB7nQe
         xG0zc1r3Qs2cVoE4oSq7H8veX8Vpm3VtGDhRAtXHfHUt9yg0WqmUBq0unIRPTFDr9bW0
         sVXQ==
X-Gm-Message-State: AFqh2kp68jAdbI8TYt9DP0kjQ1x3pjo5uW+qal3dCZhbJFw6Xa2kAldV
        58YAZt/q5gA1C71L1+yywro5QzQJqxHDa1Gzzrg26g==
X-Google-Smtp-Source: AMrXdXt1di0oM/b6morQivkbcXm4Ky5z3zOnzmSbWPfTQh0c+LbBSHcKZuP95W8tXfA3+CxNeZNf17AZY9H5yMUDV7E=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr672398ywc.132.1674004028426; Tue, 17
 Jan 2023 17:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-29-surenb@google.com>
 <Y8bDAVC/aiL9tCyz@dhcp22.suse.cz>
In-Reply-To: <Y8bDAVC/aiL9tCyz@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 17:06:57 -0800
Message-ID: <CAJuCfpHRRsUMNHp2H3UiB4EZbe9CXTVcAC+oOR1dscENjp1Jbw@mail.gmail.com>
Subject: Re: [PATCH 28/41] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
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

On Tue, Jan 17, 2023 at 7:47 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:23, Suren Baghdasaryan wrote:
> > Introduce lock_vma_under_rcu function to lookup and lock a VMA during
> > page fault handling. When VMA is not found, can't be locked or changes
> > after being locked, the function returns NULL. The lookup is performed
> > under RCU protection to prevent the found VMA from being destroyed before
> > the VMA lock is acquired. VMA lock statistics are updated according to
> > the results.
> > For now only anonymous VMAs can be searched this way. In other cases the
> > function returns NULL.
>
> Could you describe why only anonymous vmas are handled at this stage and
> what (roughly) has to be done to support other vmas? lock_vma_under_rcu
> doesn't seem to have any anonymous vma specific requirements AFAICS.

TBH I haven't spent too much time looking into file-backed page faults
yet but a couple of tasks I can think of are:
- Ensure that all vma->vm_ops->fault() handlers do not rely on
mmap_lock being read-locked;
- vma->vm_file freeing like VMA freeing will need to be done after RCU
grace period since page fault handlers use it. This will require some
caution because simply adding it into __vm_area_free() called via
call_rcu()  will cause corresponding fops->release() to be called
asynchronously. I had to solve this issue with out-of-tree SPF
implementation when asynchronously called snd_pcm_release() was
problematic.

I'm sure I'm missing more potential issues and maybe Matthew and
Michel can pinpoint more things to resolve here?

>
> Also isn't lock_vma_under_rcu effectively find_read_lock_vma? Not that
> the naming is really the most important part but the rcu locking is
> internal to the function so why should we spread this implementation
> detail to the world...

I wanted the name to indicate that the lookup is done with no locks
held. But I'm open to suggestions.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h |  3 +++
> >  mm/memory.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c464fc8a514c..d0fddf6a1de9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -687,6 +687,9 @@ static inline void vma_assert_no_reader(struct vm_area_struct *vma)
> >                     vma);
> >  }
> >
> > +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > +                                       unsigned long address);
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 9ece18548db1..a658e26d965d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5242,6 +5242,57 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >  }
> >  EXPORT_SYMBOL_GPL(handle_mm_fault);
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +/*
> > + * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
> > + * stable and not isolated. If the VMA is not found or is being modified the
> > + * function returns NULL.
> > + */
> > +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > +                                       unsigned long address)
> > +{
> > +     MA_STATE(mas, &mm->mm_mt, address, address);
> > +     struct vm_area_struct *vma, *validate;
> > +
> > +     rcu_read_lock();
> > +     vma = mas_walk(&mas);
> > +retry:
> > +     if (!vma)
> > +             goto inval;
> > +
> > +     /* Only anonymous vmas are supported for now */
> > +     if (!vma_is_anonymous(vma))
> > +             goto inval;
> > +
> > +     if (!vma_read_trylock(vma))
> > +             goto inval;
> > +
> > +     /* Check since vm_start/vm_end might change before we lock the VMA */
> > +     if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
> > +             vma_read_unlock(vma);
> > +             goto inval;
> > +     }
> > +
> > +     /* Check if the VMA got isolated after we found it */
> > +     mas.index = address;
> > +     validate = mas_walk(&mas);
> > +     if (validate != vma) {
> > +             vma_read_unlock(vma);
> > +             count_vm_vma_lock_event(VMA_LOCK_MISS);
> > +             /* The area was replaced with another one. */
> > +             vma = validate;
> > +             goto retry;
> > +     }
> > +
> > +     rcu_read_unlock();
> > +     return vma;
> > +inval:
> > +     rcu_read_unlock();
> > +     count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > +     return NULL;
> > +}
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >  #ifndef __PAGETABLE_P4D_FOLDED
> >  /*
> >   * Allocate p4d page table.
> > --
> > 2.39.0
>
> --
> Michal Hocko
> SUSE Labs
