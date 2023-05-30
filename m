Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5812E7162C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjE3N5K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjE3N5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:57:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A5D9;
        Tue, 30 May 2023 06:57:05 -0700 (PDT)
Received: from dggpeml100026.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QVv570mwMzLq8h;
        Tue, 30 May 2023 21:54:03 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggpeml100026.china.huawei.com (7.185.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 21:57:01 +0800
Received: from dggpeml500020.china.huawei.com ([7.185.36.88]) by
 dggpeml500020.china.huawei.com ([7.185.36.88]) with mapi id 15.01.2507.023;
 Tue, 30 May 2023 21:57:01 +0800
From:   "jiangheng (G)" <jiangheng14@huawei.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        shaozhengchao <shaozhengchao@huawei.com>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG REPORT] softlock up in net/core cleanup_net
Thread-Topic: [BUG REPORT] softlock up in net/core cleanup_net
Thread-Index: AdmS/oB2zuwwtRmFQNyBzJRXz7YUCQ==
Date:   Tue, 30 May 2023 13:57:01 +0000
Message-ID: <d2b08adaa6654692a15b57c9cbbc0bd7@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.117.195]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
on linux 5.10,  we want to use docker interactively when testing an internal feature. When docker restarts the container, it will call cleanup_net and a crash will occur.

[  843.330515] CPU: 0 PID: 158 Comm: kworker/u8:2 Kdump: loaded Tainted: G    B      OEL    #1 [  843.330516] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015 [  843.330523] Workqueue: netns cleanup_net [  843.330526] pstate: 60400085 (nZCv daIf +PAN -UAO -TCO BTYPE=--) [  843.330529] pc : machine_kexec+0x48/0x2b0 [  843.330531] lr : machine_kexec+0x48/0x2b0 [  843.330531] sp : ffff80010284bb10 [  843.330533] x29: ffff80010284bb10 x28: ffff0000ff851cf8 [  843.330535] x27: ffff0000ff851d78 x26: ffff80010284bda0 [  843.330537] x25: ffff800101d9c000 x24: 0000000000000001 [  843.330539] x23: ffff800101d9c650 x22: ffff800101eb6000 [  843.330541] x21: ffff800101eb6000 x20: ffff0000cba23c00 [  843.330543] x19: ffff0000cba23c00 x18: 0000000000000020 [  843.330545] x17: 0000000000000000 x16: ffff800100d27a3c [  843.330548] x15: ffffffffffffffff x14: 0000000060000085 [  843.330550] x13: ffff8001001c090c x12: 0000000000000040 [  843.330552] x11: ffff800101aad158 x10: 00000000ffff8000 [  843.330554] x9 : ffff800100157654 x8 : 0000000000000000 [  843.330556] x7 : ffff8001017ed158 x6 : 0000000000017ffd [  843.330559] x5 : ffff0000ff84b410 x4 : ffff80010284b910 [  843.330561] x3 : 0000000000000001 x2 : 0000000000000000 [  843.330563] x1 : 0000000000000000 x0 : ffff0000c09eb9c0 [  843.330566] Call trace:
[  843.330569]  machine_kexec+0x48/0x2b0 [  843.330573]  __crash_kexec+0x90/0x13c [  843.330578]  panic+0x314/0x4d8 [  843.330582]  watchdog_timer_fn+0x26c/0x2f0 [  843.330585]  __run_hrtimer+0x98/0x2b4 [  843.330586]  __hrtimer_run_queues+0xbc/0x130 [  843.330588]  hrtimer_interrupt+0x150/0x3e4 [  843.330592]  arch_timer_handler_virt+0x3c/0x50 [  843.330596]  handle_percpu_devid_irq+0x90/0x1f4
[  843.330599]  __handle_domain_irq+0x84/0x100 [  843.330601]  gic_handle_irq+0x88/0x2b0 [  843.330603]  el1_irq+0xb8/0x140 [  843.330605]  smp_call_function_single+0x1b8/0x1dc
[  843.330608]  rcu_barrier+0x1c4/0x2d0
[  843.330612]  netdev_run_todo+0x7c/0x330 [  843.330615]  rtnl_unlock+0x18/0x24 [  843.330616]  default_device_exit_batch+0x15c/0x190
[  843.330621]  ops_exit_list+0x70/0x84
[  843.330622]  cleanup_net+0x184/0x2e0
[  843.330625]  process_one_work+0x1d4/0x4bc [  843.330627]  worker_thread+0x150/0x400 [  843.330629]  kthread+0x108/0x134 [  843.330631]  ret_from_fork+0x10/0x18 [  843.330633] ---[ end trace 8378c01c76c90cc4 ]--- [  843.330637] Bye!

Crash:bt -l
PID: 158    TASK: ffff0000c09eb9c0  CPU: 0   COMMAND: "kworker/u8:2"
PID: 158    TASK: ffff0000c09eb9c0  CPU: 0   COMMAND: "kworker/u8:2"
bt: invalid kernel virtual address: 0  type: "IRQ stack contents"
bt: read of IRQ stack at 0 failed
#0 [ffff80010284bb60] __crash_kexec at ffff8001001c0908
    /usr/src/debug/kernel/./arch/arm64/include/asm/kexec.h: 57
#1 [ffff80010284bcf0] panic at ffff800100d256a4
    /usr/src/debug/kernel/kernel/panic.c: 392
#2 [ffff80010284bde0] watchdog_timer_fn at ffff80010020a5c8
    /usr/src/debug/kernel/kernel/watchdog.c: 578
#3 [ffff80010284be30] __run_hrtimer at ffff800100191d24
    /usr/src/debug/kernel/kernel/time/hrtimer.c: 1586
#4 [ffff80010284be80] __hrtimer_run_queues at ffff800100191ffc
    /usr/src/debug/kernel/kernel/time/hrtimer.c: 1650
#5 [ffff80010284bee0] hrtimer_interrupt at ffff80010019267c
    /usr/src/debug/kernel/kernel/time/hrtimer.c: 1712
#6 [ffff80010284bf50] arch_timer_handler_virt at ffff800100aa9a38
    /usr/src/debug/kernel/drivers/clocksource/arm_arch_timer.c: 674
#7 [ffff80010284bf60] handle_percpu_devid_irq at ffff80010016500c
    /usr/src/debug/kernel/./arch/arm64/include/asm/percpu.h: 45
#8 [ffff80010284bf90] __handle_domain_irq at ffff80010015b840
    /usr/src/debug/kernel/./include/linux/irqdesc.h: 153
#9 [ffff80010284bfd0] gic_handle_irq at ffff800100010144
    /usr/src/debug/kernel/./include/linux/irqdesc.h: 171
--- <IRQ stack> ---
#10 [ffff800102d4bb20] el1_irq at ffff800100012374
    /usr/src/debug/kernel/arch/arm64/kernel/entry.S: 672
#11 [ffff800102d4bb40] smp_call_function_single at ffff8001001b1e68
    /usr/src/debug/kernel/./arch/arm64/include/asm/cmpxchg.h: 278
#12 [ffff800102d4bba0] rcu_barrier at ffff800100178ba0
    /usr/src/debug/kernel/kernel/rcu/tree.c: 3920
#13 [ffff800102d4bc00] netdev_run_todo at ffff800100b3f768
    /usr/src/debug/kernel/net/core/dev.c: 10313
#14 [ffff800102d4bc80] rtnl_unlock at ffff800100b4cb54
    /usr/src/debug/kernel/net/core/rtnetlink.c: 114
#15 [ffff800102d4bc90] default_device_exit_batch at ffff800100b378d8
    /usr/src/debug/kernel/net/core/dev.c: 11287
#16 [ffff800102d4bd00] ops_exit_list at ffff800100b2337c
    /usr/src/debug/kernel/net/core/net_namespace.c: 200
#17 [ffff800102d4bd30] cleanup_net at ffff800100b25ab0
    /usr/src/debug/kernel/net/core/net_namespace.c: 616
#18 [ffff800102d4bd90] process_one_work at ffff8001000de784
    /usr/src/debug/kernel/kernel/workqueue.c: 2354
#19 [ffff800102d4bdf0] worker_thread at ffff8001000df18c
    /usr/src/debug/kernel/kernel/workqueue.c: 2500
#20 [ffff800102d4be50] kthread at ffff8001000e75a4
    /usr/src/debug/kernel/kernel/kthread.c: 313

The above backtrace seems to be caused func:netdev_run_todo() that the size of list not null.
void netdev_run_todo(void)
{
         struct net_device *dev, *tmp;
         struct list_head list;
#ifdef CONFIG_LOCKDEP
         struct list_head unlink_list;

         list_replace_init(&net_unlink_list, &unlink_list);

         while (!list_empty(&unlink_list)) {
                   struct net_device *dev = list_first_entry(&unlink_list,
                                                    struct net_device,
                                               unlink_list);
                   list_del_init(&dev->unlink_list);
                   dev->nested_level = dev->lower_level - 1;
         }
#endif

         /* Snapshot list, allow later requests */
         list_replace_init(&net_todo_list, &list);

         __rtnl_unlock();

         /* Wait for rcu callbacks to finish before next phase */
         if !(list_empty(&list))
                   rcu_barrier();

I wonder if softlockup is due to the above code? Please help analyze the possible causes of this.

