Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36899738331
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFULTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjFULSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B7184
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687346285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eA/C3UTAELWqz6unXgzX5wgchGsL80SWbmcKSOr32rc=;
        b=YWmMSlWlB++0BQAFRnxY7K0Ex0zufH5qKYJVuBWFZQ5FmrsBbA3NJxDdNDedThXRZXTSq3
        GsKwzbBWmF8QD89Xr98DzhBzmkljf2rzOuvu6FeDsddCAo0hiyQOc5WxVF7NC8uXWfAPQ7
        nZeKHR+Bpb1yMd1HSK7hNiQLzHdbTX0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-AGDJc0p6OS6ZB6mXW5tQ8A-1; Wed, 21 Jun 2023 07:18:04 -0400
X-MC-Unique: AGDJc0p6OS6ZB6mXW5tQ8A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f8fceddaeaso1593834e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346282; x=1689938282;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA/C3UTAELWqz6unXgzX5wgchGsL80SWbmcKSOr32rc=;
        b=PIs1khiu4o3/iZTz0nMkejPILyqQg/23k29gVv2J40+WxDaWoPdmMXpPjszgzdepHL
         /nRB2im3gAu4gdakuoc15i6TSwcz/xis1LMFpxOBdsI9rtGaWL06uxOhFXzhd3yZQLaw
         4rvErr4A1EWN5rmfOLUBYLF9YkiRXBozll4CKfqNaxK9CKON+nQSRn8X0EL8smKuOYa/
         YvvpRP3QerN7U3c95lY4zLhfbEdE5LQNGcdZV9YEA0ut1x8jQlSGPuM/5Z3ESpoa1NKi
         B88l+9+cgYobiqXKZf8AMYhF5aT66NTNobU/hmR98dbiQ9JDI1qNUqy2/MFMRRbj+QH6
         aKBA==
X-Gm-Message-State: AC+VfDxaBy0zgYQ3AvMS8qbpueMlVukZD80RK6UOrp2xKHJHfKC3Ln20
        1YCuVVeDCWIHpBWv3KiAhgTp/vNj6bqB+vlz44+M75FxF9tuWPmEBl5Hqc/dB1PL4Yf2gf2XCJE
        png+i0jawmcscek3aKjv5oAzN
X-Received: by 2002:a05:6512:291:b0:4f8:6e26:9347 with SMTP id j17-20020a056512029100b004f86e269347mr6566247lfp.68.1687346282264;
        Wed, 21 Jun 2023 04:18:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cbfnyJkssIXiJndC8FHgvzkyIm+QV6Pio81ybA5Qjaap7dDs9ybW2SP9EmjkYP/SLFc0Yfw==
X-Received: by 2002:a05:6512:291:b0:4f8:6e26:9347 with SMTP id j17-20020a056512029100b004f86e269347mr6566231lfp.68.1687346281827;
        Wed, 21 Jun 2023 04:18:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef? (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de. [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
        by smtp.gmail.com with ESMTPSA id s3-20020a7bc383000000b003f6132f95e6sm15851624wmj.35.2023.06.21.04.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 04:18:01 -0700 (PDT)
Message-ID: <95531f88-a1bd-3347-dc60-8e16de811145@redhat.com>
Date:   Wed, 21 Jun 2023 13:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mm/min_free_kbytes: modify min_free_kbytes calculation
 rules
Content-Language: en-US
To:     liuq <liuq131@chinatelecom.cn>, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230621073912.21747-1-liuq131@chinatelecom.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230621073912.21747-1-liuq131@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.23 09:39, liuq wrote:
> The current calculation of min_free_kbytes only uses ZONE_DMA and
> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
> will also divide part of min_free_kbytes.This will cause the min
> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.
> 
> __GFP_HIGH and PF_MEMALLOC allocations usually don't need moveable
> zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
> value in __setup_per_zone_wmarks.
> 
> Signed-off-by: liuq <liuq131@chinatelecom.cn>
> ---
>   mm/page_alloc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b..608384712a89 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6364,7 +6364,7 @@ static void __setup_per_zone_wmarks(void)
>   
>   	/* Calculate total number of !ZONE_HIGHMEM pages */
>   	for_each_zone(zone) {
> -		if (!is_highmem(zone))
> +		if (!is_highmem(zone) || zone_idx(zone) != ZONE_MOVABLE)
>   			lowmem_pages += zone_managed_pages(zone);
>   	}
>   
> @@ -6374,7 +6374,7 @@ static void __setup_per_zone_wmarks(void)
>   		spin_lock_irqsave(&zone->lock, flags);
>   		tmp = (u64)pages_min * zone_managed_pages(zone);
>   		do_div(tmp, lowmem_pages);
> -		if (is_highmem(zone)) {
> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>   			/*
>   			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
>   			 * need highmem pages, so cap pages_min to a small

Patch subject should probably be something like

"mm/page_alloc: fix min_free_kbytes calculation regarding ZONE_MOVABLE"

?

-- 
Cheers,

David / dhildenb

