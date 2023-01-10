Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E966437B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbjAJOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjAJOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8872D1788C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673361697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4g9pnWT43DUunpQsxzG5qZh/RY4G1cVAtYK0Irtegc=;
        b=HuHmvYaAF4tD7Av6cnJnEk/7WUIR0SpY29QSeNC2pqOseiZ81bUBSjEoX2uUBiV1raLoRp
        vxMnkIBMzaNVKlYFAUBmkV9XGgpGtYZKWl6KxaJpFIeK6vqT2+g9yKNPO8Yv+9UFkfmuvZ
        IzEruozRhAM7lcMNVtE4POnN+FC1jog=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-hdHDmm1zMgWbASkC5kbJPw-1; Tue, 10 Jan 2023 09:41:35 -0500
X-MC-Unique: hdHDmm1zMgWbASkC5kbJPw-1
Received: by mail-wm1-f69.google.com with SMTP id n9-20020a05600c3b8900b003d9f14e904eso3130312wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4g9pnWT43DUunpQsxzG5qZh/RY4G1cVAtYK0Irtegc=;
        b=m/ISJ/sowyqvdkYbKfaVelOIf4vu/B38YnGtp98oMqL/HtzilCHu7R6DSdUniwHdt3
         wRTOt/s/7HqnX8htIAVRjFKGtefifbcxn1/wVpGq2tGa6tiKnvVpRK4yLcu/l3qq1d4o
         u7TXQi1/q2Kq335kCPrJdwlwzAQctVFAWiQMye6GzJGNjmFAuGYUvwMKUeIbVy7IN16N
         o/UG7PnnvrTeNRGaa/2yZbLqSzMKcovTrXjXaH7HUqq1aPK+nlWu/MPq3WbcEfiIt9y2
         xO94bM4PGaLJz6d0wIioayOm38pHhONBCFiSszTmGYE8ou9ln8xsGYbC7NPhf99PjpZX
         71ZA==
X-Gm-Message-State: AFqh2krY+izp6KBles7bFyzW3URa6DipvOng33URKlSwjWime2SWYUBi
        WROySSvcByhnROmPZ7pT1TLsDeB1HVtXOja99QpopkHQkh/Jd4psuKiuy0l6EthORIyU48nRjqg
        D4Ox/qOOlSp5UWUIz03+5jyCo
X-Received: by 2002:adf:e303:0:b0:26e:4bdc:6ae1 with SMTP id b3-20020adfe303000000b0026e4bdc6ae1mr43599790wrj.28.1673361694551;
        Tue, 10 Jan 2023 06:41:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtU76tgOOv4RdpJd4IzrQciHyEboZ0J4tfjr9YHe5XNutbSBgO0YUH1mLuXQ9UPiWZ4YhbE8Q==
X-Received: by 2002:adf:e303:0:b0:26e:4bdc:6ae1 with SMTP id b3-20020adfe303000000b0026e4bdc6ae1mr43599775wrj.28.1673361694301;
        Tue, 10 Jan 2023 06:41:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:4200:65d9:4d0d:bb61:14c8? (p200300cbc708420065d94d0dbb6114c8.dip0.t-ipconnect.de. [2003:cb:c708:4200:65d9:4d0d:bb61:14c8])
        by smtp.gmail.com with ESMTPSA id bw28-20020a0560001f9c00b002421888a011sm11178824wrb.69.2023.01.10.06.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:41:33 -0800 (PST)
Message-ID: <5751732b-67c4-bff5-a7eb-8432cdac5174@redhat.com>
Date:   Tue, 10 Jan 2023 15:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/sl{a,u}b: fix wrong usages of folio_page() for getting
 head pages
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230110005124.1609-1-sj@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230110005124.1609-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.23 01:51, SeongJae Park wrote:
> The standard idiom for getting head page of a given folio is
> '&folio->page', but some are wrongly using 'folio_page(folio, 0)' for
> the purpose.  Fix those to use the idiom.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/slab.c | 4 ++--
>   mm/slub.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index b77be9c6d6b1..a5398676dc60 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1389,7 +1389,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>   
>   	BUG_ON(!folio_test_slab(folio));
>   	__slab_clear_pfmemalloc(slab);
> -	page_mapcount_reset(folio_page(folio, 0));
> +	page_mapcount_reset(&folio->page);
>   	folio->mapping = NULL;
>   	/* Make the mapping reset visible before clearing the flag */
>   	smp_wmb();
> @@ -1398,7 +1398,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>   	if (current->reclaim_state)
>   		current->reclaim_state->reclaimed_slab += 1 << order;
>   	unaccount_slab(slab, order, cachep);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(&folio->page, order);
>   }
>   
>   static void kmem_rcu_free(struct rcu_head *head)
> diff --git a/mm/slub.c b/mm/slub.c
> index 67020074ecb4..d5f20c062004 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2066,7 +2066,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>   	if (current->reclaim_state)
>   		current->reclaim_state->reclaimed_slab += pages;
>   	unaccount_slab(slab, order, s);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(&folio->page, order);
>   }
>   
>   static void rcu_free_slab(struct rcu_head *h)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

