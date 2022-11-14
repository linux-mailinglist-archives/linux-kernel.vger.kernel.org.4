Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2460628498
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiKNQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:05:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE19FD8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A087E61162
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A9DC433D6;
        Mon, 14 Nov 2022 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668441902;
        bh=WrMAiJWAGjL/5kxc67SHz6ZQmpO1PjsLIpr9WTxGv88=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qeTsKhN70k17i1CzzIWPTVnTfEhhwZWla/47uJoZCXzwrPj82Qmcl48kGlN8xRgdy
         bBzac62KJil7qgkrWD3KfleMj4Ltawu9hw+oHfR+4fuYY1uofG/pY4ZMn36MOYlwQd
         BDtVh1DNJc9OUiX1DP/VkWNDUHv65RW6HyEbg71GzmF7m5taS/k0zlo67fGCrLtWbA
         FQFJngvaP99NXgqybyJuKCdxn7hiHqnYoBloDnoW+il9n/+lheIde4U8cxcA81UtHW
         444pZzcs3CauxpPAy94w0HVoANCMjTTYj2GMbxB9FMtzWWBp8VWNObTAeYIXhArBbu
         w39uNQdkWqb5A==
Message-ID: <ce324279-bd2e-1595-0cdd-f1fdaf549549@kernel.org>
Date:   Tue, 15 Nov 2022 00:05:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] f2fs: fix to enable compress for newly created
 file if extension matches
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong@oppo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221111100830.953733-1-shengyong@oppo.com>
 <Y272nVjzr6CynmyQ@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y272nVjzr6CynmyQ@google.com>
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

On 2022/11/12 9:27, Jaegeuk Kim wrote:
> Does thes make sense?

Jaegeuk,

Could you please send modified patches to mailing list, otherwise,
I can not add comments on specified line.

Thanks,

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=608460dfae20b9d23aa222f7448710a086778222
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=962379487b5cb9f3b85ea367b130c2c6ca584edf
> 
> Second one is needed to address build error.
> 
> On 11/11, Sheng Yong wrote:
>> If compress_extension is set, and a newly created file matches the
>> extension, the file could be marked as compression file. However,
>> if inline_data is also enabled, there is no chance to check its
>> extension since f2fs_should_compress() always returns false.
>>
>> This patch moves set_compress_inode(), which do extension check, in
>> f2fs_should_compress() to check extensions before setting inline
>> data flag.
>>
>> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
>> Signed-off-by: Sheng Yong <shengyong@oppo.com>
>> ---
>>   fs/f2fs/namei.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> ---
>> v1->v2: add filename parameter for f2fs_new_inode, and move
>>          set_compress_inode into f2fs_new_inode
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index e104409c3a0e5..36e251f438568 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -22,8 +22,12 @@
>>   #include "acl.h"
>>   #include <trace/events/f2fs.h>
>>   
>> +static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
>> +						const unsigned char *name);
>> +
>>   static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>> -						struct inode *dir, umode_t mode)
>> +						struct inode *dir, umode_t mode,
>> +						const char *name)
>>   {
>>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>>   	nid_t ino;
>> @@ -119,6 +123,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>>   		if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
>>   					f2fs_may_compress(inode))
>>   			set_compress_context(inode);
>> +		if (name)
>> +			set_compress_inode(sbi, inode, name);
>>   	}
>>   
>>   	/* Should enable inline_data after compression set */
>> @@ -293,8 +299,7 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
>>   	unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
>>   	int i, cold_count, hot_count;
>>   
>> -	if (!f2fs_sb_has_compression(sbi) ||
>> -			F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
>> +	if (F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
>>   			!f2fs_may_compress(inode) ||
>>   			(!ext_cnt && !noext_cnt))
>>   		return;
>> @@ -326,10 +331,6 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
>>   	for (i = 0; i < ext_cnt; i++) {
>>   		if (!is_extension_exist(name, ext[i], false))
>>   			continue;
>> -
>> -		/* Do not use inline_data with compression */
>> -		stat_dec_inline_inode(inode);
>> -		clear_inode_flag(inode, FI_INLINE_DATA);
>>   		set_compress_context(inode);
>>   		return;
>>   	}
>> @@ -352,15 +353,13 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (err)
>>   		return err;
>>   
>> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
>> +	inode = f2fs_new_inode(mnt_userns, dir, mode, dentry->d_name.name);
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>>   	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
>>   		set_file_temperature(sbi, inode, dentry->d_name.name);
>>   
>> -	set_compress_inode(sbi, inode, dentry->d_name.name);
>> -
>>   	inode->i_op = &f2fs_file_inode_operations;
>>   	inode->i_fop = &f2fs_file_operations;
>>   	inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> @@ -689,7 +688,7 @@ static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (err)
>>   		return err;
>>   
>> -	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO);
>> +	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO, NULL);
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>> @@ -760,7 +759,7 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (err)
>>   		return err;
>>   
>> -	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode);
>> +	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode, NULL);
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>> @@ -817,7 +816,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (err)
>>   		return err;
>>   
>> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
>> +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>> @@ -856,7 +855,7 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (err)
>>   		return err;
>>   
>> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
>> +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>> -- 
>> 2.25.1
