Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4C74C114
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 07:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGIFQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 01:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGIFQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 01:16:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC84E40;
        Sat,  8 Jul 2023 22:16:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-666ecf9a081so2840212b3a.2;
        Sat, 08 Jul 2023 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688879804; x=1691471804;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ztnp1qTer1IaWaOObtyfdo8muim3ULQZOmol0cBsgFo=;
        b=IsgnDEPrWv2qRNJgNRsVo8hNkyVbhR4y/lQoM5aXev+JVsfWrzOlmuqSFm45QBgJ8R
         6tkBuQZRIooyMTUjcoEjpg7QgA8qgnth8KEaXac8CIVHISlQqaJHMSE+eUB3cuP/MW6Q
         aDK7U9HJHKaztcZa0wu0XWkyNSR3vEbtAZfH07pzExxQD+2AfL/pNPCQrFZRk+yB2P/K
         k2RSyMaC5n1SIx1fvr9sE9VvPDivv2AfEfA5sZuVwvq5GaJYnIE4I52sNLmVawpLK4iu
         XibGU11vQEo9T1aMS7xj6lou+AeoQMlIfzf1THbJWKm0plNF5GUYez1Wpr51kxLybivP
         MrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688879804; x=1691471804;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztnp1qTer1IaWaOObtyfdo8muim3ULQZOmol0cBsgFo=;
        b=ObV0O+6P0Q/6VdCglXYV9H+05ZkJ+q6TNuu/E8ihM9xlEXPGYRsIfpfE47IMDg27oz
         3CiD7OrriV2/H085R9eKnLH69ddeOdlXLYQPuFMfVFT49arYpzpptY1j/afyL9rDGjfm
         xN4+ONbj+dXEAMpvDyOFpyVXg6AXZQ9pvCD7qyFnjaODQrayullL3vW6Rvi0YG50j7oM
         UD6h+quedWDrk866+Sy1P6XXcfpqVIf8cprRG9blCW1aJOGksvaztoGbjmtUiPuYkEWv
         ozjI1YQdaOAMI0HyuZsWKODVwZU6V8S8646E4Bu9i7S/HvXSPmE4O28k5AH1ASPNzXLI
         bp4w==
X-Gm-Message-State: ABy/qLZ8hFMbgt1Et6YduHLv66xXrTG5EzPk9YRpnm9oaYq7uPnL6Rfx
        42Wt9O/+fGtNF70FzVJM8rMqJpWUcWrr9fRzCG0=
X-Google-Smtp-Source: APBJJlGdQ+mZwEX7hoR7kwbuM2LjVWZ2BiFPsOtvISNt912jjNntEHQo8YA+l89fvmmiQE4Ea48isQ==
X-Received: by 2002:a05:6a20:3d85:b0:12c:9100:362f with SMTP id s5-20020a056a203d8500b0012c9100362fmr12083123pzi.4.1688879804232;
        Sat, 08 Jul 2023 22:16:44 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:1523:3ecb:e154:8f22? ([2409:8a55:301b:e120:1523:3ecb:e154:8f22])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b0066684d8115bsm5134939pfo.178.2023.07.08.22.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 22:16:43 -0700 (PDT)
Subject: Re: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via
 Page Pool)
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-6-aleksander.lobakin@intel.com>
 <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
 <09a9a9ef-cf77-3b60-2845-94595a42cf3e@intel.com>
From:   Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <71a8bab4-1a1d-cb1a-d75c-585a14c6fb2e@gmail.com>
Date:   Sun, 9 Jul 2023 13:16:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <09a9a9ef-cf77-3b60-2845-94595a42cf3e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/7 0:28, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Thu, 6 Jul 2023 20:47:28 +0800
> 
>> On 2023/7/5 23:55, Alexander Lobakin wrote:
>>
>>> +/**
>>> + * libie_rx_page_pool_create - create a PP with the default libie settings
>>> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
>>> + * @size: size of the PP, usually simply Rx queue len
>>> + *
>>> + * Returns &page_pool on success, casted -errno on failure.
>>> + */
>>> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
>>> +					    u32 size)
>>> +{
>>> +	struct page_pool_params pp = {
>>> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>> +		.order		= LIBIE_RX_PAGE_ORDER,
>>> +		.pool_size	= size,
>>> +		.nid		= NUMA_NO_NODE,
>>> +		.dev		= napi->dev->dev.parent,
>>> +		.napi		= napi,
>>> +		.dma_dir	= DMA_FROM_DEVICE,
>>> +		.offset		= LIBIE_SKB_HEADROOM,
>>
>> I think it worth mentioning that the '.offset' is not really accurate
>> when the page is split, as we do not really know what is the offset of
>> the frag of a page except for the first frag.
> 
> Yeah, this is read as "offset from the start of the page or frag to the
> actual frame start, i.e. its Ethernet header" or "this is just
> xdp->data - xdp->data_hard_start".

So the problem seems to be if most of drivers have a similar reading as
libie does here, as .offset seems to have a clear semantics which is used
to skip dma sync operation for buffer range that is not touched by the
dma operation. Even if it happens to have the same value of "offset from
the start of the page or frag to the actual frame start", I am not sure
it is future-proofing to reuse it.

When page frag is added, I didn't really give much thought about that as
we use it in a cache coherent system.
It seems we might need to extend or update that semantics if we really want
to skip dma sync operation for all the buffer ranges that are not touched
by the dma operation for page split case.
Or Skipping dma sync operation for all untouched ranges might not be worth
the effort, because it might need a per frag dma sync operation, which is
more costly than a batched per page dma sync operation. If it is true, page
pool already support that currently as my understanding, because the dma
sync operation is only done when the last frag is released/freed.

> 
>>
>>> +	};
>>> +	size_t truesize;
>>> +
>>> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);

As mentioned above, if we depend on the last released/freed frag to do the
dma sync, the pp.max_len might need to cover all the frag.

>>> +
>>> +	/* "Wanted" truesize, passed to page_pool_dev_alloc() */
>>> +	truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset + pp.max_len));
>>> +	pp.init_arg = (void *)truesize;
>>
>> I am not sure if it is correct to use pp.init_arg here, as it is supposed to
>> be used along with init_callback. And if we want to change the implemetation
> 
> I know. I abused it to save 1 function argument :p It's safe since I
> don't use init_callback (not an argument).
> I was thinking also of having a union in PP params or even a new field
> like "wanted true size", so that your function could even take values
> from there in certain cases (e.g. if I pass 0 as parameter).
> 
>> of init_callback, we may stuck with it as the driver is using it very
>> differently here.
>>
>> Is it possible to pass the 'wanted true size' by adding a parameter for
>> libie_rx_alloc()?
> 
> Yes, or I could store it somewhere on the ring, but looks uglier =\ This
> one does as well to some degree, but at least hidden in the library and
> doesn't show up in the drivers :D

It seems most hw driver know the size of memory it needs when creating
the ring/queue, setting the frag size and deciding how many is a page
split into before allocation seems like a possible future optimization.

For now, it would be better to add helper to acess pp.init_arg at least
instead of acess pp.init_arg directly to make it more obvious and make
the future optimization more easier.

> 
>>
>>> +
>>> +	return page_pool_create(&pp);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
> 
> Thanks,
> Olek

