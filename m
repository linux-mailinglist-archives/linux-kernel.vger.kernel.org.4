Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9E7220E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFEIXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFEIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:23:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF59AF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:23:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685953387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ikEFZzVQhOPStEaidYIowYTuW/g1JDuXRSIEWHVNNI=;
        b=Xi0TDDSRp9vUi3aceigQJ55s3ACdlO1VRQiOJmZx7L5t5n6GPgwK0Mwsk5In4TackPsCeE
        H6I+nrX+V9NiWOSY56TPdIlFBzxIHSvwQq0DNlFiKubMxlrFg42n+n+2x+UghlNlGkhpP4
        8jMau7/Ys5V3Wl+YKTs7iuk3ksRv/uer/K3+u+3EXJIvK9f4kdmOrlNUI8d8fEEN50h9+3
        mFb5dRMc9CQhvrY7+xJuRqhnbZvGhwJlZdfdxT8z5JogybU404qxOxZj9V0cJJTp7GU1o/
        g+t8Bfo1ivr2YzAd5dl53kV3LsH2PIboVuj32vCc9xhgSB7YuG3jFGn7soItzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685953387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ikEFZzVQhOPStEaidYIowYTuW/g1JDuXRSIEWHVNNI=;
        b=icYcEYkVFIN7vhQZhtD/feADYqeR33tbO6Nj6rkQtJ3V9T55gKZ5IGFsCLc0A74urNt7G1
        d3qAkkAXpzjklRCQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch v2 5/6] x86/smp: Split sending INIT IPI out into a helper
 function
In-Reply-To: <20230603200459.889612295@linutronix.de>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.889612295@linutronix.de>
Date:   Mon, 05 Jun 2023 10:23:06 +0200
Message-ID: <87a5xe8gid.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: x86/smp: Split sending INIT IPI out into a helper function
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 02 Jun 2023 15:04:10 +0200

Putting CPUs into INIT is a safer place during kexec() to park CPUs.

Split the INIT assert/deassert sequence out so it can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 
