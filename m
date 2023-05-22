Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903E270BCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjEVMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjEVMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9B3E5F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684756900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDKkkJybZkdB248LiI2tddkIKMk+rLw6Jh9QgioQ6ws=;
        b=ZmgHzNeOGDQHtx1hHKkqcu+NP2hSRFtnbpbxbc7mxuaaOpIOKqM//a+o6VeY5CgxVFnKfA
        GQb+FkVESMeEuwkYmSCUoBomarbS9FQPQyFhoWc0079T5plhGfx2rFPgssn0hcFdKVLnA7
        jNUFjoNGn9lCPifcewdsbJR0RmBXIRw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-RtKnx_O1MVeP-NoplU3KUw-1; Mon, 22 May 2023 08:01:38 -0400
X-MC-Unique: RtKnx_O1MVeP-NoplU3KUw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42d18a079so32378205e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684756894; x=1687348894;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDKkkJybZkdB248LiI2tddkIKMk+rLw6Jh9QgioQ6ws=;
        b=U5HUSgoUrR3KdNM2xb5hUEGz+Z4UlnIiqTn1+yTVOkEc9iP/f9bTMe8hK6DVYo3PPi
         +e+NoGlwAc6Tx2n1gUcTwGP45xB3AkZhRYlRc00aTDHtYQESDGpHAB7HWNHvoBPdDrb6
         oJI15NealJla+MZpUXqBYBl3mfcKYFxj14CSv0Bdfdab9Olgj6Zwc1o6cyETK2Qr2a4e
         fd/mZQSxYgfCBUxLLfad+Fq9lZQKh52lNKFcLWN3YFVk9D6+t5If6au6MohunUVNsE+a
         iiCHj3trJP0OzZc+a8l2md2e8i01aD7Pmakqvaciw+3uLSOXi8kxxoQ53g54WFyFpwCd
         rF3Q==
X-Gm-Message-State: AC+VfDx7QFjOsTaGBrDJfzaxFdNPt0lABdNIM73qSGkIH1c7kDK/GKEH
        JZdi6p17bNx45qziYelX2lZh0bq58xC6IZbzDXmyYx/hpJsPAQcYg7PpYSA355LO1roJCTENCB1
        YyMudrjK9l0dIVEAnFRVct5XBKv8OLl3O
X-Received: by 2002:a5d:6547:0:b0:306:3ded:2bf1 with SMTP id z7-20020a5d6547000000b003063ded2bf1mr7769256wrv.60.1684756894304;
        Mon, 22 May 2023 05:01:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Rc7UVWcQtSjc1UnoxyFdbPKroyaqq11y7Janfx/1SJ/bHgF6Tf33aZG2l+aCwsklb/T1wOg==
X-Received: by 2002:a5d:6547:0:b0:306:3ded:2bf1 with SMTP id z7-20020a5d6547000000b003063ded2bf1mr7769237wrv.60.1684756893920;
        Mon, 22 May 2023 05:01:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id i12-20020adffc0c000000b003063db8f45bsm7487682wrr.23.2023.05.22.05.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 05:01:33 -0700 (PDT)
Message-ID: <653a4881-d17b-6d8e-8066-300c0497a702@redhat.com>
Date:   Mon, 22 May 2023 14:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V2 2/5] swap, __read_swap_cache_async(): enlarge
 get/put_swap_device protection range
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
References: <20230522070905.16773-1-ying.huang@intel.com>
 <20230522070905.16773-3-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522070905.16773-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 09:09, Huang Ying wrote:
> This makes the function a little easier to be understood because we
> don't need to consider swapoff.  And this makes it possible to remove
> get/put_swap_device() calling in some functions called by
> __read_swap_cache_async().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>   mm/swap_state.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index b76a65ac28b3..a1028fe7214e 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -417,9 +417,13 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   {
>   	struct swap_info_struct *si;
>   	struct folio *folio;
> +	struct page *page;
>   	void *shadow = NULL;
>   
>   	*new_page_allocated = false;
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return NULL;
>   
>   	for (;;) {
>   		int err;
> @@ -428,14 +432,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   		 * called after swap_cache_get_folio() failed, re-calling
>   		 * that would confuse statistics.
>   		 */
> -		si = get_swap_device(entry);
> -		if (!si)
> -			return NULL;
>   		folio = filemap_get_folio(swap_address_space(entry),
>   						swp_offset(entry));
> -		put_swap_device(si);
> -		if (!IS_ERR(folio))
> -			return folio_file_page(folio, swp_offset(entry));
> +		if (!IS_ERR(folio)) {
> +			page = folio_file_page(folio, swp_offset(entry));
> +			goto got_page;
> +		}
>   
>   		/*
>   		 * Just skip read ahead for unused swap slot.
> @@ -445,8 +447,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   		 * as SWAP_HAS_CACHE.  That's done in later part of code or
>   		 * else swap_off will be aborted if we return NULL.
>   		 */
> -		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
> -			return NULL;
> +		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
> +			goto fail;
>   
>   		/*
>   		 * Get a new page to read into from swap.  Allocate it now,
> @@ -455,7 +457,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   		 */
>   		folio = vma_alloc_folio(gfp_mask, 0, vma, addr, false);
>   		if (!folio)
> -			return NULL;
> +                        goto fail;
>   
>   		/*
>   		 * Swap entry may have been freed since our caller observed it.
> @@ -466,7 +468,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   
>   		folio_put(folio);
>   		if (err != -EEXIST)
> -			return NULL;
> +			goto fail;
>   
>   		/*
>   		 * We might race against __delete_from_swap_cache(), and
> @@ -500,12 +502,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   	/* Caller will initiate read into locked folio */
>   	folio_add_lru(folio);
>   	*new_page_allocated = true;
> -	return &folio->page;
> +	page = &folio->page;
> +got_page:
> +	put_swap_device(si);
> +	return page;
>   
>   fail_unlock:
>   	put_swap_folio(folio, entry);
>   	folio_unlock(folio);
>   	folio_put(folio);
> +fail:

Maybe better "fail_put_swap".

We now hold the swap device ref longer than we used to, prevent swapoff 
over the whole operation. I guess there is no way we can deadlock this way?

In general, looks good to me.

-- 
Thanks,

David / dhildenb

