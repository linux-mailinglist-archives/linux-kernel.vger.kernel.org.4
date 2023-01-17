Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8766E76A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjAQUHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjAQUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:04:27 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C387496F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:55:46 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v19so29377808ybv.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjk26ZZoZCfL6kjko8l/pSHnRgndFb4Mk147LRzA91E=;
        b=Mt+sJp5dwuIsL+Ko5cT1XtmvNX0+vXcya9w3KxCAGiP5wEFud5o530HskF9og8ZMkd
         ljvA9NKCih7KjYskMBb5clv4araVsgVH8bivehaUbVs1zXmC/Q33zJ2WQgBH8wLEh0Ww
         LO52zNPDud7WwXKOiScqFdlxb/HA84LcUefakhGKNdWzRjfSLYoc+FzRvi5aIbasr4/1
         iGt43X07P5GiJPZJVy/5QSn6qq+xCbFLi962ogszxOLly8aqpiMkM3flx1tsWJ3TC+lM
         JwJqwtVwEAaEziK1WoW3RHASnzImrfdF+niEuev4vFd01otF7C+PJQGmm/v884HYR4zi
         v9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hjk26ZZoZCfL6kjko8l/pSHnRgndFb4Mk147LRzA91E=;
        b=2FC22DkqP7MkMlGhoLWw55QENpcQvSW9c1bvBR67f8DZFTSsF/B7I2Qw923gKTPPyr
         c+AMTZQA8aSr/dO5YTCgVwsiOnonVbFVNY+cZPXYdOch0tiLE+C46yNUZEDNTjLBuoMV
         egsurlNxv21S4uHFipbm63M0aSkQ9Hos9o71vE8d2zDy4whHBqtRLaWrAtyI8TgzYrI/
         zEH/gAEQXbF3FJQYznxy+XSZMBt7WVGmRxDjl1msfZPYaGtyvc25bP+h3kwLWDj8avp0
         za0UGwErCqWvjo5MHV+6Gu3Wjr49HDN0GRzrwUK9BTO0Xzj15THLnkHLH9QLDEIPR+Ki
         UJEw==
X-Gm-Message-State: AFqh2kraX4eF0IE8+D1UooPz2kQwNwBhe+BknkoORzK8gsuFHfHjmaTB
        ePqFXtf9Z4cC/3HLbBq2mUQnJZ/FLgR+riWhX8jcTw==
X-Google-Smtp-Source: AMrXdXsB68dzuUro7SI9IrfjHxCTvw8eBu3xk1m8gxflhvDRkqqF3qc7tx3EmnQTV75nr092zIYy1Q+gFJMC6cvTzv8=
X-Received: by 2002:a5b:cc8:0:b0:7ba:78b1:9fcc with SMTP id
 e8-20020a5b0cc8000000b007ba78b19fccmr507280ybr.593.1673981745113; Tue, 17 Jan
 2023 10:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
 <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com>
 <Y8bpfzYvWq/3ttr+@casper.infradead.org> <CAJuCfpHkgRDpMJXd6vnCmB50PnSOwDY9pjhW5LcdR+fU5JUseA@mail.gmail.com>
 <Y8btYASD3jmdCf5n@casper.infradead.org>
In-Reply-To: <Y8btYASD3jmdCf5n@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:55:33 -0800
Message-ID: <CAJuCfpGcufxmL7A-ea_JDKU2pxrTQJ7Sez7C6zcVyFK9q1CXUg@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Tue, Jan 17, 2023 at 10:47 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 17, 2023 at 10:36:42AM -0800, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 10:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 10:26:32AM -0800, Suren Baghdasaryan wrote:
> > > > On Tue, Jan 17, 2023 at 10:12 AM Jann Horn <jannh@google.com> wrote:
> > > > >
> > > > > On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > rw_semaphore is a sizable structure of 40 bytes and consumes
> > > > > > considerable space for each vm_area_struct. However vma_lock has
> > > > > > two important specifics which can be used to replace rw_semaphore
> > > > > > with a simpler structure:
> > > > > [...]
> > > > > >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > > >  {
> > > > > > -       up_read(&vma->vm_lock->lock);
> > > > > > +       if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > > +               wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > >  }
> > > > >
> > > > > I haven't properly reviewed this, but this bit looks like a
> > > > > use-after-free because you're accessing the vma after dropping your
> > > > > reference on it. You'd have to first look up the vma->vm_mm, then do
> > > > > the atomic_dec_and_test(), and afterwards do the wake_up() without
> > > > > touching the vma. Or alternatively wrap the whole thing in an RCU
> > > > > read-side critical section if the VMA is freed with RCU delay.
> > > >
> > > > vm_lock->count does not control the lifetime of the VMA, it's a
> > > > counter of how many readers took the lock or it's negative if the lock
> > > > is write-locked.
> > >
> > > Yes, but ...
> > >
> > >         Task A:
> > >         atomic_dec_and_test(&vma->vm_lock->count)
> > >                         Task B:
> > >                         munmap()
> > >                         write lock
> > >                         free VMA
> > >                         synchronize_rcu()
> > >                         VMA is really freed
> > >         wake_up(&vma->vm_mm->vma_writer_wait);
> > >
> > > ... vma is freed.
> > >
> > > Now, I think this doesn't occur.  I'm pretty sure that every caller of
> > > vma_read_unlock() is holding the RCU read lock.  But maybe we should
> > > have that assertion?
> >
> > Yep, that's what this patch is doing
> > https://lore.kernel.org/all/20230109205336.3665937-27-surenb@google.com/
> > by calling vma_assert_no_reader() from __vm_area_free().
>
> That's not enough though.  Task A still has a pointer to vma after it
> has called atomic_dec_and_test(), even after vma has been freed by
> Task B, and before Task A dereferences vma->vm_mm.

Ah, I see your point now. I guess I'll have to store vma->vm_mm in a
local variable and call mmgrab() before atomic_dec_and_test(), then
use it in wake_up() and call mmdrop(). Is that what you are thinking?
