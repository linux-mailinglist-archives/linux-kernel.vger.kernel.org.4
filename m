Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38D6649EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiLLMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiLLMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:39:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848955AE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:38:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2BA1B80D20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10685C433EF;
        Mon, 12 Dec 2022 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670848721;
        bh=hVzoOsyhwS9evjgtcwkNyUUi5Ga7nvRZ83iWkuubvr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cjliJuA9RtYf4AvLwNw9qsB8Sbzrx1Q/eDqyJh6qUnVpcBn7rdf5w5kcTBmuRxuzm
         rOf5nlY6Ef8Vr5GioJ2JHqPtqqIrmq+AfB27xAlgol1eNXN6V1m2a5rthDAy5Y4rMo
         p0fXPN7YxcJXzD43KIKFbT6j44whIaU49Etn7pV8f6GkA9thkFkEcMb/j7/6mvcA3W
         6XrzXDjgDNUgAPkYC2t5l9gzTuNhDtwzqp1rpthxhv3ntc/Yc56YvzJ7fZAkydDToA
         /mQAtXLI9KFRxVjI+choL4MrXDulpbzwfC55uGai9jHpXlLNj5WzWPOvid67Ae94/j
         130NHknOVWE4A==
Message-ID: <f1aba391-e694-714e-18d8-116e8db9345d@kernel.org>
Date:   Mon, 12 Dec 2022 20:38:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not
 compressed
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, zhoudan8 <zhuqiandann@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8 <zhoudan8@xiaomi.com>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
 <Y5OYYJYx9G2LbRmc@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5OYYJYx9G2LbRmc@google.com>
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

On 2022/12/10 4:19, Jaegeuk Kim wrote:
> On 12/08, zhoudan8 wrote:
>> In compress_mode=user, f2fs_release_compress_blocks()
>>   does not verify whether it has been compressed and
>>   sets FI_COMPRESS_RELEASED directly. which will lead to
>> return -EINVAL after calling compress.
>> To fix it,let's do not set FI_COMPRESS_RELEASED if file
>> is not compressed.
> 
> Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
> with zero i_compr_blokcs?
> 
> I think the current logic is giving the error on a released file already.

IMO, if i_compr_blocks is zero, it's better to return -EINVAL in
f2fs_release_compress_blocks(), as there will be no benefit after the conversion.

Thanks,

> 
>>
>> Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
>> ---
>>   fs/f2fs/file.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 82cda1258227..f32910077df6 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>>   	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>>   	if (ret)
>>   		goto out;
>> -
>> -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
>>   	inode->i_ctime = current_time(inode);
>>   	f2fs_mark_inode_dirty_sync(inode, true);
>>   
>>   	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
>>   		goto out;
>>   
>> +	set_inode_flag(inode, FI_COMPRESS_RELEASED);
>>   	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>   	filemap_invalidate_lock(inode->i_mapping);
>>   
>> -- 
>> 2.38.1
