Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB173CAD1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjFXMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjFXMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:21:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E0213A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f80b192aecso4273505e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609263; x=1690201263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN/Bpcd3g2BBD8IENaIvpqjenPqBgjOGqqvyeNWy6hM=;
        b=S7Qug/L8+jW8rcAlVoty9CtIsTLlm7GoXtnsOASUOfExV8W14+nl81+uKtroNm1s07
         ioZUFXzxJ0BtUU4MvAuFR6D504wL5FcuBd5hiXnYgMjsGgVplXR0GsSKfG9K7psiptXp
         W+17RG3pSPSeeV46yBxeEUW62zoQZHRBxvcQaXqYN3lzAssysvZo5TKxpcNuxYdwyqhY
         FOfscDUcMo/1U+vvgocX47LDEnT0c1MhbXMqYYC30sF9/8XSLKfm9RTQfdX6kJKAJM6b
         Mzdvrof+ebl5xvWFGwb/njJC5xUgWaTdhgC+fFF5Qc9q5gagn9LPkooMcaJwEQxpuBuY
         /Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609263; x=1690201263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN/Bpcd3g2BBD8IENaIvpqjenPqBgjOGqqvyeNWy6hM=;
        b=I7dK5HdxM2yUX8jOn9kLlPPe4bWfSezk9qw0hM5JD/ZKXQ96f2vfUeyA+6IrX6LfPq
         jPRVwpfjpJI75frK0xZcv3mUqrm77Ky+70E59ncv4JEHvf0EXpupNCl1pUmUjboFS0Ia
         ffuu75Jc//QS7lJcQfRb/M9jM5BSYK8PWy/3WBwjaa3ehCM8Z9W4ojqEhEW4Eo9Q80/l
         GJWp7SgJe/A5cjl2QGP/bhNe4D4K+cwEDxiocIRnJYYZBBbGAP6xkbG0EISREO+T+s3J
         iOpChCd8z7v7+3LTtAiy+DVg/MIH1AZbvbc6qlFeCudYmG4q2vKj1KR7Fcs2bfsjqZRe
         +MHQ==
X-Gm-Message-State: AC+VfDzqg2KPQXxkKnA0hIe0MJvGMROOZKNE/2wxm83oMr7FTgOXvsDF
        jJiOByb3lH3fCt4z+3di0ft5+Q==
X-Google-Smtp-Source: ACHHUZ4N+s9JDq+KJBGUVTphvOM9RzUpUcJe7aoOxsQriy0LYzQji5fTNu3KxQojc980fZEbPL/iQQ==
X-Received: by 2002:a05:600c:19d2:b0:3f7:fb5d:6e7a with SMTP id u18-20020a05600c19d200b003f7fb5d6e7amr22343211wmq.0.1687609262634;
        Sat, 24 Jun 2023 05:21:02 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:21:02 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
Date:   Sat, 24 Jun 2023 14:20:48 +0200
Message-Id: <20230624122049.7886-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230624122049.7886-1-cleger@rivosinc.com>
References: <20230624122049.7886-1-cleger@rivosinc.com>
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
 arch/riscv/include/asm/processor.h   |  9 +++++++++
 arch/riscv/kernel/process.c          | 20 ++++++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c |  7 +++++++
 3 files changed, 36 insertions(+)

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
index e2a060066730..b8a41e3c1333 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -19,6 +19,7 @@
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/csr.h>
+#include <asm/sbi.h>
 #include <asm/stacktrace.h>
 #include <asm/string.h>
 #include <asm/switch_to.h>
@@ -40,6 +41,25 @@ void arch_cpu_idle(void)
 	cpu_do_idle();
 }
 
+int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
+{
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	if (!sbi_delegate_misaligned())
+		return -EINVAL;
+#endif
+	tsk->thread.align_ctl = val;
+	return 0;
+}
+
+int get_unalign_ctl(struct task_struct *tsk, unsigned long adr)
+{
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	if (!sbi_delegate_misaligned())
+		return -EINVAL;
+#endif
+	return put_user(tsk->thread.align_ctl, (unsigned long __user *)adr);
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	show_regs_print_info(KERN_DEFAULT);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index e4a273ab77c9..b828a0f3d4f7 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/stringify.h>
+#include <linux/prctl.h>
 
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -277,6 +278,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_RISCV_M_MODE) && !user_mode(regs))
 		return -1;
 
+	if ((current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(epc, &insn))
 		return -1;
 
@@ -373,6 +377,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_RISCV_M_MODE) && !user_mode(regs))
 		return -1;
 
+	if ((current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(epc, &insn))
 		return -1;
 
-- 
2.40.1

