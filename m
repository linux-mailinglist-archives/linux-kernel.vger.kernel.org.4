Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D58655356
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiLWRuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLWRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:50:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21DF1B78D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:50:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C2B61919
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CD8C433EF;
        Fri, 23 Dec 2022 17:50:34 +0000 (UTC)
Date:   Fri, 23 Dec 2022 17:50:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Message-ID: <Y6XqZ8MNb3eq5gal@arm.com>
References: <20221210230048.2841047-1-longman@redhat.com>
 <20221210230048.2841047-3-longman@redhat.com>
 <Y5mwnc03h10r0rKK@arm.com>
 <b453f697-b21b-d80e-6c41-dfa260bb2220@redhat.com>
 <Y5xJOuVsQbITDq14@arm.com>
 <7ea28f11-34af-c974-94fb-7e2481942e97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea28f11-34af-c974-94fb-7e2481942e97@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:38:28AM -0500, Waiman Long wrote:
> On 12/16/22 05:32, Catalin Marinas wrote:
> > On Wed, Dec 14, 2022 at 10:54:28AM -0500, Waiman Long wrote:
> > > On 12/14/22 06:16, Catalin Marinas wrote:
> > > > On Sat, Dec 10, 2022 at 06:00:48PM -0500, Waiman Long wrote:
> > > > > Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
> > > > > object iteration loop of kmemleak_scan()") fixes soft lockup problem
> > > > > in kmemleak_scan() by periodically doing a cond_resched(). It does
> > > > > take a reference of the current object before doing it. Unfortunately,
> > > > > if the object has been deleted from the object_list, the next object
> > > > > pointed to by its next pointer may no longer be valid after coming
> > > > > back from cond_resched(). This can result in use-after-free and other
> > > > > nasty problem.
[...]
> > If we get rid of object->lock and just use kmemleak_lock instead, we can
> > have a big lock around the scanning, released briefly in
> > kmemleak_cond_resched(). A standard list_del() (not _rcu) could be run
> > during the resched but it also updates the current object->next. Once
> > the lock is re-acquired, the list traversal can continue safely. The
> > current object cannot be freed due to get_object(). No need for
> > restarting the loop.
> 
> The problem with a big lock (kmemleak_lock) is that we will be disabing
> interrupt for an extended period of time which is not ideal.

We do this already during scanning - scan_block() takes the
kmemleak_lock as this protects the rb tree. We just need to take this
lock at a higher level in scan_gray_list() but we can still release it
in the loop as before, at least each iteration (even multiple times in
an iteration if scan_block() takes longer).

> I have posted a v2 patch that drop the idea of restarting the loop. Instead,
> I just block the current object from being removed from the object_list to
> make sure its next pointer will point to a valid object.

I haven't got around to look at that yet. Still trying to see if we can
simplify the locking here without a significant effect on latency.

> > I don't think we'd miss much in terms of scalability for a debug
> > feature. Object freeing already takes the kmemleak_lock, it's just that
> > during scanning it will have to wait for the scanning loop to release
> > it. We might as well release it within the loop on each iteration.
> > 
> > So my proposal is to replace the rcu list traversal with the classic
> > one and kmemleak_lock held (some functions like __find_and_get_object()
> > will have to skip the lock). With this in place, we can subsequently
> > remove all object->lock instances, just rely on the big lock (we do need
> > to run lockdep if we do the latter separately, some nesting is a bit
> > weird; my preference would be to remove the object->lock at the same
> > time). We still need the rcu freeing in put_object() but for a
> > completely different reason: the sl*b allocators don't like being called
> > recursively, so we just use the RCU mechanism to free the kmemleak
> > structures in a separate thread.
> 
> That was what I thought about when you said you wanted to use a big lock
> instead of object->lock in the last email. As I said above, we can't hold
> the kmemleak_lock with interrupt disabled for an extended period of time
> especially if RT tasks are running. So we may need to release the lock
> frequently like per dozen objects or so. I believe we still need
> rcu_read_lock() just to be safe.

Yes, that's what I had in mind, release the lock very often but use a
non-RCU traversal mechanism that updates list_head.next.

Yet another option would be to do a quick traversal at the beginning of
kmemleak_scan() to only do a get_object(). Once the use_count is
increased, they won't be freed. Of course, it needs another walk at the
end of the scanning to do the put_object().

I'll have a look at your v2 as well, though most likely early in
January.

-- 
Catalin
