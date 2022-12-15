Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82864DCDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLOO30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLOO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:29:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F125F2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:29:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2833852pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01a2UV5FsPpOUVUYf2R+k+b8Dh0cH0M3wFlrMUvhruw=;
        b=HqUCLpNQ4nZIY3dP3D3DeWny5wH83I40YR+GanSSNBRAdmWYA6Auprhi94xLnHVRVn
         IpyiPDX0w3v1al7y1sa3Wl12jQl2T4deTeZWF94P/3ojQhTfuyjRlLOD6I5/NLpJL0H2
         6kwyB3Gvovd8EqEfdJUknFfERUe7t3NtWFLEI+n5NielFJjfpoBn61HfitkLaV/p6dqK
         vDEd278TQv9u+wqxp3VNp5eUXKlaOHvqnQE31XHxNBSzTyygOlB11vjuTTUdLvIW7Pjv
         PgTXb7djiM10JmiwNbgmgCzjFDtmr/4MY96LJ5HY3t9EG7Cs5ht4Gm3gQFjr7L3dFbGx
         UItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01a2UV5FsPpOUVUYf2R+k+b8Dh0cH0M3wFlrMUvhruw=;
        b=0lLbJd3OzvMZT4bC0AjDSothwgwRVb0DKcD+EwusnOlFiPdlRN4ey5UltUAhsPRBV8
         2Uq3iy5YNQ5nEH7gryErt7Sg63g7Jzm85QaSdgR6NccTxsIK+dRZtQDn9D2wEu4nrF2Y
         rJBwb8zfbTpRzZ0JAr5pD6EqFvTIvJoml/+we5f16azhD4h+303SeyOxrka70Lq3PoRm
         HWM4pQyLPsPbWyXT+V+/um+gwD5CCIxEZ/ljL5OWyPVdlMGynwKjU50S4jR5zDJ8fj9c
         NYLwfoySXy9j1JSWYUB3h0C8/pEF8iSeCttF6crWi4qCLuyoNCUFiqxr1q5+NZ2fwjP6
         Tu+g==
X-Gm-Message-State: ANoB5pnTLbh2YmL7KjoPlXizZjwFW0Y4aV/0jMD2FGENE4aNDuOUmyL1
        DC7dPvADKQvOPRpZEeEX0QjR3w==
X-Google-Smtp-Source: AA0mqf7jFS4uGcfnthwZ1zlzzH60cSbqUyCuf8d8mJjKAz8olDA+3XLE/2sQ74av8ehBOHBcQE3qZw==
X-Received: by 2002:a17:902:cf12:b0:186:a5a7:cc4e with SMTP id i18-20020a170902cf1200b00186a5a7cc4emr33472597plg.17.1671114562277;
        Thu, 15 Dec 2022 06:29:22 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.45])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0017f5ad327casm3922010plf.103.2022.12.15.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:29:22 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org
Cc:     liwei391@huawei.com, mark.rutland@arm.com, mhiramat@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/2] arm64: entry: Skip single stepping into interrupt handlers
Date:   Thu, 15 Dec 2022 19:59:02 +0530
Message-Id: <20221215142903.2624142-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215142903.2624142-1-sumit.garg@linaro.org>
References: <20221215142903.2624142-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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
 arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cce1167199e3..53bcb1902f2f 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -471,19 +471,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	arm64_preempt_schedule_irq();
+	/* Don't reschedule in case we are single stepping */
+	if (!(regs->pstate & DBG_SPSR_SS))
+		arm64_preempt_schedule_irq();
 
 	exit_to_kernel_mode(regs);
 }
+
 static void noinstr el1_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
+	unsigned long reg;
+
+	/* Disable single stepping within interrupt handler */
+	if (regs->pstate & DBG_SPSR_SS) {
+		reg = read_sysreg(mdscr_el1);
+		write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
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
+		write_sysreg(reg, mdscr_el1);
+	}
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
-- 
2.34.1

