Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C464E980
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLPKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiLPKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:32:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F33D3AF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:32:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE0A6204B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AF4C433EF;
        Fri, 16 Dec 2022 10:32:30 +0000 (UTC)
Date:   Fri, 16 Dec 2022 10:32:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Message-ID: <Y5xJOuVsQbITDq14@arm.com>
References: <20221210230048.2841047-1-longman@redhat.com>
 <20221210230048.2841047-3-longman@redhat.com>
 <Y5mwnc03h10r0rKK@arm.com>
 <b453f697-b21b-d80e-6c41-dfa260bb2220@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b453f697-b21b-d80e-6c41-dfa260bb2220@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:54:28AM -0500, Waiman Long wrote:
> On 12/14/22 06:16, Catalin Marinas wrote:
> > On Sat, Dec 10, 2022 at 06:00:48PM -0500, Waiman Long wrote:
> > > Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
> > > object iteration loop of kmemleak_scan()") fixes soft lockup problem
> > > in kmemleak_scan() by periodically doing a cond_resched(). It does
> > > take a reference of the current object before doing it. Unfortunately,
> > > if the object has been deleted from the object_list, the next object
> > > pointed to by its next pointer may no longer be valid after coming
> > > back from cond_resched(). This can result in use-after-free and other
> > > nasty problem.
> > 
> > Ah, kmemleak_cond_resched() releases the rcu lock, so using
> > list_for_each_entry_rcu() doesn't help.
[...]
> > Another potential issue with re-scanning is that the loop may never
> > complete if it always goes from the beginning. Yet another problem with
> > restarting is that we may count references to an object multiple times
> > and get more false negatives.
> > 
> > I'd keep the OBJECT_ALLOCATED logic in the main kmemleak_scan() loop and
> > retake the object->lock if cond_resched() was called
> > (kmemleak_need_resched() returning true), check if it was freed and
> > restart the loop. We could add a new OBJECT_SCANNED flag so that we
> > skip such objects if we restarted the loop. The flag is reset during
> > list preparation.
[...]
> Thanks for the review. Another alternative way to handle that is to add an
> OBJECT_ANCHORED flag to indicate that this object shouldn't be deleted from
> the object list yet. Maybe also an OBJECT_DELETE_PENDING flag so that
> kmemleak_cond_resched() will delete it after returning from cond_resched()
> when set by another function that want to delete this object. All these
> checks and flag setting will be done with object lock held. How do you
> think?

I think we are over-complicating this. The problems I see with deleting
an object are that (1) only the object being deleted is locked (so that
the corresponding memory block is not freed while scanning) and (2)
kmemleak_cond_resched() releases the RCU lock briefly. A list_del_rcu()
on the object next to the one being scanned (and locked) will leave the
current object->next pointer dangling.

If we get rid of object->lock and just use kmemleak_lock instead, we can
have a big lock around the scanning, released briefly in
kmemleak_cond_resched(). A standard list_del() (not _rcu) could be run
during the resched but it also updates the current object->next. Once
the lock is re-acquired, the list traversal can continue safely. The
current object cannot be freed due to get_object(). No need for
restarting the loop.

I don't think we'd miss much in terms of scalability for a debug
feature. Object freeing already takes the kmemleak_lock, it's just that
during scanning it will have to wait for the scanning loop to release
it. We might as well release it within the loop on each iteration.

So my proposal is to replace the rcu list traversal with the classic
one and kmemleak_lock held (some functions like __find_and_get_object()
will have to skip the lock). With this in place, we can subsequently
remove all object->lock instances, just rely on the big lock (we do need
to run lockdep if we do the latter separately, some nesting is a bit
weird; my preference would be to remove the object->lock at the same
time). We still need the rcu freeing in put_object() but for a
completely different reason: the sl*b allocators don't like being called
recursively, so we just use the RCU mechanism to free the kmemleak
structures in a separate thread.

-- 
Catalin
