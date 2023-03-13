Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2266B7A73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCMOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjCMOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:34:41 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655E24BE7;
        Mon, 13 Mar 2023 07:34:39 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 16fd6ca9926dc160; Mon, 13 Mar 2023 15:34:38 +0100
Received: from kreacher.localnet (unknown [213.134.189.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 71A469C5854;
        Mon, 13 Mar 2023 15:34:37 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quanxian Wang <quanxian.wang@intel.com>
Subject: [PATCH v2 1/4] ACPI: processor: Reorder acpi_processor_driver_init()
Date:   Mon, 13 Mar 2023 15:27:03 +0100
Message-ID: <5934791.lOV4Wx5bFT@kreacher>
In-Reply-To: <2692681.mvXUDI8C0e@kreacher>
References: <2692681.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.11
X-CLIENT-HOSTNAME: 213.134.189.11
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekledruddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledruddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
 rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpufreq policy notifier in the ACPI processor driver may as
well be registered before the driver itself, which causes
acpi_processor_cpufreq_init to be true (unless the notifier
registration fails, which is unlikely at that point) when the
ACPI CPU thermal cooling devices are registered, so the
processor_get_max_state() result does not change while
acpi_processor_driver_init() is running.

Change the ordering in acpi_processor_driver_init() accordingly
to prevent the max_state value from remaining 0 permanently for all
ACPI CPU cooling devices due to setting acpi_processor_cpufreq_init
too late.  [Note that processor_get_max_state() may still return
different values at different times after this change, depending on
the cpufreq driver registration time, but that issue needs to be
addressed separately.]

Fixes: a365105c685c("thermal: sysfs: Reuse cdev->max_state")
Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
Link: https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Expand changelog to explain that this particular patch addresses
          part of the issue.

---
 drivers/acpi/processor_driver.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c
+++ linux-pm/drivers/acpi/processor_driver.c
@@ -263,6 +263,12 @@ static int __init acpi_processor_driver_
 	if (acpi_disabled)
 		return 0;
 
+	if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
+				       CPUFREQ_POLICY_NOTIFIER)) {
+		acpi_processor_cpufreq_init = true;
+		acpi_processor_ignore_ppc_init();
+	}
+
 	result = driver_register(&acpi_processor_driver);
 	if (result < 0)
 		return result;
@@ -276,12 +282,6 @@ static int __init acpi_processor_driver_
 	cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
 				  NULL, acpi_soft_cpu_dead);
 
-	if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
-				       CPUFREQ_POLICY_NOTIFIER)) {
-		acpi_processor_cpufreq_init = true;
-		acpi_processor_ignore_ppc_init();
-	}
-
 	acpi_processor_throttling_init();
 	return 0;
 err:



