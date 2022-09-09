Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF25B3676
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIILgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIILgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108C12EDA6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maZfD0oCjFCM4aCFs68Cg66zWCeM1I3js7vDr3fDq20=;
        b=R5V2QELUlUFfjrufr0N8XxoOyVMhBdlu/cAluWc4GES28ybTZJ7urPqnixiDB6QQ5EMwFR
        moTKv1UvmYVvqAwn9V/suwADzJcjiWI9cvdgDHAtCV+EtzUdSmyZI+jYEDSxjKbghXd0/3
        ceRrfgWHbN7RvHHAGFjotM+IFxVZywg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-3kfynIhbOSqFtYhKwMfkzg-1; Fri, 09 Sep 2022 07:36:12 -0400
X-MC-Unique: 3kfynIhbOSqFtYhKwMfkzg-1
Received: by mail-wm1-f72.google.com with SMTP id o25-20020a05600c339900b003b2973dab88so727008wmp.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=maZfD0oCjFCM4aCFs68Cg66zWCeM1I3js7vDr3fDq20=;
        b=IhAnwocl+Fyb3Oc9KaMQ4p1GPAss4X4+TnaprwIHaLOcfMNvLEYfMq/UjnpvbWIIJL
         WCYMihMT7JNQkitiNtbHzxOdYkXzmwIDtWzgJ5sYLfYeCg6ejohDGSNRtDCEqafGt5UR
         0jaPoC1kRlO1mD1vFiBlD/ny7ms3M17GSW0R9NEMtMOJgLdYGoi9jghqhB30axnENbS0
         fnBYh9R0BBK5v6ZBGt2LUUvHl7WKX2K94FiH5mUMRZUXOMdzxzZu+f+fHCY5MDs0hpye
         JESGbbvXq03NgYpSR6pGgCGtAjxael5px2pajaqTkCEX2OM80h+E/EbEj86MNGKzPCfD
         3YrQ==
X-Gm-Message-State: ACgBeo2+Lyp5Qiset7B2xIQzY4rra7Z1+SPJz33bGihSaE+cwQViy2ed
        IH24Ozvakjwh+FGVxoCMl+IjgAi2Cdorlo2PbMgar0+O4r64rM1qPPUBwuEW2v4r7BLF60NuoX1
        Oz2UIw79M8ZqAZJ58ZnU8DuYx
X-Received: by 2002:a05:600c:3c84:b0:3a6:9596:fa1f with SMTP id bg4-20020a05600c3c8400b003a69596fa1fmr5180367wmb.162.1662723371615;
        Fri, 09 Sep 2022 04:36:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4hTek+xtlkUNfx14F+65SKYij81qgrbT2VYd/sA2LVlUyUPG72J8QFETT1EALRbjv2ceGvqA==
X-Received: by 2002:a05:600c:3c84:b0:3a6:9596:fa1f with SMTP id bg4-20020a05600c3c8400b003a69596fa1fmr5180345wmb.162.1662723371293;
        Fri, 09 Sep 2022 04:36:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d5185000000b0022863c18b93sm325531wrv.13.2022.09.09.04.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:36:10 -0700 (PDT)
Message-ID: <50964afc-e1be-9356-fff9-8c0d89000cea@redhat.com>
Date:   Fri, 9 Sep 2022 13:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 13/16] mm/page_alloc: init local variable buddy_pfn
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-14-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-14-linmiaohe@huawei.com>
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
> The local variable buddy_pfn could be passed to buddy_merge_likely()
> without initialization if the passed in order is MAX_ORDER - 1. This
> looks buggy but buddy_pfn won't be used in this case as there's a
> order >= MAX_ORDER - 2 check. Init buddy_pfn to 0 anyway to avoid
> possible future misuse.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e1c7f98cff96..63ad25e86010 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1113,7 +1113,7 @@ static inline void __free_one_page(struct page *page,
>   		int migratetype, fpi_t fpi_flags)
>   {
>   	struct capture_control *capc = task_capc(zone);
> -	unsigned long buddy_pfn;
> +	unsigned long buddy_pfn = 0;
>   	unsigned long combined_pfn;
>   	struct page *buddy;
>   	bool to_tail;

Yeah, why not.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

