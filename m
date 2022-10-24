Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029AA60BA43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiJXUbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiJXUaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:30:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909A8106A6E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8205CE13C1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAD9C433C1;
        Mon, 24 Oct 2022 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666628118;
        bh=fbb9TnyA4/QkQJN70OgJtJjtXVcbpv/1y+hOOr3/wPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFybjEOCLlMv8grYfY0I4MiqF+Ww8ZGQCeLIqhmF8tony0k7HuNvErIitm1JgIBbM
         xGLMfLfjRLMYzjZJeZDOnHYrwoNh/GGB5tTW3yP/nnGPlOejt4fBaPAq40LUl3CArB
         qMS8WTcP3IUBD6aoV4lxwRLFu5xaoKXbk9iCu5uIevLy7Ua9a/a5VB1b5ZmY4kXPSZ
         Ut/FVUKndGeEFHwE0MDt2fKlaFJV2MhrdZZy63Xw2hl5SWy7+guy1NyMcpK4qgi9gf
         FMjbCdzl4VRck7aj0nw7vTeMG6PPDsXHfAK5wcl95ScxdowLjS65D6TtMkrju/0JEY
         jMtNnq48xwFlg==
Date:   Mon, 24 Oct 2022 19:15:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: remove repeat round
Message-ID: <Y1a6BoawCoDDCo/K@kernel.org>
References: <20221019120337.2098298-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019120337.2098298-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 08:03:37PM +0800, Yajun Deng wrote:
> Subject: memblock: remove repeat round

Please make the patch subject more detailed. Say

membloc: don't run loop in memblock_add_range() twice

> There is no need round twice in memblock_add_range().
> 
> We can call memblock_double_array() to extand the size if type->cnt no

                                        ^ extend

> less than type->max before memblock_insert_region(), otherwise we can

s/no less than/greater or equal to/

> insert the new region directly.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/memblock.c | 54 +++++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 38 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..1679244b4a1a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -578,7 +578,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  				phys_addr_t base, phys_addr_t size,
>  				int nid, enum memblock_flags flags)
>  {
> -	bool insert = false;
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
>  	int idx, nr_new;
> @@ -598,22 +597,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  		return 0;
>  	}
>  
> -	/*
> -	 * The worst case is when new range overlaps all existing regions,
> -	 * then we'll need type->cnt + 1 empty regions in @type. So if
> -	 * type->cnt * 2 + 1 is less than type->max, we know
> -	 * that there is enough empty regions in @type, and we can insert
> -	 * regions directly.
> -	 */
> -	if (type->cnt * 2 + 1 < type->max)
> -		insert = true;
> -
> -repeat:
> -	/*
> -	 * The following is executed twice.  Once with %false @insert and
> -	 * then with %true.  The first counts the number of regions needed
> -	 * to accommodate the new area.  The second actually inserts them.
> -	 */
>  	base = obase;
>  	nr_new = 0;

I believe nr_new variable is no longer needed, is it?
  
> @@ -635,10 +618,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  #endif
>  			WARN_ON(flags != rgn->flags);
>  			nr_new++;
> -			if (insert)
> -				memblock_insert_region(type, idx++, base,
> -						       rbase - base, nid,
> -						       flags);
> +
> +			if ((type->cnt >= type->max) &&
> +			    (memblock_double_array(type, obase, size) < 0))

	if ((type->cnt >= type->max) &&
	    memblock_double_array(type, obase, size))

would be just fine.

I'd appreciate a comment above the if statement explaining when the
allocation is required.

> +				return -ENOMEM;
> +
> +			memblock_insert_region(type, idx++, base,
> +					       rbase - base, nid,
> +					       flags);
>  		}
>  		/* area below @rend is dealt with, forget about it */
>  		base = min(rend, end);
> @@ -647,28 +634,19 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	/* insert the remaining portion */
>  	if (base < end) {
>  		nr_new++;
> -		if (insert)
> -			memblock_insert_region(type, idx, base, end - base,
> -					       nid, flags);
> +		if ((type->cnt >= type->max) &&
> +		    (memblock_double_array(type, obase, size) < 0))
> +			return -ENOMEM;
> +
> +		memblock_insert_region(type, idx, base, end - base,
> +				       nid, flags);
>  	}
>  
>  	if (!nr_new)
>  		return 0;
>  
> -	/*
> -	 * If this was the first round, resize array and repeat for actual
> -	 * insertions; otherwise, merge and return.
> -	 */
> -	if (!insert) {
> -		while (type->cnt + nr_new > type->max)
> -			if (memblock_double_array(type, obase, size) < 0)
> -				return -ENOMEM;
> -		insert = true;
> -		goto repeat;
> -	} else {
> -		memblock_merge_regions(type);
> -		return 0;
> -	}
> +	memblock_merge_regions(type);

A blank line here would be nice.

> +	return 0;
>  }
>  
>  /**
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
