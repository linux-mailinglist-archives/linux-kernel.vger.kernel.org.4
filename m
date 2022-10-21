Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D24607D39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJURLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJURLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:11:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF9D1CEC04
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9E90B82AD9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC7C433D7;
        Fri, 21 Oct 2022 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666372257;
        bh=3jrWFUza5Ko9/eK84tOxAqMi3QxIuNBr6p0dVpub4ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZ5Yc3TzFvRzrPTyIXu4Z5rXLPbrGJP5Hfm22ZQF7mw82htk6z0wYIxhns5/9ExP6
         0wOOe1Uu8/5gh8STY6ZC6RUM6pVA96MsDkL6xXoVq42OvQ8ubLze2DjMkTX4tvFyrb
         CRiA6x/JYykh8Fb3DGg9Uv7bO/0Il+Hz7FKuqRkovn92avh7kwlgum+U2c+KMKp1JP
         ANa3iT3CXu3XtglBs5KYcTsg51BsdPluFqvrlL2gCAW48ER2/L4FX1nUIhhmvKz864
         7G5a2PtWtmecd6/uWPsBCtTUSCM5In8dykhphu/sOWPG8KS9N8IXoQA0YpAyicx0zy
         XxNkGm04x4UXw==
Date:   Fri, 21 Oct 2022 10:10:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ntfs3@lists.linux.dev,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] fs/ntfs3: Don't use uni1 uninitialized in
 ntfs_d_compare()
Message-ID: <Y1LSn+O44lCRR3qE@dev-arch.thelio-3990X>
References: <20221004232359.285685-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004232359.285685-1-nathan@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? This is still breaking our builds in -next...

On Tue, Oct 04, 2022 at 04:23:58PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   fs/ntfs3/namei.c:445:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                   if (toupper(c1) != toupper(c2)) {
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/ctype.h:64:20: note: expanded from macro 'toupper'
>   #define toupper(c) __toupper(c)
>                     ^
>   fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
>           __putname(uni1);
>                     ^~~~
>   ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
>   #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
>                                                                         ^~~~
>   fs/ntfs3/namei.c:445:3: note: remove the 'if' if its condition is always false
>                   if (toupper(c1) != toupper(c2)) {
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/ntfs3/namei.c:434:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                   if (!lm--) {
>                       ^~~~~
>   fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
>           __putname(uni1);
>                     ^~~~
>   ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
>   #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
>                                                                         ^~~~
>   fs/ntfs3/namei.c:434:3: note: remove the 'if' if its condition is always false
>                   if (!lm--) {
>                   ^~~~~~~~~~~~
>   fs/ntfs3/namei.c:430:22: note: initialize the variable 'uni1' to silence this warning
>           struct cpu_str *uni1, *uni2;
>                               ^
>                               = NULL
>   2 errors generated.
> 
> There is no point in calling __putname() in these particular error
> paths, as there has been no corresponding __getname() call yet. Just
> return directly in these blocks to clear up the warning.
> 
> Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1729
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v2:
>     * Pick up Nick's reviewed-by tag.
> v1: https://lore.kernel.org/20221004144145.1345772-1-nathan@kernel.org/
> 
>  fs/ntfs3/namei.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 315763eb05ff..5d3a6ce3f05f 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -431,10 +431,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
>  
>  	/* First try fast implementation. */
>  	for (;;) {
> -		if (!lm--) {
> -			ret = len1 == len2 ? 0 : 1;
> -			goto out;
> -		}
> +		if (!lm--)
> +			return len1 == len2 ? 0 : 1;
>  
>  		if ((c1 = *n1++) == (c2 = *n2++))
>  			continue;
> @@ -442,10 +440,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
>  		if (c1 >= 0x80 || c2 >= 0x80)
>  			break;
>  
> -		if (toupper(c1) != toupper(c2)) {
> -			ret = 1;
> -			goto out;
> -		}
> +		if (toupper(c1) != toupper(c2))
> +			return 1;
>  	}
>  
>  	/*
> 
> base-commit: d45da67caedacd500879de5e649360cc70777af7
> -- 
> 2.37.3
> 
> 
