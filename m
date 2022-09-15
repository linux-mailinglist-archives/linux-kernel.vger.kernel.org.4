Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4579A5B9234
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIOBhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIOBhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:37:08 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3659264
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:37:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPqLUsL_1663205822;
Received: from 30.240.121.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VPqLUsL_1663205822)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 09:37:04 +0800
Message-ID: <e9076da5-bd96-1a21-e4af-36eb46409178@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 09:36:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] mm,hwpoison: check mm when killing accessing process
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     naoya.horiguchi@nec.com, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cuibixuan@linux.alibaba.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        Huang Ying <ying.huang@intel.com>
References: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
 <20220914153542.285f870f728c6129a479a69d@linux-foundation.org>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220914153542.285f870f728c6129a479a69d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/15 AM6:35, Andrew Morton 写道:
> On Wed, 14 Sep 2022 14:49:35 +0800 Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The GHES code calls memory_failure_queue() from IRQ context to queue work
>> into workqueue and schedule it on the current CPU. Then the work is
>> processed in memory_failure_work_func() by kworker and calls
>> memory_failure().
>>
>> When a page is already poisoned, commit a3f5d80ea401 ("mm,hwpoison: send
>> SIGBUS with error virutal address") make memory_failure() call
>> kill_accessing_process() that:
>>
>>     - holds mmap locking of current->mm
>>     - does pagetable walk to find the error virtual address
>>     - and sends SIGBUS to the current process with error info.
>>
>> However, the mm of kworker is not valid. Therefore, check mm when killing
>> accessing process.
> 
> Thanks.
> 
> When fixing a bug, please always describe the user-visible effects of
> tha bug.  I'm thinking "null pointer deref crashes the kernel".

Got it. Thank you :)

> 
>> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> I'll add cc:stable.

Thanks.

> 
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -743,6 +743,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>>  	};
>>  	priv.tk.tsk = p;
>>  
>> +	if (!p->mm)
>> +		return -EFAULT;
>> +
>>  	mmap_read_lock(p->mm);
>>  	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
>>  			      (void *)&priv);
>> @@ -751,6 +754,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>>  	else
>>  		ret = 0;
>>  	mmap_read_unlock(p->mm);
>> +
>>  	return ret > 0 ? -EHWPOISON : -EFAULT;
>>  }
> 
> This is an unrelated change which doesn't appear to match the style in
> memory-failure.c, so I'll drop this hunk.

I see, thanks.

Cheers,
Shuai
