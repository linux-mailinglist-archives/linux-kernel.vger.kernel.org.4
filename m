Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83EA66E6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjAQTM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjAQTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2A5C0D9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XSVCY3skPmpUfyMO6XuiNShJAohbJi5MJ+0Tl/OQUuk=; b=mEluEUKEDZTyyDRpL261mqgUP9
        +oWDZVX/939c909IkEujz+5khCUlk0qOmmCBOOt8jtKddSVusCBFb9ScfvddAieediYlWLsZGvbPU
        gGGXDadE03QIEDHX5V7yGFQsW7tadIpolftpzK+aHNUrxUhONvsFXMWrupAS+vHfu2z7nIdDpPLnr
        sUr6vc584V1N2NE72pohE5J1oRqScKE6VlFtORFuIFpAcUiPgUB+duQxe9dZ7JbgOqu24MFvdIZpo
        06YDcK8usO6+UsjwIgUQzhshHBEVMboByXpfHEdkep+Eov/2x34RXGz4SHfdJiNQc/QTDhwNOULG5
        FkfgV8aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqcQ-009uA2-Oe; Tue, 17 Jan 2023 18:23:34 +0000
Date:   Tue, 17 Jan 2023 18:23:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
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
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Y8bnpqw134CHenz/@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost>
 <Y8YgomKF189vmgLz@casper.infradead.org>
 <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
 <Y8Y2JErbNQOhL8ee@casper.infradead.org>
 <CAJuCfpEx6FJpm0Js=cvcHw6mY3izPfoskxseSMyxFAxLX97X_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEx6FJpm0Js=cvcHw6mY3izPfoskxseSMyxFAxLX97X_w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:58:35PM -0800, Suren Baghdasaryan wrote:
> On Mon, Jan 16, 2023 at 9:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jan 16, 2023 at 08:34:36PM -0800, Suren Baghdasaryan wrote:
> > > On Mon, Jan 16, 2023 at 8:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Jan 16, 2023 at 11:14:38AM +0000, Hyeonggon Yoo wrote:
> > > > > > @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> > > > > >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > > > > >  {
> > > > > >     /* Check before locking. A race might cause false locked result. */
> > > > > > -   if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > > > +   if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > > >             return false;
> > > > > >
> > > > > > -   if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> > > > > > +   if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
> > > > > >             return false;
> > > > > >
> > > > > > +   /* If atomic_t overflows, restore and fail to lock. */
> > > > > > +   if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> > > > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > > +           return false;
> > > > > > +   }
> > > > > > +
> > > > > >     /*
> > > > > >      * Overflow might produce false locked result.
> > > > > >      * False unlocked result is impossible because we modify and check
> > > > > >      * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
> > > > > >      * modification invalidates all existing locks.
> > > > > >      */
> > > > > > -   if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > > > -           up_read(&vma->vm_lock->lock);
> > > > > > +   if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > >             return false;
> > > > > >     }
> > > > >
> > > > > With this change readers can cause writers to starve.
> > > > > What about checking waitqueue_active() before or after increasing
> > > > > vma->vm_lock->count?
> > > >
> > > > I don't understand how readers can starve a writer.  Readers do
> > > > atomic_inc_unless_negative() so a writer can always force readers
> > > > to fail.
> > >
> > > I think the point here was that if page faults keep occuring and they
> > > prevent vm_lock->count from reaching 0 then a writer will be blocked
> > > and there is no reader throttling mechanism (no max time that writer
> > > will be waiting).
> >
> > Perhaps I misunderstood your description; I thought that a _waiting_
> > writer would make the count negative, not a successfully acquiring
> > writer.
> 
> A waiting writer does not modify the counter, instead it's placed on
> the wait queue and the last reader which sets the count to 0 while
> releasing its read lock will wake it up. Once the writer is woken it
> will try to set the count to negative and if successful will own the
> lock, otherwise it goes back to sleep.

Then yes, that's a starvable lock.  Preventing starvation on the mmap
sem was the original motivation for making rwsems non-starvable, so
changing that behaviour now seems like a bad idea.  For efficiency, I'd
suggest that a waiting writer set the top bit of the counter.  That way,
all new readers will back off without needing to check a second variable
and old readers will know that they *may* need to do the wakeup when
atomic_sub_return_release() is negative.

(rwsem.c has a more complex bitfield, but I don't think we need to go
that far; the important point is that the waiting writer indicates its
presence in the count field so that readers can modify their behaviour)
