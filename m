Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5C66E749
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjAQT4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjAQTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:54:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E99599B9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ei8DN4xoI7q+Mi7aRIGqiZxm7UY0w7vz3mLthbLe1k=; b=If96WMO3JL8wGi0lqkg9YBuOMp
        I4zZJGeOQc1TG1UTINhSSp8ySLEyWyptBt7FUi6oFTm+mqgs0UcHZ0EdmhQm4dodBKS/Hw0sGBqu+
        x+DkT2XT6XoF7Sp+pB5nZOas+8Xj7PHMLT8W4BKJgVeQkih9A6yTFcFl2iBJ0BCqulbU9UYfAvc4J
        FAaV71OVDApfKIXMPOMCP599ea+PdvJDIWfefrljmE8M7ThB5aS1OgX+GPqNnuvoufc4xuIX/Lq30
        NrVXQYo9o8RA3Vf/FPIZ/rkvTDYN9W8whGkyy7EaTaqK34jJoBgHVBLgA4Y7ymU1ThrKjNAA7eZG5
        LJAWEwzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHr04-009vFr-26; Tue, 17 Jan 2023 18:48:00 +0000
Date:   Tue, 17 Jan 2023 18:48:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Y8btYASD3jmdCf5n@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
 <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com>
 <Y8bpfzYvWq/3ttr+@casper.infradead.org>
 <CAJuCfpHkgRDpMJXd6vnCmB50PnSOwDY9pjhW5LcdR+fU5JUseA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHkgRDpMJXd6vnCmB50PnSOwDY9pjhW5LcdR+fU5JUseA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:36:42AM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 17, 2023 at 10:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jan 17, 2023 at 10:26:32AM -0800, Suren Baghdasaryan wrote:
> > > On Tue, Jan 17, 2023 at 10:12 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > rw_semaphore is a sizable structure of 40 bytes and consumes
> > > > > considerable space for each vm_area_struct. However vma_lock has
> > > > > two important specifics which can be used to replace rw_semaphore
> > > > > with a simpler structure:
> > > > [...]
> > > > >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > >  {
> > > > > -       up_read(&vma->vm_lock->lock);
> > > > > +       if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > +               wake_up(&vma->vm_mm->vma_writer_wait);
> > > > >  }
> > > >
> > > > I haven't properly reviewed this, but this bit looks like a
> > > > use-after-free because you're accessing the vma after dropping your
> > > > reference on it. You'd have to first look up the vma->vm_mm, then do
> > > > the atomic_dec_and_test(), and afterwards do the wake_up() without
> > > > touching the vma. Or alternatively wrap the whole thing in an RCU
> > > > read-side critical section if the VMA is freed with RCU delay.
> > >
> > > vm_lock->count does not control the lifetime of the VMA, it's a
> > > counter of how many readers took the lock or it's negative if the lock
> > > is write-locked.
> >
> > Yes, but ...
> >
> >         Task A:
> >         atomic_dec_and_test(&vma->vm_lock->count)
> >                         Task B:
> >                         munmap()
> >                         write lock
> >                         free VMA
> >                         synchronize_rcu()
> >                         VMA is really freed
> >         wake_up(&vma->vm_mm->vma_writer_wait);
> >
> > ... vma is freed.
> >
> > Now, I think this doesn't occur.  I'm pretty sure that every caller of
> > vma_read_unlock() is holding the RCU read lock.  But maybe we should
> > have that assertion?
> 
> Yep, that's what this patch is doing
> https://lore.kernel.org/all/20230109205336.3665937-27-surenb@google.com/
> by calling vma_assert_no_reader() from __vm_area_free().

That's not enough though.  Task A still has a pointer to vma after it
has called atomic_dec_and_test(), even after vma has been freed by
Task B, and before Task A dereferences vma->vm_mm.
