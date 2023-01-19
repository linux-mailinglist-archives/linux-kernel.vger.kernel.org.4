Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6367479B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjASX5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjASX5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:57:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC5B8F7E1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:57:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9074961D68
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1779FC433EF;
        Thu, 19 Jan 2023 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674172668;
        bh=FeLVo59dqGE3rXlrecXdsY0Kas2wiEpnrbJdfhsDyDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tkcmkV0qjx3HWbI5YthHGDXYsq+97776YcPPTx0iDHV0VFWXoV8oCJUZn7x9OkucD
         toqr26v8VYaQ6EeZ+PAzHqHhcQ/JVRXFDb/ihqM2GLsTpoUpXLB945gI9XzLXvMjf4
         sGJLOcut7aNvt5b7tTDJr56fcwt1dLxKDyMmIr/E8qao5HGY81hc0rXHSHdFVoYfNa
         /Dmvc/WN+QHSfhsW/Fo4zPkNWT+eDgA9yeV4xzxeyHI+EKH1efrhJkJJpDGG4mvbgB
         HmN4gFfZz5y1d2X3DjVhYeY7RKxHdBfCb8VdA2ijDhDkC9zCn2wj6Wnp+h3QPyF0lp
         4uJqOB81Ibokw==
Date:   Fri, 20 Jan 2023 08:57:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "register_kprobe" WARNING in
 v6.2-rc3 mainline kernel
Message-Id: <20230120085745.6979331f54bc133f38c12a5b@kernel.org>
In-Reply-To: <Y8URdIfVr3pq2X8w@xpf.sh.intel.com>
References: <Y8URdIfVr3pq2X8w@xpf.sh.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:57:24 +0800
Pengfei Xu <pengfei.xu@intel.com> wrote:

> Hi Masami Hiramatsu,
> 
> There is "register_kprobe" WARNING in v6.2-rc3 in guest.
> [  120.736243] ------------[ cut here ]------------
> [  120.736691] WARNING: CPU: 0 PID: 366 at kernel/kprobes.c:589 kprobe_optimizer+0x26b/0x400
> [  120.737161] Modules linked in:
> [  120.737339] CPU: 0 PID: 366 Comm: kworker/0:7 Not tainted 6.2.0-rc3-b7bfaa761d76 #1
> [  120.737831] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  120.738416] Workqueue: events kprobe_optimizer
> [  120.738683] RIP: 0010:kprobe_optimizer+0x26b/0x400
> [  120.739026] Code: c3 ff ff 4c 8b 25 25 28 b5 02 4d 8b 2c 24 49 8d 5c 24 80 4d 8d 75 80 49 81 fc f0 7e e1 83 75 2f e9 a9 00 00 00 e8 75 c3 ff ff <0f> 0b e8 6e c
> [  120.740035] RSP: 0018:ffffc90000ebfe10 EFLAGS: 00010246
> [  120.740394] RAX: 0000000000000000 RBX: ffff88800d094180 RCX: ffffffff812c5752
> [  120.740763] RDX: 0000000000000000 RSI: ffff88800eed8000 RDI: 0000000000000002
> [  120.741129] RBP: ffffc90000ebfe38 R08: 0000000000000001 R09: 0000000000000001
> [  120.741552] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [  120.741953] R13: ffffffff83e17ef0 R14: ffffffff83e17e70 R15: ffff88807dc3a400
> [  120.742319] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [  120.742778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  120.743125] CR2: 00007ffff951d3f8 CR3: 00000000131bc006 CR4: 0000000000770ef0
> [  120.743503] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  120.743868] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [  120.744339] PKRU: 55555554
> [  120.744495] Call Trace:
> [  120.744633]  <TASK>
> [  120.744764]  process_one_work+0x3b1/0x960
> [  120.745002]  worker_thread+0x52/0x660
> [  120.745228]  ? __pfx_worker_thread+0x10/0x10
> [  120.745536]  kthread+0x161/0x1a0
> [  120.745748]  ? __pfx_kthread+0x10/0x10
> [  120.745968]  ret_from_fork+0x29/0x50
> [  120.746192]  </TASK>
> [  120.746321] irq event stamp: 71069
> [  120.746523] hardirqs last  enabled at (71077): [<ffffffff811d4891>] __up_console_sem+0x91/0xb0
> [  120.747078] hardirqs last disabled at (71084): [<ffffffff811d4876>] __up_console_sem+0x76/0xb0
> [  120.747529] softirqs last  enabled at (70986): [<ffffffff82f9d213>] __do_softirq+0x323/0x48a
> [  120.748051] softirqs last disabled at (71101): [<ffffffff81123142>] irq_exit_rcu+0xd2/0x100
> [  120.748562] ---[ end trace 0000000000000000 ]---
> [  149.825325] ------------[ cut here ]------------
> [  149.825894] WARNING: CPU: 0 PID: 2872 at kernel/kprobes.c:777 register_kprobe+0x9a2/0x9b0
> [  149.826370] Modules linked in:
> [  149.826548] CPU: 0 PID: 2872 Comm: repro Tainted: G        W          6.2.0-rc3-b7bfaa761d76 #1
> [  149.827010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  149.827602] RIP: 0010:register_kprobe+0x9a2/0x9b0
> [  149.827874] Code: 4d 89 74 24 08 e8 de 91 ff ff 45 89 ec 48 b8 22 01 00 00 00 00 ad de 48 89 43 08 e8 48 e4 f3 ff e9 d2 fd ff ff e8 be 91 ff ff <0f> 0b e9 4e 0
> [  149.828872] RSP: 0018:ffffc90001aafc40 EFLAGS: 00010246
> [  149.829162] RAX: 0000000000000000 RBX: ffff88800cefeb18 RCX: ffffffff812c86ba
> [  149.829541] RDX: 0000000000000000 RSI: ffff88801324a340 RDI: 0000000000000002
> [  149.829924] RBP: ffffc90001aafc88 R08: 0000000000000001 R09: 0000000000000001
> [  149.830311] R10: ffffc90001aafc30 R11: 0000000000000001 R12: 0000000000000000
> [  149.830697] R13: ffff88800d0949c0 R14: ffff88800cefeb28 R15: 0000000000000002
> [  149.831089] FS:  00007fdc0d3c9740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [  149.831525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  149.831844] CR2: 00007fdc0d5841d3 CR3: 000000000d70c006 CR4: 0000000000770ef0
> [  149.832260] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  149.832637] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [  149.833021] PKRU: 55555554
> [  149.833179] Call Trace:
> [  149.833323]  <TASK>
> [  149.833458]  ? knl_uncore_pci_init+0x9/0x90
> [  149.833712]  ? knl_uncore_pci_init+0x9/0x90
> [  149.833959]  __register_trace_kprobe+0x183/0x190
> [  149.834241]  create_local_trace_kprobe+0x107/0x190
> [  149.834519]  perf_kprobe_init+0xa7/0x160
> [  149.834753]  perf_kprobe_event_init+0x98/0x120
> [  149.835024]  perf_try_init_event+0x88/0x280
> [  149.835274]  perf_event_alloc+0xf0a/0x1c50
> [  149.835514]  ? __do_sys_perf_event_open+0x9ca/0x1870
> [  149.835805]  ? __this_cpu_preempt_check+0x20/0x30
> [  149.836102]  __do_sys_perf_event_open+0x3b6/0x1870
> [  149.836388]  ? knl_uncore_pci_init+0x9/0x90
> [  149.836636]  __x64_sys_perf_event_open+0x2f/0x40
> [  149.836905]  do_syscall_64+0x3b/0x90
> [  149.837115]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  149.837417] RIP: 0033:0x7fdc0d4ee59d
> [  149.837630] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> [  149.838602] RSP: 002b:00007ffff951d3f8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [  149.839036] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdc0d4ee59d
> [  149.839420] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200002c0
> [  149.839800] RBP: 00007ffff951d410 R08: 0000000000000000 R09: 00007ffff951d410
> [  149.840203] R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004011a0
> [  149.840593] R13: 00007ffff951d530 R14: 0000000000000000 R15: 0000000000000000
> [  149.840984]  </TASK>
> [  149.841120] irq event stamp: 1631
> [  149.841303] hardirqs last  enabled at (1639): [<ffffffff811d4891>] __up_console_sem+0x91/0xb0
> [  149.841825] hardirqs last disabled at (1646): [<ffffffff811d4876>] __up_console_sem+0x76/0xb0
> [  149.842279] softirqs last  enabled at (1304): [<ffffffff82f9d213>] __do_softirq+0x323/0x48a
> [  149.842723] softirqs last disabled at (1295): [<ffffffff81123142>] irq_exit_rcu+0xd2/0x100
> [  149.843179] ---[ end trace 0000000000000000 ]---
> 
> Bisect and found that bad commit is:
> 63dc6325ff41ee9e570bde705ac34a39c5dbeb44
> x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK

Oops, thanks for reporting. Let me check why this happened.


> 
> After reverted the above commit on top of v6.2-rc3 kernel, this issue was gone.
> 
> The reproduced code, kconfig, bisect info, and v6.2-rc3 reproduced log are in
> attached email.
> 
> And all the detailed logs are in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/230113_100005_register_kprobe

Great, thanks!

> 
> I hope it's helpful.
> 
> Thanks!
> BR.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
