Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24976E7784
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjDSKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjDSKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:36:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550D5FD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:36:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D54021FD8A;
        Wed, 19 Apr 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681900601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdyX8kI8XXJB7Kozt+QOaoi6TEEVqf68DYnEw4ZZsqY=;
        b=W74GjSFR7Wm1d017njf6UREeGFnxEc/fiTELUNeWmtZPztZH3rcROXlWK9l4hawgFp6176
        4p7Msg8bDOUncaF0oxGgio/4sRop1XsV2JhCatXa9uZ164CtC9IKp7lDlk/myqMQ5iX+ZX
        pLvh21Je8lwcLv+upRhhhmXsMc0D4Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681900601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdyX8kI8XXJB7Kozt+QOaoi6TEEVqf68DYnEw4ZZsqY=;
        b=3mfp79+Sn57/jWe3/FRLjCb/RaavWS5YvogdwU2XPRDDkYaSC2IDax2RUk6QDMPDh5MfsY
        VX1Jh2ShqTyuGEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB2391390E;
        Wed, 19 Apr 2023 10:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KWOUKDnEP2SlMgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Apr 2023 10:36:41 +0000
Message-ID: <804dd674-6078-7455-8dda-1bd921bed828@suse.cz>
Date:   Wed, 19 Apr 2023 12:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230418191313.268131-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 21:12, Johannes Weiner wrote:
> pageblock_order can be of various sizes, depending on configuration,
> but the default is MAX_ORDER-1. Given 4k pages, that comes out to
> 4M. This is a large chunk for the allocator/reclaim/compaction to try
> to keep grouped per migratetype. It's also unnecessary as the majority
> of higher order allocations - THP and slab - are smaller than that.

Well in my experience the kernel usually has hugetlbfs config-enabled so it
uses 2MB pageblocks (on x86) even if hugetlbfs is unused at runtime and THP
is used instead. But sure, we can set a better default that's not tied to
hugetlbfs.

> Before subsequent patches increase the effort that goes into
> maintaining migratetype isolation, it's important to first set the
> defrag block size to what's likely to have common consumers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/pageblock-flags.h | 4 ++--
>  mm/page_alloc.c                 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index 5f1ae07d724b..05b6811f8cee 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -47,8 +47,8 @@ extern unsigned int pageblock_order;
>  
>  #else /* CONFIG_HUGETLB_PAGE */
>  
> -/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
> -#define pageblock_order		(MAX_ORDER-1)
> +/* Manage fragmentation at the 2M level */
> +#define pageblock_order		ilog2(2U << (20 - PAGE_SHIFT))
>  
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ac03571e0532..5e04a69f6a26 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7634,7 +7634,7 @@ static inline void setup_usemap(struct zone *zone) {}
>  /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
>  void __init set_pageblock_order(void)
>  {
> -	unsigned int order = MAX_ORDER - 1;
> +	unsigned int order = ilog2(2U << (20 - PAGE_SHIFT));
>  
>  	/* Check that pageblock_nr_pages has not already been setup */
>  	if (pageblock_order)

