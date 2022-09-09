Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB375B3678
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIILhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIILhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B712ED9B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f81NbfEEf1+GjsVhdmRQYXxmtitfbsq8j6gFgnQBrqo=;
        b=MLR+4fi1496VYYzBdpA3bg+xeePl4kIdE5JD+6WcEWhLmvhjc49DMzhhNOYOjEVJPkXnd7
        CEM8Zq9WdEEq9/vruVFctKXPFOkJPEroqelY9/tycgm61Eo1EvDUffOElKy53GimjZZLEC
        LOJZGES8Q6crmkaw9n0wQEJcsRaRxVY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-rAnBujGyNg28coblZ8LEhA-1; Fri, 09 Sep 2022 07:37:04 -0400
X-MC-Unique: rAnBujGyNg28coblZ8LEhA-1
Received: by mail-wm1-f69.google.com with SMTP id i129-20020a1c3b87000000b003b33e6160bdso1013499wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=f81NbfEEf1+GjsVhdmRQYXxmtitfbsq8j6gFgnQBrqo=;
        b=ys3gW3zAW30FowopVxuvLtXwGtVr4qxfNtmhghoFwK4svZLL7rSEgjvxaEvA4TkxcL
         2d7dq3YRpeojAIjmi7smExUlidVeUk7S1AwnJ7P1BIAn80ioOyXTC1apVVEpz2wcJq+j
         zhucMCkrTqmGyQc5pPeXI44g6lEuJeSIBPp4hYA2Hdo54UyOKxmiSplq1K5X7iQZwfly
         /KLMFt+21FoA4nsSiyinXThexTJlUBDMnlW9STxl56OW0UraLlG46QY9/x/l25lOvUvq
         O7aWe8CxAIisy6EM/RW7jkjXDzqmldS4ak1BE4gH0uoKVErb9AeHEBbStLV0Vo/RcL76
         wOUw==
X-Gm-Message-State: ACgBeo0RJnVREiiuOzdESZLYE9+buWKzHipV2a3ycQYxdm8JLYCMCR1a
        xAyqevygc8ahUWz7zFjJGv/lbKqHYBCqw+tA+PLA7eOBPHVK3PUmPxL7mdWHxZa5T1aHxY/Rxxd
        Hd9gYNKkEY6h9PvihoOLX8U0F
X-Received: by 2002:a05:600c:216:b0:3a6:60e1:2726 with SMTP id 22-20020a05600c021600b003a660e12726mr4956988wmi.182.1662723423140;
        Fri, 09 Sep 2022 04:37:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4IC6GYPzJeHHs7qdQyJ8giBvMIBwMkEOoEec1/ZAwHrSN1UuFqOR70IDWzKzC+W6+sE9qpgA==
X-Received: by 2002:a05:600c:216:b0:3a6:60e1:2726 with SMTP id 22-20020a05600c021600b003a660e12726mr4956973wmi.182.1662723422848;
        Fri, 09 Sep 2022 04:37:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b003b31fc77407sm467994wmq.30.2022.09.09.04.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:37:02 -0700 (PDT)
Message-ID: <d20088b4-641f-2c33-7276-2eabc2833eb0@redhat.com>
Date:   Fri, 9 Sep 2022 13:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 14/16] mm/page_alloc: use costly_order in
 WARN_ON_ONCE_GFP()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-15-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-15-linmiaohe@huawei.com>
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
> There's no need to check whether order > PAGE_ALLOC_COSTLY_ORDER again.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 63ad25e86010..262e8972e019 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5272,7 +5272,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   		 * so that we can identify them and convert them to something
>   		 * else.
>   		 */
> -		WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
> +		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
>   
>   		/*
>   		 * Help non-failing allocations by giving them access to memory

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

