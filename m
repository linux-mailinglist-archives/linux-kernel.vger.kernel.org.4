Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9973FDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjF0OgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjF0OgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:36:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB330F1;
        Tue, 27 Jun 2023 07:35:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 5fa6a326169e7c8a; Tue, 27 Jun 2023 16:35:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6236F660365;
        Tue, 27 Jun 2023 16:35:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Jeremy Compostella <jeremy.compostella@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1] ACPI: EC: Fix acpi_ec_dispatch_gpe()
Date:   Tue, 27 Jun 2023 16:35:52 +0200
Message-ID: <12234124.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrhgvmhihrdgtohhmphhoshhtvghllhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 896e97bf99ec ("ACPI: EC: Clear GPE on interrupt handling only")
broke suspend-to-idle at least on Dell XPS13 9360 and 9380.

The problem is that acpi_ec_dispatch_gpe() must clear the EC GPE,
because the EC GPE handler never runs when the system is in the
suspend-to-idle state and if the EC GPE is not cleared by the suspend-
to-idle loop, it is never cleared at all which leads to a GPE storm.
This causes suspend-to-idle to burn energy instead of saving it which
is potentially dangerous (the affected machines heat up rather badly
when that happens).

Addess this by making acpi_ec_dispatch_gpe() clear the EC GPE as it did
before.

Fixes: 896e97bf99ec ("ACPI: EC: Clear GPE on interrupt handling only")
Tested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1267,12 +1267,8 @@ static void acpi_ec_event_handler(struct
 	spin_unlock_irq(&ec->lock);
 }
 
-static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
+static void clear_gpe_and_advance_transaction(struct acpi_ec *ec, bool interrupt)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
-
 	/*
 	 * Clear GPE_STS upfront to allow subsequent hardware GPE_STS 0->1
 	 * changes to always trigger a GPE interrupt.
@@ -1289,6 +1285,16 @@ static void acpi_ec_handle_interrupt(str
 		acpi_clear_gpe(NULL, ec->gpe);
 
 	advance_transaction(ec, true);
+}
+
+static void acpi_ec_handle_interrupt(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+
+	clear_gpe_and_advance_transaction(ec, true);
+
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
@@ -2083,7 +2089,7 @@ bool acpi_ec_dispatch_gpe(void)
 	if (acpi_ec_gpe_status_set(first_ec)) {
 		pm_pr_dbg("ACPI EC GPE status set\n");
 
-		advance_transaction(first_ec, false);
+		clear_gpe_and_advance_transaction(first_ec, false);
 		work_in_progress = acpi_ec_work_in_progress(first_ec);
 	}
 



