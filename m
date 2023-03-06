Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B26ABA3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCFJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCFJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:45:08 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AAB2130
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:45:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdE1F8n_1678095901;
Received: from 30.221.131.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VdE1F8n_1678095901)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 17:45:02 +0800
Message-ID: <19551cbd-f4b9-b53a-bbfb-08c88b81321b@linux.alibaba.com>
Date:   Mon, 6 Mar 2023 17:45:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] erofs: avoid hardcoded blocksize for subpage block
 support
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
 <20230302143915.111739-2-jefflexu@linux.alibaba.com>
 <20230306151606.00000ebd.zbestahu@gmail.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230306151606.00000ebd.zbestahu@gmail.com>
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



On 3/6/23 3:16 PM, Yue Hu wrote:
> On Thu,  2 Mar 2023 22:39:14 +0800
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> As the first step of converting hardcoded blocksize to that specified in
>> on-disk superblock, convert all call sites of hardcoded blocksize to
>> sb->s_blocksize except for:
>>
>> 1) use sbi->blkszbits instead of sb->s_blocksize in
>> erofs_superblock_csum_verify() since sb->s_blocksize has not been
>> updated with the on-disk blocksize yet when the function is called.
>>
>> 2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
>> since the inode operated on may be an anonymous inode in fscache mode.
>> Currently the anonymous inode is allocated from an anonymous mount
>> maintained in erofs, while in the near future we may allocate anonymous
>> inodes from a generic API directly and thus have no access to the
>> anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
>> anonymous inodes in fscache mode.
>>
>> Be noted that this patch only gets rid of the hardcoded blocksize, in
>> preparation for actually setting the on-disk block size in the following
>> patch.  The hard limit of constraining the block size to PAGE_SIZE still
>> exists until the next patch.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>> index 51b7ac7166d9..21fc6897d225 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -42,7 +42,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>>  		if (!sbi->lz4.max_pclusterblks) {
>>  			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
>>  		} else if (sbi->lz4.max_pclusterblks >
>> -			   Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
>> +			   Z_EROFS_PCLUSTER_MAX_SIZE >> sb->s_blocksize_bits) {
> 
> erofs_blknr(sb, Z_EROFS_PCLUSTER_MAX_SIZE)?

Okay.

>> @@ -422,7 +423,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>>  		return -EFSCORRUPTED;
>>  	}
>>  out:
>> -	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
>> +	map->m_plen = (u64)m->compressedblks << sb->s_blocksize_bits;
> 
> erofs_pos(sb, m->compressedblks)?

Okay.  I will update all these in the next version.

Thanks for the comment!


-- 
Thanks,
Jingbo
