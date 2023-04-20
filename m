Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A26E8734
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjDTBKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjDTBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1219F4C20
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C5B963C20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE53C433D2;
        Thu, 20 Apr 2023 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681953039;
        bh=XfrLsPfs0KQwHZJqNqn6efmesm8mlbE6vACTnNWtOgM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=elY/kyd13xjzyhWaWquwxahkNqhy48aCcbaM6sIOKm3kFOZU5GFcx6r56ZJoQ/Nvk
         nxTQHusgFdx29JSaN22An5is6wDMUGewztWDPdiLyG4cObmDdmm2u/CZdopS7pSyVi
         xQwOf6/Ptkq6hxX5UGqJbsRA1eF9ODlLsHkGJI/Xv0842AoteHo5OD2hlcq/n6pA0X
         htPS4U+TGFCHkPRznbPGj0HflhCLNFyGgOJXkFu2VbWsRMRjZ3fm5iNNQzA/B+hl5l
         7AVlznonVtqYCwnC+9bS6ZMJQXsl7AvQYy7EDaoVd7VgyrxRVo0Sy8ceZ5ZON0FJSR
         71ISHukzxPWtA==
Message-ID: <0d53c53a-ebbd-292d-8c61-154cc98c5498@kernel.org>
Date:   Thu, 20 Apr 2023 09:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: allocate trace path buffer from
 names_cache
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     wubo.oduw@gmail.com, linux-kernel@vger.kernel.org,
        Wu Bo <bo.wu@vivo.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20230414104308.6591-1-bo.wu@vivo.com>
 <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
 <ZD7AJT7ZYPji8TWk@google.com>
 <91a05857-c916-cae5-d61d-bbec6f1ae052@kernel.org>
 <ZEAwcaVlYq+PNwEK@google.com> <ZEBE2iT/fKhnhrhg@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZEBE2iT/fKhnhrhg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/20 3:45, Jaegeuk Kim wrote:
> On 04/19, Jaegeuk Kim wrote:
>> On 04/19, Chao Yu wrote:
>>> On 2023/4/19 0:07, Jaegeuk Kim wrote:
>>>> On 04/18, Chao Yu wrote:
>>>>> On 2023/4/14 18:43, Wu Bo wrote:
>>>>>> It would be better to use the dedicated slab to store path.
>>>>>>
>>>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>>>> ---
>>>>>>     fs/f2fs/file.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>> index 15dabeac4690..27137873958f 100644
>>>>>> --- a/fs/f2fs/file.c
>>>>>> +++ b/fs/f2fs/file.c
>>>>>> @@ -4361,7 +4361,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>>>>>>     	struct inode *inode = file_inode(iocb->ki_filp);
>>>>>>     	char *buf, *path;
>>>>>> -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
>>>>>> +	buf = __getname();
>>>>>
>>>>> How about:
>>>>>
>>>>> buf = f2fs_kmem_cache_alloc(names_cachep, GFP_KERNEL, NULL, F2FS_I_SB(inode));
>>>>
>>>> This looks like a hack using names_cachep?
>>>
>>> names_cachep was exported in fs.h.
>>
>> I think that's for __getname() in general, which doesn't indicate you can hack.
>> No one is using like that.
>>
>> $ grep names_cachep fs/* -R
>> fs/dcache.c:struct kmem_cache *names_cachep __read_mostly;
>> fs/dcache.c:EXPORT_SYMBOL(names_cachep);
>> fs/dcache.c:	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
>>
>> $ grep __getname fs/* -R
>> fs/ceph/mds_client.c:	path = __getname();
>> fs/cifs/cifsproto.h:	return __getname();
>> fs/dcache.c:/* SLAB cache for __getname() consumers */
>> fs/d_path.c:	char *page = __getname();
>> fs/exfat/dir.c:	nb->lfn = __getname();
>> fs/f2fs/file.c:	buf = __getname();
>> fs/fat/dir.c:		*unicode = __getname();
>> fs/fat/namei_vfat.c:	uname = __getname();
>> fs/hostfs/hostfs_kern.c:	char *name = __getname();
>> fs/namei.c:	result = __getname();
>> fs/namei.c:	result = __getname();
>> fs/ntfs3/dir.c:	name = __getname();
>> fs/ntfs3/xattr.c:	buf = __getname();
>> fs/ntfs3/inode.c:	new_de = __getname();
>> fs/ntfs3/inode.c:	de = __getname();
>> fs/ntfs3/inode.c:	de = __getname();
>> fs/ntfs3/namei.c:	struct cpu_str *uni = __getname();
>> fs/ntfs3/namei.c:	de = __getname();
>> fs/ntfs3/namei.c:	struct cpu_str *uni = __getname();
>> fs/ntfs3/namei.c:	uni = __getname();
>> fs/ntfs3/namei.c:	uni1 = __getname();
>> fs/vboxsf/utils.c: * Returns a shfl_string allocated through __getname (must be freed using
>> fs/vboxsf/utils.c:	buf = __getname();
>> fs/vboxsf/utils.c:		shfl_path = __getname();
>>
>>>
>>>> Using f2fs_kmem_cache_alloc is able to inject malloc error.
>>>> But here is a trace event, is it ok to inject error in a trace path?
>>>
>>> Yes, the fail path handling is very simple, so it's fine to leave it
>>> as it is.
>>>
>>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> What is this for?

Oh, I mean I'm okay w/ original patch, because f2fs_trace_rw_file_path()
doesn't have complicated error handling.

>>
> 
> If we want to keep the error injection, how about this?

Both original patch or below patch w/ fault injection is fine to me.

Free feel to add rvb tag of me. :)

Thanks,

> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/f2fs.h | 13 +++++++++++++
>   fs/f2fs/file.c |  4 ++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6cae94d51821..d87044516fe9 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3347,6 +3347,19 @@ static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
>   	return kmalloc(size, flags);
>   }
>   
> +static inline void *f2fs_getname(struct f2fs_sb_info *sbi)
> +{
> +	if (time_to_inject(sbi, FAULT_KMALLOC))
> +		return NULL;
> +
> +	return __getname();
> +}
> +
> +static inline void f2fs_putname(char *buf)
> +{
> +	__putname(buf);
> +}
> +
>   static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
>   					size_t size, gfp_t flags)
>   {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1b4411271f54..5ac53d2627d2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4372,7 +4372,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   	char *buf, *path;
>   
> -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
> +	buf = f2fs_getname(F2FS_I_SB(inode));
>   	if (!buf)
>   		return;
>   	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
> @@ -4385,7 +4385,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>   		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
>   				current->pid, path, current->comm);
>   free_buf:
> -	kfree(buf);
> +	f2fs_putname(buf);
>   }
>   
>   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
