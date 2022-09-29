Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E95EED6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiI2F5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiI2F5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:57:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3421512BDAD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA3F7B8233F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1615C433D6;
        Thu, 29 Sep 2022 05:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664431055;
        bh=p8rNpJp8zU2f+LbsfvWOTxZBK5/phXiTL+WknhTB4Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEHxFa5zU/tt3q+/nIgySIYn6Jl9r1VtPjgWxRr8KsknsfZswJbU/GMFxWiLErnM7
         OcDn48nvnHIKYIHNDyrW3v0wFyXGQJEcUC6EKV+tk6KYkSfp2F8TktK7Jd/UYbfStP
         d8EdVaOSbQqppNehQg80NIC1gaX1PFWayEQ7fsv/8h7qmjoFVabVyHbmrAMAqrkIBc
         u4RPTbNjxT7+x27boUMZGF/CjSTopCtlpeu/a2typQeda55cJqtg1DjPS8O/HNs0Pw
         kil5CO9qhi6AW8XUJY0Fa4cjWrOrYi52LB01KOoKgP31Cla17gRTC15T/vFqYCJqd0
         SJ4sRDizey1Nw==
Date:   Thu, 29 Sep 2022 08:57:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 2/2] 9p: client_create: init fcall_cache earlier
Message-ID: <YzUzyw9JE4lFWKo5@unreal>
References: <YzQc2yaDufjp+rHc@unreal>
 <20220928214417.1749609-1-asmadeus@codewreck.org>
 <20220928214417.1749609-2-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928214417.1749609-2-asmadeus@codewreck.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 06:44:17AM +0900, Dominique Martinet wrote:
> fcall cache was init'd last for some reason, but we actually allocate
> some requests for the version check before that.
> Moving the cache creation towards the start also makes p9_client_destroy's
> order match the allocation order, which might be easier to think about
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  net/9p/client.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Please submit it properly. It is unclear to which series you are
referring.

> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 40b59431a566..1ea326e6e271 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -977,6 +977,17 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	if (err < 0)
>  		goto out;
>  
> +	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
> +	 * followed by data accessed from userspace by read
> +	 * Note we do not check for failure here because the cache is
> +	 * optional; warning will be issued on dmesg for failure.
> +	 */
> +	clnt->fcall_cache =
> +		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
> +					   0, 0, P9_HDRSZ + 4,
> +					   clnt->msize - (P9_HDRSZ + 4),
> +					   NULL);
> +

clnt->msize can be changed after call to ->create() if it is larger than clnt->trans_mod->maxsize).

>  	if (!clnt->trans_mod)
>  		clnt->trans_mod = v9fs_get_default_trans();
>  
> @@ -1016,15 +1027,6 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	if (err)
>  		goto out;
>  
> -	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
> -	 * followed by data accessed from userspace by read
> -	 */
> -	clnt->fcall_cache =
> -		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
> -					   0, 0, P9_HDRSZ + 4,
> -					   clnt->msize - (P9_HDRSZ + 4),
> -					   NULL);
> -
>  	return clnt;
>  
>  out:
> -- 
> 2.35.1
> 
