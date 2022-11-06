Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69661E275
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKFNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKFNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:55:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB962E0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:55:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC15A60C55
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA99C433C1;
        Sun,  6 Nov 2022 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667742901;
        bh=e3Hjt0HFvq7svWTT6yYuVpQxSjxCKFMNN+dx63micnQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=qeITGlTuvEFxzY/KVK0EY03Zk0kEjYk5Mb6jk0ZGEuQ0CtDZHXzweMESsFvIizhbV
         rRa61wVrN9OIiIIWxiqmdA0oLfo8BtHIIWvQJaqGW8xiFc2ksL2cQF1Y5/Wbx9nVRV
         +htmGoCzAlYPLiFTwSAw3zIYbiiLtDL2+odjx414WLEoP5sAoPm4kK+NHcd3Fkw22a
         i4aOEdIIVHk/1u0F14OSbvrAZSTzeNcV2g8wP4xyEMQPIfZLFASuuaqIqymmT6TVw+
         /7oKcNDFS87tpOfvI+dGCulEA3tyA2f6cLWo8IMSI+0ooo0gEllz3T4GZr1l/J03pn
         ZQqnyvNXMf0fw==
Message-ID: <3d2b1141-995a-4bfb-4bf0-5227be25105a@kernel.org>
Date:   Sun, 6 Nov 2022 21:54:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     qixiaoyu <qxy65535@gmail.com>
Cc:     qixiaoyu1 <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
 <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
 <20221102122518.GB22857@mi-HP-ProDesk-680-G4-MT>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
In-Reply-To: <20221102122518.GB22857@mi-HP-ProDesk-680-G4-MT>
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

On 2022/11/2 20:25, qixiaoyu wrote:
> Hi Chao,
> 
> fdatasync do in-place-update to avoid additional node writes, but currently
> it only do that with F2FS_IPU_FSYNC as:
> 
> f2fs_do_sync_file:
> 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>   		set_inode_flag(inode, FI_NEED_IPU);
> 
> check_inplace_update_policy:
> 	/* this is only set during fdatasync */
> 	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> 			is_inode_flag_set(inode, FI_NEED_IPU))
> 		return true;
> 
> So this patch separate in-place-update of fdatasync from F2FS_IPU_FSYNC to
> apply it to all IPU policy.
> 
> BTW, we found small performance improvement with this patch on AndroBench app
> using F2FS_IPU_SSR_UTIL on our product:

How this patch affects performance when F2FS_IPU_SSR_UTIL is on?

Thanks,

> 
>                  F2FS_IPU_FSYNC  F2FS_IPU_SSR_UTIL   F2FS_IPU_SSR_UTIL(with patch)
> SQLite Insert(QPS)  6818.08     6327.09(-7.20%)     6757.72
> SQLite Update(QPS)  6528.81     6336.57(-2.94%)     6490.77
> SQLite Delete(QPS)  9724.68     9378.37(-3.56%)     9622.27
> 
> Thanks
> 
> On Tue, Nov 01, 2022 at 11:14:55PM +0800, Chao Yu wrote:
>> On 2022/10/21 10:31, qixiaoyu1 wrote:
>>> Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
>>> Fix to apply it to all IPU policy.
>>
>> Xiaoyu,
>>
>> Sorry for the delay.
>>
>> I didn't get the point, can you please explain more about the
>> issue?
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
>>> ---
>>>   fs/f2fs/data.c | 8 +++-----
>>>   fs/f2fs/file.c | 4 +++-
>>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index a71e818cd67b..fec8e15fe820 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>>>   	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
>>>   			is_inode_flag_set(inode, FI_OPU_WRITE))
>>>   		return false;
>>> +	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
>>> +	if (is_inode_flag_set(inode, FI_NEED_IPU))
>>> +		return true;
>>>   	if (policy & (0x1 << F2FS_IPU_FORCE))
>>>   		return true;
>>>   	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
>>> @@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>>>   			!IS_ENCRYPTED(inode))
>>>   		return true;
>>> -	/* this is only set during fdatasync */
>>> -	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
>>> -			is_inode_flag_set(inode, FI_NEED_IPU))
>>> -		return true;
>>> -
>>>   	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>>>   			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
>>>   		return true;
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 82cda1258227..08091550cdf2 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>   		goto go_write;
>>>   	/* if fdatasync is triggered, let's do in-place-update */
>>> -	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>>> +	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
>>> +			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
>>>   		set_inode_flag(inode, FI_NEED_IPU);
>>> +
>>>   	ret = file_write_and_wait_range(file, start, end);
>>>   	clear_inode_flag(inode, FI_NEED_IPU);
