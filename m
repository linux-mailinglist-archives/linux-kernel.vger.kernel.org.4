Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272E6DD5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDKIgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjDKIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1121F12D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A14AA61997
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324CFC433EF;
        Tue, 11 Apr 2023 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681202175;
        bh=QK5lRHbzUyNcL/CLee7/EdTKhaXBSZZ5/FnxzE21Az0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=nRcZZDOwjeYEkfJfwVrA0nHOxUuouvEMQfZLL+FTB3DIeS4jfxJHDaF3uNl0cGsLj
         oX3IToNZLIkJAu7Z2NPpMf5K4cm47cWrVupf0+N3Gwfad9EhkHRchVbFnJ/S0XEsl/
         i8w/Gm3dnB4RE48oj+TAzDdxngWsQS2Q3utX2wzq+ET+VN4uIapGecVnXDJYgDTre+
         UBtMrGKn/x9m+0tDGJyDw2uIbKYa292nlG0ksu8DPkkxUvpIfvm19aJQ8fMNjGdRZG
         NpcTYYQ01EeMLn/dJDmfL/FVbwKWGtWf6qXf5QtY10/bRKYNuNgqku0jFm7gfqPTa6
         kjvQHeL9M9RCA==
Message-ID: <2341db3b-5a40-a9f0-51f1-29a8908e3e98@kernel.org>
Date:   Tue, 11 Apr 2023 16:36:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to tag FIEMAP_EXTENT_DELALLOC in
 fiemap() for delay allocated extent
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230405144359.930253-1-chao@kernel.org>
 <ZDCEK2OPkhTmRZrq@google.com>
 <224e8756-7c63-fd53-a0f3-f3e2a7b4c13f@kernel.org>
 <ZDROBJFxSUdGaqAa@google.com>
 <538fd229-28ae-0ec5-ef07-35d505fbb8a9@kernel.org>
In-Reply-To: <538fd229-28ae-0ec5-ef07-35d505fbb8a9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/11 16:14, Chao Yu wrote:
> On 2023/4/11 1:57, Jaegeuk Kim wrote:
>> On 04/08, Chao Yu wrote:
>>> On 2023/4/8 4:59, Jaegeuk Kim wrote:
>>>> This breaks generic/009?
>>>
>>> I guess it is as expected?
>>>
>>> Please check description of fiemap ioctl manual from [1]:
>>>
>>> FIEMAP_EXTENT_UNKNOWN
>>> The location of this extent is currently unknown. This may
>>> indicate the data is stored on an inaccessible volume or that
>>> no storage has been allocated for the file yet.
>>>
>>> FIEMAP_EXTENT_DELALLOC
>>> This will also set FIEMAP_EXTENT_UNKNOWN.
>>>
>>> Delayed allocation - while there is data for this extent, its
>>> physical location has not been allocated yet.
>>>
>>> FIEMAP_EXTENT_UNWRITTEN
>>> Unwritten extent - the extent is allocated but its data has not
>>> been initialized. This indicates the extent’s data will be all
>>> zero if read through the filesystem but the contents are undefined
>>> if read directly from the device.
>>>
>>> [1] https://www.kernel.org/doc/html/latest/filesystems/fiemap.html
>>>
>>> According to its description, f2fs only support
>>> FIEMAP_EXTENT_{UNKNOWN, DELALLOC}, but not support
>>> FIEMAP_EXTENT_UNWRITTEN.
>>
>> No, I don't think so.
> 
> Jaegeuk,
> 
> Could you please check the detailed description of FIEMAP_EXTENT_UNWRITTEN?
> The flag indicates two conditions:
> 1. on-disk blkaddrs were allocated for extent, and the extent is tagged as
> unwritten status.
> 2. data readed on those blocks will be all zero.

Sorry, I mean:

1. on-disk blkaddrs were allocated for extent;
2. extent is tagged as unwritten status, data readed on those blocks will be
all zero.

Thanks,

> 
> So, let's check f2fs' status:
> - fallocate only reserve valid block count and set NEW_ADDR in dnode, so
> it does not match condition 1)
> - pin & fallocate preallocates blkaddrs and set blkaddrs in dnode, but
> content on those blkaddrs may contain zero or random data, so it does not
> match  condition 2)
> 
> Christoph describes this issue in below patch as well, you can check it.
> da8c7fecc9c7 ("f2fs: rename F2FS_MAP_UNWRITTEN to F2FS_MAP_DELALLOC")
> 
> Am I missing something?
> 
> Thanks,
> 
>>
>>>
>>> So 009, 092, 094 .. which expects unwritten status from extent will
>>> fail.
>>>
>>> How about disabling those testcase?
>>>
>>> Thanks,
>>>
>>>>
>>>> On 04/05, Chao Yu wrote:
>>>>> xfstest generic/614 fails to run due below reason:
>>>>>
>>>>> generic/614 1s ... [not run] test requires delayed allocation buffered writes
>>>>>
>>>>> The root cause is f2fs tags wrong fiemap flag for delay allocated
>>>>> extent.
>>>>>
>>>>> Quoted from fiemap.h:
>>>>> FIEMAP_EXTENT_UNKNOWN        0x00000002 /* Data location unknown. */
>>>>> FIEMAP_EXTENT_DELALLOC        0x00000004 /* Location still pending.
>>>>>                             * Sets EXTENT_UNKNOWN. */
>>>>> FIEMAP_EXTENT_UNWRITTEN        0x00000800 /* Space allocated, but
>>>>>                             * no data (i.e. zero). */
>>>>>
>>>>> FIEMAP_EXTENT_UNWRITTEN means block address is preallocated, but w/o
>>>>> been written any data, which status f2fs is not supported now, for all
>>>>> NEW_ADDR block addresses, it means delay allocated blocks, so let's
>>>>> tag FIEMAP_EXTENT_DELALLOC instead.
>>>>>
>>>>> Testcase:
>>>>> xfs_io -f -c 'pwrite 0 64k' /mnt/f2fs/file;
>>>>> filefrag -v /mnt/f2fs/file
>>>>>
>>>>> Output:
>>>>> - Before
>>>>> Filesystem type is: f2f52010
>>>>> Fize of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
>>>>>    ext:     logical_offset:        physical_offset: length:   expected: flags:
>>>>>      0:        0..      15:          0..        15:     16:             last,unwritten,merged,eof
>>>>> /mnt/f2fs/file: 1 extent found
>>>>>
>>>>> After:
>>>>> Filesystem type is: f2f52010
>>>>> File size of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
>>>>>    ext:     logical_offset:        physical_offset: length:   expected: flags:
>>>>>      0:        0..      15:          0..         0:      0:             last,unknown_loc,delalloc,eof
>>>>> /mnt/f2fs/file: 1 extent found
>>>>>
>>>>> Fixes: 7f63eb77af7b ("f2fs: report unwritten area in f2fs_fiemap")
>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>> ---
>>>>>    fs/f2fs/data.c | 7 +++++--
>>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 359de650772e..3afc9764743e 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -1995,7 +1995,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>>>        }
>>>>>        if (size) {
>>>>> -        flags |= FIEMAP_EXTENT_MERGED;
>>>>> +        if (flags & FIEMAP_EXTENT_DELALLOC)
>>>>> +            phys = 0;
>>>>> +        else
>>>>> +            flags |= FIEMAP_EXTENT_MERGED;
>>>>>            if (IS_ENCRYPTED(inode))
>>>>>                flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
>>>>> @@ -2035,7 +2038,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>>>                    size += blks_to_bytes(inode, 1);
>>>>>                }
>>>>>            } else if (map.m_flags & F2FS_MAP_DELALLOC) {
>>>>> -            flags = FIEMAP_EXTENT_UNWRITTEN;
>>>>> +            flags = FIEMAP_EXTENT_DELALLOC;
>>>>>            }
>>>>>            start_blk += bytes_to_blks(inode, size);
>>>>> -- 
>>>>> 2.36.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
