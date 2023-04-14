Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237306E1AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNDKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNDKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:10:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AD919C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681441838; x=1712977838;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=dYWvX9si8ZEdJHGpbENtp+EkLrXzXwd/Hz+e5Z7kfxg=;
  b=IMWNS8srESToSj83+nvTIbp8ZnZNj/ihufgNPm8hHsmWBVkhg9Raoibs
   CJqbGJxhrFO2GH4JwXxjsV5rE4QTkoLCdxXH+8k3jqcsVP/PTOsCnfTb8
   QeT8KrbgNdYSMaCoIIM/7SPNU7bbKTtc6ofYD7mg51pCP/EDBHHyJRydY
   2OhGtkCrD50loc38H/VGD6e+Lks0+Ha3BmV3tqo/fuKW7CujP7C8E9dl8
   Nfhot7BwYpx6WGHpAmtJRhel1dLhYbxkl4t4T8gCr8yQtvDUwpAUCzxPg
   3YukBEFGO8MiswTY8VLKJ7CjEHK84VHGvNH7Ob83Sz184mSDdgdGKBDQC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341870043"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="341870043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 20:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="801027586"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="801027586"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 20:10:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
Date:   Fri, 14 Apr 2023 11:09:26 +0800
In-Reply-To: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
        (Douglas Anderson's message of "Thu, 13 Apr 2023 18:23:15 -0700")
Message-ID: <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> writes:

> Currently when we try to do page migration and we're in "synchronous"
> mode (and not doing direct compaction) then we'll wait an infinite
> amount of time for a page lock. This does not appear to be a great
> idea.
>
> One issue can be seen when I put a device under extreme memory
> pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
> swap). I ran the browser along with Android (which runs from a
> loopback mounted 128K block-size squashfs "disk"). I then manually ran
> the mmm_donut memory pressure tool [1]. The system is completely
> unusable both with and without this patch since there are 8 processes
> completely thrashing memory, but it was still interesting to look at
> how migration was behaving. I put some timing code in and I could see
> that we sometimes waited over 25 seconds (in the context of
> kcompactd0) for a page lock to become available. Although the 25
> seconds was the high mark, it was easy to see tens, hundreds, or
> thousands of milliseconds spent waiting on the lock.
>
> Instead of waiting, if I bailed out right away (as this patch does), I
> could see kcompactd0 move forward to successfully to migrate other
> pages instead. This seems like a better use of kcompactd's time.
>
> Thus, even though this didn't make the system any more usable in my
> absurd test case, it still seemed to make migration behave better and
> that feels like a win. It also makes the code simpler since we have
> one fewer special case.

TBH, the test case is too extreme for me.

And, we have multiple "sync" mode to deal with latency requirement, for
example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
latency.  If you have latency requirement for some users, you may
consider to add new "sync" mode.

Best Regards,
Huang, Ying

> The second issue that this patch attempts to fix is one that I haven't
> managed to reproduce yet. We have crash reports from the field that
> report that kcompactd0 was blocked for more than ~120 seconds on this
> exact lock. These crash reports are on devices running older kernels
> (5.10 mostly). In most of these crash reports the device is under
> memory pressure and many tasks were blocked in squashfs code, ext4
> code, or memory allocation code. While I don't know if unblocking
> kcompactd would actually have helped relieve the memory pressure, at
> least there was a chance that it could have helped a little bit.
>
> [1] https://chromium.googlesource.com/chromiumos/platform/microbenchmarks/+/refs/heads/main/mmm_donut.py
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  mm/migrate.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index db3f154446af..dfb0a6944181 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1143,26 +1143,15 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>  	dst->private = NULL;
>  
>  	if (!folio_trylock(src)) {
> -		if (mode == MIGRATE_ASYNC)
> -			goto out;
> -
>  		/*
> -		 * It's not safe for direct compaction to call lock_page.
> -		 * For example, during page readahead pages are added locked
> -		 * to the LRU. Later, when the IO completes the pages are
> -		 * marked uptodate and unlocked. However, the queueing
> -		 * could be merging multiple pages for one bio (e.g.
> -		 * mpage_readahead). If an allocation happens for the
> -		 * second or third page, the process can end up locking
> -		 * the same page twice and deadlocking. Rather than
> -		 * trying to be clever about what pages can be locked,
> -		 * avoid the use of lock_page for direct compaction
> -		 * altogether.
> +		 * While there are some modes we could be running in where we
> +		 * could block here waiting for the lock (specifically
> +		 * modes other than MIGRATE_ASYNC and when we're not in
> +		 * direct compaction), it's not worth the wait. Instead of
> +		 * waiting, we'll bail. This will let the caller try to
> +		 * migrate some other pages that aren't contended.
>  		 */
> -		if (current->flags & PF_MEMALLOC)
> -			goto out;
> -
> -		folio_lock(src);
> +		goto out;
>  	}
>  	locked = true;
