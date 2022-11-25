Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4263866B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKYJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKYJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:42:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D061A830
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:42:38 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669369357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYtDKXEAvjEf1YJAc3x9GyPrR/5UvNDnbCTQFLZPR1w=;
        b=JPV14MvtFeNQp++zT40Gqm8cARU4bfG1isYMsoAiY1/WXq385FYLd5KVgD+uhAhEduV7+I
        3BtKsCL85s+p2MsSjLeMIAOvX2eeX5zSYJxvQ0UPRqKVhGOVoQ9PykSJt583Z0Ng7fWAJR
        JAtZlCwKakltdLb8YhYyzKZnsT/sLaorNW9qJeTzwhU9Ftvwkx1yglWnCi0SrsTGvzzzCk
        FLOYri3OJzFJWDHT64mHZpecz/Sxm/2quSGXl0jqPjMQKmJWW3G/trbwIqSABjauBA6wZH
        +feookW5xemzgdB6E4xZtS1FJ06AespFxKvlVRJZ/+h4aduc06DCdMCmuhmWXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669369357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYtDKXEAvjEf1YJAc3x9GyPrR/5UvNDnbCTQFLZPR1w=;
        b=ZJrOcsZXlB3YdtykG4rliywnUljEYGheHx6C02eBpywX2uS5WzsXsWv+L2J327+YyJPnYD
        yKGYZo+bYQc4o4BQ==
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Roland Mainz <roland.mainz@nrubsig.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] x86: Provide a full setup for getcpu on x86-32.
Date:   Fri, 25 Nov 2022 10:42:14 +0100
Message-Id: <20221125094216.3663444-2-bigeasy@linutronix.de>
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

setup_getcpu() configures two things:
- writes the current CPU & node information into the MSR_TSC_AUX.
- writes the same information as a GDT entry.

By using the "full" setup_getcpu() on i386 it is possible to read the
CPU information in userland via rdtscp.

Provide an GDT_ENTRY_CPUNODE for x86-32.
Move the CONFIG_X86_64 so the x86-64 implementation becomes also
available for x86-32.

Reviewed-By: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/segment.h | 8 ++++----
 arch/x86/kernel/cpu/common.c   | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 2e7890dd58a47..662281c2a907c 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -96,7 +96,7 @@
  *
  *  26 - ESPFIX small SS
  *  27 - per-cpu			[ offset to per-cpu data area ]
- *  28 - unused
+ *  28 - VDSO getcpu
  *  29 - unused
  *  30 - unused
  *  31 - TSS for double fault handler
@@ -119,6 +119,7 @@
=20
 #define GDT_ENTRY_ESPFIX_SS		26
 #define GDT_ENTRY_PERCPU		27
+#define GDT_ENTRY_CPUNODE		28
=20
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
=20
@@ -158,6 +159,8 @@
 # define __KERNEL_PERCPU		0
 #endif
=20
+#define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
+
 #else /* 64-bit: */
=20
 #include <asm/cache.h>
@@ -226,8 +229,6 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
=20
-#ifdef CONFIG_X86_64
-
 /* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX=
) */
 #define VDSO_CPUNODE_BITS		12
 #define VDSO_CPUNODE_MASK		0xfff
@@ -265,7 +266,6 @@ static inline void vdso_read_cpunode(unsigned *cpu, uns=
igned *node)
 }
=20
 #endif /* !__ASSEMBLY__ */
-#endif /* CONFIG_X86_64 */
=20
 #ifdef __KERNEL__
=20
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f2390983..520a0a2e765d3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2128,7 +2128,6 @@ static void wait_for_master_cpu(int cpu)
 #endif
 }
=20
-#ifdef CONFIG_X86_64
 static inline void setup_getcpu(int cpu)
 {
 	unsigned long cpudata =3D vdso_encode_cpunode(cpu, early_cpu_to_node(cpu)=
);
@@ -2150,6 +2149,7 @@ static inline void setup_getcpu(int cpu)
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPUNODE, &d, DESCTYPE_S);
 }
=20
+#ifdef CONFIG_X86_64
 static inline void ucode_cpu_init(int cpu)
 {
 	if (cpu)
@@ -2169,8 +2169,6 @@ static inline void tss_setup_ist(struct tss_struct *t=
ss)
=20
 #else /* CONFIG_X86_64 */
=20
-static inline void setup_getcpu(int cpu) { }
-
 static inline void ucode_cpu_init(int cpu)
 {
 	show_ucode_info_early();
--=20
2.38.1

