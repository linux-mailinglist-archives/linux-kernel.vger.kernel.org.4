Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3AF6CD499
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjC2Iai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjC2Iag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:30:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB9268B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:30:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id fd25so9761332pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680078634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1Or5bDbG7pY6oTZ/LXhOi2Wc2GzPwk9E7MW4Vddhkk=;
        b=SMOY6yF468+WcCeHsXCJ8Fzv6o84CIyGjKt/mmVuvvhHoiXzjAhLUoCc7MScSHQ4NS
         HcerTmICPy7F4FO9iZP+qItxyFMVyUTZGvTFkJ6/gpLuW5NTaKIoI/NxA7jKCDXVq2R/
         tvP40V5+Zmp3CLAeCjvXam/Bs+GOpGSwxFvyHAKWecLY/1br165z3TVhZ2YLAztyTX6I
         meV8hu/SI7c9TK9MDfnKEnekGew324t92Dem0pYNqC2dw57a9PT9LE765sKY34mmPQaz
         PpOF24nILD9MCWaUK2FhyqZokMtSsM2YT2UEAczTrVA92gopTzhGqE7Jk+/VEveo9PDD
         puaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1Or5bDbG7pY6oTZ/LXhOi2Wc2GzPwk9E7MW4Vddhkk=;
        b=jAWkbsSVvmyQVuG2uAU2rsKewyTrk+FormAfJW7rnJSXyPMdRwGKcQo/XcjDFoeW7J
         C04g+F/t8OOtcblm6QS5Ye3v6nlWezC8GR5wrefINU2Vi8tcuhJPGMQtgRfCHi+0ZbnT
         KEft1UMsA0vViNW6iQEZwWeO1d0eq359M/dKSzdULG6guf6faXKdu8PCVUC64nQkTIs9
         zSAzlcY0vQZ/hrSpzt6Ddv8TDJJZmttEs1v6ncjnZvbI2a96j2gS9X6rr7c70P7GhiYX
         YzbiQ9WFkt/xgzlz5MIDKgL/O4717DIr+mgeF1gkdgK2O2cPMwI6v7Xe0TfstnLAyhs4
         fFtQ==
X-Gm-Message-State: AAQBX9dLP5hqFXOYd1TcBc8WBS2262B/Zb0gZdtIlMBuO1kSVtjM7ykB
        ZAEid39lu3NgSH14BULGIRxpvQ==
X-Google-Smtp-Source: AKy350a/RT33ojzlmmiLVq9LXv3UGFykrkRXqZARMk0sJqJJmIIx1NaHDOg0tCERw2PtZt/2JjyiSA==
X-Received: by 2002:aa7:95a4:0:b0:628:cff:1440 with SMTP id a4-20020aa795a4000000b006280cff1440mr18379267pfk.28.1680078634640;
        Wed, 29 Mar 2023 01:30:34 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([2408:8606:1800:501::1:3])
        by smtp.gmail.com with ESMTPSA id g11-20020a62e30b000000b006281bc04392sm845676pfh.191.2023.03.29.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:30:34 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     conor.dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mpe@ellerman.id.au, jpoimboe@kernel.org, mark.rutland@arm.com,
        svens@linux.ibm.com, cuiyunhui@bytedance.com, guoren@kernel.org,
        jszhang@kernel.org, ebiederm@xmission.com, bjorn@rivosinc.com,
        heiko@sntech.de, xianting.tian@linux.alibaba.com,
        mnissler@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Dump user opcode bytes on fatal faults
Date:   Wed, 29 Mar 2023 16:29:50 +0800
Message-Id: <20230329082950.726-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encountered such a problem that when the system starts to execute
init, init exits unexpectedly with error message: "unhandled signal 4
code 0x1 ...".

We are more curious about which instruction execution caused the
exception. After dumping it through show_opcodes(), we found that it
was caused by a floating-point instruction.

In this way, we found the problem: in the system bringup , it is
precisely that we have not enabled the floating point function(CONFIG_FPU
is set, but not enalbe COMPAT_HWCAP_ISA_F/D in the dts or acpi).

Like commit ba54d856a9d8 ("x86/fault: Dump user opcode bytes on fatal
faults"), when an exception occurs, it is necessary to dump the
instruction that caused the exception.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/bug.h |  1 +
 arch/riscv/kernel/process.c  | 30 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c    |  1 +
 3 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..56dab998d05d 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -86,6 +86,7 @@ struct pt_regs;
 struct task_struct;
 
 void __show_regs(struct pt_regs *regs);
+void show_opcodes(struct pt_regs *regs);
 void die(struct pt_regs *regs, const char *str);
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr);
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 774ffde386ab..9ba9f8719605 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,6 +83,36 @@ void show_regs(struct pt_regs *regs)
 		dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
+static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
+		     unsigned int nbytes)
+{
+	if (!user_mode(regs))
+		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
+
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
+
+	return copy_from_user_nofault(buf, (void __user *)src, nbytes);
+}
+
+void show_opcodes(struct pt_regs *regs)
+{
+	u8 opcodes[4];
+
+	switch (copy_code(regs, opcodes, regs->epc, sizeof(opcodes))) {
+	case 0:
+		pr_info("Opcode: %4ph", opcodes);
+		break;
+	case -EPERM:
+		pr_err("Unable to access userspace of other tasks");
+		break;
+	default:
+		pr_err("Failed to access opcode");
+		break;
+	}
+}
+
 #ifdef CONFIG_COMPAT
 static bool compat_mode_supported __read_mostly;
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f6fda94e8e59..892826234ee9 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -100,6 +100,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
+		show_opcodes(regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-- 
2.20.1

