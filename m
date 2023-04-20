Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC36E8E47
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjDTJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjDTJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC34C01;
        Thu, 20 Apr 2023 02:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0667F6097C;
        Thu, 20 Apr 2023 09:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCDCC433D2;
        Thu, 20 Apr 2023 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983380;
        bh=9yTTALXrhDWYKygBa8EeTRuKSMceh1+79v9wec5T14o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajxHbB/KrslK5/nnLpLato1TyihZEAgQpvvMpxqib6MMAJ3Yh0E7l7lhumRbIfYgV
         oXwMWjuNvYi3l3Xkyfuf8L8S4JUIVNViCMVcpNnmEj5s54t/D+pGz03I/uuhwhlPbe
         w0mDDwdcRu9PL16grKZoxoQqtOjSZu9iIiP/wNlSX+coS66ffGa2WtflXvWArCz0Iq
         G2pU6aj7P8IxJjqJDEwnGhg80m2uOi+t3/bidJ2bUM9y5UVehpzn+rDuNmrwg69VoU
         nB9BmD/csjW3RNWG/2qn104xbqIJomwsN6X6X7tw340hytXXR8ygRQjv3AaD9lo6Tf
         +fBa0k43LhR9w==
Date:   Thu, 20 Apr 2023 11:36:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gao Xiang <xiang@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the erofs tree with the
 vfs-idmapping tree
Message-ID: <20230420-umfragen-sandige-68c01f9ace00@brauner>
References: <20230413144651.3519980-1-broonie@kernel.org>
 <4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:49:27PM +0100, Mark Brown wrote:
> On Thu, Apr 13, 2023 at 03:46:51PM +0100, broonie@kernel.org wrote:
> 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> No, that's wrong.  This:

Yes, that fixup looks correct, thank you! 

> 
> diff --cc fs/erofs/xattr.c
> index 015462763bdd5,a04724c816e5f..0000000000000
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@@ -483,12 -517,28 +513,25 @@@ static int xattr_entrylist(struct xattr
>   {
>   	struct listxattr_iter *it =
>   		container_of(_it, struct listxattr_iter, it);
> - 	unsigned int prefix_len;
> - 	const char *prefix;
> + 	unsigned int base_index = entry->e_name_index;
> + 	unsigned int prefix_len, infix_len = 0;
> + 	const char *prefix, *infix = NULL;
>  -	const struct xattr_handler *h;
> + 
> + 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> + 		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
> + 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> + 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> + 
> + 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> + 			return 1;
> + 		infix = pf->prefix->infix;
> + 		infix_len = pf->infix_len;
> + 		base_index = pf->prefix->base_index;
> + 	}
>   
> - 	prefix = erofs_xattr_prefix(entry->e_name_index, it->dentry);
>  -	h = erofs_xattr_handler(base_index);
>  -	if (!h || (h->list && !h->list(it->dentry)))
> ++	prefix = erofs_xattr_prefix(base_index, it->dentry);
>  +	if (!prefix)
>   		return 1;
>  -
>  -	prefix = xattr_prefix(h);
>   	prefix_len = strlen(prefix);
>   
>   	if (!it->buffer) {


