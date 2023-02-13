Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24D694F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjBMS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBMS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF802104;
        Mon, 13 Feb 2023 10:26:27 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRvsYlPKAkyUONMmY3Do21DCFIfU1YIyXzRXIXHlfu4=;
        b=HXeCE88Thb6qPKdWbaw9ml5YuX50g+buEMzqbRSyzOx/SJ51VdRqJwcH2JKzXjigyHhaQG
        M90VPyeNEqqfX7ekyoh8a3hf1H4Fdx1kECuRdy4LgbctVdL0O270GINRmen54PhsFRIsDA
        yq1KDFwM9RcZXACqRZdEMPQJElBAGVUszn3xbU33CGPj9eTKkb2vQ49pSMfDfRNfSALMJh
        DqCUxWRpYvxa0gSTe0ZM/xYqoUqKAwoVvopl7vYvE7RTFk1Bmnn7/bRSMlu0Weed521Zh9
        fsqR1hYFJ4pS581Wu2CTso0I73URFkSRRdRZWUM9igxDeiA/Sp1ozMNI58jUPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRvsYlPKAkyUONMmY3Do21DCFIfU1YIyXzRXIXHlfu4=;
        b=3oLrymvHZkmkMkiMnofWpJKl1aN0v5FK9rEH2K7pwpo4rxgUfh0vRYQzdARV1gvDxxHvue
        jP9wmTNkBvQqGRDQ==
From:   "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <167631278366.4906.10317855823309761779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3aff0403f814df6ce2377a6ecf61dd7750a3925f
Gitweb:        https://git.kernel.org/tip/3aff0403f814df6ce2377a6ecf61dd7750a3925f
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 29 Dec 2022 22:46:01 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback

Having a clocksource_arch_init() callback always sets vdso_clock_mode to
VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
required for the riscv-timer.

This works for platforms where just riscv-timer clocksource is present.
On platforms where other clock sources are available we want them to
register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.

On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
move setting of vdso_clock_mode in the riscv-timer driver instead of doing
this in clocksource_arch_init() callback as done similarly for ARM/64
architecture.

[0] drivers/clocksource/renesas-ostm.c

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/riscv/Kconfig                |  1 -
 arch/riscv/kernel/time.c          |  9 ---------
 drivers/clocksource/timer-riscv.c |  5 +++++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b6560..9c687da 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,7 +12,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_BINFMT_FLAT
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 1cf21db..babaf3b 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -33,12 +33,3 @@ void __init time_init(void)
 
 	tick_setup_hrtimer_broadcast();
 }
-
-void clocksource_arch_init(struct clocksource *cs)
-{
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
-	cs->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER;
-#else
-	cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
-#endif
-}
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index adf7f98..d8cb629 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -78,6 +78,11 @@ static struct clocksource riscv_clocksource = {
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+	.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
+#else
+	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
+#endif
 };
 
 static int riscv_timer_starting_cpu(unsigned int cpu)
