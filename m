Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F675EED65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiI2FyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiI2FyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC6E12B5FA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D0B6200E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AB3C433D6;
        Thu, 29 Sep 2022 05:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664430855;
        bh=g15tzfzPdhSnHrHSTmuII/jk7Tm4dZCtS/XXnDPqtyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfBEw+s8MOVjo4iTJNPZPcjjYTBZAdqre9O9iVsIcJ5MhFUPxQf9ytYYxh0mkDJyq
         sugtZ4zKLBV/+4g1giWF0Kf1ZoZNCMcoWPFBXYcxsSlZ62bixfCUgjs++/HFJdFsC/
         WKziSoaA1VpwLGc3Ohm01yN3PUBHs0Llhq+qQgwz5FQ0VOrYHdG6QGl0t74Vlj6T31
         bUuv7S9pAlAviHbNPagcA2E8ppy/27XQWldqwQCY+6T0nmlRmOmLCJfqkcKtHCaThp
         xbArcV84t4f51azWiOjZyvvP1pGl+cO9Aa6nGKQBfW+b6kKYFJt5cAKs+0eEhoXl3B
         xFggI8QsBK6ZA==
Date:   Thu, 29 Sep 2022 08:54:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] 9p: client_create/destroy: only call trans_mod->close
 after create
Message-ID: <YzUzAqsq803Z+rtr@unreal>
References: <20220928215800.1749929-1-asmadeus@codewreck.org>
 <20220928221923.1751130-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928221923.1751130-1-asmadeus@codewreck.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:19:23AM +0900, Dominique Martinet wrote:
> destroy code would incorrectly call close() if trans_mod exists after some
> hasty code cleanup: we need to make sure we only call close after create
> 
> Link: https://lkml.kernel.org/r/20220928214417.1749609-1-asmadeus@codewreck.org
> Link: https://lkml.kernel.org/r/00000000000015ac7905e97ebaed@google.com
> Reported-by: syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Fixes: 3ff51294a055 ("9p: p9_client_create: use p9_client_destroy on failure")
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> v1->v2: also reset trans on create error
> v2->v3: fix silly compile errors
> 
> Sorry for the multiple mails, that's what I get for not even doing basic
> tests before talking...

Please always submit new patch versions as new one and don't reply-to.
It breaks flows of everyone who relies on proper email threading.

> 
>  net/9p/client.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index bfa80f01992e..41e825a8da7c 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -971,6 +971,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	spin_lock_init(&clnt->lock);
>  	idr_init(&clnt->fids);
>  	idr_init(&clnt->reqs);
> +	clnt->trans = ERR_PTR(-EINVAL);
>  
>  	err = parse_opts(options, clnt);
>  	if (err < 0)
> @@ -990,8 +991,14 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  		 clnt, clnt->trans_mod, clnt->msize, clnt->proto_version);
>  
>  	err = clnt->trans_mod->create(clnt, dev_name, options);
> -	if (err)
> +	// ensure clnt->trans is initialized to call close() on destroy
> +	// if and only if create succeeded

Please use /* */ comment style.

> +	if (err < 0) {
> +		clnt->trans = ERR_PTR(err);
>  		goto out;
> +	}
> +	if (IS_ERR(clnt->trans))
> +		clnt->trans = NULL;
>  
>  	if (clnt->msize > clnt->trans_mod->maxsize) {
>  		clnt->msize = clnt->trans_mod->maxsize;
> @@ -1036,7 +1043,7 @@ void p9_client_destroy(struct p9_client *clnt)
>  
>  	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
>  
> -	if (clnt->trans_mod)
> +	if (clnt->trans_mod && !IS_ERR(clnt->trans))

It is completely no-go to rely on internal value inside of structure after
failure in ->create() callback.

>  		clnt->trans_mod->close(clnt);
>  
>  	v9fs_put_trans(clnt->trans_mod);
> -- 
> 2.35.1
> 
