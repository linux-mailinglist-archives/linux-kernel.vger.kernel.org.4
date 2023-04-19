Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABEC6E782E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjDSLKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjDSLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:10:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813414F51
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a6670671e3so26993515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902611; x=1684494611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9eEO9ZSQHehmRVwlaaNhzbm/IQf1ILPfvFx8ATSlnk=;
        b=nM88pRf/8GbdydpA0PP59ZJw6KWtk+CReKDnuabgXXMLywUgP8jhNzJYgb+cjDguai
         OwcZks3oek4D8CauNV//M+GGG84t9v8BrXspxTYPgj7NoYmjKUFElRaaahMEE0bo6GAZ
         FtdkgabxoZkOMQNnXOB3g9hc4yKmhsOxhjccntE7GQ7MO7BlGELiFMFHqVKcxoxYa+D/
         UGrVjOBB/J4w3p2eo9fxlnm9kLTKgC25ESbticBubAHIxpm4o0/6AyM2fj10z3HC7k8p
         kORWjTcvG2LSfK/BXCcK7QTGjUOLUeviuj3O4CtyJ2TPGJzX7UHGVgZ0baILjf5rs3jp
         kBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902611; x=1684494611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9eEO9ZSQHehmRVwlaaNhzbm/IQf1ILPfvFx8ATSlnk=;
        b=Y52We7IkdfJxarOnDYkuRpoHYRpHUeOMGq6JWygqBQQ4NbEGJP/OumgIRn39QnM2F4
         xzQIxBawGKK2CZJ08P2P5kG4b//tHZ1CMNMsHuZMCYY4vVEIYwSuvSio9XS8gu7Arttt
         MAm2bCPGC0Jz6R919XS5Z/gi0ZhEGYzw3tfRhhxj0XQI0ELSt5G2OMSoEOdz0nUxzrRt
         AwU+s/5fG8iSYjm66bCDgQn2x271FusokJzGJ5gT366hxR0T3VRssCfAXGKn+MxFGguP
         0QeQVVfge/Rj5CRgzWk6POezA+M2TUEj7aeXhNjabHYwOJtMkmLOwmykrme6qiG2vyF+
         KBNA==
X-Gm-Message-State: AAQBX9faW6Ic4+dIJzGI4h70q17uWzDtZWu78+3i8Mgb6uYr6i9cDkeL
        a8RBUL9u3DgkBP5FQ8UiicF17w==
X-Google-Smtp-Source: AKy350bhv5stQ0WnqrTJGtJwB7abMIt3eVgi0yKf8TCk3qK2vODWs8w+pscnRiChOTW/REaSB/AhWA==
X-Received: by 2002:a17:902:e847:b0:1a4:ee94:a79c with SMTP id t7-20020a170902e84700b001a4ee94a79cmr5668813plg.14.1681902611548;
        Wed, 19 Apr 2023 04:10:11 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:09 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 02/21] RISC-V: Add support for sqoscfg CSR
Date:   Wed, 19 Apr 2023 04:10:52 -0700
Message-Id: <20230419111111.477118-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
than the current value of the CSR.

A per-cpu variable cpu_sqoscfg is used to mirror that state of the CSR.
This is because access to L1D hot memory should be several times faster
than a CSR read. Also, in the case of virtualization, accesses to this
CSR are trapped in the hypervisor.

Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Note:
- A version of this patch rebased on riscv/for-next was already
  submitted as an RFC to linux-riscv [1] with Message-ID:
    20230410043646.3138446-1-dfustini@baylibre.com
- This patch is included in this RFC series so as to provide a cohesive
  demonstration in one series.

[1] https://lore.kernel.org/lkml/20230410043646.3138446-1-dfustini@baylibre.com/

 arch/riscv/Kconfig                 | 19 ++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 ++++++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 40 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  2 ++
 5 files changed, 72 insertions(+)
 create mode 100644 arch/riscv/include/asm/qos.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..9d4c8c505191 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -398,6 +398,25 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSQOSID
+	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
+	default y
+	help
+	  Adds support for the Ssqosid ISA extension (Supervisor-mode
+	  Quality of Service ID).
+
+	  Ssqosid defines the sqoscfg CSR which allows the system to tag
+	  the running process with RCID (Resource Control ID) and MCID
+	  (Monitoring Counter ID). The RCID is used to determine resource
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
index 0e571f6483d9..ab222ca15799 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -60,6 +60,13 @@
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
 
@@ -246,6 +253,7 @@
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

