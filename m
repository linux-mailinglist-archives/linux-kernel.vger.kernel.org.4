Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64266D29A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjAPXJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjAPXJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:02 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB229E1F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:00 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id a9so15273513ybb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CCmcgNVg+h1QPPdn7LnXBY1iAHC/zKU20AQ2NLQkiFA=;
        b=E5v9Zy7zWLUAijIhoGuGY4A7Xz+Skyg7ATIc7CA2K5y4gPwwEHP3JyJi9u8cJNM6zQ
         ABidkAs9IsO2IctTC62zMYzOvSCSpVcI3+ZCRk6sEZ820fBC5i1bh7W2sSwApNH5iUzJ
         2+T/SDFJTtm4RinEZEfFdXlU0vXW9g0/ctzKRkOm56VyO8C/eQrXFv6rxV36A196aq48
         bJQiAJLN19gsaoiFYIrVUKjyiTzWHzA6mN5YfCzSYnCS9ut/YFoZm1nqvNpbeowyr5lO
         PXsSS/eonuyF1qDGfe3g11a70vBcslP59ZXN3BINJauHaWN5hJEmrr2Nn2viPs9lmFN4
         POHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCmcgNVg+h1QPPdn7LnXBY1iAHC/zKU20AQ2NLQkiFA=;
        b=DngGwLvaORDaOhti6g6jzIXtSoTUpta81jOJcD1/kxUdNDk9G4jOg7IEl08xgI9as3
         yLgIDB7dvn9Tx4RlqU+YA1LaSo2ymnlE6kfwi7A/j4yIhIp1x4LOEn9XbPSHSt/vpxIK
         y7FjyCCzJTPbT6HHAPfK0wJmXQPKp8RkmUGGQMHg0Zdc5Txo1sqSvc3Hrmz24ZFjLjzy
         irDmHauNNGKhkXYsMSDzJxjM2yclbd92g2hBEavScqWH8XpKCTLcLCdB/VwCZAre2q7S
         SMUQtFgoBMRNOuXjbLCnZtU4Wz7jDDDjCBPkyp8y+1ncMv1lV6gNocdJqCIK2MsfVRwU
         EuEQ==
X-Gm-Message-State: AFqh2kri19zJBeogugi3W9uWF7cb8EdqxggeUQ109QW0GkbzmTw/abkg
        pg88lp1TF0lWU9BzyJwcAU5cqmBompj2QjKCJMrtog==
X-Google-Smtp-Source: AMrXdXuC83KCNmLbi9dxB0b39+OgMITEOwaUjUEh+a4kfZnL/EJltO0eVDwXIinTp2Ug+3vGt1V8Z9C8FT7VNVA2HUM=
X-Received: by 2002:a05:6902:11cd:b0:7d6:c4f6:b4ea with SMTP id
 n13-20020a05690211cd00b007d6c4f6b4eamr139498ybu.59.1673910539752; Mon, 16 Jan
 2023 15:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-42-surenb@google.com> <20230116140649.2012-1-hdanton@sina.com>
In-Reply-To: <20230116140649.2012-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 Jan 2023 15:08:48 -0800
Message-ID: <CAJuCfpHoHcZxQZgt4Ki1kiBu9O+sANZQambOa+1gSQu2brPoyA@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Hillf Danton <hdanton@sina.com>
Cc:     vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        peterz@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Mon, Jan 16, 2023 at 6:07 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 9 Jan 2023 12:53:36 -0800 Suren Baghdasaryan <surenb@google.com>
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -627,12 +627,16 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> >        * mm->mm_lock_seq can't be concurrently modified.
> >        */
> >       mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> > -     if (vma->vm_lock_seq == mm_lock_seq)
> > +     if (vma->vm_lock->lock_seq == mm_lock_seq)
> >               return;
>
>         lock acquire for write to info lockdep.

Thanks for the review Hillf!

Good idea. Will add in the next version.

> >
> > -     down_write(&vma->vm_lock->lock);
> > -     vma->vm_lock_seq = mm_lock_seq;
> > -     up_write(&vma->vm_lock->lock);
> > +     if (atomic_cmpxchg(&vma->vm_lock->count, 0, -1))
> > +             wait_event(vma->vm_mm->vma_writer_wait,
> > +                        atomic_cmpxchg(&vma->vm_lock->count, 0, -1) == 0);
> > +     vma->vm_lock->lock_seq = mm_lock_seq;
> > +     /* Write barrier to ensure lock_seq change is visible before count */
> > +     smp_wmb();
> > +     atomic_set(&vma->vm_lock->count, 0);
> >  }
> >
> >  /*
> > @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> >  {
> >       /* Check before locking. A race might cause false locked result. */
> > -     if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > +     if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> >               return false;
>
> Add mb to pair with the above wmb like

The wmb above is to ensure the ordering between updates of lock_seq
and vm_lock->count (lock_seq is updated first and vm_lock->count only
after that). The first access to vm_lock->count in this function is
atomic_inc_unless_negative() and it's an atomic RMW operation with a
return value. According to documentation such functions are fully
ordered, therefore I think we already have an implicit full memory
barrier between reads of lock_seq and vm_lock->count here. Am I wrong?

>
>         if (READ_ONCE(vma->vm_lock->lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq)) {
>                 smp_acquire__after_ctrl_dep();
>                 return false;
>         }
> >
> > -     if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> > +     if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
> >               return false;
> >
> > +     /* If atomic_t overflows, restore and fail to lock. */
> > +     if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> > +             if (atomic_dec_and_test(&vma->vm_lock->count))
> > +                     wake_up(&vma->vm_mm->vma_writer_wait);
> > +             return false;
> > +     }
> > +
> >       /*
> >        * Overflow might produce false locked result.
> >        * False unlocked result is impossible because we modify and check
> >        * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
> >        * modification invalidates all existing locks.
> >        */
> > -     if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > -             up_read(&vma->vm_lock->lock);
> > +     if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > +             if (atomic_dec_and_test(&vma->vm_lock->count))
> > +                     wake_up(&vma->vm_mm->vma_writer_wait);
> >               return false;
> >       }
>
> Simpler way to detect write lock owner and count overflow like
>
>         int count = atomic_read(&vma->vm_lock->count);
>         for (;;) {
>                 int new = count + 1;
>
>                 if (count < 0 || new < 0)
>                         return false;
>
>                 new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
>                 if (new == count)
>                         break;
>                 count = new;
>                 cpu_relax();
>         }
>
>         (wake up waiting readers after taking the lock;
>         but the write lock owner before this read trylock should be
>         responsible for waking waiters up.)
>
>         lock acquire for read.

This schema might cause readers to wait, which is not an exact
replacement for down_read_trylock(). The requirement to wake up
waiting readers also complicates things and since we can always fall
back to mmap_lock, that complication is unnecessary IMHO. I could use
part of your suggestion like this:

                 int new = count + 1;

                 if (count < 0 || new < 0)
                         return false;

                 new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
                 if (new == count)
                         return false;

Compared to doing atomic_inc_unless_negative() first, like I did
originally, this schema opens a bit wider window for the writer to get
in the middle and cause the reader to fail locking but I don't think
it would result in any visible regression.

>
> >       return true;
> > @@ -664,7 +676,8 @@ static inline bool vma_read_trylock(struct vm_area_struct *vma)
> >
> >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> >  {
>         lock release for read.

Ack.

>
> > -     up_read(&vma->vm_lock->lock);
> > +     if (atomic_dec_and_test(&vma->vm_lock->count))
> > +             wake_up(&vma->vm_mm->vma_writer_wait);
> >  }
>
