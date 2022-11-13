Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7F626DED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 07:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiKMGsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 01:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiKMGsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 01:48:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A24AE79
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 22:48:34 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N930v43cRzHvkd;
        Sun, 13 Nov 2022 14:47:59 +0800 (CST)
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 14:48:27 +0800
Message-ID: <48ff4656-dd3e-b70e-0733-66ac37249bf5@huawei.com>
Date:   Sun, 13 Nov 2022 14:48:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/2] tracing: Fix memory leak in test_gen_synth_cmd() and
 test_empty_synth_event()
To:     Tom Zanussi <zanussi@kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <fengguang.wu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20221108083124.27218-1-shangxiaojing@huawei.com>
 <20221108083124.27218-2-shangxiaojing@huawei.com>
 <1b1d42582c2c9957dc47cd25b50f566b305fb14b.camel@kernel.org>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <1b1d42582c2c9957dc47cd25b50f566b305fb14b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2022/11/13 5:12, Tom Zanussi wrote:
> Hi Shang,
> 
> Thanks for finding this bug, comment below...
> 
> On Tue, 2022-11-08 at 16:31 +0800, Shang XiaoJing wrote:
>> test_gen_synth_cmd() only free buf in fail path, hence buf will leak
>> when there is no failure. Add kfree(buf) to prevent the memleak. The
>> same reason and solution in test_empty_synth_event().
>>
>> unreferenced object 0xffff8881127de000 (size 2048):
>>    comm "modprobe", pid 247, jiffies 4294972316 (age 78.756s)
>>    hex dump (first 32 bytes):
>>      20 67 65 6e 5f 73 79 6e 74 68 5f 74 65 73 74 20   gen_synth_test
>>      20 70 69 64 5f 74 20 6e 65 78 74 5f 70 69 64 5f   pid_t next_pid_
>>    backtrace:
>>      [<000000004254801a>] kmalloc_trace+0x26/0x100
>>      [<0000000039eb1cf5>] 0xffffffffa00083cd
>>      [<000000000e8c3bc8>] 0xffffffffa00086ba
>>      [<00000000c293d1ea>] do_one_initcall+0xdb/0x480
>>      [<00000000aa189e6d>] do_init_module+0x1cf/0x680
>>      [<00000000d513222b>] load_module+0x6a50/0x70a0
>>      [<000000001fd4d529>] __do_sys_finit_module+0x12f/0x1c0
>>      [<00000000b36c4c0f>] do_syscall_64+0x3f/0x90
>>      [<00000000bbf20cf3>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> unreferenced object 0xffff8881127df000 (size 2048):
>>    comm "modprobe", pid 247, jiffies 4294972324 (age 78.728s)
>>    hex dump (first 32 bytes):
>>      20 65 6d 70 74 79 5f 73 79 6e 74 68 5f 74 65 73   empty_synth_tes
>>      74 20 20 70 69 64 5f 74 20 6e 65 78 74 5f 70 69  t  pid_t next_pi
>>    backtrace:
>>      [<000000004254801a>] kmalloc_trace+0x26/0x100
>>      [<00000000d4db9a3d>] 0xffffffffa0008071
>>      [<00000000c31354a5>] 0xffffffffa00086ce
>>      [<00000000c293d1ea>] do_one_initcall+0xdb/0x480
>>      [<00000000aa189e6d>] do_init_module+0x1cf/0x680
>>      [<00000000d513222b>] load_module+0x6a50/0x70a0
>>      [<000000001fd4d529>] __do_sys_finit_module+0x12f/0x1c0
>>      [<00000000b36c4c0f>] do_syscall_64+0x3f/0x90
>>      [<00000000bbf20cf3>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Fixes: 9fe41efaca08 ("tracing: Add synth event generation test
>> module")
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   kernel/trace/synth_event_gen_test.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/trace/synth_event_gen_test.c
>> b/kernel/trace/synth_event_gen_test.c
>> index 0b15e975d2c2..db1ec4809ad1 100644
>> --- a/kernel/trace/synth_event_gen_test.c
>> +++ b/kernel/trace/synth_event_gen_test.c
>> @@ -120,6 +120,7 @@ static int __init test_gen_synth_cmd(void)
>>   
>>          /* Now generate a gen_synth_test event */
>>          ret = synth_event_trace_array(gen_synth_test, vals,
>> ARRAY_SIZE(vals));
>> +       kfree(buf);
>>    out:
>>          return ret;
>>    delete:
>> @@ -227,6 +228,7 @@ static int __init test_empty_synth_event(void)
>>   
>>          /* Now trace an empty_synth_test event */
>>          ret = synth_event_trace_array(empty_synth_test, vals,
>> ARRAY_SIZE(vals));
>> +       kfree(buf);
>>    out:
>>          return ret;
>>    delete:
> 
> Makes sense, and if you do this then you could probably remove the
> other kfree() at the bottom and clean the code up a bit, like change
> this:
> 
>         /* Now generate a gen_synth_test event */
>         ret = synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(vals));
>         kfree(buf);
>   out:
>          return ret;
>   delete:
>          /* We got an error after creating the event, delete it */
> 	synth_event_delete("gen_synth_test");
>   free:
>          kfree(buf);
> 
> 	goto out;
> }
> 
> to this:
> 
>         /* Now generate a gen_synth_test event */
>         ret = synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(vals));
>   free:
>         kfree(buf);
>         return ret;
>   delete:
>          /* We got an error after creating the event, delete it */
> 	synth_event_delete("gen_synth_test");
>   	goto free;
> }
> 
> What do you think?
> 

Right, I thought maybe less change is better for the bugfix. It looks 
better to carry some clean up, thanks for the review, will fix in v2.

Thanks,
-- 
Shang XiaoJing
