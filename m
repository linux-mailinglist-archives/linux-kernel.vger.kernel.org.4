Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C75736CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjFTNB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjFTNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:01:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA519A1;
        Tue, 20 Jun 2023 06:00:52 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687266051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGO0N+b4VLs0S7U3M2s5rSy9XlrIT13PxXT3rsvwIKk=;
        b=DOzLFvshbTzVdh2JY8agz/fN71GEG5OEPiywNaa+KRIp+lsiQWbp2xcjy+JL4AwKNkmxD5
        j5Nli93/0/R5cgDzf9nxIARwSDg/ZgtInF+NNr5SLrGuHtkmw5VnR1m72PjHWg5d9NPprk
        NQz5+hGm5uL4d09mcv21FrwQGe6pGNh3McS+Potdqt+19P4g3TQNS8ic0DJodZH1Xo6w+T
        90qM8g5lqbAcasTDGghY7qIT1cUZQLOUPy0JaxVthLVsADYyRHXgDjUyzhhC+oBLHpQE5U
        tU6ruO15qU9I99Yse1KeI4K0w7sJlls/s4HuRFs8kuwuesTd3n6yjIhTk0Vjlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687266051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGO0N+b4VLs0S7U3M2s5rSy9XlrIT13PxXT3rsvwIKk=;
        b=T2qEEqtsD9ZC2exBe7zz1q1Cnyl9MNRoZs90IgrEctmzlnGaNLl5hYRBCRlXzXv3BPfG0E
        K6eNpyBJKwNwrLCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Split sending INIT IPI out into a helper function
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615193330.551157083@linutronix.de>
References: <20230615193330.551157083@linutronix.de>
MIME-Version: 1.0
Message-ID: <168726605053.404.8610488673779596542.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6087dd5e86ff03a8cd4cffdf463a7f457e65cbff
Gitweb:        https://git.kernel.org/tip/6087dd5e86ff03a8cd4cffdf463a7f457e65cbff
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Jun 2023 22:33:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Jun 2023 14:51:47 +02:00

x86/smp: Split sending INIT IPI out into a helper function

Putting CPUs into INIT is a safer place during kexec() to park CPUs.

Split the INIT assert/deassert sequence out so it can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20230615193330.551157083@linutronix.de
---
 arch/x86/kernel/smpboot.c | 49 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 483df04..b403ead 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -853,47 +853,38 @@ wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
 	return (send_status | accept_status);
 }
 
-static int
-wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+static void send_init_sequence(int phys_apicid)
 {
-	unsigned long send_status = 0, accept_status = 0;
-	int maxlvt, num_starts, j;
+	int maxlvt = lapic_get_maxlvt();
 
-	maxlvt = lapic_get_maxlvt();
-
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
 
-	pr_debug("Waiting for send to finish...\n");
-	send_status = safe_apic_wait_icr_idle();
+/*
+ * Wake up AP by INIT, INIT, STARTUP sequence.
+ */
+static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+{
+	unsigned long send_status = 0, accept_status = 0;
+	int num_starts, j, maxlvt = lapic_get_maxlvt();
+
+	send_init_sequence(phys_apicid);
 
 	mb();
 
