Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1060308B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJRQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJRQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:09:44 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598BA22BFD;
        Tue, 18 Oct 2022 09:09:40 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 349dc4d4a828391b; Tue, 18 Oct 2022 18:09:37 +0200
Received: from kreacher.localnet (unknown [213.134.183.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BA45666695D;
        Tue, 18 Oct 2022 18:09:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-rtc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
Date:   Tue, 18 Oct 2022 18:09:31 +0200
Message-ID: <5887691.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.104
X-CLIENT-HOSTNAME: 213.134.183.104
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppedvudefrddufeegrddukeefrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekfedruddtgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrrdiiuhhmmhhosehtohifvghrthgvtghhrdhithdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhttgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
 thhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmghhorhhmrghnsehtvggthhhsihhnghhulhgrrhhithihrdhnvghtpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehtohguugdrvgdrsghrrghnughtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
ordering issue") overlooked the fact that cmos_do_probe() depended
on the preparations carried out by cmos_wake_setup() and the wake
alarm stopped working after the ordering of them had been changed.

Address this by partially reverting commit 4919d3eb2ec0 so that
cmos_wake_setup() is called before cmos_do_probe() again and moving
the rtc_wake_setup() invocation from cmos_wake_setup() directly to the
callers of cmos_do_probe() where it will happen after a successful
completion of the latter.

Fixes: 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration ordering issue")
Reported-by: Zhang Rui <rui.zhang@intel.com>
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

@Bjorn: This is the minimum fix.  Folding cmos_wake_setup() into cmos_do_probe()
requires changes that are a bit intrusive for post-rc1, but I will do that later.

---
 drivers/rtc/rtc-cmos.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-pm.orig/drivers/rtc/rtc-cmos.c
+++ linux-pm/drivers/rtc/rtc-cmos.c
@@ -1233,6 +1233,9 @@ static u32 rtc_handler(void *context)
 
 static inline void rtc_wake_setup(struct device *dev)
 {
+	if (acpi_disabled)
+		return;
+
 	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, dev);
 	/*
 	 * After the RTC handler is installed, the Fixed_RTC event should
@@ -1286,7 +1289,6 @@ static void cmos_wake_setup(struct devic
 
 	use_acpi_alarm_quirks();
 
-	rtc_wake_setup(dev);
 	acpi_rtc_info.wake_on = rtc_wake_on;
 	acpi_rtc_info.wake_off = rtc_wake_off;
 
@@ -1354,6 +1356,8 @@ static int cmos_pnp_probe(struct pnp_dev
 {
 	int irq, ret;
 
+	cmos_wake_setup(&pnp->dev);
+
 	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
 		irq = 0;
 #ifdef CONFIG_X86
@@ -1372,7 +1376,7 @@ static int cmos_pnp_probe(struct pnp_dev
 	if (ret)
 		return ret;
 
-	cmos_wake_setup(&pnp->dev);
+	rtc_wake_setup(&pnp->dev);
 
 	return 0;
 }
@@ -1461,6 +1465,7 @@ static int __init cmos_platform_probe(st
 	int irq, ret;
 
 	cmos_of_init(pdev);
+	cmos_wake_setup(&pdev->dev);
 
 	if (RTC_IOMAPPED)
 		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -1474,7 +1479,7 @@ static int __init cmos_platform_probe(st
 	if (ret)
 		return ret;
 
-	cmos_wake_setup(&pdev->dev);
+	rtc_wake_setup(&pdev->dev);
 
 	return 0;
 }



