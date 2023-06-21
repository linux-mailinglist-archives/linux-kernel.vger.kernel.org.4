Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6573829B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFULzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFULzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A3D1706
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687348505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+J1qMM2RTjxatsaIkvpjnhKANFLWQpC2UlaADiJWrv4=;
        b=drtontr334mrAMDJfy48COyun789zOT7ntFhoFaRy7AHZ8kNULRC63zMr5WwRVZqSjmo7q
        qu15jxeS5tXAWOtFClbfrmUXEHicRBWqI9V+vn9xLvf/rEc0OgNG6xQPeD7Vfq6EjlFhEE
        sWVZ/SwTGbYxCEuccalpJLMr/26WObo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Mr-BIbGlNMK2cjQJMvkOZQ-1; Wed, 21 Jun 2023 07:55:04 -0400
X-MC-Unique: Mr-BIbGlNMK2cjQJMvkOZQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f8fe1f1199so20887855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348502; x=1689940502;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J1qMM2RTjxatsaIkvpjnhKANFLWQpC2UlaADiJWrv4=;
        b=FbUfiwgVE+G5K0cdhe3Ya2eY0zA79IH/+NC13UQ0RK7XhSQU1UFLO15p7gEXpi3hba
         /uLQAL8pz9t58EG23EfwkKuHdR2QdKI1M9JJwVMXJQvMdqI+49eUUUfqhU7/gagYj5Iu
         Iv5gEnmBq+YM+I0qVFZuS9SgFap+119x1f2A8NfkiDsUvuju/NYgpOmna6j4zAIAg+Dh
         d4awf49tv2gC+qK/iVVdR9cGx3QRfRu72EuRJfo9rwP80EzT3y7XR2DhwL6QaSsmYaXo
         8R2FjcR894PgfCeHIMQ/NeRfx1rpYx5rBLn1qGW/gfSO0mCrYla3CQv04Q2x/umSYnIL
         YRpg==
X-Gm-Message-State: AC+VfDywpJ6AzwIx3j8KujXCpicRqicNwuKd+UI25+8/bBMffykpL8nF
        eGbPzWXBOqxGZGx0hL89EhCx51XIQkVrS4GAYxgfYN02ExlkdGoaOPWgRP996zcIlwDDuABAk/3
        f6r292vIZA6gyuJ9jXUyH0dtL
X-Received: by 2002:a05:600c:203:b0:3f9:b81f:280d with SMTP id 3-20020a05600c020300b003f9b81f280dmr3255406wmi.16.1687348502740;
        Wed, 21 Jun 2023 04:55:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7G/KUvMHJtbnvHIUqOjaGZv4QFnXX0alnxEDmwLTKV4/+Nn0iTfkK33v8dtmk8b76/WGyB1Q==
X-Received: by 2002:a05:600c:203:b0:3f9:b81f:280d with SMTP id 3-20020a05600c020300b003f9b81f280dmr3255395wmi.16.1687348502447;
        Wed, 21 Jun 2023 04:55:02 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c225500b003f7f4dc6d14sm4754623wmm.14.2023.06.21.04.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 04:55:01 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3e6c191a-3be3-d6ff-92a2-2685bade2e66@redhat.com>
Date:   Wed, 21 Jun 2023 13:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Maryam Tahhan <mtahhan@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
 <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
 <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
 <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
 <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
 <CAKgT0UcNOYwxRP_zkaBaZh-VBL-CriL8dFG-VY7-FUyzxfHDWw@mail.gmail.com>
 <ZI8dP5+guKdR7IFE@lore-desk>
 <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>
 <ZJIXSyjxPf7FQQKo@lore-rh-laptop>
In-Reply-To: <ZJIXSyjxPf7FQQKo@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/06/2023 23.16, Lorenzo Bianconi wrote:
> [...]
> 
>>> I did some experiments using page_frag_cache/page_frag_alloc() instead of
>>> page_pools in a simple environment I used to test XDP for veth driver.
>>> In particular, I allocate a new buffer in veth_convert_skb_to_xdp_buff() from
>>> the page_frag_cache in order to copy the full skb in the new one, actually
>>> "linearizing" the packet (since we know the original skb length).
>>> I run an iperf TCP connection over a veth pair where the
>>> remote device runs the xdp_rxq_info sample (available in the kernel source
>>> tree, with action XDP_PASS):
>>>
>>> TCP clietn -- v0 === v1 (xdp_rxq_info) -- TCP server
>>>
>>> net-next (page_pool):
>>> - MTU 1500B: ~  7.5 Gbps
>>> - MTU 8000B: ~ 15.3 Gbps
>>>
>>> net-next + page_frag_alloc:
>>> - MTU 1500B: ~  8.4 Gbps
>>> - MTU 8000B: ~ 14.7 Gbps
>>>
>>> It seems there is no a clear "win" situation here (at least in this environment
>>> and we this simple approach). Moreover:
>>
>> For the 1500B packets it is a win, but for 8000B it looks like there
>> is a regression. Any idea what is causing it?
> 
> nope, I have not looked into it yet.
> 

I think I can explain via using micro-benchmark numbers.
(Lorenzo and I have discussed this over IRC, so this is our summary)

*** MTU 1500***

* The MTU 1500 case, where page_frag_alloc is faster than PP (page_pool):

The PP alloc a 4K page for MTU 1500. The cost of alloc + recycle via
ptr_ring cost 48 cycles (page_pool02_ptr_ring Per elem: 48 cycles(tsc)).

The page_frag_alloc API allocates a 32KB order-3 page, and chops it up
for packets.  The order-3 alloc + free cost 514 cycles (page_bench01:
alloc_pages order:3(32768B) 514 cycles). The MTU 1500 needs alloc size
1514+320+256 = 2090 bytes.  In 32KB we can fit 15 packets.  Thus, the
amortized cost per packet is only 34.3 cycles (514/15).

Thus, this explains why page_frag_alloc API have an advantage here, as
amortized cost per packet is lower (for page_frag_alloc).


*** MTU 8000 ***

* The MTU 8000 case, where PP is faster than page_frag_alloc.

The page_frag_alloc API cannot slice the same 32KB into as many packets.
The MTU 8000 needs alloc size 8000+14+256+320 = 8590 bytes.  This is can
only store 3 full packets (32768/8590 = 3.81).
Thus, cost is 514/3 = 171 cycles.

The PP is actually challenged at MTU 8000, because it unfortunately
leads to allocating 3 full pages (12KiB), due to needed alloc size 8590
bytes. Thus cost is 3x 48 cycles = 144 cycles.
(There is also a chance of Jakubs "allow_direct" optimization in 
page_pool_return_skb_page to increase performance for PP).

Thus, this explains why PP is fastest in this case.


*** Surprising insights ***

My (maybe) surprising conclusion is that we should combine the two
approaches.  Which is basically what Lin's patchset is doing!
Thus, I'm actually suddenly become a fan of this patchset...

The insight is that PP can also work with higher-order pages and the
cost of PP recycles via ptr_ring will be the same, regardless of page
order size.  Thus, we can reduced the order-3 cost 514 cycles to
basically 48 cycles, and fit 15 packets (MTU 1500) resulting is
amortized allocator cost 48/15 = 3.2 cycles.

On the PP alloc-side this will be amazingly fast. When PP recycles frags
side, see page_pool_defrag_page() there is an atomic_sub operation.
I've measured atomic_inc to cost 17 cycles (for optimal non-contended
case), thus 3+17 = 20 cycles, it should still be a win.


--Jesper

