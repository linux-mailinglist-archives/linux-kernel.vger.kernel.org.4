Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1446837E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAaUwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAaUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:52:43 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2F518E5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:52:37 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30VKqBOh1345929
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 31 Jan 2023 12:52:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30VKqBOh1345929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1675198333;
        bh=SQo8ietahuC9KUQ9qI0iQsdNdqUbJR3joYs/mC0gvCg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=iGA8tQAE20ANc0YpXD1tiBvnyofxHUTvCN6BZSYBVmq2oufLkKAwRclqIwSjUTGOZ
         5vMGGIM84bgXaTXIiqzyvtkBxs4T/qou8yP6q8qEITiDVXx0QJ2fDIKszBRdUEUH4H
         K7VpQM4tOOeFG70734HzekixJGgWkrOCXhJGLoH+tQnXYTtrKzVg/lF8QmELjOCpS/
         Tlgx/D21OYdYiHw7bbGO3W8BFg6BEjWotGG5hHQK6AWG6Bf8rqdX1ohXhY2TA7YI6J
         +A3iICw9PoLTRGEmYEsOb12kJ0WrjXLLzJE6IaWMSJ7kFi33/y12fQ69vqBYaHafzy
         EbU0I5aEZCNLA==
Date:   Tue, 31 Jan 2023 12:52:10 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_x86=3A_Use_=60get=5Frandom=5Fu8?= =?US-ASCII?Q?=27_for_kernel_stack_offset_randomization?=
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
Message-ID: <1EA89768-9EBC-4A31-B134-AC86F472DA19@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2023 1:30:31 PM PST, "Maciej W=2E Rozycki" <macro@orcam=2Eme=
=2Euk> wrote:
>For x86 kernel stack offset randomization uses the RDTSC instruction,=20
>which according to H=2E Peter Anvin is not a secure source of entropy:
>
>"RDTSC isn't a super fast instruction either, but what is *way* more
>significant is that this use of RDTSC is NOT safe: in certain power state=
s
>it may very well be that stone number of lower bits of TSC contain no
>entropy at all=2E"
>
>It also causes an invalid opcode exception with hardware that does not=20
>implement this instruction:
>
>process '/sbin/init' started with executable stack
>invalid opcode: 0000 [#1]
>CPU: 0 PID: 1 Comm: init Not tainted 6=2E1=2E0-rc4+ #1
>EIP: exit_to_user_mode_prepare+0x90/0xe1
>Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73 05 e=
8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f> 31 0f b6 c0=
 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
>EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
>ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
>DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
>CR0: 80050033 CR2: bfe8659b CR3: 012e0000 CR4: 00000000
>Call Trace:
> ? rest_init+0x72/0x72
> syscall_exit_to_user_mode+0x15/0x27
> ret_from_fork+0x10/0x30
>EIP: 0xb7f74800
>Code: Unable to access opcode bytes at 0xb7f747d6=2E
>EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfe864b0
>DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
>---[ end trace 0000000000000000 ]---
>EIP: exit_to_user_mode_prepare+0x90/0xe1
>Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73 05 e=
8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f> 31 0f b6 c0=
 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
>EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
>ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
>DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
>CR0: 80050033 CR2: b7f747d6 CR3: 012e0000 CR4: 00000000
>Kernel panic - not syncing: Fatal exception
>
>Therefore switch to our generic entropy source and use `get_random_u8'=20
>instead, which according to Jason A=2E Donenfeld is supposed to be fast=
=20
>enough:
>
>"Generally it's very very fast, as most cases wind up being only a
>memcpy -- in this case, a single byte copy=2E So by and large it should
>be suitable=2E It's fast enough now that most networking things are able
>to use it=2E And lots of other places where you'd want really high
>performance=2E So I'd expect it's okay to use here too=2E And if it is to=
o
>slow, we should figure out how to make it faster=2E But I don't suspect
>it'll be too slow=2E"
>
>Signed-off-by: Maciej W=2E Rozycki <macro@orcam=2Eme=2Euk>
>Suggested-by: Jason A=2E Donenfeld <Jason@zx2c4=2Ecom>
>Fixes: fe950f602033 ("x86/entry: Enable random_kstack_offset support")
>Cc: stable@vger=2Ekernel=2Eorg # v5=2E13+
>---
>Changes from v2:
>
>- Use `get_random_u8' rather than `rdtsc', universally; update the headin=
g=20
>  (was: "x86: Disable kernel stack offset randomization for !TSC") and th=
e=20
>  description accordingly=2E
>
>- As a security concern mark for backporting=2E
>
>Changes from v1:
>
>- Disable randomization at run time rather than in configuration=2E
>---
> arch/x86/include/asm/entry-common=2Eh |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>linux-x86-randomize-kstack-offset-random-u8=2Ediff
>Index: linux-macro/arch/x86/include/asm/entry-common=2Eh
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-macro=2Eorig/arch/x86/include/asm/entry-common=2Eh
>+++ linux-macro/arch/x86/include/asm/entry-common=2Eh
>@@ -2,6 +2,7 @@
> #ifndef _ASM_X86_ENTRY_COMMON_H
> #define _ASM_X86_ENTRY_COMMON_H
>=20
>+#include <linux/random=2Eh>
> #include <linux/randomize_kstack=2Eh>
> #include <linux/user-return-notifier=2Eh>
>=20
>@@ -85,7 +86,7 @@ static inline void arch_exit_to_user_mod
> 	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> 	 * 6 (ia32) bits=2E
> 	 */
>-	choose_random_kstack_offset(rdtsc() & 0xFF);
>+	choose_random_kstack_offset(get_random_u8());
> }
> #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>=20

Well, what I said was that masking out the low bits of TSC is not a valid =
use to extract a random(-ish) number this way, because the lower bits may b=
e affected by quantization=2E Something like a circular multiply using a la=
rge prime with a good 0:1 balance can be used to mitigate that=2E

However, the second part is that subsequent RDTSCs will be highly correlat=
ed, and so a CSPRNG is needed if you are actually trying to get reasonable =
security this way =E2=80=93 and, well, we already have one of those=2E
