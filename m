Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F9689797
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjBCLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBCLQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF691894
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675422943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXJDBhevOd/1JFZkBMpO6169BckV/OKptenwPTpSBbs=;
        b=Bq6LXaKxUvbNbCTn614msdAQu0medgtgFi8ITk/2EOuNa6YID7WOKcry6VIMO3qAYQFvAq
        oo+B41v70eQCD9lYTdqKMg1rggYOGZVjnyLgYy93zWIKmXjlZzzhmm+NdsH6NEDk1/DDNE
        VNT/vplaeBYbk22RELTf3+vv0gcUOHM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-x5F0-_muOeS4ujfLG_eZ7w-1; Fri, 03 Feb 2023 06:15:42 -0500
X-MC-Unique: x5F0-_muOeS4ujfLG_eZ7w-1
Received: by mail-ed1-f72.google.com with SMTP id ev18-20020a056402541200b004a621e993a8so3398020edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXJDBhevOd/1JFZkBMpO6169BckV/OKptenwPTpSBbs=;
        b=q9jIBoMQ9MXHyXwp0Dm+XrENuhaUgDc9mJIOPbULG1h9ZhvgelUqZMmaW9XfoTdVlF
         rDlGp9dE3tOjatkFnCW7sUK7iEzTMc7e6Npf0GO2I4knGVlJhmULP9ooY089sTfpE/n2
         d8IPy8fob4lE4+1RgA9X9c5r18wI7f0LNITp2wTeWZ82criX1cao5hGzBXNTFuWoqzHo
         iPqn48xQ6ez37NDwELQNRSqqEQO2CLA5Bu3t5jqjx/KlufvUq/vg95e72Ma5G8re2HHN
         BCZMb/n2vdJCfQeMljQjuBCQhjt/kWYnblEXlMlwG4e7JzUnIh11KeZWIlWoHtkMJvW4
         1rwA==
X-Gm-Message-State: AO0yUKVzznVb9y9TFjxPaUWndBdEAGSc8gHGNXN0yFztw3ALl72BVPvG
        VMxGZjNlyMs3lRsZg+Doq34gPYgC1s5x/b+ullEgH04fBoMFRdyx7/RxkhSiQkpuCSb+K79UyQF
        OedqrScFaLcpI4mecfYdarXVL
X-Received: by 2002:a17:906:2d4a:b0:883:5b33:e019 with SMTP id e10-20020a1709062d4a00b008835b33e019mr9638676eji.61.1675422940779;
        Fri, 03 Feb 2023 03:15:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9fDddBx5Yf7iRkJLq985W9j9hqpNTI1LQ3S2u0rnvZCnOb/yJ+3xrKr0ksRDi3EknYCs9EpQ==
X-Received: by 2002:a17:906:2d4a:b0:883:5b33:e019 with SMTP id e10-20020a1709062d4a00b008835b33e019mr9638665eji.61.1675422940600;
        Fri, 03 Feb 2023 03:15:40 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id y7-20020a170906470700b0088cdb05f1d5sm1215605ejq.113.2023.02.03.03.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 03:15:40 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ec42f238-8fc7-2ea4-c1a7-e4c3c4b8f512@redhat.com>
Date:   Fri, 3 Feb 2023 12:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     brouer@redhat.com
Subject: Re: [PATCH net] net: page_pool: use in_softirq() instead
Content-Language: en-US
To:     Qingfang DENG <dqfext@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202024417.4477-1-dqfext@gmail.com>
In-Reply-To: <20230202024417.4477-1-dqfext@gmail.com>
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


On 02/02/2023 03.44, Qingfang DENG wrote:
> From: Qingfang DENG <qingfang.deng@siflower.com.cn>
> 
> We use BH context only for synchronization, so we don't care if it's
> actually serving softirq or not.
> 

Are you sure this is safe?
(also see my inline notes below)

> As a side node, in case of threaded NAPI, in_serving_softirq() will
> return false because it's in process context with BH off, making
> page_pool_recycle_in_cache() unreachable.

How can I enable threaded NAPI on my system?

> Signed-off-by: Qingfang DENG <qingfang.deng@siflower.com.cn>
> Fixes: 7886244736a4 ("net: page_pool: Add bulk support for ptr_ring")
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> ---
>   include/net/page_pool.h | 4 ++--
>   net/core/page_pool.c    | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 813c93499f20..34bf531ffc8d 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -386,7 +386,7 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
>   static inline void page_pool_ring_lock(struct page_pool *pool)
>   	__acquires(&pool->ring.producer_lock)
>   {
> -	if (in_serving_softirq())
> +	if (in_softirq())
>   		spin_lock(&pool->ring.producer_lock);
>   	else
>   		spin_lock_bh(&pool->ring.producer_lock);
> @@ -395,7 +395,7 @@ static inline void page_pool_ring_lock(struct page_pool *pool)
>   static inline void page_pool_ring_unlock(struct page_pool *pool)
>   	__releases(&pool->ring.producer_lock)
>   {
> -	if (in_serving_softirq())
> +	if (in_softirq())
>   		spin_unlock(&pool->ring.producer_lock);
>   	else
>   		spin_unlock_bh(&pool->ring.producer_lock);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 9b203d8660e4..193c18799865 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -511,8 +511,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
>   static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
>   {
>   	int ret;
> -	/* BH protection not needed if current is serving softirq */
> -	if (in_serving_softirq())
> +	/* BH protection not needed if current is softirq */
> +	if (in_softirq())
>   		ret = ptr_ring_produce(&pool->ring, page);
>   	else
>   		ret = ptr_ring_produce_bh(&pool->ring, page);
> @@ -570,7 +570,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>   			page_pool_dma_sync_for_device(pool, page,
>   						      dma_sync_size);
>   
> -		if (allow_direct && in_serving_softirq() &&
> +		if (allow_direct && in_softirq() &&
>   		    page_pool_recycle_in_cache(page, pool))

I think other cases (above) are likely safe, but I worry a little about
this case, as the page_pool_recycle_in_cache() rely on RX-NAPI protection.
Meaning it is only the CPU that handles RX-NAPI for this RX-queue that
is allowed to access this lockless array.

We do have the 'allow_direct' boolean, and if every driver/user uses
this correctly, then this should be safe.  Changing this makes it
possible for drivers to use page_pool API incorrectly and this leads to
hard-to-debug errors.

>   			return NULL;
>   

--Jesper

