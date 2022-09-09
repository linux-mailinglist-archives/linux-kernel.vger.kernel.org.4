Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46485B3653
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIIL1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIIL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344CE903F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wfYy6ZeUFGo0evauzx0o3lnmHqWq7O1ZHI0jQhIckQ=;
        b=fD2ZVx5vrb7o7MbOWm7FAYxniulNWlx7tLQV1AXvcNFLkaTdIM6TwMw7BPIzC3i7Rqmt9j
        sv7NZCYNs5mfqFzd2Kq/VUeXYHP3xlikRbtECnrPXz3XcFjPPAv6tMA64Lgqs+g7C7pqGF
        pen1u5x7RPnjheuCCrhDVXfhjgEAmyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-538-MYc_tg8lNFWmx8XRel8ewQ-1; Fri, 09 Sep 2022 07:27:29 -0400
X-MC-Unique: MYc_tg8lNFWmx8XRel8ewQ-1
Received: by mail-wm1-f71.google.com with SMTP id i66-20020a1c3b45000000b003b339a8556eso715951wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+wfYy6ZeUFGo0evauzx0o3lnmHqWq7O1ZHI0jQhIckQ=;
        b=T6few50ho2hzPenjXkbHIkbvgv1eyzGAfhNAOtRSHHwqFvlTjW2M6JxJ2bKySoFksx
         6spM3+ofn7K6v3OYfwUIBRGfFkOSqSIcibwPcA6uX2ygajrFU20lJdYF88LYQ4Un+RVO
         H8IUGwX+I3nADVrdiHJos1vqWTIon/qAgf8yUt7a7synTe58vKRucDXht8MdtFIfNzfj
         YXMoyVJo3x4iNlvWXcU9DdUJVOjh3xCBs9TJ7TITnUnMUAIJ+8trTgTlkiLiSwctK6RM
         ef+3TFumEl3DfJm/p1AtbkI+sclYCGDQ5bAI38ZKyAzw17jzNhGCDsETVpsGZHzxVaWP
         Ek2A==
X-Gm-Message-State: ACgBeo3jET/yBPloxiGtxtQ9Ti6WctJkTZ7SogaX58ZC7kNNdzvHv2dl
        oSrUmbF6QSGDJQFeDNb5bOT6lPV2VcN8gVl9NLG9SPvEanCHk6k1hlaK9guGW1cFmyHOwqURQLJ
        z3fPyi5UxsrrN3Nv477y7VqZM
X-Received: by 2002:a5d:4e0a:0:b0:228:a2d7:f474 with SMTP id p10-20020a5d4e0a000000b00228a2d7f474mr7680974wrt.286.1662722848119;
        Fri, 09 Sep 2022 04:27:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gaaUiKkxNMVR9UES/pb1gukqOYoJZGBneYbkpS1MRHWiLR5yBTYRJnq/SoGI6M6S4T8cElw==
X-Received: by 2002:a5d:4e0a:0:b0:228:a2d7:f474 with SMTP id p10-20020a5d4e0a000000b00228a2d7f474mr7680961wrt.286.1662722847884;
        Fri, 09 Sep 2022 04:27:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003a5260b8392sm526951wms.23.2022.09.09.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:27:27 -0700 (PDT)
Message-ID: <d40e79f8-6295-78ec-1077-7abd52cec3d1@redhat.com>
Date:   Fri, 9 Sep 2022 13:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 04/16] mm/page_alloc: remove obsolete comment in
 zone_statistics()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-5-linmiaohe@huawei.com>
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
> Since commit 43c95bcc51e4 ("mm/page_alloc: reduce duration that IRQs
> are disabled for VM counters"), zone_statistics() is not called with
> interrupts disabled. Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2deac2fe3372..c81f06d8a4f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3671,8 +3671,6 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>   
>   /*
>    * Update NUMA hit/miss statistics
> - *
> - * Must be called with interrupts disabled.
>    */
>   static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
>   				   long nr_account)


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

