Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA35EEF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiI2Hg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2Hgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:36:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677FD139416
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AC26B8237D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFECC433D7;
        Thu, 29 Sep 2022 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664437010;
        bh=zoRODf+0JGREJ0meYcsO7CBJh8QP25i3a9LjaGUnhYk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oWANY7OLHl4u9yr6J9BSRdsSomUwxWRgoNG0ZXzFwKg962SHe6WwCUcXKgMUIZQO2
         AHjBCQSNQHH78DntN16q784xdFszeXRBzC/fI9icxfZQhytomPSKY4RUEx+qucDR+T
         bisxlaTpoSxVkDykLc/HC2YsVXP+UoAJJIzdHeE9iZrTg2k7M1i0tbIQyfh9i21Ay+
         f4WbZOncXmUOfrOjrAdzkiYVhr8/NAkteOtkHTlu4egyY1o53XypmiKHlIym26l663
         ugaKhmSWv2tWlXkTpMJ11wqabyVbWfWmt2Knk5cmVzFPbyLfmlVGVIpY0MbRQIo5OP
         mryLlDCIy6mEg==
Message-ID: <f4ce9486-f104-b0e2-25ed-f6de96316b76@kernel.org>
Date:   Thu, 29 Sep 2022 15:36:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce
 F2FS_IOC_START_ATOMIC_REPLACE
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220920014036.2295853-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220920014036.2295853-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 9:40, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> introduce a new ioctl to replace the whole content of a file atomically,
> which means it induces truncate and content update at the same time.
> We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
> F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
> F2FS_IOC_ABORT_ATOMIC_WRITE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: add undefined ioctl number reported by <lkp@intel.com>
> ---
>   fs/f2fs/data.c            |  3 +++
>   fs/f2fs/f2fs.h            |  1 +
>   fs/f2fs/file.c            | 12 ++++++++++--
>   fs/f2fs/segment.c         | 14 +++++++++++++-
>   include/uapi/linux/f2fs.h |  1 +
>   5 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6cd29a575105..d3d32db3a25d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3438,6 +3438,9 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>   	else if (*blk_addr != NULL_ADDR)
>   		return 0;
>   
> +	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
> +		goto reserve_block;
> +
>   	/* Look for the block in the original inode */
>   	err = __find_data_block(inode, index, &ori_blk_addr);
>   	if (err)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 539da7f12cfc..2c49da12d6d8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -764,6 +764,7 @@ enum {
>   	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
>   	FI_ALIGNED_WRITE,	/* enable aligned write */
>   	FI_COW_FILE,		/* indicate COW file */
> +	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
>   	FI_MAX,			/* max flag, never be used */
>   };
>   
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4f9b80c41b1e..4abd9d2a55b3 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1982,7 +1982,7 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
>   	return put_user(inode->i_generation, (int __user *)arg);
>   }
>   
> -static int f2fs_ioc_start_atomic_write(struct file *filp)
> +static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   {
>   	struct inode *inode = file_inode(filp);
>   	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
> @@ -2051,6 +2051,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>   
>   	isize = i_size_read(inode);
>   	fi->original_i_size = isize;
> +	if (truncate) {
> +		set_inode_flag(inode, FI_ATOMIC_REPLACE);
> +		truncate_inode_pages_final(inode->i_mapping);
> +		f2fs_i_size_write(inode, 0);
> +		isize = 0;
> +	}

Hi Daeho,

isize should be updated after tagging inode as atomic_write one?
otherwise f2fs_mark_inode_dirty_sync() may update isize to inode page,
latter checkpoint may persist that change? IIUC...

Thanks,

>   	f2fs_i_size_write(fi->cow_inode, isize);
>   
>   	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> @@ -4080,7 +4086,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	case FS_IOC_GETVERSION:
>   		return f2fs_ioc_getversion(filp, arg);
>   	case F2FS_IOC_START_ATOMIC_WRITE:
> -		return f2fs_ioc_start_atomic_write(filp);
> +		return f2fs_ioc_start_atomic_write(filp, false);
> +	case F2FS_IOC_START_ATOMIC_REPLACE:
> +		return f2fs_ioc_start_atomic_write(filp, true);
>   	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
>   		return f2fs_ioc_commit_atomic_write(filp);
>   	case F2FS_IOC_ABORT_ATOMIC_WRITE:
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 143b7ea0fb8e..c524538a9013 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -263,14 +263,26 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
>   					bool revoke)
>   {
>   	struct revoke_entry *cur, *tmp;
> +	pgoff_t start_index = 0;
> +	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
>   
>   	list_for_each_entry_safe(cur, tmp, head, list) {
> -		if (revoke)
> +		if (revoke) {
>   			__replace_atomic_write_block(inode, cur->index,
>   						cur->old_addr, NULL, true);
> +		} else if (truncate) {
> +			f2fs_truncate_hole(inode, start_index, cur->index);
> +			start_index = cur->index + 1;
> +		}
> +
>   		list_del(&cur->list);
>   		kmem_cache_free(revoke_entry_slab, cur);
>   	}
> +
> +	if (!revoke && truncate) {
> +		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
> +		clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> +	}
>   }
>   
>   static int __f2fs_commit_atomic_write(struct inode *inode)
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 3121d127d5aa..955d440be104 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -42,6 +42,7 @@
>   						struct f2fs_comp_option)
>   #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
>   #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
> +#define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
>   
>   /*
>    * should be same as XFS_IOC_GOINGDOWN.
