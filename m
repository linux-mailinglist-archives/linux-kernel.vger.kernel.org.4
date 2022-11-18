Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF08630483
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 00:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiKRXkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 18:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiKRXh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:37:57 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B4EA6A0C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:22:46 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id jr19so4148933qtb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTPRlJSX2DLHg3q6WEUslM2aHDz3cJkv4J+i/NOGxF8=;
        b=75OTZs/um0vrPFpf4rivUwFVfj569zfn8Hctoup+Fiv3oEqtIn6IcBbfbBi6nnc/bg
         +sv4KCRJeHTLu/hxv/C79WXWDvufJOLxFizqU3kSkItW/vZ+W4KQxRlvEHDqBH2KApqX
         2+vhesXQDjfneOy93QfjPCfRnRIP4KLc0S07SuuXkdv7MSijUXpYNj/vl50qwidHgMaR
         RiwkvOb2FzxMWxSsf7nIKyx2IJobE4YFPoQl8/+bOV7mWjlMb/9RvAtAsJz2xj/LwFVm
         YgpYyNnEw1OJCvTUD5F/qGt1aVaZFwiGHKM0w2C9V9L3tFjRNI7gEgopa/C81ACAYm0u
         6IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTPRlJSX2DLHg3q6WEUslM2aHDz3cJkv4J+i/NOGxF8=;
        b=SJDJx8jZHZGD1MoZzqo7/QjISeFF9pHAee7g3/+lHWYZsLyCvOVW+rAZjx5oolE+CP
         r54jyRsy/TUhDj7t9QYUmL91x8m5D5iUsuPnLAgVdsBUMrb4HyGRQmFKTOCZLhcExA5e
         xi4EeR5PhVMiFdQiRBSbdBOtGRAQPo30kLzbAF+h+H5q0bnpqWPlUtuLVgURlIP9cnGS
         rIPlNaNFjJ+bKhW1nq5UVKEMdcPkuzzQcn4AVwylhMFjqz7MbOxxuo2GMCRkCsWhV1sN
         EocjaWxZfsxHSG5VDGtcVrPEtBQsaRre+Wva0oeY3UuzmDAVqkTd/rV5oiODNUYS+qaf
         d0RQ==
X-Gm-Message-State: ANoB5pnbxAir0P0owN+36UxI9/+scmIKmduE4IoLpLfCZQ57rhFzbLBN
        gJX6yQZBVYdPS7fLA+GZuladLg==
X-Google-Smtp-Source: AA0mqf4Lax1B626EO0404yB6hsv9w/QkDTAth8qheZdYexzp5WcpdsNEENwKQG2bnhqg75Um2kQsiQ==
X-Received: by 2002:ac8:4a10:0:b0:3a5:30f8:17b4 with SMTP id x16-20020ac84a10000000b003a530f817b4mr8810660qtq.115.1668813766064;
        Fri, 18 Nov 2022 15:22:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id t7-20020a37ea07000000b006fa2cc1b0fbsm3304307qkj.11.2022.11.18.15.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:22:45 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:23:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3gT3bZT9yAXGY6C@cmpxchg.org>
References: <20221118182407.82548-1-nphamcs@gmail.com>
 <20221118182407.82548-5-nphamcs@gmail.com>
 <Y3fdsTDFgCzhcDwo@google.com>
 <Y3flcAXNxxrvy3ZH@cmpxchg.org>
 <Y3f6habiVuV9LMcu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3f6habiVuV9LMcu@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:35:01PM -0800, Minchan Kim wrote:
> On Fri, Nov 18, 2022 at 03:05:04PM -0500, Johannes Weiner wrote:
> > On Fri, Nov 18, 2022 at 11:32:01AM -0800, Minchan Kim wrote:
> > > On Fri, Nov 18, 2022 at 10:24:05AM -0800, Nhat Pham wrote:
> > > > @@ -1444,6 +1473,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > > > 
> > > >  	/* We completely set up zspage so mark them as movable */
> > > >  	SetZsPageMovable(pool, zspage);
> > > > +out:
> > > > +#ifdef CONFIG_ZPOOL
> > > > +	/* Move the zspage to front of pool's LRU */
> > > > +	move_to_front(pool, zspage);
> > > > +#endif
> > > >  	spin_unlock(&pool->lock);
> > > 
> > > Please move the move_to_front into zs_map_object with ZS_MM_WO with
> > > comment with "why we are doing only for WO case".
> > 
> > I replied to the other thread, but I disagree with this request.
> > 
> > The WO exception would be as zswap-specific as is the
> > rotate-on-alloc. It doesn't make the resulting zsmalloc code any
> 
> That's true but at least, zs_pool allocators have the accessor so
> that's fair place to have the LRU updating. I guess that's why
> you agreed that's better place. No?
> 
> I understand that's zswap-specific that the bad design keeps
> pushing smelly code into allocators and then "push to take it
> since other were already doing" with "we will take them off with
> better solution in future". I am really struggling to understand
> this concept. Johannes, Is that really how we work over a decade?

My point was that there is no difference between having zswap code in
alloc or in map. And there is a small upside to having it in alloc
because of the other backends.

But I won't fight you on it. The code isn't going to stay like this
for long anyway.
