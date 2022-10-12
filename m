Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0B5FCA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJLSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:07:07 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622861B06;
        Wed, 12 Oct 2022 11:07:05 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 9949fdea2438a364; Wed, 12 Oct 2022 20:07:03 +0200
Received: from kreacher.localnet (unknown [213.134.169.115])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 63C5666677E;
        Wed, 12 Oct 2022 20:07:02 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-rtc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] rtc: rtc-cmos: Fix event handler registration ordering issue
Date:   Wed, 12 Oct 2022 20:07:01 +0200
Message-ID: <5629262.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.115
X-CLIENT-HOSTNAME: 213.134.169.115
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduieelrdduudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrudduhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprgdriihumhhmohesthhofigvrhhtvggthhdrihhtpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhrthgtsehv
 ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhgohhrmhgrnhesthgvtghhshhinhhguhhlrghrihhthidrnhgvth
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because acpi_install_fixed_event_handler() enables the event
automatically on success, it is incorrect to call it before the
handler routine passed to it is ready to handle events.

Unfortunately, the rtc-cmos driver does exactly the incorrect thing
by calling cmos_wake_setup(), which passes rtc_handler() to
acpi_install_fixed_event_handler(), before cmos_do_probe(), because
rtc_handler() uses dev_get_drvdata() to get to the cmos object
pointer and the driver data pointer is only populated in
cmos_do_probe().

This leads to a NULL pointer dereference in rtc_handler() on boot
if the RTC fixed event happens to be active at the init time.

To address this issue, change the initialization ordering of the
driver so that cmos_wake_setup() is always called after a successful
cmos_do_probe() call.

While at it, change cmos_pnp_probe() to call cmos_do_probe() after
the initial if () statement used for computing the IRQ argument to
be passed to cmos_do_probe() which is cleaner than calling it in
each branch of that if () (local variable "irq" can be of type int,
because it is passed to that function as an argument of type int).

Note that commit 6492fed7d8c9 ("rtc: rtc-cmos: Do not check
ACPI_FADT_LOW_POWER_S0") caused this issue to affect a larger number
of systems, because previously it only affected systems with
ACPI_FADT_LOW_POWER_S0 set, but it is present regardless of that
commit.

Fixes: 6492fed7d8c9 ("rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0")
Fixes: a474aaedac99 ("rtc-cmos: move wake setup from ACPI glue into RTC driver")
Link: https://lore.kernel.org/linux-acpi/20221010141630.zfzi7mk7zvnmclzy@techsingularity.net/
Reported-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/rtc/rtc-cmos.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-pm.orig/drivers/rtc/rtc-cmos.c
+++ linux-pm/drivers/rtc/rtc-cmos.c
@@ -1352,10 +1352,10 @@ static void cmos_check_acpi_rtc_status(s
 
 static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 {
-	cmos_wake_setup(&pnp->dev);
+	int irq, ret;
 
 	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
-		unsigned int irq = 0;
+		irq = 0;
 #ifdef CONFIG_X86
 		/* Some machines contain a PNP entry for the RTC, but
 		 * don't define the IRQ. It should always be safe to
@@ -1364,13 +1364,17 @@ static int cmos_pnp_probe(struct pnp_dev
 		if (nr_legacy_irqs())
 			irq = RTC_IRQ;
 #endif
-		return cmos_do_probe(&pnp->dev,
-				pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
 	} else {
-		return cmos_do_probe(&pnp->dev,
-				pnp_get_resource(pnp, IORESOURCE_IO, 0),
-				pnp_irq(pnp, 0));
+		irq = pnp_irq(pnp, 0);
 	}
+
+	ret = cmos_do_probe(&pnp->dev, pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
+	if (ret)
+		return ret;
+
+	cmos_wake_setup(&pnp->dev);
+
+	return 0;
 }
 
 static void cmos_pnp_remove(struct pnp_dev *pnp)
@@ -1454,10 +1458,9 @@ static inline void cmos_of_init(struct p
 static int __init cmos_platform_probe(struct platform_device *pdev)
 {
 	struct resource *resource;
-	int irq;
+	int irq, ret;
 
 	cmos_of_init(pdev);
-	cmos_wake_setup(&pdev->dev);
 
 	if (RTC_IOMAPPED)
 		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -1467,7 +1470,13 @@ static int __init cmos_platform_probe(st
 	if (irq < 0)
 		irq = -1;
 
-	return cmos_do_probe(&pdev->dev, resource, irq);
+	ret = cmos_do_probe(&pdev->dev, resource, irq);
+	if (ret)
+		return ret;
+
+	cmos_wake_setup(&pdev->dev);
+
+	return 0;
 }
 
 static int cmos_platform_remove(struct platform_device *pdev)



