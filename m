Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F34616C94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiKBSht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiKBShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D512FC34
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+DUkFwzVDWBAoIlFP88fJ/ZyZos6qnRzZwRuH+/Nwc=;
        b=R7YolwFHj8RU9izOD1qTztdTDPaM4HMEjt9xkZRo4XS3LiwQjW6ID3t5FPVhYwJMKgvXT7
        5INl5LsgZ8Ym8X362whreCftnYGsi1uf+IDouyRO7FFkOOMROoHiVam4DGfeufzz+YpXs4
        JUpH4Ltg6NSGrUJIUlPcHqFJ40kDZYA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-C4s1fAyWPg6GC9dR_PfTbw-1; Wed, 02 Nov 2022 14:34:32 -0400
X-MC-Unique: C4s1fAyWPg6GC9dR_PfTbw-1
Received: by mail-qt1-f199.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso12830575qtr.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+DUkFwzVDWBAoIlFP88fJ/ZyZos6qnRzZwRuH+/Nwc=;
        b=7f+Fh4vpi25aE5jWM7B2Cb0AcT2GOPwcXcQeHpvHb0jNYwLvlYsTPeFNLSzd5J5J4d
         XYXYM/pTk0EGHo01acBaODayVGmGevsOE7LaeUSGBgrxZwGZ3veeVMkubAxOJ61/unN9
         z5kQexl+apkfZbt7wro6naUcDGtZgtSmlcjz4MEUaj2Nhq4oTyGvsLlzz3h9FwONnzU2
         vuhrXGeNcxZEnTqZoqCE1d8JUiOCU6vl7d4zH1hbHmELh+kdyYLP6Bvmgg5Cb/hl1soK
         d8/F2/UApSVskS1MJwqV+95nBfim+cf61yvhL0pc3RF0jL0sDBDsIHrujpqHW36Yww1y
         jEsQ==
X-Gm-Message-State: ACrzQf0ISbqHD2f+ny9tZUmstaUvJwjCLF/Iqlbd6Dt8uCBLBqr9SB8I
        /VO9EbHj+3i77asY86ib+HXPscJ03VkWkKwAbrCvR/MBL+sTavL4CAI+GcyeTOPKx/T4eVrFo07
        pZI/2snXqKGdNUVspRFglHRGo
X-Received: by 2002:a37:2e84:0:b0:6cf:8dd4:7adc with SMTP id u126-20020a372e84000000b006cf8dd47adcmr18698490qkh.723.1667414070490;
        Wed, 02 Nov 2022 11:34:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JVN0uUv5xcXV3NWn4R+zPAe32FfY9CU6reQSjaMcymj00Sb8uKMdjN8WczbxFLj+CwWikmw==
X-Received: by 2002:a37:2e84:0:b0:6cf:8dd4:7adc with SMTP id u126-20020a372e84000000b006cf8dd47adcmr18698439qkh.723.1667414070130;
        Wed, 02 Nov 2022 11:34:30 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:29 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     Guo Ren <guoren@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 6/8] treewide: Trace IPIs sent via smp_send_reschedule()
Date:   Wed,  2 Nov 2022 18:33:34 +0000
Message-Id: <20221102183336.3120536-5-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to trace invocations of smp_send_reschedule(), rename the
arch-specific definitions of it to arch_smp_send_reschedule() and wrap it
into an smp_send_reschedule() that contains a tracepoint.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
[csky bits]
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/alpha/kernel/smp.c          | 2 +-
 arch/arc/kernel/smp.c            | 2 +-
 arch/arm/kernel/smp.c            | 2 +-
 arch/arm64/kernel/smp.c          | 2 +-
 arch/csky/kernel/smp.c           | 2 +-
 arch/hexagon/kernel/smp.c        | 2 +-
 arch/ia64/kernel/smp.c           | 4 ++--
 arch/loongarch/include/asm/smp.h | 2 +-
 arch/mips/include/asm/smp.h      | 2 +-
 arch/openrisc/kernel/smp.c       | 2 +-
 arch/parisc/kernel/smp.c         | 4 ++--
 arch/powerpc/kernel/smp.c        | 4 ++--
 arch/powerpc/kvm/book3s_hv.c     | 1 +
 arch/riscv/kernel/smp.c          | 4 ++--
 arch/s390/kernel/smp.c           | 2 +-
 arch/sh/kernel/smp.c             | 2 +-
 arch/sparc/kernel/smp_32.c       | 2 +-
 arch/sparc/kernel/smp_64.c       | 2 +-
 arch/x86/include/asm/smp.h       | 2 +-
 arch/x86/kvm/svm/svm.c           | 1 +
 arch/x86/kvm/x86.c               | 1 +
 arch/xtensa/kernel/smp.c         | 2 +-
 include/linux/smp.h              | 2 +-
 kernel/smp.c                     | 8 ++++++++
 24 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index f4e20f75438f8..38637eb9eebd5 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -562,7 +562,7 @@ handle_ipi(struct pt_regs *regs)
 }
 
 void
-smp_send_reschedule(int cpu)
+arch_smp_send_reschedule(int cpu)
 {
 #ifdef DEBUG_IPI_MSG
 	if (cpu == hard_smp_processor_id())
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index ad93fe6e4b77d..409cfa4675b40 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -292,7 +292,7 @@ static void ipi_send_msg(const struct cpumask *callmap, enum ipi_msg_type msg)
 		ipi_send_msg_one(cpu, msg);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	ipi_send_msg_one(cpu, IPI_RESCHEDULE);
 }
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3b280d55c1c40..f216ac890b6f9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -745,7 +745,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	ipi_setup(smp_processor_id());
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 937d2623e06ba..8d108edc4a89f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -976,7 +976,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	ipi_setup(smp_processor_id());
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 4b605aa2e1d65..fd7f81be16dd6 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -140,7 +140,7 @@ void smp_send_stop(void)
 	on_each_cpu(ipi_stop, NULL, 1);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 4ba93e59370c4..4e8bee25b8c68 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -217,7 +217,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
index e2cc59db86bc2..ea4f009a232b4 100644
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -220,11 +220,11 @@ kdump_smp_send_init(void)
  * Called with preemption disabled.
  */
 void
-smp_send_reschedule (int cpu)
+arch_smp_send_reschedule (int cpu)
 {
 	ia64_send_ipi(cpu, IA64_IPI_RESCHEDULE, IA64_IPI_DM_INT, 0);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 /*
  * Called with preemption disabled.
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 71189b28bfb27..3fcca134dfb1b 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -83,7 +83,7 @@ extern void show_ipi_list(struct seq_file *p, int prec);
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-static inline void smp_send_reschedule(int cpu)
+static inline void arch_smp_send_reschedule(int cpu)
 {
 	loongson3_send_ipi_single(cpu, SMP_RESCHEDULE);
 }
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 5d9ff61004ca7..9806e79895d99 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -66,7 +66,7 @@ extern void calculate_cpu_foreign_map(void);
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-static inline void smp_send_reschedule(int cpu)
+static inline void arch_smp_send_reschedule(int cpu)
 {
 	extern const struct plat_smp_ops *mp_ops;	/* private */
 
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index e1419095a6f0a..0a7a059e2dff4 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -173,7 +173,7 @@ void handle_IPI(unsigned int ipi_msg)
 	}
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 7dbd92cafae38..b7fc859fa87db 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -246,8 +246,8 @@ void kgdb_roundup_cpus(void)
 inline void 
 smp_send_stop(void)	{ send_IPI_allbutself(IPI_CPU_STOP); }
 
-void 
-smp_send_reschedule(int cpu) { send_IPI_single(cpu, IPI_RESCHEDULE); }
+void
+arch_smp_send_reschedule(int cpu) { send_IPI_single(cpu, IPI_RESCHEDULE); }
 
 void
 smp_send_all_nop(void)
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 0da6e59161cd4..2f85a757ee792 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -364,12 +364,12 @@ static inline void do_message_pass(int cpu, int msg)
 #endif
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	if (likely(smp_ops))
 		do_message_pass(cpu, PPC_MSG_RESCHEDULE);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 void arch_send_call_function_single_ipi(int cpu)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6ba68dd6190bd..686c80b17627e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -43,6 +43,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/smp.h>
 
 #include <asm/ftrace.h>
 #include <asm/reg.h>
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 760a64518c585..213602e89a8b2 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -235,8 +235,8 @@ void smp_send_stop(void)
 			   cpumask_pr_args(cpu_online_mask));
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
-EXPORT_SYMBOL_GPL(smp_send_reschedule);
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0031325ce4bc9..6c4da1e26e568 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -553,7 +553,7 @@ void arch_send_call_function_single_ipi(int cpu)
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	pcpu_ec_call(pcpu_devices + cpu, ec_schedule);
 }
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 65924d9ec2459..5cf35a774dc70 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -256,7 +256,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	       (bogosum / (5000/HZ)) % 100);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	mp_ops->send_ipi(cpu, SMP_MSG_RESCHEDULE);
 }
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index ad8094d955eba..87eaa7719fa27 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -120,7 +120,7 @@ void cpu_panic(void)
 
 struct linux_prom_registers smp_penguin_ctable = { 0 };
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	/*
 	 * CPU model dependent way of implementing IPI generation targeting
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a55295d1b9244..e5964d1d8b37d 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1430,7 +1430,7 @@ static unsigned long send_cpu_poke(int cpu)
 	return hv_err;
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	if (cpu == smp_processor_id()) {
 		WARN_ON_ONCE(preemptible());
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a73bced40e241..5ff5815149bd3 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -99,7 +99,7 @@ static inline void play_dead(void)
 	smp_ops.play_dead();
 }
 
-static inline void smp_send_reschedule(int cpu)
+static inline void arch_smp_send_reschedule(int cpu)
 {
 	smp_ops.smp_send_reschedule(cpu);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 58f0077d93579..b972c6f8c1791 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -26,6 +26,7 @@
 #include <linux/swap.h>
 #include <linux/rwsem.h>
 #include <linux/cc_platform.h>
+#include <linux/smp.h>
 
 #include <asm/apic.h>
 #include <asm/perf_event.h>
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 521b433f978c7..3fbc3fea3e754 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -58,6 +58,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/entry-kvm.h>
 #include <linux/suspend.h>
+#include <linux/smp.h>
 
 #include <trace/events/kvm.h>
 
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 4dc109dd6214e..d95907b8e4d38 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -389,7 +389,7 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
-void smp_send_reschedule(int cpu)
+void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58ae3f1d..2f9dc1b7a7fb6 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -125,9 +125,9 @@ extern void smp_send_stop(void);
 /*
  * sends a 'reschedule' event to another CPU:
  */
+extern void arch_smp_send_reschedule(int cpu);
 extern void smp_send_reschedule(int cpu);
 
-
 /*
  * Prepare machine for booting other CPUs.
  */
diff --git a/kernel/smp.c b/kernel/smp.c
index c4d561cf50d45..44fa4b9b1f46b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -167,6 +167,14 @@ send_call_function_ipi_mask(const struct cpumask *mask)
 	arch_send_call_function_ipi_mask(mask);
 }
 
+void smp_send_reschedule(int cpu)
+{
+	/* XXX scheduler_ipi is inline :/ */
+	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
+	arch_smp_send_reschedule(cpu);
+}
+EXPORT_SYMBOL_GPL(smp_send_reschedule);
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
-- 
2.31.1

