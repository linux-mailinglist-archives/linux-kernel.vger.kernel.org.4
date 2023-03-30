Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6D6D07F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjC3OTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjC3OSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:18:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47BBDFD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:18:18 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PnQS067PMzKxNw;
        Thu, 30 Mar 2023 22:15:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 22:17:52 +0800
Subject: Re: [PATCH] ubifs: Fix memory leak in do_rename
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230330-memleak_rename-fix-v1-1-99789e908fdf@axis.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <bc8aaf0a-0b21-99a8-4c50-92edeff8edd7@huawei.com>
Date:   Thu, 30 Mar 2023 22:17:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230330-memleak_rename-fix-v1-1-99789e908fdf@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If renaming a file in an encrypted directory, function
> fscrypt_setup_filename allocates memory for a file name. This name is
> never used, and before returning to the caller the memory for it is not
> freed.
> 
> When running kmemleak on it we see that it is registered as a leak. The
> report below is triggered by a simple program 'rename' that renames a
> file in an encrypted directory:
> 
>    unreferenced object 0xffff888101502840 (size 32):
>      comm "rename", pid 9404, jiffies 4302582475 (age 435.735s)
>      backtrace:
>        __kmem_cache_alloc_node
>        __kmalloc
>        fscrypt_setup_filename
>        do_rename
>        ubifs_rename
>        vfs_rename
>        do_renameat2
> 
> To fix this we can remove the call to fscrypt_setup_filename as it's not
> needed.
> 
> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>   fs/ubifs/dir.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

I'm okay with this modification. It would be better to add a fix tag. 
(Fixes: 278d9a243635f26 ("ubifs: Rename whiteout atomically"))


Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 0f29cf201136..4c2dda1346e7 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -358,7 +358,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
>   	umode_t mode = S_IFCHR | WHITEOUT_MODE;
>   	struct inode *inode;
>   	struct ubifs_info *c = dir->i_sb->s_fs_info;
> -	struct fscrypt_name nm;
>   
>   	/*
>   	 * Create an inode('nlink = 1') for whiteout without updating journal,
> @@ -369,10 +368,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
>   	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
>   		dentry, mode, dir->i_ino);
>   
> -	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
> -	if (err)
> -		return ERR_PTR(err);
> -
>   	inode = ubifs_new_inode(c, dir, mode, false);
>   	if (IS_ERR(inode)) {
>   		err = PTR_ERR(inode);
> @@ -395,7 +390,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
>   	make_bad_inode(inode);
>   	iput(inode);
>   out_free:
> -	fscrypt_free_filename(&nm);
>   	ubifs_err(c, "cannot create whiteout file, error %d", err);
>   	return ERR_PTR(err);
>   }
> 
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230330-memleak_rename-fix-6f94a6f99350
> 
> Best regards,
> 

