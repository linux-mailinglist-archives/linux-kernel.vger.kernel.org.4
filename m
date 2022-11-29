Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3876563C8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiK2TsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiK2TrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:47:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1019C2EF31;
        Tue, 29 Nov 2022 11:44:58 -0800 (PST)
Date:   Tue, 29 Nov 2022 19:44:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669751095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXVtIzomxjTksg3tJ+hAHpeadbStKm5VAGTkI7rYqqM=;
        b=1iuc7NUcn28WY6asYAUrT+ar37PO3frxZAAZ4YuikdJIQApFa2nJ5Pl/qeYz8Mw1K+Y+CN
        9FyL0UD1nEVoJhJhM9xyw9pi6kjv0yt1fgoXVeFaf1Vfp5Uio+hijTbnqLyW7/xOpfAwmq
        ewcyxWhHhNo1fsVXGQF/x/0U+uRRDrtPoZ4WQGFAVZvgUzUnZ2jXSeEEBQul4vNRrzcG2s
        ediuYu9SmgUPjNxo5/vEdu4j5MTxa6TvlpoP+4SOl4wZ/9P490TSvfqnNHaSEVsyTFKOtY
        0e7LTICeOQjkGv5OL7cMgTomlDJOiys58eanqqZon1xgJFpxJ0MIfG+pgcB2nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669751095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXVtIzomxjTksg3tJ+hAHpeadbStKm5VAGTkI7rYqqM=;
        b=hT1twTOCUbZPOut7Ldf657AKzPGMjy0XbkslyeqA7LCkSm9pK9Ubz9BDO4TqwTXSEBcr5p
        rxweYfsiTUyFpDAg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Remove x86_32 PIC using %ebx workaround
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221104124546.196077-1-ubizjak@gmail.com>
References: <20221104124546.196077-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <166975109360.4906.1198013784402637046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     60253f100c5846029f1370e51be6ebaeb160dcec
Gitweb:        https://git.kernel.org/tip/60253f100c5846029f1370e51be6ebaeb160dcec
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 04 Nov 2022 13:45:46 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 29 Nov 2022 16:26:53 +01:00

x86/boot: Remove x86_32 PIC using %ebx workaround

The currently supported minimum gcc version is 5.1. Before that, the
PIC register, when generating Position Independent Code, was considered
"fixed" in the sense that it wasn't in the set of registers available to
the compiler's register allocator. Which, on x86-32, is already a very
small set.

What is more, the register allocator was unable to satisfy extended asm
"=b" constraints. (Yes, PIC code uses %ebx on 32-bit as the base reg.)

With gcc 5.1:

"Reuse of the PIC hard register, instead of using a fixed register,
was implemented on x86/x86-64 targets. This improves generated PIC
code performance as more hard registers can be used. Shared libraries
can significantly benefit from this optimization. Currently it is
switched on only for x86/x86-64 targets. As RA infrastructure is already
implemented for PIC register reuse, other targets might follow this in
the future."

  (from: https://gcc.gnu.org/gcc-5/changes.html)

which basically means that the register allocator has a higher degree
of freedom when handling %ebx, including reloading it with the correct
value before a PIC access.

Furthermore:

  arch/x86/Makefile:
          # Never want PIC in a 32-bit kernel, prevent breakage with GCC built
          # with nonstandard options
          KBUILD_CFLAGS += -fno-pic

  $ gcc -Wp,-MMD,arch/x86/boot/.cpuflags.o.d ... -fno-pic ... -D__KBUILD_MODNAME=kmod_cpuflags -c -o arch/x86/boot/cpuflags.o arch/x86/boot/cpuflags.c

so the 32-bit workaround in cpuid_count() is fixing exactly nothing
because 32-bit configs don't even allow PIC builds.

As to 64-bit builds: they're done using -mcmodel=kernel which produces
RIP-relative addressing for PIC builds and thus does not apply here
either.

So get rid of the thing and make cpuid_count() nice and simple.

There should be no functional changes resulting from this.

  [ bp: Expand commit message. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221104124546.196077-1-ubizjak@gmail.com
---
 arch/x86/boot/cpuflags.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index a83d67e..d75237b 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -64,20 +64,11 @@ int has_eflag(unsigned long mask)
 	return !!((f0^f1) & mask);
 }
 
-/* Handle x86_32 PIC using ebx. */
-#if defined(__i386__) && defined(__PIC__)
-# define EBX_REG "=r"
-#else
-# define EBX_REG "=b"
-#endif
-
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
 {
-	asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif	\n\t"
-		     "cpuid					\n\t"
-		     ".ifnc %%ebx,%3 ; xchgl %%ebx,%3 ; .endif	\n\t"
-		    : "=a" (*a), "=c" (*c), "=d" (*d), EBX_REG (*b)
-		    : "a" (id), "c" (count)
+	asm volatile("cpuid"
+		     : "=a" (*a), "=b" (*b), "=c" (*c), "=d" (*d)
+		     : "0" (id), "2" (count)
 	);
 }
 
