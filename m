Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3F5BA26E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIOVpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIOVpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE1C27DDC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 747A5625B8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB0C433D6;
        Thu, 15 Sep 2022 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663278303;
        bh=ondPqiIv00SaqFFzETnfFTIZrNHScOlUmailF0Bt7bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a6TVrhndKjuiPGGpUhhVhL4UpbvbyuZ0ChBABYaCZXpP1Z78KUpwnaF9yr9WZIfgW
         l8S9OpWLLjW7M9JSxjlZINmniw0IGjFXU5Evg6WGM57KgzlqRO+rIXH1jQpoPnx/zp
         0iOdlYxg8Yvj7TL4FOHU93DA7OZybPTdRJDsDFj8=
Date:   Thu, 15 Sep 2022 14:45:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: Re: [PATCH] mm: change the type to bool for page_has_xxx's val
Message-Id: <20220915144502.31e7241c6144f23ce197428b@linux-foundation.org>
In-Reply-To: <1663210600-29258-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1663210600-29258-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 10:56:40 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> It is proper to return bool value for such functions
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/page-flags.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e66f7aa..9a46c8b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -946,9 +946,9 @@ static inline bool is_page_hwpoison(struct page *page)
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>  
> -static inline int page_has_type(struct page *page)
> +static inline bool page_has_type(struct page *page)
>  {
> -	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
> +	return !!((int)page->page_type < PAGE_MAPCOUNT_RESERVE);

Much nicer to simply do this:

	return page->page_type < PAGE_MAPCOUNT_RESERVE;

>  }
>  
>  #define PAGE_TYPE_OPS(uname, lname)					\
> @@ -1081,7 +1081,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
>   * Determine if a page has private stuff, indicating that release routines
>   * should be invoked upon it.
>   */
> -static inline int page_has_private(struct page *page)
> +static inline bool page_has_private(struct page *page)
>  {
>  	return !!(page->flags & PAGE_FLAGS_PRIVATE);
>  }

Maybe.  This might cause the compiler to emit more code, to convert the
integer to a bool having value 0 or 1.  It would do so if the code was
uninlined.

But given that it's inlined, the compiler hopefully has the brains to
avoid doing that and to test the integer directly.  Please check this -
the above change shouldn't increase the .o file's text section size.

