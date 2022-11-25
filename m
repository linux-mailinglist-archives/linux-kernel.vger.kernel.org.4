Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6463866D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKYJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKYJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:42:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBB23BF9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:42:39 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669369357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksDDcmQCY+1As7J2HctVpfMXUOEO/R8OEqcyPN1HAtc=;
        b=sV3Ks6WnkZ68pgk95VzupBIV3V6E8bwuylnssY4zHQwhs0VzeWVz3mq+F3DpVZmvr6RXC0
        FyEifY8N1A2E3UQzxkJaS9OuijDNpIz/Bzn1b0H8eeoucEpBSGVRcYvgt3LQTR2ooxBI+f
        iogtYQ9zLp4PR3xG0tUVeAwIcjrQLIPh8m4fd6Zhm9qIHcGaqgSmK6MZc7bYWrbH7nqJaj
        gApVZUYjEg5JdGWG8H12V2q832ho0b5NSbcszudy5JxvW7qAXXrkIDHrbif3PEwye+P7lc
        DnvG27Dj6+vrh+qMLKwEmTGzthj5ulN43WArk0AheUHGMXKN2DatzcH0KTOxUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669369357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksDDcmQCY+1As7J2HctVpfMXUOEO/R8OEqcyPN1HAtc=;
        b=dGP36mBtjGK+hzexrC2h0GV58AMU2lCv//tdl3WWVpcD5QvjxW3lrHK6uuc3d8caDFXHjD
        1XY/wPu77bAOe1Bw==
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Roland Mainz <roland.mainz@nrubsig.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] x86/vdso: Provide getcpu for x86-32.
Date:   Fri, 25 Nov 2022 10:42:15 +0100
Message-Id: <20221125094216.3663444-3-bigeasy@linutronix.de>
In-Reply-To: <20221125094216.3663444-1-bigeasy@linutronix.de>
References: <20221125094216.3663444-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up __vdso_getcpu() for x86-32. The version for 64bit can be reused.
The defines must no be faked (like it is done for vclock_gettime.c)
because we need the 64bit defines for the 32bit VDSO because the segment
number of the host kernel is required.

Reuse the vgetcpu.c for vdso32. Remove the time* header files which lead
to compile errors on 32bit. Add segment.h which provides
vdso_read_cpunode() and its requirements.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/entry/vdso/Makefile            | 3 ++-
 arch/x86/entry/vdso/vdso32/vdso32.lds.S | 1 +
 arch/x86/entry/vdso/vdso32/vgetcpu.c    | 2 ++
 arch/x86/entry/vdso/vgetcpu.c           | 3 +--
 4 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vdso32/vgetcpu.c

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3e88b9df8c8f1..fcbcfc2b4e1a7 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -29,7 +29,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:=3D y
 # files to link into the vdso
 vobjs-y :=3D vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y :=3D vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-vobjs32-y +=3D vdso32/vclock_gettime.o
+vobjs32-y +=3D vdso32/vclock_gettime.o vdso32/vgetcpu.o
 vobjs-$(CONFIG_X86_SGX)	+=3D vsgx.o
=20
 # files to link into kernel
@@ -103,6 +103,7 @@ $(vobjs): KBUILD_AFLAGS +=3D -DBUILD_VDSO
 CFLAGS_REMOVE_vclock_gettime.o =3D -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o =3D -pg
 CFLAGS_REMOVE_vgetcpu.o =3D -pg
+CFLAGS_REMOVE_vdso32/vgetcpu.o =3D -pg
 CFLAGS_REMOVE_vsgx.o =3D -pg
=20
 #
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/=
vdso32/vdso32.lds.S
index c7720995ab1af..8a3be07006bb6 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -28,6 +28,7 @@ VERSION
 		__vdso_time;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_getcpu;
 	};
=20
 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdso32/vgetcpu.c b/arch/x86/entry/vdso/vds=
o32/vgetcpu.c
new file mode 100644
index 0000000000000..b777f84ffae9b
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/vgetcpu.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../vgetcpu.c"
diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index b88a82bbc3593..0a9007c240568 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -7,8 +7,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/getcpu.h>
-#include <linux/time.h>
-#include <asm/vgtod.h>
+#include <asm/segment.h>
=20
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
--=20
2.38.1

