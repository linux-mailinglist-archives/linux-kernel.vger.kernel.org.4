Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29866D5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjAQFqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAQFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:46:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B82195A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y+G3RMYpPUCpeVuUHshColV5JZSGDtGhPdizzIP2wms=; b=P5cLpNHv6wO/jMH62R5ivyuODF
        9VsvXC8b/excwArNe/KRkxWV2mLKsX2xgsbEwt66Kpn346Prm3dUGTZPNLMImD+nitRxhxo3xsvrJ
        mfWg3QFSX5Pnkn3FwXGIL0mp4sWpaCgjBACW/+8RJtWIR3s1pBjFwfBDXT+otbyR6bwQonX/+BNxd
        m4lbN1/gZznRAQ0EpxpP7GMJZxelmPWujsE6/6vtlABgFHE/nyJ+bG6wPajtevQ+GbMdPYR+7Tt7o
        zrVDxwqxl2pwLVtaerw4OF9cO5ys5rZNxm/Sm8Y2+JIni90YzxmlfVcFMmeuOLlaAh3xxs8PtamWR
        Fca2JJYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHenU-009Pje-4O; Tue, 17 Jan 2023 05:46:12 +0000
Date:   Tue, 17 Jan 2023 05:46:12 +0000
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
Message-ID: <Y8Y2JErbNQOhL8ee@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost>
 <Y8YgomKF189vmgLz@casper.infradead.org>
 <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:34:36PM -0800, Suren Baghdasaryan wrote:
> On Mon, Jan 16, 2023 at 8:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jan 16, 2023 at 11:14:38AM +0000, Hyeonggon Yoo wrote:
> > > > @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> > > >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > > >  {
> > > >     /* Check before locking. A race might cause false locked result. */
> > > > -   if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > +   if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > >             return false;
> > > >
> > > > -   if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> > > > +   if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
> > > >             return false;
> > > >
> > > > +   /* If atomic_t overflows, restore and fail to lock. */
> > > > +   if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > +           return false;
> > > > +   }
> > > > +
> > > >     /*
> > > >      * Overflow might produce false locked result.
> > > >      * False unlocked result is impossible because we modify and check
> > > >      * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
> > > >      * modification invalidates all existing locks.
> > > >      */
> > > > -   if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > -           up_read(&vma->vm_lock->lock);
> > > > +   if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > >             return false;
> > > >     }
> > >
> > > With this change readers can cause writers to starve.
> > > What about checking waitqueue_active() before or after increasing
> > > vma->vm_lock->count?
> >
> > I don't understand how readers can starve a writer.  Readers do
> > atomic_inc_unless_negative() so a writer can always force readers
> > to fail.
> 
> I think the point here was that if page faults keep occuring and they
> prevent vm_lock->count from reaching 0 then a writer will be blocked
> and there is no reader throttling mechanism (no max time that writer
> will be waiting).

Perhaps I misunderstood your description; I thought that a _waiting_
writer would make the count negative, not a successfully acquiring
writer.
