Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A61687664
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjBBHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:32:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996879F27
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:32:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so384210pjp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HVeXriudK8VUfG7IXky8/P1/K4exUTPN02+5x1/aWk=;
        b=tNE1hOqgyzfZrv+m53QDibjRnzkEoudW+5axJk7qRZPfiNx4ZPtPU43HSR6CGabcyb
         FfbVdMAMG/ozgNRH5OvsNSFeTJTAlKJwmQ6UJ+ixxNq6Sb8D3WBlnibGhvRFS/e2aQi/
         StiPFniJzGkzckBo0I/+nwJk2Lk6tacdFVbhFkdR0vUb65Lv3GBhDpz7dNxdVWmb+Cqo
         Gla0XpBP+XWOmZu8H01SS/pubQ73Og7aDtYUpQR5X0yhy4z8G32SJb7oFFnmqp4NjIuO
         4ycrTWlX56wBMM/mcWZtRCNdbQjwrLDKxRK+aTTfr0UBM5To6KnYk+MUWxF7J3WhIUyK
         fNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HVeXriudK8VUfG7IXky8/P1/K4exUTPN02+5x1/aWk=;
        b=FaTpDjk+yrNJregIrgu2sYz5j0rOXwh1LGWNCGWI43wOJZsjlu5pRF7nq/nZMZ4XBf
         dECsWPjVLg/W+nm99ZwJ3StZPJXXfQ7EW6t/elbxqX42aJuD9AbvZzXi3mQ2mAhMgenj
         Zy1toVabr+ikagK+OTZdBTwMUWPFOQpHsjajasF6w2RKzGlQpYEnZt7h5eO6R/AHZSr2
         DUJ7DILHHtREcD96bHW05tWVoBkeKXJ4x7QuVr3O9M3Ah4iUoE37WWInABIQBd53SyJ1
         /MJ5tkP5xXijtEXtvdar0xPuCBOGkKKSufYblHiC8EGTCgaTeMzQBeVvR5giJ6PR2gHn
         Mk4w==
X-Gm-Message-State: AO0yUKVucgr4r+5vxhRBJY6D2UbiRf+t67OzGThAC/r7MD6AjblMC7mg
        3K0JpcfftIMC0mRBBgklwjVO+w==
X-Google-Smtp-Source: AK7set+mw1dHNc9akouI86sKWRtZ8+TxnQMNzD8jTeP64nqqdVQDR6kM1hbsJzaChVbCT91YbraX7Q==
X-Received: by 2002:a17:902:ecd1:b0:196:12f1:76f5 with SMTP id a17-20020a170902ecd100b0019612f176f5mr1206670plh.52.1675323133195;
        Wed, 01 Feb 2023 23:32:13 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.222])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00196077ba463sm12959015plg.123.2023.02.01.23.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 23:32:12 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        dianders@chromium.org, liwei391@huawei.com, mhiramat@kernel.org,
        maz@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
Date:   Thu,  2 Feb 2023 13:01:48 +0530
Message-Id: <20230202073148.657746-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202073148.657746-1-sumit.garg@linaro.org>
References: <20230202073148.657746-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the first attempt to single-step has any effect. After
that all further stepping remains "stuck" at the same program counter
value.

Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
PSTATE.SS=1 should be set at each step before transferring the PE to the
'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
since the second single-step.

After the first single-step, the PE transferes to the 'Inactive' state,
with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
kernel_active_single_step()=true. Then the PE transferes to the
'Active-pending' state when ERET and returns to the debugger by step
exception.

Before this patch:
==================
Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb>

[0]kdb>
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
    is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb>

After this patch:
=================
Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
    is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
[1]kdb>

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Co-developed-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/debug-monitors.h | 1 +
 arch/arm64/kernel/debug-monitors.c      | 5 +++++
 arch/arm64/kernel/kgdb.c                | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7b7e05c02691..13d437bcbf58 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_rewind_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 3da09778267e..64f2ecbdfe5c 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -438,6 +438,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_rewind_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index cda9c1e9864f..4e1f983df3d1 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_rewind_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
-- 
2.34.1

