Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AB5BCCB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiISNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiISNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:16:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2522296
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:16:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jm11so27838726plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VSUTTuBtczOK0dusiAERizvPFnsTvHA+wMPPrDEBhnI=;
        b=QJCmFKIIyxpHeniueWZ2Tv+at8cKXHPCC5ScaVf69+guJLWX9NsepszEC8SxslbQDV
         jdO2G4ofc9R0MBwfF9uLB6EZ/MS0baLvmH+DnMCgQddH5zbKUhgJ1gmDNLK+Sng6LAOW
         sIo4n3bYTOqOkyUEX3XaWfofaUuKQuBm4FXr+VTWvJOfzfX8DzXd0q3lUfDEsiZV2NqZ
         59K0GFy4n7kOYVoz2QQcYH43ZiqwSb0Pk0WpP9pe2FIc/NEfrUoPlJlcuz+UdaCrY5ht
         VBwlX6KjiYL/hxNMM9RXM/cVa+VjbJKz2wXtYiWlfU094mr736SzGTxqv5o6PHkztek9
         1tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VSUTTuBtczOK0dusiAERizvPFnsTvHA+wMPPrDEBhnI=;
        b=rbccg6WB512+uKZljpLmbUc+fWH033RWO97ryS2D+fKjN7Y/eNNsdb71f+VSVQytMd
         YtmSVQ1OZWCOuB5JOWBgnztra+zmrQszsklgmTOujqxbYJBe44QOM7xSN6mALvG6GzFn
         bdbLPTQbHp0Wt5X9zR9PrWmo4zlVlOTK9BIkra0y5MKtiUUdvq1io1iDI7zpJUOdJsyl
         7uwLh/wHrVZWIvDodg0uGSn01AqDLiOKOdK6fTZS3jn6difanMjf+jsvDc/LvB08Qlg+
         G5vOe5zpPtrL75tKKbLojuaIF3pmaNDtC5fWji1hZAVjiWbDROIOpdUMli5UC9Jqe/Zc
         MMyA==
X-Gm-Message-State: ACrzQf284tGbYwhYc3TpGwNTa9A0oLaUf/ivZEDBiCDzhk+toonJr1GO
        doY6TGxYdRk0hzf/egFxuIU=
X-Google-Smtp-Source: AMsMyM6IASeXmQ3l3P+K47bKKt+cvumIy2sbCsxVZvlVL37ZzO+KA+E+zXnH1QB0tR2slCp41/Pubg==
X-Received: by 2002:a17:90b:3b8e:b0:202:6f3d:539e with SMTP id pc14-20020a17090b3b8e00b002026f3d539emr29875176pjb.205.1663593385609;
        Mon, 19 Sep 2022 06:16:25 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a170d00b002037a4e913bsm3874336pjd.44.2022.09.19.06.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:16:25 -0700 (PDT)
Date:   Mon, 19 Sep 2022 22:16:17 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: move PG_slab flag to page_type
Message-ID: <YyhroRoWrQlmGdGu@hyeyoo>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919125708.276864-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:57:08PM +0900, Hyeonggon Yoo wrote:
> For now, only SLAB uses _mapcount field as a number of active objects in
> a slab, and other slab allocators do not use it. As 16 bits are enough
> for that, use remaining 16 bits of _mapcount as page_type even when
> SLAB is used. And then move PG_slab flag to page_type!
> 
> Note that page_type is always placed in upper 16 bits of _mapcount to
> avoid confusing normal _mapcount as page_type. As underflow (actually
> I mean, yeah, overflow) is not a concern anymore, use more lower bits
> except bit zero.
> 
> Add more folio helpers for PAGE_TYPE_OPS() not to break existing
> slab implementations.
> 
> Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
> check if _mapcount is properly set at free.
> 
> Exclude PG_slab from hwpoison and show_page_flags() for now.
> 
> Note that with this patch, page_mapped() and folio_mapped() always return
> false for slab page.
> 

[...]

Hi. a silly mistake:

> 
>  include/linux/mm_types.h       | 22 +++++++--
>  include/linux/page-flags.h     | 83 ++++++++++++++++++++++++++--------
>  include/trace/events/mmflags.h |  1 -
>  mm/memory-failure.c            |  8 ----
>  mm/slab.h                      | 11 ++++-
>  5 files changed, 92 insertions(+), 33 deletions(-)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index cf97f3884fda..4b217c6fbe1f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -193,12 +193,24 @@ struct page {
>  		atomic_t _mapcount;
>  
>  		/*
> -		 * If the page is neither PageSlab nor mappable to userspace,
> -		 * the value stored here may help determine what this page
> -		 * is used for.  See page-flags.h for a list of page types
> -		 * which are currently stored here.
> +		 * If the page is not mappable to userspace, the value
> +		 * stored here may help determine what this page is used for.
> +		 * See page-flags.h for a list of page types which are currently
> +		 * stored here.
>  		 */
> -		unsigned int page_type;
> +		struct {
> +			/*
> +			 * Always place page_type in
> +			 * upper 16 bits of _mapcount
> +			 */
> +#ifdef CPU_BIG_ENDIAN

s/CPU_BIG_ENDIAN/CONFIG_CPU_BIG_ENDIAN/g

> +			__u16 page_type;
> +			__u16 active;
> +#else
> +			__u16 active;
> +			__u16 page_type;
> +#endif
> +		};
>  	};
>  
>  	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */

[...]

> diff --git a/mm/slab.h b/mm/slab.h
> index 985820b9069b..a5273e189265 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -20,7 +20,16 @@ struct slab {
>  		};
>  		struct rcu_head rcu_head;
>  	};
> -	unsigned int active;
> +	struct {
> +		/* always place page_type in upper 16 bits of _mapcount */
> +#ifdef CPU_BIG_ENDIAN

same here.

> +		__u16 page_type;
> +		__u16 active;
> +#else
> +		__u16 active;
> +		__u16 page_type;
> +#endif
> +	};
>  
>  #elif defined(CONFIG_SLUB)
>  
> -- 
> 2.32.0
> 

-- 
Thanks,
Hyeonggon
