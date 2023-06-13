Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86C72E723
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbjFMPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbjFMPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:25:11 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177419B9;
        Tue, 13 Jun 2023 08:25:09 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d693ed22b0d7d60d; Tue, 13 Jun 2023 17:25:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 609006E2F7A;
        Tue, 13 Jun 2023 17:25:07 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Saket Dumbre <saket.dumbre@intel.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: [PATCH v1] ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()
Date:   Tue, 13 Jun 2023 17:25:07 +0200
Message-ID: <12237421.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghl
 rdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The addition of might_sleep() to down_timeout() caused the latter to
enable interrupts unconditionally in some cases, which in turn broke
the ACPI S3 wakeup path in acpi_suspend_enter(), where down_timeout()
is called by acpi_disable_all_gpes() via acpi_ut_acquire_mutex().

Namely, if CONFIG_DEBUG_ATOMIC_SLEEP is set, might_sleep() causes
might_resched() to be used and if CONFIG_PREEMPT_VOLUNTARY is set,
this triggers __cond_resched() which may call preempt_schedule_common(),
so __schedule() gets invoked and it ends up with enabled interrupts (in
the prev == next case).

Now, enabling interrupts early in the S3 wakeup path causes the kernel
to crash.

Address this by modifying acpi_suspend_enter() to disable GPEs without
attempting to acquire the sleeping lock which is not needed in that code
path anyway.

Fixes: 99409b935c9a locking/semaphore: Add might_sleep() to down_*() family
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/achware.h |    2 --
 drivers/acpi/sleep.c          |   16 ++++++++++++----
 include/acpi/acpixf.h         |    1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/acpica/achware.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/achware.h
+++ linux-pm/drivers/acpi/acpica/achware.h
@@ -101,8 +101,6 @@ acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status *event_status);
 
-acpi_status acpi_hw_disable_all_gpes(void);
-
 acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -761,6 +761,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 						     acpi_event_status
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -636,11 +636,19 @@ static int acpi_suspend_enter(suspend_st
 	}
 
 	/*
-	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
-	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
-	 * acpi_leave_sleep_state will reenable specific GPEs later
+	 * Disable all GPE and clear their status bits before interrupts are
+	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
+	 * prevent them from producing spurious interrups.
+	 *
+	 * acpi_leave_sleep_state() will reenable specific GPEs later.
+	 *
+	 * Because this code runs on one CPU with disabled interrupts (all of
+	 * the other CPUs are offline at that time), it need not acquire any
+	 * sleeping locks which maybe harmful due to instrumentation even if
+	 * those locks are not contended, so avoid doing that by using a low-
+	 * level library routine here.
 	 */
-	acpi_disable_all_gpes();
+	acpi_hw_disable_all_gpes();
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions();
 



