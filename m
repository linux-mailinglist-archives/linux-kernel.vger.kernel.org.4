Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4163937C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKZCuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKZCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:50:23 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6D2FFEB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:50:22 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVhKlCy_1669431019;
Received: from 30.15.198.69(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVhKlCy_1669431019)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 10:50:20 +0800
Message-ID: <37198439-8d2d-dfb9-38b4-a68091c640cc@linux.alibaba.com>
Date:   Sat, 26 Nov 2022 10:50:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] erofs: enable large folio support for non-compressed
 format
Content-Language: en-US
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20221126005756.7662-1-jefflexu@linux.alibaba.com>
 <20221126005756.7662-3-jefflexu@linux.alibaba.com> <Y4F3EGk+0najgTco@debian>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <Y4F3EGk+0najgTco@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/22 10:16 AM, Gao Xiang wrote:
> Hi Jingbo,
> 
> On Sat, Nov 26, 2022 at 08:57:56AM +0800, Jingbo Xu wrote:
>> Enable large folio in both device and fscache mode.  Then the readahead
> 
>          ^ large folios in both iomap and fscache modes.
> 
> I tend to enable iomap/fscache large folios with two patches.
> Also please see dev-test branch.

Got it.


> 
> 
>> routine will pass down large folio containing multiple pages.
>>
>> Enable this feature for non-compressed format for now, until the
>> compression part supports large folio later.
> 
>                             ^ large folios
> 
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c | 1 +
>>  fs/erofs/inode.c   | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 0643b205c7eb..d2dd58ce312b 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -436,6 +436,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>>  		inode->i_size = OFFSET_MAX;
>>  		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>>  		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>> +		mapping_set_large_folios(inode->i_mapping);
>>  
> 
> Meta inodes currently doesn't need large folios for now, and
> we don't have readahead policy for these.

Alright, I will fix this in a quick v2.

> 
>>  		ctx->inode = inode;
>>  	}
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index ad2a82f2eb4c..85932086d23f 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -295,6 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
>>  		goto out_unlock;
>>  	}
>>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
>> +	mapping_set_large_folios(inode->i_mapping);
>>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>>  	if (erofs_is_fscache_mode(inode->i_sb))
>>  		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
>> -- 
>> 2.19.1.6.gb485710b
>>

-- 
Thanks,
Jingbo
