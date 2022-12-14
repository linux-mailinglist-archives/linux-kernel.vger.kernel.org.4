Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA864C7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiLNLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLNLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:16:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85117E1E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:16:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CCB619B6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7BAC433EF;
        Wed, 14 Dec 2022 11:16:48 +0000 (UTC)
Date:   Wed, 14 Dec 2022 11:16:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Message-ID: <Y5mwnc03h10r0rKK@arm.com>
References: <20221210230048.2841047-1-longman@redhat.com>
 <20221210230048.2841047-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210230048.2841047-3-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 06:00:48PM -0500, Waiman Long wrote:
> Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first
> object iteration loop of kmemleak_scan()") fixes soft lockup problem
> in kmemleak_scan() by periodically doing a cond_resched(). It does
> take a reference of the current object before doing it. Unfortunately,
> if the object has been deleted from the object_list, the next object
> pointed to by its next pointer may no longer be valid after coming
> back from cond_resched(). This can result in use-after-free and other
> nasty problem.

Ah, kmemleak_cond_resched() releases the rcu lock, so using
list_for_each_entry_rcu() doesn't help.

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 8c44f70ed457..d3a8fa4e3af3 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1465,15 +1465,26 @@ static void scan_gray_list(void)
>   * that the given object won't go away without RCU read lock by performing a
>   * get_object() if necessaary.
>   */
> -static void kmemleak_cond_resched(struct kmemleak_object *object)
> +static void kmemleak_cond_resched(struct kmemleak_object **pobject)
>  {
> -	if (!get_object(object))
> +	struct kmemleak_object *obj = *pobject;
> +
> +	if (!(obj->flags & OBJECT_ALLOCATED) || !get_object(obj))
>  		return;	/* Try next object */

I don't think we can rely on obj->flags without holding obj->lock. We do
have a few WARN_ON() checks without the lock but in all other places the
lock should be held.

Another potential issue with re-scanning is that the loop may never
complete if it always goes from the beginning. Yet another problem with
restarting is that we may count references to an object multiple times
and get more false negatives.

I'd keep the OBJECT_ALLOCATED logic in the main kmemleak_scan() loop and
retake the object->lock if cond_resched() was called
(kmemleak_need_resched() returning true), check if it was freed and
restart the loop. We could add a new OBJECT_SCANNED flag so that we
skip such objects if we restarted the loop. The flag is reset during
list preparation.

I wonder whether we actually need the cond_resched() in the first loop.
It does take a lot of locks but it doesn't scan the objects. I had a
patch around to remove the fine-grained locking in favour of the big
kmemleak_lock, it would make this loop faster (not sure what happened to
that patch, I need to dig it out).

-- 
Catalin
