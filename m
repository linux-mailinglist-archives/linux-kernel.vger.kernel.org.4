Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363846DCE28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDJXfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC6185;
        Mon, 10 Apr 2023 16:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7220761982;
        Mon, 10 Apr 2023 23:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD12C433EF;
        Mon, 10 Apr 2023 23:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681169699;
        bh=FCDVQiK/WUm1WPDlCxcSnDSPyEfQ3zafLdbSMLvTnGM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gl6yNMDArz7FY/iRC8A/Yq56qpvmFGFGv8QAAldCrSnlezdgBt7Q4y31FGgMEuo77
         aUgxjxVLgU7wTRntn5ockwsYf0zrGowym6qBvZR59Pq5vRSGntecRuhqlBGMrO7UE2
         pEIEoHIZqIMHfX8XjIztjHR1btuDNK5GukDlNkiGFHfAFrBTFuOuA00DSAAGJwc9my
         4kjnb/4ZLkDpOcUGXcOqqLliM54hjNYuG7YOFJpJfs/LdzyvKE/kQAc8CTzoeQILyY
         CE1VSejtXrkVgg2zSG91CpM4W6ljKGYFcwYIW4LWSu4MTnM9gFUczeGAmXC9zKZGm3
         4lYLMm06si4DA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5E9871540478; Mon, 10 Apr 2023 16:34:59 -0700 (PDT)
Date:   Mon, 10 Apr 2023 16:34:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408142517.800549-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 10:25:17PM +0800, Zqiang wrote:
> Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> executed before kfree_rcu_monitor() to drain page cache, if the bnode
> structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> page cache again in kfree_rcu_monitor(), this commit add a check
> for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> if the krcp structure's->backoff_page_cache_fill is set, prevent page
> cache growing and disable allocated page in fill_page_cache_func().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Much improved!  But still some questions below...

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cc34d13be181..9d9d3772cc45 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2908,6 +2908,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  	struct kvfree_rcu_bulk_data *bnode)
>  {
> +	if (atomic_read(&krcp->backoff_page_cache_fill))
> +		return false;

This will mean that under low-memory conditions, we will keep zero
pages in ->bkvcache.  All attempts to put something there will fail.

This is probably not an issue for structures containing an rcu_head
that are passed to kfree_rcu(p, field), but doesn't this mean that
kfree_rcu_mightsleep() unconditionally invokes synchronize_rcu()?
This could seriously slow up freeing under low-memory conditions,
which might exacerbate the low-memory conditions.

Is this really what we want?  Zero cached rather than just fewer cached?

>  	// Check the limit.
>  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
>  		return false;
> @@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
>  	int i;
>  
>  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> -		1 : rcu_min_cached_objs;
> +		0 : rcu_min_cached_objs;
>  
>  	for (i = 0; i < nr_pages; i++) {

I am still confused as to why we start "i" at zero rather than at
->nr_bkv_objs.  What am I missing here?

>  		bnode = (struct kvfree_rcu_bulk_data *)
> -- 
> 2.32.0
> 
