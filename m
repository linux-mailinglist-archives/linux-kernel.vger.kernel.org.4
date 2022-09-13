Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1F05B76BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIMQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiIMQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1441FCEE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E1EC614C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC37C433D6;
        Tue, 13 Sep 2022 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663083803;
        bh=Ir7P+Su2E7kZxVG0lqR6jeQUnTLGLwG/e7Tk9o9uELk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx7d1SjGZdCSQymvF7oRaHvg9q2ToarGZkooE3ffzJYQxLRoE4hBHksXnwPWR5RE9
         mOCMi18vlwfKuujUtpqR2dGUjN3c51CC++ceijwc+5kzR3/EI8CXV06Hfx7zDYITrL
         SVHuH1SQsWHNuNGa2qmrI2cu5QblVyNkwYhZvbrVHVLc08+eJNNw1z8/t57EN3o28j
         AHMYMk/XiZ04pzWpIrslD48cBUNw8nzmI/t8MSeXZwwVjHm3J3M7WMPUt5Tm7qV03y
         TsVhJ7hNrfBQaNm9NiQUnJgJgdM3sNLgxzrAP4RbGz4pmwRXMSb485OKwVm9VvfAWg
         3bZeKYi+E6eGg==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: simplify scheme create in lru_sort.c
Date:   Tue, 13 Sep 2022 15:43:21 +0000
Message-Id: <20220913154321.45954-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913152245.25224-1-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Tue, 13 Sep 2022 23:22:45 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
> they have so much in common, so we can combine them into a single
> function, and we just need to distinguish their differences.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/lru_sort.c | 82 +++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 8415e18fcf0e..62063ed43224 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -257,15 +257,15 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
>  static struct damon_ctx *ctx;
>  static struct damon_target *target;
> 
> -/* Create a DAMON-based operation scheme for hot memory regions */
> -static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
> +static inline struct damos *damon_lru_sort_new_scheme(unsigned int thres,
> +						      enum damos_action action)
>  {
>  	struct damos_access_pattern pattern = {
>  		/* Find regions having PAGE_SIZE or larger size */
>  		.min_sz_region = PAGE_SIZE,
>  		.max_sz_region = ULONG_MAX,
>  		/* and accessed for more than the threshold */
> -		.min_nr_accesses = hot_thres,
> +		.min_nr_accesses = 0,
>  		.max_nr_accesses = UINT_MAX,
>  		/* no matter its age */
>  		.min_age_region = 0,
> @@ -292,60 +292,38 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>  		.weight_age = 0,
>  	};
> 
> -	return damon_new_scheme(
> -			&pattern,
> -			/* prioritize those on LRU lists, as soon as found */
> -			DAMOS_LRU_PRIO,
> -			/* under the quota. */
> -			&quota,
> -			/* (De)activate this according to the watermarks. */
> -			&wmarks);
> +	switch (action) {
> +	case DAMOS_LRU_PRIO:
> +		pattern.min_nr_accesses = thres;
> +		break;
> +	case DAMOS_LRU_DEPRIO:
> +		pattern.min_age_region = thres;
> +		quota.weight_nr_accesses = 0;
> +		quota.weight_age = 1;
> +		break;

I would like to do this from damon_lru_sort_new_{hot,cold}_scheme() instead.

> +	default:
> +		return NULL;
> +	}
> +
> +	return damon_new_scheme(&pattern,
> +				/* mark those as not accessed, as soon as found */
> +				action,
> +				/* under the quota. */
> +				&quota,
> +				/* (De)activate this according to the watermarks. */
> +				&wmarks);
> +}
> +
> +/* Create a DAMON-based operation scheme for hot memory regions */
> +static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
> +{
> +	return damon_lru_sort_new_scheme(hot_thres, DAMOS_LRU_PRIO);
>  }
> 
>  /* Create a DAMON-based operation scheme for cold memory regions */
>  static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>  {
> -	struct damos_access_pattern pattern = {
> -		/* Find regions having PAGE_SIZE or larger size */
> -		.min_sz_region = PAGE_SIZE,
> -		.max_sz_region = ULONG_MAX,
> -		/* and not accessed at all */
> -		.min_nr_accesses = 0,
> -		.max_nr_accesses = 0,
> -		/* for min_age or more micro-seconds */
> -		.min_age_region = cold_thres,
> -		.max_age_region = UINT_MAX,
> -	};
> -	struct damos_watermarks wmarks = {
> -		.metric = DAMOS_WMARK_FREE_MEM_RATE,
> -		.interval = wmarks_interval,
> -		.high = wmarks_high,
> -		.mid = wmarks_mid,
> -		.low = wmarks_low,
> -	};
> -	struct damos_quota quota = {
> -		/*
> -		 * Do not try LRU-lists sorting of cold pages for more than
> -		 * half of quota_ms milliseconds within
> -		 * quota_reset_interval_ms.
> -		 */
> -		.ms = quota_ms / 2,
> -		.sz = 0,
> -		.reset_interval = quota_reset_interval_ms,
> -		/* Within the quota, mark colder regions not accessed first. */
> -		.weight_sz = 0,
> -		.weight_nr_accesses = 0,
> -		.weight_age = 1,
> -	};
> -
> -	return damon_new_scheme(
> -			&pattern,
> -			/* mark those as not accessed, as soon as found */
> -			DAMOS_LRU_DEPRIO,
> -			/* under the quota. */
> -			&quota,
> -			/* (De)activate this according to the watermarks. */
> -			&wmarks);
> +	return damon_lru_sort_new_scheme(cold_thres, DAMOS_LRU_DEPRIO);
>  }
> 
>  static int damon_lru_sort_apply_parameters(void)
> --
> 2.31.0

And, yes, LRU_SORT is a mess.  I'm also trying to make some cleanups like this:
https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=366451cd82e71ff0227caa0c6b7b6f9ae2659c29

I'd like to apply your patch and then rebase my cleanups on it, but it might be
not a one second work.  Could I ask you to wait until my cleanups are done?  I
will post the patches within this week.


Thanks,
SJ
