Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180FF6DB865
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDHC5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 22:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDHC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 22:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137AD339
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 19:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1B76361B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 02:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAEEC433EF;
        Sat,  8 Apr 2023 02:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680922636;
        bh=Bc+uF/5u234A5wF5Cii6t3vLz3f10HXrREOqC0Ikqog=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=J1za49D7XJW49fUFjtJeh8GC8YVw3hjxuh64UbNqsbA3+rm9M0NHjUy+ewOLgnQ9h
         Iu/6vdR5idnqhzQiR7JMXho5l6UISHhcrMaO7YrdaN4cDhebO0dUf/uJpJr7+wEtVa
         iyDtnDTit5VHbXZTLs8kpWIvRLQYtR4S4IMyojrEGf47IqLqg0kjWuSMmumtuhJO0Z
         8tuF1IeIJhsAe79WC/w2nz+xhQ/gFacFn+h8UIB+4TqLQEqrS4pdhCg8ZFqwB1Fitd
         TyYxOEBg4Rf/P7gBStzdjRSZPJfW3SOyDDT3DU7aY/DzJXopYBR0IkfzTD8Pmx586I
         SHVfNmwYrKpyQ==
Message-ID: <224e8756-7c63-fd53-a0f3-f3e2a7b4c13f@kernel.org>
Date:   Sat, 8 Apr 2023 10:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230405144359.930253-1-chao@kernel.org>
 <ZDCEK2OPkhTmRZrq@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to tag FIEMAP_EXTENT_DELALLOC in fiemap() for
 delay allocated extent
In-Reply-To: <ZDCEK2OPkhTmRZrq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/8 4:59, Jaegeuk Kim wrote:
> This breaks generic/009?

I guess it is as expected?

Please check description of fiemap ioctl manual from [1]:

FIEMAP_EXTENT_UNKNOWN
The location of this extent is currently unknown. This may
indicate the data is stored on an inaccessible volume or that
no storage has been allocated for the file yet.

FIEMAP_EXTENT_DELALLOC
This will also set FIEMAP_EXTENT_UNKNOWN.

Delayed allocation - while there is data for this extent, its
physical location has not been allocated yet.

FIEMAP_EXTENT_UNWRITTEN
Unwritten extent - the extent is allocated but its data has not
been initialized. This indicates the extent’s data will be all
zero if read through the filesystem but the contents are undefined
if read directly from the device.

[1] https://www.kernel.org/doc/html/latest/filesystems/fiemap.html

According to its description, f2fs only support
FIEMAP_EXTENT_{UNKNOWN, DELALLOC}, but not support
FIEMAP_EXTENT_UNWRITTEN.

So 009, 092, 094 .. which expects unwritten status from extent will
fail.

How about disabling those testcase?

Thanks,

> 
> On 04/05, Chao Yu wrote:
>> xfstest generic/614 fails to run due below reason:
>>
>> generic/614 1s ... [not run] test requires delayed allocation buffered writes
>>
>> The root cause is f2fs tags wrong fiemap flag for delay allocated
>> extent.
>>
>> Quoted from fiemap.h:
>> FIEMAP_EXTENT_UNKNOWN		0x00000002 /* Data location unknown. */
>> FIEMAP_EXTENT_DELALLOC		0x00000004 /* Location still pending.
>> 						    * Sets EXTENT_UNKNOWN. */
>> FIEMAP_EXTENT_UNWRITTEN		0x00000800 /* Space allocated, but
>> 						    * no data (i.e. zero). */
>>
>> FIEMAP_EXTENT_UNWRITTEN means block address is preallocated, but w/o
>> been written any data, which status f2fs is not supported now, for all
>> NEW_ADDR block addresses, it means delay allocated blocks, so let's
>> tag FIEMAP_EXTENT_DELALLOC instead.
>>
>> Testcase:
>> xfs_io -f -c 'pwrite 0 64k' /mnt/f2fs/file;
>> filefrag -v /mnt/f2fs/file
>>
>> Output:
>> - Before
>> Filesystem type is: f2f52010
>> Fize of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
>>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>>     0:        0..      15:          0..        15:     16:             last,unwritten,merged,eof
>> /mnt/f2fs/file: 1 extent found
>>
>> After:
>> Filesystem type is: f2f52010
>> File size of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
>>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>>     0:        0..      15:          0..         0:      0:             last,unknown_loc,delalloc,eof
>> /mnt/f2fs/file: 1 extent found
>>
>> Fixes: 7f63eb77af7b ("f2fs: report unwritten area in f2fs_fiemap")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 359de650772e..3afc9764743e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1995,7 +1995,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>   	}
>>   
>>   	if (size) {
>> -		flags |= FIEMAP_EXTENT_MERGED;
>> +		if (flags & FIEMAP_EXTENT_DELALLOC)
>> +			phys = 0;
>> +		else
>> +			flags |= FIEMAP_EXTENT_MERGED;
>>   		if (IS_ENCRYPTED(inode))
>>   			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
>>   
>> @@ -2035,7 +2038,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>   				size += blks_to_bytes(inode, 1);
>>   			}
>>   		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
>> -			flags = FIEMAP_EXTENT_UNWRITTEN;
>> +			flags = FIEMAP_EXTENT_DELALLOC;
>>   		}
>>   
>>   		start_blk += bytes_to_blks(inode, size);
>> -- 
>> 2.36.1
