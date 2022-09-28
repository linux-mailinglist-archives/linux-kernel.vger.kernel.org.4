Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522945EDEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiI1O1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiI1O1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7507AB04C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664375261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsRvdNuB3v/SNcrkexdVjS7ITSiCQeyOBq5LFv9LGBc=;
        b=YS8c5V9s0tEcnnB7ZiaUucx0K8X5d1x5GsV/aFdlu27m2CqF63dgW5RYtaQXtVtJG64RrH
        H9dJsM2nPiulwvtjaVj6aCZRsqfSEX8NnIApscGBXGK/UuqdzSA5idGywYCupZ+xrwtbse
        9OEfN5vTu1HxTvtK3kuSsl0D4yHNTz8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-EWmFq-9kMY6gJfNsctQoyg-1; Wed, 28 Sep 2022 10:27:40 -0400
X-MC-Unique: EWmFq-9kMY6gJfNsctQoyg-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso7175711wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=CsRvdNuB3v/SNcrkexdVjS7ITSiCQeyOBq5LFv9LGBc=;
        b=dh71fd3AvbZBoJndAmvaC8dLEOtYwqo0+PVP2h+rDiQK05TUXha7e8QkZ5goHT74Vo
         qAJFN8kXhWFpPvzVTGtU4sbWce7/MFu+1/025hzv7rixxRbWX+WHPvOKHH/Y0nwtio2z
         De2g0uj4MQMwudqq27Llux6ZsfYah7tsjuz7PVlD6le0M6YhZ/fRvyjNRzrUgLxiSrUa
         xQWwWqwKthk1VhWWOpTGZCuUbOSIQceRDxPdByUJ25aeC0WGGIpkDJCt/nl/AepmjV35
         i13FzVju3i+jT21a60fQO0AtGyUvU/5FdeJUiM4o0717CQyk/3caT0O0/ddvxO4I8Ajm
         qKgQ==
X-Gm-Message-State: ACrzQf2FnWlQDwulrJuVrtoAj0ohbWRonD5bTLfTYqZKunsdLsVQ0QTY
        Xi7N9rx6M6+R3etyphWUQU3HtbIxOi6LVKr7OF9SAHLzd8X81qX5/+LA+ujGPx6V4srzXW/ELKR
        nEXDogX6ardzaO3AjYNuKXwjt
X-Received: by 2002:a05:600c:198a:b0:3b4:c06a:28b1 with SMTP id t10-20020a05600c198a00b003b4c06a28b1mr7253789wmq.72.1664375258855;
        Wed, 28 Sep 2022 07:27:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PL6DSJpi05ycxfM4eUOHcWUfX6Va9hKc9hPOOGXegD1eig35izDc6V95YS8RX3LTd0YVPBQ==
X-Received: by 2002:a05:600c:198a:b0:3b4:c06a:28b1 with SMTP id t10-20020a05600c198a00b003b4c06a28b1mr7253764wmq.72.1664375258586;
        Wed, 28 Sep 2022 07:27:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:1100:add9:5f61:6b94:7540? (p200300cbc7041100add95f616b947540.dip0.t-ipconnect.de. [2003:cb:c704:1100:add9:5f61:6b94:7540])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b0022ca921dc67sm4288199wrs.88.2022.09.28.07.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:27:38 -0700 (PDT)
Message-ID: <ae48706e-e628-766e-8a74-e322b96eeb6b@redhat.com>
Date:   Wed, 28 Sep 2022 16:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] mm: rmap: rename page_not_mapped() to folio_not_mapped()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20220927063826.159590-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220927063826.159590-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.22 08:38, Kefeng Wang wrote:
> Since commit 2f031c6f042c ("mm/rmap: Convert rmap_walk() to
> take a folio"), page_not_mapped() takes folio as parameter,
> rename it to be consistent.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/rmap.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2ec925e5fa6a..df228602cf0e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1801,7 +1801,7 @@ static bool invalid_migration_vma(struct vm_area_struct *vma, void *arg)
>   	return vma_is_temporary_stack(vma);
>   }
>   
> -static int page_not_mapped(struct folio *folio)
> +static int folio_not_mapped(struct folio *folio)
>   {
>   	return !folio_mapped(folio);
>   }
> @@ -1822,7 +1822,7 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
>   	struct rmap_walk_control rwc = {
>   		.rmap_one = try_to_unmap_one,
>   		.arg = (void *)flags,
> -		.done = page_not_mapped,
> +		.done = folio_not_mapped,
>   		.anon_lock = folio_lock_anon_vma_read,
>   	};
>   
> @@ -2150,7 +2150,7 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
>   	struct rmap_walk_control rwc = {
>   		.rmap_one = try_to_migrate_one,
>   		.arg = (void *)flags,
> -		.done = page_not_mapped,
> +		.done = folio_not_mapped,
>   		.anon_lock = folio_lock_anon_vma_read,
>   	};
>   
> @@ -2297,7 +2297,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
>   	};
>   	struct rmap_walk_control rwc = {
>   		.rmap_one = page_make_device_exclusive_one,
> -		.done = page_not_mapped,
> +		.done = folio_not_mapped,
>   		.anon_lock = folio_lock_anon_vma_read,
>   		.arg = &args,
>   	};

I'm wondering if we should call it "folio_unmapped()". Anyhow

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

