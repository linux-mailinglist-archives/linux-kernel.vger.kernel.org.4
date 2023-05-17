Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86700705BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEQAY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEQAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:24:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978740DF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684283093; x=1715819093;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VHJgDotmM1YR6FyBhX/3Ob5tky0kjCc7LZ41KEmsRc0=;
  b=SLRXDMH07iivWmB+iIoOcPFSyYGT2F6r8zsNqfwKu1nJVYrAAPPBTh4T
   W0Fjv7tKYWrMQSmOaob7Ne8Kap9vU++XgtnJRjgPevHb6MT5AmSGyyUYB
   bxzQ+ZIy3Gq0pEm0/3wAcTEAglFdtxI0P9u01whnohAZ43bT9eiPSo0fe
   BX6i9x0UzwP285m6GbM4x6xSksBFrdBAEVz3uKsD0KuZHsK7YwpOhcjGM
   OYJV32dMunRnDA32AuQHx0t79wfWg9tM1IMNrFuueSEiNOr8kf7vtV8pK
   /KAMnyCWdg0Bk90UC6EfFosptwg+I3/3hyANahAk3UF8NeIujra2CwclS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="349125529"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="349125529"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="732181480"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="732181480"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:24:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Date:   Wed, 17 May 2023 08:23:18 +0800
In-Reply-To: <d1b054d0-d083-d35c-e547-7e8756fd802a@redhat.com> (David
        Hildenbrand's message of "Tue, 16 May 2023 13:06:03 +0200")
Message-ID: <87fs7v7qmh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 16.05.23 07:29, Huang Ying wrote:
>> The general rule to use a swap entry is as follows.
>> When we get a swap entry, if there isn't some other way to prevent
>> swapoff, such as page lock for swap cache, page table lock, etc., the
>> swap entry may become invalid because of swapoff.  Then, we need to
>> enclose all swap related functions with get_swap_device() and
>> put_swap_device(), unless the swap functions call
>> get/put_swap_device() by themselves.
>> Add the rule as comments of get_swap_device(), and cleanup some
>> functions which call get/put_swap_device().
>> 1. Enlarge the get/put_swap_device() protection range in
>> __read_swap_cache_async().  This makes the function a little easier to
>> be understood because we don't need to consider swapoff.  And this
>> makes it possible to remove get/put_swap_device() calling in some
>> function called by __read_swap_cache_async().
>> 2. Remove get/put_swap_device() in __swap_count().  Which is call in
>> do_swap_page() only, which encloses the call with get/put_swap_device()
>> already.
>> 3. Remove get/put_swap_device() in __swp_swapcount().  Which is call
>> in __read_swap_cache_async() only, which encloses the call with
>> get/put_swap_device() already.
>> 4. Remove get/put_swap_device() in __swap_duplicate(). Which is
>> called
>> by
>> - swap_shmem_alloc(): the swap cache is locked.
>> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one()
>> ->
>> swap_duplicate(): the page table lock is held.
>> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>> get/put_swap_device() already.
>> Other get/put_swap_device() usages are checked too.
>
> I suggest splitting this patch up into logical pieces as outlined here
> by you already.

OK.  Will do that in the next version.

Best Regards,
Huang, Ying
