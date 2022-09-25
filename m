Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7905E9532
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIYSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIYSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:03:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC9A2C673
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 11:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD129B80883
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D79C433B5;
        Sun, 25 Sep 2022 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664129006;
        bh=yuYN7bd1gIiPT3BTzCfFO4NEhdO0lqD/4wVB1SM5PeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFlI4ua1yv/8H7MMzh25JoBbiK51TEMNW8iitSIxwku+faDMfUDfLX1tHWdS8Otmn
         Za7OmTGjcHMe5LfNqteaLDje9VTTVsqbpQ12PkkNsyVLVDtltY9kacyKN1kSbMKUvN
         zbcJ4V1f7eduOwNg8biHS23cNclRj2Vuz4qd6gp9HBqotbLM368LKk1vv5Ip/MP+SQ
         oDFx80//ItDXuibLAkHHJQEP7i+q+X5xWl0mr8q3K6VJGjhJBiFMHSbmFLcTI4ZzB+
         EFom0Vslrm0q8TZUlN4Jyx9oP3T63rALGhsSsLirxEz4vV499ISJicdONPQ7gs22Mv
         2B1VEmmlina7A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 1/4] riscv: remove extra level wrappers of trace_hardirqs_{on,off}
Date:   Mon, 26 Sep 2022 01:53:53 +0800
Message-Id: <20220925175356.681-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925175356.681-1-jszhang@kernel.org>
References: <20220925175356.681-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since riscv is converted to generic entry, there's no need for the
extra wrappers of trace_hardirqs_{on,off}.

Tested with llvm + irqsoff.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/Makefile    |  2 --
 arch/riscv/kernel/trace_irq.c | 27 ---------------------------
 arch/riscv/kernel/trace_irq.h | 11 -----------
 3 files changed, 40 deletions(-)
 delete mode 100644 arch/riscv/kernel/trace_irq.c
 delete mode 100644 arch/riscv/kernel/trace_irq.h

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 01da14e21019..11ee206cc235 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -69,8 +69,6 @@ obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
-
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
deleted file mode 100644
index 095ac976d7da..000000000000
--- a/arch/riscv/kernel/trace_irq.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
- */
-
-#include <linux/irqflags.h>
-#include <linux/kprobes.h>
-#include "trace_irq.h"
-
-/*
- * trace_hardirqs_on/off require the caller to setup frame pointer properly.
- * Otherwise, CALLER_ADDR1 might trigger an pagging exception in kernel.
- * Here we add one extra level so they can be safely called by low
- * level entry code which $fp is used for other purpose.
- */
-
-void __trace_hardirqs_on(void)
-{
-	trace_hardirqs_on();
-}
-NOKPROBE_SYMBOL(__trace_hardirqs_on);
-
-void __trace_hardirqs_off(void)
-{
-	trace_hardirqs_off();
-}
-NOKPROBE_SYMBOL(__trace_hardirqs_off);
diff --git a/arch/riscv/kernel/trace_irq.h b/arch/riscv/kernel/trace_irq.h
deleted file mode 100644
index 99fe67377e5e..000000000000
--- a/arch/riscv/kernel/trace_irq.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
- */
-#ifndef __TRACE_IRQ_H
-#define __TRACE_IRQ_H
-
-void __trace_hardirqs_on(void);
-void __trace_hardirqs_off(void);
-
-#endif /* __TRACE_IRQ_H */
-- 
2.34.1

