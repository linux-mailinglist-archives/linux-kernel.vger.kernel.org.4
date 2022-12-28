Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA665870C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiL1V1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiL1V1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:27:22 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C4140AF;
        Wed, 28 Dec 2022 13:27:21 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 36817dc0ed6b8a83; Wed, 28 Dec 2022 22:27:19 +0100
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 12A5D780AF8;
        Wed, 28 Dec 2022 22:27:19 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Pratyush Yadav <ptyadav@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit" frequency QoS
Date:   Wed, 28 Dec 2022 22:21:49 +0100
Message-ID: <12124970.O9o76ZdvQC@kreacher>
In-Reply-To: <12138067.O9o76ZdvQC@kreacher>
References: <12138067.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdduhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeekledrjeejrdehuddrkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdejjedrhedurdekgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpthihrggurghvsegrmhgriihonhdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghs
 rdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When _PPC returns 0, it means that the CPU frequency is not limited by
the platform firmware, so make acpi_processor_get_platform_limit()
update the frequency QoS request used by it to "no limit" in that case.

This addresses a problem with limiting CPU frequency artificially on
some systems after CPU offline/online to the frequency that corresponds
to the first entry in the _PSS return package.

Reported-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Move some changes into a separate patch
   * Update the changelog accordingly

---
 drivers/acpi/processor_perflib.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -53,6 +53,8 @@ static int acpi_processor_get_platform_l
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
+	s32 qos_value;
+	int index;
 	int ret;
 
 	if (!pr)
@@ -72,17 +74,27 @@ static int acpi_processor_get_platform_l
 		}
 	}
 
+	index = ppc;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
-		       (int)ppc, ppc ? "" : "not");
+		 index, index ? "is" : "is not");
 
-	pr->performance_platform_limit = (int)ppc;
+	pr->performance_platform_limit = index;
 
 	if (ppc >= pr->performance->state_count ||
 	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = freq_qos_update_request(&pr->perflib_req,
-			pr->performance->states[ppc].core_frequency * 1000);
+	/*
+	 * If _PPC returns 0, it means that all of the available states can be
+	 * used ("no limit").
+	 */
+	if (index == 0)
+		qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		qos_value = pr->performance->states[index].core_frequency * 1000;
+
+	ret = freq_qos_update_request(&pr->perflib_req, qos_value);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
 			pr->id, ret);



