Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08A721270
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjFCUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjFCUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:08:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147BC1B1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:07:55 -0700 (PDT)
Message-ID: <20230603200459.889612295@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685822823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Y46eTbENCwKeEacqCP+RntAtFJd0WeB3KmTST49uhjE=;
        b=uzaFJoAicXXB1OMPQ6488zyFUrKvJ+MPs3GtqQZR8wA3AR9I/3Bpk6mhRkDLuzKTs0S4Mq
        HgrPcsOBgoErTzLeUSC/+IpopPE7KNuzZCR8kUEoUnRMIcNCZOrA+kJnl3wahqoDoXP5bv
        DrZ/THD2rPTj1pIBOL0YG+eKuE8anGCStrObe7EVv8TL4WvGnMjIcp3agjPnvm31M6qXjd
        WRNpJPqUo1CCMo+OmYXl4HAD4OnMS44D5N6COtOgUAzOw3uKdGQAYcO7GZ3JMvTMCMzFPb
        IkkWRnekR6wHvnZnLUbMJT7qPoMcPsjFGh89ILg8vcX7AzMWH13sAmDaid2HbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685822823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Y46eTbENCwKeEacqCP+RntAtFJd0WeB3KmTST49uhjE=;
        b=8FveJwVoVmiP1lJU+Lhh3x5CU6ewAbCz36APqoBREfMpFa74nq/tEGtvLd+8xDNEsCSGe+
        MJtScKp7oSMZFqBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch 5/6] x86/smp: Split sending INIT IPI out into a helper function
References: <20230603193439.502645149@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat,  3 Jun 2023 22:07:03 +0200 (CEST)
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
---
 arch/x86/kernel/smpboot.c |   51 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -853,47 +853,40 @@ wakeup_secondary_cpu_via_nmi(int apicid,
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
+	int maxlvt, num_starts, j;
+
+	preempt_disable();
 
-	pr_debug("Waiting for send to finish...\n");
-	send_status = safe_apic_wait_icr_idle();
+	send_init_sequence(phys_apicid);
 
 	mb();
 

