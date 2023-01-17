Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0469670B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjAQWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAQWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:08:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65108BBA1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dYK7QHEqGROj9cTFeHvfSuKosaNcqMrUb865g495bOk=; b=O6tZSHHzGKJZX1iAYHUlbpNdcq
        ZxrxvmTmmsbqr936EiEWOWMMqob8GgiHmdccZoQjFy2M7JSHlbZzbvs2TchncI+j0k3viYTmseIPC
        SRjOwRtExn9hUARvpUyEETZYLIXkShGyDfwMwJ/WYav3L6y7Iyc00H+U3nCuYm8W5n4LDo5BjuZ9p
        +4aRxAyoACCM8sQessBpBPk+zQMyvZ5Hh/ve5p02fFVP7yXt2nK4sqO5wiKupykfS5P04QW3XJyeU
        2jtbz1crNDA/cVwMfi6Bbdl8kHWAt1s79upbuw/UbeV07ohd0sPjx5OZI3OnS4vNsVmqG228akiwH
        AVrAhxbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHtv0-00A4f1-Fg; Tue, 17 Jan 2023 21:54:58 +0000
Date:   Tue, 17 Jan 2023 21:54:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
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
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
Message-ID: <Y8cZMt01Z1FvVFXh@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-13-surenb@google.com>
 <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz>
 <Y8a66gshQkkhC1cT@dhcp22.suse.cz>
 <CAJuCfpF2ciMbMFgqa4GqYqg8zjpnmBoNZDG23V0+w017LXeU3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF2ciMbMFgqa4GqYqg8zjpnmBoNZDG23V0+w017LXeU3w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 01:21:47PM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 17, 2023 at 7:12 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 17-01-23 16:04:26, Michal Hocko wrote:
> > > On Mon 09-01-23 12:53:07, Suren Baghdasaryan wrote:
> > > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > > to be exclusively locked during VMA tree modifications, instead of the
> > > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > > locked.
> > >
> > > I have to say I was struggling a bit with the above and only understood
> > > what you mean by reading the patch several times. I would phrase it like
> > > this (feel free to use if you consider this to be an improvement).
> > >
> > > Introduce a per-VMA rw_semaphore. The lock implementation relies on a
> > > per-vma and per-mm sequence counters to note exclusive locking:
> > >         - read lock - (implemented by vma_read_trylock) requires the the
> > >           vma (vm_lock_seq) and mm (mm_lock_seq) sequence counters to
> > >           differ. If they match then there must be a vma exclusive lock
> > >           held somewhere.
> > >         - read unlock - (implemented by vma_read_unlock) is a trivial
> > >           vma->lock unlock.
> > >         - write lock - (vma_write_lock) requires the mmap_lock to be
> > >           held exclusively and the current mm counter is noted to the vma
> > >           side. This will allow multiple vmas to be locked under a single
> > >           mmap_lock write lock (e.g. during vma merging). The vma counter
> > >           is modified under exclusive vma lock.
> >
> > Didn't realize one more thing.
> >             Unlike standard write lock this implementation allows to be
> >             called multiple times under a single mmap_lock. In a sense
> >             it is more of mark_vma_potentially_modified than a lock.
> 
> In the RFC it was called vma_mark_locked() originally and renames were
> discussed in the email thread ending here:
> https://lore.kernel.org/all/621612d7-c537-3971-9520-a3dec7b43cb4@suse.cz/.
> If other names are preferable I'm open to changing them.

I don't want to bikeshed this, but rather than locking it seems to be
more:

	vma_start_read()
	vma_end_read()
	vma_start_write()
	vma_end_write()
	vma_downgrade_write()

... and that these are _implemented_ with locks (in part) is an
implementation detail?

Would that reduce people's confusion?

> >
> > >         - write unlock - (vma_write_unlock_mm) is a batch release of all
> > >           vma locks held. It doesn't pair with a specific
> > >           vma_write_lock! It is done before exclusive mmap_lock is
> > >           released by incrementing mm sequence counter (mm_lock_seq).
> > >       - write downgrade - if the mmap_lock is downgraded to the read
> > >         lock all vma write locks are released as well (effectivelly
> > >         same as write unlock).
> > --
> > Michal Hocko
> > SUSE Labs
