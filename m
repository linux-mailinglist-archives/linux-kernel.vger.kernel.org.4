Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3016647F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjAJR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjAJR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:17 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B907A44E;
        Tue, 10 Jan 2023 09:58:09 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 322c10ed6f9fbde9; Tue, 10 Jan 2023 18:58:07 +0100
Received: from kreacher.localnet (unknown [213.134.183.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9B0452625407;
        Tue, 10 Jan 2023 18:58:06 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Date:   Tue, 10 Jan 2023 18:58:05 +0100
Message-ID: <12149290.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.108
X-CLIENT-HOSTNAME: 213.134.183.108
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudekfedruddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeefrddutdekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihurdgtrdgthhgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases, PNP device IDs from acpi_pnp_device_ids[] are returned by
_CID for devices for which matching platform drivers are present in the
kernel and should be bound to them.  However, the IDs coming from _CID
cause the PNP scan handler to attach to those devices which prevents
platform device objects from being created for them.

Address this by introducing a list of known non-PNP device IDs into
acpi_pnp.c such that if a device ID is there in that list, it cannot be
attached to by the PNP scan handler and add the platform runtime update
and telemetry device IDs to that list to start with.

Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pnp.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/acpi_pnp.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_pnp.c
+++ linux-pm/drivers/acpi/acpi_pnp.c
@@ -348,10 +348,22 @@ static bool acpi_pnp_match(const char *i
 	return false;
 }
 
+/*
+ * If one of the device IDs below is present in the list of device IDs of a
+ * given ACPI device object, the PNP scan handler will not attach to that
+ * object, because there is a proper non-PNP driver in the kernel for the
+ * device represented by it.
+ */
+static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
+	{"INTC1080"},
+	{"INTC1081"},
+	{""},
+};
+
 static int acpi_pnp_attach(struct acpi_device *adev,
 			   const struct acpi_device_id *id)
 {
-	return 1;
+	return !!acpi_match_device_ids(adev, acpi_nonpnp_device_ids);
 }
 
 static struct acpi_scan_handler acpi_pnp_handler = {



