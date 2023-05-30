Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750907171BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjE3Xck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjE3Xci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FAEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C88D632EF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B92AC433EF;
        Tue, 30 May 2023 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685489556;
        bh=JXz0xI70zuYpYZsltrSyZalooGB27OtEMdKKeiDcQNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXcGh5VxJseqUJCs/l1tb6YMnkYiaCyHEJTbJqUThtjcDapGkcJac485k3iwsuBrJ
         SdqnqflN+cQvNFYN+X1ewgC1UEYScO3QvVLLxMZvRn/P+VzwJmuG3jsV5DcJnqPR9e
         veyKyUJlQCnr5v3vsOg+e9djeOGIprE4lt9SJ3sF8g/IsnW/3PeQHDkL06aKLTG5ml
         zjQwucwHtmy5cbW9CStYnaZd+lGyaZGsgaGWmEpKpAvISP+5LcTF2Q8QAHvuOqbQpu
         J//q6QKPKLT4b9ZC0qupD41JPo8h6SBsGiv6sx4mL1auDdcJb6WAPzzwg6Md8zlXel
         wVzjEwbX49w6g==
Date:   Tue, 30 May 2023 16:32:34 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
Subject: Re: [PATCH v2 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Message-ID: <ZHaHknKmSQIdQzBC@google.com>
References: <20230530012118.74228-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530012118.74228-1-bo.wu@vivo.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30, Wu Bo wrote:
> The NULL return of 'd_splice_alias' dosen't mean error. Thus the
> successful case will also return NULL, which makes the tracepoint always
> print 'err=-ENOENT'.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/namei.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 77a71276ecb1..0c5e4c424eab 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -576,8 +576,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  	}
>  #endif
>  	new = d_splice_alias(inode, dentry);
> -	err = PTR_ERR_OR_ZERO(new);
> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> +	if (IS_ERR(new))
> +		err = PTR_ERR(new);
> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);

Again, new can be an error pointer, and the previous err was supposed to be
zero or -ENOENT.

case 1) dentry exists: err (0) with new (NULL) --> dentry, err=0
case 2) dentry exists: err (0) with new (VALID) --> new, err=0
case 3) dentry exists: err (0) with new (ERR) --> dentry, err=ERR
case 4) no dentry exists: err (-ENOENT) with new (NULL) --> dentry, err=-ENOENT
case 4) no dentry exists: err (-ENOENT) with new (VALID) --> new, err=-ENOENT
case 5) no dentry exists: err (-ENOENT) with new (ERR) --> dentry, err=ERR

	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
				ino, IS_ERR(new) ? PTR_ERR(new) : err);


>  	return new;
>  out_iput:
>  	iput(inode);
> -- 
> 2.35.3
