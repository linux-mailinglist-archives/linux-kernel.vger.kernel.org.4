Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3364DCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLOO3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLOO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:29:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26ED2CE1B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:29:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so2884534pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuxPSSo3Y0HNcsTRiv4LvjgP5Z2vwZbV6xJtY/KrG9Q=;
        b=GH+o3xGpbeSkSiHU4ZhFMZ9jkmwSgjEShmS+hkyC7LNuC+FLDPkFdCt39W2pFj3AEq
         3As93RhfetUr/a7+HyILd1yr1jzNA4jL3g65bSUssPV3DXNsyRiz7MB4Q1IZMNyHQdX0
         KdKsXm+wpuXZumoARgb0dOpHO6JxWQXv3nabufiTcvvLq6C/KV29jIjx6SzomLlD3CiL
         cdoIvLW6MjHKI32o3jL/M6+DbJaMmhAHE3iNhv8LQxF0tqxqQJjUq/W3D0jzhC0oKL1F
         tjpZFM6Dv21s0Dp9a6xoJGxJmlCzbNMtmDDN3LEC4KyS+J3XtdDbTB03jQdaw5kLlIce
         EKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuxPSSo3Y0HNcsTRiv4LvjgP5Z2vwZbV6xJtY/KrG9Q=;
        b=2YcjGme5bEdqa0NkgrMRS7FEf5Xz9F4Q3GjsTTawiopblKITzAs3dlx4MyobPWQjo+
         W19NMJUYySHK9rRCu+HQQ25ZQQy61ABsqCj4NClF+mpLogBhrVxxLLDaT+1M5UZEhfwb
         aR3FFaXTDwkd/+a5L4ViwUyv9s/0e43ooHdELAasL/irMHQ1D+HhdaIM+vLCDG0DeDQz
         nby7rZ6LrbQ0LoGgXghRlMtnzzZPf5x94PcTOxNIQ0wtZhj/pJ++DsCVoB+FH+JzTkh0
         pG3wFYrgeKBVRDRqxcD8b2+BsjUlGEWh+jxV0yLHl+Z6md+iHoFqTp0HUA0qE3UtPyzH
         wiJQ==
X-Gm-Message-State: ANoB5pkJLYnqkDVYLXlr1dalQs3ejywDHyODcvtLlawfnUFZ7lgXXyOO
        JlkZ0u7nCxdISDL+LG9V4iIY2Q==
X-Google-Smtp-Source: AA0mqf6Fe2RSsBxw7IoI8CLHsSgyH2bi7UGfEUMoabxqwYlOQ8jx9uJ48AQ0FQtFljyOfs1EiF8dQA==
X-Received: by 2002:a17:903:251:b0:189:7891:574d with SMTP id j17-20020a170903025100b001897891574dmr32757233plh.47.1671114566259;
        Thu, 15 Dec 2022 06:29:26 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.45])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0017f5ad327casm3922010plf.103.2022.12.15.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:29:25 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org
Cc:     liwei391@huawei.com, mark.rutland@arm.com, mhiramat@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
Date:   Thu, 15 Dec 2022 19:59:03 +0530
Message-Id: <20221215142903.2624142-3-sumit.garg@linaro.org>
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
---
 arch/arm64/include/asm/debug-monitors.h | 1 +
 arch/arm64/kernel/debug-monitors.c      | 5 +++++
 arch/arm64/kernel/kgdb.c                | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7b7e05c02691..ce3875ad5cd3 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_regs_reset_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 3da09778267e..9af898b22ed4 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -438,6 +438,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_regs_reset_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index cda9c1e9864f..51f204bbcf87 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_regs_reset_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
-- 
2.34.1

