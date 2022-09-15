Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F995B9282
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIOCGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIOCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:06:42 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2A5B05D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:06:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPqfvKR_1663207594;
Received: from 30.240.121.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VPqfvKR_1663207594)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 10:06:38 +0800
Message-ID: <a6073325-b575-d991-7bf9-999642e0ca90@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 10:06:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] mm,hwpoison: check mm when killing accessing process
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
References: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
 <51eb9735-349e-db8b-fa1c-096a924ef520@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <51eb9735-349e-db8b-fa1c-096a924ef520@huawei.com>
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



在 2022/9/15 AM9:45, Miaohe Lin 写道:
> On 2022/9/14 14:49, Shuai Xue wrote:
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
>>
>> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Thanks for fixing.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> Miaohe Lin

Thank you for your review.

Cheers,
Shuai

> 
> 
>> ---
>>  mm/memory-failure.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 14439806b5ef..7553917ce820 100644
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
>>  
>>
