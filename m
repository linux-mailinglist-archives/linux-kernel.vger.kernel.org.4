Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F66F398A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEAVC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEAVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:02:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF7B1BFE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:02:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-518d325b8a2so2545379a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682974968; x=1685566968;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0PMc06A2yO1+4gBCh6kqZ9mPyJIp2PmIrRbClN4AUU=;
        b=22pB7WZDuACv8vKwyma11RORQBTgeLJOhEWaVOHjR4k1EQ0m1ccauLXSPMoS3CqUI/
         Rmt/TNm93ODh6yu4l+tzgcaPwUwVghZn9Jisri9HzX0plEHuvrRu2qxW74AqeNGf8eKk
         KZNN+IdcPduuRJJuPHMyQ/Wo+y9GBQDMtyKx+rbVQOUHJRC1/Uk6EyD+AEMMZiWBBFnk
         yJ+xL0NBALIifCIO9X7ncLxEpoHDsgAV0JzhuJA5vhpB5p82OR90CGnJ8h6RKMyFj7xL
         V60Q1Juh68HPQPuHaYSQB/KenVA7usLPla0Gp4iTzeBZdo4WCwuYayOSbP8MqNZEjDMV
         iD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974968; x=1685566968;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0PMc06A2yO1+4gBCh6kqZ9mPyJIp2PmIrRbClN4AUU=;
        b=ccCoKcZtW9Ty5d/AiEFpm072jMU/i2ch4tXVxQTCOgVt3gmt4wPv7HVDmf4008k7WJ
         WxWAmq1K0BR/1m4IywAJtTywwU4kHQlZDZPZEbHQGLMQy6Im6tXqoXPci6UoiGod5y53
         HndJvvlUXHMAqtaWVEsXacoTef4C9YSHJ9v19bV4DCD3ar9npjfMTDCTzIURt63Nw28/
         XgSgK7SKlW9SdXQNOgdAD2seWmcG8DbZkT0/W4kKByQRc2ivB7CwRTYJeRcWR4Sgphk2
         tQ2lBnw5LrJOYCYzEA0xFJ+sSwGkamfG9AlElpy9FELLNGs8WqSBeEF3ncMLowVWRD7j
         gYhw==
X-Gm-Message-State: AC+VfDyJYIqOOIdN5l8AtnmteaFAejw8/EG2h55sO2+qCm/8chZBXyCY
        rVM+NTkYL1/9OPdNt0lA7j82fg==
X-Google-Smtp-Source: ACHHUZ7JntkrxpTw7Ce1AQ2PUesqX2qhhXG3Smz+hSrCFgp2HGEQOm3YMYdv9ENcPs4dJ+3sdr21MA==
X-Received: by 2002:a05:6a20:3c8b:b0:f2:93b7:a452 with SMTP id b11-20020a056a203c8b00b000f293b7a452mr18876852pzj.4.1682974968123;
        Mon, 01 May 2023 14:02:48 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:1f1:1360:eb9b:387])
        by smtp.gmail.com with ESMTPSA id i12-20020a056a00224c00b0063d670ad850sm20899151pfu.92.2023.05.01.14.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:02:47 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 01 May 2023 14:05:22 -0700
Subject: [PATCH RFC v2 2/2] RISC-V: Add support for sqoscfg CSR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230430-riscv-cbqri-rfc-v2-v2-2-8e3725c4a473@baylibre.com>
References: <20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com>
In-Reply-To: <20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682975186; l=7192;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=pWQVrZDB0/WwGsPOU+vgZxpwWoA9+OJKEaCTiIWYn6w=;
 b=VjMXT5Dzf04LphERS+3SbW74JjkhLQUHjOPgLeAFISnPcRs305me/gjpnAkZckj+fzNbuxsdN
 vRjJTMbr2LrCpv4aWJlJNcPV4OIZOMfcc9gZEKjrBn+TM89MWzdC+3C
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the sqoscfg CSR defined in the Ssqosid ISA extension
(Supervisor-mode Quality of Service ID). The CSR contains two fields:

  - Resource Control ID (RCID) used determine resource allocation
  - Monitoring Counter ID (MCID) used to track resource usage

Requests from a hart to shared resources like cache will be tagged with
these IDs. This allows the usage of shared resources to be associated
with the task currently running on the hart.

A sqoscfg field is added to thread_struct and has the same format as the
sqoscfg CSR. This allows the scheduler to set the hart's sqoscfg CSR to
contain the RCID and MCID for the task that is being scheduled in. The
sqoscfg CSR is only written to if the thread_struct.sqoscfg is different
from the current value of the CSR.

A per-cpu variable cpu_sqoscfg is used to mirror that state of the CSR.
This is because access to L1D hot memory should be several times faster
than a CSR read. Also, in the case of virtualization, accesses to this
CSR are trapped in the hypervisor.

Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/Kconfig                 | 19 +++++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 +++++++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 43 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 +++
 arch/riscv/kernel/Makefile         |  1 +
 arch/riscv/kernel/qos/Makefile     |  2 ++
 arch/riscv/kernel/qos/qos.c        |  5 +++++
 8 files changed, 84 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c58d74235363..4de2ce69f9fa 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -409,6 +409,25 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSQOSID
+	bool "Ssqosid extension support for supervisor mode QoS ID"
+	default y
+	help
+	  Adds support for the Ssqosid ISA extension (Supervisor-mode
+	  Quality of Service ID).
+
+	  Ssqosid defines the sqoscfg CSR which allows the system to tag
+	  the running process with RCID (Resource Control ID) and MCID
+	  (Monitoring Counter ID). The RCID is used determine resource
+	  allocation. The MCID is used to track resource usage in event
+	  counters.
+
+	  For example, a cache controller may use the RCID to apply a
+	  cache partitioning scheme and use the MCID to track how much
+	  cache a process, or a group of processes, is using.
+
+	  If you don't know what to do here, say Y.
+
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 7c2b8cdb7b77..17d04a0cacd6 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -59,6 +59,13 @@
 #define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
 
+/* SQOSCFG fields */
+#define SQOSCFG_RCID_MASK	_AC(0x00000FFF, UL)
+#define SQOSCFG_MCID_MASK	SQOSCFG_RCID_MASK
+#define SQOSCFG_MCID_SHIFT	16
+#define SQOSCFG_MASK		((SQOSCFG_MCID_MASK << SQOSCFG_MCID_SHIFT) | \
+				  SQOSCFG_RCID_MASK)
+
 /* Exception cause high bit - is an interrupt if set */
 #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
 
@@ -245,6 +252,7 @@
 #define CSR_STVAL		0x143
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
+#define CSR_SQOSCFG		0x181
 
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..724b2aa2732d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -39,6 +39,9 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+	u32 sqoscfg;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
new file mode 100644
index 000000000000..9d0fe1ac1b34
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_QOS_H
+#define _ASM_RISCV_QOS_H
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+
+#include <linux/sched.h>
+#include <linux/jump_label.h>
+
+#include <asm/barrier.h>
+#include <asm/csr.h>
+#include <asm/hwcap.h>
+
+/* cached value of sqoscfg csr for each cpu */
+DECLARE_PER_CPU(u32, cpu_sqoscfg);
+
+static inline void __switch_to_sqoscfg(struct task_struct *prev,
+				       struct task_struct *next)
+{
+	u32 *cpu_sqoscfg_ptr = this_cpu_ptr(&cpu_sqoscfg);
+	u32 thread_sqoscfg;
+
+	thread_sqoscfg = READ_ONCE(next->thread.sqoscfg);
+
+	if (thread_sqoscfg != *cpu_sqoscfg_ptr) {
+		*cpu_sqoscfg_ptr = thread_sqoscfg;
+		csr_write(CSR_SQOSCFG, thread_sqoscfg);
+	}
+}
+
+static __always_inline bool has_sqoscfg(void)
+{
+	return riscv_has_extension_likely(RISCV_ISA_EXT_SSQOSID);
+}
+
+#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
+
+static __always_inline bool has_sqoscfg(void) { return false; }
+#define __switch_to_sqoscfg(__prev, __next) do { } while (0)
+
+#endif /* CONFIG_RISCV_ISA_SSQOSID */
+
+#endif /* _ASM_RISCV_QOS_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 60f8ca01d36e..79e8e907d7a6 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/qos.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -78,6 +79,8 @@ do {							\
 	struct task_struct *__next = (next);		\
 	if (has_fpu())					\
 		__switch_to_aux(__prev, __next);	\
+	if (has_sqoscfg())				\
+		__switch_to_sqoscfg(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 0fee73a20c87..22c18b916212 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
 
 obj-$(CONFIG_64BIT)		+= pi/
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos/
diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makefile
new file mode 100644
index 000000000000..9f996263a86d
--- /dev/null
+++ b/arch/riscv/kernel/qos/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o
diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
new file mode 100644
index 000000000000..a6956664dfe1
--- /dev/null
+++ b/arch/riscv/kernel/qos/qos.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <asm/qos.h>
+
+/* cached value of sqoscfg csr for each cpu */
+DEFINE_PER_CPU(u32, cpu_sqoscfg);

-- 
2.34.1

