Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54A5BB7F7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIQLMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 07:12:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D87326EF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 04:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F8A6B80B0C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 11:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F72EC433C1;
        Sat, 17 Sep 2022 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663413152;
        bh=6zgW0jH+FYXoff9unH4qY7BhAxpjuAZOYZY6rw5rGo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kg29XTolKJSbkf5tyeOGyUift9/qaSrMMWEQhsAUJdsYrpR3ZXa60w9k5CwXZWBTL
         PaoDepwhgikAqkTqq+pRpBwQ0zuet4qO8QfvSd3wN1URFY8iKje1Q1VJq9DRWhzc8m
         IlzCuMvIn9Ev0loSj/Y6c6/P/fUwKmU4roHEHZ6yIc6MvhzHWL027rQa3rskKhW/DF
         90mjvczNVTP2XLC5uvBmIdpIUFqS6oqLlm2gnang0cFLcZ4O8xAGI+ZAO2pgfiozDQ
         i0uzWtMcn1myteXWIEYa5geMD/tP/HOeMqdfWLltQ4q3haWlgi3dhi0rXRQEVHmnia
         TRbB74lOPuD/Q==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon: rename damon_pageout_score() to damon_cold_score()
Date:   Sat, 17 Sep 2022 11:12:29 +0000
Message-Id: <20220917111230.114618-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663407558-21316-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2022 17:39:18 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> In the beginning there is only one damos_action 'DAMOS_PAGEOUT'
> that need to get the coldness score of a region for a scheme,
> which using damon_pageout_score() to do that. But now there are
> also other damos_action actions need the coldness score, so
> rename it to damon_cold_score() to make more sense.

Good idea.

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  mm/damon/ops-common.c | 2 +-
>  mm/damon/ops-common.h | 2 +-
>  mm/damon/paddr.c      | 5 ++---
>  mm/damon/vaddr.c      | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 9310df72e1c5..75409601f934 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -130,7 +130,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  	return hotness;
>  }
>  
> -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> +int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s)
>  {
>  	int hotness = damon_hot_score(c, r, s);
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 52329ff361cd..8d82d3722204 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -12,7 +12,7 @@ struct page *damon_get_page(unsigned long pfn);
>  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
>  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
>  
> -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> +int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s);
>  int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s);
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index dfeebffe82f4..e495146e49e9 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -287,11 +287,10 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
>  {
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> -		return damon_pageout_score(context, r, scheme);
> +	case DAMOS_LRU_DEPRIO:
> +		return damon_cold_score(context, r, scheme);
>  	case DAMOS_LRU_PRIO:
>  		return damon_hot_score(context, r, scheme);
> -	case DAMOS_LRU_DEPRIO:
> -		return damon_pageout_score(context, r, scheme);

I'm not a big fan of switch-case fall-through, and want to keep the order of
cases here more similar to that in damos_action definition.  Let's change only 
the function name.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index f53c2ff2bcc8..ea94e0b2c311 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -673,7 +673,7 @@ static int damon_va_scheme_score(struct damon_ctx *context,
>  
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> -		return damon_pageout_score(context, r, scheme);
> +		return damon_cold_score(context, r, scheme);
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 
> 
