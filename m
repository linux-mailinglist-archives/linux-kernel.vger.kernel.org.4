Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6171A37B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjFAP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjFAP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:58:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26F4E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:58:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f7f864525fso9188171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685635107; x=1688227107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+efOPSQxKas75WP7TlhxEhnwgM07+GQGh73l38GMf0M=;
        b=WOtGKFfUfj263gss/jG5SRnfu4yLThBxRbobS2E9IWT4CDL04ivObj9pOmUr+XBthC
         ncBWs71xUEZtg0ESmqRbnFagwc0aCJA49sv5W6ywMG6lRYPmU/FIFflMGY50V+9L9Xps
         xROIzO9F8QVo8QrFyE2uodILmHd65z1fJ/1QhZDb6JUFaimkEU7r74ZRdod/MY6TSAgm
         EXtS42MPGONFDhpxtlt42vPa8qBM52X2f9xcIobhPrh8XFHBnOKJ2phBWf6GmCgWgrKg
         8df5qQV6mKvfZTeVKVuCoj7kIdzFjC2p2M8JhpoNeApZjC7ZcxZYxgH9WCaIXd19Wc5g
         Y0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635107; x=1688227107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+efOPSQxKas75WP7TlhxEhnwgM07+GQGh73l38GMf0M=;
        b=XsS3Va0xHK2IhU5WysTUzyez7NEEmbzX0nzoJeXobLSaE312AJ3de7qqQY3fPD9tNZ
         P9+Y+EEGm4aTYBFgRRGGyOvDGtI9Q47l4Fp+vkxlLj+zzRm04wCiKgQfpt+d7Vq198H/
         ghzC25O9k8umXd8KNTys4vFaCPattGoqAyZWwiWhc42m9n7J1G/LP0OcfesjzbL5SL9m
         WolNSPS2BOFO03c5ocMTTQA6ywl/k2UxxRbGn+VfJQCVSBCAh92yItQxb8QZQYDU29MM
         BOcCNVN64yrwCf5to+5GbC8qMnlkRPrRC1eQHWq/EDJAbMklGmBKWPiQUl1QQjOP+VWd
         7B1Q==
X-Gm-Message-State: AC+VfDxHUiVw35qhwr2I8HTdUZB2EIr6kUoqIhewsN05T5VHbHXTWEPw
        btOVCvUZtSk2QRxjpvyUyHpz0w==
X-Google-Smtp-Source: ACHHUZ7rCrxITTB/aL5ETWXQROrQsurURij9L4UceM5lkqCEdiAHax2OAz72JjKkxoLTHTRIpBhp5A==
X-Received: by 2002:ad4:5fc9:0:b0:5ef:8c79:fe92 with SMTP id jq9-20020ad45fc9000000b005ef8c79fe92mr14127895qvb.3.1685635106461;
        Thu, 01 Jun 2023 08:58:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id lw14-20020a05621457ce00b006238b37fb05sm7552557qvb.119.2023.06.01.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:58:26 -0700 (PDT)
Date:   Thu, 1 Jun 2023 11:58:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: multiple zpool support
Message-ID: <20230601155825.GF102494@cmpxchg.org>
References: <20230531022911.1168524-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531022911.1168524-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 02:29:11AM +0000, Yosry Ahmed wrote:
> Support using multiple zpools of the same type in zswap, for concurrency
> purposes. Add CONFIG_ZSWAP_NR_ZPOOLS_ORDER to control the number of
> zpools. The order is specific by the config rather than the absolute
> number to guarantee a power of 2. This is useful so that we can use
> deterministically link each entry to a zpool by hashing the zswap_entry
> pointer.
> 
> On a setup with zswap and zsmalloc, comparing a single zpool (current
> default) to 32 zpools (by setting CONFIG_ZSWAP_NR_ZPOOLS_ORDER=32) shows
> improvements in the zsmalloc lock contention, especially on the swap out
> path.
> 
> The following shows the perf analysis of the swapout path when 10
> workloads are simulatenously reclaiming and refaulting tmpfs pages.
> There are some improvements on the swapin path as well, but much less
> significant.
> 
> 1 zpool:
> 
>  |--28.99%--zswap_frontswap_store
>        |     |
>        <snip>
>        |     |
>        |     |--8.98%--zpool_map_handle
>        |     |     |
>        |     |      --8.98%--zs_zpool_map
>        |     |           |
>        |     |            --8.95%--zs_map_object
>        |     |                 |
>        |     |                  --8.38%--_raw_spin_lock
>        |     |                       |
>        |     |                        --7.39%--queued_spin_lock_slowpath
>        |     |
>        |     |--8.82%--zpool_malloc
>        |     |     |
>        |     |      --8.82%--zs_zpool_malloc
>        |     |           |
>        |     |            --8.80%--zs_malloc
>        |     |                 |
>        |     |                 |--7.21%--_raw_spin_lock
>        |     |                 |     |
>        |     |                 |      --6.81%--queued_spin_lock_slowpath
>        <snip>
> 
> 32 zpools:
> 
>  |--16.73%--zswap_frontswap_store
>        |     |
>        <snip>
>        |     |
>        |     |--1.81%--zpool_malloc
>        |     |     |
>        |     |      --1.81%--zs_zpool_malloc
>        |     |           |
>        |     |            --1.79%--zs_malloc
>        |     |                 |
>        |     |                  --0.73%--obj_malloc
>        |     |
>        |     |--1.06%--zswap_update_total_size
>        |     |
>        |     |--0.59%--zpool_map_handle
>        |     |     |
>        |     |      --0.59%--zs_zpool_map
>        |     |           |
>        |     |            --0.57%--zs_map_object
>        |     |                 |
>        |     |                  --0.51%--_raw_spin_lock
>        <snip>
> 
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/Kconfig | 12 +++++++
>  mm/zswap.c | 95 ++++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 76 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 92c30879bf67..de1da56d2c07 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -59,6 +59,18 @@ config ZSWAP_EXCLUSIVE_LOADS
>  	  The cost is that if the page was never dirtied and needs to be
>  	  swapped out again, it will be re-compressed.
>  
> +config ZSWAP_NR_ZPOOLS_ORDER
> +	int "Number of zpools in zswap, as power of 2"
> +	default 0
> +	depends on ZSWAP
> +	help
> +	  This options determines the number of zpools to use for zswap, it
> +	  will be 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER.
> +
> +	  Having multiple zpools helps with concurrency and lock contention
> +	  on the swap in and swap out paths, but uses a little bit of extra
> +	  space.

This is nearly impossible for a user, let alone a distribution, to
answer adequately.

The optimal value needs to be found empirically. And it varies heavily
not just by workload but by implementation changes. If we make changes
to the lock holding time or redo the data structures, a previously
chosen value might no longer be a net positive, and even be harmful.

Architecturally, the pool scoping and the interaction with zswap_tree
is currently a mess. We're aware of lifetime bugs, where swapoff kills
the tree but the pool still exists with entries making dead references
e.g. We likely need to rearchitect this in the near future - maybe tie
pools to trees to begin with.

(I'm assuming you're already using multiple swap files to avoid tree
lock contention, because it has the same scope as the pool otherwise.)

Such changes quickly invalidate any settings the user or distro might
make here. Exposing the implementation detail of the pools might even
get in the way of fixing bugs and cleaning up the architecture.

> @@ -263,11 +266,13 @@ static void zswap_update_total_size(void)
>  {
>  	struct zswap_pool *pool;
>  	u64 total = 0;
> +	int i;
>  
>  	rcu_read_lock();
>  
>  	list_for_each_entry_rcu(pool, &zswap_pools, list)
> -		total += zpool_get_total_size(pool->zpool);
> +		for (i = 0; i < zswap_nr_zpools; i++)
> +			total += zpool_get_total_size(pool->zpools[i]);

This adds a O(nr_pools) operation to every load and store. It's easy
for this to dominate or outweigh locking costs as workload concurrency
changes, or data structures and locking change inside the kernel.

> @@ -587,14 +603,17 @@ static void shrink_worker(struct work_struct *w)
>  {
>  	struct zswap_pool *pool = container_of(w, typeof(*pool),
>  						shrink_work);
> +	int i;
>  
> -	if (zpool_shrink(pool->zpool, 1, NULL))
> -		zswap_reject_reclaim_fail++;
> +	for (i = 0; i < zswap_nr_zpools; i++)
> +		if (zpool_shrink(pool->zpools[i], 1, NULL))
> +			zswap_reject_reclaim_fail++;
>  	zswap_pool_put(pool);

This scales reclaim batch size by the number of zpools, which can lead
to varying degrees of overreclaim especially on small zswap sizes with
high pool concurrency.

I don't think this patch is ready for primetime. A user build time
setting is not appropriate for an optimization that is heavily tied to
implementation details and workload dynamics.
