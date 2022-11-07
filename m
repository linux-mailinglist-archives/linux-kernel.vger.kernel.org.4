Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F761F49D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKGNrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:47:16 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5741CFCE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:47:14 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5XW94lG2zpWDX;
        Mon,  7 Nov 2022 21:43:33 +0800 (CST)
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 21:47:11 +0800
Message-ID: <7576839f-9a1d-65ee-afa8-2ba8eed44ffd@huawei.com>
Date:   Mon, 7 Nov 2022 21:47:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 2/2] tracing: kprobe: Fix potential null-ptr-deref on
 trace_array in kprobe_event_gen_test_exit()
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <rostedt@goodmis.org>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221107071617.21644-1-shangxiaojing@huawei.com>
 <20221107071617.21644-3-shangxiaojing@huawei.com>
 <20221107223835.4d5583852a7efef1a2ac19af@kernel.org>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <20221107223835.4d5583852a7efef1a2ac19af@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/11/7 21:38, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Mon, 7 Nov 2022 15:16:17 +0800
> Shang XiaoJing <shangxiaojing@huawei.com> wrote:
> 
>> When test_gen_kprobe_cmd() failed after kprobe_event_gen_cmd_end(), it
>> will goto delete, which will call kprobe_event_delete() and release the
>> corresponding resource. However, the trace_array in gen_kretprobe_test
>> will point to the invalid resource. Set gen_kretprobe_test->tr to NULL
>> after called kprobe_event_delete() and add NULL check when releasing
>> the module.
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000070
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP PTI
>> CPU: 0 PID: 246 Comm: modprobe Tainted: G        W
>> 6.1.0-rc1-00174-g9522dc5c87da-dirty #248
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:__ftrace_set_clr_event_nolock+0x53/0x1b0
>> Code: e8 82 26 fc ff 49 8b 1e c7 44 24 0c ea ff ff ff 49 39 de 0f 84 3c
>> 01 00 00 c7 44 24 18 00 00 00 00 e8 61 26 fc ff 48 8b 6b 10 <44> 8b 65
>> 70 4c 8b 6d 18 41 f7 c4 00 02 00 00 75 2f
>> RSP: 0018:ffffc9000159fe00 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff88810971d268 RCX: 0000000000000000
>> RDX: ffff8881080be600 RSI: ffffffff811b48ff RDI: ffff88810971d058
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>> R10: ffffc9000159fe58 R11: 0000000000000001 R12: ffffffffa0001064
>> R13: ffffffffa000106c R14: ffff88810971d238 R15: 0000000000000000
>> FS:  00007f89eeff6540(0000) GS:ffff88813b600000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000070 CR3: 000000010599e004 CR4: 0000000000330ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __ftrace_set_clr_event+0x3e/0x60
>>   trace_array_set_clr_event+0x35/0x50
>>   ? 0xffffffffa0000000
>>   kprobe_event_gen_test_exit+0xcd/0x10b [kprobe_event_gen_test]
>>   __x64_sys_delete_module+0x206/0x380
>>   ? lockdep_hardirqs_on_prepare+0xd8/0x190
>>   ? syscall_enter_from_user_mode+0x1c/0x50
>>   do_syscall_64+0x3f/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f89eeb061b7
>>
>> Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   kernel/trace/kprobe_event_gen_test.c | 29 +++++++++++++++++-----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
>> index 1c98fafcf333..277e21e4a63e 100644
>> --- a/kernel/trace/kprobe_event_gen_test.c
>> +++ b/kernel/trace/kprobe_event_gen_test.c
>> @@ -145,6 +145,8 @@ static int __init test_gen_kprobe_cmd(void)
>>    delete:
>>   	/* We got an error after creating the event, delete it */
>>   	ret = kprobe_event_delete("gen_kprobe_test");
>> +	if (trace_event_file_is_valid(gen_kprobe_test))
>> +		gen_kprobe_test->tr = NULL;
> 
> I think the correct fix should be
> 
> 	if (trace_event_file_is_valid(gen_kprobe_test)) {
> 		trace_put_event_file(gen_kprobe_test);
> 		gen_kprobe_test = NULL;
> 	}
>    	ret = kprobe_event_delete("gen_kprobe_test");
> 
> Since the gen_kprobe_event is owned by ftrace subsystem, the test
> code should not change the tr field.
> 
When trace_array_set_clr_event() failed, it already called 
trace_put_event_file(), maybe we only need set gen_kprobe_test to NULL.

>>   	goto out;
>>   }
>>   
>> @@ -208,6 +210,8 @@ static int __init test_gen_kretprobe_cmd(void)
>>    delete:
>>   	/* We got an error after creating the event, delete it */
>>   	ret = kprobe_event_delete("gen_kretprobe_test");
>> +	if (trace_event_file_is_valid(gen_kretprobe_test))
>> +		gen_kretprobe_test->tr = NULL;
> 
> Ditto. >
> And then, below changes are not required.

Yes, will fix in v2, thanks for the review.

Thanks,
-- 
Shang XiaoJing
