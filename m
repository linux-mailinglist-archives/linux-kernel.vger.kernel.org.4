Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87A6618B9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjAHTnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjAHTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:42:58 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D361324
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:42:56 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0D1CC92009C; Sun,  8 Jan 2023 20:42:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 08EF392009B;
        Sun,  8 Jan 2023 19:42:55 +0000 (GMT)
Date:   Sun, 8 Jan 2023 19:42:54 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Disable kernel stack offset randomization for !TSC
Message-ID: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_HDRS_LCASE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86 kernel stack offset randomization uses the RDTSC instruction, 
which causes an invalid opcode exception with hardware that does not 
implement this instruction:

process '/sbin/init' started with executable stack
invalid opcode: 0000 [#1]
CPU: 0 PID: 1 Comm: init Not tainted 6.1.0-rc4+ #1
EIP: exit_to_user_mode_prepare+0x90/0xe1
Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73 05 e8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f> 31 0f b6 c0 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
CR0: 80050033 CR2: bfe8659b CR3: 012e0000 CR4: 00000000
Call Trace:
 ? rest_init+0x72/0x72
 syscall_exit_to_user_mode+0x15/0x27
 ret_from_fork+0x10/0x30
EIP: 0xb7f74800
Code: Unable to access opcode bytes at 0xb7f747d6.
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfe864b0
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
---[ end trace 0000000000000000 ]---
EIP: exit_to_user_mode_prepare+0x90/0xe1
Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73 05 e8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f> 31 0f b6 c0 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
CR0: 80050033 CR2: b7f747d6 CR3: 012e0000 CR4: 00000000
Kernel panic - not syncing: Fatal exception

Therefore do not offer the option for CPU configurations that do not 
guarantee the presence of this instruction.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-x86-randomize-kstack-offset-tsc.diff
Index: linux-macro/arch/x86/Kconfig
===================================================================
--- linux-macro.orig/arch/x86/Kconfig
+++ linux-macro/arch/x86/Kconfig
@@ -186,7 +186,7 @@ config X86
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_USERFAULTFD_MINOR	if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
-	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET	if X86_TSC
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
