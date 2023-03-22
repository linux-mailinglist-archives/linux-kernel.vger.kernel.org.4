Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3536C48ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCVLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCVLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD0C4390A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679483937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4PBeFJVq5sXMm2kVcvHwookT+3r5JXG0gTDh8oEJNU=;
        b=OAnggRhZWUz/8+ZektwMDgmcCAKxwSpCSgG/UFKt86RzyQlVGiqm1erQEVJVDIv2dqLq/y
        +Qc7OQr0cc3Qn58oECT3o1qvC+xTlRZK4Pn1a3xMIYHjeQ9J/roQgBwInMFoUlPQLhhhWY
        QGNn+BC04T75C4xNUgPiCtFrtcY2T2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-su1uJfnGOr2vi5MLhlz9lA-1; Wed, 22 Mar 2023 07:18:56 -0400
X-MC-Unique: su1uJfnGOr2vi5MLhlz9lA-1
Received: by mail-wm1-f71.google.com with SMTP id i3-20020a05600c354300b003edfa408811so4319448wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483935;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4PBeFJVq5sXMm2kVcvHwookT+3r5JXG0gTDh8oEJNU=;
        b=L/554oD1BWmdg0ZixRlY7rNjaC3lHAVR2RKlZO+wbvumkSUHybS5BnjS0qu26BkPbv
         9ELTk3WIQwzn1INflR+LV87N2NA6BAgIKRihK9umvGcqYL/uSR0kbeqOS+fHR4md5ap1
         6H47KJsn0yuynqiXu572FKJx9bmNKBjBwdRV19ApN3bWO3uoqB5m0LKMUjLeoAMxomFS
         wfjoUHBQYyXoRBxNG8JeQsjlZ5SLvOfJMqMaSukLbPnuY9X1NkAEYDsc66+LCiYocvIe
         CDk0IeWxBFMbHeGvCS6361qRxQlFsctskKl8Yc7QjjuTqVFMdCoAm49xdkjmI1NsGnTw
         IJNw==
X-Gm-Message-State: AO0yUKUaakpLND41CnW9N0re1psNwhqbcLXOrcGD9Bo+XlxO7KRMliKP
        ngmqM0vRCCE/yOeRbD5NuHoeJd920EV9z9vWaewARBitMmEFBd4utNFPUh+AnEJhEUlOMF2m4Ep
        JvQml46mrbL5djBViBHKXU7OB
X-Received: by 2002:adf:ebcf:0:b0:2cf:f35b:9aa2 with SMTP id v15-20020adfebcf000000b002cff35b9aa2mr5083034wrn.19.1679483935294;
        Wed, 22 Mar 2023 04:18:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set8NWBavpXfZJCtR0zWMvJ2tk+TF3CcC7KjKh7fqSTp3IiRzYiIqIqJFR2gpzL1SxrRhG0XTEw==
X-Received: by 2002:adf:ebcf:0:b0:2cf:f35b:9aa2 with SMTP id v15-20020adfebcf000000b002cff35b9aa2mr5083014wrn.19.1679483934972;
        Wed, 22 Mar 2023 04:18:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b002c55b0e6ef1sm13808154wrz.4.2023.03.22.04.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:18:54 -0700 (PDT)
Message-ID: <d17ab016-661f-498b-6b50-19c7fc5f04b7@redhat.com>
Date:   Wed, 22 Mar 2023 12:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/14] mm: call {ptlock,pgtable}_cache_init() directly
 from mm_core_init()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-9-rppt@kernel.org>
 <ff403707-a61b-8b87-4d8d-5aecaa574be3@gmail.com>
 <ZBrTtQKe7SowXSKb@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBrTtQKe7SowXSKb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 11:08, Mike Rapoport wrote:
> On Wed, Mar 22, 2023 at 12:06:18PM +0300, Sergei Shtylyov wrote:
>> On 3/21/23 8:05 PM, Mike Rapoport wrote:
>>
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> and drop pgtable_init() as it has no real value and it's name is
>>
>>     Its name.
> 
> oops :)
> 
> Andrew, can you replace this patch with the updated version, please?
>   
>  From 52420723c9bfa84aa48f666330e96f9e5b2f3248 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Sat, 18 Mar 2023 13:55:28 +0200
> Subject: [PATCH v3] mm: call {ptlock,pgtable}_cache_init() directly from
>   mm_core_init()
> 
> and drop pgtable_init() as it has no real value and its name is
> misleading.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   include/linux/mm.h | 6 ------
>   mm/mm_init.c       | 3 ++-
>   2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2d7f095136fc..c3c67d8bc833 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2782,12 +2782,6 @@ static inline bool ptlock_init(struct page *page) { return true; }
>   static inline void ptlock_free(struct page *page) {}
>   #endif /* USE_SPLIT_PTE_PTLOCKS */
>   
> -static inline void pgtable_init(void)
> -{
> -	ptlock_cache_init();
> -	pgtable_cache_init();
> -}
> -
>   static inline bool pgtable_pte_page_ctor(struct page *page)
>   {
>   	if (!ptlock_init(page))
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index bba73f1fb277..f1475413394d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2584,7 +2584,8 @@ void __init mm_core_init(void)
>   	 */
>   	page_ext_init_flatmem_late();
>   	kmemleak_init();
> -	pgtable_init();
> +	ptlock_cache_init();
> +	pgtable_cache_init();
>   	debug_objects_mem_init();
>   	vmalloc_init();
>   	/* If no deferred init page_ext now, as vmap is fully initialized */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

