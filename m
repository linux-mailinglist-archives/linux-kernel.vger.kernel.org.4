Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA6678639
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjAWTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjAWTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:24:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B5D30F2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:24:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B0B6B80DCC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 19:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B45C433D2;
        Mon, 23 Jan 2023 19:24:50 +0000 (UTC)
Date:   Mon, 23 Jan 2023 19:24:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RESEND PATCH v2 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Message-ID: <Y87fAFIxd+NMFouM@arm.com>
References: <20230119040111.350923-1-longman@redhat.com>
 <20230119040111.350923-3-longman@redhat.com>
 <Y8ro6DxR1v0XlDs3@arm.com>
 <55978b11-5e7e-4b10-dff1-398275ec68b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55978b11-5e7e-4b10-dff1-398275ec68b3@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:54:28PM -0500, Waiman Long wrote:
> On 1/20/23 14:18, Catalin Marinas wrote:
> > >   /*
> > > @@ -633,6 +642,7 @@ static void __create_object(unsigned long ptr, size_t size,
> > >   	object->count = 0;			/* white color initially */
> > >   	object->jiffies = jiffies;
> > >   	object->checksum = 0;
> > > +	object->del_state = 0;
> > >   	/* task information */
> > >   	if (in_hardirq()) {
> > > @@ -1470,9 +1480,22 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
> > >   	if (!get_object(object))
> > >   		return;	/* Try next object */
> > > +	raw_spin_lock_irq(&kmemleak_lock);
> > > +	if (object->del_state & DELSTATE_REMOVED)
> > > +		goto unlock_put;	/* Object removed */
> > > +	object->del_state |= DELSTATE_NO_DELETE;
> > > +	raw_spin_unlock_irq(&kmemleak_lock);
> > > +
> > >   	rcu_read_unlock();
> > >   	cond_resched();
> > >   	rcu_read_lock();
> > > +
> > > +	raw_spin_lock_irq(&kmemleak_lock);
> > > +	if (object->del_state & DELSTATE_REMOVED)
> > > +		list_del_rcu(&object->object_list);
> > > +	object->del_state &= ~DELSTATE_NO_DELETE;
> > > +unlock_put:
> > > +	raw_spin_unlock_irq(&kmemleak_lock);
> > >   	put_object(object);
> > >   }
> > I'm not sure this was the only problem. We do have the problem that the
> > current object may be removed from the list, solved above, but another
> > scenario I had in mind is the next object being released during this
> > brief resched period. The RCU relies on object->next->next being valid
> > but, with a brief rcu_read_unlock(), the object->next could be freed,
> > reallocated, so object->next->next invalid.
> 
> Looking at the following scenario,
> 
> object->next => A (removed)
> A->next => B (removed)
> 
> As object->next is pointing to A, A must still be allocated and not freed
> yet. Now if B is also removed, there are 2 possible case.
> 
> 1) B is removed from the list after the removal of A. In that case, it is
> not possible that A is allocated, but B is freed.
> 
> 2) B is removed before A. A->next can't pointed to B when it is being
> removed. Due to weak memory ordering, it is possible that another cpu can
> see A->next still pointing to B. In that case, I believe that it is still
> within the grace period where neither A or B is freed.
> 
> In fact, it is no different from a regular scanning of the object list
> without ever called cond_resched().

More like thinking out loud:

The lockless RCU loop relies on object->next->next being valid within
the grace period (A not freed). Due to weak memory ordering, the looping
CPU may not observe the object->next update (removal of A) by another
CPU, so it continues to loop over it. But since we do an
rcu_read_unlock() in the middle of the loop, I don't think these
assumptions are still valid, so A may be freed.

What we need is that object->next reading for the following iteration
either sees the updated object->next (B) or it sees A but the latter
still around. I think this holds with the proposed
kmemleak_cond_resched() since we now start a new grace period with
rcu_read_lock() followed by taking and releasing kmemleak_lock. The
latter would give us the memory ordering required since removing object
A from the list does take the lock.

So yeah, you are probably right, I just find it hard to get my head
around ;). I still think it would be simpler with a single kmemleak_lock
(no object->lock) but that's more involved than a simple fix.

Assuming your (and my) reasoning above is correct:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
