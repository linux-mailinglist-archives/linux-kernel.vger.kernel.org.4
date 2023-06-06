Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F868723792
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjFFGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjFFGWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95081981
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA5262D6B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6D9C433B4;
        Tue,  6 Jun 2023 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686032495;
        bh=7Y283N6eAfDc6+mkcJb/LEMLq42CKVcBrl7sj2/MNog=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CESdHtYEcYp02s8OIehmNezKAxoa9M9l0W5PoBGjUbJDEqHtdRTvqg+c93MRyy2GF
         KdKk8uRKAik+aDx7lMAK1lK8HZj9AXPQOKd5W0RDAX1g689EM5f5q1grrYjzMJxOuo
         OC5q/bBEsq5E9ZuSAW1KDwgVj3JUSdeVvs0xGIKbrP5/QXgHDq7MShDbkMwxjnfWW8
         0nBAk0CJcQrIcQjW3Ya1M+z45Y2Puvifpw4LXYAnFwWmaJ6XEgUNi+ZVT/3LEQ0Qzu
         vMc0Sq0OCyqZJkGT0JzrDQrnxtNvd1IG4Du7FxpVGzORQ0BIYtP39s6dr2pyxvZD0n
         FxLRjT3U6lhnw==
Message-ID: <58d14972-b7d5-364d-526f-b7e5fc248477@kernel.org>
Date:   Tue, 6 Jun 2023 14:21:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] f2fs: fix to avoid mmap vs set_compress_option case
Content-Language: en-US
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230529104709.2560779-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230529104709.2560779-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Any comments on this patch?

On 2023/5/29 18:47, Chao Yu wrote:
> Compression option in inode should not be changed after they have
> been used, however, it may happen in below race case:
> 
> Thread A				Thread B
> - f2fs_ioc_set_compress_option
>   - check f2fs_is_mmap_file()
>   - check get_dirty_pages()
>   - check F2FS_HAS_BLOCKS()
> 					- f2fs_file_mmap
> 					 - set_inode_flag(FI_MMAP_FILE)
> 					- fault
> 					 - do_page_mkwrite
> 					  - f2fs_vm_page_mkwrite
> 					  - f2fs_get_block_locked
> 					 - fault_dirty_shared_page
> 					  - set_page_dirty
>   - update i_compress_algorithm
>   - update i_log_cluster_size
>   - update i_cluster_size
> 
> Avoid such race condition by covering f2fs_file_mmap() w/ inode lock,
> meanwhile add mmap file check condition in f2fs_may_compress() as well.
> 
> Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add mmap file check condition in f2fs_may_compress()
>   fs/f2fs/f2fs.h |  3 ++-
>   fs/f2fs/file.c | 14 +++++++++++---
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9bd83fb28439..0db8b37c7a4d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4487,7 +4487,8 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
>   static inline bool f2fs_may_compress(struct inode *inode)
>   {
>   	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
> -		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode))
> +		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode) ||
> +		f2fs_is_mmap_file(inode))
>   		return false;
>   	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
>   }
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7b097ab2f5e4..685ded62fc28 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -519,17 +519,25 @@ static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
>   static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
>   {
>   	struct inode *inode = file_inode(file);
> +	int ret = 0;
>   
>   	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>   		return -EIO;
>   
> -	if (!f2fs_is_compress_backend_ready(inode))
> -		return -EOPNOTSUPP;
> +	inode_lock(inode);
> +
> +	if (!f2fs_is_compress_backend_ready(inode)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
>   
>   	file_accessed(file);
>   	vma->vm_ops = &f2fs_file_vm_ops;
>   	set_inode_flag(inode, FI_MMAP_FILE);
> -	return 0;
> +
> +out_unlock:
> +	inode_unlock(inode);
> +	return ret;
>   }
>   
>   static int f2fs_file_open(struct inode *inode, struct file *filp)
