Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38174C112
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 07:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGIFQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjGIFQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 01:16:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6F102;
        Sat,  8 Jul 2023 22:16:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b8b4749013so24936295ad.2;
        Sat, 08 Jul 2023 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688879808; x=1691471808;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5IT/4pg2ojRd4xm57HWhrEgHwR41enNj19n7FJ7HSQ=;
        b=M6th2hcmP2yhN28ewtB2KAsywav6oXtLYTfObWDIyUVcRH2JmHoSX1GBNT9Y1MGboT
         J0N7FaO9RXNehWOtIMbDhoR9TsIa9I8tn5QDTddEiT9xncgyfG8OQYR0NHEyIY5IrydX
         FcDOJ6+ymOJJyn7Q7pVgednnypGlgfZA1iwTnJVm9yERN1cWUe6+IPg0ujcWZZj41y/z
         OQpxZVXY8R1sYRGDBaPwe6LS1YUECU73KOYvqvOXOZvFU1lHIMRZuUPBAXv4EwvfZkLE
         qS884K9+hv8H8TlAWP2plkTb6yGqpj16ear8ie/CXrj7J3+dgvoQtDU4Kml+0YzrRgiY
         qYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688879808; x=1691471808;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5IT/4pg2ojRd4xm57HWhrEgHwR41enNj19n7FJ7HSQ=;
        b=cUDKrFRLOL0nbkjJc+nSR9XIlrNin5XUhSD16V1rdzswITgFbHLLRwrmlDm3CKPt4F
         Z095OtgtUjx6cJdR9lflz4R7+05kf1keqwuXvZxM82H4Q568Ylm7IhLxyTR7A46aycnd
         fXsGecytcFT1Q0ZiptqANtihQRMWdqUYdSJ7RatZ4TS/aTTCoaa41F/7Rgm1Kz6XGes3
         xnJiSWbzizZBNl+JkxdCzlVlukT4jLvLgrTDOpYBcMu8YG1rUrVob7X8Oi8nY2iR65Ag
         t6GRkKXk7K82dHTXa0Xnhc7fHXoIHL8Un4AQL5wVggrfTifdnEcBr3zx4q0MLktmDmW8
         IuZg==
X-Gm-Message-State: ABy/qLYOt0JlXl1c24QhKBGPEaGS+jgFd0y/wMC8pKOaC1N5Uj/F9M1Y
        slSml8jeZdmJegDucW2Eh0BVhZgC7WsxMXTrhXA=
X-Google-Smtp-Source: APBJJlEvHN3XmnInifh1UC3s8BpriGfww6vlI8aI3/l8lfEJntt8m/UB1LDbt6hPZDlePX07akcwpQ==
X-Received: by 2002:a17:902:d507:b0:1b9:d335:2216 with SMTP id b7-20020a170902d50700b001b9d3352216mr4003737plg.20.1688879807819;
        Sat, 08 Jul 2023 22:16:47 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:1523:3ecb:e154:8f22? ([2409:8a55:301b:e120:1523:3ecb:e154:8f22])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001ab12ccc2a7sm5669261pli.98.2023.07.08.22.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 22:16:47 -0700 (PDT)
Subject: Re: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
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
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
 <bc495d87-3968-495f-c672-bf1bab38524a@intel.com>
From:   Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <4946b9df-66ea-d184-b97c-0ba687e41df8@gmail.com>
Date:   Sun, 9 Jul 2023 13:16:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <bc495d87-3968-495f-c672-bf1bab38524a@intel.com>
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

On 2023/7/7 0:38, Alexander Lobakin wrote:

...
 
>>
>>>  /**
>>> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
>>>   **/
>>>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>>>  {
>>> -	struct device *dev = rx_ring->dev;
>>> -	int bi_size;
>>> +	struct page_pool *pool;
>>> +
>>> +	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
>>> +					 rx_ring->count);
>>
>> If a page is able to be spilt between more than one desc, perhaps the
>> prt_ring size does not need to be as big as rx_ring->count.
> 
> But we doesn't know in advance, right? Esp. given that it's hidden in
> the lib. But anyway, you can only assume that in regular cases if you
> always allocate frags of the same size, PP will split pages when 2+
> frags can fit there or return the whole page otherwise, but who knows
> what might happen.

It seems intel driver is able to know the size of memory it needs when
creating the ring/queue/napi/pp, maybe the driver only tell the libie
how many descs does it use for queue, and libie can adjust it accordingly?

> BTW, with recent recycling optimization, most of recycling is done
> directly through cache, not ptr_ring. So I'd even say it's safe to start
> creating smaller ptr_rings in the drivers.

The problem is that we may use more memory than before for certain case
if we don't limit the size of ptr_ring, unless we can ensure all of
recycling is done directly through cache, not ptr_ring.

> 
>>
>>> +	if (IS_ERR(pool))
>>> +		return PTR_ERR(pool);
>>> +
>>> +	rx_ring->pp = pool;
> 
> [...]
> 
>>>  	/* build an skb around the page buffer */
>>> -	skb = napi_build_skb(va - IAVF_SKB_PAD, truesize);
>>> -	if (unlikely(!skb))
>>> +	skb = napi_build_skb(va, rx_buffer->truesize);
>>> +	if (unlikely(!skb)) {
>>> +		page_pool_put_page(page->pp, page, size, true);
>>
>> Isn't it more correct to call page_pool_put_full_page() here?
>> as we do not know which frag is used for the rx_buffer, and depend
>> on the last released frag to do the syncing, maybe I should mention
>> that in Documentation/networking/page_pool.rst.
> 
> Ooof, maybe. My first try with PP frags. So when we use frags, we always
> must use _full_page() / p.max_len instead of the actual frame size?

Currently, _full_page() / p.max_len must be used to ensure the correct
dma sync operation.
But as mentioned in the previous patch, it might be about what is the
semantics of dma sync operation for page split case.

> 
