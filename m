Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E961F465
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiKGNbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiKGNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:31:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA01CB09
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:31:41 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5XB04tKZzJnXT;
        Mon,  7 Nov 2022 21:28:40 +0800 (CST)
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 21:31:39 +0800
Message-ID: <ea5827fc-ca41-3ee7-87df-f1e3acdba561@huawei.com>
Date:   Mon, 7 Nov 2022 21:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/2] tracing: kprobe: Fix potential null-ptr-deref on
 trace_event_file in kprobe_event_gen_test_exit()
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <rostedt@goodmis.org>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221107071617.21644-1-shangxiaojing@huawei.com>
 <20221107071617.21644-2-shangxiaojing@huawei.com>
 <20221107222540.1701bb267fd523fbafbbdee8@kernel.org>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <20221107222540.1701bb267fd523fbafbbdee8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2022/11/7 21:25, Masami Hiramatsu (Google) wrote:
> On Mon, 7 Nov 2022 15:16:16 +0800
> Shang XiaoJing <shangxiaojing@huawei.com> wrote:
> 
>> When trace_get_event_file() failed, gen_kretprobe_test will be assigned
>> as the error code. If module kprobe_event_gen_test is removed now, the
>> null pointer dereference will happen in kprobe_event_gen_test_exit().
>> Check if gen_kprobe_test or gen_kretprobe_test is error code or NULL
>> before dereference them.
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000012
>> PGD 0 P4D 0
>> Oops: 0000 [#1] SMP PTI
>> CPU: 3 PID: 2210 Comm: modprobe Not tainted
>> 6.1.0-rc1-00171-g2159299a3b74-dirty #217
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:kprobe_event_gen_test_exit+0x1c/0xb5 [kprobe_event_gen_test]
>> Code: Unable to access opcode bytes at 0xffffffff9ffffff2.
>> RSP: 0018:ffffc900015bfeb8 EFLAGS: 00010246
>> RAX: ffffffffffffffea RBX: ffffffffa0002080 RCX: 0000000000000000
>> RDX: ffffffffa0001054 RSI: ffffffffa0001064 RDI: ffffffffdfc6349c
>> RBP: ffffffffa0000000 R08: 0000000000000004 R09: 00000000001e95c0
>> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000800
>> R13: ffffffffa0002420 R14: 0000000000000000 R15: 0000000000000000
>> FS:  00007f56b75be540(0000) GS:ffff88813bc00000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffff9ffffff2 CR3: 000000010874a006 CR4: 0000000000330ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __x64_sys_delete_module+0x206/0x380
>>   ? lockdep_hardirqs_on_prepare+0xd8/0x190
>>   ? syscall_enter_from_user_mode+0x1c/0x50
>>   do_syscall_64+0x3f/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
> 
> Ah, indeed. If anything wrong in the test code and if the
> gen_kprobe_test/gen_kretprobe_test is not initialized, this
> can happen.
> 
> Cc: stable@vger.kernel.org
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you!
> 
Thanks for the review, will add the Tag in v2.

Thanks,
-- 
Shang XiaoJing
