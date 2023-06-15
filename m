Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE097320F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjFOUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFOUeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:34:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D5271E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:00 -0700 (PDT)
Message-ID: <20230615193330.551157083@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686861239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TBdYSJyouEMeMZNGX8gFG7/P16NsNnlIxKFRjUwkdQA=;
        b=j1c6y+H+ghd90bqWcOYaeek1KPZwPr4s786lnbW2HLa9/lStXSxPNBQqGR0eEhv/o48TtW
        wqT2ySFUmcaquU8eMXIhz8tgLomGDQ9JQOQ52Ghn25c3LticxOcEJR/Wv5UAAepZgdTFlN
        TGd2NoHF6fKAJDer7Tj+kaa28gMim6jnyzPROFw+0E+V3xH3Zp7LEcxLMjxkBMTaw0KjOn
        hNNYeKGS0f8CrJ1OOwKaE88DuSgFJf+IQlq9WmM2NTG2A/Dind5UQtCBtuoIaHFWFn6G6b
        HF5UifVUhVl5Suj1M0O0ixJfB5So51YX2PITXHx09CdOkIUEsrTe8MqQjB+yHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686861239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TBdYSJyouEMeMZNGX8gFG7/P16NsNnlIxKFRjUwkdQA=;
        b=SHOg7nOYSiQk/qkaMe8xz62FLyXEHmClkNZJcz0GMKAMPhXPe3oCHuJlUg2i5gXFVBRohk
        ZKM55SH+d+K7WgDw==
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
Subject: [patch v3 6/7] x86/smp: Split sending INIT IPI out into a helper function
References: <20230615190036.898273129@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 15 Jun 2023 22:33:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 

