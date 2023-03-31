Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DE86D2101
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjCaM6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjCaM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70360210D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F03628C8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC459C433D2;
        Fri, 31 Mar 2023 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680267510;
        bh=UgrdYIiRIbayP2Q1rIOBzLC98/PLeze/M5lY956Ds+8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VMPzYccq2lNRrECym0avp51Jp5+rIWGRObTEnwkUjKugo0vt1hWQcN7U2wQ1hmCDR
         M7D+iS5IPTfJ0BIy74aZhka/pU9+QaNID0F0j2YO3rAi6A9uCH9xtEm1zi/xOTvXT7
         /txk36wbyKb21fsmmIQwk9ugDAG6vs9EOQxq1cqOs9DhTsx13Xl3Ij7U7IeRRpZSyX
         ALKUPCw1w98j0UrDfsNxCTQAGn+5LOenGvRwWP0LoGk3nK4BU98vy47wWl3SIVOoji
         JaxNIsQUjq7wAsvaKX3hs+mjjKqW9on47bdG2wnv7nk8HoMuTse6tD1WGDNTZQGqco
         wbp/0eHLkGR+g==
Message-ID: <cc346bd6-16bb-a38d-d0d8-ec7e928b27e9@kernel.org>
Date:   Fri, 31 Mar 2023 20:58:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: support fault injection for
 f2fs_down_write_trylock()
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230330152510.81886-1-frank.li@vivo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330152510.81886-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/30 23:25, Yangtao Li wrote:
> Similar to FAULT_LOCK_OP, this patch supports to inject fault into
> f2fs_down_write_trylock().

I guess we can cover all trylock w/ FAULT_LOCK_OP type fault injection,
rather than just cover f2fs_down_write_trylock().

Including:
- inode_trylock
- down_read_trylock
- down_write_trylock
- mutex_trylock
- sb_start_write_trylock
- trylock_page

Bug only excluding f2fs_trylock_op which was covered by FAULT_LOCK_OP?

What do you think?

Thanks,

> 
> Usage:
>    a) echo 524288 > /sys/fs/f2fs/<dev>/inject_type or
>    b) mount -o fault_type=524288 <dev> <mountpoint>
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -remove f2fs_down_write_trylock macro
>   Documentation/ABI/testing/sysfs-fs-f2fs |  1 +
>   Documentation/filesystems/f2fs.rst      |  1 +
>   fs/f2fs/checkpoint.c                    |  4 ++--
>   fs/f2fs/f2fs.h                          |  7 ++++++-
>   fs/f2fs/file.c                          |  8 ++++----
>   fs/f2fs/gc.c                            | 10 +++++-----
>   fs/f2fs/node.c                          |  2 +-
>   fs/f2fs/super.c                         |  1 +
>   8 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index c1314b7fe544..fc0f82f5c9f9 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -714,6 +714,7 @@ Description:	Support configuring fault injection type, should be
>   		FAULT_DQUOT_INIT         0x000010000
>   		FAULT_LOCK_OP            0x000020000
>   		FAULT_BLKADDR            0x000040000
> +		FAULT_LOCK               0x000080000
>   		===================      ===========
>   
>   What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 2055e72871fe..a81c896464ff 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -206,6 +206,7 @@ fault_type=%d		 Support configuring fault injection type, should be
>   			 FAULT_DQUOT_INIT	  0x000010000
>   			 FAULT_LOCK_OP		  0x000020000
>   			 FAULT_BLKADDR		  0x000040000
> +			 FAULT_LOCK	          0x000080000
>   			 ===================	  ===========
>   mode=%s			 Control block allocation mode which supports "adaptive"
>   			 and "lfs". In "lfs" mode, there should be no random
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 1e0164cde23d..b119c9ab0cc1 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -372,7 +372,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
>   		goto skip_write;
>   
>   	/* if locked failed, cp will flush dirty pages instead */
> -	if (!f2fs_down_write_trylock(&sbi->cp_global_sem))
> +	if (!f2fs_down_write_trylock(sbi, &sbi->cp_global_sem))
>   		goto skip_write;
>   
>   	trace_f2fs_writepages(mapping->host, wbc, META);
> @@ -1185,7 +1185,7 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
>   	if (!is_journalled_quota(sbi))
>   		return false;
>   
> -	if (!f2fs_down_write_trylock(&sbi->quota_sem))
> +	if (!f2fs_down_write_trylock(sbi, &sbi->quota_sem))
>   		return true;
>   	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH)) {
>   		ret = false;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e73fefe0d8fb..d434c25fa175 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -61,6 +61,7 @@ enum {
>   	FAULT_DQUOT_INIT,
>   	FAULT_LOCK_OP,
>   	FAULT_BLKADDR,
> +	FAULT_LOCK,
>   	FAULT_MAX,
>   };
>   
> @@ -2193,8 +2194,12 @@ static inline void f2fs_down_write(struct f2fs_rwsem *sem)
>   	down_write(&sem->internal_rwsem);
>   }
>   
> -static inline int f2fs_down_write_trylock(struct f2fs_rwsem *sem)
> +static inline int f2fs_down_write_trylock(struct f2fs_sb_info *sbi,
> +					struct f2fs_rwsem *sem)
>   {
> +	if (time_to_inject(sbi, FAULT_LOCK))
> +		return 0;
> +
>   	return down_write_trylock(&sem->internal_rwsem);
>   }
>   
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 14e9a20e68df..db8c435d6201 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2462,7 +2462,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
>   		return ret;
>   
>   	if (!sync) {
> -		if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
> +		if (!f2fs_down_write_trylock(sbi, &sbi->gc_lock)) {
>   			ret = -EBUSY;
>   			goto out;
>   		}
> @@ -2506,7 +2506,7 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
>   
>   do_more:
>   	if (!range->sync) {
> -		if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
> +		if (!f2fs_down_write_trylock(sbi, &sbi->gc_lock)) {
>   			ret = -EBUSY;
>   			goto out;
>   		}
> @@ -2851,7 +2851,7 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	f2fs_down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>   	if (src != dst) {
>   		ret = -EBUSY;
> -		if (!f2fs_down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE]))
> +		if (!f2fs_down_write_trylock(sbi, &F2FS_I(dst)->i_gc_rwsem[WRITE]))
>   			goto out_src;
>   	}
>   
> @@ -2971,7 +2971,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
>   	end_segno = min(start_segno + range.segments, dev_end_segno);
>   
>   	while (start_segno < end_segno) {
> -		if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
> +		if (!f2fs_down_write_trylock(sbi, &sbi->gc_lock)) {
>   			ret = -EBUSY;
>   			goto out;
>   		}
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 7e97e4284db5..302950c6cbeb 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -104,7 +104,7 @@ static int gc_thread_func(void *data)
>   		if (foreground) {
>   			f2fs_down_write(&sbi->gc_lock);
>   			goto do_gc;
> -		} else if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
> +		} else if (!f2fs_down_write_trylock(sbi, &sbi->gc_lock)) {
>   			stat_other_skip_bggc_count(sbi);
>   			goto next;
>   		}
> @@ -1577,7 +1577,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>   				return submitted;
>   			}
>   
> -			if (!f2fs_down_write_trylock(
> +			if (!f2fs_down_write_trylock(sbi,
>   				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
>   				iput(inode);
>   				sbi->skipped_gc_rwsem++;
> @@ -1620,11 +1620,11 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>   			int err;
>   
>   			if (S_ISREG(inode->i_mode)) {
> -				if (!f2fs_down_write_trylock(&fi->i_gc_rwsem[READ])) {
> +				if (!f2fs_down_write_trylock(sbi, &fi->i_gc_rwsem[READ])) {
>   					sbi->skipped_gc_rwsem++;
>   					continue;
>   				}
> -				if (!f2fs_down_write_trylock(
> +				if (!f2fs_down_write_trylock(sbi,
>   						&fi->i_gc_rwsem[WRITE])) {
>   					sbi->skipped_gc_rwsem++;
>   					f2fs_up_write(&fi->i_gc_rwsem[READ]);
> @@ -2150,7 +2150,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>   	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
>   
>   	/* stop other GC */
> -	if (!f2fs_down_write_trylock(&sbi->gc_lock))
> +	if (!f2fs_down_write_trylock(sbi, &sbi->gc_lock))
>   		return -EAGAIN;
>   
>   	/* stop CP to protect MAIN_SEC in free_segment_range */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index bd1dad523796..e8e838f72ae6 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -517,7 +517,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
>   	struct f2fs_nm_info *nm_i = NM_I(sbi);
>   	int nr = nr_shrink;
>   
> -	if (!f2fs_down_write_trylock(&nm_i->nat_tree_lock))
> +	if (!f2fs_down_write_trylock(sbi, &nm_i->nat_tree_lock))
>   		return 0;
>   
>   	spin_lock(&nm_i->nat_list_lock);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7d0202f7b317..768be1c76a47 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -62,6 +62,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
>   	[FAULT_DQUOT_INIT]	= "dquot initialize",
>   	[FAULT_LOCK_OP]		= "lock_op",
>   	[FAULT_BLKADDR]		= "invalid blkaddr",
> +	[FAULT_LOCK]		= "lock",
>   };
>   
>   void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
