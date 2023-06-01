Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F1E71F4E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjFAVho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjFAVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7725FE54
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:37:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso1066343b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655440; x=1688247440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZEI6Qd7tJdeWnwaS3kN3vC1A5EXJtp5KG07jP5WNyg=;
        b=JCAPoe0UpPAv7b1ZAoftxG1P1Hl0vpy0Cq9P6rzVeNVHhducqeN2ZSZojZbVaWW7dC
         V/r0eOU8zgusv6UU08goYhmBOTNL9X1E2+EeO3BOcET7CCGt7ad1tSvNoW5LKgBFJ/Sy
         CFgDlXkaNjTm6x7b8QEVI4t2zoTG++PINUd2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655440; x=1688247440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZEI6Qd7tJdeWnwaS3kN3vC1A5EXJtp5KG07jP5WNyg=;
        b=Kt1LWddZqMO8XxB0zSVUch0ZDWWLbZtIBtostiZTClzkAu+/owP5xMAg9LUSabh/lZ
         J01RKLCLt8cqAIStHEzK77WcLu2LNAo4Vf8Lp0uomj3jNudlmOdkh5HtxIU1cCVPPhNc
         uoKhwXEBmOXd1VK0ByCo227pSl3amvA1LBJxRr18foM8U3dZXCB8ti9h1bSUikSsrzM4
         qXMWTyzk2pzNrlGvsSDTxDiq6Uz1JZ0ZSmrPT+i6ytzhQOgH/gm6JQl3Mc5wgwW8uptc
         8ln6kY/fOusO04SioklYiGqREFzTrtFx8ioqxuIHxX6viTj3sEB+5gZZMPgjg/o7PObM
         u4dg==
X-Gm-Message-State: AC+VfDx+5lGwRTfT9iuYPq2vRZhqYJE6lPRRowHiEF/bMNpn8TAKZObp
        N/id/yrjiirmzLe4FRN804PGQQ==
X-Google-Smtp-Source: ACHHUZ7TxkqQeHk3f5nB+sAADSHmxXcXgS1PF5xyCA13nK+lN+RUiZlRh2TxB02uIQ36XVKsZ9fK0A==
X-Received: by 2002:a05:6a00:841:b0:643:6aed:3a9 with SMTP id q1-20020a056a00084100b006436aed03a9mr9872210pfk.0.1685655440701;
        Thu, 01 Jun 2023 14:37:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
Date:   Thu,  1 Jun 2023 14:31:51 -0700
Message-ID: <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
References: <20230601213440.2488667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
IPI is backed by an NMI (or pseudo NMI) then this will let us debug
even hard locked CPUs. When the debug IPI isn't backed by an NMI then
this won't really have any huge benefit but it will still work.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v9:
- Remove fallback for when debug IPI isn't available.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.

 arch/arm64/kernel/ipi_debug.c |  5 +++++
 arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
index 6984ed507e1f..5794894d94f1 100644
--- a/arch/arm64/kernel/ipi_debug.c
+++ b/arch/arm64/kernel/ipi_debug.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kgdb.h>
 #include <linux/nmi.h>
 #include <linux/smp.h>
 
@@ -40,6 +41,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 static irqreturn_t ipi_debug_handler(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
+	unsigned int cpu = smp_processor_id();
 
 	/*
 	 * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're calling
@@ -49,6 +51,9 @@ static irqreturn_t ipi_debug_handler(int irq, void *data)
 	if (nmi_cpu_backtrace(get_irq_regs()))
 		ret = IRQ_HANDLED;
 
+	if (!kgdb_nmicallback(cpu, get_irq_regs()))
+		ret = IRQ_HANDLED;
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 4e1f983df3d1..9c4c47507cd4 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -20,6 +20,8 @@
 #include <asm/patching.h>
 #include <asm/traps.h>
 
+#include "ipi_debug.h"
+
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "x0", 8, offsetof(struct pt_regs, regs[0])},
 	{ "x1", 8, offsetof(struct pt_regs, regs[1])},
@@ -356,3 +358,15 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arm64_debug_ipi(&mask);
+}
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

