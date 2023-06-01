Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4871F4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjFAVhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjFAVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DA19B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:37:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-652a6cf1918so294693b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655432; x=1688247432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxngL/nWZ9CvmSVXwg8pkM18NqkUW/hq6cWY9xHbU50=;
        b=aXtBMJsuEHVcZIKV7cLRpp9gJah5t0XCzX6mPhaAfDBP1dJ5ow0nIMbyHBqXyExXs/
         iONAnH757E2JdGKhPAJpJ0T+0at+owiwzn2oTUIqycF0fDPlNwbji/qaAjIXJsOAh/DF
         EzBp3VrZJfcftxuQAMYGMNArokNyBuLgHVwN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655432; x=1688247432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxngL/nWZ9CvmSVXwg8pkM18NqkUW/hq6cWY9xHbU50=;
        b=SVQn6hBXGRfOonl/DPD7pkHCOaHdr7rPI+wxrCXo7vDj31hsNhbyc9nfrBzAx/gOOv
         fqZO1sgOOhamnc0Ab2YNSk7yszxUPfivagUr+frPJp1BjIkTirlCDHfFhRuDGbnsR3aS
         +5dRzDkEbNXoQI+oxI9dRJqLqUnqeTHeD9ch/f0aQzcxP/fU8ns61J2aTQNeSEri14aj
         EGATVzpGp989JXfB5CHggcRfNZlWzfX6Eu+fGfbPf/IxW024pWd2Rox++FNiX6AM0/E3
         UtAKC4yqstTUYBnqgX0c+49pOjRyfNETnnqjQg6vSNomFYKhUtVrOS49pDMFXZ0PUReH
         9wkw==
X-Gm-Message-State: AC+VfDzgqjB8lS2ll9UGf82A1jcikuEanH/pzz1t/vPnYGk+Mmr8e6b1
        4cxNxjYVnT5VQmGj4djmNlbDgw==
X-Google-Smtp-Source: ACHHUZ5ef/rtEIYJxyW1OxKT1bSL//A95UwWPCmZBbTCdj36TOdor4jNJCZmCSlkwGKN3QsCenCWSg==
X-Received: by 2002:a05:6a00:8ca:b0:64c:b45f:fc86 with SMTP id s10-20020a056a0008ca00b0064cb45ffc86mr10767019pfu.17.1685655432123;
        Thu, 01 Jun 2023 14:37:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:11 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/7] arm64: Add framework for a debug IPI
Date:   Thu,  1 Jun 2023 14:31:47 -0700
Message-ID: <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
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

Introduce a framework for an IPI that will be used for debug
purposes. The primary use case of this IPI will be to generate stack
crawls on other CPUs, but it will also be used to round up CPUs for
kgdb.

When possible, we try to allocate this debug IPI as an NMI (or a
pseudo NMI). If that fails (due to CONFIG, an incompatible interrupt
controller, a quirk, missing the "irqchip.gicv3_pseudo_nmi=1" kernel
parameter, etc) we fall back to a normal IPI.

NOTE: hooking this up for CPU backtrace / kgdb will happen in a future
patch, this just adds the framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I didn't get any feedback from v8 patch #10 [1], but I went ahead and
folded it in here anyway since it really simplfies things. If people
don't like the fallback to regular IPI, I can also undo it.

[1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid/

Changes in v9:
- Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
- Moved header file out of "include" since it didn't need to be there.
- Remove arm64_supports_nmi()
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.

Changes in v8:
- debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param

 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/ipi_debug.c | 76 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ipi_debug.h | 13 ++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/ipi_debug.c
 create mode 100644 arch/arm64/kernel/ipi_debug.h

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cc22011ab66a..737838f803b7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
-			   patching.o
+			   patching.o ipi_debug.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
new file mode 100644
index 000000000000..b57833e31eaf
--- /dev/null
+++ b/arch/arm64/kernel/ipi_debug.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Debug IPI support
+ *
+ * Copyright (C) 2020 Linaro Limited
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+
+#include "ipi_debug.h"
+
+static struct irq_desc *ipi_debug_desc __read_mostly;
+static int ipi_debug_id __read_mostly;
+static bool is_nmi;
+
+void arm64_debug_ipi(cpumask_t *mask)
+{
+	if (WARN_ON_ONCE(!ipi_debug_desc))
+		return;
+
+	__ipi_send_mask(ipi_debug_desc, mask);
+}
+
+static irqreturn_t ipi_debug_handler(int irq, void *data)
+{
+	/* nop, NMI handlers for special features can be added here. */
+
+	return IRQ_NONE;
+}
+
+void debug_ipi_setup(void)
+{
+	if (!ipi_debug_desc)
+		return;
+
+	if (is_nmi) {
+		if (!prepare_percpu_nmi(ipi_debug_id))
+			enable_percpu_nmi(ipi_debug_id, IRQ_TYPE_NONE);
+	} else {
+		enable_percpu_irq(ipi_debug_id, IRQ_TYPE_NONE);
+	}
+}
+
+void debug_ipi_teardown(void)
+{
+	if (!ipi_debug_desc)
+		return;
+
+	if (is_nmi) {
+		disable_percpu_nmi(ipi_debug_id);
+		teardown_percpu_nmi(ipi_debug_id);
+	} else {
+		disable_percpu_irq(ipi_debug_id);
+	}
+}
+
+void __init set_smp_debug_ipi(int ipi)
+{
+	int err;
+
+	if (!request_percpu_nmi(ipi, ipi_debug_handler, "IPI", &cpu_number)) {
+		is_nmi = true;
+	} else {
+		err = request_percpu_irq(ipi, ipi_debug_handler, "IPI", &cpu_number);
+		if (WARN_ON(err))
+			return;
+
+		irq_set_status_flags(ipi, IRQ_HIDDEN);
+	}
+
+	ipi_debug_desc = irq_to_desc(ipi);
+	ipi_debug_id = ipi;
+}
diff --git a/arch/arm64/kernel/ipi_debug.h b/arch/arm64/kernel/ipi_debug.h
new file mode 100644
index 000000000000..f6011a09282f
--- /dev/null
+++ b/arch/arm64/kernel/ipi_debug.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#include <linux/cpumask.h>
+
+void arm64_debug_ipi(cpumask_t *mask);
+
+void set_smp_debug_ipi(int ipi);
+void debug_ipi_setup(void);
+void debug_ipi_teardown(void);
+
+#endif
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

