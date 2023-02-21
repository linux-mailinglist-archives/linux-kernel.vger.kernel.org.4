Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394D669DD91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjBUKJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjBUKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74988695
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676974122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQngTxIAa7bq5F++Qt1+J5qF8M9CFcFTXwihCMqwxiU=;
        b=LXYefHCvgn3T8u3hrl1REa7QUrtDqiQN2MhHNZEmr5+d09NFedHeB4dxMuHYax3B2t15tA
        FjFGWRIrdGJfBoov4P8YzRtcuPtrHVdKuStcmh1ys/uWi6N0HRVdpJmdYdz/mfGPJNN+6x
        unOX0OwkZ8+AjeIQrx4r5VmTL1N0J+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-ogdzya5EMHuhjAhlrgFI6A-1; Tue, 21 Feb 2023 05:08:41 -0500
X-MC-Unique: ogdzya5EMHuhjAhlrgFI6A-1
Received: by mail-wr1-f70.google.com with SMTP id n14-20020a5d67ce000000b002bfc2f61048so907625wrw.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQngTxIAa7bq5F++Qt1+J5qF8M9CFcFTXwihCMqwxiU=;
        b=zkW/CfI34gSch5SkiEO3cIRDPBVLXwDRuzqCi4hehMJs51rtb7D67X0wPk2eMKt2Rm
         HtOI5TjVkyzxY9FnzwvQ6FoyDNhVCXo2Fg8odO7LsNnZEgTaw+3wZg9JG0OaI3xlz82u
         XT6KjBHbPtDWd67GbfeaugH62Bjevv2olCPPo6FgZlQ7YCh1ZQFpwMoRyOtgFkXjTIgu
         QRTu3c6Z97feqhK0Wg54lrVDnROt5NTDaTnV2ocMi0w8hVi5Wp9S0C0k4eYigva0Dm28
         w07yK0X/ig77/2qrTaC2OJH5R+yJ6qdG4Jx7FPzIXHetI2/mKz8lIV5nL5RFYsX7Lge2
         HrtA==
X-Gm-Message-State: AO0yUKXKNxouNzwCzKkFUOm+oDTV8cb1A3EYXZzzpB/93S709g5+G6v9
        +vXTz66lyQjB5rfFNVcFaTvM9BjmC4l/04DvjIqztJ60Eh/akOszP7q7j3RseM2WnkBzhwAx1r/
        TgLAzq3Nm3wh4vMrUllhXwXYO
X-Received: by 2002:adf:fbc8:0:b0:2c5:5ff8:93e5 with SMTP id d8-20020adffbc8000000b002c55ff893e5mr3060436wrs.44.1676974120107;
        Tue, 21 Feb 2023 02:08:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+yvZn9hxlDINT7LN34Sejar7rKnrWklRGP11gcX16WuW5/FXenaqtVUV1kKpqHEv+TURtHBg==
X-Received: by 2002:adf:fbc8:0:b0:2c5:5ff8:93e5 with SMTP id d8-20020adffbc8000000b002c55ff893e5mr3060418wrs.44.1676974119708;
        Tue, 21 Feb 2023 02:08:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003dfdeb57027sm3086701wmh.38.2023.02.21.02.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:08:39 -0800 (PST)
Message-ID: <1b3e8e88-ed5c-7302-553f-4ddb3400d466@redhat.com>
Date:   Tue, 21 Feb 2023 11:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Andrew Yang <andrew.yang@mediatek.com>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, casper.lin@mediatek.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230221090313.15396-1-andrew.yang@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/damon/paddr: fix pin page problem
In-Reply-To: <20230221090313.15396-1-andrew.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.23 10:03, Andrew Yang wrote:
> From: "andrew.yang" <andrew.yang@mediatek.com>

Nit: I'd suggest a different subject

"mm/damon/paddr: fix missing put_page()"


Fixes: ?
Cc: stable ?


I think a patch from Willy is queued that converts this code into folios.

> 
> damon_get_page() would always increase page _refcount and
> isolate_lru_page() would increase page _refcount if the page's lru
> flag is set.
> 
> If a unevictable page isolated successfully, there will be two more
> _refcount. The one from isolate_lru_page() will be decreased in
> putback_lru_page(), but the other one from damon_get_page() will be
> left behind. This causes a pin page.
> 
> Whatever the case, the _refcount from damon_get_page() should be
> decreased.
> 
> Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> ---
>   mm/damon/paddr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e1a4315c4be6..56d8abd08fb1 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -223,8 +223,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
>   			putback_lru_page(page);
>   		} else {
>   			list_add(&page->lru, &page_list);
> -			put_page(page);
>   		}
> +		put_page(page);
>   	}
>   	applied = reclaim_pages(&page_list);
>   	cond_resched();

-- 
Thanks,

David / dhildenb

