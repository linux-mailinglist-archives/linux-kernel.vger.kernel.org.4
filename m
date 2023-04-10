Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623756DC31E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 06:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDJEed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJEeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 00:34:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A43C32
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 21:34:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a2b01f5ac0so4329595ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681101263; x=1683693263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sV0mvKgExLa61TD4oV6e6QKH6k26NRAsPw2q/sIptY=;
        b=6N1Ll4lBsBO3F91bivVGG+AcRkH/V9v3SFDbYGF2cCEpBJhibNkpWfo8heKOpf7PeK
         F4htyxI9Dzsm08ZBmm78EnbxOq6YeSU/xBzMATpQINRRofB/lY9rqR7w4EfOWgdxksSO
         2h62cr6TAWRwinrIs6rXe3mwgbVQBKnHkdeKrGdtbqOdBj5Q8XzLEnRIADWQMhWD3Aw0
         hgnJkZA3EPdkulfMJjrpFVtisYNK6fIvkXo4l/MAXgRGSB7t7VtsGojckzc4x6Ii5gjV
         Y+IEUomUc80/qXbyC1qQvS29gLmaPgyBI9lZKl7nJwwhA9C8IKdtvysEBzrcQS3TU9OZ
         e+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681101263; x=1683693263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sV0mvKgExLa61TD4oV6e6QKH6k26NRAsPw2q/sIptY=;
        b=HedksOqo7TK8nFUtSXyrzD6rEmqvVWC/sdQy85Ixk/nfjmPGYKQYUa63LsAGKW/Kn6
         WZfXFuEdnYugiEGlz9R9WTL70xwq6IcTSNR2KtR7G1oMO5Xchwz0i7ir5pRQiFHsrKeS
         hr5XyIH3seSFAS6QnWABjKdf0FtQ6yTxTiB5bARcDscN7Ugr+UYqLZyNjQ77qjq1jzyf
         7tgcPHKp4qtWzGoaI7hjtOk+tUWO+kPPCSDz7wkODzzXyGQtBBu9n/C63G/kLc8MaHuW
         bycLK96hUwlHChh7W7MR5Xi72Mow2I0CNpdEi3gEtfZTFASiTb2j1A+DDrxGeOPC9B7D
         21Og==
X-Gm-Message-State: AAQBX9dJFxxPRKILpCbAhyWsOSGB5VJoDh8SwcNbwrQEUyg+QJgjpWgi
        T6/oAtP2NOqlvURPRjMcT4bOwg==
X-Google-Smtp-Source: AKy350Zl7sZArfG8z0rXM1frr2iQuRxz40uDjDFFAuAI50yWPI44W7Qc7LrEGEUGP/9VaFa1Oc/fsw==
X-Received: by 2002:a62:5e41:0:b0:626:2ae6:31f6 with SMTP id s62-20020a625e41000000b006262ae631f6mr10982689pfb.7.1681101263359;
        Sun, 09 Apr 2023 21:34:23 -0700 (PDT)
Received: from x1.. ([2601:1c2:1801:d250:45c0:94f2:eea7:6dc3])
        by smtp.gmail.com with ESMTPSA id x24-20020aa793b8000000b00634a96493f7sm2394411pff.128.2023.04.09.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 21:34:22 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 2/2] RISC-V: Add support for sqoscfg CSR
Date:   Sun,  9 Apr 2023 21:36:46 -0700
Message-Id: <20230410043646.3138446-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410043646.3138446-1-dfustini@baylibre.com>
References: <20230410043646.3138446-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Link: https://github.com/riscv-non-isa/riscv-cmqri/blob/main/riscv-cbqri.pdf
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Note: the Ssqosid extension and CBQRI spec are still in a draft state.
The CSR address of sqoscfg is not final.

Changes from the original patch [1]:
- Rebase from 6.0 to 6.3
- Simplify per-cpu variable from struct to u32 with just sqoscfg
- Move qoscfg to thread_struct in arch/riscv/include/asm/processor.h
  This avoids changing task_struct in /include/linux/sched.h
- Reword commit description
- Reword Kconfig description

[1] https://github.com/rivosinc/linux/commit/8454b793a62be21d39e5826ef5241dfa06198ba9

 arch/riscv/Kconfig                 | 19 ++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 ++++++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 40 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  2 ++
 5 files changed, 72 insertions(+)
 create mode 100644 arch/riscv/include/asm/qos.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cc02eb9eee1f..03f22b7fe34b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -418,6 +418,25 @@ config RISCV_ISA_SVNAPOT
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSQOSID
+	bool "Ssqosid extension support"
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
 config RISCV_ISA_SVPBMT
 	bool "SVPBMT extension support"
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
index 000000000000..297e7fb64d80
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,40 @@
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
+static DEFINE_PER_CPU(u32, cpu_sqoscfg);
+
+static void __qos_sched_in(struct task_struct *task)
+{
+	u32 *cpu_sqoscfg_ptr = this_cpu_ptr(&cpu_sqoscfg);
+	u32 thread_sqoscfg;
+
+	thread_sqoscfg = READ_ONCE(task->thread.sqoscfg);
+
+	if (thread_sqoscfg != *cpu_sqoscfg_ptr) {
+		*cpu_sqoscfg_ptr = thread_sqoscfg;
+		csr_write(CSR_SQOSCFG, thread_sqoscfg);
+	}
+}
+
+static inline void qos_sched_in(struct task_struct *task)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_SSQOSID))
+		__qos_sched_in(task);
+}
+#else
+
+static inline void qos_sched_in(struct task_struct *task) {}
+
+#endif /* CONFIG_RISCV_ISA_SSQOSID */
+#endif /* _ASM_RISCV_QOS_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 60f8ca01d36e..75d9bfd766af 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/qos.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -79,6 +80,7 @@ do {							\
 	if (has_fpu())					\
 		__switch_to_aux(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
+	qos_sched_in(__next);				\
 } while (0)
 
 #endif /* _ASM_RISCV_SWITCH_TO_H */
-- 
2.34.1

