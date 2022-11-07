Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6361FF13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiKGUED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiKGUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:03:42 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F921821;
        Mon,  7 Nov 2022 12:03:40 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 081015dcfe8ce848; Mon, 7 Nov 2022 21:03:38 +0100
Received: from kreacher.localnet (unknown [213.134.188.205])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6BB0A6682BE;
        Mon,  7 Nov 2022 21:03:37 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] rtc: rtc-cmos: Call cmos_wake_setup() from cmos_do_probe()
Date:   Mon, 07 Nov 2022 20:59:09 +0100
Message-ID: <1850290.tdWV9SEqCh@kreacher>
In-Reply-To: <2276401.ElGaqSPkdT@kreacher>
References: <2276401.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.205
X-CLIENT-HOSTNAME: 213.134.188.205
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgddufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeekrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrvddthedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhttgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprgdriihumhhmohesthhofigvrhhtvggthhdrihhtpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that cmos_wake_setup() is the only user of acpi_rtc_info and it
can operate on the cmos_rtc variable directly, so it need not set the
platform_data pointer before cmos_do_probe() is called.  Instead, it
can be called by cmos_do_probe() in the case when the platform_data
pointer is not set to implement the default behavior (which is to use
the FADT information as long as ACPI support is enabled).

Modify the code accordingly.

While at it, drop a comment that doesn't really match the code it is
supposed to be describing.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/rtc/rtc-cmos.c |   47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-pm.orig/drivers/rtc/rtc-cmos.c
+++ linux-pm/drivers/rtc/rtc-cmos.c
@@ -744,6 +744,8 @@ static irqreturn_t cmos_interrupt(int ir
 		return IRQ_NONE;
 }
 
+static void cmos_wake_setup(struct device *dev);
+
 #ifdef	CONFIG_PNP
 #define	INITSECTION
 
@@ -827,19 +829,27 @@ cmos_do_probe(struct device *dev, struct
 		if (info->address_space)
 			address_space = info->address_space;
 
-		if (info->rtc_day_alarm && info->rtc_day_alarm < 128)
-			cmos_rtc.day_alrm = info->rtc_day_alarm;
-		if (info->rtc_mon_alarm && info->rtc_mon_alarm < 128)
-			cmos_rtc.mon_alrm = info->rtc_mon_alarm;
-		if (info->rtc_century && info->rtc_century < 128)
-			cmos_rtc.century = info->rtc_century;
+		cmos_rtc.day_alrm = info->rtc_day_alarm;
+		cmos_rtc.mon_alrm = info->rtc_mon_alarm;
+		cmos_rtc.century = info->rtc_century;
 
 		if (info->wake_on && info->wake_off) {
 			cmos_rtc.wake_on = info->wake_on;
 			cmos_rtc.wake_off = info->wake_off;
 		}
+	} else {
+		cmos_wake_setup(dev);
 	}
 
+	if (cmos_rtc.day_alrm >= 128)
+		cmos_rtc.day_alrm = 0;
+
+	if (cmos_rtc.mon_alrm >= 128)
+		cmos_rtc.mon_alrm = 0;
+
+	if (cmos_rtc.century >= 128)
+		cmos_rtc.century = 0;
+
 	cmos_rtc.dev = dev;
 	dev_set_drvdata(dev, &cmos_rtc);
 
@@ -1275,13 +1285,6 @@ static void use_acpi_alarm_quirks(void)
 static inline void use_acpi_alarm_quirks(void) { }
 #endif
 
-/* Every ACPI platform has a mc146818 compatible "cmos rtc".  Here we find
- * its device node and pass extra config data.  This helps its driver use
- * capabilities that the now-obsolete mc146818 didn't have, and informs it
- * that this board's RTC is wakeup-capable (per ACPI spec).
- */
-static struct cmos_rtc_board_info acpi_rtc_info;
-
 static void cmos_wake_setup(struct device *dev)
 {
 	if (acpi_disabled)
@@ -1289,26 +1292,23 @@ static void cmos_wake_setup(struct devic
 
 	use_acpi_alarm_quirks();
 
-	acpi_rtc_info.wake_on = rtc_wake_on;
-	acpi_rtc_info.wake_off = rtc_wake_off;
+	cmos_rtc.wake_on = rtc_wake_on;
+	cmos_rtc.wake_off = rtc_wake_off;
 
-	/* workaround bug in some ACPI tables */
+	/* ACPI tables bug workaround. */
 	if (acpi_gbl_FADT.month_alarm && !acpi_gbl_FADT.day_alarm) {
 		dev_dbg(dev, "bogus FADT month_alarm (%d)\n",
 			acpi_gbl_FADT.month_alarm);
 		acpi_gbl_FADT.month_alarm = 0;
 	}
 
-	acpi_rtc_info.rtc_day_alarm = acpi_gbl_FADT.day_alarm;
-	acpi_rtc_info.rtc_mon_alarm = acpi_gbl_FADT.month_alarm;
-	acpi_rtc_info.rtc_century = acpi_gbl_FADT.century;
+	cmos_rtc.day_alrm = acpi_gbl_FADT.day_alarm;
+	cmos_rtc.mon_alrm = acpi_gbl_FADT.month_alarm;
+	cmos_rtc.century = acpi_gbl_FADT.century;
 
-	/* NOTE:  S4_RTC_WAKE is NOT currently useful to Linux */
 	if (acpi_gbl_FADT.flags & ACPI_FADT_S4_RTC_WAKE)
 		dev_info(dev, "RTC can wake from S4\n");
 
-	dev->platform_data = &acpi_rtc_info;
-
 	/* RTC always wakes from S1/S2/S3, and often S4/STD */
 	device_init_wakeup(dev, 1);
 }
@@ -1359,8 +1359,6 @@ static int cmos_pnp_probe(struct pnp_dev
 {
 	int irq, ret;
 
-	cmos_wake_setup(&pnp->dev);
-
 	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
 		irq = 0;
 #ifdef CONFIG_X86
@@ -1468,7 +1466,6 @@ static int __init cmos_platform_probe(st
 	int irq, ret;
 
 	cmos_of_init(pdev);
-	cmos_wake_setup(&pdev->dev);
 
 	if (RTC_IOMAPPED)
 		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);



