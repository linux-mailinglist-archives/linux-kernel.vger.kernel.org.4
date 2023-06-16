Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48FB732B69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbjFPJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbjFPJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9721210F6;
        Fri, 16 Jun 2023 02:24:50 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dpe0s/A8gQEATi7ZIZtKyKYtccf1X0JVPt4Jz4V2Szg=;
        b=MM7ggo/EZnROouRphGtMeBMw+q5Mj0Smf7Y9tcQAROtsiCunoMz7m1KGViSRQXxPjmhrRO
        6E48eTgVZDZxizDSQRKPg9HCB22mDNCYWkq7+jlYUsPUw9r0+egVMR6kMNVy3nU+GFZz3b
        yrCcX3VSz4xx0cSiEEk1uuyaM5rd1JjplwPcGFQbExfm7XqwURr33+x0D4NiejtP4zGLBG
        BsFn9c2+byj/WYJNM52j/5egNflgqmo6oJIigFg7+ZXZq/VZVh3sd8uVzoBztp+sz8/p7U
        iEKGYNCwUamtgcL4/MLD3YNprILZBCvyUL88Yn+/TyaHh17otC9/ZhzVqtDIwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dpe0s/A8gQEATi7ZIZtKyKYtccf1X0JVPt4Jz4V2Szg=;
        b=bhmpJN8dPj2YmgjAt5P4vgfszJppM02rTK6B9LzxjmiNRoX+b2S6JE6TlE+LC10gfBKJk4
        Sn1asFofi2VKq1Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] init: Invoke arch_cpu_finalize_init() earlier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.612182854@linutronix.de>
References: <20230613224545.612182854@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748448.404.15686125885595544937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9df9d2f0471b4c4702670380b8d8a45b40b23a7d
Gitweb:        https://git.kernel.org/tip/9df9d2f0471b4c4702670380b8d8a45b40b23a7d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

init: Invoke arch_cpu_finalize_init() earlier

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
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/r/20230613224545.612182854@linutronix.de

---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 389ac62..c968c19 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1041,6 +1041,8 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 	sched_clock_init();
 	calibrate_delay();
 
+	arch_cpu_finalize_init();
+
 	/*
 	 * This needs to be called before any devices perform DMA
 	 * operations that might use the SWIOTLB bounce buffers. It will
@@ -1077,8 +1079,6 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 	taskstats_init_early();
 	delayacct_init();
 
-	arch_cpu_finalize_init();
-
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	kcsan_init();
