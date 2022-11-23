Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C163635E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiKWPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiKWPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:23:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF2F24BCD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85230B820D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF591C433D6;
        Wed, 23 Nov 2022 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217010;
        bh=QEtQv6YqDKiNS67DUNp9CxDV72NyjsMORwknJ502TB4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y+PZsgJ7EGo6FGA1re2MzTsuYfMvabxmAhAl1KSsyW/kyEKQFPRhkEJQcRudeaAd7
         bfX6rdJhwCHUdLzc/7j/lhGheTNpBWGLGk6r0KXiVI1PLjVja17qhiHFmuXORqpqHI
         q1CQiEFNFw5+a8lb81T1ubDijr2d0g4ZjLFqjL6ho/Q32n5H4Icyjnzm0gpRF74VX8
         qr+O+URuohIYDb7kPZ/BbufwVs9RXZR0ftlqy0ih7Spc7WtPYuS8kYhfmt94e6X8XO
         JLkceAJDz5NgJz6HYBFT6ggVUSz9+NsgoYbSGDDhrv30tmd0vZhI4aHK2BfvElDDkv
         kZcxpHoW93lLw==
Message-ID: <6e26eb7d-8b9e-5a91-b66f-a6f8cf1d53ce@kernel.org>
Date:   Wed, 23 Nov 2022 23:23:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: introduce
 F2FS_IOC_START_ATOMIC_REPLACE
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20221111170406.1086745-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221111170406.1086745-1-daeho43@gmail.com>
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

On 2022/11/12 1:04, Daeho Jeong wrote:
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
> v7: changed where to clear FI_ATOMIC_REPLACE
>      fixed tentative race condition in f2fs_ioc_start_atomic_write()
> v3: move i_size change after setting atomic write flag
> v2: add undefined ioctl number reported by <lkp@intel.com>
> ---
>   fs/f2fs/data.c            |  3 +++
>   fs/f2fs/f2fs.h            |  1 +
>   fs/f2fs/file.c            | 21 +++++++++++++++------
>   fs/f2fs/segment.c         | 13 ++++++++++++-
>   include/uapi/linux/f2fs.h |  1 +
>   5 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5f895ddcd64a..bce4dcc3ad78 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3457,6 +3457,9 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
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
> index e29f9adf60ca..d513ecd17550 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -765,6 +765,7 @@ enum {
>   	FI_ALIGNED_WRITE,	/* enable aligned write */
>   	FI_COW_FILE,		/* indicate COW file */
>   	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
> +	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
>   	FI_MAX,			/* max flag, never be used */
>   };
>   
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7ce629c95f4a..f9a04f6d76cb 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1984,7 +1984,7 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
>   	return put_user(inode->i_generation, (int __user *)arg);
>   }
>   
> -static int f2fs_ioc_start_atomic_write(struct file *filp)
> +static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   {
>   	struct inode *inode = file_inode(filp);
>   	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
> @@ -2053,15 +2053,22 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>   
>   	f2fs_write_inode(inode, NULL);
>   
> -	isize = i_size_read(inode);
> -	fi->original_i_size = isize;
> -	f2fs_i_size_write(fi->cow_inode, isize);
> -
>   	stat_inc_atomic_inode(inode);
>   
>   	set_inode_flag(inode, FI_ATOMIC_FILE);
>   	set_inode_flag(fi->cow_inode, FI_COW_FILE);
>   	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> +
> +	isize = i_size_read(inode);
> +	fi->original_i_size = isize;
> +	if (truncate) {
> +		set_inode_flag(inode, FI_ATOMIC_REPLACE);
> +		truncate_inode_pages_final(inode->i_mapping);
> +		f2fs_i_size_write(inode, 0);
> +		isize = 0;
> +	}
> +	f2fs_i_size_write(fi->cow_inode, isize);
> +
>   	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>   
>   	f2fs_update_time(sbi, REQ_TIME);
> @@ -4089,7 +4096,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
> index 9cbf88092c78..f2930fffbc7d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -197,6 +197,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>   	fi->cow_inode = NULL;
>   	release_atomic_write_cnt(inode);
>   	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> +	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
>   	clear_inode_flag(inode, FI_ATOMIC_FILE);
>   	stat_dec_atomic_inode(inode);
>   
> @@ -261,14 +262,24 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
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

Do we try to truncate from page #0 to page #(index of last page in chain)?

If so, how about calling f2fs_truncate_hole(, 0, last_index) after the loop?

Thanks,

> +		}
> +
>   		list_del(&cur->list);
>   		kmem_cache_free(revoke_entry_slab, cur);
>   	}
> +
> +	if (!revoke && truncate)
> +		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
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
