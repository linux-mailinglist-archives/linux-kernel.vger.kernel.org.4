Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B472F047
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbjFMXlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjFMXkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:40:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F51FFB;
        Tue, 13 Jun 2023 16:39:41 -0700 (PDT)
Message-ID: <20230613224545.612182854@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0VnFCDlFg0Z65xUPcTSUW8cd097ZM3tj8m6sSpK3s64=;
        b=2vIwQPIUp/HJUmCG4BQezI45Q367xKHJYYqLK7G4wdrDSn+cOBFzLkdHYUwzUXc6gDifT9
        rXY1lpsCnLehM7zAXb6roxx5XLRXYnCJR+grAmVc2dHif25zyPdBFAdRB8oZi5F8oDEYjX
        LfRMBrXHCi+WgVWwvhW/rD4N9Ur83iWtMYD/8dwxcO3p39WY5cZNs0IUmsHtiYOfpH2mPn
        zfJVRybOawF0SSzGOD7ZbR8K3/Wde2+WMR35K0mYj4U05gliICM7VVvC+XUr8nRG+osE42
        Jt6Rw45sBhht2PYfVT0AcDzOMXI7pmmP+pQ2CC66euAz7R6Cd8BF8y04Prxn9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0VnFCDlFg0Z65xUPcTSUW8cd097ZM3tj8m6sSpK3s64=;
        b=Xu1aR4gK/TE/PO7y3dM5tqNyYP8UwrzsrU8JCSaOdKEVqSuAOvhIQ2kubFuP8M//eeln2X
        Z4Xwxgc0BSAFJ1Bg==
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
Subject: [patch 12/17] init: Invoke arch_cpu_finalize_init() earlier
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:39 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86 is reworking the boot process so that initializations which are not
required during early boot can be moved into the late boot process and out
of the fragile and restricted initial boot phase.

arch_cpu_finalize_init() is the obvious place to do such initializations,
but arch_cpu_finalize_init() is invoked too late in start_kernel() e.g. for
initializing the FPU completely. fork_init() requires that the FPU is
initialized as the size of task_struct on X86 depends on the size of the
required FPU register buffer.

Fortunately none of the init calls between calibrate_delay() and
arch_cpu_finalize_init() is relevant for the functionality of
arch_cpu_finalize_init().

Invoke it right after calibrate_delay() where everything which is relevant
for arch_cpu_finalize_init() has been set up already.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 init/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/init/main.c
+++ b/init/main.c
@@ -1041,6 +1041,8 @@ asmlinkage __visible void __init __no_sa
 	sched_clock_init();
 	calibrate_delay();
 
+	arch_cpu_finalize_init();
+
 	/*
 	 * This needs to be called before any devices perform DMA
 	 * operations that might use the SWIOTLB bounce buffers. It will
@@ -1077,8 +1079,6 @@ asmlinkage __visible void __init __no_sa
 	taskstats_init_early();
 	delayacct_init();
 
-	arch_cpu_finalize_init();
-
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	kcsan_init();

