Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD55B368D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIILkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiIILjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E1102D6D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+xQ+u9S0tgyk9MqUu4hGDCqntK9cHlkmBOzSNS1R1w=;
        b=HoEsXEdch8kIonrmTAs8dxLkXFIWGqiBWHCTlQjE+ZxMujcR/6PSBfHw61sxSlOcs5VefA
        d/UCq4knrtoUxxLcCa6Yxs8Vw8N8kqXVvzBAYxzjO95pFJLr7mwJXzj1b/Qg35zt9Nz6bh
        maoy8KUVJPbKler9gFcupe8FOxgxet8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-4FGv38smPWOiy7IWwxpKww-1; Fri, 09 Sep 2022 07:39:16 -0400
X-MC-Unique: 4FGv38smPWOiy7IWwxpKww-1
Received: by mail-wm1-f69.google.com with SMTP id v189-20020a1cacc6000000b003b461a36bb5so387030wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=4+xQ+u9S0tgyk9MqUu4hGDCqntK9cHlkmBOzSNS1R1w=;
        b=ZTqeel5cHmtLU4R+82bK+jT5nOZjrnBHEd+GPATPoYsuQMsg8+f74vcMSdgvAIR5QY
         469KS+5pIvfwoIiogu1ZbMbE9ozddK3n3HWaDO+s4Zt1a/Pa/35qZLbZ2+Tf+hG1wyF0
         Pp+4lYLO05+ZwF0SuNtw6zO4nT0p76V2smLp2Sgy6jpS94rXsUI7Cz+G8tRvwdCEZje3
         Zebt4yX3iy5wNBTbsCrVckrMZFje7E2HP1n1R/brIbKDWZQiaGj4MlxL9ULeCgg/qKJ6
         suNW9nx1aM37x9yN7V1t+bHZDNiFrOHdE/lwcGzR5Y5xWmbVZ7iNG3TLJQC+rDoeg8rh
         5nrg==
X-Gm-Message-State: ACgBeo1FZE2fdMQbHNhwVSUcZ4WLXKHsUDkE5WbE0BvbdIqbrMUoD54M
        0ftTJoepA7LTxF1xVNwwZRrZuoLGqTkHTKsrvtPrJZnOyeDZUDKysSgG+74gDRs9T56L5FpHC1l
        d5EqlwRpck+w3SFxBxdBZhktB
X-Received: by 2002:a05:600c:190a:b0:3a8:43b8:53e3 with SMTP id j10-20020a05600c190a00b003a843b853e3mr5410833wmq.4.1662723551771;
        Fri, 09 Sep 2022 04:39:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5oSOQCv1rV8+0kKXwGqYxsbmkXFVKOldZ3ZBR0HZyGJjq4rqQ63TIdaJov10te02Vg9N29fQ==
X-Received: by 2002:a05:600c:190a:b0:3a8:43b8:53e3 with SMTP id j10-20020a05600c190a00b003a843b853e3mr5410821wmq.4.1662723551494;
        Fri, 09 Sep 2022 04:39:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id k13-20020adfe3cd000000b00228655a5c8fsm308697wrm.28.2022.09.09.04.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:39:11 -0700 (PDT)
Message-ID: <1b078b99-a0d8-f1d9-d804-10cd0228d168@redhat.com>
Date:   Fri, 9 Sep 2022 13:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 01/16] mm/page_alloc: ensure kswapd doesn't accidentally
 go to sleep
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 11:24, Miaohe Lin wrote:
> If ALLOC_KSWAPD is set, wake_all_kswapds() will be called to ensure
> kswapd doesn't accidentally go to sleep. But when reserve_flags is
> set, alloc_flags will be overwritten and ALLOC_KSWAPD is thus lost.
> Preserve the ALLOC_KSWAPD flag in alloc_flags to ensure kswapd won't
> go to sleep accidentally.
> 
> Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ba5c9402a5cb..4b97a03fa2dd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5147,7 +5147,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   
>   	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
>   	if (reserve_flags)
> -		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
> +		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
> +					  (alloc_flags & ALLOC_KSWAPD);
>   
>   	/*
>   	 * Reset the nodemask and zonelist iterators if memory policies can be

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

