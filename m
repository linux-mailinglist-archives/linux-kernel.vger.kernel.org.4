Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B367888D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAWUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:44:08 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8A4C25;
        Mon, 23 Jan 2023 12:44:06 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 81c69f774a457d50; Mon, 23 Jan 2023 21:44:05 +0100
Received: from kreacher.localnet (unknown [213.134.188.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3E48E21322A8;
        Mon, 23 Jan 2023 21:44:04 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2] thermal: Fail object registration if thermal class is not registered
Date:   Mon, 23 Jan 2023 21:44:03 +0100
Message-ID: <5660360.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.170
X-CLIENT-HOSTNAME: 213.134.188.170
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukeekrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudejtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghs
 rdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If thermal_class is not registered with the driver core, there is no way
to expose the interfaces used by the thermal control framework, so
prevent thermal zones and cooling devices from being registered in
that case by returning an error from object registration functions.

For this purpose, use a thermal_class pointer that will be NULL if the
class is not registered.  To avoid wasting memory in that case, allocate
the thermal class object dynamically and if it fails to register, free
it and clear the thermal_class pointer to NULL.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: This replaces the series at
       https://lore.kernel.org/linux-pm/5905717.lOV4Wx5bFT@kreacher/

---
 drivers/thermal/thermal_core.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -774,10 +774,7 @@ static void thermal_release(struct devic
 	}
 }
 
-static struct class thermal_class = {
-	.name = "thermal",
-	.dev_release = thermal_release,
-};
+static struct class *thermal_class;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -880,6 +877,9 @@ __thermal_cooling_device_register(struct
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
+	if (!thermal_class)
+		return ERR_PTR(-ENODEV);
+
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
@@ -901,7 +901,7 @@ __thermal_cooling_device_register(struct
 	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
-	cdev->device.class = &thermal_class;
+	cdev->device.class = thermal_class;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
@@ -1349,6 +1349,9 @@ thermal_zone_device_register_with_trips(
 	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
 		return ERR_PTR(-EINVAL);
 
+	if (!thermal_class)
+		return ERR_PTR(-ENODEV);
+
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
@@ -1370,7 +1373,7 @@ thermal_zone_device_register_with_trips(
 
 	tz->ops = ops;
 	tz->tzp = tzp;
-	tz->device.class = &thermal_class;
+	tz->device.class = thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
 	tz->num_trips = num_trips;
@@ -1615,9 +1618,21 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	result = class_register(&thermal_class);
-	if (result)
+	thermal_class = kzalloc(sizeof(*thermal_class), GFP_KERNEL);
+	if (!thermal_class) {
+		result = -ENOMEM;
+		goto unregister_governors;
+	}
+
+	thermal_class->name = "thermal";
+	thermal_class->dev_release = thermal_release;
+
+	result = class_register(thermal_class);
+	if (result) {
+		kfree(thermal_class);
+		thermal_class = NULL;
 		goto unregister_governors;
+	}
 
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)



