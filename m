Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D3963FABF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiLAWmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiLAWl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:41:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75208B398
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3052F6217C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790E6C433C1;
        Thu,  1 Dec 2022 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669934464;
        bh=fFoarzAFHYeupBpefmPHT7y3xrRGiNIZ22fWIBPhPrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CX5eYhGHM/Nvq6gev2G+bKrhNNqDV1AruJYrEs4xxCy5BTtEb2qE28/O8BJEV0lu+
         6A3wAjA6Q1Jc98Mopmqmgj4JlsB+jHnrwPLoAyqVskoXypLiglwmYn0xtQUwsbII5a
         7M3be/tbNcXzgt0DCMYsYw8DErMR7we2BRhwdHro=
Date:   Thu, 1 Dec 2022 14:41:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wonder_rock@126.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/page_alloc: update comments in __free_pages_ok()
Message-Id: <20221201144103.8f79e5272e75957a34de4c4e@linux-foundation.org>
In-Reply-To: <20221201135045.31663-1-wonder_rock@126.com>
References: <20221201135045.31663-1-wonder_rock@126.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Dec 2022 21:50:45 +0800 wonder_rock@126.com wrote:

> Add a comment to explain why we call get_pfnblock_migratetype() twice
> in __free_pages_ok().
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1702,6 +1702,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>  	if (!free_pages_prepare(page, order, true, fpi_flags))
>  		return;
>  
> +	/*
> +	 * Calling get_pfnblock_migratetype() without spin_lock_irqsave() here
> +	 * is used to avoid calling get_pfnblock_migratetype() under the lock.
> +	 * This will reduce the lock holding time.
> +	 */
>  	migratetype = get_pfnblock_migratetype(page, pfn);
>  
>  	spin_lock_irqsave(&zone->lock, flags);

I guess that if the comment helped one reader, it will help others. 
But this is a pretty common trick in MM and most readers will recognize
it.

That being said, get_pfnblock_migratetype() is pretty lightweight. 
Particularly when compared with __free_one_page().  I wonder if the
optimization does much good.

If the second call to get_pfnblock_migratetype() is almost never performed
then we just added a bunch of testing and branching inside the lock
which actually made things worse!
