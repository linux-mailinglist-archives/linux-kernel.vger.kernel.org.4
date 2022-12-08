Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453D64720D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLHOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:43:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76614D11
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:43:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D66AB8242C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5E8C433B5;
        Thu,  8 Dec 2022 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510609;
        bh=IqwRsM7lenlQresvHYwSIt1Cw7umO70+c8Xe4t1BRBc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dyAT3koB7hrpONFK+rsQDJpT/qlIanq0e5Wjf5biIvQYUyh0rbnNKJo4cT7Dmo8AO
         +8reGs2x4usN+N1ghVBrdK3ItRzt2Tfb5L3/8WlKU3DkoMYnEROiUoSwMq9XbcKH6X
         DQcNCRwtRjJse4+zydwkIx9BdT7Ius8yCXSH2g3dkCEjuBArbbc7zui2lkm7++/Zvh
         1A7oAUep7y7CBe9DRwTT3TD4+2EDlsI5WQSDwHdZsu1Qia9cj3dlan7fow64VWzNSQ
         soTBxmCeiSJ0847yc2zB/SDVv8yEXQqd886VFlE1Ql2VuPw5q4HHRXqrC1D7eTknp5
         7nI+hAI5X0J/A==
Message-ID: <8ffb43dd-3887-aa56-6f0a-1fb6ff0e191e@kernel.org>
Date:   Thu, 8 Dec 2022 22:43:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: specify extent cache for read
 explicitly
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221205185433.3479699-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/6 2:54, Jaegeuk Kim wrote:
> Let's descrbie it's read extent cache.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/extent_cache.c |  4 ++--
>   fs/f2fs/f2fs.h         | 10 +++++-----
>   fs/f2fs/inode.c        |  2 +-
>   fs/f2fs/node.c         |  2 +-
>   fs/f2fs/node.h         |  2 +-
>   fs/f2fs/segment.c      |  4 ++--
>   fs/f2fs/super.c        | 16 ++++++++--------
>   7 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 932c070173b9..8cd87aee0292 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -383,7 +383,7 @@ static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
>   	if (!i_ext || !i_ext->len)
>   		return;
>   
> -	get_extent_info(&ei, i_ext);
> +	get_read_extent_info(&ei, i_ext);
>   
>   	write_lock(&et->lock);
>   	if (atomic_read(&et->node_cnt))
> @@ -710,7 +710,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
>   	unsigned int node_cnt = 0, tree_cnt = 0;
>   	int remained;
>   
> -	if (!test_opt(sbi, EXTENT_CACHE))
> +	if (!test_opt(sbi, READ_EXTENT_CACHE))
>   		return 0;
>   
>   	if (!atomic_read(&sbi->total_zombie_tree))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eb8c27c4e5fc..1c39f8145b61 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -92,7 +92,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>   #define F2FS_MOUNT_FLUSH_MERGE		0x00000400
>   #define F2FS_MOUNT_NOBARRIER		0x00000800
>   #define F2FS_MOUNT_FASTBOOT		0x00001000
> -#define F2FS_MOUNT_EXTENT_CACHE		0x00002000
> +#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00002000
>   #define F2FS_MOUNT_DATA_FLUSH		0x00008000
>   #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
>   #define F2FS_MOUNT_USRQUOTA		0x00080000
> @@ -600,7 +600,7 @@ enum {
>   #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
>   
>   /* number of extent info in extent cache we try to shrink */
> -#define EXTENT_CACHE_SHRINK_NUMBER	128
> +#define READ_EXTENT_CACHE_SHRINK_NUMBER	128
>   
>   #define RECOVERY_MAX_RA_BLOCKS		BIO_MAX_VECS
>   #define RECOVERY_MIN_RA_BLOCKS		1
> @@ -830,7 +830,7 @@ struct f2fs_inode_info {
>   	loff_t original_i_size;		/* original i_size before atomic write */
>   };
>   
> -static inline void get_extent_info(struct extent_info *ext,
> +static inline void get_read_extent_info(struct extent_info *ext,
>   					struct f2fs_extent *i_ext)
>   {
>   	ext->fofs = le32_to_cpu(i_ext->fofs);
> @@ -838,7 +838,7 @@ static inline void get_extent_info(struct extent_info *ext,
>   	ext->len = le32_to_cpu(i_ext->len);
>   }
>   
> -static inline void set_raw_extent(struct extent_info *ext,
> +static inline void set_raw_read_extent(struct extent_info *ext,
>   					struct f2fs_extent *i_ext)
>   {
>   	i_ext->fofs = cpu_to_le32(ext->fofs);
> @@ -4407,7 +4407,7 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   
> -	if (!test_opt(sbi, EXTENT_CACHE) ||
> +	if (!test_opt(sbi, READ_EXTENT_CACHE) ||
>   			is_inode_flag_set(inode, FI_NO_EXTENT) ||
>   			(is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>   			 !f2fs_sb_has_readonly(sbi)))
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 577f109b4e1d..2c705c60019b 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -629,7 +629,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
>   
>   	if (et) {
>   		read_lock(&et->lock);
> -		set_raw_extent(&et->largest, &ri->i_ext);
> +		set_raw_read_extent(&et->largest, &ri->i_ext);
>   		read_unlock(&et->lock);
>   	} else {
>   		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index b9ee5a1176a0..84b147966080 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -85,7 +85,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
>   						sizeof(struct ino_entry);
>   		mem_size >>= PAGE_SHIFT;
>   		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
> -	} else if (type == EXTENT_CACHE) {
> +	} else if (type == READ_EXTENT_CACHE) {
>   		mem_size = (atomic_read(&sbi->total_ext_tree) *
>   				sizeof(struct extent_tree) +
>   				atomic_read(&sbi->total_ext_node) *
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 3c09cae058b0..0aa48704c77a 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -146,7 +146,7 @@ enum mem_type {
>   	NAT_ENTRIES,	/* indicates the cached nat entry */
>   	DIRTY_DENTS,	/* indicates dirty dentry pages */
>   	INO_ENTRIES,	/* indicates inode entries */
> -	EXTENT_CACHE,	/* indicates extent cache */
> +	READ_EXTENT_CACHE,	/* indicates read extent cache */
>   	DISCARD_CACHE,	/* indicates memory of cached discard cmds */
>   	COMPRESS_PAGE,	/* indicates memory of cached compressed pages */
>   	BASE_CHECK,	/* check kernel status */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9486ca49ecb1..51de358bc452 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -449,8 +449,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
>   		return;
>   
>   	/* try to shrink extent cache when there is no enough memory */
> -	if (!f2fs_available_free_memory(sbi, EXTENT_CACHE))
> -		f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
> +	if (!f2fs_available_free_memory(sbi, READ_EXTENT_CACHE))
> +		f2fs_shrink_extent_tree(sbi, READ_EXTENT_CACHE_SHRINK_NUMBER);
>   
>   	/* check the # of cached NAT entries */
>   	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 79bf1faf4161..10bd03bbefec 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -814,10 +814,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   			set_opt(sbi, FASTBOOT);
>   			break;
>   		case Opt_extent_cache:
> -			set_opt(sbi, EXTENT_CACHE);
> +			set_opt(sbi, READ_EXTENT_CACHE);
>   			break;
>   		case Opt_noextent_cache:
> -			clear_opt(sbi, EXTENT_CACHE);
> +			clear_opt(sbi, READ_EXTENT_CACHE);
>   			break;
>   		case Opt_noinline_data:
>   			clear_opt(sbi, INLINE_DATA);
> @@ -1954,10 +1954,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_puts(seq, ",barrier");
>   	if (test_opt(sbi, FASTBOOT))
>   		seq_puts(seq, ",fastboot");
> -	if (test_opt(sbi, EXTENT_CACHE))
> -		seq_puts(seq, ",extent_cache");
> +	if (test_opt(sbi, READ_EXTENT_CACHE))
> +		seq_puts(seq, ",read_extent_cache");

How about keeping consistent w/ description of f2fs.rst?

>   	else
> -		seq_puts(seq, ",noextent_cache");
> +		seq_puts(seq, ",no_read_extent_cache");

Ditto,

Thanks,

>   	if (test_opt(sbi, DATA_FLUSH))
>   		seq_puts(seq, ",data_flush");
>   
> @@ -2076,7 +2076,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>   	set_opt(sbi, INLINE_XATTR);
>   	set_opt(sbi, INLINE_DATA);
>   	set_opt(sbi, INLINE_DENTRY);
> -	set_opt(sbi, EXTENT_CACHE);
> +	set_opt(sbi, READ_EXTENT_CACHE);
>   	set_opt(sbi, NOHEAP);
>   	clear_opt(sbi, DISABLE_CHECKPOINT);
>   	set_opt(sbi, MERGE_CHECKPOINT);
> @@ -2218,7 +2218,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	bool need_restart_ckpt = false, need_stop_ckpt = false;
>   	bool need_restart_flush = false, need_stop_flush = false;
>   	bool need_restart_discard = false, need_stop_discard = false;
> -	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
> +	bool no_read_extent_cache = !test_opt(sbi, READ_EXTENT_CACHE);
>   	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
>   	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
>   	bool no_atgc = !test_opt(sbi, ATGC);
> @@ -2308,7 +2308,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	}
>   
>   	/* disallow enable/disable extent_cache dynamically */
> -	if (no_extent_cache == !!test_opt(sbi, EXTENT_CACHE)) {
> +	if (no_read_extent_cache == !!test_opt(sbi, READ_EXTENT_CACHE)) {
>   		err = -EINVAL;
>   		f2fs_warn(sbi, "switch extent_cache option is not allowed");
>   		goto restore_opts;
