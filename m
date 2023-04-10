Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9326DCACE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDJSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50C9138
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 552E0614B3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B7C433D2;
        Mon, 10 Apr 2023 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681151606;
        bh=LXAl7LmH7DPvBG2tCvsfOUy9uznk9588j5SHxfWELbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMEQVvUl5JOYt59RpLrNqNZkRWlPbS1On2qVVk11XOibMH+qD6/NVeZ1mYU7lfguT
         c495Pxo45CPFrJMZnvzy7BSlHte4c9EwTRdrM7E/ZYykBpJ/I6YcbNRg1ZO7xAWAo/
         jYUAAxCMJ6mTbeQZc5pUZ3p94YDnsjhkApIEKrmaFGVRyEAvCu3xczP5wskTZOLMQQ
         gXWGPf1Y5B6hENR/qr3Cq4M5cEwYUrZ7Qf1Cv8oxPK5JBMHrXczrltGD8kKfbu5R/r
         APyWLt1KaR0QdvrjFbvx/IY6ojlS8BrRUZjdBiUBIS79wD2QYvIv+fI42urw+8lM6b
         APOtFTHTCWL7w==
Date:   Mon, 10 Apr 2023 11:33:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: remove folio_detach_private() in
 .invalidate_folio and .release_folio
Message-ID: <ZDRWdJxP6QzcIU7G@google.com>
References: <20230410022418.1843178-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410022418.1843178-1-chao@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Chao Yu wrote:
> We have maintain PagePrivate and page_private and page reference
> w/ {set,clear}_page_private_*, it doesn't need to call
> folio_detach_private() in the end of .invalidate_folio and
> .release_folio, remove it and use f2fs_bug_on instead.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4946df6dd253..8b179b4bdc03 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3737,7 +3737,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>  			inode->i_ino == F2FS_COMPRESS_INO(sbi))
>  		clear_page_private_data(&folio->page);
>  
> -	folio_detach_private(folio);
> +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> +	f2fs_bug_on(sbi, page_private(&folio->page));

I think we can just check page_private() only.

>  }
>  
>  bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> @@ -3759,7 +3760,9 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
>  	clear_page_private_reference(&folio->page);
>  	clear_page_private_gcing(&folio->page);
>  
> -	folio_detach_private(folio);
> +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> +	f2fs_bug_on(sbi, page_private(&folio->page));
> +
>  	return true;
>  }
>  
> -- 
> 2.25.1
