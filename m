Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135F7335FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbjFPQcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFPQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A612D6A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686933095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPytIYwEkl6QEu7Rgu+ICkD4rqXTkTJ3ru8gg8dbkVU=;
        b=YDCamqWyurashZ3i5O1OandqxeUipq6I1ZoEcS2TcWUrOmfc+zKmIGSnw9+re52Wtr3ZHA
        C7W5mAnLDSfQgx6KjVZJf7JPWXvI22bb9H+w5GRiMNOzeM/EQ7KCvCvCg+ebkyIYhXcdoI
        DPDVGcVbEegfl3I6BHGn2wTiBoe0d1M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-mCaV6q6dMo2iFIfer3rJag-1; Fri, 16 Jun 2023 12:31:33 -0400
X-MC-Unique: mCaV6q6dMo2iFIfer3rJag-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso60342566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933092; x=1689525092;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPytIYwEkl6QEu7Rgu+ICkD4rqXTkTJ3ru8gg8dbkVU=;
        b=TkQXE5ubfCNoWI1b9qSMMQiXrgk6Y2fysQgu6fGrr0NdPmZpvA5arPAc2GlHucIY+r
         G2lN3BVf44EA7RcEyA4cXmFHAGcdxLGj8cVxCm36WHuEs7RIuKJECmyIj5FOcQLnhCWD
         +CXz/PPM/Yl5bMnwO6mk2e0N0+5pIZqCfUwmPcT+yWJx2rEZxdSWO6LV2fA1hofSppW1
         Mn2eduVVhRUu7DyRUG0lPCPmNTi3FBqYQjz0tA82vGQuCeTRvVpOALwfV9Thh1k0tMwb
         WMNA/N4GoxZ5JZOMRCIjttpF4RxmGR3ciydla9rOdLZdsaHXZ/f8kpeLAbBltZCCgkxQ
         gW+g==
X-Gm-Message-State: AC+VfDzBPDdaGgn64cH1D7hPnI8QruR+yFPMDbwSBw2pGQtSRcaN/F5y
        0buoTcdXQfoU+jAG6aAXiBNpKBOtO7rmt9rjnwIQfpwfZLb54OnEifkjelDczaXTjuY/Ef3cdeS
        6U1EkIrbaAwiPdBxuNdVrCBG1
X-Received: by 2002:a17:907:2cc4:b0:978:70e1:f02e with SMTP id hg4-20020a1709072cc400b0097870e1f02emr2251713ejc.22.1686933092376;
        Fri, 16 Jun 2023 09:31:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QwaRaNv6ifNugvelfv7foAf6nRIFf7h4Hs5kRZnyhyelYJppcvYV1pqXjZMzTH6ieVSVktw==
X-Received: by 2002:a17:907:2cc4:b0:978:70e1:f02e with SMTP id hg4-20020a1709072cc400b0097870e1f02emr2251685ejc.22.1686933091957;
        Fri, 16 Jun 2023 09:31:31 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906960200b00982834553a6sm3278848ejx.165.2023.06.16.09.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:31:31 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
Date:   Fri, 16 Jun 2023 18:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Maryam Tahhan <mtahhan@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20230609131740.7496-1-linyunsheng@huawei.com>
 <20230609131740.7496-4-linyunsheng@huawei.com>
 <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
 <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com>
 <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
 <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
In-Reply-To: <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2023 13.57, Yunsheng Lin wrote:
> On 2023/6/16 0:19, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>> You have mentioned veth as the use-case. I know I acked adding page_pool
>> use-case to veth, for when we need to convert an SKB into an
>> xdp_buff/xdp-frame, but maybe it was the wrong hammer(?).
>> In this case in veth, the size is known at the page allocation time.
>> Thus, using the page_pool API is wasting memory.  We did this for
>> performance reasons, but we are not using PP for what is was intended
>> for.  We mostly use page_pool, because it an existing recycle return
>> path, and we were too lazy to add another alloc-type (see enum
>> xdp_mem_type).
>>
>> Maybe you/we can extend veth to use this dynamic size API, to show us
>> that this is API is a better approach.  I will signup for benchmarking
>> this (and coordinating with CC Maryam as she came with use-case we
>> improved on).
> 
> Thanks, let's find out if page pool is the right hammer for the
> veth XDP case.
> 
> Below is the change for veth using the new api in this patch.
> Only compile test as I am not familiar enough with veth XDP and
> testing environment for it.
> Please try it if it is helpful.
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 614f3e3efab0..8850394f1d29 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -736,7 +736,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>          if (skb_shared(skb) || skb_head_is_locked(skb) ||
>              skb_shinfo(skb)->nr_frags ||
>              skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> -               u32 size, len, max_head_size, off;
> +               u32 size, len, max_head_size, off, truesize, page_offset;
>                  struct sk_buff *nskb;
>                  struct page *page;
>                  int i, head_off;
> @@ -752,12 +752,15 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>                  if (skb->len > PAGE_SIZE * MAX_SKB_FRAGS + max_head_size)
>                          goto drop;
> 
> +               size = min_t(u32, skb->len, max_head_size);
> +               truesize = size;
> +
>                  /* Allocate skb head */
> -               page = page_pool_dev_alloc_pages(rq->page_pool);
> +               page = page_pool_dev_alloc(rq->page_pool, &page_offset, &truesize);

Maybe rename API to:

  addr = netmem_alloc(rq->page_pool, &truesize);

>                  if (!page)
>                          goto drop;
> 
> -               nskb = napi_build_skb(page_address(page), PAGE_SIZE);
> +               nskb = napi_build_skb(page_address(page) + page_offset, truesize);

IMHO this illustrates that API is strange/funky.
(I think this is what Alex Duyck is also pointing out).

This is the memory (virtual) address "pointer":
  addr = page_address(page) + page_offset

This is what napi_build_skb() takes as input. (I looked at other users 
of napi_build_skb() whom all give a mem ptr "va" as arg.)
So, why does your new API provide the "page" and not just the address?

As proposed above:
   addr = netmem_alloc(rq->page_pool, &truesize);

Maybe the API should be renamed, to indicate this isn't returning a "page"?
We have talked about the name "netmem" before.

>                  if (!nskb) {
>                          page_pool_put_full_page(rq->page_pool, page, true);
>                          goto drop;
> @@ -767,7 +770,6 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>                  skb_copy_header(nskb, skb);
>                  skb_mark_for_recycle(nskb);
> 
> -               size = min_t(u32, skb->len, max_head_size);
>                  if (skb_copy_bits(skb, 0, nskb->data, size)) {
>                          consume_skb(nskb);
>                          goto drop;
> @@ -782,14 +784,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>                  len = skb->len - off;
> 
>                  for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> -                       page = page_pool_dev_alloc_pages(rq->page_pool);
> +                       size = min_t(u32, len, PAGE_SIZE);
> +                       truesize = size;
> +
> +                       page = page_pool_dev_alloc(rq->page_pool, &page_offset,
> +                                                  &truesize);
>                          if (!page) {
>                                  consume_skb(nskb);
>                                  goto drop;
>                          }
> 
> -                       size = min_t(u32, len, PAGE_SIZE);
> -                       skb_add_rx_frag(nskb, i, page, 0, size, PAGE_SIZE);
> +                       skb_add_rx_frag(nskb, i, page, page_offset, size, truesize);

Guess, this shows the opposite; that the "page" _is_ used by the 
existing API.

>                          if (skb_copy_bits(skb, off, page_address(page),
>                                            size)) {
>                                  consume_skb(nskb);

--Jesper

