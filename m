Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E06AD954
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCGIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCGIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:36:47 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35C4D62B;
        Tue,  7 Mar 2023 00:36:45 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9648024E023;
        Tue,  7 Mar 2023 16:36:43 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 16:36:43 +0800
Received: from [192.168.125.124] (183.27.97.46) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 16:36:42 +0800
Message-ID: <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
Date:   Tue, 7 Mar 2023 16:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230221024645.127922-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 10:46:26 +0800, Hal Feng wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC. Patch 17 depends on series [1] which provides pinctrl
> dt-bindings. Patch 19 depends on series [2] which provides dt-bindings
> of VisionFive 2 board and JH7110 SoC.
> 
> You can simply review or test the patches at the link [3].
> 
> [1]: https://lore.kernel.org/all/20230209143702.44408-1-hal.feng@starfivetech.com/
> [2]: https://lore.kernel.org/all/20230216131511.3327943-1-conor.dooley@microchip.com/
> [3]: https://github.com/hal-feng/linux/commits/visionfive2-minimal

Hi Conor,

When I tried to rebase these patches on v6.3-rc1, I found the kernel
would crash on the VisionFive 2 board during startup. The logs are as
below. I checkout the branch to the mainline and found that the kernel
would also crash on the VisionFive board which is equipped with JH7100
SoC.

--------------------------------
Unable to handle kernel paging request at virtual address 0000004cccccccd4
Oops [#1]
Modules linked in:
CPU: 3 PID: 87 Comm: udevd Not tainted 6.3.0-rc1-00019-g239e7809f291 #305
Hardware name: StarFive VisionFive 2 v1.3B (DT)
epc : enqueue_timer+0x18/0x90
 ra : internal_add_timer+0x2c/0x38
epc : ffffffff8006a714 ra : ffffffff8006a7b8 sp : ffffffc80443bc80
 gp : ffffffff80eb5100 tp : ffffffd8c01db200 t0 : 0000000000000000
 t1 : 000000000000000f t2 : 0000000038b3ea28 s0 : ffffffc80443bcb0
 s1 : ffffffff80813940 a0 : ffffffff80813940 a1 : ffffffc80443bd48
 a2 : 000000000000020b a3 : cccccccd0b000000 a4 : cccccccccccccccc
 a5 : 000000000000020b a6 : ffffffff80814a08 a7 : 0000000000000001
 s2 : ffffffc80443bd48 s3 : 0000000008400040 s4 : ffffffff80813940
 s5 : ffffffff80eea0b8 s6 : ffffffff80eb7220 s7 : 0000000000000040
 s8 : ffffffff80eb61e0 s9 : 0000002ac84a2548 s10: 0000002ad53e92c0
 s11: 0000000000000001 t3 : 000000000000003f t4 : 0000000000000000
 t5 : 0000000000000004 t6 : 0000000000000003
status: 0000000200000100 badaddr: 0000004cccccccd4 cause: 000000000000000f
[<ffffffff8006a714>] enqueue_timer+0x18/0x90
[<ffffffff8006aa64>] add_timer_on+0xf0/0x134
[<ffffffff80500f18>] try_to_generate_entropy+0x1ec/0x232
[<ffffffff8035a636>] urandom_read_iter+0x42/0xc2
[<ffffffff800fff16>] vfs_read+0x17c/0x1e4
[<ffffffff801005b6>] ksys_read+0x78/0x98
[<ffffffff801005e4>] sys_read+0xe/0x16
[<ffffffff800035dc>] ret_from_syscall+0x0/0x2
Code: 9381 9713 0037 0813 0705 983a 3703 0008 e198 c311 (e70c) d713 
---[ end trace 0000000000000000 ]---
note: udevd[87] exited with irqs disabled
Segmentation fault
FAIL
Saving random seed: 
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: 	1-...0: (0 ticks this GP) idle=19c4/1/0x4000000000000000 softirq=42/42 fqs=7474
rcu: 	(detected by 2, t=15005 jiffies, g=-195, q=35 ncpus=4)
Task dump for CPU 1:
task:dd              state:R  running task     stack:0     pid:92    ppid:88     flags:0x00000008
Call Trace:
[<ffffffff80003764>] ret_from_fork+0x0/0xc
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: 	1-...0: (0 ticks this GP) idle=19c4/1/0x4000000000000000 softirq=42/42 fqs=29814
rcu: 	(detected by 2, t=60018 jiffies, g=-195, q=35 ncpus=4)
Task dump for CPU 1:
task:dd              state:R  running task     stack:0     pid:92    ppid:88     flags:0x00000008
Call Trace:
[<ffffffff80003764>] ret_from_fork+0x0/0xc
...
--------------------------------

I used 'git bisect' and found out the commit 9493e6f3ce02 is the
cause. I tried to revert this commit on the tag v6.3-rc1, but it
seems there is no improvement.

Any options I am missing? Could you please give me some suggestions
to adapt to the new changes between 6.2 and 6.3? Thank you in
advance.

Best regards,
Hal
