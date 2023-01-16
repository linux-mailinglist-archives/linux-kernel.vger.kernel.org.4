Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B587B66D1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjAPWg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAPWgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:36:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653C17CF1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:36:24 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 20so12811641ybl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8x0ax+CrpRdZ474UKgbbkMQWa7fnkqGkNbkY5YDvYN8=;
        b=IRTe23cB9H6aTVRzS1VkJBbWS3kWAKwm81ESOnh/qvhUb91AYaNRSUNI0S8RUGxEZ3
         h4S6eATYVs38FAo2PWtdhGYY4OfXPvM9N4v6Wb5k6QuoWadoD/eIFLn/skx21/ok2jhv
         SXuEvjJrgFW4RQktr6Ez2nYap+wI5Q5Gr6EcfObHYt0vJs8pEbXEDearImg0E0rzVBAR
         fjgi4ZzPiPVYLGqkgpdYEU2e530Z0oGeGhXnTFK9GhkK5BpGt4kpwDZtWwalj2LQp3s2
         5PC/suWXHjKBxFS9/UvFQjQYa+Pxmg7aD9vbI2IK0nKaNteQTKuPNqnJjAUfXI7dQFcC
         426w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8x0ax+CrpRdZ474UKgbbkMQWa7fnkqGkNbkY5YDvYN8=;
        b=jk5cfrIx1wNRiMDvBfksafMVLM8+REEkyKG51Q8IlVu2cR2HUUy30iV/fwVlL5csRB
         5uDQUMuAQtwTJK730fffyzkzdac+nWTmG5g7v88wkYjukkNweUCFCVh9+j1GJkHjBbU2
         0fAyoLbFSSv601Ib96V5qufqd70JQKzzcXoThIu5LWQl5Q9cxg2cu2U6A4CZ8rm4Aehv
         G/EGba3dXOHz0IH72PwQbxf9KjHEdIpd+374qtcxiBiv6ZsAA+kePZLAjROvX4oZPeNo
         XdyA5vmAvAr3U1c1Qy3CXrrQlW2jhLnsg6vG2U9Qmnff35Sx4OI7vPcgcZx7nQEDf+af
         pagw==
X-Gm-Message-State: AFqh2kqgEh645/n/nxB2rFJrjkObpMOz6mZRACZhbHV83UregaKnXM72
        vUKZ5/dFcAttHshEY3skGks3mnVdRUieOCAMAC5+Rg==
X-Google-Smtp-Source: AMrXdXvljgHOV/UoOcOikWC1/3qvS04jHBKBkL3Vl0H3O9rQK82hflXcJ4xxJZi7iin1IEWYklAFhv7wq6FpD+eNUG8=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr160919ybe.316.1673908583348; Mon, 16
 Jan 2023 14:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost>
In-Reply-To: <Y8UxnqPCTLbbD+2F@localhost>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 Jan 2023 14:36:12 -0800
Message-ID: <CAJuCfpGmYNYxCrbCsvhgsXDt1patKSHib32te1Mwx+wducuPAA@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
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

On Mon, Jan 16, 2023 at 3:15 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Mon, Jan 09, 2023 at 12:53:36PM -0800, Suren Baghdasaryan wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index d40bf8a5e19e..294dd44b2198 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -627,12 +627,16 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> >        * mm->mm_lock_seq can't be concurrently modified.
> >        */
> >       mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> > -     if (vma->vm_lock_seq == mm_lock_seq)
> > +     if (vma->vm_lock->lock_seq == mm_lock_seq)
> >               return;
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
> With this change readers can cause writers to starve.
> What about checking waitqueue_active() before or after increasing
> vma->vm_lock->count?

The readers are in page fault path, which is the fast path, while
writers performing updates are in slow path. Therefore I *think*
starving writers should not be a big issue. So far in benchmarks I
haven't seen issues with that but maybe there is such a case?

>
> --
> Thanks,
> Hyeonggon
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
