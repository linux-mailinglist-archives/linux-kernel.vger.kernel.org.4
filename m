Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242D56DE14C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDKQoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDKQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC465580;
        Tue, 11 Apr 2023 09:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C6862330;
        Tue, 11 Apr 2023 16:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF3BC433EF;
        Tue, 11 Apr 2023 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681231431;
        bh=BSTpJzFM2sSLIuqjYDM9pIz7YB8NaUWK+YA4X9lnAOE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MEmtBVCgBt6BfMd7ICwytsj+rMhPRXHqqg+M7Nu2kT2gy3nETa9nQbalU0PClQJGg
         gYt8RWYGV4mvXDTjt90mMe93j/lH6Nnqx/INAw2VQML35qJYCK97n1UOVESpPN4GSf
         AtsT2t8EX9PZ/i8dK3Gw0AGPKJNzpxbMQSP+F+iTjyBOCgIaHgL9Vkdxh+cGiP19Tb
         5xO+zKC9Qynfd/OJ4GlEi9QNjermozPcNsxCMeDieDYd8a0nhK6NDSHMxA/R+7DVje
         gNpai9J8z3SMb7amNUnqj1HIZMkS3XLFRjxWhNVMW8PrPqAjjoaYmSD/BVKBdMBW+R
         VczgOYtyDFeaQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 55E3E1540478; Tue, 11 Apr 2023 09:43:51 -0700 (PDT)
Date:   Tue, 11 Apr 2023 09:43:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHi v4] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <16bb9c4c-e27b-4483-a1d4-05245b8b1a51@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230411142733.1011223-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411142733.1011223-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:27:33PM +0800, Zqiang wrote:
> Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> executed before kfree_rcu_monitor() to drain page cache, if the bnode
> structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> page cache again in kfree_rcu_monitor(), this commit add a check
> for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> if the krcp structure's->backoff_page_cache_fill is set, prevent page
> cache growing and start fill page from krcp->nr_bkv_objs, if the
> krcp->nr_bkv_objs is greater or equal to nr_pages, not alloc page,
> avoid unnecessary __get_free_page() calls.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 41daae3239b5..d5639025bd1a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2908,6 +2908,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  	struct kvfree_rcu_bulk_data *bnode)
>  {
> +	if (atomic_read(&krcp->backoff_page_cache_fill))
> +		return false;

This one is still missing the logic that allows that cache to hold
one page during low memory?  Or is that being handled somewhere else?

							Thanx, Paul

>  	// Check the limit.
>  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
>  		return false;
> @@ -3223,7 +3225,7 @@ static void fill_page_cache_func(struct work_struct *work)
>  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
>  		1 : rcu_min_cached_objs;
>  
> -	for (i = 0; i < nr_pages; i++) {
> +	for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
>  		bnode = (struct kvfree_rcu_bulk_data *)
>  			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  
> -- 
> 2.32.0
> 
