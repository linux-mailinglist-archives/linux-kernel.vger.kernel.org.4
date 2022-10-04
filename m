Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5695B5F4722
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJDQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJDQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E980543C9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 865D1613E9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD6EC433C1;
        Tue,  4 Oct 2022 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664899705;
        bh=uFMwOLP3RUhCOk0dtvA+jQ3MjGUaf7MqATOqt3PVaOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFN/1mY+sFwQiffx3YtSM4uJXf8ssrhi8l7C/bwLZfTtbMfDtwmVX/U93UJkuyfhf
         tul7ZEdJ8N2YykR2wp5/2sG/S+N99dDIlM1mHOk9+Gq4SP/i9BvZwDdmcJkpMWPoau
         ViCBwEKLUYNHgorUHZAv89jgPRlmBtKt309BhlwpF7h880R1zcaTr/NPBvTzcKVS0m
         nQIeXAPPf8R/+umcG71x2/pdW+QOSIWIYS86pvrjSFkequhR+3wMZjedLLLshiJwmX
         UDAJzlyit5UJVJfqZTCQRoLrHcKF4HquMvjprz55Y+uRr4fiOPKOV52dsO5IjPFJDc
         WVdplxud/jGuw==
Date:   Wed, 5 Oct 2022 00:08:21 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Yue Hu <zbestahu@163.com>
Cc:     chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] erofs: fix the unmapped access in
 z_erofs_fill_inode_lazy()
Message-ID: <YzxadSy1YToNHQGr@debian>
Mail-Followup-To: Yue Hu <zbestahu@163.com>, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
References: <20221004144951.31075-1-zbestahu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004144951.31075-1-zbestahu@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:49:51PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
> after calling erofs_put_metabuf(), that is not correct. Fix it.
> 
> Fixes: ab92184ff8f1 ("add on-disk compressed tail-packing inline support")
> Fixes: b15b2e307c3a ("support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/erofs/zmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 

erofs: fix invalid unmapped accesses in z_erofs_fill_inode_lazy()

> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 44c27ef39c43..1a15bbf18ba3 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -58,7 +58,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
>  		    vi->xattr_isize, 8);
>  	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> -				   EROFS_KMAP_ATOMIC);
> +				   EROFS_KMAP);

	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP); ?

Also I will use kmap_local later to replace kmap and kmap_atomic if
possible.

>  	if (IS_ERR(kaddr)) {
>  		err = PTR_ERR(kaddr);
>  		goto out_unlock;
> @@ -73,7 +73,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
>  		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
>  		vi->z_tailextent_headlcn = 0;
> -		goto unmap_done;
> +		goto init_done;
>  	}
>  	vi->z_advise = le16_to_cpu(h->h_advise);
>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> @@ -105,10 +105,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		err = -EFSCORRUPTED;
>  		goto unmap_done;
>  	}
> -unmap_done:
> -	erofs_put_metabuf(&buf);
> -	if (err)
> -		goto out_unlock;
>  
>  	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
>  		struct erofs_map_blocks map = {
> @@ -127,7 +123,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  			err = -EFSCORRUPTED;
>  		}
>  		if (err < 0)
> -			goto out_unlock;
> +			goto unmap_done;
>  	}
>  
>  	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
> @@ -141,11 +137,14 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  					    EROFS_GET_BLOCKS_FINDTAIL);
>  		erofs_put_metabuf(&map.buf);
>  		if (err < 0)
> -			goto out_unlock;
> +			goto unmap_done;
>  	}
> +init_done:

done:

>  	/* paired with smp_mb() at the beginning of the function */
>  	smp_mb();
>  	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
> +unmap_done:

out_put_metabuf:

Thanks,
Gao Xiang

> +	erofs_put_metabuf(&buf);
>  out_unlock:
>  	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
>  	return err;
> -- 
> 2.25.1
> 
