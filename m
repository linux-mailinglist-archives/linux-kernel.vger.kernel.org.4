Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CF668F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjAMHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjAMHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:46:23 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4948A61300
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:46:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VZTolwy_1673595977;
Received: from 30.97.48.201(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZTolwy_1673595977)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 15:46:18 +0800
Message-ID: <feaaaa52-1464-644f-2942-aaf53b6c783a@linux.alibaba.com>
Date:   Fri, 13 Jan 2023 15:46:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs: clean up erofs_iget()
To:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
 <144922ad-66a3-27e8-df85-4a58c175a630@linux.alibaba.com>
From:   Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <144922ad-66a3-27e8-df85-4a58c175a630@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/13 15:41, Jingbo Xu wrote:
> 
> 
> On 1/13/23 2:52 PM, Gao Xiang wrote:
>> Move inode hash function into inode.c and simplify erofs_iget().
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/inode.c    | 40 +++++++++++++++++++++-------------------
>>   fs/erofs/internal.h |  9 ---------
>>   2 files changed, 21 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index d3b8736fa124..57328691582e 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -308,47 +308,49 @@ static int erofs_fill_inode(struct inode *inode)
>>   }
>>   
>>   /*
>> - * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
>> - * we should do more for 32-bit platform to find the right inode.
>> + * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
>> + * so that it will fit.
>>    */
>> -static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
>> +static ino_t erofs_squash_ino(erofs_nid_t nid)
>>   {
>> -	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
>> +	ino_t ino = (ino_t)nid;
>> +
>> +	if (sizeof(ino_t) < sizeof(erofs_nid_t))
>> +		ino ^= nid >> (sizeof(erofs_nid_t) - sizeof(ino_t)) * 8;
> 
> Shouldn't we do:
> 
> 	ino ^= nid >> sizeof(ino_t) * 8
Actually I copied it from fuse, for 64-bit erofs_nid_t it has no difference
though. I will also update it as your suggestion in v2.

Thanks,
Gao Xiang


> ?
> 
> 
