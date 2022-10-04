Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EE5F46D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJDPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJDPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:41:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF094DB69
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7D14B81B3A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAEEC433C1;
        Tue,  4 Oct 2022 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664898096;
        bh=P44hUj+idhBMNAf0TO7tFSAmItXg2jgFuF6nRwWxmcc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NmVUwlO/fVwXuMR8Oa+BndDftDN/VMXqwwOcWpMRJfTkWPVMAIQqvKP+2Y/KEh+wr
         T8BOIXwC+B8yVwepGgjB4ehExsV7Xxwu/Xc7ra7KBjomG9S8VSsFD6nTim5rW8BjW2
         D/AI1y+74XPvY+s5zrag92Jj9qKo0XksGWmDZT+SmD0a7bPpd7ru1oHyIwgDm7D6z/
         Ilvm+edfvoxMzgcJYo7mgLLn4Iq4P2rMZnJcqz6c+pAdMcdQHA6SZ6A13WZ1L3bmNd
         6DmdconVHl26K/d8ZnwQe8kR2py42CS0LSiGkWjfE6F5TRzF4gEEJV7hyy/N5ShJ5N
         GX9Ue5Clf1xEA==
Message-ID: <85cc583c-279c-2d65-4cfd-ebd54468c6f5@kernel.org>
Date:   Tue, 4 Oct 2022 23:41:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: correct i_size change for atomic
 writes
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20221004001050.3269377-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221004001050.3269377-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/4 8:10, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to make sure i_size doesn't change until atomic write commit is
> successful and restore it when commit is failed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v3: make sure inode is clean while atomic writing
> ---
>   fs/f2fs/f2fs.h    |  1 +
>   fs/f2fs/file.c    | 18 +++++++++++-------
>   fs/f2fs/inode.c   |  3 +++
>   fs/f2fs/segment.c |  4 +++-
>   4 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dee7b67a17a6..539da7f12cfc 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -821,6 +821,7 @@ struct f2fs_inode_info {
>   	unsigned int i_cluster_size;		/* cluster size */
>   
>   	unsigned int atomic_write_cnt;
> +	loff_t original_i_size;		/* original i_size before atomic write */
>   };
>   
>   static inline void get_extent_info(struct extent_info *ext,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5efe0e4a725a..ce2336d2f688 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1989,6 +1989,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct inode *pinode;
> +	loff_t isize;
>   	int ret;
>   
>   	if (!inode_owner_or_capable(mnt_userns, inode))
> @@ -2047,7 +2048,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>   		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>   		goto out;
>   	}
> -	f2fs_i_size_write(fi->cow_inode, i_size_read(inode));
> +
> +	f2fs_write_inode(inode, NULL);
> +
> +	isize = i_size_read(inode);
> +	fi->original_i_size = isize;
> +	f2fs_i_size_write(fi->cow_inode, isize);
>   
>   	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>   	sbi->atomic_files++;
> @@ -2087,16 +2093,14 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>   
>   	if (f2fs_is_atomic_file(inode)) {
>   		ret = f2fs_commit_atomic_write(inode);
> -		if (ret)
> -			goto unlock_out;
> -
> -		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>   		if (!ret)
> -			f2fs_abort_atomic_write(inode, false);
> +			ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> +
> +		f2fs_abort_atomic_write(inode, ret);
>   	} else {
>   		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
>   	}
> -unlock_out:
> +
>   	inode_unlock(inode);
>   	mnt_drop_write_file(filp);
>   	return ret;
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index cde0a3dc80c3..64d7772b4cd9 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -30,6 +30,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>   	if (f2fs_inode_dirtied(inode, sync))
>   		return;
>   
> +	if (f2fs_is_atomic_file(inode))
> +		return;
> +
>   	mark_inode_dirty_sync(inode);
>   }
>   
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 460048f3c850..143b7ea0fb8e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -193,8 +193,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>   	if (!f2fs_is_atomic_file(inode))
>   		return;
>   
> -	if (clean)
> +	if (clean) {
>   		truncate_inode_pages_final(inode->i_mapping);
> +		f2fs_i_size_write(inode, fi->original_i_size);

inode has atomic_write flag, it can not be set dirtied here, how
about writing i_size ater clear_inode_flag(inode, FI_ATOMIC_FILE)?

Thanks,

> +	}
>   	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
>   	iput(fi->cow_inode);
>   	fi->cow_inode = NULL;
