Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB49716770
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjE3PqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjE3PqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:46:05 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FFEC7;
        Tue, 30 May 2023 08:46:00 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id b5dd397e3628a3f2; Tue, 30 May 2023 17:45:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D8F848BB094;
        Tue, 30 May 2023 17:45:58 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 4/5] ACPI: thermal: Move acpi_thermal_driver definition
Date:   Tue, 30 May 2023 17:44:40 +0200
Message-ID: <21889638.EfDdHjke4D@kreacher>
In-Reply-To: <5675481.DvuYhMxLoT@kreacher>
References: <5675481.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehm
 ihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhm
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

Move the definition of the acpi_thermal_driver structure closer to the
initialization code that registes the driver, so some function forward
declarations can be dropped.

Also move the module information to the end of the file where it is
usually located.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   66 +++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -70,10 +70,6 @@ do { \
 			"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
-MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
-MODULE_LICENSE("GPL");
-
 static int act;
 module_param(act, int, 0644);
 MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.");
@@ -100,37 +96,6 @@ MODULE_PARM_DESC(psv, "Disable or overri
 
 static struct workqueue_struct *acpi_thermal_pm_queue;
 
-static int acpi_thermal_add(struct acpi_device *device);
-static void acpi_thermal_remove(struct acpi_device *device);
-static void acpi_thermal_notify(struct acpi_device *device, u32 event);
-
-static const struct acpi_device_id  thermal_device_ids[] = {
-	{ACPI_THERMAL_HID, 0},
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
-
-#ifdef CONFIG_PM_SLEEP
-static int acpi_thermal_suspend(struct device *dev);
-static int acpi_thermal_resume(struct device *dev);
-#else
-#define acpi_thermal_suspend NULL
-#define acpi_thermal_resume NULL
-#endif
-static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
-
-static struct acpi_driver acpi_thermal_driver = {
-	.name = "thermal",
-	.class = ACPI_THERMAL_CLASS,
-	.ids = thermal_device_ids,
-	.ops = {
-		.add = acpi_thermal_add,
-		.remove = acpi_thermal_remove,
-		.notify = acpi_thermal_notify,
-		},
-	.drv.pm = &acpi_thermal_pm,
-};
-
 struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
@@ -1131,6 +1096,33 @@ static int acpi_thermal_resume(struct de
 }
 #endif
 
+static const struct acpi_device_id  thermal_device_ids[] = {
+	{ACPI_THERMAL_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
+
+#ifdef CONFIG_PM_SLEEP
+static int acpi_thermal_suspend(struct device *dev);
+static int acpi_thermal_resume(struct device *dev);
+#else
+#define acpi_thermal_suspend	NULL
+#define acpi_thermal_resume	NULL
+#endif
+static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
+
+static struct acpi_driver acpi_thermal_driver = {
+	.name = "thermal",
+	.class = ACPI_THERMAL_CLASS,
+	.ids = thermal_device_ids,
+	.ops = {
+		.add = acpi_thermal_add,
+		.remove = acpi_thermal_remove,
+		.notify = acpi_thermal_notify,
+		},
+	.drv.pm = &acpi_thermal_pm,
+};
+
 static int thermal_act(const struct dmi_system_id *d) {
 	if (act == 0) {
 		pr_notice("%s detected: disabling all active thermal trip points\n",
@@ -1235,3 +1227,7 @@ static void __exit acpi_thermal_exit(voi
 
 module_init(acpi_thermal_init);
 module_exit(acpi_thermal_exit);
+
+MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
+MODULE_LICENSE("GPL");



