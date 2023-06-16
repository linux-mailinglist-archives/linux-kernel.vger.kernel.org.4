Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20378732B57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbjFPJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343991AbjFPJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E28271E;
        Fri, 16 Jun 2023 02:24:43 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjTC0bn1c6tuURZzGvFsI612RvzdiyDdTjdWG5MDlzU=;
        b=wF2SmJWuNppxnWPNrs81++B5IdpKH61pDoL/tR9JOHqjEJ11/n1l9kOUl+fMgrnqxDlmIC
        O3kJfSi99UVFzWr/CHTxCxSKkvv/pYrCIIkobhmmkKL1NBgcYMvQ/8UjIcZWAeUpjfHPa0
        5Un7u52oetO6mciwq2mQ3LCx5HuFcDl3PZYaixL9gGGPF8Bs/StdWXZbQTZm8Kf7J4duXr
        vXY98MKyEbxZZFdN4Tchya+kHmW18OJhG12M5Y3JfRgQDFrSBTdSgZw0vdfhf/3fxH3UvV
        zOFEUtuvKYT4+6mxhqowa+7YMnuES9zZY0KqJkBcvpjTO5tdK4rKvAmd6Qsghg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjTC0bn1c6tuURZzGvFsI612RvzdiyDdTjdWG5MDlzU=;
        b=ezM+NdLbqduyvN1oe2vodJ+TxHZ91y5g1UqcEsjacSf7udrLhxZwVLGp7VrOW6RVoKN4uD
        NN6UEWF2qkSMRuCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.902376621@linutronix.de>
References: <20230613224545.902376621@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748113.404.13314023725457189436.tip-bot2@tip-bot2>
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

Commit-ID:     b81fac906a8f9e682e513ddd95697ec7a20878d4
Gitweb:        https://git.kernel.org/tip/b81fac906a8f9e682e513ddd95697ec7a20878d4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:01 +02:00

x86/fpu: Move FPU initialization into arch_cpu_finalize_init()

Initializing the FPU during the early boot process is a pointless
exercise. Early boot is convoluted and fragile enough.

Nothing requires that the FPU is set up early. It has to be initialized
before fork_init() because the task_struct size depends on the FPU register
buffer size.

Move the initialization to arch_cpu_finalize_init() which is the perfect
place to do so.

No functional change.

This allows to remove quite some of the custom early command line parsing,
but that's subject to the next installment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.902376621@linutronix.de

---
 arch/x86/kernel/cpu/common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2807e5b..46ebdd6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1604,8 +1604,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	sld_setup(c);
 
-	fpu__init_system();
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
@@ -2287,8 +2285,6 @@ void cpu_init(void)
 
 	doublefault_init_cpu_tss();
 
-	fpu__init_cpu();
-
 	if (is_uv_system())
 		uv_cpu_init();
 
@@ -2304,6 +2300,7 @@ void cpu_init_secondary(void)
 	 */
 	cpu_init_exception_handling();
 	cpu_init();
+	fpu__init_cpu();
 }
 #endif
 
@@ -2396,6 +2393,13 @@ void __init arch_cpu_finalize_init(void)
 			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 	}
 
+	/*
+	 * Must be before alternatives because it might set or clear
+	 * feature bits.
+	 */
+	fpu__init_system();
+	fpu__init_cpu();
+
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
