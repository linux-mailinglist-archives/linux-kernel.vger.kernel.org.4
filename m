Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4C7237E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjFFGkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFGkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECEC7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7933762D91
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC0C433EF;
        Tue,  6 Jun 2023 06:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686033637;
        bh=Bc4xT3nI5CYlCloz6TBu1mtUbi94szMGgvZxxy0tVYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rjyte5kIcsFHmqfF+YX9Rw0ff33W8LAOFjXNpZNTRMA/2+ocj5k2uivmGlNj2WyUO
         vUD0UU7DYYV7ExjEUamA2L5Rtw6pFhNNv6utbvgX3Nol+oO3s+lYfhL9d6vS7T9HCo
         Ky8orgrROjSbOz/+G7haRhOgRlReQn5p+JhC6B3Uo1UuyWTDptbwV9WM7XY9wuN/1/
         8rc/fTcE/MXrzcXfWDnuo90aClU7ojdnK/K0PjldPSQHw1Jscq6q2fF8MOcJr02wj0
         npndYTC7Wiai3FaQmXJGRCv24lYuTR5s44Cv32igVcApf8k091qUs1t6WP4oG6BOfh
         5LoQCYZFVLUFg==
Message-ID: <20fb7157-05ae-eeb5-4acd-76b2c82d80b3@kernel.org>
Date:   Tue, 6 Jun 2023 14:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: flag as supporting buffered async reads
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Juhyung Park <qkrwngud825@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Lu Hongfei <luhongfei@vivo.com>
References: <20230531125918.55609-1-frank.li@vivo.com>
 <CAD14+f1YoiSVvq2M1v8u5bUdCNN_0nurY4ued6ZFu1gaBSHxDw@mail.gmail.com>
 <ZH48E4/AOtk1viOY@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZH48E4/AOtk1viOY@google.com>
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

On 2023/6/6 3:48, Jaegeuk Kim wrote:
> On 05/31, Juhyung Park wrote:
>> Hi Yangtao,
>>
>> I remember hearing that f2fs can perform relatively poorly under io_uring,
>> nice find.
>>
>> I suggest rewriting the commit message though. From the looks of it, it
>> might suggest that FMODE_BUF_RASYNC is a magic flag that automatically
>> improves performance that can be enabled willy nilly.
>>
>> How about something like:
>>
>> f2fs uses generic_file_buffered_read(), which supports buffered async
>> reads since commit 1a0a7853b901 ("mm: support async buffered reads in
>> generic_file_buffered_read()").
> 
> Thanks Juhyung,
> 
> Applied with a minor motification based on yours. :)

The version in dev-test branch looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Match other file-systems and enable it. The read performance has been
>> greatly improved under io_uring:
>>
>>      167M/s -> 234M/s, Increase ratio by 40%
>>
>> Test w/:
>>      ./fio --name=onessd --filename=/data/test/local/io_uring_test
>>      --size=256M --rw=randread --bs=4k --direct=0 --overwrite=0
>>      --numjobs=1 --iodepth=1 --time_based=0 --runtime=10
>>      --ioengine=io_uring --registerfiles --fixedbufs
>>      --gtod_reduce=1 --group_reporting --sqthread_poll=1
>>
>> On Wed, May 31, 2023 at 10:01 PM Yangtao Li via Linux-f2fs-devel
>> <linux-f2fs-devel@lists.sourceforge.net> wrote:
>>>
>>> After enabling this feature, the read performance has been greatly
>>> improved:
>>>
>>>      167M/s -> 234M/s, Increase ratio by 40%
>>>
>>> Test w/:
>>>      ./fio --name=onessd --filename=/data/test/local/io_uring_test
>>>      --size=256M --rw=randread --bs=4k --direct=0 --overwrite=0
>>>      --numjobs=1 --iodepth=1 --time_based=0 --runtime=10
>>>      --ioengine=io_uring --registerfiles --fixedbufs
>>>      --gtod_reduce=1 --group_reporting --sqthread_poll=1
>>>
>>> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>   fs/f2fs/file.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 015ed274dc31..23c68ee946e5 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -546,7 +546,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>>>          if (err)
>>>                  return err;
>>>
>>> -       filp->f_mode |= FMODE_NOWAIT;
>>> +       filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
>>>
>>>          return dquot_file_open(inode, filp);
>>>   }
>>> --
>>> 2.39.0
>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
