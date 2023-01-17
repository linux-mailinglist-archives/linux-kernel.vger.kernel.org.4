Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1D670E52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjARACi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjARACP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:02:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C27B4E1E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=10ybaKGDEMNrZJwsXfzl1FfnbRmTCPN7YpUINfERZ28=; b=L/0tR0eKtGHYZtRFgbb4J/TazM
        jwcMUPJtwquGQc7O2qRObrMoc3DbrRyrPw6llbDvvKc5YR+S8oxReiTZyiHgud38bANV1BvJGVmPw
        ZBreiPK44g//2XbqFyhvcLxFA1G4radxeNrEsltk3gFb/MO2+7BwuQfND0zlYFjiNrTO0iqmTMIHY
        6uf/lY6WYjCAp8nD1X/48axQ/8Csodfz/VbklYybkBH7olSZLVzmpCcW0/EEe0ND1WhiDbhXowLYY
        zk0RSsGT5eOn/3NHhN6A1QjXlTe2kTSyOLUzIG/lzVj7BI/KNG2VFr2sJfBSsh9nGSt7w8KZzyYH5
        BUnxXFnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHvAp-00A86K-5N; Tue, 17 Jan 2023 23:15:23 +0000
Date:   Tue, 17 Jan 2023 23:15:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Jann Horn <jannh@google.com>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
Message-ID: <Y8csC2Jgzx4Gt7n0@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-13-surenb@google.com>
 <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
 <CAJuCfpHawn-hj3yK6MEMHsvnH9xgO87h7Sj3_g0FA7rgut_mVg@mail.gmail.com>
 <CAG48ez3sCwasFzKD5CsqMFA2W57-2fazd75g7r0NaA_BVNTLow@mail.gmail.com>
 <CAJuCfpFDyt2ZBGufhRz6oz2E=oyO47-d7BHwSeOiexD+UQ08jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFDyt2ZBGufhRz6oz2E=oyO47-d7BHwSeOiexD+UQ08jA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:36:47PM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 17, 2023 at 1:46 PM Jann Horn <jannh@google.com> wrote:
> > On Tue, Jan 17, 2023 at 10:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > On Tue, Jan 17, 2023 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > > > One thing that might be gnarly here is that I think you might not be
> > > > allowed to use up_read() to fully release ownership of an object -
> > > > from what I remember, I think that up_read() (unlike something like
> > > > spin_unlock()) can access the lock object after it's already been
> > > > acquired by someone else. So if you want to protect against concurrent
> > > > deletion, this might have to be something like:
> > > >
> > > > rcu_read_lock(); /* keeps vma alive */
> > > > up_read(&vma->lock);
> > > > rcu_read_unlock();
> > >
> > > But for deleting VMA one would need to write-lock the vma->lock first,
> > > which I assume can't happen until this up_read() is complete. Is that
> > > assumption wrong?
> >
> > __up_read() does:
> >
> > rwsem_clear_reader_owned(sem);
> > tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
> > DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
> > if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
> >       RWSEM_FLAG_WAITERS)) {
> >   clear_nonspinnable(sem);
> >   rwsem_wake(sem);
> > }
> >
> > The atomic_long_add_return_release() is the point where we are doing
> > the main lock-releasing.
> >
> > So if a reader dropped the read-lock while someone else was waiting on
> > the lock (RWSEM_FLAG_WAITERS) and no other readers were holding the
> > lock together with it, the reader also does clear_nonspinnable() and
> > rwsem_wake() afterwards.
> > But in rwsem_down_write_slowpath(), after we've set
> > RWSEM_FLAG_WAITERS, we can return successfully immediately once
> > rwsem_try_write_lock() sees that there are no active readers or
> > writers anymore (if RWSEM_LOCK_MASK is unset and the cmpxchg
> > succeeds). We're not necessarily waiting for the "nonspinnable" bit or
> > the wake.
> >
> > So yeah, I think down_write() can return successfully before up_read()
> > is done with its memory accesses.
> >
> > (Spinlocks are different - the kernel relies on being able to drop
> > references via spin_unlock() in some places.)
> 
> Thanks for bringing this up. I can add rcu_read_{lock/unlock) as you
> suggested and that would fix the issue because we free VMAs from
> call_rcu(). However this feels to me as an issue of rw_semaphore
> design that this locking pattern is unsafe and might lead to UAF.

We have/had this problem with normal mutexes too.  It was the impetus
for adding the struct completion which is very careful to not touch
anything after the completion is, well, completed.
