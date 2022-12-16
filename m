Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF45664F283
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiLPUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiLPUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:42:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F563D0D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:42:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76C79B81E05
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058C9C433EF;
        Fri, 16 Dec 2022 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671223324;
        bh=EZFmYusjJ/sEsZTKMldpp4cUqNdEDMv0lVSg7WwxolQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pro/xyn5yiR4ycCanHRL+SgLaHAqpiTsjcwVn5yMdwyL3mV2muumSrSukX2XyeSM8
         WwulXIs9qLSwoXVeVhj4QYILoFz3nfA/GRokQPE3dgyhJE0MZfJuxKPDz39bvbfBgu
         TJ4oW00bPtqT5/7NCDAdEcsdXT7hmk2AdEICn8EngifDo5LuTxr2Aq9wikzCMGkDh1
         hNKIdiJUU1OsGWVBBHXLSY/rsyAeoWOh/03mha9ZNrNiBUzexdO0xap66TrSL8JKVX
         0c3a/N/QpVHx+Ayaglv4jgv+96H44zjPWfbnTbqeKus0geZh021kQL1PVnHV5YgJkF
         gS8Q0cuAoiyrQ==
Date:   Fri, 16 Dec 2022 12:42:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org,
        syzbot+4793f6096d174c90b4f7@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadlock
Message-ID: <Y5zYGsBZDZ9101zU@sol.localdomain>
References: <20221216155000.3204-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216155000.3204-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:50:00PM +0800, Chao Yu wrote:
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cad4bdd6f097..4bc98dbe8292 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2336,6 +2336,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	u8 encrypt_pw_salt[16];
>  	int err;
>  
>  	if (!f2fs_sb_has_encrypt(sbi))
> @@ -2360,12 +2361,14 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  		goto out_err;
>  	}
>  got_it:
> -	if (copy_to_user((__u8 __user *)arg, sbi->raw_super->encrypt_pw_salt,
> -									16))
> -		err = -EFAULT;
> +	memcpy(encrypt_pw_salt, sbi->raw_super->encrypt_pw_salt, 16);
>  out_err:
>  	f2fs_up_write(&sbi->sb_lock);
>  	mnt_drop_write_file(filp);
> +
> +	if (!err && copy_to_user((__u8 __user *)arg, encrypt_pw_salt, 16))
> +		err = -EFAULT;
> +
>  	return err;

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
