Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4765DC56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjADSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjADSpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:45:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9851C415;
        Wed,  4 Jan 2023 10:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B57AB81893;
        Wed,  4 Jan 2023 18:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B5DC433D2;
        Wed,  4 Jan 2023 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672857900;
        bh=Qv30oYUxFBlBjClx9eK3GqOzg4ZjrorlOct/L1UTkW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGiUfB4JjlMEmAtine7uDrBBxGStB7cV9wQaKMAnhGyjTxFQ9Tb8hUgKqHfsrjt8+
         hiCtHJJSjYKdu30ilBgVEFYkpuyz6hnE51D4Qm2OyzjQnWG/LxutOZLDryAUBaCQKo
         rBz+Wrsfe9IDPFYcyZ7i5tZr0FJnUFiDFAqGz9NhHD4FJKwohoX1pnwGIQ97Lmtu2a
         1/c41E8ITOwxUJjHcL4psTKz30QHYr5GcX8My6rZCnimsY/BwWTog8/kIynxjZZjMI
         6ws6zpJxBmc1zAi8Cqtb2VuCebrCtA5kXJWJZ14g3rgOOzrKUnwmG2xYrubdFyvNW+
         Aq2Lmagw0TPUQ==
Date:   Wed, 4 Jan 2023 11:44:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 02/30] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
Message-ID: <Y7XJKZhuU9VJZQ11@dev-arch.thelio-3990X>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
 <20221122203932.231377-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203932.231377-3-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, Nov 22, 2022 at 03:39:04PM -0500, Mathieu Desnoyers wrote:
> Export the rseq feature size supported by the kernel as well as the
> required allocation alignment for the rseq per-thread area to user-space
> through ELF auxiliary vector entries.
> 
> This is part of the extensible rseq ABI.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I just bisected a crash with CONFIG_HARDENED_USERCOPY=y and
CONFIG_RSEQ=y on 32-bit ARM to this change as commit 317c8194e6ae
("rseq: Introduce feature size and alignment ELF auxiliary vector
entries") in the sched/core branch of the -tip tree:

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- defconfig

$ scripts/config -e HARDENED_USERCOPY -e RSEQ

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig zImage

$ qemu-system-arm \
-machine virt \
-kernel arch/arm/boot/zImage \
-append "console=ttyAMA0 earlycon" \
-display none \
-initrd rootfs.cpio \
-m 512m \
-nodefaults \
-no-reboot \
-serial mon:stdio
...
[    1.410707] usercopy: Kernel memory exposure attempt detected from SLUB object 'mm_struct' (offset 180, size 176)!
[    1.410964] ------------[ cut here ]------------
[    1.411076] kernel BUG at mm/usercopy.c:102!
[    1.411163] Internal error: Oops - BUG: 0 [#2] SMP ARM
[    1.411282] Modules linked in:
[    1.411403] CPU: 0 PID: 1 Comm: init Tainted: G      D            6.2.0-rc1-00004-g317c8194e6ae #1
[    1.411606] Hardware name: Generic DT based system
[    1.411712] PC is at usercopy_abort+0x90/0x94
[    1.411820] LR is at usercopy_abort+0x90/0x94
[    1.411898] pc : [<c1120b3c>]    lr : [<c1120b3c>]    psr: 60000013
[    1.412035] sp : e080de40  ip : 0000bff4  fp : b6f18148
[    1.412135] r10: 000000b0  r9 : 00000000  r8 : c22d62f4
[    1.412235] r7 : 00000001  r6 : 000000b0  r5 : 000000b0  r4 : 000000b4
[    1.412366] r3 : c20b8000  r2 : 00000000  r1 : 00000000  r0 : 00000066
[    1.412502] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.412684] Control: 10c5387d  Table: 425a406a  DAC: 00000051
[    1.412796] Register r0 information: non-paged memory
[    1.412914] Register r1 information: NULL pointer
[    1.413022] Register r2 information: NULL pointer
[    1.413134] Register r3 information: slab task_struct start c20b8000 pointer offset 0 size 2176
[    1.413365] Register r4 information: non-paged memory
[    1.413468] Register r5 information: non-paged memory
[    1.413580] Register r6 information: non-paged memory
[    1.413691] Register r7 information: non-paged memory
[    1.413807] Register r8 information: slab mm_struct start c22d6240 pointer offset 180 size 564
[    1.414022] Register r9 information: NULL pointer
[    1.414132] Register r10 information: non-paged memory
[    1.414246] Register r11 information: non-paged memory
[    1.414353] Register r12 information: non-paged memory
[    1.414466] Process init (pid: 1, stack limit = 0xfdcb78d5)
[    1.414601] Stack: (0xe080de40 to 0xe080e000)
[    1.414702] de40: c164cf44 c16362a4 c1645208 000000b4 000000b0 00000240 60000000 c04ba5a4
[    1.414894] de60: 000000b0 d381ab2f c22d62f4 dbc1eac0 000000b0 00000001 c22d63a4 c04bf0a8
[    1.415073] de80: c22d6278 000000b0 c22d6240 c22d6240 c3007400 c22d62f4 c20b8000 00000000
[    1.415250] dea0: be953f0c c0522aa8 00000012 00000000 00000002 c22ba3c0 00000002 00000002
[    1.415410] dec0: 000000b0 c22d62f4 c258b1f8 c1b04cc8 b6f2e09c 004c79fc 005a001d 004c0034
[    1.415590] dee0: 00000005 0058dbb0 0059e7d8 004c0000 00000034 00000000 00000100 7b30eb30
[    1.415791] df00: be882ab5 0881c2d0 414ecb5e d381ab2f 00000000 fffffff8 c3007400 c1ba28c4
[    1.415962] df20: c1d951ac c1ba6b08 00000002 c300745c c1ba287c c04cc468 dbc0efe0 00000005
[    1.416129] df40: c20b8000 00000000 00000001 00000001 00000100 00000000 c20b8000 d381ab2f
[    1.416315] df60: ffffffff 00000000 c3007400 c20c1000 c1b09214 c1b092a0 00000000 00000000
[    1.416490] df80: 00000000 c04ccb94 c1b04cc0 c1b09214 00000000 00000000 00000000 c1133d70
[    1.416655] dfa0: 00000000 c1133d04 00000000 c03001a8 00000000 00000000 00000000 00000000
[    1.416834] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.417014] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.417194]  usercopy_abort from __check_heap_object+0xe0/0xfc
[    1.417332]  __check_heap_object from __check_object_size+0x25c/0x2dc
[    1.417482]  __check_object_size from load_elf_binary+0x11e0/0x1484
[    1.417637]  load_elf_binary from bprm_execve+0x200/0x568
[    1.417761]  bprm_execve from kernel_execve+0x12c/0x1d0
[    1.417866]  kernel_execve from kernel_init+0x6c/0x12c
[    1.417982]  kernel_init from ret_from_fork+0x14/0x2c
[    1.418097] Exception stack(0xe080dfb0 to 0xe080dff8)
[    1.418229] dfa0:                                     00000000 00000000 00000000 00000000
[    1.418414] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.418606] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.418742] Code: e98d4001 e30c0f48 e34c0164 ebfff87f (e7f001f2)
[    1.418968] ---[ end trace 0000000000000000 ]---
[    1.419207] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.419558] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

If there is any more information I can provide, I am more than happy to
do so. The rootfs is available at [1]; that repo also has a script that
can help drive QEMU if you would like.

Cheers,
Nathan

[1]: https://github.com/ClangBuiltLinux/boot-utils/raw/1b837f3b0fca441e0cc694c9b587120e81299554/images/arm/rootfs.cpio.zst

# bad: [b9fdd2ea1a7cff56550990ee920e44f2394da0b6] Add linux-next specific files for 20230103
# good: [69b41ac87e4a664de78a395ff97166f0b2943210] Merge tag 'for-6.2-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect start 'b9fdd2ea1a7cff56550990ee920e44f2394da0b6' '69b41ac87e4a664de78a395ff97166f0b2943210'
# good: [9d1919d3a74d454501e4431ff50b96bd7419ec7b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 9d1919d3a74d454501e4431ff50b96bd7419ec7b
# bad: [b705cff481d9ed62a845e9393463b8d57264e75b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect bad b705cff481d9ed62a845e9393463b8d57264e75b
# good: [065024e724f54ff6fbdfa980849d845641e2c750] Merge branch 'hwmon-next' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
git bisect good 065024e724f54ff6fbdfa980849d845641e2c750
# good: [a6863e831038c4bea7119c912c06442284d13a79] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect good a6863e831038c4bea7119c912c06442284d13a79
# bad: [08d1485bcd896e9516da6585c6dbce18ff466694] Merge branch into tip/master: 'perf/urgent'
git bisect bad 08d1485bcd896e9516da6585c6dbce18ff466694
# bad: [b344b8f2d88dbf095caf97ac57fd3645843fa70f] selftests/rseq: Add mm_numa_cid to test script
git bisect bad b344b8f2d88dbf095caf97ac57fd3645843fa70f
# bad: [18c2355838e76788f61849f4d83513b103d68b95] selftests/rseq: Implement rseq mm_cid field support
git bisect bad 18c2355838e76788f61849f4d83513b103d68b95
# bad: [cbae6bac29a8c5cf2f1cb5c6bce35af00cec164b] rseq: Extend struct rseq with numa node id
git bisect bad cbae6bac29a8c5cf2f1cb5c6bce35af00cec164b
# good: [4842dadfc66f627083ec46c4e9a426e805c765f3] selftests/rseq: Fix: Fail thread registration when CONFIG_RSEQ=n
git bisect good 4842dadfc66f627083ec46c4e9a426e805c765f3
# bad: [ee3e3ac05c2631ce1f12d88c9cc9a092f8fe947a] rseq: Introduce extensible rseq ABI
git bisect bad ee3e3ac05c2631ce1f12d88c9cc9a092f8fe947a
# bad: [317c8194e6aeb8b3b573ad139fc2a0635856498e] rseq: Introduce feature size and alignment ELF auxiliary vector entries
git bisect bad 317c8194e6aeb8b3b573ad139fc2a0635856498e
# first bad commit: [317c8194e6aeb8b3b573ad139fc2a0635856498e] rseq: Introduce feature size and alignment ELF auxiliary vector entries
