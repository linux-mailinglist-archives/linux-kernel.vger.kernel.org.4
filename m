Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35372E2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbjFMMSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbjFMMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A810DA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:18:04 -0700 (PDT)
Message-ID: <20230613121615.988238767@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TBdYSJyouEMeMZNGX8gFG7/P16NsNnlIxKFRjUwkdQA=;
        b=PnXfWGOWNKoX5Y2YOXm/AS72gnZ7FfbtQ7A8gA7wqf0e0pRab16EvmBYn7zoDp82o+Ifeq
        MvJOfq+KpLw8CFq9Oaj7A0bY81jGhs2usisMwJSC0GiTZSi1vuddo0KNGTFaVIJVvmiGTt
        2FfTQXkoTzaIeYrXoWbS3wifYi/5I/6TXnkq2K2yWOTavzkHXfENc0yb2wb17L/OGSBz76
        d+Ar9DIbanNwDbVwFPr1+O8GK+3Drj0WAcyCCQURQT88Ko+S3oJDy8v+/f2vSjjMsTvWl1
        +UbN65Fs8ZgHyZdFFZ3u5dBoKKFB3qmEzdWHzwWEsfpq5lQF2vTfhyJbeN7z9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TBdYSJyouEMeMZNGX8gFG7/P16NsNnlIxKFRjUwkdQA=;
        b=sQqGJr9gWYQT+uqv1DzEL8yLTUSr7eHXZfptlhAktVNcdTuo/WU8Ml7RAsqYwMrOPrN76a
        n4do5/hAXULSMxDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [patch V2 7/8] x86/smp: Split sending INIT IPI out into a helper function
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:18:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting CPUs into INIT is a safer place during kexec() to park CPUs.

Split the INIT assert/deassert sequence out so it can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
V2: Fix rebase screwup
---
 arch/x86/kernel/smpboot.c |   49 ++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -853,47 +853,38 @@ wakeup_secondary_cpu_via_nmi(int apicid,
 	return (send_status | accept_status);
 }
 
-static int
-wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static void send_init_sequence(int phys_apicid)
 {
-	unsigned long send_status = 0, accept_status = 0;
-	int maxlvt, num_starts, j;
-
-	maxlvt = lapic_get_maxlvt();
+	int maxlvt = lapic_get_maxlvt();
 
-	/*
-	 * Be paranoid about clearing APIC errors.
-	 */
+	/* Be paranoid about clearing APIC errors. */
 	if (APIC_INTEGRATED(boot_cpu_apic_version)) {
-		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP.  */
+		/* Due to the Pentium erratum 3AP.  */
+		if (maxlvt > 3)
 			apic_write(APIC_ESR, 0);
 		apic_read(APIC_ESR);
 	}
 
-	pr_debug("Asserting INIT\n");
-
-	/*
-	 * Turn INIT on target chip
-	 */
-	/*
-	 * Send IPI
-	 */
-	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT,
-		       phys_apicid);
-
-	pr_debug("Waiting for send to finish...\n");
-	send_status = safe_apic_wait_icr_idle();
+	/* Assert INIT on the target CPU */
+	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT, phys_apicid);
+	safe_apic_wait_icr_idle();
 
 	udelay(init_udelay);
 
-	pr_debug("Deasserting INIT\n");
-
-	/* Target chip */
-	/* Send IPI */
+	/* Deassert INIT on the target CPU */
 	apic_icr_write(APIC_INT_LEVELTRIG | APIC_DM_INIT, phys_apicid);
+	safe_apic_wait_icr_idle();
+}
+
+/*
+ * Wake up AP by INIT, INIT, STARTUP sequence.
+ */
+static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+{
+	unsigned long send_status = 0, accept_status = 0;
+	int num_starts, j, maxlvt = lapic_get_maxlvt();
 
-	pr_debug("Waiting for send to finish...\n");
-	send_status = safe_apic_wait_icr_idle();
+	send_init_sequence(phys_apicid);
 
 	mb();
 

