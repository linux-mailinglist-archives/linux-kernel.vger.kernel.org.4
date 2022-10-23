Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B62609628
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJWUc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJWUcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:32:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5BE6716B;
        Sun, 23 Oct 2022 13:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB456B80DD0;
        Sun, 23 Oct 2022 20:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF58EC433D6;
        Sun, 23 Oct 2022 20:32:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RhG6F6Ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666557164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pz1YbnhHHES22JbBuvoJmFfteKoXfI875tJTfozeVoM=;
        b=RhG6F6OtF0oXd925+MkqnzLfGYM6DZvyYuE4hWTHemEIu4bZUXkdfVK/z8lbpn5DFNIwlC
        lZJQGL8AsSQxW2vGubxpFBHajkz/qjvTS73fOGtflywhINBph+mpTZ8v6H/lLwbVokvZsA
        bhL3nqDGdFWm75dB4CALhgPA/u1bgws=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01fa1245 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 23 Oct 2022 20:32:44 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v1 1/2] stackprotector: move CANARY_MASK and get_random_canary() into stackprotector.h
Date:   Sun, 23 Oct 2022 22:32:07 +0200
Message-Id: <20221023203208.118919-2-Jason@zx2c4.com>
In-Reply-To: <20221023203208.118919-1-Jason@zx2c4.com>
References: <20221023203208.118919-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has nothing to do with random.c and everything to do with stack
protectors. Yes, it uses randomness. But many things use randomness.
random.h and random.c are concerned with the generation of randomness,
not with each and every use. So move this function into the more
specific stackprotector.h file where it belongs.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/setup_percpu.c |  2 +-
 arch/x86/kernel/smpboot.c      |  2 +-
 arch/x86/xen/enlighten_pv.c    |  2 +-
 include/linux/random.h         | 19 -------------------
 include/linux/stackprotector.h | 19 +++++++++++++++++++
 kernel/fork.c                  |  2 +-
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..3f66dd03c091 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -22,9 +22,9 @@
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
+#include <linux/stackprotector.h>
 
 #include <asm/cmdline.h>
-#include <asm/stackprotector.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/doublefault.h>
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 49325caa7307..b26123c90b4f 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/topology.h>
 #include <linux/pfn.h>
+#include <linux/stackprotector.h>
 #include <asm/sections.h>
 #include <asm/processor.h>
 #include <asm/desc.h>
@@ -21,7 +22,6 @@
 #include <asm/proto.h>
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
-#include <asm/stackprotector.h>
 
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f3ea0287f69..dbe09fcc6604 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -56,6 +56,7 @@
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
+#include <linux/stackprotector.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -80,7 +81,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
-#include <asm/stackprotector.h>
 #include <asm/sev.h>
 
 /* representing HT siblings of each logical CPU */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index f82857e48815..745420853a7c 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -32,6 +32,7 @@
 #include <linux/edd.h>
 #include <linux/reboot.h>
 #include <linux/virtio_anchor.h>
+#include <linux/stackprotector.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -64,7 +65,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/reboot.h>
-#include <asm/stackprotector.h>
 #include <asm/hypervisor.h>
 #include <asm/mach_traps.h>
 #include <asm/mwait.h>
diff --git a/include/linux/random.h b/include/linux/random.h
index bf8ed3df3af0..182780cafd45 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -115,25 +115,6 @@ static inline u32 get_random_u32_between(u32 floor, u32 ceil)
 	return floor + get_random_u32_below(ceil - floor);
 }
 
-/*
- * On 64-bit architectures, protect against non-terminated C string overflows
- * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
- */
-#ifdef CONFIG_64BIT
-# ifdef __LITTLE_ENDIAN
-#  define CANARY_MASK 0xffffffffffffff00UL
-# else /* big endian, 64 bits: */
-#  define CANARY_MASK 0x00ffffffffffffffUL
-# endif
-#else /* 32 bits: */
-# define CANARY_MASK 0xffffffffUL
-#endif
-
-static inline unsigned long get_random_canary(void)
-{
-	return get_random_long() & CANARY_MASK;
-}
-
 void __init random_init_early(const char *command_line);
 void __init random_init(void);
 bool rng_is_initialized(void);
diff --git a/include/linux/stackprotector.h b/include/linux/stackprotector.h
index 4c678c4fec58..9c88707d9a0f 100644
--- a/include/linux/stackprotector.h
+++ b/include/linux/stackprotector.h
@@ -6,6 +6,25 @@
 #include <linux/sched.h>
 #include <linux/random.h>
 
+/*
+ * On 64-bit architectures, protect against non-terminated C string overflows
+ * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
+ */
+#ifdef CONFIG_64BIT
+# ifdef __LITTLE_ENDIAN
+#  define CANARY_MASK 0xffffffffffffff00UL
+# else /* big endian, 64 bits: */
+#  define CANARY_MASK 0x00ffffffffffffffUL
+# endif
+#else /* 32 bits: */
+# define CANARY_MASK 0xffffffffUL
+#endif
+
+static inline unsigned long get_random_canary(void)
+{
+	return get_random_long() & CANARY_MASK;
+}
+
 #if defined(CONFIG_STACKPROTECTOR) || defined(CONFIG_ARM64_PTR_AUTH)
 # include <asm/stackprotector.h>
 #else
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..ec57cae58ff1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -75,7 +75,6 @@
 #include <linux/freezer.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
-#include <linux/random.h>
 #include <linux/tty.h>
 #include <linux/fs_struct.h>
 #include <linux/magic.h>
@@ -97,6 +96,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/stackprotector.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
-- 
2.38.1

