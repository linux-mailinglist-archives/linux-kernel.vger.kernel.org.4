Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD35F07C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiI3Jjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiI3Jjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:39:36 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47D131F6C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:39:31 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28U9d77F028702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 30 Sep 2022 17:39:07 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 30 Sep 2022 17:39:08 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>
Subject: [PATCH] lib: check stack_table in __stack_depot_save
Date:   Fri, 30 Sep 2022 17:38:47 +0800
Message-ID: <1664530727-4581-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28U9d77F028702
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

NULL pointer reported in below lkp test report which should caused by invalid
stack_table in very early stage before stack_depot_early_init called. I would like
have kmemleak use stackdepot to track backtrace in this commit which lead to
stack hash access before stackdepot is initialized. Add stack_table as extra
criteria in __stack_depot_save's entry check.

commit: a65edf711f97a0a3764fc04b0301ab2e073992db ("[PATCH] mm: use stack_depot for recording kmemleak's backtrace")
url: https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-use-stack_depot-for-recording-kmemleak-s-backtrace/20220929-183243
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/linux-mm/1664447407-8821-1-git-send-email-zhaoyang.huang@unisoc.com

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

	[    0.191645][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000000
	[    0.192360][    T0] #PF: supervisor read access in kernel mode
	[    0.192862][    T0] #PF: error_code(0x0000) - not-present page
	[    0.193371][    T0] PGD 0 P4D 0
	[    0.193672][    T0] Oops: 0000 [#1] SMP PTI
	[    0.194051][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc3-00706-ga65edf711f97 #26
	[    0.194755][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 0.195583][ T0] RIP: 0010:__stack_depot_save (kbuild/src/x86_64-2/lib/stackdepot.c:452)
	[ 0.196081][ T0] Code: 03 48 c7 c7 ec 17 b3 84 e8 f1 ea 85 ff 44 89 e0 23 05 d4 aa 01 03 48 8d 04 c3 48 89 c3 48 89 c7 48 89 44 24 28 e8 34 fc 85 ff <4c> 8b 33 4d 85 f6 0f 84 b6 00 00 00 8b 04 24 83 e8 01 48 8d 04 c5
	All code
	========
	0:   03 48 c7                add    -0x39(%rax),%ecx
3:   c7                      (bad)
	4:   ec                      in     (%dx),%al
5:   17                      (bad)
	6:   b3 84                   mov    $0x84,%bl
	8:   e8 f1 ea 85 ff          callq  0xffffffffff85eafe
	d:   44 89 e0                mov    %r12d,%eax
	10:   23 05 d4 aa 01 03       and    0x301aad4(%rip),%eax        # 0x301aaea
	16:   48 8d 04 c3             lea    (%rbx,%rax,8),%rax
	1a:   48 89 c3                mov    %rax,%rbx
	1d:   48 89 c7                mov    %rax,%rdi
20:   48 89 44 24 28          mov    %rax,0x28(%rsp)
	25:   e8 34 fc 85 ff          callq  0xffffffffff85fc5e
	2a:*  4c 8b 33                mov    (%rbx),%r14              <-- trapping instruction
	2d:   4d 85 f6                test   %r14,%r14
	30:   0f 84 b6 00 00 00       je     0xec
	36:   8b 04 24                mov    (%rsp),%eax
	39:   83 e8 01                sub    $0x1,%eax
	3c:   48                      rex.W
	3d:   8d                      .byte 0x8d
	3e:   04 c5                   add    $0xc5,%al

	Code starting with the faulting instruction
	===========================================
	0:   4c 8b 33                mov    (%rbx),%r14
	3:   4d 85 f6                test   %r14,%r14
	6:   0f 84 b6 00 00 00       je     0xc2
	c:   8b 04 24                mov    (%rsp),%eax
	f:   83 e8 01                sub    $0x1,%eax
	12:   48                      rex.W
	13:   8d                      .byte 0x8d
	14:   04 c5                   add    $0xc5,%al
	[    0.197693][    T0] RSP: 0000:ffffffff83603ca8 EFLAGS: 00010046
	[    0.198214][    T0] RAX: ffffffff83613cd8 RBX: 0000000000000000 RCX: ffffffff81b16d2c
	[    0.198858][    T0] RDX: 0000000000000b1e RSI: 0000000000000000 RDI: 0000000000000000
	[    0.199499][    T0] RBP: 00000000c5a6b597 R08: ffffffff8479d118 R09: 0000000000000000
	[    0.200142][    T0] R10: 0000000000000004 R11: 0001ffffffffffff R12: 0000000027b2cd0a
	[    0.200787][    T0] R13: 0000000000000003 R14: 000000004954f68c R15: ffffffff83603d54
	[    0.201488][    T0] FS:  0000000000000000(0000) GS:ffffffff842c9000(0000) knlGS:0000000000000000
	[    0.202247][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[    0.202807][    T0] CR2: 0000000000000000 CR3: 000000000360a000 CR4: 00000000000406b0
	[    0.203470][    T0] Call Trace:
	[    0.203748][    T0]  <TASK>
	[ 0.203996][ T0] stack_depot_save (kbuild/src/x86_64-2/lib/stackdepot.c:534)
	[ 0.204406][ T0] set_track_prepare (kbuild/src/x86_64-2/mm/slub.c:752)
	[ 0.204816][ T0] ? memblock_alloc_range_nid (kbuild/src/x86_64-2/mm/memblock.c:1424)
	[ 0.205311][ T0] ? memblock_alloc_internal (kbuild/src/x86_64-2/mm/memblock.c:1514)
	[ 0.205781][ T0] ? memblock_alloc_try_nid (kbuild/src/x86_64-2/mm/memblock.c:1614 (discriminator 3))
	[ 0.206238][ T0] ? setup_command_line (kbuild/src/x86_64-2/init/main.c:631)
	[ 0.206670][ T0] ? start_kernel (kbuild/src/x86_64-2/init/main.c:965)
	[ 0.207068][ T0] ? secondary_startup_64_no_verify (kbuild/src/x86_64-2/arch/x86/kernel/head_64.S:358)
	[ 0.207612][ T0] ? __raw_callee_save___native_queued_spin_unlock (??:?)
	[ 0.208251][ T0] ? write_comp_data (kbuild/src/x86_64-2/kernel/kcov.c:236)
	[ 0.208678][ T0] ? strncpy (kbuild/src/x86_64-2/lib/string.c:115)
	[ 0.209040][ T0] __create_object (kbuild/src/x86_64-2/mm/kmemleak.c:681)
	[ 0.209447][ T0] kmemleak_alloc_phys (kbuild/src/x86_64-2/mm/kmemleak.c:1212)
	[ 0.209867][ T0] memblock_alloc_range_nid (kbuild/src/x86_64-2/mm/memblock.c:1424)
	[ 0.210344][ T0] memblock_alloc_internal (kbuild/src/x86_64-2/mm/memblock.c:1514)
	[ 0.210806][ T0] memblock_alloc_try_nid (kbuild/src/x86_64-2/mm/memblock.c:1614 (discriminator 3))
	[ 0.211255][ T0] setup_command_line (kbuild/src/x86_64-2/init/main.c:631)
	[ 0.211678][ T0] start_kernel (kbuild/src/x86_64-2/init/main.c:965)
	[ 0.212063][ T0] ? load_ucode_bsp (kbuild/src/x86_64-2/arch/x86/kernel/cpu/microcode/core.c:176)
[ 0.212483][ T0] secondary_startup_64_no_verify (kbuild/src/x86_64-2/arch/x86/kernel/head_64.S:358)
	[    0.212996][    T0]  </TASK>
	[    0.213247][    T0] Modules linked in:
	[    0.213591][    T0] CR2: 0000000000000000
	[    0.213955][    T0] ---[ end trace 0000000000000000 ]---
[ 0.214415][ T0] RIP: 0010:__stack_depot_save (kbuild/src/x86_64-2/lib/stackdepot.c:452)
	[ 0.214933][ T0] Code: 03 48 c7 c7 ec 17 b3 84 e8 f1 ea 85 ff 44 89 e0 23 05 d4 aa 01 03 48 8d 04 c3 48 89 c3 48 89 c7 48 89 44 24 28 e8 34 fc 85 ff <4c> 8b 33 4d 85 f6 0f 84 b6 00 00 00 8b 04 24 83 e8 01 48 8d 04 c5
	All code
	========
	0:   03 48 c7                add    -0x39(%rax),%ecx
3:   c7                      (bad)
	4:   ec                      in     (%dx),%al
5:   17                      (bad)
	6:   b3 84                   mov    $0x84,%bl
	8:   e8 f1 ea 85 ff          callq  0xffffffffff85eafe
	d:   44 89 e0                mov    %r12d,%eax
	10:   23 05 d4 aa 01 03       and    0x301aad4(%rip),%eax        # 0x301aaea
	16:   48 8d 04 c3             lea    (%rbx,%rax,8),%rax
	1a:   48 89 c3                mov    %rax,%rbx
	1d:   48 89 c7                mov    %rax,%rdi
20:   48 89 44 24 28          mov    %rax,0x28(%rsp)
	25:   e8 34 fc 85 ff          callq  0xffffffffff85fc5e
	2a:*  4c 8b 33                mov    (%rbx),%r14              <-- trapping instruction
	2d:   4d 85 f6                test   %r14,%r14
	30:   0f 84 b6 00 00 00       je     0xec
	36:   8b 04 24                mov    (%rsp),%eax
	39:   83 e8 01                sub    $0x1,%eax
	3c:   48                      rex.W
	3d:   8d                      .byte 0x8d
	3e:   04 c5                   add    $0xc5,%al

	Code starting with the faulting instruction
	===========================================
	0:   4c 8b 33                mov    (%rbx),%r14
	3:   4d 85 f6                test   %r14,%r14
	6:   0f 84 b6 00 00 00       je     0xc2
	c:   8b 04 24                mov    (%rsp),%eax
	f:   83 e8 01                sub    $0x1,%eax
	12:   48                      rex.W
	13:   8d                      .byte 0x8d
	14:   04 c5                   add    $0xc5,%al

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e73fda2..97b6a2a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -421,7 +421,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 */
 	nr_entries = filter_irq_stacks(entries, nr_entries);
 
-	if (unlikely(nr_entries == 0) || stack_depot_disable)
+	if (unlikely(nr_entries == 0) || stack_depot_disable || !stack_table)
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-- 
1.9.1

