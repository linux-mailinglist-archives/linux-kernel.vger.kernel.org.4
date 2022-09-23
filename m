Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0B5E85E2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiIWW3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:29:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8813F49;
        Fri, 23 Sep 2022 15:29:29 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:29:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663972167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKqtrIa6eWeO5fTQzsUl+gBgUVyxyORjsqKunP19yko=;
        b=Gc35W1p0Z0YQKURH+k+F7VWYgkeERZCXmcZsSWBkFII/FQl9Z1z1LILTW/HMrCoCNOqoTh
        ngPviG4j16gvW/vdCbaX7SBeWt6mQZKiOvqtPBF8ZPzxqJAhvshLrCm3jW3HoyakJw23Qv
        jLFQo2gF6jE/BKUN9C0f/7+f/oXTysIm4OE6IxClp+ZxNTouFjuTJFLNmyzz8IFLvqAwGe
        FYE+/l02KF7RMX7Idi+PaRe3qohTOKgBFiQxh+2/r2StwAZC+miHohzm41KcYn8QEyiZN9
        vlMKN/I2Xf0pS7+Gwfi1ADWLokzYlgOeC/F+2EiCwqmL5ICnUL9R8yvbnPN15Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663972167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKqtrIa6eWeO5fTQzsUl+gBgUVyxyORjsqKunP19yko=;
        b=KMSHUw6rnb3bUD7gAcCSSvD45IQ044XHNM6fRLKvIz1iStFAsxsuHr9KBS8qxLfQhs6pzr
        azc+tj7N4ptk6ICw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] ACPI: processor idle: Practically limit "Dummy
 wait" workaround to old Intel systems
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220922184745.3252932-1-dave.hansen@intel.com>
References: <20220922184745.3252932-1-dave.hansen@intel.com>
MIME-Version: 1.0
Message-ID: <166397216527.401.8938673863974895520.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e400ad8b7e6a1b9102123c6240289a811501f7d9
Gitweb:        https://git.kernel.org/tip/e400ad8b7e6a1b9102123c6240289a811501f7d9
Author:        Dave Hansen <dave.hansen@intel.com>
AuthorDate:    Thu, 22 Sep 2022 11:47:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 23 Sep 2022 15:24:10 -07:00

ACPI: processor idle: Practically limit "Dummy wait" workaround to old Intel systems

Old, circa 2002 chipsets have a bug: they don't go idle when they are
supposed to.  So, a workaround was added to slow the CPU down and
ensure that the CPU waits a bit for the chipset to actually go idle.
This workaround is ancient and has been in place in some form since
the original kernel ACPI implementation.

But, this workaround is very painful on modern systems.  The "inl()"
can take thousands of cycles (see Link: for some more detailed
numbers and some fun kernel archaeology).

First and foremost, modern systems should not be using this code.
Typical Intel systems have not used it in over a decade because it is
horribly inferior to MWAIT-based idle.

Despite this, people do seem to be tripping over this workaround on
AMD system today.

Limit the "dummy wait" workaround to Intel systems.  Keep Modern AMD
systems from tripping over the workaround.  Remotely modern Intel
systems use intel_idle instead of this code and will, in practice,
remain unaffected by the dummy wait.

Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/all/20220921063638.2489-1-kprateek.nayak@amd.com/
Link: https://lkml.kernel.org/r/20220922184745.3252932-1-dave.hansen@intel.com
---
 drivers/acpi/processor_idle.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 16a1663..9f40917 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -531,10 +531,27 @@ static void wait_for_freeze(void)
 	/* No delay is needed if we are in guest */
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
+	/*
+	 * Modern (>=Nehalem) Intel systems use ACPI via intel_idle,
+	 * not this code.  Assume that any Intel systems using this
+	 * are ancient and may need the dummy wait.  This also assumes
+	 * that the motivating chipset issue was Intel-only.
+	 */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
 #endif
-	/* Dummy wait op - must do something useless after P_LVL2 read
-	   because chipsets cannot guarantee that STPCLK# signal
-	   gets asserted in time to freeze execution properly. */
+	/*
+	 * Dummy wait op - must do something useless after P_LVL2 read
+	 * because chipsets cannot guarantee that STPCLK# signal gets
+	 * asserted in time to freeze execution properly
+	 *
+	 * This workaround has been in place since the original ACPI
+	 * implementation was merged, circa 2002.
+	 *
+	 * If a profile is pointing to this instruction, please first
+	 * consider moving your system to a more modern idle
+	 * mechanism.
+	 */
 	inl(acpi_gbl_FADT.xpm_timer_block.address);
 }
 
