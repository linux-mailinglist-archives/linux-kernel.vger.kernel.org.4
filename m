Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347A567A284
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjAXTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjAXTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:19:13 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561B32522;
        Tue, 24 Jan 2023 11:19:10 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 489f2acd983c5755; Tue, 24 Jan 2023 20:19:09 +0100
Received: from kreacher.localnet (unknown [213.134.189.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 501A47A644A;
        Tue, 24 Jan 2023 20:19:08 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 4/6] thermal: intel: int340x: Rearrange int340x_thermal_read_trips()
Date:   Tue, 24 Jan 2023 20:17:09 +0100
Message-ID: <3238718.44csPzL39Z@kreacher>
In-Reply-To: <12159228.O9o76ZdvQC@kreacher>
References: <12159228.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.30
X-CLIENT-HOSTNAME: 213.134.189.30
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekledrfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledrfedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthho
 pehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use local variables trips and adev to store the addresses of the given
thermal zone's trip point table and ACPI device, respectively, and use
them to shorten some code lines.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -66,25 +66,27 @@ static struct thermal_zone_device_ops in
 
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
 {
+	struct thermal_trip *trips = int34x_zone->trips;
+	struct acpi_device *adev = int34x_zone->adev;
 	int trip_cnt;
 	int i, ret;
 
 	trip_cnt = int34x_zone->aux_trip_nr;
 
-	ret = thermal_acpi_trip_critical(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	ret = thermal_acpi_trip_critical(adev, &trips[trip_cnt]);
 	if (!ret)
 		trip_cnt++;
 
-	ret = thermal_acpi_trip_hot(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	ret = thermal_acpi_trip_hot(adev, &trips[trip_cnt]);
 	if (!ret)
 		trip_cnt++;
 
-	ret = thermal_acpi_trip_passive(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	ret = thermal_acpi_trip_passive(adev, &trips[trip_cnt]);
 	if (!ret)
 		trip_cnt++;
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		ret = thermal_acpi_trip_active(int34x_zone->adev, i, &int34x_zone->trips[trip_cnt]);
+		ret = thermal_acpi_trip_active(adev, i, &trips[trip_cnt]);
 		if (ret)
 			break;
 



