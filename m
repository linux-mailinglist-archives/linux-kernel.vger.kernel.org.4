Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61334607095
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJUG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJUG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:57:36 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32740244708
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:57:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VSiKiEG_1666335448;
Received: from 30.32.67.117(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VSiKiEG_1666335448)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 14:57:29 +0800
Message-ID: <fc9fa0b2-16d3-9aba-02a2-61d492bde95f@linux.alibaba.com>
Date:   Fri, 21 Oct 2022 14:57:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] mm, hwpoison: Try to recover from copy-on write faults
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221019170835.155381-1-tony.luck@intel.com>
 <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
 <Y1GqGbBNk6fX/OnD@agluck-desk3.sc.intel.com>
 <359bae4e-6ce3-cc7e-33d0-252064157bc6@linux.alibaba.com>
 <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/21 PM12:08, Tony Luck 写道:
> On Fri, Oct 21, 2022 at 09:52:01AM +0800, Shuai Xue wrote:
>>
>>
>> 在 2022/10/21 AM4:05, Tony Luck 写道:
>>> On Thu, Oct 20, 2022 at 09:57:04AM +0800, Shuai Xue wrote:
>>>>
>>>>
>>>> 在 2022/10/20 AM1:08, Tony Luck 写道:
> 
>>> I'm experimenting with using sched_work() to handle the call to
>>> memory_failure() (echoing what the machine check handler does using
>>> task_work)_add() to avoid the same problem of not being able to directly
>>> call memory_failure()).
>>
>> Work queues permit work to be deferred outside of the interrupt context
>> into the kernel process context. If we return to user-space before the
>> queued memory_failure() work is processed, we will take the fault again,
>> as we discussed recently.
>>
>>     commit 7f17b4a121d0d ACPI: APEI: Kick the memory_failure() queue for synchronous errors
>>     commit 415fed694fe11 ACPI: APEI: do not add task_work to kernel thread to avoid memory leak
>>
>> So, in my opinion, we should add memory failure as a task work, like
>> do_machine_check does, e.g.
>>
>>     queue_task_work(&m, msg, kill_me_maybe);
> 
> Maybe ... but this case isn't pending back to a user instruction
> that is trying to READ the poison memory address. The task is just
> trying to WRITE to any address within the page.

Aha, I see the difference. Thank you. But I still have a question on
this. Let us discuss in your reply to David Laight.

Best Regards,
Shuai

> 
> So this is much more like a patrol scrub error found asynchronously
> by the memory controller (in this case found asynchronously by the
> Linux page copy function).  So I don't feel that it's really the
> responsibility of the current task.
> 
> When we do return to user mode the task is going to be busy servicing
> a SIGBUS ... so shouldn't try to touch the poison page before the
> memory_failure() called by the worker thread cleans things up.
> 
>>> +	INIT_WORK(&p->work, do_sched_memory_failure);
>>> +	p->pfn = pfn;
>>> +	schedule_work(&p->work);
>>> +}
>>
>> I think there is already a function to do such work in mm/memory-failure.c.
>>
>> 	void memory_failure_queue(unsigned long pfn, int flags)
> 
> Also pointed out by Miaohe Lin <linmiaohe@huawei.com> ... this does
> exacly what I want, and is working well in tests so far. So perhaps
> a cleaner solution than making the kill_me_maybe() function globally
> visible.
> 
> -Tony
