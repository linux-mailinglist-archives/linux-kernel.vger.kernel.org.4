Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0737473C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGDOMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGDOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:12:07 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599010DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:12:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7e0904a3aso6750085ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479924; x=1691071924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzBMq7R5xdVR7lBpakM9B1ewv3x8Aa9s+j6b6UY73u8=;
        b=hvWRzizVS0S/x2p6tjb3F48jVU/dzlutZSlw8XrL7FD9+thr9gbw2aaqzN6tsZKoSd
         2Bjqk1qks5xIwsaJ5NMkcL3bSJO3KnFhsi8534y5jjbxdzdwq4hYpuTmR0c/k45hkPI2
         SSdqBN/57ipAVGH1Gmk3Z0hN+ryPyEr6Ch9u/lhiHjq9W0Pgu99Ycd3dgy18oVMArTzR
         FDcNwx83BA3zeK//pwth3Bbji/waAPqqHxWVDJ1Vp+S5bLt98xaY0nfYjzC4wA1iq9J4
         3Q8qbgzRw4CdhSpw1qzUM16Xpz1Oqy8g8bQnaf8MFIkxMvSrkE9rIuIugOSVUf1/Mp3k
         YBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479924; x=1691071924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzBMq7R5xdVR7lBpakM9B1ewv3x8Aa9s+j6b6UY73u8=;
        b=ULOz/atDkVU7tYqPTi1QCQUAkmT7Zjo1TO2Qe700oIG0frLTQvlrbPsm3Hu4uN7Ttc
         OetnjhDurgNMbCbgyYlWc9JftKg+Z2Qy1INv8QNvcn98p5AB1Ug43Q/MdN6WyIIRNEAi
         X/Ty2mQcNWHl1ZU4vr04tn0/b/N52QsnFCkN22YbwFlWPugxPYVCVvs1/BYMgQY+iWl9
         0vlTuSJLsF7JyZsSgxeoVwkHQxEgNVvxYyACW/Dx6RYfm3v8VymNS5VOXmIaEEWBFnPb
         tmp6teV9dtsUDoA7vZQWW0TqcQkesJ+lxpoODJrlmChGfbIEFU2pQrlNjQ8tVspJO9YX
         FmeA==
X-Gm-Message-State: ABy/qLa+JO7pVulNeIThuseGGFC8eLcNq3Vr+/JHTET3o6nB/b7rMvt8
        n0EzkJpqtEb7m9Zwy7D+qyxQdw==
X-Google-Smtp-Source: APBJJlE8+jXKSctC4pk5eGzZC4+H+KcnNBUni6PU53miDEBuzspFdXv1MB6i2skH6gE/0p6Td5KxSA==
X-Received: by 2002:a17:903:786:b0:1b3:ec39:f42c with SMTP id kn6-20020a170903078600b001b3ec39f42cmr13861775plb.5.1688479923889;
        Tue, 04 Jul 2023 07:12:03 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:12:03 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 PATCH 8/9] riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
Date:   Tue,  4 Jul 2023 16:09:23 +0200
Message-Id: <20230704140924.315594-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704140924.315594-1-cleger@rivosinc.com>
References: <20230704140924.315594-1-cleger@rivosinc.com>
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

Now that trap support is ready to handle misalignment errors in S-mode,
allow the user to control the behavior of misalignment accesses using
prctl(). Add an align_ctl flag in thread_struct which will be used to
determine if we should SIGBUS the process or not on such fault.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  |  8 ++++++++
 arch/riscv/include/asm/processor.h   |  9 +++++++++
 arch/riscv/kernel/process.c          | 18 ++++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c |  7 +++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 7e968499db49..e2fd6fc7157f 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_CPUFEATURE_H
 #define _ASM_CPUFEATURE_H
 
+#include <asm/hwprobe.h>
+
 /*
  * These are probed via a device_initcall(), via either the SBI or directly
  * from the corresponding CSRs.
@@ -20,6 +22,12 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 DECLARE_PER_CPU(long, misaligned_access_speed);
 
+static inline bool misaligned_access_emulated(void)
+{
+	return per_cpu(misaligned_access_speed, 0) ==
+					RISCV_HWPROBE_MISALIGNED_EMULATED;
+}
+
 void __init misaligned_emulation_init(void);
 
 #endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..4e6667d5ca68 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PROCESSOR_H
 
 #include <linux/const.h>
+#include <linux/prctl.h>
 
 #include <vdso/processor.h>
 
@@ -39,6 +40,7 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+	unsigned long align_ctl;
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -51,6 +53,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 
 #define INIT_THREAD {					\
 	.sp = sizeof(init_stack) + (long)&init_stack,	\
+	.align_ctl = PR_UNALIGN_NOPRINT,		\
 }
 
 #define task_pt_regs(tsk)						\
@@ -80,6 +83,12 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+extern int get_unalign_ctl(struct task_struct *, unsigned long addr);
+extern int set_unalign_ctl(struct task_struct *, unsigned int val);
+
+#define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
+#define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e2a060066730..88a71359396b 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -24,6 +24,7 @@
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
 #include <asm/cpuidle.h>
+#include <asm/cpufeature.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -40,6 +41,23 @@ void arch_cpu_idle(void)
 	cpu_do_idle();
 }
 
+int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
+{
+	if (!misaligned_access_emulated())
+		return -EINVAL;
+
+	tsk->thread.align_ctl = val;
+	return 0;
+}
+
+int get_unalign_ctl(struct task_struct *tsk, unsigned long adr)
+{
+	if (!misaligned_access_emulated())
+		return -EINVAL;
+
+	return put_user(tsk->thread.align_ctl, (unsigned long __user *)adr);
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	show_regs_print_info(KERN_DEFAULT);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 243ef9314734..5fb6758b0bf9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -9,6 +9,7 @@
 #include <linux/perf_event.h>
 #include <linux/irq.h>
 #include <linux/stringify.h>
+#include <linux/prctl.h>
 
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -305,6 +306,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 	if (!unaligned_enabled)
 		return -1;
 
+	if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -398,6 +402,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 	if (!unaligned_enabled)
 		return -1;
 
+	if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-- 
2.40.1

