Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9970A102
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjESUpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjESUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238DC116
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA3660C5D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 20:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801C1C433EF;
        Fri, 19 May 2023 20:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684529147;
        bh=WJO1c4PJ+6qGvmWHyWcDtGHu6W/qtzeSk7We3HLS+0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HbWF9ckmO8I/D9tphXQDuU04e1KhWw9QjwvCjln1ZDQ5kccZq5HgTDsM+qmZ3gIss
         iGUCUNfPILwV18RVcSig8Uh1m1X+kMUkElsXBXDEeEOxxFx/xQ682X54Z23vSlCKfm
         PXRV8QOS99m3hhrGzaHVpe0THU/hAPaUypF/VbVGAMhPToURJJ3DNOk0nyTBhOO3+8
         E/rZ+kVzTgat/r8MO7beGku9RaQ0VK5mwbpF8mOqX6Y5SoEtUvPJggbPFHyxA+WBlA
         /bEws/nR4a6KWCLU19P//aZSegN7dIqyIj5f8S+S1SRcgO5KHfRMhdznHnCangdM9G
         h3QxXRiOtJGoQ==
Date:   Fri, 19 May 2023 13:45:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 07/11] net: page_pool: add
 DMA-sync-for-CPU inline helpers
Message-ID: <20230519134545.5807e1d8@kernel.org>
In-Reply-To: <77d929b2-c124-d3db-1cd9-8301d1d269d3@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
        <20230516161841.37138-8-aleksander.lobakin@intel.com>
        <20230517211211.1d1bbd0b@kernel.org>
        <9feef136-7ff3-91a4-4198-237b07a91c0c@intel.com>
        <20230518075643.3a242837@kernel.org>
        <0dfa36f1-a847-739e-4557-fc43e2e8c6a7@intel.com>
        <20230518133627.72747418@kernel.org>
        <77d929b2-c124-d3db-1cd9-8301d1d269d3@intel.com>
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

On Fri, 19 May 2023 15:56:40 +0200 Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 18 May 2023 13:36:27 -0700
> >> I'll definitely take a look, I also like the idea of minimalistic and
> >> lightweight headers.
> >> page_pool.h and page_pool_drv.h? :D  
> > 
> > What I've been doing lately is split like this:
> > 
> > include/net/something.h           (simply includes all other headers)
> > include/net/something/types.h     (structs, defines, enums)
> > include/net/something/functions.h (inlines and function declarations)
> > 
> > If that's reasonable -- we should put the helpers under
> > 
> > include/net/page_pool/functions.h ?  
> 
> Hmm, all files that need something from page_pool.h usually need both
> types and functions. Not sure we'll benefit anything here.

Ack, in the scheme above most places (source files) would include
something.h, the something/types.h is just for other headers.
something/functions.h is basically never included directly.

> OTOH leaving
> those sync-for-cpu inlines alone allows to avoid including dma-mapping.h
> and currently only IAVF needs them. So my idea is:
> 
> - you need smth from PP, but not sync-for-cpu -- more lightweight
>   page_pool.h is for you;
> - you need sync-for-cpu (or maybe something else with heavy deps in the
>   future) -- just include page_pool_drv.h.

The idea makes sense in isolation, but I'm trying to figure out
a convention which would not require case-by-case discussions.

> I tried moving something else, but couldn't find anything that would
> give any win. <linux/mm.h> and <linux/ptr_ring.h> are needed to define
> `struct page_pool`, i.e. even being structured like in your example they
> would've gone into pp/types.h =\
> `struct ptr_ring` itself doesn't require any MM-related definitions, so
> would we split it into ptr_ring/{types,functions}.h, we could probably
> avoid a couple includes :D

Ack, not saying that we need to split now, it's just about the naming
(everyone's favorite topic).

I think that it's a touch weird to name the header _drv.h and then
include it in the core in multiple places (*cough* xdp_sock_drv.h). 
Also If someone needs to add another "heavy" static line for use by 
the core they will try to put it in page_pool.h rather than _drv.h...

I'd rather split the includes by the basic language-level contents,
first, then by the intended consumer, only if necessary. Language 
level sorting require less thinking :)

But none of this is important, if you don't wanna to do it, just keep 
the new helpers in page_pool.h (let's not do another _drv.h).
