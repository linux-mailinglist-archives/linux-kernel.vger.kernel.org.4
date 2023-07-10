Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA85374CF46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGJH6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjGJH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:58:26 -0400
Received: from out-43.mta0.migadu.com (out-43.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A634195
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:58:20 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:58:12 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVMEOtNfmrAJbNlYNLeJkpBJ86lBc5FefQaiwluDrmo=;
        b=H6ST3Ijv+TfXMWOtilgr8Ll8L0J/2ivFMLsOaSbXrc3O0IE8/Q4oBPLl/LeOy8gJB6j2lg
        rKzmVYnsjHynEBV836ohplSW+R3c8Tmt+9eYtN1BBcnzTbyFup7auNcjGPlXY7isKL09RU
        aHc1tzI1Nj1xSdtqCTLFNyTv0WgXhQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mm: memory-failure: fix race window when trying to
 get hugetlb folio
Message-ID: <20230710075812.GH1686200@ik1-406-35019.vs.sakura.ne.jp>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-9-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708085744.3599311-9-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 04:57:44PM +0800, Miaohe Lin wrote:
> page_folio() is fetched before calling get_hwpoison_hugetlb_folio()
> without hugetlb_lock being held. So hugetlb page could be demoted
> before get_hwpoison_hugetlb_folio() holding hugetlb_lock but after
> page_folio() is fetched. So get_hwpoison_hugetlb_folio() will hold
> unexpected extra refcnt of hugetlb folio while leaving demoted page
> un-refcnted.

Very nice, thank you for finding the issue.

> 
> Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 76d88d27cdbe..066bf57f2d22 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1388,8 +1388,14 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
>  	bool hugetlb = false;
>  
>  	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
> -	if (hugetlb)
> -		return ret;
> +	if (hugetlb) {
> +		if (folio == page_folio(page))
> +			return ret;

Some short comment about the race against demotion here is helpful.

Anyway, the patch looks good to me.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> +		if (ret > 0) {
> +			folio_put(folio);
> +			folio = page_folio(page);
> +		}
> +	}
>  
>  	/*
>  	 * This check prevents from calling folio_try_get() for any
> @@ -1478,8 +1484,12 @@ static int __get_unpoison_page(struct page *page)
>  	bool hugetlb = false;
>  
>  	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, true);
> -	if (hugetlb)
> -		return ret;
> +	if (hugetlb) {
> +		if (folio == page_folio(page))
> +			return ret;
> +		if (ret > 0)
> +			folio_put(folio);
> +	}
>  
>  	/*
>  	 * PageHWPoisonTakenOff pages are not only marked as PG_hwpoison,
> -- 
> 2.33.0
> 
> 
> 
