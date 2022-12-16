Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5163264E60A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLPCvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPCvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:51:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8013E81
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:51:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DDDFB8091F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A143BC433D2;
        Fri, 16 Dec 2022 02:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671159093;
        bh=efWWnl3l3gWnkN8hoZS+d4dcbkkHnDrdS7MG4YlWCQc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jkFOL7sg7Sfg44YaEAAOzJgATyLq1QMHK4xPEEiPjRCVLfKhbYKbiY6+IYpUN7E1a
         U3YVib+o6eJiSegscDq6r9TRGFQZqOyqcTjki2g8nsOWSBOCvIZ3axNN7vpYe1hqSO
         kUIrQxGRBAEWp/L40UtpdwJSgh1W18xt/TGBNONIrU6Qiy+YGyfX1ymFFxEqWuSYfo
         i21DjDBOkGnmhbGHB/UYCiZoa01tPfBOaZz03Ys00q5piplid1nyYYNz78Qu2GK8TQ
         k0/gHYc6BpaPzxOMH3Kdqk/JbqmE8UapMUWjLSELEiOWinLSAHgwwEMu1axeX8xn/S
         HFTUOYNlt4jLA==
Message-ID: <dedae282-2d13-cc12-95b8-98cfd377d98c@kernel.org>
Date:   Fri, 16 Dec 2022 10:51:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221215122012.55832-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221215122012.55832-1-frank.li@vivo.com>
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

On 2022/12/15 20:20, Yangtao Li wrote:
> There is no need to additionally use f2fs_show_injection_info()
> to output information. Concatenate time_to_inject() and
> __time_to_inject() via a macro. In the new __time_to_inject() function,
> pass in the caller function name.
> 
> In this way, we no longer need the f2fs_show_injection_info() function,
> and let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/checkpoint.c |  5 +----
>   fs/f2fs/data.c       |  8 ++------
>   fs/f2fs/dir.c        |  4 +---
>   fs/f2fs/f2fs.h       | 43 +++++++++++++------------------------------
>   fs/f2fs/file.c       |  4 +---
>   fs/f2fs/gc.c         |  4 +---
>   fs/f2fs/inode.c      |  4 +---
>   fs/f2fs/node.c       |  4 +---
>   fs/f2fs/segment.c    |  5 +----
>   fs/f2fs/super.c      |  8 ++------
>   10 files changed, 24 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 56f7d0d6a8b2..d68b3c991888 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -171,10 +171,8 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   					block_t blkaddr, int type)
>   {
> -	if (time_to_inject(sbi, FAULT_BLKADDR)) {
> -		f2fs_show_injection_info(sbi, FAULT_BLKADDR);
> +	if (time_to_inject(sbi, FAULT_BLKADDR))
>   		return false;
> -	}
>   
>   	switch (type) {
>   	case META_NAT:
> @@ -622,7 +620,6 @@ int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi)
>   
>   	if (time_to_inject(sbi, FAULT_ORPHAN)) {
>   		spin_unlock(&im->ino_lock);
> -		f2fs_show_injection_info(sbi, FAULT_ORPHAN);
>   		return -ENOSPC;
>   	}
>   
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c77442a42f89..873908ed20f7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -295,10 +295,8 @@ static void f2fs_read_end_io(struct bio *bio)
>   	iostat_update_and_unbind_ctx(bio, 0);
>   	ctx = bio->bi_private;
>   
> -	if (time_to_inject(sbi, FAULT_READ_IO)) {
> -		f2fs_show_injection_info(sbi, FAULT_READ_IO);
> +	if (time_to_inject(sbi, FAULT_READ_IO))
>   		bio->bi_status = BLK_STS_IOERR;
> -	}
>   
>   	if (bio->bi_status) {
>   		f2fs_finish_read_bio(bio, intask);
> @@ -335,10 +333,8 @@ static void f2fs_write_end_io(struct bio *bio)
>   	iostat_update_and_unbind_ctx(bio, 1);
>   	sbi = bio->bi_private;
>   
> -	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
> -		f2fs_show_injection_info(sbi, FAULT_WRITE_IO);
> +	if (time_to_inject(sbi, FAULT_WRITE_IO))
>   		bio->bi_status = BLK_STS_IOERR;
> -	}
>   
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		struct page *page = bvec->bv_page;
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 8e025157f35c..9ccdbe120425 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -732,10 +732,8 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
>   	}
>   
>   start:
> -	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH)) {
> -		f2fs_show_injection_info(F2FS_I_SB(dir), FAULT_DIR_DEPTH);
> +	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH))
>   		return -ENOSPC;
> -	}
>   
>   	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH))
>   		return -ENOSPC;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4035dab1f570..d01817b11f61 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1875,12 +1875,9 @@ struct f2fs_sb_info {
>   };
>   
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
> -#define f2fs_show_injection_info(sbi, type)					\
> -	printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",	\
> -		KERN_INFO, sbi->sb->s_id,				\
> -		f2fs_fault_name[type],					\
> -		__func__, __builtin_return_address(0))
> -static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
> +#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
> +static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
> +								    const char *func_name)
>   {
>   	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
>   
> @@ -1893,12 +1890,14 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>   	atomic_inc(&ffi->inject_ops);
>   	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>   		atomic_set(&ffi->inject_ops, 0);
> +		printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",
> +			KERN_INFO, sbi->sb->s_id, f2fs_fault_name[type],
> +			func_name, __builtin_return_address(0));

After moving f2fs_show_injection_info() core functionality into time_to_inject(),
__builtin_return_address(0) result changes from return address of caller of
f2fs_show_injection_info() to return address of time_to_inject().

Thanks,

>   		return true;
>   	}
>   	return false;
>   }
>   #else
> -#define f2fs_show_injection_info(sbi, type) do { } while (0)
>   static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>   {
>   	return false;
> @@ -2231,10 +2230,8 @@ static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
>   
>   static inline int f2fs_trylock_op(struct f2fs_sb_info *sbi)
>   {
> -	if (time_to_inject(sbi, FAULT_LOCK_OP)) {
> -		f2fs_show_injection_info(sbi, FAULT_LOCK_OP);
> +	if (time_to_inject(sbi, FAULT_LOCK_OP))
>   		return 0;
> -	}
>   	return f2fs_down_read_trylock(&sbi->cp_rwsem);
>   }
>   
> @@ -2322,7 +2319,6 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>   		return ret;
>   
>   	if (time_to_inject(sbi, FAULT_BLOCK)) {
> -		f2fs_show_injection_info(sbi, FAULT_BLOCK);
>   		release = *count;
>   		goto release_quota;
>   	}
> @@ -2602,10 +2598,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>   			return err;
>   	}
>   
> -	if (time_to_inject(sbi, FAULT_BLOCK)) {
> -		f2fs_show_injection_info(sbi, FAULT_BLOCK);
> +	if (time_to_inject(sbi, FAULT_BLOCK))
>   		goto enospc;
> -	}
>   
>   	spin_lock(&sbi->stat_lock);
>   
> @@ -2729,11 +2723,8 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
>   		if (page)
>   			return page;
>   
> -		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
> -			f2fs_show_injection_info(F2FS_M_SB(mapping),
> -							FAULT_PAGE_ALLOC);
> +		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC))
>   			return NULL;
> -		}
>   	}
>   
>   	if (!for_write)
> @@ -2750,10 +2741,8 @@ static inline struct page *f2fs_pagecache_get_page(
>   				struct address_space *mapping, pgoff_t index,
>   				int fgp_flags, gfp_t gfp_mask)
>   {
> -	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
> -		f2fs_show_injection_info(F2FS_M_SB(mapping), FAULT_PAGE_GET);
> +	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET))
>   		return NULL;
> -	}
>   
>   	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
>   }
> @@ -2803,10 +2792,8 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
>   	if (nofail)
>   		return f2fs_kmem_cache_alloc_nofail(cachep, flags);
>   
> -	if (time_to_inject(sbi, FAULT_SLAB_ALLOC)) {
> -		f2fs_show_injection_info(sbi, FAULT_SLAB_ALLOC);
> +	if (time_to_inject(sbi, FAULT_SLAB_ALLOC))
>   		return NULL;
> -	}
>   
>   	return kmem_cache_alloc(cachep, flags);
>   }
> @@ -3380,10 +3367,8 @@ static inline bool is_dot_dotdot(const u8 *name, size_t len)
>   static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
>   					size_t size, gfp_t flags)
>   {
> -	if (time_to_inject(sbi, FAULT_KMALLOC)) {
> -		f2fs_show_injection_info(sbi, FAULT_KMALLOC);
> +	if (time_to_inject(sbi, FAULT_KMALLOC))
>   		return NULL;
> -	}
>   
>   	return kmalloc(size, flags);
>   }
> @@ -3397,10 +3382,8 @@ static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
>   static inline void *f2fs_kvmalloc(struct f2fs_sb_info *sbi,
>   					size_t size, gfp_t flags)
>   {
> -	if (time_to_inject(sbi, FAULT_KVMALLOC)) {
> -		f2fs_show_injection_info(sbi, FAULT_KVMALLOC);
> +	if (time_to_inject(sbi, FAULT_KVMALLOC))
>   		return NULL;
> -	}
>   
>   	return kvmalloc(size, flags);
>   }
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cad4bdd6f097..ef25b5b14b10 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -782,10 +782,8 @@ int f2fs_truncate(struct inode *inode)
>   
>   	trace_f2fs_truncate(inode);
>   
> -	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
> -		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_TRUNCATE);
> +	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE))
>   		return -EIO;
> -	}
>   
>   	err = f2fs_dquot_initialize(inode);
>   	if (err)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 83e68ec7763d..2b9891efcfee 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -72,11 +72,9 @@ static int gc_thread_func(void *data)
>   			continue;
>   		}
>   
> -		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
> -			f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
> +		if (time_to_inject(sbi, FAULT_CHECKPOINT))
>   			f2fs_stop_checkpoint(sbi, false,
>   					STOP_CP_REASON_FAULT_INJECT);
> -		}
>   
>   		if (!sb_start_write_trylock(sbi->sb)) {
>   			stat_other_skip_bggc_count(sbi);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index ff6cf66ed46b..01b9e6f85f6b 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -809,10 +809,8 @@ void f2fs_evict_inode(struct inode *inode)
>   	if (F2FS_HAS_BLOCKS(inode))
>   		err = f2fs_truncate(inode);
>   
> -	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
> -		f2fs_show_injection_info(sbi, FAULT_EVICT_INODE);
> +	if (time_to_inject(sbi, FAULT_EVICT_INODE))
>   		err = -EIO;
> -	}
>   
>   	if (!err) {
>   		f2fs_lock_op(sbi);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index dde4c0458704..8e87be0fa85e 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2544,10 +2544,8 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>   	struct f2fs_nm_info *nm_i = NM_I(sbi);
>   	struct free_nid *i = NULL;
>   retry:
> -	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
> -		f2fs_show_injection_info(sbi, FAULT_ALLOC_NID);
> +	if (time_to_inject(sbi, FAULT_ALLOC_NID))
>   		return false;
> -	}
>   
>   	spin_lock(&nm_i->nid_list_lock);
>   
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 25ddea478fc1..573955d9aed7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -384,10 +384,8 @@ int f2fs_commit_atomic_write(struct inode *inode)
>    */
>   void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>   {
> -	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
> -		f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
> +	if (time_to_inject(sbi, FAULT_CHECKPOINT))
>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);
> -	}
>   
>   	/* balance_fs_bg is able to be pending */
>   	if (need && excess_cached_nats(sbi))
> @@ -1142,7 +1140,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   		dc->len += len;
>   
>   		if (time_to_inject(sbi, FAULT_DISCARD)) {
> -			f2fs_show_injection_info(sbi, FAULT_DISCARD);
>   			err = -EIO;
>   		} else {
>   			err = __blkdev_issue_discard(bdev,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1f812b9ce985..73e779d3b2e7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1372,10 +1372,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>   {
>   	struct f2fs_inode_info *fi;
>   
> -	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
> -		f2fs_show_injection_info(F2FS_SB(sb), FAULT_SLAB_ALLOC);
> +	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC))
>   		return NULL;
> -	}
>   
>   	fi = alloc_inode_sb(sb, f2fs_inode_cachep, GFP_F2FS_ZERO);
>   	if (!fi)
> @@ -2595,10 +2593,8 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>   
>   int f2fs_dquot_initialize(struct inode *inode)
>   {
> -	if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT)) {
> -		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_DQUOT_INIT);
> +	if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT))
>   		return -ESRCH;
> -	}
>   
>   	return dquot_initialize(inode);
>   }
