Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B663C2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiK2Oqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiK2Oqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:46:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8B55AAA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:46:30 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17D311EC06D0;
        Tue, 29 Nov 2022 15:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669733188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QfcMOLpL7FrCvY8GSfK+YtqploCAsF27JXhObDSNnEE=;
        b=P0lDuBgfn9IqvTwDDPpdEc4JFS2K2xw3IEuxT5D93ihP2mgdkMQsynJxl+FhUbvWS2wUh6
        Rd45Kv1TLxuzVyOcUi+l6yU+NVh5KqGjTEnJ74jFA5CFixUXMxCaCn0HjxeTEhqjO6nZb+
        kpG6UA5jtPu/p++6xyGeGfTXg7uvvCQ=
Date:   Tue, 29 Nov 2022 15:46:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
Message-ID: <Y4YbQHKbl1BVZKMX@zn.tnic>
References: <20221104124546.196077-1-ubizjak@gmail.com>
 <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com>
 <Y4XDVbuYtFUYCrur@zn.tnic>
 <CAFULd4Yv9ZYu_mWwFBGheJ7_XsP6Ok1uCCPDr-ChDK4yzOK3qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4Yv9ZYu_mWwFBGheJ7_XsP6Ok1uCCPDr-ChDK4yzOK3qA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

I tried to summarize what we talked on the thread and have the whole
deal explained in greater detail.

Holler if something's missing:

---
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 4 Nov 2022 13:45:46 +0100
Subject: [PATCH] x86/boot: Remove x86_32 PIC using %ebx workaround

The currently supported minimum gcc version is 5.1. Before that, the
PIC register, when generating Position Independent Code, was considered
"fixed" in the sense that it wasn't in the set of registers available to
the compiler's register allocator. Which, on x86-32, is already a very
small set.

What is more, the register allocator was unable to satisfy extended asm
"=b" constraints. (Yes, PIC code uses %ebx on 32-bit as the base reg.)

With gcc5:

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
index a83d67ec627d..d75237ba7ce9 100644
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
 
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
