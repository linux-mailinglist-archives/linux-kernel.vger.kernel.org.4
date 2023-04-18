Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662E6E55F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDRAlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912A35BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D704F62B72
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A7C433D2;
        Tue, 18 Apr 2023 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681778492;
        bh=NDF5RERKBTV++O0srQwGL0/bYyfwjsDkNiG58kuLKlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hACjk0Lz/j0DG53leFvmdfDdqQ9KUp4Z+Ou4HeMOjYhjmJaq90aSNKRNeNAJPjdEt
         BfuhYxYq3M/RoK8yHTLT6df+Ac33RHjUfyRsk+Y93zn/p7UNb6nGz9JbYJdTjPSPb7
         oxK4AIfBe0d656niLEsHioESG2gO8srcSZjwzibc=
Date:   Mon, 17 Apr 2023 17:41:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction
 context
Message-Id: <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
In-Reply-To: <20230417135420.1836741-1-senozhatsky@chromium.org>
References: <20230417135420.1836741-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 22:54:20 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> zsmalloc pool can be compacted concurrently by many contexts,
> e.g.
> 
>  cc1 handle_mm_fault()
>       do_anonymous_page()
>        __alloc_pages_slowpath()
>         try_to_free_pages()
>          do_try_to_free_pages(
>           lru_gen_shrink_node()
>            shrink_slab()
>             do_shrink_slab()
>              zs_shrinker_scan()
>               zs_compact()
> 
> This creates unnecessary contention as all those processes
> compete for access to the same classes. A single compaction
> process is enough. Moreover contention that is created by
> multiple compaction processes impact other zsmalloc functions,
> e.g. zs_malloc(), since zsmalloc uses "global" pool->lock to
> synchronize access to pool.
> 
> Introduce pool compaction mutex and permit only one compaction
> context at a time. This reduces overall pool->lock contention.

That isn't what the patch does!  Perhaps an earlier version used a mutex?

> /proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
> &pool->lock#3:
> 
>                 Base           Patched
> ------------------------------------------
> con-bounces     2035730        1540066
> contentions     2343871        1774348
> waittime-min    0.10           0.10
> waittime-max    4004216.24     2745.22
> waittime-total  101334168.29   67865414.91
> waittime-avg    43.23          38.25
> acq-bounces     2895765        2186745
> acquisitions    6247686        5136943
> holdtime-min    0.07           0.07
> holdtime-max    2605507.97     482439.16
> holdtime-total  9998599.59     5107151.01
> holdtime-avg    1.60           0.99
> 
> Test run time:
> Base
> 2775.15user 1709.13system 2:13.82elapsed 3350%CPU
> 
> Patched
> 2608.25user 1439.03system 2:03.63elapsed 3273%CPU
> 
> ...
>
> @@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
>  	struct size_class *class;
>  	unsigned long pages_freed = 0;
>  
> +	if (atomic_xchg(&pool->compaction_in_progress, 1))
> +		return 0;
> +

A code comment might be appropriate here.

Is the spin_is_contended() test in __zs_compact() still relevant?

And....  single-threading the operation seems a pretty sad way of
addressing a contention issue.  zs_compact() is fairly computationally
expensive - surely a large machine would like to be able to
concurrently run many instances of zs_compact()?
