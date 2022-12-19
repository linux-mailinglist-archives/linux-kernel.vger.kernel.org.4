Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0F650A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLSKZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiLSKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:25:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E62BFF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:25:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fy4so8613140pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi3gpq9hnnVh1G3NTQ1MirWR5bKsTeEH2CH3CJi0VpU=;
        b=BMft+u0nyKZnjgqVhQRPY1+VVQmfb8C1AsWz81oiPKNLTYQUhGFzZH8cgAH2veijTO
         a0ShS/Ivg3KNm0JS9YZHSbtwadKt0w5H2pUVpozu4jWrZXfGGc3T237J01JY21b5CZxZ
         2uJElRt65V5xVRZM+0JhyTDdTqkBWxLDzZwEowpXVDrW5tBtQNcAz1FLH2L7Cocl7c+E
         GirmdAuk4Bflpt3iaz2hFnr4V6i2vyyMtSWK9w0FKXLm3pJTGUmiShUBwctxeYMCJZrL
         /ertytA7IbdjYUuyDMS4M3nuFATScKnVxV1e0TqF966LZdSEhzVL5hMVSotfY8laLLsy
         3/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi3gpq9hnnVh1G3NTQ1MirWR5bKsTeEH2CH3CJi0VpU=;
        b=BKTX4GVqfTcJGiIB3IArGJuC4iDSf68AidO968wYbsDSX3HOdKWNOquxmB3qVQPRll
         bVQiQg7BPM7M7WF45U/0AKdVLpzMR9iaFv4REVMkbUs2UN6b/2p0EnfW2GiQhQKPb7ba
         wmcy33ek/5L/u8gEeotdOX05wGcW04tWeaUa3Jg2cyPWRXnZu/9kOaMe0Y8wrSYRrZi8
         jbKsADhXjdHIVKyqooKdGR0XPrq8GE2mXys4BXH4Cr+3APNr3yRw5J88XzDpNYCUPsof
         tWup+SuxBzDVT+/l6FbgAk9pzoWlFqxnmis+tTCz1E/7rhegA+4oZMBqYjT+UNS1n9EE
         Lslw==
X-Gm-Message-State: ANoB5pl6v6xamiL7OBNcoYyXv+0z6zLxT9nrbPF431ltr4Nz9//C5599
        ZPHh2LWpnQeVrEZTrw1wgA2bZQ==
X-Google-Smtp-Source: AA0mqf5Dr0aghsXn629RB3zoEJykFlGCTYQQYJJsr63zOeUXQLTuXuqjXi5xFANt90MChLGN1/o56Q==
X-Received: by 2002:a17:90b:4a85:b0:21e:1c8e:f791 with SMTP id lp5-20020a17090b4a8500b0021e1c8ef791mr40781421pjb.31.1671445507740;
        Mon, 19 Dec 2022 02:25:07 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.5])
        by smtp.gmail.com with ESMTPSA id 89-20020a17090a0fe200b0020087d7e778sm8832731pjz.37.2022.12.19.02.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:25:07 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org
Cc:     liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 1/2] arm64: entry: Skip single stepping into interrupt handlers
Date:   Mon, 19 Dec 2022 15:54:51 +0530
Message-Id: <20221219102452.2860088-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219102452.2860088-1-sumit.garg@linaro.org>
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on systems where the timer interrupt (or any other
fast-at-human-scale periodic interrupt) is active then it is impossible
to step any code with interrupts unlocked because we will always end up
stepping into the timer interrupt instead of stepping the user code.

The common user's goal while single stepping is that when they step then
the system will stop at PC+4 or PC+I for a branch that gets taken
relative to the instruction they are stepping. So, fix broken single step
implementation via skipping single stepping into interrupt handlers.

The methodology is when we receive an interrupt from EL1, check if we
are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
clear the register bit if it was set. Then unmask only D and leave I set.
On return from the interrupt, set D and restore MDSCR_EL1.SS. Along with
this skip reschedule if we were stepping.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/kernel/entry-common.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cce1167199e3..688d1ef8e864 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -231,11 +231,15 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
 #endif
 
-static void __sched arm64_preempt_schedule_irq(void)
+static void __sched arm64_preempt_schedule_irq(struct pt_regs *regs)
 {
 	if (!need_irq_preemption())
 		return;
 
+	/* Don't reschedule in case we are single stepping */
+	if (!(regs->pstate & DBG_SPSR_SS))
+		return;
+
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
 	 * and thread_info::need_resched, and is not equivalent to
@@ -471,19 +475,33 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	arm64_preempt_schedule_irq();
+	arm64_preempt_schedule_irq(regs);
 
 	exit_to_kernel_mode(regs);
 }
+
 static void noinstr el1_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
+	unsigned long mdscr;
+
+	/* Disable single stepping within interrupt handler */
+	if (regs->pstate & DBG_SPSR_SS) {
+		mdscr = read_sysreg(mdscr_el1);
+		write_sysreg(mdscr & ~DBG_MDSCR_SS, mdscr_el1);
+	}
+
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
 	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
 		__el1_pnmi(regs, handler);
 	else
 		__el1_irq(regs, handler);
+
+	if (regs->pstate & DBG_SPSR_SS) {
+		write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
+		write_sysreg(mdscr, mdscr_el1);
+	}
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
-- 
2.34.1

