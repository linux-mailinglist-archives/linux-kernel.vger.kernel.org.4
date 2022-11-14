Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD32062835E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiKNO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiKNO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:59:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC26394
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:59:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C91B80FED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB9AC433D6;
        Mon, 14 Nov 2022 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668437965;
        bh=MyGp7ncnUOUDJYrcTaf14fF06apJ3gX8OEBOWs6Q5mA=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=eEqfDIWL9mH8h3V7HI/UEJtJgKdlXBpk8S7Hz42jvY0swo4bOhFpQ9o9rRbDT5fuJ
         qAPT5sr8lBX1yrXYvZf2fh1B6WwdJjxYCNQiRLtV3R3zzWKGzXLbQ2bQCb5NWsWuOT
         UJ6q8bTiPqplUHaYDSEByv3pt2Ez1l0IFZvzwA5gk7TpFM9iZeoAel5sGyvFVCcB6j
         K9ZI/LNr+I1ocSkgKHkMG3+L6UUlNBKfxCgMlEThidssKSuSj4xl6koLf/6laB3zdi
         VOHUR1ve5vDRygDpw2+jYlH6guBCKm5EaOauY4hxnNInEJZbV+gN7bVTGhUR2EbgjE
         xUgCKKCaQlv8g==
Message-ID: <420531c0-2649-bf2a-140d-2f4f13036b0d@kernel.org>
Date:   Mon, 14 Nov 2022 22:59:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
 <20221112083250.295700-4-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: change type for 'sbi->readdir_ra'
In-Reply-To: <20221112083250.295700-4-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/12 16:32, Yuwei Guan wrote:
> Before this patch, the varibale 'readdir_ra' takes effect if it's equal
> to '1' or not, so we can change type for it from 'int' to 'bool'.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   fs/f2fs/dir.c   | 7 +++----
>   fs/f2fs/f2fs.h  | 2 +-
>   fs/f2fs/super.c | 2 +-
>   fs/f2fs/sysfs.c | 5 +++++
>   4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 21960a899b6a..06d9bf98f5ae 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -1000,13 +1000,12 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
>   	struct blk_plug plug;
> -	bool readdir_ra = sbi->readdir_ra == 1;
>   	bool found_valid_dirent = false;
>   	int err = 0;
>   
>   	bit_pos = ((unsigned long)ctx->pos % d->max);
>   
> -	if (readdir_ra)
> +	if (sbi->readdir_ra)
>   		blk_start_plug(&plug);
>   
>   	while (bit_pos < d->max) {
> @@ -1064,14 +1063,14 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   			goto out;
>   		}
>   
> -		if (readdir_ra)
> +		if (sbi->readdir_ra)
>   			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
>   
>   		ctx->pos = start_pos + bit_pos;
>   		found_valid_dirent = true;
>   	}
>   out:
> -	if (readdir_ra)
> +	if (sbi->readdir_ra)

I don't think this is the right way... due to below case:

if (sbi->readdir_ra)	// readdir_ra is 1 by default
	blk_start_plug(&plug);

if (sbi->readdir_ra)	// readdir_ra is updated to 0, it will miss to unplug.
	blk_finish_plug(&plug);

Thanks,

>   		blk_finish_plug(&plug);
>   	return err;
>   }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6355a5683b7..384840216e7f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1693,7 +1693,7 @@ struct f2fs_sb_info {
>   	unsigned int total_node_count;		/* total node block count */
>   	unsigned int total_valid_node_count;	/* valid node block count */
>   	int dir_level;				/* directory level */
> -	int readdir_ra;				/* readahead inode in readdir */
> +	bool readdir_ra;			/* readahead inode in readdir */
>   	u64 max_io_bytes;			/* max io bytes to merge IOs */
>   
>   	block_t user_block_count;		/* # of user blocks */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f18ae5410b2c..da304861890f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2202,7 +2202,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool is_remount)
>   	}
>   
>   	if (!is_remount)
> -		sbi->readdir_ra = 1;
> +		sbi->readdir_ra = true;
>   }
>   
>   static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index df27afd71ef4..53fbbb87dd0f 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -649,6 +649,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "readdir_ra")) {
> +		sbi->readdir_ra = !!t;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
