Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1361F6CA2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjC0L6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjC0L6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:58:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657435B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:58:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso11601341pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679918310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LV9la5f2Alty6EKhNfpDearvf5tbwwgFKDMkwlyKPtE=;
        b=GiLwRJUOrKqj5W/x6KqK8UEqfjHXn/4U7CcAA3l7VEKUrLnhhrYxJXxqRd0Ub583gH
         wldPDbWqqe15vuPBf/SoYxURgxtdxIVl1avGkwN9PMj+vGfEEBuEV7Ev7OBIKR+ITanF
         PGto16BPPgcDSUjFniOtA94AjsxPmRGxlAR/i8AD8sYIbZseVkQYk1236f3wQZQx3Qov
         tlH6cXS3OZqXjXwSqKzK39kWqryHCFK43SxGiOYylmXfcSxB0zLgyhbM0dJHLO5Jb0AK
         f1N0nLfDLq1++CnyON6lKm4PmB1NGt4CSRJfpvCevoYgDONvfCRW9Sj1VAYrzljj6Wsr
         /SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679918310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LV9la5f2Alty6EKhNfpDearvf5tbwwgFKDMkwlyKPtE=;
        b=EmanuUq2+YXjon8/5irAY4+Lm8ZVFRwRMv29j9nm7fOxZVq5pP5Hczh5F+bHVptas6
         zQ/RU4o5mHwONGozbXTAb84zD6kKak4DuMxVqy7ZVPRWO3q53HYzTgf3uslnUrCJSqBU
         1CLwkykYSyVr1M/NVbKRYLTH7qzGxw3vF/N8xQ3y/fY5MBMHezxh9Cpi9YR34C+E0/Rl
         1Zj3z+2OY3trHgZhFYry5kBz24hISCmj8inppGeEivyKe+on25qroMu/ZcuIGaLffyr4
         9vk0+BOFa96ZoSFo9KI76Bc3p54dWQWkSRUN2IoSeTiDtCt2vBJnVNWG3rgxQSL0CXZC
         jtoQ==
X-Gm-Message-State: AAQBX9dZjuo77rmyCUuX0H+K+ZUgHLzBYC3bT7Hgq0v4DB1/xGQvvoSX
        Fh7qaULB1rWc7nbgjcXrHnHx2iqGwHxnyrw0xCzvWQ==
X-Google-Smtp-Source: AKy350Zva3pWuTyJ13bSraEd0rO2c/BK8g8uliYwap6yoKykNA2lwCZFLn8j/hfhi+yYc+1RHoFB8w==
X-Received: by 2002:a17:90b:38d2:b0:234:dc4:2006 with SMTP id nn18-20020a17090b38d200b002340dc42006mr13442400pjb.4.1679918310187;
        Mon, 27 Mar 2023 04:58:30 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([2408:8606:1800:501::2:2])
        by smtp.gmail.com with ESMTPSA id t8-20020a63dd08000000b00502ecb91940sm17959536pgg.55.2023.03.27.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:58:29 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, cuiyunhui@bytedance.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv/fault: Dump user opcode bytes on fatal faults
Date:   Mon, 27 Mar 2023 19:56:42 +0800
Message-Id: <20230327115642.1610-1-cuiyunhui@bytedance.com>
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

We encountered such a problem(logs are below). We are more curious about
which instruction execution caused the exception. After dumping it
through show_opcodes(), we found that it was caused by a floating-point
instruction.

In this way, we found the problem: in the system bringup , it is
precisely that we have not enabled the floating point function.

So when an exception occurs, it is necessary to dump the instruction
that caused the exception, like x86/fault (ba54d856a9d8).

Logs:
[    0.822481] Run /init as init process
[    0.837569] init[1]: unhandled signal 4 code 0x1 at 0x000000000005e028 in bb[10000+5fe000]
[    0.932292] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00048-g4a843c9043e8-dirty #138
[    0.932949] Hardware name:  , BIOS
[    0.933399] epc : 000000000005e028 ra : 000000000007c7c4 sp : 0000003fffd45da0
[    0.933855]  gp : ffffffff816ea2d8 tp : 0000000000000000 t0 : 0000000000000000
[    0.934303]  t1 : 0000003fffd35df0 t2 : 0000000000000000 s0 : 0000000000000000
[    0.934734]  s1 : 0000000000000000 a0 : 0000003fffd36190 a1 : 0000003fffd45e18
[    0.935200]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[    0.935622]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
[    0.936073]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
[    0.936495]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
[    0.936947]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
[    0.937487]  s11: 0000000000d14980 t3 : 0000000000000000 t4 : 0000000000000000
[    0.937954]  t5 : 0000000000000000 t6 : 0000000000000000
[    0.938510] status: 0000000200000020 badaddr: 00000000f0028053 cause: 0000000000000002

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/bug.h |  1 +
 arch/riscv/kernel/process.c  | 30 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c    |  1 +
 3 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index d3804a2f9aad..77655dd10a2c 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -86,6 +86,7 @@ struct pt_regs;
 struct task_struct;
 
 void __show_regs(struct pt_regs *regs);
+void show_opcodes(struct pt_regs *regs);
 void die(struct pt_regs *regs, const char *str);
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr);
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..759dc74fe160 100644
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
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0a98fd0ddfe9..a6f6851e4e87 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -68,6 +68,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
+		show_opcodes(regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-- 
2.20.1

