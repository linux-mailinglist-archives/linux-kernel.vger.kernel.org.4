Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302DB6DCB10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDJSrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjDJSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C9E77
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DF926122F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C509C433D2;
        Mon, 10 Apr 2023 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681152433;
        bh=aBlz48YZds82/29V67b+Ke52jVh21IHmdlaHPojy2Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4wjBtCAzOKa0ez6iqWFoe5dQU5GMSeAX5jfjGQqwkjja/7yJLEcW1cKePmXmZ92G
         pB/WHCQodK0KP8a+Q9HqjOU3TdbOcAjVBUhcx2jLRjEjZ+7RR+ts+9Cy9q8zDzKedo
         wnVuVLbVElnyY9Eef84UTm1BzqzqCgxBqOOnhIAptNFuzrX6AhZQIrjo0ghnXHqGgO
         6eP6hifqJzuDZTlnpSQhQJ0B9pbr7cjFRpk6SS9J2YNekuFW4d/IZDajopKzIjcFs/
         iuAL4JmwBXIgJLl7H5yiVo4LhtKeaI3o/3cUfU/RwDEmKATMItv9koRy2mJQKJgdYg
         bbWMEfdPipU3A==
Date:   Mon, 10 Apr 2023 11:47:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: clean up with {attach,detach}_page_private()
Message-ID: <ZDRZrzROjW5z935R@google.com>
References: <20230410022418.1843178-1-chao@kernel.org>
 <20230410022418.1843178-2-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410022418.1843178-2-chao@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Chao Yu wrote:
> No logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ec8387da7f74..c378aedcadea 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1416,11 +1416,8 @@ static inline bool page_private_##name(struct page *page) \
>  #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
>  static inline void set_page_private_##name(struct page *page) \
>  { \
> -	if (!PagePrivate(page)) { \
> -		get_page(page); \
> -		SetPagePrivate(page); \
> -		set_page_private(page, 0); \
> -	} \
> +	if (!PagePrivate(page)) \
> +		attach_page_private(page, (void *)page->private); \

		attach_page_private(page, (void *)0);

>  	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>  	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>  }
> @@ -1429,13 +1426,8 @@ static inline void set_page_private_##name(struct page *page) \
>  static inline void clear_page_private_##name(struct page *page) \
>  { \
>  	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> -	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) { \
> -		set_page_private(page, 0); \
> -		if (PagePrivate(page)) { \
> -			ClearPagePrivate(page); \
> -			put_page(page); \
> -		}\
> -	} \
> +	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
> +		detach_page_private(page); \
>  }
>  
>  PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
> @@ -1464,11 +1456,8 @@ static inline unsigned long get_page_private_data(struct page *page)
>  
>  static inline void set_page_private_data(struct page *page, unsigned long data)
>  {
> -	if (!PagePrivate(page)) {
> -		get_page(page);
> -		SetPagePrivate(page);
> -		set_page_private(page, 0);
> -	}
> +	if (!PagePrivate(page))
> +		attach_page_private(page, 0);
>  	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
>  	page_private(page) |= data << PAGE_PRIVATE_MAX;
>  }
> @@ -1476,13 +1465,8 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
>  static inline void clear_page_private_data(struct page *page)
>  {
>  	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
> -	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) {
> -		set_page_private(page, 0);
> -		if (PagePrivate(page)) {
> -			ClearPagePrivate(page);
> -			put_page(page);
> -		}
> -	}
> +	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))
> +		detach_page_private(page);
>  }
>  
>  /* For compression */
> -- 
> 2.25.1
