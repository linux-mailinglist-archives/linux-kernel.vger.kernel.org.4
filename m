Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FA6D66AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjDDPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjDDPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809D53585
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2802A635C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ED2C4339B;
        Tue,  4 Apr 2023 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680620595;
        bh=7oy8h46rrhB1ieIqVXQECr4df3oWx5oEbXm8xhNQB/4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=g0QX2A/ElUKD3zejglZ+pWv5gerUvIOVE3W4rcE06gvtBJxrGqX6za46CTYS2HrQ8
         Yl/QySeiOxEC+7VkgN1oW9pAfe/xtrPRjAniQdGsVMie3WUZQeuwPsovIYE0X+fa8t
         /hKfpBdlEuM7sx7ph9HX/JlSqKpQHG+xTx0IlXFRmdsXhpXkxk6ARW64wcSSt/Stbq
         coEtHGRkZUw5LfZAl+Pd7j2cV64SruXpMvJwfiP5ZkJxHa8lGz2W2wpYCkRhFcfU8j
         4ciBXS9ePYhjfXv2nrRQPuCQerfo5F4oaOaFcVQfMgLtQDVCUwK1b97wksPqngqDgZ
         8PIv6yfTMQatQ==
Message-ID: <e4757f96-8749-5210-11cc-fcbe4875661d@kernel.org>
Date:   Tue, 4 Apr 2023 23:03:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230402112825.42486-1-chao@kernel.org>
 <ZCsT5mRsZJqPXBzz@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to check readonly condition correctly
In-Reply-To: <ZCsT5mRsZJqPXBzz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 1:59, Jaegeuk Kim wrote:
> On 04/02, Chao Yu wrote:
>> This patch does below changes:
>>
>> - If f2fs enables readonly feature or device is readonly, allow to
>> mount readonly mode only
>> - Introduce f2fs_dev_is_readonly() to indicate whether image or device
>> is readonly
>> - remove unnecessary f2fs_hw_is_readonly() in f2fs_write_checkpoint()
>> and f2fs_convert_inline_inode()
>> - enable FLUSH_MERGE only if f2fs is mounted as rw and image/device
>> is writable
> 
> What is the problem to solve here?

With below case, it can mount multi-device image w/ rw option, however
one of secondary device is set as ro, later update will cause panic, so
I introduced f2fs_dev_is_readonly(), and check multi-devices rw status
in parse_options() w/ it in order to avoid such inconsistent mount status.

mkfs.f2fs -c /dev/zram1 /dev/zram0 -f
blockdev --setro /dev/zram1
mount -t f2fs /dev/zram0 /mnt/f2fs/
mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.
mount -t f2fs -o remount,rw /mnt/f2fs/
dd if=/dev/zero  of=/mnt/f2fs/file bs=1M count=8192

kernel BUG at fs/f2fs/inline.c:258!
RIP: 0010:f2fs_write_inline_data+0x23e/0x2d0 [f2fs]
Call Trace:
  f2fs_write_single_data_page+0x26b/0x9f0 [f2fs]
  f2fs_write_cache_pages+0x389/0xa60 [f2fs]
  __f2fs_write_data_pages+0x26b/0x2d0 [f2fs]
  f2fs_write_data_pages+0x2e/0x40 [f2fs]
  do_writepages+0xd3/0x1b0
  __writeback_single_inode+0x5b/0x420
  writeback_sb_inodes+0x236/0x5a0
  __writeback_inodes_wb+0x56/0xf0
  wb_writeback+0x2a3/0x490
  wb_do_writeback+0x2b2/0x330
  wb_workfn+0x6a/0x260
  process_one_work+0x270/0x5e0
  worker_thread+0x52/0x3e0
  kthread+0xf4/0x120
  ret_from_fork+0x29/0x50

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/checkpoint.c |  2 +-
>>   fs/f2fs/f2fs.h       | 10 +++++-----
>>   fs/f2fs/inline.c     |  3 +--
>>   fs/f2fs/super.c      | 13 +++++++------
>>   4 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 8e1db5752fff..1eef597ed393 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1604,7 +1604,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   	unsigned long long ckpt_ver;
>>   	int err = 0;
>>   
>> -	if (f2fs_readonly(sbi->sb) || f2fs_hw_is_readonly(sbi))
>> +	if (f2fs_readonly(sbi->sb))
>>   		return -EROFS;
>>   
>>   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 2d4a7ef62537..7de95133478a 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4446,6 +4446,11 @@ static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
>>   	return false;
>>   }
>>   
>> +static inline bool f2fs_dev_is_readonly(struct f2fs_sb_info *sbi)
>> +{
>> +	return f2fs_sb_has_readonly(sbi) || f2fs_hw_is_readonly(sbi);
>> +}
>> +
>>   static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
>>   {
>>   	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
>> @@ -4546,11 +4551,6 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
>>   	}
>>   }
>>   
>> -static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
>> -{
>> -	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
>> -}
>> -
>>   #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>>   #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>>   
>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>> index 72269e7efd26..2c36f2dc2317 100644
>> --- a/fs/f2fs/inline.c
>> +++ b/fs/f2fs/inline.c
>> @@ -203,8 +203,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
>>   	struct page *ipage, *page;
>>   	int err = 0;
>>   
>> -	if (!f2fs_has_inline_data(inode) ||
>> -			f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
>> +	if (!f2fs_has_inline_data(inode) || f2fs_readonly(sbi->sb))
>>   		return 0;
>>   
>>   	err = f2fs_dquot_initialize(inode);
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index d016f398fcad..db7649010c12 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1382,15 +1382,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
>> +	if (f2fs_dev_is_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
>> +		f2fs_err(sbi, "Allow to mount readonly mode only");
>> +		return -EROFS;
>> +	}
>> +
>> +	if (f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE)) {
>>   		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
>> -		f2fs_err(sbi, "Allow to mount readonly mode only");
>> -		return -EROFS;
>> -	}
>>   	return 0;
>>   }
>>   
>> @@ -2122,7 +2123,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>   	set_opt(sbi, MERGE_CHECKPOINT);
>>   	F2FS_OPTION(sbi).unusable_cap = 0;
>>   	sbi->sb->s_flags |= SB_LAZYTIME;
>> -	if (!f2fs_is_readonly(sbi))
>> +	if (!f2fs_readonly(sbi->sb) && !f2fs_dev_is_readonly(sbi))
>>   		set_opt(sbi, FLUSH_MERGE);
>>   	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
>>   		set_opt(sbi, DISCARD);
>> -- 
>> 2.36.1
