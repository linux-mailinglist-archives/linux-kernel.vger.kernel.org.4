Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF66F037B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbjD0Ji0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjD0JiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6254CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6412C63C0F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D922C433EF;
        Thu, 27 Apr 2023 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682588302;
        bh=8h3n++F1xXGmMbuOXjl1rR2J8pNfIheLahD5RfGRUfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EjKKegG6uccwvlOD9bx9j7Xn+WMIH5PPxpdO+uu48UeQLht6Kr97s95yJc74N1bcA
         89kwt5mMhNjrBBysK467aa4QKFaIZW7wcSEDHK9V6ookjxXB5akAsu4ACKKeTABTg0
         eqRC/vCgq81nCVej2DZeUer0J4lnFcUlhKZ/hY3THvKws4w1dVz36z7LuYu4hY8zLy
         4TnG74khF3+ANXT0q/VYEbfFEZ1NZruqjQKFvbqUSbdUep/LhTlqtPyxrqaE/yg0r6
         meeoQCi1d2clRoz/lYF3DTTfG+aPVEuTlHr2Yl0RSLxD5d8mDGyNVBfE9tQ6BXxPz4
         BwxbGb0EtHhBA==
Message-ID: <626404fe-3547-979f-f483-b43416f6f88a@kernel.org>
Date:   Thu, 27 Apr 2023 17:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] f2fs: do not allow to defragment files have
 FI_COMPRESS_RELEASED
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230425151126.50566-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230425151126.50566-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/25 23:11, Yangtao Li wrote:
> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed.
> 
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9c9c3f660e01..c21d6a829c4a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2734,6 +2734,9 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>   	if (f2fs_readonly(sbi->sb))
>   		return -EROFS;
>   
> +	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
> +		return -EINVAL;

This flag should be checked w/ inode lock.

Thanks,

> +
>   	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
>   							sizeof(range)))
>   		return -EFAULT;
