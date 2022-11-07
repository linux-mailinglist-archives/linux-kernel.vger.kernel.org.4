Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177861FF03
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiKGUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiKGUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:03:37 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7F178BB;
        Mon,  7 Nov 2022 12:03:35 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 0badc597a4899159; Mon, 7 Nov 2022 21:03:31 +0100
Received: from kreacher.localnet (unknown [213.134.188.205])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D8CB46682BE;
        Mon,  7 Nov 2022 21:03:30 +0100 (CET)
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
Subject: [PATCH v1 5/5] rtc: rtc-cmos: Disable ACPI RTC event on removal
Date:   Mon, 07 Nov 2022 21:03:06 +0100
Message-ID: <2219830.iZASKD2KPV@kreacher>
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

Make cmos_do_remove() drop the ACPI RTC fixed event handler so as to
prevent it from operating on stale data in case the event triggers
after driver removal.

While at it, make cmos_do_remove() also clear the driver data pointer
of the device and make cmos_acpi_wake_setup() do that in the error path
too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/rtc/rtc-cmos.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-pm/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-pm.orig/drivers/rtc/rtc-cmos.c
+++ linux-pm/drivers/rtc/rtc-cmos.c
@@ -798,6 +798,12 @@ static inline void acpi_rtc_event_setup(
 	acpi_disable_event(ACPI_EVENT_RTC, 0);
 }
 
+static inline void acpi_rtc_event_cleanup(void)
+{
+	if (!acpi_disabled)
+		acpi_remove_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler);
+}
+
 static void rtc_wake_on(struct device *dev)
 {
 	acpi_clear_event(ACPI_EVENT_RTC);
@@ -884,6 +890,10 @@ static inline void acpi_rtc_event_setup(
 {
 }
 
+static inline void acpi_rtc_event_cleanup(void)
+{
+}
+
 static inline void cmos_acpi_wake_setup(struct device *dev)
 {
 }
@@ -1109,6 +1119,7 @@ cleanup2:
 		free_irq(rtc_irq, cmos_rtc.rtc);
 cleanup1:
 	cmos_rtc.dev = NULL;
+	dev_set_drvdata(dev, NULL);
 cleanup0:
 	if (RTC_IOMAPPED)
 		release_region(ports->start, resource_size(ports));
@@ -1138,6 +1149,9 @@ static void cmos_do_remove(struct device
 			hpet_unregister_irq_handler(cmos_interrupt);
 	}
 
+	if (!dev_get_platdata(dev))
+		acpi_rtc_event_cleanup();
+
 	cmos->rtc = NULL;
 
 	ports = cmos->iomem;
@@ -1148,6 +1162,7 @@ static void cmos_do_remove(struct device
 	cmos->iomem = NULL;
 
 	cmos->dev = NULL;
+	dev_set_drvdata(dev, NULL);
 }
 
 static int cmos_aie_poweroff(struct device *dev)



