Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942372F016
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjFMXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjFMXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DC199B;
        Tue, 13 Jun 2023 16:39:24 -0700 (PDT)
Message-ID: <20230613224544.957805717@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=77AqRKQdSjaQjDGx40OLahyRXrEjSKh/Zvl13xpUqBI=;
        b=fnjAlb4buqGgk+rgrSCls7XVVnssMKtlFn2wVkNKc0rXqkoKriukti4plpA4B3XFF4TzZK
        HkCGTHa0kgSQScvJzMGd5ndETRmA+U3bEX7DbZ4/2do4EQ0DxEh5OrT0lEol4VvMYfuRS9
        HynlSeJlhLILNeJrnp5YyETdHndPSJ7O/5rI4vnEKgJp3QTTCjnHyKycf9vdAFNWo8H2rb
        OTqiVuHCxtKC1JhOpK0UDZj/7iiiakYdsll7mDRVfp6DDuS0PUAl8a0YNpVsMMsx4052en
        gUZVODYB997wOJEzzkrsE7bLzpx5hqFiHqP0cAfvYOr6EwF5Zzytu+rPbxhCmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=77AqRKQdSjaQjDGx40OLahyRXrEjSKh/Zvl13xpUqBI=;
        b=NcUHkxGs2yX0+eW1fJGry5eTvk3bMCTGxKXUguMEnkfcS6GFg9bNcY/6dOYm0SDEPQHUZn
        lMvSic4+i4tjOCAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 01/17] init: Provide arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_bugs() has become a dump ground for all sorts of activities to
finalize the CPU initialization before running the rest of the init code.

Most are empty, a few do actual bug checks, some do alternative patching
and some cobble a CPU advertisment string together....

Aside of that the current implementation requires duplicated function
declaration and mostly empty header files for them.

Provide a new function arch_cpu_finalize_init(). Provide a generic
declaration if CONFIG_ARCH_HAS_CPU_FINALIZE_INIT is selected and a stub
inline otherwise.

This requires a temporary #ifdef in start_kernel() which will be removed
along with check_bugs() once the architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/Kconfig        |    3 +++
 include/linux/cpu.h |    6 ++++++
 init/main.c         |    4 ++++
 3 files changed, 13 insertions(+)
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -285,6 +285,9 @@ config ARCH_HAS_DMA_SET_UNCACHED
 config ARCH_HAS_DMA_CLEAR_UNCACHED
 	bool
 
+config ARCH_HAS_CPU_FINALIZE_INIT
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -184,6 +184,12 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
 
+#ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
+void arch_cpu_finalize_init(void);
+#else
+static inline void arch_cpu_finalize_init(void) { }
+#endif
+
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
--- a/init/main.c
+++ b/init/main.c
@@ -1078,7 +1078,11 @@ asmlinkage __visible void __init __no_sa
 	taskstats_init_early();
 	delayacct_init();
 
+	arch_cpu_finalize_init();
+	/* Temporary conditional until everything has been converted */
+#ifndef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
 	check_bugs();
+#endif
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();

