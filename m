Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC256D0284
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjC3LGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjC3LGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:06:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4B6A71
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:05:59 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PnL9X1c9lz17Lbs;
        Thu, 30 Mar 2023 19:02:40 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 19:05:56 +0800
Subject: Re: [PATCH v2] ubifs: Free memory for tmpfile name
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230329-memleak-fix-v2-1-cb8d9394300b@axis.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <72ffd9c6-e203-be55-6663-768262fb611e@huawei.com>
Date:   Thu, 30 Mar 2023 19:05:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230329-memleak-fix-v2-1-cb8d9394300b@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When opening a ubifs tmpfile on an encrypted directory, function
> fscrypt_setup_filename allocates memory for the name that is to be
> stored in the directory entry, but after the name has been copied to the
> directory entry inode, the memory is not freed.
> 
> When running kmemleak on it we see that it is registered as a leak. The
> report below is triggered by a simple program 'tmpfile' just opening a
> tmpfile:
> 
>    unreferenced object 0xffff88810178f380 (size 32):
>      comm "tmpfile", pid 509, jiffies 4294934744 (age 1524.742s)
>      backtrace:
>        __kmem_cache_alloc_node
>        __kmalloc
>        fscrypt_setup_filename
>        ubifs_tmpfile
>        vfs_tmpfile
>        path_openat
> 
> Free this memory after it has been copied to the inode.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> Changes in v2:
> - Call fscrypt_free_filename after ubifs_release_budget
> - Link to v1: https://lore.kernel.org/r/20230329-memleak-fix-v1-1-7133da56ea8f@axis.com
> ---
>   fs/ubifs/dir.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 0f29cf201136..7dd6dd34b84c 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -492,6 +492,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>   	unlock_2_inodes(dir, inode);
>   
>   	ubifs_release_budget(c, &req);
> +	fscrypt_free_filename(&nm);
>   
>   	return finish_open_simple(file, 0);
>   
> 
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230329-memleak-fix-87a01daf469e
> 
> Best regards,
> 

