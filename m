Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402316DC29A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDJCTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjDJCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953AC1FC4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B1360B37
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E05C433EF;
        Mon, 10 Apr 2023 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681093146;
        bh=LG6USM/94rDV9nNrdflUEcz3dzqZCI2vEu5Pzc94NY0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VncAcSSiCSr+sSk8MOIS9K54tGGqMsNKsNdxiKkrJWGxYdzKj8koi6vxTaUTq13mG
         COq2oZ+spkdiTYwHgb58L9/A0Zl5OR0UdufQJnJf7yG487TbFsjyxC8cOIVgch4bRF
         BkrzstXCK2FjpgMFt4TyBBqDGNjMTPrsRgTqdmP2ppODaRk/xVVg2t03sKs+XpMbth
         hf1KET+wMOlEwz69wA3CsNBXR4iWPYZNFcRNbIoKw+kQrlawakps7lgJocSTv+1BnS
         ptDU5TeoCpHO/qoO+ps0eMrBxj1BTr55J1tCg58gE27uO7XccaclCY7fn5yOIEK9Vk
         wYr2+UermJGFg==
Message-ID: <a8d480c5-3992-d241-97b3-2a7d7b15c1d1@kernel.org>
Date:   Mon, 10 Apr 2023 10:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: fix to check readonly condition correctly
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230402112825.42486-1-chao@kernel.org>
 <ZCsT5mRsZJqPXBzz@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZCsT5mRsZJqPXBzz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
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

Jaegeuk,

Please drop this patch, and help to check below one, thanks. :)

f2fs: use f2fs_hw_is_readonly() instead of bdev_read_only()

Thanks,

> 
> What is the problem to solve here?
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
