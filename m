Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1A5FD98D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJMMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJMMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:50:34 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6220181;
        Thu, 13 Oct 2022 05:50:32 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 9bd3522237f0ea1e; Thu, 13 Oct 2022 14:50:30 +0200
Received: from kreacher.localnet (unknown [213.134.183.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8BF6B6667B9;
        Thu, 13 Oct 2022 14:50:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] thermal: intel_powerclamp: Use first online CPU as control_cpu
Date:   Thu, 13 Oct 2022 14:50:28 +0200
Message-ID: <5633735.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.5
X-CLIENT-HOSTNAME: 213.134.183.5
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekfedrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeefrdehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihurdgtrdgthhgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhht
 vghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrjhhunhdrphgrnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehprghvvghlsehutgifrdgtii
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead
of smp_processor_id() to avoid crash") fixed an issue related to using
smp_processor_id() in preemptible context by replacing it with a pair
of get_cpu()/put_cpu(), but what is needed there really is any online
CPU and not necessarily the one currently running the code.  Arguably,
getting the one that's running the code in there is confusing.

For this reason, simply give the control CPU role to the first online
one which automatically will be CPU0 if it is online, so one check
can be dropped from the code for an added benefit.

Link: https://lore.kernel.org/linux-pm/20221011113646.GA12080@duo.ucw.cz/
Fixes: 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead of smp_processor_id() to avoid crash")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_powerclamp.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_powerclamp.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_powerclamp.c
+++ linux-pm/drivers/thermal/intel/intel_powerclamp.c
@@ -516,11 +516,7 @@ static int start_power_clamp(void)
 	cpus_read_lock();
 
 	/* prefer BSP */
-	control_cpu = 0;
-	if (!cpu_online(control_cpu)) {
-		control_cpu = get_cpu();
-		put_cpu();
-	}
+	control_cpu = cpumask_first(cpu_online_mask);
 
 	clamping = true;
 	schedule_delayed_work(&poll_pkg_cstate_work, 0);



