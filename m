Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059A973384E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjFPSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjFPSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35183A9D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C07F61375
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 18:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1909BC433C8;
        Fri, 16 Jun 2023 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941231;
        bh=/Qr0GLXmqNAy+vLSOaufC5FpI6BR6vkDi5r1CSKe30A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S7ri9AujBQSOsuj+NUkAT5AcrRqR1wK5bAffw7fsPR4vCkL4onocjtO3Q7Gqj/LNK
         zljqj3vhsUYnKPxNwuTQi61MpVm7sdkuRX5D93OCohEh9L/DEvXtuKz7ebBzc2MOIx
         NEWszrXK1bjESq/wrW4Q8NHZyVNQ4IUST1WWzmfpKJefEos3L+VrUQ9zd+QsDYGDR5
         xBvUKerZwywBlzfnQZn4Q//vUR50Gz1gTnfgkvCR081InJ235lMWdhvf6ppJqJN3N+
         zoALPRN/w+gQnYXb4r9x7PfUoAy9cvRkU0hxav1/ch8Oua4l1W2Zk29XFOwoViSCNZ
         4JSAVNkY9Kztg==
Date:   Fri, 16 Jun 2023 11:47:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, brouer@redhat.com,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Maryam Tahhan <mtahhan@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
Message-ID: <20230616114710.7e746dea@kernel.org>
In-Reply-To: <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
References: <20230609131740.7496-1-linyunsheng@huawei.com>
        <20230609131740.7496-4-linyunsheng@huawei.com>
        <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
        <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com>
        <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
        <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
        <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
        <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
        <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
        <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
        <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
        <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 20:41:45 +0200 Jesper Dangaard Brouer wrote:
> > This is a sort-of. One thing that has come up as of late is that all
> > this stuff is being moved over to folios anyway and getting away from
> > pages. In addition I am not sure how often we are having to take this
> > path as I am not sure how many non-Tx frames end up having to have
> > fragments added to them. For something like veth it might be more
> > common though since Tx becomes Rx in this case.  
> 
> I'm thinking, that is it very unlikely that XDP have modified the
> fragments.  So, why are we allocating and copying the fragments?
> Wouldn't it be possible for this veth code to bump the refcnt on these
> fragments? (maybe I missed some detail).

They may be page cache pages, AFAIU.
