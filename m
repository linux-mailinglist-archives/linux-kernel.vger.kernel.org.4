Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF579620593
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiKHBGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiKHBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:06:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215122613A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:06:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60EC2CE1853
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F47BC433C1;
        Tue,  8 Nov 2022 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667869589;
        bh=fMLhUX07pSNSkDg8dzTeiM4tsFWqD3ltLaK0XNYd6PM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XizbBn9GVFMc1LSh2/SH4G3uzK9q9Wul+darKM9jn0tb/GxkIZA02wLPiYKIOx5CG
         RYuf2KEG2/L/8EKnNUWg+PJA6IrlDjMXPKv1dYXLvHRrOamv/f15KbhW4smdkSIz4e
         9wxCwzXdoh29fzlB6AnQ85FbZaqNYn82C9gJCIpY94yd+26u8eyMgwE5wa7ejhVM2n
         /HyhlzKcSz9mkzVqJ0IzBS7J57Wc30F2p33ZlR5QkX4yH0tavRrO5wRN1Q3MVo197d
         KUmgyf8Lt3+ck4rATWGTtJgvnwM5m2AqDyYyNiyIk7dMvLhF7JXvs/pb6J6NyuCwmN
         71fE1aAoKOYlw==
Message-ID: <b42f9a77-942b-9e55-2637-93821255b370@kernel.org>
Date:   Tue, 8 Nov 2022 09:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: speed up f2fs_empty_dir()
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     jaegeuk@kernel.org, Wei Chen <harperchen1110@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221106094855.131967-1-chao@kernel.org>
 <Y2lOmCIt5gZmFJ5H@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y2lOmCIt5gZmFJ5H@sol.localdomain>
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

On 2022/11/8 2:29, Eric Biggers wrote:
> On Sun, Nov 06, 2022 at 05:48:55PM +0800, Chao Yu wrote:
>> Wei Chen reports a kernel bug as blew:
>>
>> INFO: task syz-executor.0:29056 blocked for more than 143 seconds.
>>        Not tainted 5.15.0-rc5 #1
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz-executor.0  state:D stack:14632 pid:29056 ppid:  6574 flags:0x00000004
>> Call Trace:
>>   __schedule+0x4a1/0x1720
>>   schedule+0x36/0xe0
>>   rwsem_down_write_slowpath+0x322/0x7a0
>>   fscrypt_ioctl_set_policy+0x11f/0x2a0
>>   __f2fs_ioctl+0x1a9f/0x5780
>>   f2fs_ioctl+0x89/0x3a0
>>   __x64_sys_ioctl+0xe8/0x140
>>   do_syscall_64+0x34/0xb0
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Eric did some investigation on this issue, quoted from reply of Eric:
>>
>> "Well, the quality of this bug report has a lot to be desired (not on
>> upstream kernel, reproducer is full of totally irrelevant stuff, not
>> sent to the mailing list of the filesystem whose disk image is being
>> fuzzed, etc.).  But what is going on is that f2fs_empty_dir() doesn't
>> consider the case of a directory with an extremely large i_size on a
>> malicious disk image.
>>
>> Specifically, the reproducer mounts an f2fs image with a directory
>> that has an i_size of 14814520042850357248, then calls
>> FS_IOC_SET_ENCRYPTION_POLICY on it.
>>
>> That results in a call to f2fs_empty_dir() to check whether the
>> directory is empty.  f2fs_empty_dir() then iterates through all
>> 3616826182336513 blocks the directory allegedly contains to check
>> whether any contain anything.  i_rwsem is held during this, so
>> anything else that tries to take it will hang."
>>
>> In order to solve this issue, let's use f2fs_get_next_page_offset()
>> to speed up iteration by skipping holes for all below functions:
>> - f2fs_empty_dir
>> - f2fs_readdir
>> - find_in_level
>>
>> The way why we can speed up iteration was described in
>> 'commit 3cf4574705b4 ("f2fs: introduce get_next_page_offset to speed
>> up SEEK_DATA")'.
>>
>> Meanwhile, in f2fs_empty_dir(), let's use f2fs_find_data_page()
>> instead f2fs_get_lock_data_page(), due to i_rwsem was held in
>> caller of f2fs_empty_dir(), there shouldn't be any races, so it's
>> fine to not lock dentry page during lookuping dirents in the page.
>>
>> Link: https://lore.kernel.org/lkml/536944df-a0ae-1dd8-148f-510b476e1347@kernel.org/T/
>> Reported-by: Wei Chen <harperchen1110@gmail.com>
>> Cc: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 17 ++++++++++++-----
>>   fs/f2fs/dir.c  | 34 ++++++++++++++++++++++++----------
>>   fs/f2fs/f2fs.h |  5 +++--
>>   fs/f2fs/gc.c   |  4 ++--
>>   4 files changed, 41 insertions(+), 19 deletions(-)
> 
> Thanks.  I'm not an expert on all the details, but this patch looks good to me.
> 
> Given that it optimizes lookups and readdirs too, a better title for the patch
> might be something like "f2fs: optimize iteration over sparse directories".

Yes, thanks for your suggestion, will update in v2.

Thanks,

> 
> - Eric
