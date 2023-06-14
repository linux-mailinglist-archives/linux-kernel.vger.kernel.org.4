Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F01730581
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjFNQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2951BC6;
        Wed, 14 Jun 2023 09:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D186363EC8;
        Wed, 14 Jun 2023 16:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE09C433C0;
        Wed, 14 Jun 2023 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686761811;
        bh=JDM0HAS6PaF/JR+qgqrW0SQvJ7ciVgLgv02udiikKF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lWoXAirWNGlRowrSNl53iWU7sefp8jy2qQoYUvLgsAZZHYTTuHm0i1aG7UvY1WiKe
         o/FijxZxDdaEp9RpSFAOwgPvlOQPCHqZPTc9fkax1p3WS0p8c9u7DABC1zPLIhl6oM
         hhzndx/99LsY3KtkY1XEdh9BqeDlhKIHvZDhw2oqmTJLhSjq5lFkTsRxqAQzuhT9yj
         aEqoYYwGVubSxcBU31D11zjeke0Ngg9hvPSPzyIn88YYXbLfPKSCvJ1hVkqCzrcmpT
         9QqWR0liaBff4/zRssAvO/SwZmSl5JyCmiG15Qsv5kXl34npzpqwTertF8tKtrmcfe
         k3WU9Nd/ufj/g==
Date:   Wed, 14 Jun 2023 09:56:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <linux-doc@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v4 5/5] page_pool: update document about frag
 API
Message-ID: <20230614095649.5f7d8d40@kernel.org>
In-Reply-To: <1dc9b2e3-65ee-aa33-d604-a758fea98eb8@huawei.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-6-linyunsheng@huawei.com>
        <20230613214041.1c29a357@kernel.org>
        <1dc9b2e3-65ee-aa33-d604-a758fea98eb8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 20:04:39 +0800 Yunsheng Lin wrote:
> > Seems like the semantics of page_pool_alloc() are always better than
> > page_pool_alloc_frag(). Is there a reason to keep these two separate?  
> 
> I am agree the semantics of page_pool_alloc() is better, I was thinking
> about combining those two too.
> The reason I am keeping it is about the nic hw with fixed buffer size for
> each desc, and that buffer size is always smaller than or equal to half
> of the page allocated from page pool, so it doesn't bother doing the
> checking of 'size << 1 > max_size' and doesn't care about the actual
> truesize.

I see. Let's reorg the documentation, then? Something along the lines
of, maybe:


The page_pool allocator is optimized for recycling page or page frag used by skb
packet and xdp frame.

Basic use involves replacing napi_alloc_frag() and alloc_pages() calls
with page_pool_alloc(). page_pool_alloc() allocates memory with or
without page splitting depending on the requested memory size.

If the driver knows that it always requires full pages or its allocates
are always smaller than half a page, it can use one of the more specific
API calls:

1. page_pool_alloc_pages(): allocate memory without page splitting when
   driver knows that the memory it need is always bigger than half of the
   page allocated from page pool. There is no cache line dirtying for
   'struct page' when a page is recycled back to the page pool.

2. page_pool_alloc_frag(): allocate memory with page splitting when driver knows
   that the memory it need is always smaller than or equal to half of the page
   allocated from page pool. Page splitting enables memory saving and thus avoid
   TLB/cache miss for data access, but there also is some cost to implement page
   splitting, mainly some cache line dirtying/bouncing for 'struct page' and
   atomic operation for page->pp_frag_count.
