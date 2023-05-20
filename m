Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C579770A943
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjETQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C098E
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 09:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E289E60B86
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 16:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40B2C433EF;
        Sat, 20 May 2023 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684600832;
        bh=T64zNX1m7m4YFe69QC+IHxV7cY9TLku1+q52iomz1gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUxVbv260mef6o/DDZdOZdJva3acBvLV3lU3n3gEy+x82IexadqsipQvkmAAr+xVd
         Gqx4VJsuIO9pzUIgpJZHi5rUNh2xfS/29DI9Zsf6FzXEzdIAhDBtFnPZivXD5sC7aT
         oZ63UoMWlV0lHwoZ5vCe23B1+eOT4vM62EZaALDy9mYPLJeqd/VjlcKyG/fCCkfRyw
         hhumgI5XA61W57ZiKCSmz78UgS0yAm0GGiqxN3quqv+utMyrPzVnN5TK/AImLo6WZk
         BvZpIOPrEnOWut1izCrHbOBV62i1NgSZGf46HgtgpjRILSXAJg5/SOqK3RxswaDob3
         Q6qRhPzYxefXw==
Date:   Sat, 20 May 2023 09:40:30 -0700
From:   Chris Li <chrisl@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] swap: cleanup get/put_swap_device usage
Message-ID: <ZGj3/p/IFGRTBbHf@google.com>
References: <20230516052957.175432-1-ying.huang@intel.com>
 <d1b054d0-d083-d35c-e547-7e8756fd802a@redhat.com>
 <87fs7v7qmh.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs7v7qmh.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 08:23:18AM +0800, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > On 16.05.23 07:29, Huang Ying wrote:
> >> The general rule to use a swap entry is as follows.
> >> When we get a swap entry, if there isn't some other way to prevent
> >> swapoff, such as page lock for swap cache, page table lock, etc., the
> >> swap entry may become invalid because of swapoff.  Then, we need to
> >> enclose all swap related functions with get_swap_device() and
> >> put_swap_device(), unless the swap functions call
> >> get/put_swap_device() by themselves.
> >> Add the rule as comments of get_swap_device(), and cleanup some
> >> functions which call get/put_swap_device().
> >> 1. Enlarge the get/put_swap_device() protection range in
> >> __read_swap_cache_async().  This makes the function a little easier to
> >> be understood because we don't need to consider swapoff.  And this
> >> makes it possible to remove get/put_swap_device() calling in some
> >> function called by __read_swap_cache_async().
> >> 2. Remove get/put_swap_device() in __swap_count().  Which is call in
> >> do_swap_page() only, which encloses the call with get/put_swap_device()
> >> already.
> >> 3. Remove get/put_swap_device() in __swp_swapcount().  Which is call
> >> in __read_swap_cache_async() only, which encloses the call with
> >> get/put_swap_device() already.
> >> 4. Remove get/put_swap_device() in __swap_duplicate(). Which is
> >> called
> >> by
> >> - swap_shmem_alloc(): the swap cache is locked.
> >> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one()
> >> ->
> >> swap_duplicate(): the page table lock is held.
> >> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
> >> get/put_swap_device() already.
> >> Other get/put_swap_device() usages are checked too.
> >
> > I suggest splitting this patch up into logical pieces as outlined here
> > by you already.

Agree with David here.

> 
> OK.  Will do that in the next version.

Your patch make sense to me.

Looking forward to your next version.

BTW, no relat to your patch, but just when I look
at your patch I notice is that we have too many swap
count functions.
The naming scheme is very confusing.

1) swap_count(), just mask out SWAP_HAS_CACHE

2) __swap_count() the name with underscore suggest it
is more internal.  But __swap_count() calls swap_count().
It is basically swap_count() with device lookup.

3) swap_swapcount()
similar to __swap_count() but with cluster level
locking if possible. otherwise fall back to device level locking.

4) __swp_swapcount()
swap_swapcount () with device lookup.  not consider continuing.
Again this function is more external while swap_swapcount()
is more internal.

5) swp_swapcount() similar to __swp_swapcount()
exact count consider continue

We should have a more consistent naming regarding swap count.
Device level, then cluster level, then entry level.

Also I consider the continuing is internal to the current
swap index implementation. If we have alternative swap file
implementation, we might not have count continuing at all.

Chris
