Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC055FFECE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJPLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJPLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 07:08:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F5F33E23
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 04:08:56 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ok1Vm-0004V4-1l; Sun, 16 Oct 2022 13:08:54 +0200
Message-ID: <e2cf3207-e9e9-5585-1a6e-9b39d96b4b54@leemhuis.info>
Date:   Sun, 16 Oct 2022 13:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
Cc:     Denis Chancogne <denis.chancogne@free.fr>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 216581 - Kernel panic on /init as busybox symbolic link with xen
 efi
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665918536;798a69f5;
X-HE-SMSGID: 1ok1Vm-0004V4-1l
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216581 :

>  Denis Chancogne 2022-10-13 22:00:19 UTC
> 
> Created attachment 302995 [details]
> /proc/cpuinfo, .config
> 
> Hi,
> 
> when I start Xen 4.15.3 in efi with kernel 5.18.19, all works well;
> but since kernel 5.19, I have a kernel panic on my /init process as
> busybox symbolic link inside initramfs.
> 
> This is the kernel log :
> ...
> [    6.265122] Run /init as init process
> [    6.266027] traps: init[1] trap invalid opcode ip:5855d1 sp:7ffe5ceddeb0 error:0 in busybox[401000+1db000]
> [    6.266553] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> [    6.267039] CPU: 3 PID: 1 Comm: init Tainted: G        W         5.19.0-dch #1
> [    6.267522] Hardware name: Micro-Star International Co., Ltd. MS-7B84/B450M PRO-M2 (MS-7B84), BIOS 2.E0 06/12/2020
> [    6.268010] Call Trace:
> [    6.268495]  <TASK>
> [    6.268974]  dump_stack_lvl+0x45/0x5e
> [    6.269455]  panic+0x107/0x285
> [    6.269923]  do_exit.cold+0x15/0x45
> [    6.270389]  do_group_exit+0x28/0x90
> [    6.270852]  get_signal+0x9f1/0xa40
> [    6.271313]  arch_do_signal_or_restart+0x57/0x7b0
> [    6.271771]  ? _raw_spin_unlock+0x10/0x30
> [    6.272223]  ? finish_task_switch.isra.0+0x8e/0x270
> [    6.272674]  ? __switch_to+0x186/0x400
> [    6.273118]  exit_to_user_mode_prepare+0xc8/0x150
> [    6.273564]  irqentry_exit_to_user_mode+0x5/0x20
> [    6.274003]  asm_exc_invalid_op+0x16/0x20
> [    6.274441] RIP: 0033:0x5855d1
> [    6.274877] Code: f6 48 89 ef e8 90 79 03 00 48 c7 05 cd 2e 0c 00 01 00 00 00 48 89 2d 26 a2 0c 00 4c 8d 74 24 20 4c 8d 6c 24 40 4c 8d 64 24 18 <c5> f9 ef c0 48 b8 f6 75 ae 03 01 00 00 00 4c 8d 3d 8c 02 0a 00 c5
> [    6.275776] RSP: 002b:00007ffe5ceddeb0 EFLAGS: 00010202
> [    6.276221] RAX: 0000000000000000 RBX: 00000000004006c8 RCX: 0000000000000001
> [    6.276670] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000648400
> [    6.277116] RBP: 00000000009e0060 R08: 00007ffe5cfdf178 R09: 00000000effffef5
> [    6.277561] R10: 0000000070000022 R11: 0000000000000032 R12: 00007ffe5ceddec8
> [    6.278003] R13: 00007ffe5ceddef0 R14: 00007ffe5cedded0 R15: 000000006ffffeff
> [    6.278442]  </TASK>
> [    6.278903] Kernel Offset: disabled
> 
> I try to decode it :
> 
> All code
> ========
>    0:   f6 48 89 ef             testb  $0xef,-0x77(%rax)
>    4:   e8 90 79 03 00          call   0x37999
>    9:   48 c7 05 cd 2e 0c 00    movq   $0x1,0xc2ecd(%rip)        # 0xc2ee1
>   10:   01 00 00 00 
>   14:   48 89 2d 26 a2 0c 00    mov    %rbp,0xca226(%rip)        # 0xca241
>   1b:   4c 8d 74 24 20          lea    0x20(%rsp),%r14
>   20:   4c 8d 6c 24 40          lea    0x40(%rsp),%r13
>   25:   4c 8d 64 24 18          lea    0x18(%rsp),%r12
>   2a:*  c5 f9 ef c0             vpxor  %xmm0,%xmm0,%xmm0                <-- trapping instruction
>   2e:   48 b8 f6 75 ae 03 01    movabs $0x103ae75f6,%rax
>   35:   00 00 00 
>   38:   4c 8d 3d 8c 02 0a 00    lea    0xa028c(%rip),%r15        # 0xa02cb
>   3f:   c5                      .byte 0xc5
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   c5 f9 ef c0             vpxor  %xmm0,%xmm0,%xmm0
>    4:   48 b8 f6 75 ae 03 01    movabs $0x103ae75f6,%rax
>    b:   00 00 00 
>    e:   4c 8d 3d 8c 02 0a 00    lea    0xa028c(%rip),%r15        # 0xa02a1
>   15:   c5                      .byte 0xc5
> 
> Regards,
> Denis
> PS:
>    denis@srv2 ~ $ gcc --version
>    gcc (Gentoo 11.3.0 p4) 11.3.0

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.18..v5.19
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
