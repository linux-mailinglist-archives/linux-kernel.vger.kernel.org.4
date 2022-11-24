Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CDC637C92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKXPMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKXPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:12:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25747B43
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:12:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC83DB827FF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD06C433D6;
        Thu, 24 Nov 2022 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669302744;
        bh=OtLRvA4YMC+HsHOS+DjoSGWEC2yDF5c6xjThOmpeUiw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LExguQ8/5p1rEte9Om550OXwVQL5KHe3B8Aq6oOUB0i4QIWInzh1bHmLp08Uy56YS
         UKOyC7u8Kddlv9bkFq/gQtfaD+H4DC4FF+RZjvTRxHGYSNIO/txXbOFRrHV73on9us
         gF2ZR1IS6rn13RKF4KX1F2xA9Lr4/L+BhCk5Abk8yhus4a+r14SALefvfNudaSKwnH
         C2Yn5GVZLArSjz2irlIRCK/8efBmgOLrjGxZIYtdbpr32fu1SYKTQORaKO6XkiTK8K
         CIwYHvVrREyGZtv2XxdrSCCTThMEcye/wP5t+ZrDActpqHu2gdegV6szTKpOkNOM8R
         6Xu64UO3ZuuGw==
Message-ID: <1faee1c5-33ca-2d1f-0079-0e7bcbd3df21@kernel.org>
Date:   Thu, 24 Nov 2022 23:12:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: introduce
 F2FS_IOC_START_ATOMIC_REPLACE
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20221111170406.1086745-1-daeho43@gmail.com>
 <6e26eb7d-8b9e-5a91-b66f-a6f8cf1d53ce@kernel.org>
 <Y36Xis5vGsfzVS8l@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y36Xis5vGsfzVS8l@google.com>
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

On 2022/11/24 5:58, Jaegeuk Kim wrote:
> On 11/23, Chao Yu wrote:
>> On 2022/11/12 1:04, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> introduce a new ioctl to replace the whole content of a file atomically,
>>> which means it induces truncate and content update at the same time.
>>> We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
>>> F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
>>> F2FS_IOC_ABORT_ATOMIC_WRITE.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>> v7: changed where to clear FI_ATOMIC_REPLACE
>>>       fixed tentative race condition in f2fs_ioc_start_atomic_write()
>>> v3: move i_size change after setting atomic write flag
>>> v2: add undefined ioctl number reported by <lkp@intel.com>
>>> ---
>>>    fs/f2fs/data.c            |  3 +++
>>>    fs/f2fs/f2fs.h            |  1 +
>>>    fs/f2fs/file.c            | 21 +++++++++++++++------
>>>    fs/f2fs/segment.c         | 13 ++++++++++++-
>>>    include/uapi/linux/f2fs.h |  1 +
>>>    5 files changed, 32 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 5f895ddcd64a..bce4dcc3ad78 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -3457,6 +3457,9 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>>>    	else if (*blk_addr != NULL_ADDR)
>>>    		return 0;
>>> +	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
>>> +		goto reserve_block;
>>> +
>>>    	/* Look for the block in the original inode */
>>>    	err = __find_data_block(inode, index, &ori_blk_addr);
>>>    	if (err)
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index e29f9adf60ca..d513ecd17550 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -765,6 +765,7 @@ enum {
>>>    	FI_ALIGNED_WRITE,	/* enable aligned write */
>>>    	FI_COW_FILE,		/* indicate COW file */
>>>    	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
>>> +	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
>>>    	FI_MAX,			/* max flag, never be used */
>>>    };
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 7ce629c95f4a..f9a04f6d76cb 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1984,7 +1984,7 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
>>>    	return put_user(inode->i_generation, (int __user *)arg);
>>>    }
>>> -static int f2fs_ioc_start_atomic_write(struct file *filp)
>>> +static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>>>    {
>>>    	struct inode *inode = file_inode(filp);
>>>    	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
>>> @@ -2053,15 +2053,22 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>    	f2fs_write_inode(inode, NULL);
>>> -	isize = i_size_read(inode);
>>> -	fi->original_i_size = isize;
>>> -	f2fs_i_size_write(fi->cow_inode, isize);
>>> -
>>>    	stat_inc_atomic_inode(inode);
>>>    	set_inode_flag(inode, FI_ATOMIC_FILE);
>>>    	set_inode_flag(fi->cow_inode, FI_COW_FILE);
>>>    	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>>> +
>>> +	isize = i_size_read(inode);
>>> +	fi->original_i_size = isize;
>>> +	if (truncate) {
>>> +		set_inode_flag(inode, FI_ATOMIC_REPLACE);
>>> +		truncate_inode_pages_final(inode->i_mapping);
>>> +		f2fs_i_size_write(inode, 0);
>>> +		isize = 0;
>>> +	}
>>> +	f2fs_i_size_write(fi->cow_inode, isize);
>>> +
>>>    	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>>>    	f2fs_update_time(sbi, REQ_TIME);
>>> @@ -4089,7 +4096,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>    	case FS_IOC_GETVERSION:
>>>    		return f2fs_ioc_getversion(filp, arg);
>>>    	case F2FS_IOC_START_ATOMIC_WRITE:
>>> -		return f2fs_ioc_start_atomic_write(filp);
>>> +		return f2fs_ioc_start_atomic_write(filp, false);
>>> +	case F2FS_IOC_START_ATOMIC_REPLACE:
>>> +		return f2fs_ioc_start_atomic_write(filp, true);
>>>    	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
>>>    		return f2fs_ioc_commit_atomic_write(filp);
>>>    	case F2FS_IOC_ABORT_ATOMIC_WRITE:
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 9cbf88092c78..f2930fffbc7d 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -197,6 +197,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>>>    	fi->cow_inode = NULL;
>>>    	release_atomic_write_cnt(inode);
>>>    	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
>>> +	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
>>>    	clear_inode_flag(inode, FI_ATOMIC_FILE);
>>>    	stat_dec_atomic_inode(inode);
>>> @@ -261,14 +262,24 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
>>>    					bool revoke)
>>>    {
>>>    	struct revoke_entry *cur, *tmp;
>>> +	pgoff_t start_index = 0;
>>> +	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
>>>    	list_for_each_entry_safe(cur, tmp, head, list) {
>>> -		if (revoke)
>>> +		if (revoke) {
>>>    			__replace_atomic_write_block(inode, cur->index,
>>>    						cur->old_addr, NULL, true);
>>> +		} else if (truncate) {
>>> +			f2fs_truncate_hole(inode, start_index, cur->index);
>>> +			start_index = cur->index + 1;
>>
>> Do we try to truncate from page #0 to page #(index of last page in chain)?
>>
>> If so, how about calling f2fs_truncate_hole(, 0, last_index) after the loop?
> 
> I think either would be fine. Could you please send a separate patch for this?

Fine, let me add a new patch to clean up it.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>> +		}
>>> +
>>>    		list_del(&cur->list);
>>>    		kmem_cache_free(revoke_entry_slab, cur);
>>>    	}
>>> +
>>> +	if (!revoke && truncate)
>>> +		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
>>>    }
>>>    static int __f2fs_commit_atomic_write(struct inode *inode)
>>> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
>>> index 3121d127d5aa..955d440be104 100644
>>> --- a/include/uapi/linux/f2fs.h
>>> +++ b/include/uapi/linux/f2fs.h
>>> @@ -42,6 +42,7 @@
>>>    						struct f2fs_comp_option)
>>>    #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
>>>    #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
>>> +#define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
>>>    /*
>>>     * should be same as XFS_IOC_GOINGDOWN.
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
