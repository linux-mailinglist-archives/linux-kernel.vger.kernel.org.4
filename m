Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378F740705
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjF1AFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1AFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:05:02 -0400
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C410DE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:05:00 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:04:51 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687910698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=54OyhFsBGIZ/A36jD1GnMe8MSzqCQN967iGmLVj8WRI=;
        b=jaKhuxcGo8Uz8CSv7Ojnzxdj+hj0taVV5MzWNC3vNFOvIWC7C0bj8D9kSZoXD9X0X9sR3A
        pVl0R12Nma1NTN6I9W1A5K9dm/bEA7JCVv/zUYuzD6g3wSA8kRyVE3xvzCh3+h9PAyHLRQ
        lgv9cSbELdu2Kqw9qiNRCMbuWzb9zpk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: memory-failure: remove unneeded page state check in
 shake_page()
Message-ID: <20230628000451.GA1000547@ik1-406-35019.vs.sakura.ne.jp>
References: <20230625113430.2310385-1-linmiaohe@huawei.com>
 <20230626005221.GA353339@ik1-406-35019.vs.sakura.ne.jp>
 <2cd57a67-1cb2-83b8-3f73-6da72cd6159d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cd57a67-1cb2-83b8-3f73-6da72cd6159d@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:43:44AM +0800, Miaohe Lin wrote:
> On 2023/6/26 8:52, Naoya Horiguchi wrote:
> > On Sun, Jun 25, 2023 at 07:34:30PM +0800, Miaohe Lin wrote:
> >> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
> >> are not shrunk now. This check can be added back when a lightweight range
> >> based shrinker is available.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > This looks to me a good cleanup because the result of
> > "if (PageLRU(p) || is_free_buddy_page(p))" check is not used, so the check
> > itself is unneeded.
> > 
> >> ---
> >>  mm/memory-failure.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 5b663eca1f29..92f951df3e87 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -373,11 +373,10 @@ void shake_page(struct page *p)
> >>  	if (PageHuge(p))
> >>  		return;
> >>  
> >> -	if (!PageSlab(p)) {
> >> -		lru_add_drain_all();
> >> -		if (PageLRU(p) || is_free_buddy_page(p))
> >> -			return;
> >> -	}
> >> +	if (PageSlab(p))
> >> +		return;
> >> +
> >> +	lru_add_drain_all();
> >>  
> >>  	/*
> >>  	 * TODO: Could shrink slab caches here if a lightweight range-based
> > 
> > I think that this TODO comment can be put together with "if (PageSlab)" block.
> 
> Thanks for your comment and advice. Do you mean something like below?

Yes, this is what I mean.  Feel free to add my ack when posting v2.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thank you.

> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5b663eca1f29..66e7b3ceaf2d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -372,17 +372,14 @@ void shake_page(struct page *p)
>  {
>         if (PageHuge(p))
>                 return;
> -
> -       if (!PageSlab(p)) {
> -               lru_add_drain_all();
> -               if (PageLRU(p) || is_free_buddy_page(p))
> -                       return;
> -       }
> -
>         /*
>          * TODO: Could shrink slab caches here if a lightweight range-based
>          * shrinker will be available.
>          */
> +       if (PageSlab(p))
> +               return;
> +
> +       lru_add_drain_all();
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
> 
> Thanks.
> 
> 
