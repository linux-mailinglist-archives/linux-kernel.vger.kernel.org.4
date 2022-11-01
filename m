Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95284614E22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiKAPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiKAPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA72CE19
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09860615F7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37745C433D6;
        Tue,  1 Nov 2022 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667315697;
        bh=K8l71rqgkflfcqzq6zpcUJabx7k/R95mzZKRenQ/V7E=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=CEApPlBaOEfvrN+B5Y/YD+KhxDbZyu5IKXn1LsohCm/9EHmCJ11tswKkahg5g/0Dy
         Ursqdi8IgdjtQOFw1Ve40wg7hNMbjTGqfeYPTYNbkXOX6PjG5RUNqh+Hrg4vmCv5hO
         RIw3JWBUGlXbMpT6PklTqFAAxAtbNp0Y238qv9ZMeY8GWxD6MmyHb0OzJFQLPrjzdN
         500I3zcQHm+FOZDgSmOGbqsAQ5QxjaLhc4Eitfl2Q9hmwUghk6eIJ+eSZgE4fMo4gr
         sGbLxItM9EpYjRTbq1izCxR6pGZfwuAXSl0u7AEVtwfUOEGffPqlUhaGp5GS4xfxde
         WKgaoNWKV5ODQ==
Message-ID: <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
Date:   Tue, 1 Nov 2022 23:14:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
In-Reply-To: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/21 10:31, qixiaoyu1 wrote:
> Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
> Fix to apply it to all IPU policy.

Xiaoyu,

Sorry for the delay.

I didn't get the point, can you please explain more about the
issue?

Thanks,

> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> ---
>   fs/f2fs/data.c | 8 +++-----
>   fs/f2fs/file.c | 4 +++-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a71e818cd67b..fec8e15fe820 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>   	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
>   			is_inode_flag_set(inode, FI_OPU_WRITE))
>   		return false;
> +	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
> +	if (is_inode_flag_set(inode, FI_NEED_IPU))
> +		return true;
>   	if (policy & (0x1 << F2FS_IPU_FORCE))
>   		return true;
>   	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
> @@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>   			!IS_ENCRYPTED(inode))
>   		return true;
>   
> -	/* this is only set during fdatasync */
> -	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> -			is_inode_flag_set(inode, FI_NEED_IPU))
> -		return true;
> -
>   	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>   			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
>   		return true;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82cda1258227..08091550cdf2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>   		goto go_write;
>   
>   	/* if fdatasync is triggered, let's do in-place-update */
> -	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> +	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
> +			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
>   		set_inode_flag(inode, FI_NEED_IPU);
> +
>   	ret = file_write_and_wait_range(file, start, end);
>   	clear_inode_flag(inode, FI_NEED_IPU);
>   
