Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C495681CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjA3Vat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjA3Vah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:30:37 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A0954955D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:30:32 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F1F5E92009D; Mon, 30 Jan 2023 22:30:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id EAB4392009B;
        Mon, 30 Jan 2023 21:30:31 +0000 (GMT)
Date:   Mon, 30 Jan 2023 21:30:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
Message-ID: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86 kernel stack offset randomization uses the RDTSC instruction, 
which according to H. Peter Anvin is not a secure source of entropy:

"RDTSC isn't a super fast instruction either, but what is *way* more
significant is that this use of RDTSC is NOT safe: in certain power states
it may very well be that stone number of lower bits of TSC contain no
entropy at all."

It also causes an invalid opcode exception with hardware that does not 
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

Therefore switch to our generic entropy source and use `get_random_u8' 
instead, which according to Jason A. Donenfeld is supposed to be fast 
enough:

"Generally it's very very fast, as most cases wind up being only a
memcpy -- in this case, a single byte copy. So by and large it should
be suitable. It's fast enough now that most networking things are able
to use it. And lots of other places where you'd want really high
performance. So I'd expect it's okay to use here too. And if it is too
slow, we should figure out how to make it faster. But I don't suspect
it'll be too slow."

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Fixes: fe950f602033 ("x86/entry: Enable random_kstack_offset support")
Cc: stable@vger.kernel.org # v5.13+
---
Changes from v2:

- Use `get_random_u8' rather than `rdtsc', universally; update the heading 
  (was: "x86: Disable kernel stack offset randomization for !TSC") and the 
  description accordingly.

- As a security concern mark for backporting.

Changes from v1:

- Disable randomization at run time rather than in configuration.
---
 arch/x86/include/asm/entry-common.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

linux-x86-randomize-kstack-offset-random-u8.diff
Index: linux-macro/arch/x86/include/asm/entry-common.h
===================================================================
--- linux-macro.orig/arch/x86/include/asm/entry-common.h
+++ linux-macro/arch/x86/include/asm/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
+#include <linux/random.h>
 #include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
 
@@ -85,7 +86,7 @@ static inline void arch_exit_to_user_mod
 	 * Therefore, final stack offset entropy will be 5 (x86_64) or
 	 * 6 (ia32) bits.
 	 */
-	choose_random_kstack_offset(rdtsc() & 0xFF);
+	choose_random_kstack_offset(get_random_u8());
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
