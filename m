Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0A72F3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjFNEks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFNEkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA41A7;
        Tue, 13 Jun 2023 21:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F288063D81;
        Wed, 14 Jun 2023 04:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4107C433C8;
        Wed, 14 Jun 2023 04:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686717643;
        bh=0ucmmW3adV4+eqQVBYgvmKckBTOl6NDz0Ul52vNk6IM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dg5101Tl455j/arfoVjzrVjaCZJ819UcB4X9QiFmxupTrdGqx1Dqyyu0LzxEjeSgQ
         bgdUJ+70vxtma18+RsVJ0os0UTx/4PnxmeQJjDfraBHIkaOCUPK2KFcudlKy46vMHD
         jYPxoEWIB1RnzC9hoIbnBXX63RaKo4mkzvlj1yVqpmbtuPP1j1kDwPRgoKltNymPi5
         dDy8BM78W/Tsxmcpl3HuV9Sux36JiZIb5qtTHEOOazDoSlftFhRcXNzDW2yVdAStsB
         LLmwm8OEhXtnYN0V75Pl0o5YInS/HjzxIkDWfq2I/XtBH01g+SaFykQCa8kBEKI888
         oBw+xT+d8oG0Q==
Date:   Tue, 13 Jun 2023 21:40:41 -0700
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
Message-ID: <20230613214041.1c29a357@kernel.org>
In-Reply-To: <20230612130256.4572-6-linyunsheng@huawei.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-6-linyunsheng@huawei.com>
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

On Mon, 12 Jun 2023 21:02:56 +0800 Yunsheng Lin wrote:
> +2. page_pool_alloc_frag(): allocate memory with page splitting when driver knows
> +   that the memory it need is always smaller than or equal to half of the page
> +   allocated from page pool. Page splitting enables memory saving and thus avoid
> +   TLB/cache miss for data access, but there also is some cost to implement page
> +   splitting, mainly some cache line dirtying/bouncing for 'struct page' and
> +   atomic operation for page->pp_frag_count.
> +
> +3. page_pool_alloc(): allocate memory with or without page splitting depending
> +   on the requested memory size when driver doesn't know the size of memory it
> +   need beforehand. It is a mix of the above two case, so it is a wrapper of the
> +   above API to simplify driver's interface for memory allocation with least
> +   memory utilization and performance penalty.

Seems like the semantics of page_pool_alloc() are always better than
page_pool_alloc_frag(). Is there a reason to keep these two separate?
