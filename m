Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C2683456
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAaRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjAaRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECB6A46
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675187637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxLokYAH5ydF1+ZeMtmR9NhkYjt+FwCvHi94HFDPd2c=;
        b=QaUrx0QprOe+YqIi7zoJ1uHbW2knLUOLc+QKI4Oc/Z2H5WYs9/ohO29varkfNSQWecRdrv
        d0GelY8BUw45gJSidFqfNzDctQzz2UtFBU8YV1+o+kNtfDoVDZ43h+oDY4HvA02JOc78H3
        P3NeTv1tYZzVEa8vOMm6enF35/MD8+I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-FU9SEH-zOqiwyDfq2-lFUg-1; Tue, 31 Jan 2023 12:53:54 -0500
X-MC-Unique: FU9SEH-zOqiwyDfq2-lFUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 355032A59557;
        Tue, 31 Jan 2023 17:53:54 +0000 (UTC)
Received: from fedora (unknown [10.22.16.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3E10C15BAD;
        Tue, 31 Jan 2023 17:53:51 +0000 (UTC)
Date:   Tue, 31 Jan 2023 14:53:50 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
Message-ID: <20230131175350.s7eiz55fozlhaegh@fedora>
References: <20230117172649.52465-1-wander@redhat.com>
 <875yd4k8qd.ffs@tglx>
 <CAAq0SUkN38V00HqV3Hk3ee_-=vfkKxG9xtR3n=4gAT+zCs+=Zg@mail.gmail.com>
 <87fsc6i6ud.ffs@tglx>
 <CAAq0SU=FmkSyS=-SQJBoHYEtZExK3Qn9Wqcn-c+BnmfVeO3q6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SU=FmkSyS=-SQJBoHYEtZExK3Qn9Wqcn-c+BnmfVeO3q6g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:46:19PM -0300, Wander Lairson Costa wrote:
> On Thu, Jan 19, 2023 at 5:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Wander!
> >
> > On Wed, Jan 18 2023 at 15:49, Wander Lairson Costa wrote:
> > > On Tue, Jan 17, 2023 at 9:05 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> On Tue, Jan 17 2023 at 14:26, Wander Lairson Costa wrote:
> > >> > rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
> > >> > phase, waiter may be initially in the top of the queue, but after
> > >> > dequeued and requeued it may no longer be true.
> > >>
> > >> That's related to your above argumentation in which way?
> > >>
> > >
> > > I think I made the mistake of not explicitly saying at least three
> > > tasks are involved:
> > >
> > > - A Task T1 that currently holds the mutex
> > > - A Task T2 that is the top waiter
> > > - A Task T3 that changes the top waiter
> > >
> > > T3 tries to acquire the mutex, but as T1 holds it, it calls
> > > task_blocked_on_lock() and saves the owner. It eventually calls
> > > rt_mutex_adjust_prio_chain(), but it releases the wait lock before
> > > doing so. This opens a window for T1 to release the mutex and wake up
> > > T2. Before T2 runs, T3 acquires the wait lock again inside
> > > rt_mutex_adjust_prio_chain(). If the "dequeue/requeue" piece of code
> > > changes the top waiter, then 1) When T2 runs, it will verify that it
> > > is no longer the top waiter and comes back to sleep 2) As you observed
> > > below, the waiter doesn't point to the top waiter and, therefore, it
> > > will wake up the wrong task.
> >
> > This is still confusing as hell because the wait locks you are talking
> > about belong to different rtmutexes. So there is no drops wait lock and
> > reacquires wait lock window.
> >
> > There must be (multiple) lock chains involved, but I couldn't figure out
> > yet what the actaul scenario is in the case of a pure rt_spinlock clock
> > chain:
> >
> 
> Sorry, it took so long to reply. I didn't have the traces anymore and
> had to regenerate them. You spotted an error in my analysis, then I
> had to start over.
> 
> > > Another piece of information I forgot: I spotted the bug in the
> > > spinlock_rt, which uses a rtmutex under the hood. It has a different
> > > code path in the lock scenario, and there is no call to
> > > remove_waiter() (or I am missing something).
> >
> > Correct. But this still might be a lock chain issue where a non
> > rt_spinlock which allows early removal.
> >
> > > Anyway, you summed it up pretty well here: "@waiter is no longer the
> > > top waiter due to the requeue operation". I tried (and failed) to
> > > explain the call chain that ends up in the buggy scenario, but now I
> > > think I should just describe the fundamental problem (the waiter
> > > doesn't point to the top waiter).
> >
> > You really want to provide the information WHY this case can happen at
> > all. If it's not the removal case and related to some other obscure lock
> > chain problem, then we really need to understand the scenario because
> > that lets us analyze whether there are other holes we did not think
> > about yet.
> >
> > If you have traces which show the sequence of lock events leading to
> > this problem, then you should be able to decode the scenario. If you
> > fail to extract the information, then please provide the traces so we
> > can stare at them.
> >
> 
> Here we go:
> 
> Let L1 and L2 be two spinlocks.
> 
> Let T1 be a task holding L1 and blocked on L2. T1, currently, is the top
> waiter of L2.
> 
> Let T2 be the task holding L2.
> 
> Let T3 be a task trying to acquire L1.
> 
> The following events will lead to a state in which the wait queue of L2
> isn't empty but nobody holds it.
> 
> T1                              T2                              T3
>                                                                 spin_lock(L1)
> 
> raw_spin_lock(L1->wait_lock)
> 
> rtlock_slowlock_locked(L1)
> 
> task_blocks_on_rt_mutex(L1, T3)
> 
> orig_waiter->lock = L1
> 
> orig_waiter->task = T3
> 
> raw_spin_unlock(L1->wait_lock)
> 
> rt_mutex_adjust_prio_chain(T1, L1, L2, orig_waiter, T3)
> 
>                                 spin_unlock(L2)
>                                   rt_mutex_slowunlock(L2)
>                                     raw_spin_lock(L2->wait_lock)
>                                     wakeup(T1)
>                                     raw_spin_unlock(L2->wait_lock)
> 
>        waiter = T1->pi_blocked_on
> 
>        waiter == rt_mutex_top_waiter(L2)
> 
>        waiter->task == T1
> 
>        raw_spin_lock(L2->wait_lock)
> 
>        dequeue(L2, waiter)
> 
>        update_prio(waiter, T1)
> 
>        enqueue(L2, waiter)
> 
>        waiter != rt_mutex_top_waiter(L2)
> 
>        L2->owner == NULL
> 
>        wakeup(T1)
> 
>        raw_spin_unlock(L2->wait_lock)
> T1 wakes up
> T1 != top_waiter(L2)
> schedule_rtlock()
> 

Arrrrghhhh, s**t mail servers... Hopefully now it is formatted correctly:

Let L1 and L2 be two spinlocks.

Let T1 be a task holding L1 and blocked on L2. T1, currently, is the top
waiter of L2.

Let T2 be the task holding L2.

Let T3 be a task trying to acquire L1.

The following events will lead to a state in which the wait queue of L2
isn't empty but nobody holds it.

T1                              T2                              T3
                                                                spin_lock(L1)
                                                                  raw_spin_lock(L1->wait_lock)
                                                                  rtlock_slowlock_locked(L1)
                                                                    task_blocks_on_rt_mutex(L1, T3)
                                                                      orig_waiter->lock = L1
                                                                      orig_waiter->task = T3
                                                                      raw_spin_unlock(L1->wait_lock)
                                                                      rt_mutex_adjust_prio_chain(T1, L1, L2, orig_waiter, T3)

                                spin_unlock(L2)
                                  rt_mutex_slowunlock(L2)
                                    raw_spin_lock(L2->wait_lock)
                                    wakeup(T1)
                                    raw_spin_unlock(L2->wait_lock)
                                                                              waiter = T1->pi_blocked_on
                                                                              waiter == rt_mutex_top_waiter(L2)
                                                                              waiter->task == T1
                                                                              raw_spin_lock(L2->wait_lock)
                                                                              dequeue(L2, waiter)
                                                                              update_prio(waiter, T1)
                                                                              enqueue(L2, waiter)
                                                                              waiter != rt_mutex_top_waiter(L2)
                                                                              L2->owner == NULL
                                                                              wakeup(T1)
                                                                              raw_spin_unlock(L2->wait_lock)
T1 wakes up
T1 != top_waiter(L2)
schedule_rtlock()

