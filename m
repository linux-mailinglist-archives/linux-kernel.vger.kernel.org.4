Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28B734AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFSEFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSEE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CBFF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCBC760B62
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E524DC433C8;
        Mon, 19 Jun 2023 04:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687147496;
        bh=W8waJk4XTaE76FP7LndZakOM9LvxqgfZtqHIAdHYMGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QigEo1GRv2wym/UeqLTVusquiKXKw82/893v9gmr0EaRMB6/V8+WWrvGZMzjcb5rO
         /THHwNsdaEGYw3HC1YBFpXGf+NpuMt5PtZ1FILgcjD0fDgrOUhJVC8Qr53gP5ZyM2s
         8unE9jtqzwP2GkA4kQKsMFK9xuZTak2XzXMJHD2jJd3jtgSylIEQ2pHrR/hfGkCpdM
         xF0EFpsWKIjw5R1g54W2X3oy+zqvYmnP8iVO8/nDtA5OhxCFIffRNRitgcAGiWgBIQ
         9Uew+S5GlrbsI/tMLbnV1ljZdZLagzIHAZ0HqGuZ98I9lOwM6d03LQlIUf4K1+pxzO
         6jGJ6aCq5tclw==
Message-ID: <65ce42d6-889a-5e1d-8f04-af8f66fd0afa@kernel.org>
Date:   Mon, 19 Jun 2023 12:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] f2fs: compress: don't force buffered io when in
 COMPR_MODE_USER mode
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230609131555.56651-1-frank.li@vivo.com>
 <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
 <dde6972a-e98c-8a6e-493b-9aff5668101d@vivo.com>
 <7ab6b6f9-37fa-9bf2-69ce-7b1b1944d9f3@kernel.org>
 <fe223231-5445-61ef-1ba8-0d46f4f4ed5f@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <fe223231-5445-61ef-1ba8-0d46f4f4ed5f@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/19 11:11, Yangtao Li wrote:
> On 2023/6/19 8:54, Chao Yu wrote:
> 
>> On 2023/6/13 12:14, Yangtao Li wrote:
>>>
>>> On 2023/6/12 22:38, Chao Yu wrote:
>>>> On 2023/6/9 21:15, Yangtao Li wrote:
>>>>> It is observed that when in user compression mode
>>>>> (compress_extension=*),
>>>>> even though the file is not compressed, the file is still forced to use
>>>>> buffer io, which makes the AndroBench sequential read and write drop
>>>>> significantly. In fact, when the file is not compressed, we don't need
>>>>> to force it to buffer io.
>>>>>
>>>>>                    | w/o patch | w/ patch |
>>>>> seq read  (MB/s) | 1320.068  | 3696.154 |
>>>>> seq write (MB/s) | 617.996   | 2978.478 |
>>>>>
>>>>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>>>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>>> ---
>>>>>    fs/f2fs/f2fs.h | 14 ++++++++++++++
>>>>>    fs/f2fs/file.c |  2 +-
>>>>>    2 files changed, 15 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 1efcfd9e5a99..7f5472525310 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct
>>>>> inode *inode)
>>>>>            is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>>>>>    }
>>>>>    +static inline bool f2fs_is_compressed_file(struct inode *inode)
>>>>> +{
>>>>> +    int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>>>>> +
>>>>> +    if (compress_mode == COMPR_MODE_FS)
>>>>> +        return f2fs_compressed_file(inode);
>>>>> +    else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||
>>>>
>>>> Should check dirty page as well? i_compr_blocks may increase after
>>>> data writeback.
>>>>
>>> IIUC, in COMPR_MODE_USER mode, i_compr_blocks will only be updated when
>>> FI_ENABLE_COMPRESS is enabled.
>>>
>>> If FI_ENABLE_COMPRESS is not enabled, i_compr_blocks will never be
>>> updated after data writeback.
>>>
>>> So there is no need to additionally judge whether there is a dirty page?
>>
>> Oh, user mode, that's correct.
>>
>> If we allow dio/aio on compress file, it needs to consider race case in
>> between aio and ioc_compress_file.
> 
> 
> The inode_lock is already held in f2fs_file_write_iter and f2fs_ioc_compress_file, I guess this is enough?
> 
> What else?

aio may complete outside inode lock, so it needs to call inode_dio_wait()
in f2fs_ioc_compress_file() to avoid the race case?

Thanks,

> 
> 
> 4691 static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 4692 {
> 4693         struct inode *inode = file_inode(iocb->ki_filp);
> 4694         const loff_t orig_pos = iocb->ki_pos;
> 4695         const size_t orig_count = iov_iter_count(from);
> 4696         loff_t target_size;
> 4697         bool dio;
> 4698         bool may_need_sync = true;
> 4699         int preallocated;
> 4700         ssize_t ret;
> 4701
> 4702         if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
> 4703                 ret = -EIO;
> 4704                 goto out;
> 4705         }
> 4706
> 4707         if (!f2fs_is_compress_backend_ready(inode)) {
> 4708                 ret = -EOPNOTSUPP;
> 4709                 goto out;
> 4710         }
> 4711
> 4712         if (iocb->ki_flags & IOCB_NOWAIT) {
> 4713                 if (!inode_trylock(inode)) {
> 4714                         ret = -EAGAIN;
> 4715                         goto out;
> 4716                 }
> 4717         } else {
> 4718                 inode_lock(inode);
> 4719         }
> 
> 
> 4115 static int f2fs_ioc_compress_file(struct file *filp)
> 4116 {
> 4117         struct inode *inode = file_inode(filp);
> 4118         struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> 4119         pgoff_t page_idx = 0, last_idx;
> 4120         unsigned int blk_per_seg = sbi->blocks_per_seg;
> 4121         int cluster_size = F2FS_I(inode)->i_cluster_size;
> 4122         int count, ret;
> 4123
> 4124         if (!f2fs_sb_has_compression(sbi) ||
> 4125                         F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
> 4126                 return -EOPNOTSUPP;
> 4127
> 4128         if (!(filp->f_mode & FMODE_WRITE))
> 4129                 return -EBADF;
> 4130
> 4131         if (!f2fs_compressed_file(inode))
> 4132                 return -EINVAL;
> 4133
> 4134         f2fs_balance_fs(sbi, true);
> 4135
> 4136         file_start_write(filp);
> 4137         inode_lock(inode);
> 
> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>>
>>> Thanks,
>>>
>>>> Thanks,
>>>>
>>>>> +        is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
>>>>> +        is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
>>>>> +        return true;
>>>>> +
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>>    static inline bool f2fs_need_compress_data(struct inode *inode)
>>>>>    {
>>>>>        int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index 74ecc9e20619..0698129b2165 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode
>>>>> *inode, int rw)
>>>>>            return true;
>>>>>        if (fsverity_active(inode))
>>>>>            return true;
>>>>> -    if (f2fs_compressed_file(inode))
>>>>> +    if (f2fs_is_compressed_file(inode))
>>>>>            return true;
>>>>>          /* disallow direct IO if any of devices has unaligned blksize */
