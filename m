Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1F70B2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjEVB2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjEVB2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:28:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEBAC1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684718889; x=1716254889;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QyQJCN5elPlHL3m/otcd0ae3nywiqlEjaHw9qMhPzo0=;
  b=Fmq4enLSZ97IILq7riaE4Bk3/SzOMbIdWDotGV/nj+sNIi7vmIG+pEmx
   kO6nZg5lshHCVxToVknISHp++arKdymBDjXK5cvG3x/lT/r396lw1c5Tu
   fprqcao56/0acANR1mJJ3ETWUyOqSXJH12r2oAeGfJk2VMpefREpmdzA+
   sH6s8sMtLMsnUiuZo21ORPG2xrKacoI+GdhEojq+yg8G+VvwR7A8Ehbwh
   6PSqdtIvRz9Se39+PzCVyaaRZU5tWx+ccIpzxsM8iLv7HlCTBnx95F76U
   OFay9ysEEtuZiAEXJ4Q8leVcHEs519ajGk2CRwJCQ8Wxh5cMRTJaFVfWM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="333165986"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="333165986"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 18:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="768325617"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="768325617"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 18:28:06 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chris Li <chrisl@kernel.org>
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
References: <20230516052957.175432-1-ying.huang@intel.com>
        <d1b054d0-d083-d35c-e547-7e8756fd802a@redhat.com>
        <87fs7v7qmh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZGj3/p/IFGRTBbHf@google.com>
Date:   Mon, 22 May 2023 09:26:46 +0800
In-Reply-To: <ZGj3/p/IFGRTBbHf@google.com> (Chris Li's message of "Sat, 20 May
        2023 09:40:30 -0700")
Message-ID: <87ilcl2m21.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> writes:

> On Wed, May 17, 2023 at 08:23:18AM +0800, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>> > On 16.05.23 07:29, Huang Ying wrote:
>> >> The general rule to use a swap entry is as follows.
>> >> When we get a swap entry, if there isn't some other way to prevent
>> >> swapoff, such as page lock for swap cache, page table lock, etc., the
>> >> swap entry may become invalid because of swapoff.  Then, we need to
>> >> enclose all swap related functions with get_swap_device() and
>> >> put_swap_device(), unless the swap functions call
>> >> get/put_swap_device() by themselves.
>> >> Add the rule as comments of get_swap_device(), and cleanup some
>> >> functions which call get/put_swap_device().
>> >> 1. Enlarge the get/put_swap_device() protection range in
>> >> __read_swap_cache_async().  This makes the function a little easier to
>> >> be understood because we don't need to consider swapoff.  And this
>> >> makes it possible to remove get/put_swap_device() calling in some
>> >> function called by __read_swap_cache_async().
>> >> 2. Remove get/put_swap_device() in __swap_count().  Which is call in
>> >> do_swap_page() only, which encloses the call with get/put_swap_device()
>> >> already.
>> >> 3. Remove get/put_swap_device() in __swp_swapcount().  Which is call
>> >> in __read_swap_cache_async() only, which encloses the call with
>> >> get/put_swap_device() already.
>> >> 4. Remove get/put_swap_device() in __swap_duplicate(). Which is
>> >> called
>> >> by
>> >> - swap_shmem_alloc(): the swap cache is locked.
>> >> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one()
>> >> ->
>> >> swap_duplicate(): the page table lock is held.
>> >> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>> >> get/put_swap_device() already.
>> >> Other get/put_swap_device() usages are checked too.
>> >
>> > I suggest splitting this patch up into logical pieces as outlined here
>> > by you already.
>
> Agree with David here.
>
>> 
>> OK.  Will do that in the next version.
>
> Your patch make sense to me.
>
> Looking forward to your next version.
>
> BTW, no relat to your patch, but just when I look
> at your patch I notice is that we have too many swap
> count functions.
> The naming scheme is very confusing.
>
> 1) swap_count(), just mask out SWAP_HAS_CACHE
>
> 2) __swap_count() the name with underscore suggest it
> is more internal.  But __swap_count() calls swap_count().
> It is basically swap_count() with device lookup.
>
> 3) swap_swapcount()
> similar to __swap_count() but with cluster level
> locking if possible. otherwise fall back to device level locking.
>
> 4) __swp_swapcount()
> swap_swapcount () with device lookup.  not consider continuing.
> Again this function is more external while swap_swapcount()
> is more internal.
>
> 5) swp_swapcount() similar to __swp_swapcount()
> exact count consider continue
>
> We should have a more consistent naming regarding swap count.
> Device level, then cluster level, then entry level.

Yes.  The original naming is confusing.

> Also I consider the continuing is internal to the current
> swap index implementation. If we have alternative swap file
> implementation, we might not have count continuing at all.

There's some difficulties to hide continuation completely.  For example,
we want to call add_swap_count_continuation() in non-atomic context in
copy_pte_range(), while the fast path calls swap_duplicate() in atomic
context (via copy_nonpresent_pte()).

Best Regards,
Huang, Ying
