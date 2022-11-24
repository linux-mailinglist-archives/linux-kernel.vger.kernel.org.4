Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC28637E03
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKXRGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKXRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:06:22 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9072BB0F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:06:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id EC9FA604F6;
        Thu, 24 Nov 2022 18:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669309577; bh=boIlZ77gHTLGxlFpNyhEpY5Bo9Dm7M1zpjHQer6huUI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tBOQd/pKKagDO0YnKWErRx24jJSNULxn1nk/piZV3lXxrGOWSdWpfIHX1sGlfbuot
         XrlRFBjGJ9l9dAk1BwZD/xVTYOExoY9KRw/EwfKlj8eIinri8eIkIMOeM2yGTiQ1TC
         ALfyWJ2oKeHPiwM9mmiij/EcyzFSU5ZeBwqljG2MnTINjgQ4IOb1OhN9DFlypqXANr
         LagioW0b0z1Mgw5PywwlYyYNCVUC1KV4zK9GwED9lqkkuxetoSo8JSwUsZpjeBA18H
         U5aPl3lqhsxWvVay5NpO+aFoUfjaEXruddLxJUy78TMB5qpqRaziG3E0kwnH9LD/fa
         IIIMP/0+4rQcQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V8aWXCngky6J; Thu, 24 Nov 2022 18:06:15 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.243])
        by domac.alu.hr (Postfix) with ESMTPSA id 84F39604F5;
        Thu, 24 Nov 2022 18:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669309575; bh=boIlZ77gHTLGxlFpNyhEpY5Bo9Dm7M1zpjHQer6huUI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V2IAXdNwzBUozUxgZkYJ1v6FEaaECiAS7nhYAGNwq8ulZNXLwA2SNbrZNpHzITJHA
         C+PcK5v+YeIKBtQQYiAejVpVfyus5Q09JPNj1g+yo72cNurruIhO7C+QdaJL2tUw+g
         IPGhHA6oGCt3OVvuv2PrbmUM0kfKqqXggeQuVsOEFhzBgEXAgaVZnozFKffIiQ6/Tq
         CNtHZER/XiRa/JIvT4rUSr+ApLrwuRqE7smQGe3dL/WM6yrJdgIanWFyp3lGk/JhAd
         AZ84HGzXPIkKaDPWFZ+5nF9SynSmptcTeUFapbToRObKwqj5LU6StCjmxFhzzAHT3w
         jEGJYo9hoyVRA==
Message-ID: <d2c392d9-4415-da33-ace7-d73cf64a023c@alu.unizg.hr>
Date:   Thu, 24 Nov 2022 18:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
To:     paulmck@kernel.org, "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
 <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <e8f5b9b3-383a-c267-9ee3-f1e0da5466fc@alu.unizg.hr>
 <20221123144415.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842135518BD1D119E26EDCDAB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221123190932.GF4001@paulmck-ThinkPad-P17-Gen-1>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20221123190932.GF4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 11. 2022. 20:09, Paul E. McKenney wrote:

>>> If you build with (say) CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200, does
>>> this still happen?
>>
>> BTW, you don't need to rebuild the kernel to change those parameters; they're
>> module parameters, so can be modified on the kernel command line (if needed
>> during boot) and sysfs (if only needed after boot).
>>
>> For sysfs the syntax is:
>> #!/bin/bash
>> # set rcu timeouts to specified values
>> echo 60 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
>> echo 21000 > /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
>> echo 600000 > /sys/module/rcupdate/parameters/rcu_task_stall_timeout
>> grep -Hs . /sys/module/rcupdate/parameters/rcu_*_timeout
> 
> Excellent point, thank you!
> 
> I hope that this makes Mirsad's life easier, perhaps featuring less time
> waiting for kernel builds and reboots.  ;-)

Unfortunately, the first stall and NMI occurs before any system script or setting a /sys/module/rcupdate/parameters/*
could be executed, as second 14 of the boot process:

[   14.320045] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 7-.... } 6 jiffies s: 105 root: 0x80/.
[   14.320064] rcu: blocking rcu_node structures (internal RCU debug):
[   14.320070] Sending NMI from CPU 1 to CPUs 7:
[   14.320081] NMI backtrace for cpu 7
[   14.320085] CPU: 7 PID: 532 Comm: modprobe Not tainted 6.1.0-rc6 #1
[   14.320090] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022
[   14.320093] RIP: 0010:find_kallsyms_symbol+0x1ba/0x2e0
[   14.320103] Code: 24 02 84 c0 74 24 3c 2e 48 8b 55 a0 74 1c 48 39 55 b8 0f 82 f8 00 00 00 48 3b 55 c0 0f 86 ee 00 00 00 48 89 55 
c0 44 89 6d ac <41> 83 c5 01 48 83
c3 18 45 39 fd 0f 85 2d ff ff ff 8b 45 ac 4c 8b
[   14.320107] RSP: 0018:ffff88811ab5f4f0 EFLAGS: 00000202
[   14.320113] RAX: 0000000000000000 RBX: ffffffffc1d1429e RCX: ffffffffb1c378e5
[   14.320116] RDX: ffffc900066e11e0 RSI: dffffc0000000000 RDI: ffffffffc1d142a0
[   14.320120] RBP: ffff88811ab5f560 R08: 0000000000000000 R09: ffff88811ab5f670
[   14.320123] R10: ffff88811ab5f90f R11: ffffed102356bf21 R12: ffffffffc1d33bd9
[   14.320126] R13: 0000000000000171 R14: 000000000000005f R15: 00000000000014ed
[   14.320128] FS:  00007f878ce39000(0000) GS:ffff888257380000(0000) knlGS:0000000000000000
[   14.320132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.320135] CR2: 00007f13ac19cae0 CR3: 000000010c73e001 CR4: 0000000000770ee0
[   14.320138] PKRU: 55555554
[   14.320140] Call Trace:
[   14.320142]  <TASK>
[   14.320145]  ? __SCT__tp_func_raid56_scrub_read_recover+0x8/0x8 [btrfs]
[   14.320318]  ? btrfs_free_reserved_bytes+0xe0/0xe0 [btrfs]
[   14.320485]  ? btrfs_show_options+0x860/0x860 [btrfs]
[   14.320647]  ? btrfs_free_reserved_bytes+0xe0/0xe0 [btrfs]
[   14.320816]  module_address_lookup+0x7a/0xc0
[   14.320822]  ? btrfs_free_reserved_bytes+0xe0/0xe0 [btrfs]
[   14.320987]  kallsyms_lookup_buildid+0x172/0x200
[   14.320993]  ? do_kernel_range_flush+0x60/0x60
[   14.321002]  kallsyms_lookup+0x14/0x20
[   14.321007]  test_for_valid_rec.isra.38+0x95/0x110
[   14.321015]  ? remove_direct_functions_hash.isra.37+0x1c0/0x1c0
[   14.321021]  ? _find_next_bit+0x42/0xe0
[   14.321037]  ? __kasan_check_write+0x14/0x20
[   14.321043]  ? mutex_lock+0x8f/0xe0
[   14.321049]  ? __mutex_lock_slowpath+0x20/0x20
[   14.321056]  ? btrfs_free_reserved_bytes+0xe0/0xe0 [btrfs]
[   14.321220]  ftrace_module_enable+0x15f/0x460
[   14.321228]  load_module+0x323e/0x3800
[   14.321233]  ? __kernel_read+0x304/0x450
[   14.321246]  ? module_frob_arch_sections+0x40/0x40
[   14.321252]  ? security_kernel_post_read_file+0x6d/0x80
[   14.321259]  ? __kasan_check_write+0x14/0x20
[   14.321264]  ? kernel_read_file+0x20a/0x490
[   14.321270]  ? __kasan_check_read+0x11/0x20
[   14.321275]  ? __fget_light+0xb6/0x220
[   14.321283]  __do_sys_finit_module+0x131/0x1d0
[   14.321288]  ? __do_sys_finit_module+0x131/0x1d0
[   14.321293]  ? __ia32_sys_init_module+0x50/0x50
[   14.321297]  ? vm_mmap_pgoff+0x1a8/0x240
[   14.321307]  ? __kasan_check_write+0x14/0x20
[   14.321311]  ? fput+0x1d/0xd0
[   14.321317]  __x64_sys_finit_module+0x43/0x50
[   14.321322]  do_syscall_64+0x58/0x80
[   14.321330]  ? exit_to_user_mode_prepare+0x32/0x190
[   14.321337]  ? syscall_exit_to_user_mode+0x1b/0x30
[   14.321343]  ? do_syscall_64+0x67/0x80
[   14.321348]  ? fpregs_assert_state_consistent+0x5e/0x70
[   14.321356]  ? exit_to_user_mode_prepare+0x32/0x190
[   14.321362]  ? syscall_exit_to_user_mode+0x1b/0x30
[   14.321367]  ? do_syscall_64+0x67/0x80
[   14.321372]  ? syscall_exit_to_user_mode+0x1b/0x30
[   14.321377]  ? do_syscall_64+0x67/0x80
[   14.321382]  ? do_syscall_64+0x67/0x80
[   14.321388]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   14.321397] RIP: 0033:0x7f878c51ea3d
[   14.321401] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
73 01 c3 48 8b 0d c3 a3 0f 00 f7 d8 64 89 01 48
[   14.321405] RSP: 002b:00007ffd078d4c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   14.321410] RAX: ffffffffffffffda RBX: 0000558c0d8830a0 RCX: 00007f878c51ea3d
[   14.321414] RDX: 0000000000000000 RSI: 0000558c0d6fdcd2 RDI: 0000000000000005
[   14.321417] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[   14.321419] R10: 0000000000000005 R11: 0000000000000246 R12: 0000558c0d6fdcd2
[   14.321422] R13: 0000558c0d883060 R14: 0000558c0d8824f0 R15: 0000558c0d88f5d0
[   14.321428]  </TASK>

Probably something sensible should be set in the case of KASAN build. This example of stall
apparently has nothing to do with squashfs_readahead().

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

