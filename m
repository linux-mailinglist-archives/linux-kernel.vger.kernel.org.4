Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7136266CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiKLDw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiKLDwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:52:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D3391D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 19:52:06 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8M844cqQz15MN6;
        Sat, 12 Nov 2022 11:51:48 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 11:52:04 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 11:52:03 +0800
Subject: Re: [PATCH] kprobes: Update ftrace_ops when clearing ftrace-based
 aggrprobe's post_handler
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <rostedt@goodmis.org>, <joe.lawrence@redhat.com>,
        <zhaogongyi@huawei.com>
References: <20221111101006.239177-1-lihuafei1@huawei.com>
 <20221112003311.30ff643aee860d5b27e3617a@kernel.org>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <ab264a6e-729b-bd49-7fa2-8bccfa24c735@huawei.com>
Date:   Sat, 12 Nov 2022 11:52:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20221112003311.30ff643aee860d5b27e3617a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/11 23:33, Masami Hiramatsu (Google) wrote:
> On Fri, 11 Nov 2022 18:10:06 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> In __unregister_kprobe_top(), if the currently unregistered probe has
>> post_handler but other child probes of the aggrprobe do not have
>> post_handler, the post_handler of the aggrprobe is cleared. If this is
>> a ftrace-based probe, there is a problem. In later calls to
>> disarm_kprobe(), we will use kprobe_ftrace_ops because post_handler is
>> NULL. But we're armed with kprobe_ipmodify_ops. This triggers a WARN in
>> __disarm_kprobe_ftrace() and may even cause use-after-free:
>>
>>   Failed to disarm kprobe-ftrace at kernel_clone+0x0/0x3c0 (error -2)
>>   WARNING: CPU: 5 PID: 137 at kernel/kprobes.c:1135 __disarm_kprobe_ftrace.isra.21+0xcf/0xe0
>>   Modules linked in: testKprobe_007(-)
>>   CPU: 5 PID: 137 Comm: rmmod Not tainted 6.1.0-rc4-dirty #18
>>   [...]
>>   Call Trace:
>>    <TASK>
>>    __disable_kprobe+0xcd/0xe0
>>    __unregister_kprobe_top+0x12/0x150
>>    ? mutex_lock+0xe/0x30
>>    unregister_kprobes.part.23+0x31/0xa0
>>    unregister_kprobe+0x32/0x40
>>    __x64_sys_delete_module+0x15e/0x260
>>    ? do_user_addr_fault+0x2cd/0x6b0
>>    do_syscall_64+0x3a/0x90
>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>    [...]
> 
> Ah, good catch! :D
> 
>>
>> For ftrace kprobe, update post_handler at the same time update
>> ftrace_ops, moving it from kprobe_ipmodify_ops to kprobe_ftrace_ops.
> 
> Hmm, but I would not like this because there can be a time
> window when it can miss an event. What about just skipping
> clearing ap->post_handler in kprobe-on-ftrace case?
> 

Agree. I hadn't considered this time window. The effects I see if I keep
ap->handler are 1) kprobe_ftrace_handler() still needs to call
aggr_post_handler() and 2) other ftrace_ops still can't set IPMODIFY on
the probe function. This doesn't seem to be a problem.

Thanks for the suggestion.

>>
>> Fixes: 0bc11ed5ab60 ("kprobes: Allow kprobes coexist with livepatch")
>> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  kernel/kprobes.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index cd9f5a66a690..f8bec48a9cf9 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1766,7 +1766,17 @@ static int __unregister_kprobe_top(struct kprobe *p)
>>  				if ((list_p != p) && (list_p->post_handler))
>>  					goto noclean;
>>  			}
>> -			ap->post_handler = NULL;
>> +			/*
>> +			 * For ftrace kprobe, we need to update ftrace_ops
>> +			 * at the same time as we update post_handler, moving
>> +			 * it from kprobe_ipmodify_ops to kprobe_ftrace_ops.
>> +			 */
>> +			if (unlikely(kprobe_ftrace(ap))) {
>> +				disarm_kprobe(ap, false);
>> +				ap->post_handler = NULL;
>> +				arm_kprobe(ap);
>> +			} else
> 
> So here, just add; (also, don't use unlikely/likely for this case, this
> depends on where the user probes, not a systematically rare case.)
> 

Okay. Will fix it in the next version. Thanks!

> 			if (!kprobe_ftrace(ap))
> 
>> +				ap->post_handler = NULL;
> 
> Thank you!
> 
>>  		}
>>  noclean:
>>  		/*
>> -- 
>> 2.17.1
>>
> 
> 
