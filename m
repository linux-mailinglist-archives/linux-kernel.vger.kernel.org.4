Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA4602124
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJRC00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJRC0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:26:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841258FD74
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:26:16 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MryKR4vhLzmV9B;
        Tue, 18 Oct 2022 10:21:31 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:26:13 +0800
Subject: Re: [PATCH] copy_process(): fix a memleak in copy_process()
To:     Christian Brauner <brauner@kernel.org>
CC:     <akpm@linux-foundation.org>, <tglx@linutronix.de>,
        <ebiederm@xmission.com>, <luto@kernel.org>,
        <bigeasy@linutronix.de>, <Liam.Howlett@Oracle.com>,
        <fenghua.yu@intel.com>, <peterz@infradead.org>,
        <viro@zeniv.linux.org.uk>, <jannh@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20221017063406.604188-1-cuigaosheng1@huawei.com>
 <20221017071832.yy7oyhatdszlg3l2@wittgenstein>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <d0ccf66e-da42-6077-d57c-e44a4095ae1b@huawei.com>
Date:   Tue, 18 Oct 2022 10:26:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221017071832.yy7oyhatdszlg3l2@wittgenstein>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This will be released during __fput() when ->release() ==
> pidfd_release() is called so calling put_pid() here will result in UAF
> later on. What syzbot instance does this report come from?
> .

Thanks for taking time to review the patch, kmemleak report this when
I'm doing some kernel tests, unfortunately, I didn't realize that
pidfd_release would release pid. Perhaps there is another reason for this
issue, but I'm not sure now, I will try to prove it.

By the way, do you have any ideas about it? such as "->release() == NULL"?

Thanks very much!

On 2022/10/17 15:18, Christian Brauner wrote:
> On Mon, Oct 17, 2022 at 02:34:06PM +0800, Gaosheng Cui wrote:
>> If CLONE_PIDFD is set in clone_flags, pidfile will hold the reference
>> count of pid by getpid(pid), In the error path bad_fork_put_pidfd, the
>> reference of pid needs to be released, otherwise there will be a
>> memleak issue, fix it.
>>
>> unreferenced object 0xffff888164aed400 (size 224):
>>    comm "sh", pid 75274, jiffies 4295717290 (age 2955.536s)
>>    hex dump (first 32 bytes):
>>      01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
>>      ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
>>    backtrace:
>>      [<00000000bcb9eebb>] kmem_cache_alloc+0x16a/0x7f0
>>      [<00000000340cf9ad>] alloc_pid+0xc5/0xce0
>>      [<000000002387362c>] copy_process+0x29ef/0x6c90
>>      [<00000000bf7d7efc>] kernel_clone+0xd9/0xc70
>>      [<0000000047b1a04f>] __do_sys_clone+0xe1/0x120
>>      [<0000000000f1aa25>] __x64_sys_clone+0xc3/0x150
>>      [<00000000250a19f1>] do_syscall_64+0x5c/0x90
>>      [<000000007e0ac417>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   kernel/fork.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 08969f5aa38d..8706c06be8af 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2499,6 +2499,7 @@ static __latent_entropy struct task_struct *copy_process(
>>   	cgroup_cancel_fork(p, args);
>>   bad_fork_put_pidfd:
>>   	if (clone_flags & CLONE_PIDFD) {
>> +		put_pid(pid);
> This will be released during __fput() when ->release() ==
> pidfd_release() is called so calling put_pid() here will result in UAF
> later on. What syzbot instance does this report come from?
> .
