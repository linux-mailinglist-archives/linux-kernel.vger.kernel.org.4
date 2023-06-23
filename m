Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E062B73BE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFWSzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFWSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56251BD2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E91F61AFB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AB8C433C8;
        Fri, 23 Jun 2023 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687546536;
        bh=VnxQJHaKQsPmcm1OKRvt1nu0tfgMb5k4v2j2VSOguZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1mjN+yDK/HIBcVtmO4krGa3lR7Jd4OuPjTYnE8Pg/qhniSIqSbdcYaUXpKBYThWk
         76uLDZhuBpLggR3JzNqU+i8IAPQQqouac8Z3AeofwMVpeImCUC9zy86pVWiRgDP1F3
         NtZdZVwoMtngP7VElnLK6N5nq11+c3t8ahYsIumIQiCpLRkTToncYeLUcrMf8+2W/b
         Tv8Vq5u4C4nPgsocTwDD27OznbmkOpr2eFEtNbBphJwSmHOe1v2qP4+qWB7y8zOmu5
         2rFc90PF3Fftg4/uX9STN8pFLk6Rtp6eO2kui1nA+36oCEsnY4EAc/2c/hgDajGvY/
         +FyDvcRrXhT3w==
Date:   Fri, 23 Jun 2023 11:55:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yunlei He <heyunlei@oppo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev][PATCH 1/2 v2] f2fs: update mtime and ctime in move
 file range method
Message-ID: <ZJXqpw2Ckluo+20G@google.com>
References: <20230622161647.742012-1-heyunlei@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622161647.742012-1-heyunlei@oppo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23, Yunlei He wrote:
> Mtime and ctime stay old value without update after move
> file range ioctl. This patch add time update.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>
> ---
> v2:
> -update both src and dst inode
>  fs/f2fs/file.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cb42d8464ad9..e59fc8faa035 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2886,6 +2886,19 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>  		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
>  out_src:
>  	f2fs_up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> +
> +	if (!ret) {

Applied with minor change like:

	if (ret)
		goto out_unlock;
	...

> +		src->i_mtime = src->i_ctime = current_time(src);
> +		f2fs_mark_inode_dirty_sync(src, false);
> +
> +		if (src != dst) {
> +			dst->i_mtime = dst->i_ctime = current_time(dst);
> +			f2fs_mark_inode_dirty_sync(dst, false);
> +		}
> +
> +		f2fs_update_time(sbi, REQ_TIME);
> +	}
> +
>  out_unlock:
>  	if (src != dst)
>  		inode_unlock(dst);
> -- 
> 2.40.1
