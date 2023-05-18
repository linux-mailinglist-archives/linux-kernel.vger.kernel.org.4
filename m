Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE3707A83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjERHDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjERHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:03:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698ED2D63
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:03:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so11459075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684393425; x=1686985425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmE3Hw/g7PPXrHo8vcI6AjK/ohP/P6DVA7E2EEZA5aw=;
        b=lNypA+WGF2vO1hR7ikW9cji9tuOPvcbtbUBOxHzGqO4xtpMGVB6DkS1/BXmv9xnBAj
         L4XUoIwAROLoDGxQc7FPnw+nIJnpo0e5vuiaPH3mNf8/Qm9m4WgJUXgFSHOMVqF8kQF0
         lGq98PFQ6c+vLqDalLC72hlWN0qUAALcjHXfF3pijF/1SVHSRbm3z5gN8zvLEWFu69aR
         1Gw5PfG+ns+3qIjk+4WbR6QqLMby0ilKS4tz60gv8qfooG6Py867g57LRIEukAXUBzpm
         D2thI7uvQKTaDqu89O5+AjN7X/RqPl6B4z+gsMxjNPlT9HOo3ORGOIDxnBauldOllBpk
         vwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684393425; x=1686985425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmE3Hw/g7PPXrHo8vcI6AjK/ohP/P6DVA7E2EEZA5aw=;
        b=PnOKJh+Jt/BsB3K6XcfEkIxTE0O6IwHkN6//NAv3VAcMdAyASdj+/+iBM+iFXTev1W
         0WNqnv+xxhE7Tqgl3T4PnP0/KSBWrHWWuzTynC2aWeFfatnhOzHMGXKAtyfrfVKiWAJH
         w6pOpKRYjxxT39BMhC0/aLeTmTU0MTW9Z29wHXEAvzhWZ4I6+oJd2LvWVTGYvlNeWpnP
         nj9sbTF35d6YicCnhZqbv/NNV8OLVmJBCzZL/0QJGNJ8/qgbkk6tk8QhVgRdXevfhzVT
         bQCMYQ6JxPkvyBqJk1CcsihzJxpSRlT0QVB1VmIZeNeMoN8Jk4Efz3GTw8shBcTi7mXu
         2oeA==
X-Gm-Message-State: AC+VfDwWe8Ar1bAPw5fKsMlDI6P70vGqsWRYK8RFNWZ9yOpNtL5C6GQL
        85wXnRCA+dQOmjWXGSlanTVoYQ==
X-Google-Smtp-Source: ACHHUZ7KA7gW++urZQKvPGWLM/0di9BvXzgoPwnUHrCMESNRXMuASR1PwcyqGPzX8tXB+3miGBskrg==
X-Received: by 2002:adf:fb08:0:b0:309:3c0c:b2c1 with SMTP id c8-20020adffb08000000b003093c0cb2c1mr572723wrr.23.1684393424852;
        Thu, 18 May 2023 00:03:44 -0700 (PDT)
Received: from hera (ppp176092130041.access.hol.gr. [176.92.130.41])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b00307a83ea722sm1110439wrw.58.2023.05.18.00.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:03:44 -0700 (PDT)
Date:   Thu, 18 May 2023 10:03:41 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] net: page_pool: add DMA-sync-for-CPU
 inline helpers
Message-ID: <ZGXNzX77/5cXqAhe@hera>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-8-aleksander.lobakin@intel.com>
 <20230517211211.1d1bbd0b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517211211.1d1bbd0b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> On Wed, May 17, 2023 at 09:12:11PM -0700, Jakub Kicinski wrote:
> On Tue, 16 May 2023 18:18:37 +0200 Alexander Lobakin wrote:
> > Each driver is responsible for syncing buffers written by HW for CPU
> > before accessing them. Almost each PP-enabled driver uses the same
> > pattern, which could be shorthanded into a static inline to make driver
> > code a little bit more compact.
> > Introduce a couple such functions. The first one takes the actual size
> > of the data written by HW and is the main one to be used on Rx. The
> > second does the same, but only if the PP performs DMA synchronizations
> > at all. The last one picks max_len from the PP params and is designed
> > for more extreme cases when the size is unknown, but the buffer still
> > needs to be synced.
> > Also constify pointer arguments of page_pool_get_dma_dir() and
> > page_pool_get_dma_addr() to give a bit more room for optimization,
> > as both of them are read-only.
>
> Very neat.
>
> > diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> > index 8435013de06e..f740c50b661f 100644
> > --- a/include/net/page_pool.h
> > +++ b/include/net/page_pool.h
> > @@ -32,7 +32,7 @@
> >
> >  #include <linux/mm.h> /* Needed by ptr_ring */
> >  #include <linux/ptr_ring.h>
> > -#include <linux/dma-direction.h>
> > +#include <linux/dma-mapping.h>
>
> highly nit picky - but isn't dma-mapping.h pretty heavy?
> And we include page_pool.h in skbuff.h. Not that it matters
> today, but maybe one day we'll succeed putting skbuff.h
> on a diet -- so perhaps it's better to put "inline helpers
> with non-trivial dependencies" into a new header?
>
> >  #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
> >  					* map/unmap
>
> > +/**
> > + * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
> > + * @pool: page_pool which this page belongs to
> > + * @page: page to sync
> > + * @dma_sync_size: size of the data written to the page
> > + *
> > + * Can be used as a shorthand to sync Rx pages before accessing them in the
> > + * driver. Caller must ensure the pool was created with %PP_FLAG_DMA_MAP.
> > + */
> > +static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> > +					      const struct page *page,
> > +					      u32 dma_sync_size)
> > +{
> > +	dma_sync_single_range_for_cpu(pool->p.dev,
> > +				      page_pool_get_dma_addr(page),
> > +				      pool->p.offset, dma_sync_size,
> > +				      page_pool_get_dma_dir(pool));
>
> Likely a dumb question but why does this exist?
> Is there a case where the "maybe" version is not safe?
>

I got similar concerns here.  Syncing for the cpu is currently a
responsibility for the driver.  The reason for having an automated DMA sync
is that we know when we allocate buffers for the NIC to consume so we can
safely sync them accordingly.  I am fine having a page pool version for the
cpu sync, but do we really have to check the pp flags for that?  IOW if you
are at the point that you need to sync a buffer for the cpu *someone*
already mapped it for you.  Regardsless of who mapped it the sync is
identical

> > +}
> > +
> > +/**
> > + * page_pool_dma_maybe_sync_for_cpu - sync Rx page for CPU if needed
> > + * @pool: page_pool which this page belongs to
> > + * @page: page to sync
> > + * @dma_sync_size: size of the data written to the page
> > + *
> > + * Performs DMA sync for CPU, but only when required (swiotlb, IOMMU etc.).
> > + */
> > +static inline void
> > +page_pool_dma_maybe_sync_for_cpu(const struct page_pool *pool,
> > +				 const struct page *page, u32 dma_sync_size)
> > +{
> > +	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> > +		page_pool_dma_sync_for_cpu(pool, page, dma_sync_size);
> > +}

Thanks
/Ilias
