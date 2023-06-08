Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8407F727B96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjFHJiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjFHJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7C1BFF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11AD64B58
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AEFC433D2;
        Thu,  8 Jun 2023 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217090;
        bh=V19RuyGw5moEVQtVIKIzHCHkmzutxvLKUftm4u1YHGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HfOYHujpVwPnBBs8MCW0W1iGvRx+wOQX/szfXZboXubF8q4XHtecO5OD86vbE2s6/
         mZqC2BoP61MJ50e1RU2Zai29XGG84KdAt/OcBUJn9L4xVsvdJiwcKv220DewoB1v1z
         DN/QCbMGv9MYdfe6PKd81teb+hFFuo+j96LSFw0cFG4OzNj0EzEAmi74B6EdK5m22T
         Ix9XVYwbr30CZrteZulUWuoeFXAca2v/YMiHIrlHUL6CEEKCnEO+5reOmkJA928/Kp
         XmSvzADO/8c4Ty1ufLex02AHZKKUpy0zQKelwWeOKlpsle0Yq04i+nEYxFcEovTFtw
         MRtwgvAmJOAsQ==
Message-ID: <059b17ce-cb65-fd55-29b1-2b253c6b41c4@kernel.org>
Date:   Thu, 8 Jun 2023 17:38:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] f2fs: enable nowait async buffered writes
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230531144006.7307-1-frank.li@vivo.com>
 <e8e4758f-5895-acd7-27d2-4b72b69722b3@kernel.org>
 <29bea47b-9085-05e7-d254-a40007e6c7f3@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <29bea47b-9085-05e7-d254-a40007e6c7f3@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/6 19:13, Yangtao Li wrote:
> On 2023/6/6 14:43, Chao Yu wrote:
> 
>> On 2023/5/31 22:40, Yangtao Li wrote:
>>> This adds the async buffered write support to f2fs,
>>> the following is the relevant test data.
>>
>> Yangtao,
>>
>> Could you please provide detailed test command?
> 
> 
> Use fio to test, the following is the configuration:
> 
> # io_uring
> [global]
> ioengine=io_uring
> sqthread_poll=1
> threads=1
> iodepth=32
> hipri=0
> direct=0
> fixedbufs=0
> uncached=0
> nowait=0
> force_async=0
> randrepeat=0
> time_based=0
> size=256M
> filename=/data/test/local/io_uring_test
> group_reporting
> [read256B-rand]
> bs=4096
> rw=randwrite
> numjobs=1

Thanks, it looks the performance is not very stable when iodepth is
large, e.g. 32.

Could you please add above test parameter into commit message?

Otherwise, this patch looks good to me.

Thanks,

> 
> 
>>
>> Thanks,
>>
>>>
>>> iodepth      | 1    | 2    | 4    | 8    | 16   |
>>> before(M/s)  | 1012 | 1133 | 894  | 981  | 866  |
>>> after(M/s)   | 1488 | 1896 | 2081 | 2188 | 2207 |
>>>
>>> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>   fs/f2fs/file.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 23c68ee946e5..4faf2c04e325 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -546,7 +546,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>>>       if (err)
>>>           return err;
>>>   -    filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
>>> +    filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
>>>         return dquot_file_open(inode, filp);
>>>   }
>>> @@ -4515,9 +4515,6 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
>>>       struct inode *inode = file_inode(file);
>>>       ssize_t ret;
>>>   -    if (iocb->ki_flags & IOCB_NOWAIT)
>>> -        return -EOPNOTSUPP;
>>> -
>>>       current->backing_dev_info = inode_to_bdi(inode);
>>>       ret = generic_perform_write(iocb, from);
>>>       current->backing_dev_info = NULL;
