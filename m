Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60327216D5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFDMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:21:24 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDEB5;
        Sun,  4 Jun 2023 05:21:22 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id ac3ac691e1f6ec71; Sun, 4 Jun 2023 14:21:20 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C35A1963C55;
        Sun,  4 Jun 2023 14:21:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 7/7] ACPI: thermal: Drop struct acpi_thermal_flags
Date:   Sun, 04 Jun 2023 14:21:13 +0200
Message-ID: <2581616.Lt9SDvczpP@kreacher>
In-Reply-To: <2703629.mvXUDI8C0e@kreacher>
References: <2703629.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehm
 ihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop struct acpi_thermal_flags which is not really used (only one
flag in it is ever set, but it is never read) and call
acpi_execute_simple_method() directly to evaluate _SCP instead of
using acpi_thermal_set_cooling_mode(), which has no callers after
that change, so drop it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 drivers/acpi/thermal.c |   24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -129,12 +129,6 @@ struct acpi_thermal_trips {
 	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
 };
 
-struct acpi_thermal_flags {
-	u8 cooling_mode:1;	/* _SCP */
-	u8 devices:1;		/* _TZD */
-	u8 reserved:6;
-};
-
 struct acpi_thermal {
 	struct acpi_device *device;
 	acpi_bus_id name;
@@ -142,7 +136,6 @@ struct acpi_thermal {
 	unsigned long last_temperature;
 	unsigned long polling_frequency;
 	volatile u8 zombie;
-	struct acpi_thermal_flags flags;
 	struct acpi_thermal_trips trips;
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
@@ -197,18 +190,6 @@ static int acpi_thermal_get_polling_freq
 	return 0;
 }
 
-static int acpi_thermal_set_cooling_mode(struct acpi_thermal *tz, int mode)
-{
-	if (!tz)
-		return -EINVAL;
-
-	if (ACPI_FAILURE(acpi_execute_simple_method(tz->device->handle,
-						    "_SCP", mode)))
-		return -ENODEV;
-
-	return 0;
-}
-
 static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;
@@ -926,9 +907,8 @@ static int acpi_thermal_get_info(struct
 		return result;
 
 	/* Set the cooling mode [_SCP] to active cooling (default) */
-	result = acpi_thermal_set_cooling_mode(tz, ACPI_THERMAL_MODE_ACTIVE);
-	if (!result)
-		tz->flags.cooling_mode = 1;
+	acpi_execute_simple_method(tz->device->handle, "_SCP",
+				   ACPI_THERMAL_MODE_ACTIVE);
 
 	/* Get default polling frequency [_TZP] (optional) */
 	if (tzp)



