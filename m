Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB246D8D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjDFB4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BEA9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29CF7618D1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B921C433EF;
        Thu,  6 Apr 2023 01:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680746211;
        bh=NfVX/6hHzwCtO9HI9+XPZetTVkhGP+gQgPt3MPubcPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuo7uiXVaEjL4NGKpZ/ikc8NnyHxIM22q0eFCcPGmhranX/JO3hTSRGZf2Y8eEAQL
         VeKbZ2PDbfGbh0icOYaML7+71C3fqLRioDIOS7pritKeZtSAR8+wIwuQf3gvJITAvP
         mqDuEA+9mr/JJYl9mwWQGzkpkpbTYxsZ9929/Hw8=
Date:   Wed, 5 Apr 2023 18:56:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     jaewon31.kim@samsung.com
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Message-Id: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
In-Reply-To: <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
References: <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
        <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p3>
        <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 10:44:19 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> >> ...
> >>
> >> --- a/drivers/dma-buf/heaps/system_heap.c
> >> +++ b/drivers/dma-buf/heaps/system_heap.c
> >> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> >>  	struct page *page, *tmp_page;
> >>  	int i, ret = -ENOMEM;
> >>  
> >> +	if (len / PAGE_SIZE > totalram_pages() / 2)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >
> >This seems so random.  Why ram/2 rather than ram/3 or 17*ram/35?
> 
> Hello
> 
> Thank you for your comment.
> 
> I just took the change from the old ion driver code, and actually I thought the
> half of all memory is unrealistic. It could be unwanted size like negative,
> or too big size which incurs slowness or OoM panic.
> 
> >
> >Better behavior would be to try to allocate what the caller asked
> >for and if that doesn't work out, fail gracefully after freeing the
> >partial allocations which have been performed thus far.  If dma_buf
> >is changed to do this then that change is useful in many scenarios other
> >than this crazy corner case.
> 
> I think you would like __GFP_RETRY_MAYFAIL. Actually T.J. Mercier recommended
> earlier, here's what we discussed.
> https://lore.kernel.org/linux-mm/20230331005140epcms1p1ac5241f02f645e9dbc29626309a53b24@epcms1p1/
> 
> I just worried about a case in which we need oom kill to get more memory but
> let me change my mind. That case seems to be rare. I think now it's time when
> we need to make a decision and not to allow oom kill for dma-buf system heap
> allocations.
> 
> But I still want to block that huge size over ram. For an unavailabe size,
> I think, we don't have to do memory reclaim or killing processes, and we can
> avoid freezing screen in user perspecitve.
> 
> This is eventually what I want. Can we check totalram_pages and and apply
> __GFP_RETRY_MAYFAIL?
> 
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -41,7 +41,7 @@ struct dma_heap_attachment {
>         bool mapped;
>  };
>  
> -#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> +#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP | __GFP_RETRY_MAYFAIL)
>  #define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>         struct page *page, *tmp_page;
>         int i, ret = -ENOMEM;
>  
> +       if (len / PAGE_SIZE > totalram_pages())
> +               return ERR_PTR(-ENOMEM);

We're catering for a buggy caller here, aren't we?  Are such large
requests ever reasonable?

How about we decide what's the largest reasonable size and do a
WARN_ON(larger-than-that), so the buggy caller gets fixed?
