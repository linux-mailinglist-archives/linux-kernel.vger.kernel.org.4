Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE306BDE22
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCQBY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:24:25 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709D3199C6;
        Thu, 16 Mar 2023 18:24:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Ve0nrhc_1679016257;
Received: from 30.240.112.205(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ve0nrhc_1679016257)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 09:24:18 +0800
Message-ID: <335fe2c8-1ed7-c945-a158-181154bdea79@linux.alibaba.com>
Date:   Fri, 17 Mar 2023 09:24:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-3-xueshuai@linux.alibaba.com>
 <20230316072148.GA364378@hori.linux.bs1.fc.nec.co.jp>
 <8cd8688e-99f9-0696-c6bc-1c3ce44eec55@linux.alibaba.com>
 <20230317002922.GA407956@hori.linux.bs1.fc.nec.co.jp>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230317002922.GA407956@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/17 AM8:29, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Mar 16, 2023 at 07:10:56PM +0800, Shuai Xue wrote:
>>
>>
>> On 2023/3/16 PM3:21, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Mon, Feb 27, 2023 at 01:03:15PM +0800, Shuai Xue wrote:
>>>> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
>>>> error is detected by a background scrubber, or signaled by synchronous
>>>> exception, e.g. when an uncorrected error is consumed. Both synchronous and
>>>> asynchronous error are queued and handled by a dedicated kthread in
>>>> workqueue.
>>>>
>>>> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
>>>> synchronous errors") keep track of whether memory_failure() work was
>>>> queued, and make task_work pending to flush out the workqueue so that the
>>>> work for synchronous error is processed before returning to user-space.
>>>> The trick ensures that the corrupted page is unmapped and poisoned. And
>>>> after returning to user-space, the task starts at current instruction which
>>>> triggering a page fault in which kernel will send SIGBUS to current process
>>>> due to VM_FAULT_HWPOISON.
>>>>
>>>> However, the memory failure recovery for hwpoison-aware mechanisms does not
>>>> work as expected. For example, hwpoison-aware user-space processes like
>>>> QEMU register their customized SIGBUS handler and enable early kill mode by
>>>> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
>>>> the process by sending a SIGBUS signal in memory failure with wrong
>>>> si_code: the actual user-space process accessing the corrupt memory
>>>> location, but its memory failure work is handled in a kthread context, so
>>>> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
>>>> process instead of BUS_MCEERR_AR in kill_proc().
>>>>
>>>> To this end, separate synchronous and asynchronous error handling into
>>>> different paths like X86 platform does:
>>>>
>>>> - task work for synchronous errors.
>>>> - and workqueue for asynchronous errors.
>>>>
>>>> Then for synchronous errors, the current context in memory failure is
>>>> exactly belongs to the task consuming poison data and it will send SIBBUS
>>>> with proper si_code.
>>>>
>>>> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> ...
>>>>  
>>>>  /*
>>>> - * Called as task_work before returning to user-space.
>>>> - * Ensure any queued work has been done before we return to the context that
>>>> - * triggered the notification.
>>>> + * struct mce_task_work - for synchronous RAS event
>>>
>>> This seems to handle synchronous memory errors, not limited to MCE?
>>> So naming this struct as such (more generally) might be better.
>>
>> Yes. How about `sync_task_work`?
> 
> Sounds better to me.

Fine, I will change it in next version.

>>
>>>
>>>> + *
>>>> + * @twork:                callback_head for task work
>>>> + * @pfn:                  page frame number of corrupted page
>>>> + * @flags:                fine tune action taken
>>>> + *
>>>> + * Structure to pass task work to be handled before
>>>> + * ret_to_user via task_work_add().
>>>>   */
>>> ...
>>>
>>>>  }
>>>>  
>>>> -static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>>> +static void ghes_do_memory_failure(u64 physical_addr, int flags)
>>>>  {
>>>>  	unsigned long pfn;
>>>> +	struct mce_task_work *twcb;
>>>>  
>>>>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>>>> -		return false;
>>>> +		return;
>>>>  
>>>>  	pfn = PHYS_PFN(physical_addr);
>>>>  	if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) {
>>>>  		pr_warn_ratelimited(FW_WARN GHES_PFX
>>>>  		"Invalid address in generic error data: %#llx\n",
>>>>  		physical_addr);
>>>> -		return false;
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (flags == MF_ACTION_REQUIRED && current->mm) {
>>>> +		twcb = kmalloc(sizeof(*twcb), GFP_ATOMIC);
>>>> +		if (!twcb)
>>>> +			return;
>>>
>>> When this kmalloc() fails, the error event might be silently dropped?
>>> If so, some warning messages could be helpful.
>>
>> Yes, I was going to add a warning messages like:
>>
>>     pr_err("Failed to handle memory failure due to out of memory\n");
>>
>> But got a warning about patch when checked by checkpatch.pl.
>>
>>    WARNING: Possible unnecessary 'out of memory' message
>>
>> I will add it back in next version :)
> 
> Oh, I didn't know about this warning.  I checked the commit log introduced
> this meesages, and the justification makes sense to me. So I'd like to
> withdraw my comment about this (I mean you don't have to add it back).
> 
>   commit ebfdc40969f24fc0cdd1349835d36e8ebae05374                            
>   Author: Joe Perches <joe@perches.com>                                      
>   Date:   Wed Aug 6 16:10:27 2014 -0700                                      
>                                                                              
>       checkpatch: attempt to find unnecessary 'out of memory' messages       
>                                                                              
>       Logging messages that show some type of "out of memory" error are      
>       generally unnecessary as there is a generic message and a stack dump   
>       done by the memory subsystem.                                          
>                                                                              
>       These messages generally increase kernel size without much added value.

Haha, that's exactly the patch I was referring to (Sorry for forgetting to
attach a link in last reply). So I will not add the warning messages back.

> 
> Thanks,
> Naoya Horiguchi

Thank you for comments.

Cheers.
Shuai

