Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B516466EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHCX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLHCXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:23:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72FD8E59A;
        Wed,  7 Dec 2022 18:23:45 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSHxT4LqpzmWRx;
        Thu,  8 Dec 2022 10:22:53 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 10:23:10 +0800
Message-ID: <be3be4d6-b752-6ed2-9b19-9686186a09e7@huawei.com>
Date:   Thu, 8 Dec 2022 10:23:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 00/13] leds: Fix devm vs. non-devm ordering
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <Y5D1d3WhLCpmfo+N@duo.ucw.cz>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <Y5D1d3WhLCpmfo+N@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/8 4:20, Pavel Machek 写道:
> Hi!
> 
>> Fault-inject tests reports this issue:
>>
>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> WARNING: CPU: 2 PID: 52 at kernel/locking/mutex.c:582 __mutex_lock+0x1366/0x15b0
>> Call Trace:
> 
> Ok, so:
> 
> a) this does not happen in wild
> 
> b) you have not actually tested any of this
> 

Hi!

Sorry, I don't have an actual device, I tested it with bpf mock device. 
During the test on leds_cr0014114, the following issue occurs:

root@syzkaller:~# python3 -m kddv.cmds.test 
kddv.tests.leds.test_cr0014114.TestCR0014114
test_device_probe (kddv.tests.leds.test_cr0014114.TestCR0014114) ... [ 
61.307831] SPI driver leds_cr0014114 has no spi_device_id for 
crane,cr0014114
[   77.660222] ------------[ cut here ]------------
[   77.660822] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[   77.660860] WARNING: CPU: 0 PID: 95 at kernel/locking/mutex.c:582 
__mutex_lock+0x1366/0x15b0
[   77.662518] Modules linked in: leds_cr0014114 rtc_cmos
[   77.663190] CPU: 0 PID: 95 Comm: kworker/0:2 Tainted: G 
   N 6.1.0-rc6+ #59 b2d6fc177d3c6952297e89bfb954a5133622046e
[   77.664587] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   77.665760] Workqueue: events set_brightness_delayed
[   77.666428] RIP: 0010:__mutex_lock+0x1366/0x15b0
[   77.667035] Code: e8 fc 30 88 e8 3b ed 8a fe 8b 15 cd d6 eb 01 85 d2 
0f 85 9b ed ff ff 48 c7 c6 40 98 a6 86 48 c7 c7 c0 96 a6 86 e8 d3 e2 f4 
ff <0f> 0b e9 81 ed ff ff e8 0e 42 ff ff 85 c0 0f 84 b7 fe ff ff 80 3d
[   77.669233] RSP: 0018:ffff88810bbbfba0 EFLAGS: 00010282
[   77.669876] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   77.670750] RDX: ffff88810bba3600 RSI: 0000000000000000 RDI: 
ffffed1021777f66
[   77.671628] RBP: ffff88810bbbfce0 R08: ffffffff8492d14f R09: 
ffffed1023604efa
[   77.672503] R10: ffff88811b0277cb R11: ffffed1023604ef9 R12: 
ffff888111a7a0e8
[   77.673376] R13: 0000000000000000 R14: ffff88811b038a20 R15: 
ffff88811b0389c0
[   77.674258] FS:  0000000000000000(0000) GS:ffff88811b000000(0000) 
knlGS:0000000000000000
[   77.675250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.675969] CR2: 00007fc05d4229d0 CR3: 0000000109ba4003 CR4: 
0000000000370ef0
[   77.676828] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   77.677706] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   77.678579] Call Trace:
[   77.678913]  <TASK>
[   77.679200]  ? cr0014114_set_sync+0x2d/0x80 [leds_cr0014114 
04aa6b9a9c145895781b235c6c924b67f752bc72]
[   77.680324]  ? mutex_lock_io_nested+0x13d0/0x13d0
[   77.680930]  ? lock_acquire+0x175/0x410
[   77.681422]  ? lock_is_held_type+0xd7/0x130
[   77.681975]  ? cr0014114_set_sync+0x2d/0x80 [leds_cr0014114 
04aa6b9a9c145895781b235c6c924b67f752bc72]
[   77.683103]  cr0014114_set_sync+0x2d/0x80 [leds_cr0014114 
04aa6b9a9c145895781b235c6c924b67f752bc72]
[   77.684214]  ? cr0014114_sync+0x360/0x360 [leds_cr0014114 
04aa6b9a9c145895781b235c6c924b67f752bc72]
[   77.685326]  set_brightness_delayed+0xc5/0x140
[   77.685919]  process_one_work+0x654/0xc30
[   77.686436]  ? pwq_dec_nr_in_flight+0x140/0x140
[   77.687046]  ? rwlock_bug.part.0+0x50/0x50
[   77.687576]  worker_thread+0x30b/0x820
[   77.688076]  ? preempt_count_sub+0xf/0xc0
[   77.688599]  ? process_one_work+0xc30/0xc30
[   77.689149]  kthread+0x1a2/0x1e0
[   77.689575]  ? kthread_complete_and_exit+0x40/0x40
[   77.690202]  ret_from_fork+0x22/0x30
[   77.690679]  </TASK>
[   77.691005] irq event stamp: 25531
[   77.691435] hardirqs last  enabled at (25531): [<ffffffff8645deaf>] 
_raw_spin_unlock_irq+0x1f/0x50
[   77.692533] hardirqs last disabled at (25530): [<ffffffff8645dc61>] 
_raw_spin_lock_irq+0x41/0x50
[   77.693605] softirqs last  enabled at (25522): [<ffffffff868003dc>] 
__do_softirq+0x3dc/0x58d
[   77.694644] softirqs last disabled at (25517): [<ffffffff848d3ad3>] 
irq_exit_rcu+0xd3/0x100
[   77.695672] ---[ end trace 0000000000000000 ]---


After patch "leds: cr0014114: Fix devm vs. non-devm ordering" is 
installed, the test is successful.

root@syzkaller:~# python3 -m kddv.cmds.test 
kddv.tests.leds.test_cr0014114.TestCR0014114
test_device_probe (kddv.tests.leds.test_cr0014114.TestCR0014114) ... [ 
216.419070] SPI driver leds_cr0014114 has no spi_device_id for 
crane,cr0014114
ok


The bpf mock device test tool is provided by Yongjun. Currently, some of 
the tools have been submitted to the community 
(https://lwn.net/Articles/906236/). The whole test set is still in the 
preliminary validation phase, will send to the community after the 
further verification.

By the way, here's an introduction to the tool, but now only in Chinese:
https://github.com/ChinaLinuxKernel/CLK2022/blob/main/%E5%9F%BA%E4%BA%8EeBPF%E7%9A%84%E8%AE%BE%E5%A4%87%E9%A9%B1%E5%8A%A8%E6%B5%8B%E8%AF%95%E6%A1%86%E6%9E%B6.pdf

Thanks,
Wang

> ?
> 
> It looks reasonable, but the "Fixes:" tags mean -stable will pick this
> up almost immediately.
> 
> Is anyone else willing to say this looks ok to him?
> 
> Any testers?
> 
> Best regards,
> 								Pavel
