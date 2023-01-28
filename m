Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C235067F3E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjA1CH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:07:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF51A979
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:07:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C224261DDC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E0C433EF;
        Sat, 28 Jan 2023 02:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674871675;
        bh=xgzCRzmI0lEryWo5hfa+X56jGl8dwqUVxbtlBrWeTJ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QLjkhLTOehTSsfYs+XlzYgoTWNywLpaOOD/rrOee6Nda8wCsRGMWtXoJyo+0EYY9g
         BpVDLLW3Pp1RzKD3Z33u3jmUEJwtJWhauUchgGYdUZ9qz5ICnx/QZGs6A+zWo6Ieob
         DBWRclqJsqT9a36iy8oE3ggScDqx27MCGWZnKrNTbY0aXh4FK/nOrDXYfH2oBskJ3K
         BK55KV2x0BJ7HdOxBR+6r6FtTTBP0lvcTnkJCtMbFuOOHV1qVKxW8vsr4WUluXGok3
         GRX4zKim8qK63V3pHwxLDo3f6ZNhls5g7yUnkdddcGROhUY3mrzNtRhc3oGDYo7kkN
         /15Rm9/SraZWQ==
Message-ID: <ed5f65a7-13bb-581c-cfb5-df5ab30fbc4c@kernel.org>
Date:   Sat, 28 Jan 2023 10:07:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: synchronize atomic write aborts
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
References: <20230113004933.2082072-1-daeho43@gmail.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230113004933.2082072-1-daeho43@gmail.com>
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

Hi Daeho, Jaegeuk,

Please take a look at patchset in below link:

https://lore.kernel.org/linux-f2fs-devel/20230109034453.490176-1-chao@kernel.org/T/#t

In PATCH 4/5, I'm trying to fix the same issue w/ alternative way, let me
know your preference. :)

One comment as below.

On 2023/1/13 8:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> To fix a race condition between atomic write aborts, I use the inode
> lock and make COW inode to be re-usable thoroughout the whole
> atomic file inode lifetime.
> 
> Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/file.c    | 43 ++++++++++++++++++++++++++++---------------
>   fs/f2fs/inode.c   | 11 +++++++++--
>   fs/f2fs/segment.c |  3 ---
>   fs/f2fs/super.c   |  2 --
>   4 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ecbc8c135b49..ff072a9ed258 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1866,7 +1866,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
>   			atomic_read(&inode->i_writecount) != 1)
>   		return 0;
>   
> +	inode_lock(inode);
>   	f2fs_abort_atomic_write(inode, true);
> +	inode_unlock(inode);
> +
>   	return 0;
>   }
>   
> @@ -1880,8 +1883,11 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
>   	 * until all the writers close its file. Since this should be done
>   	 * before dropping file lock, it needs to do in ->flush.
>   	 */
> -	if (F2FS_I(inode)->atomic_write_task == current)
> +	if (F2FS_I(inode)->atomic_write_task == current) {
> +		inode_lock(inode);
>   		f2fs_abort_atomic_write(inode, true);
> +		inode_unlock(inode);
> +	}
>   	return 0;
>   }
>   
> @@ -2087,19 +2093,28 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   		goto out;
>   	}
>   
> -	/* Create a COW inode for atomic write */
> -	pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> -	if (IS_ERR(pinode)) {
> -		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -		ret = PTR_ERR(pinode);
> -		goto out;
> -	}
> +	/* Check if the inode already has a COW inode */
> +	if (fi->cow_inode == NULL) {
> +		/* Create a COW inode for atomic write */
> +		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> +		if (IS_ERR(pinode)) {
> +			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +			ret = PTR_ERR(pinode);
> +			goto out;
> +		}
>   
> -	ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
> -	iput(pinode);
> -	if (ret) {
> -		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -		goto out;
> +		ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
> +		iput(pinode);
> +		if (ret) {
> +			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +			goto out;
> +		}
> +
> +		set_inode_flag(fi->cow_inode, FI_COW_FILE);
> +		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> +	} else {
> +		/* Reuse the already created COW inode */
> +		f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>   	}
>   
>   	f2fs_write_inode(inode, NULL);
> @@ -2107,8 +2122,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   	stat_inc_atomic_inode(inode);
>   
>   	set_inode_flag(inode, FI_ATOMIC_FILE);
> -	set_inode_flag(fi->cow_inode, FI_COW_FILE);
> -	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>   
>   	isize = i_size_read(inode);
>   	fi->original_i_size = isize;
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index ff6cf66ed46b..4921f7209e28 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -766,11 +766,18 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>   void f2fs_evict_inode(struct inode *inode)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	nid_t xnid = fi->i_xattr_nid;
>   	int err = 0;
>   
>   	f2fs_abort_atomic_write(inode, true);
>   
> +	if (fi->cow_inode) {
> +		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> +		iput(fi->cow_inode);
> +		fi->cow_inode = NULL;
> +	}
> +
>   	trace_f2fs_evict_inode(inode);
>   	truncate_inode_pages_final(&inode->i_data);
>   
> @@ -857,7 +864,7 @@ void f2fs_evict_inode(struct inode *inode)
>   	stat_dec_inline_inode(inode);
>   	stat_dec_compr_inode(inode);
>   	stat_sub_compr_blocks(inode,
> -			atomic_read(&F2FS_I(inode)->i_compr_blocks));
> +			atomic_read(&fi->i_compr_blocks));
>   
>   	if (likely(!f2fs_cp_error(sbi) &&
>   				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ae3c4e5474ef..536d7c674b04 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -192,9 +192,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>   	if (!f2fs_is_atomic_file(inode))
>   		return;
>   
> -	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> -	iput(fi->cow_inode);
> -	fi->cow_inode = NULL;
>   	release_atomic_write_cnt(inode);
>   	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
>   	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1f812b9ce985..10463f084d30 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1430,8 +1430,6 @@ static int f2fs_drop_inode(struct inode *inode)
>   			atomic_inc(&inode->i_count);
>   			spin_unlock(&inode->i_lock);
>   
> -			f2fs_abort_atomic_write(inode, true);

In order to avoid caching obsolete page of cow_inode, how about truncating
them here?

if (f2fs_is_atomic_file() && cow_inode)
	truncate_inode_pages_final(&cow_inode->i_data);

Thanks,

> -
>   			/* should remain fi->extent_tree for writepage */
>   			f2fs_destroy_extent_node(inode);
>   
