Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2088A67B52B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjAYOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjAYOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:55:45 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA74EC6;
        Wed, 25 Jan 2023 06:55:39 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 7fbb2e3704d35487; Wed, 25 Jan 2023 15:55:38 +0100
Received: from kreacher.localnet (unknown [213.134.163.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 994952201948;
        Wed, 25 Jan 2023 15:55:37 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/3] thermal: intel: int340x: Use zone lock for synchronization
Date:   Wed, 25 Jan 2023 15:54:03 +0100
Message-ID: <4798426.GXAFRqVoOG@kreacher>
In-Reply-To: <5665899.DvuYhMxLoT@kreacher>
References: <5665899.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.149
X-CLIENT-HOSTNAME: 213.134.163.149
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduieefrddugeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrudegledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the ->get_trip_temp() and ->get_trip_type() thermal zone
callbacks are only invoked from __thermal_zone_get_trip() which is
always called by the thermal core under the zone lock, it is sufficient
for int340x_thermal_update_trips() to acquire the zone lock for mutual
exclusion with those callbacks.

Accordingly, modify int340x_thermal_update_trips() to use the zone lock
instead of the internal trip_mutex and drop the latter which is not
necessary any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   28 +++--------
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h |    1 
 2 files changed, 8 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -41,9 +41,7 @@ static int int340x_thermal_get_trip_temp
 					 int trip, int *temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
-	int i, ret = 0;
-
-	mutex_lock(&d->trip_mutex);
+	int i;
 
 	if (trip < d->aux_trip_nr)
 		*temp = d->aux_trips[trip];
@@ -62,12 +60,10 @@ static int int340x_thermal_get_trip_temp
 			}
 		}
 		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
-	mutex_unlock(&d->trip_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
@@ -75,9 +71,7 @@ static int int340x_thermal_get_trip_type
 					 enum thermal_trip_type *type)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
-	int i, ret = 0;
-
-	mutex_lock(&d->trip_mutex);
+	int i;
 
 	if (trip < d->aux_trip_nr)
 		*type = THERMAL_TRIP_PASSIVE;
@@ -96,12 +90,10 @@ static int int340x_thermal_get_trip_type
 			}
 		}
 		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
-	mutex_unlock(&d->trip_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
@@ -222,8 +214,6 @@ struct int34x_thermal_zone *int340x_ther
 	if (!int34x_thermal_zone)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_init(&int34x_thermal_zone->trip_mutex);
-
 	int34x_thermal_zone->adev = adev;
 
 	int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
@@ -286,7 +276,6 @@ err_thermal_zone:
 err_trip_alloc:
 	kfree(int34x_thermal_zone->ops);
 err_ops_alloc:
-	mutex_destroy(&int34x_thermal_zone->trip_mutex);
 	kfree(int34x_thermal_zone);
 	return ERR_PTR(ret);
 }
@@ -299,7 +288,6 @@ void int340x_thermal_zone_remove(struct
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone->aux_trips);
 	kfree(int34x_thermal_zone->ops);
-	mutex_destroy(&int34x_thermal_zone->trip_mutex);
 	kfree(int34x_thermal_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
@@ -309,7 +297,7 @@ void int340x_thermal_update_trips(struct
 	acpi_handle zone_handle = int34x_zone->adev->handle;
 	int i, err;
 
-	mutex_lock(&int34x_zone->trip_mutex);
+	mutex_lock(&int34x_zone->zone->lock);
 
 	if (int34x_zone->crt_trip_id > 0) {
 		err = int340x_thermal_get_trip_config(zone_handle, "_CRT",
@@ -344,7 +332,7 @@ void int340x_thermal_update_trips(struct
 			int34x_zone->act_trips[i].temp = THERMAL_TEMP_INVALID;
 	}
 
-	mutex_unlock(&int34x_zone->trip_mutex);
+	mutex_unlock(&int34x_zone->zone->lock);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
 
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -32,7 +32,6 @@ struct int34x_thermal_zone {
 	struct thermal_zone_device_ops *ops;
 	void *priv_data;
 	struct acpi_lpat_conversion_table *lpat_table;
-	struct mutex trip_mutex;
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,



