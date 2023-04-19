Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1926E855F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjDSW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjDSW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82113C38
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2474e09fdcfso251696a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945021; x=1684537021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25B8XpzGl30nnQXc7pjFTkaHGbx7UR1/WEEDjJTDF98=;
        b=Xfg8UwnoAK8MCu52W2ZLu7R7oiex2ZaZoucSRvBlVW3TyEgZkCurK+9F6/kK4Eeakg
         mJYqTpmVTL98+Ggd8n/eYRf9hDuZBPoSd+rSmNh0hbTs/rfIrEVs1jmnlEo2kxgoPCw0
         a6mKZpDJzo1jvJDMRUa72CbljfWkELab8aptY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945021; x=1684537021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25B8XpzGl30nnQXc7pjFTkaHGbx7UR1/WEEDjJTDF98=;
        b=EzYLCxNC/dWysrq8D1lvbcSSA6Z6Z7U8Sp/pHebHlZI7a16oJ5iwSDy08xZ2640b2b
         a3I3LHcBPCXG/EA6TVsHzIMKBAwKgtbmuyag0AXndwngbpKJovIsA8d3dv6BN+2o/EU8
         7uCg8irCsouGyu85tEFP0GRlitWeSSZVA2usIdXBFbFkLr24Em9DAfXAvUwpAKwibzzV
         j/uIULFZyADrCYLQpNho8UbbiXX9WBAAKVq3JwMtSXlTrBCmY0I6KCBiaNTVNKncokMs
         ND9WWPRSFCyiE16xUn27YkIGAShDjK7tTnZYJyP9ayigtNo4/FOHvatwT3Iq+8fN7ifH
         pG6Q==
X-Gm-Message-State: AAQBX9ehIkYsjd0JGNdFNJPKYlLjpp0Bq9MVgm3Hj4iYbCDlK9yv4sLw
        M0x3MLLOdPBDk1f1caXkIKdWgA==
X-Google-Smtp-Source: AKy350ZZrZJ5+OO/w2IYX4HjwSzmdypxalKREpzh3tzWqSewaK2EchHc8k1ghGwj4XrJCa9x6dAFug==
X-Received: by 2002:a17:90a:fe88:b0:23f:9d83:ad76 with SMTP id co8-20020a17090afe8800b0023f9d83ad76mr4060143pjb.23.1681945021144;
        Wed, 19 Apr 2023 15:57:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/10] arm64: Add framework to turn IPI as NMI
Date:   Wed, 19 Apr 2023 15:55:55 -0700
Message-ID: <20230419155341.v8.1.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Introduce framework to turn an IPI as NMI using pseudo NMIs. The main
motivation for this feature is to have an IPI that can be leveraged to
invoke NMI functions on other CPUs.

And current prospective users are NMI backtrace and KGDB CPUs round-up
whose support is added via future patches.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- dynamic_ipi_setup() and dynamic_ipi_teardown() no longer take cpu param

 arch/arm64/include/asm/nmi.h | 17 ++++++++++
 arch/arm64/kernel/Makefile   |  2 +-
 arch/arm64/kernel/ipi_nmi.c  | 65 ++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 000000000000..2cc4b4d4090e
--- /dev/null
+++ b/arch/arm64/include/asm/nmi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#ifndef __ASSEMBLER__
+
+#include <linux/cpumask.h>
+
+extern bool arm64_supports_nmi(void);
+extern void arm64_send_nmi(cpumask_t *mask);
+
+void set_smp_dynamic_ipi(int ipi);
+void dynamic_ipi_setup(void);
+void dynamic_ipi_teardown(void);
+
+#endif /* !__ASSEMBLER__ */
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3..d57c8f99ca69 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
-			   patching.o
+			   patching.o ipi_nmi.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
new file mode 100644
index 000000000000..712411eed949
--- /dev/null
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NMI support for IPIs
+ *
+ * Copyright (C) 2020 Linaro Limited
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+
+#include <asm/nmi.h>
+
+static struct irq_desc *ipi_nmi_desc __read_mostly;
+static int ipi_nmi_id __read_mostly;
+
+bool arm64_supports_nmi(void)
+{
+	if (ipi_nmi_desc)
+		return true;
+
+	return false;
+}
+
+void arm64_send_nmi(cpumask_t *mask)
+{
+	if (WARN_ON_ONCE(!ipi_nmi_desc))
+		return;
+
+	__ipi_send_mask(ipi_nmi_desc, mask);
+}
+
+static irqreturn_t ipi_nmi_handler(int irq, void *data)
+{
+	/* nop, NMI handlers for special features can be added here. */
+
+	return IRQ_NONE;
+}
+
+void dynamic_ipi_setup(void)
+{
+	if (!ipi_nmi_desc)
+		return;
+
+	if (!prepare_percpu_nmi(ipi_nmi_id))
+		enable_percpu_nmi(ipi_nmi_id, IRQ_TYPE_NONE);
+}
+
+void dynamic_ipi_teardown(void)
+{
+	if (!ipi_nmi_desc)
+		return;
+
+	disable_percpu_nmi(ipi_nmi_id);
+	teardown_percpu_nmi(ipi_nmi_id);
+}
+
+void __init set_smp_dynamic_ipi(int ipi)
+{
+	if (!request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number)) {
+		ipi_nmi_desc = irq_to_desc(ipi);
+		ipi_nmi_id = ipi;
+	}
+}
-- 
2.40.0.634.g4ca3ef3211-goog

