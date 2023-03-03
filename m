Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF96AA008
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCCTYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCCTYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:24:11 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC510408;
        Fri,  3 Mar 2023 11:24:09 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 45dcb4239fb6fbda; Fri, 3 Mar 2023 20:24:07 +0100
Received: from kreacher.localnet (unknown [213.134.183.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CE9CC20619DE;
        Fri,  3 Mar 2023 20:24:06 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quanxian Wang <quanxian.wang@intel.com>
Subject: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling devices on cpufreq policy changes
Date:   Fri, 03 Mar 2023 20:23:58 +0100
Message-ID: <1936685.PYKUYFuaPT@kreacher>
In-Reply-To: <2148907.irdbgypaU6@kreacher>
References: <2148907.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.41
X-CLIENT-HOSTNAME: 213.134.183.41
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukeefrdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeefrdeguddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
 rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When a cpufreq policy appears or goes away, the CPU cooling devices for
the CPUs covered by that policy need to be updated so that the new
processor_get_max_state() value is stored as max_state and the
statistics in sysfs are rearranged for each of them.

Do that accordingly in acpi_thermal_cpufreq_init() and
acpi_thermal_cpufreq_exit().

Fixes: a365105c685c("thermal: sysfs: Reuse cdev->max_state")
Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
Link: https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_thermal.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/processor_thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_thermal.c
+++ linux-pm/drivers/acpi/processor_thermal.c
@@ -140,9 +140,14 @@ void acpi_thermal_cpufreq_init(struct cp
 		ret = freq_qos_add_request(&policy->constraints,
 					   &pr->thermal_req,
 					   FREQ_QOS_MAX, INT_MAX);
-		if (ret < 0)
+		if (ret < 0) {
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
+			continue;
+		}
+
+		if (!IS_ERR(pr->cdev))
+			thermal_cooling_device_update(pr->cdev);
 	}
 }
 
@@ -153,8 +158,13 @@ void acpi_thermal_cpufreq_exit(struct cp
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 
-		if (pr)
-			freq_qos_remove_request(&pr->thermal_req);
+		if (!pr)
+			continue;
+
+		freq_qos_remove_request(&pr->thermal_req);
+
+		if (!IS_ERR(pr->cdev))
+			thermal_cooling_device_update(pr->cdev);
 	}
 }
 #else				/* ! CONFIG_CPU_FREQ */



