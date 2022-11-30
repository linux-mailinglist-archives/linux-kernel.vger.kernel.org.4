Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494563DA67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiK3QTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3QTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67754D5EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnZGBkwWgbFX167qaVZmI9S2d5cNmBBPcO+crFwoMks=;
        b=UihkukJMdy7/ktcRu3ozOWLL0uQGi4V5qqBRX8IWwBnLi5fsvGNFiJFlekHKcU8L1LgGtY
        oLDIQAIZUXNwiFQUek8ZsgcxgetZZfp2AQYVcGfUYEl6VRW9q3P7XsL65asOhjwb4IIGJy
        zRtj0Y2a90hOwmeKYcBrEiT+m2UXOJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-k5qbtME1Pd2dtHP8scxEPQ-1; Wed, 30 Nov 2022 11:18:48 -0500
X-MC-Unique: k5qbtME1Pd2dtHP8scxEPQ-1
Received: by mail-wm1-f72.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so1171686wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnZGBkwWgbFX167qaVZmI9S2d5cNmBBPcO+crFwoMks=;
        b=C2T+bbVAqt2U6+DQRRrxE6udP+bUH5Q+7UnbMUGlarHQjf8hRKJ3e68NTn29jhMCLa
         FJIxjuAeOLE+vyD4uPsvJGj1L2Byy93JbSAlJk6thgpwfBQE7fO1coI0jNwoMkhoZ9zp
         fjlMzfPY773PF/fjtfZxA8kFivXCkmhRDoKBbHhSc6YL2dCqZ97G0RwiB71mHKwkh7Fx
         nYWQm1MsVyTKzYipdsnfWew/q32qS0ZtwQmy7jUv64RZMkl1FSFwB/FxzUMrRYyHjM7Y
         jHAN9r+0+kKm1B8JP3OjE7tdGjGRiB9jd8jq1oDBswbNLjlP5Y93cGoHr/UDA0Lqr73Q
         cC/g==
X-Gm-Message-State: ANoB5pmzdz0GSab8T2Oy5jRHhx4wRRqQS1LtJQAHwlTMX0cyHBMws1B6
        rD3dJiotPc1cqmg6h9JLu/5rHyRLuHQDPLw57B+r8GkbV1Fk1vMFELtt5mRmJugHGau8Wla0v8B
        NM/m2FacH8UnA5KCdFSm1Vfkv
X-Received: by 2002:adf:a357:0:b0:242:2669:be96 with SMTP id d23-20020adfa357000000b002422669be96mr4527490wrb.713.1669825126875;
        Wed, 30 Nov 2022 08:18:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7A6sXPnq+UQVA7DWGCrB2WPLau85zrzR/9C04F6J581F2ohdEXx496Fwz9ibJTCvV4eTXMXA==
X-Received: by 2002:adf:a357:0:b0:242:2669:be96 with SMTP id d23-20020adfa357000000b002422669be96mr4527469wrb.713.1669825126564;
        Wed, 30 Nov 2022 08:18:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003b4fe03c881sm6809659wmq.48.2022.11.30.08.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:18:46 -0800 (PST)
Message-ID: <65a3a912-3534-6718-2c55-e0d4b5246f1e@redhat.com>
Date:   Wed, 30 Nov 2022 17:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to pmd
 unshare
In-Reply-To: <20221129193526.3588187-10-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.22 20:35, Peter Xu wrote:
> Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/rmap.h | 4 ++++
>   mm/page_vma_mapped.c | 5 ++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index bd3504d11b15..a50d18bb86aa 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -13,6 +13,7 @@
>   #include <linux/highmem.h>
>   #include <linux/pagemap.h>
>   #include <linux/memremap.h>
> +#include <linux/hugetlb.h>
>   
>   /*
>    * The anon_vma heads a list of private "related" vmas, to scan if
> @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>   		pte_unmap(pvmw->pte);
>   	if (pvmw->ptl)
>   		spin_unlock(pvmw->ptl);
> +	/* This needs to be after unlock of the spinlock */
> +	if (is_vm_hugetlb_page(pvmw->vma))
> +		hugetlb_vma_unlock_read(pvmw->vma);
>   }
>   
>   bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 93e13fc17d3c..f94ec78b54ff 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		if (pvmw->pte)
>   			return not_found(pvmw);
>   
> +		hugetlb_vma_lock_read(vma);
>   		/* when pud is not present, pte will be NULL */
>   		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> -		if (!pvmw->pte)
> +		if (!pvmw->pte) {
> +			hugetlb_vma_unlock_read(vma);
>   			return false;
> +		}
>   
>   		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
>   		if (!check_pte(pvmw))

Looking at code like  mm/damon/paddr.c:__damon_pa_mkold() and reading 
the doc of page_vma_mapped_walk(), this might be broken.

Can't we get page_vma_mapped_walk() called multiple times? Wouldn't we 
have to remember that we already took the lock to not lock twice, and to 
see if we really have to unlock in page_vma_mapped_walk_done() ?

-- 
Thanks,

David / dhildenb

