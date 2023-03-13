Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7583F6B7A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCMOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCMOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:34:39 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144B196B9;
        Mon, 13 Mar 2023 07:34:36 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 0bedc2db18c9cec4; Mon, 13 Mar 2023 15:34:35 +0100
Received: from kreacher.localnet (unknown [213.134.189.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9DF529C5854;
        Mon, 13 Mar 2023 15:34:34 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quanxian Wang <quanxian.wang@intel.com>
Subject: [PATCH v2 3/4] thermal: core: Introduce thermal_cooling_device_update()
Date:   Mon, 13 Mar 2023 15:32:26 +0100
Message-ID: <2156873.irdbgypaU6@kreacher>
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

Introduce a core thermal API function, thermal_cooling_device_update(),
for updating the max_state value for a cooling device and rearranging
its statistics in sysfs after a possible change of its ->get_max_state()
callback return value.

That callback is now invoked only once, during cooling device
registration, to populate the max_state field in the cooling device
object, so if its return value changes, it needs to be invoked again
and the new return value needs to be stored as max_state.  Moreover,
the statistics presented in sysfs need to be rearranged in general,
because there may not be enough room in them to store data for all
of the possible states (in the case when max_state grows).

The new function takes care of that (and some other minor things
related to it), but some extra locking and lockdep annotations are
added in several places too to protect against crashes in the cases
when the statistics are not present or when a stale max_state value
might be used by sysfs attributes.

Note that the actual user of the new function will be added separately.

Link: https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
    * Make thermal_cooling_device_update() do the full IS_ERR_OR_NULL() check
      on cdev, so that its callers don't need to do it.
    * Remove ->set_cur_state() callback invocation from
      thermal_cooling_device_update(), because it is redundant (and it doesn't
      make sense to pass a state value exceeding max_state to it anyway).

---
 drivers/thermal/thermal_core.c  |   40 ++++++++++++++++++++++
 drivers/thermal/thermal_core.h  |    1 
 drivers/thermal/thermal_sysfs.c |   72 +++++++++++++++++++++++++++++++++++-----
 include/linux/thermal.h         |    1 
 4 files changed, 106 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1057,6 +1057,46 @@ static bool thermal_cooling_device_prese
 	return false;
 }
 
+void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
+{
+	unsigned long state;
+
+	if (IS_ERR_OR_NULL(cdev))
+		return;
+
+	/*
+	 * Hold thermal_list_lock throughout the update to prevent the device
+	 * from going away while being updated.
+	 */
+	mutex_lock(&thermal_list_lock);
+
+	if (!thermal_cooling_device_present(cdev))
+		goto unlock_list;
+
+	/*
+	 * Update under the cdev lock to prevent the state from being set beyond
+	 * the new limit concurrently.
+	 */
+	mutex_lock(&cdev->lock);
+
+	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
+		goto unlock;
+
+	thermal_cooling_device_stats_reinit(cdev);
+
+	if (cdev->ops->get_cur_state(cdev, &state) || state > cdev->max_state)
+		goto unlock;
+
+	thermal_cooling_device_stats_update(cdev, state);
+
+unlock:
+	mutex_unlock(&cdev->lock);
+
+unlock_list:
+	mutex_unlock(&thermal_list_lock);
+}
+EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
+
 static void __unbind(struct thermal_zone_device *tz, int mask,
 		     struct thermal_cooling_device *cdev)
 {
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -685,6 +685,8 @@ void thermal_cooling_device_stats_update
 {
 	struct cooling_dev_stats *stats = cdev->stats;
 
+	lockdep_assert_held(&cdev->lock);
+
 	if (!stats)
 		return;
 
@@ -706,13 +708,22 @@ static ssize_t total_trans_show(struct d
 				struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
+	struct cooling_dev_stats *stats;
 	int ret;
 
+	mutex_lock(&cdev->lock);
+
+	stats = cdev->stats;
+	if (!stats)
+		goto unlock;
+
 	spin_lock(&stats->lock);
 	ret = sprintf(buf, "%u\n", stats->total_trans);
 	spin_unlock(&stats->lock);
 
+unlock:
+	mutex_unlock(&cdev->lock);
+
 	return ret;
 }
 
@@ -721,11 +732,18 @@ time_in_state_ms_show(struct device *dev
 		      char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
+	struct cooling_dev_stats *stats;
 	ssize_t len = 0;
 	int i;
 
+	mutex_lock(&cdev->lock);
+
+	stats = cdev->stats;
+	if (!stats)
+		goto unlock;
+
 	spin_lock(&stats->lock);
+
 	update_time_in_state(stats);
 
 	for (i = 0; i <= cdev->max_state; i++) {
@@ -734,6 +752,9 @@ time_in_state_ms_show(struct device *dev
 	}
 	spin_unlock(&stats->lock);
 
+unlock:
+	mutex_unlock(&cdev->lock);
+
 	return len;
 }
 
@@ -742,8 +763,16 @@ reset_store(struct device *dev, struct d
 	    size_t count)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
-	int i, states = cdev->max_state + 1;
+	struct cooling_dev_stats *stats;
+	int i, states;
+
+	mutex_lock(&cdev->lock);
+
+	stats = cdev->stats;
+	if (!stats)
+		goto unlock;
+
+	states = cdev->max_state + 1;
 
 	spin_lock(&stats->lock);
 
@@ -757,6 +786,9 @@ reset_store(struct device *dev, struct d
 
 	spin_unlock(&stats->lock);
 
+unlock:
+	mutex_unlock(&cdev->lock);
+
 	return count;
 }
 
@@ -764,10 +796,18 @@ static ssize_t trans_table_show(struct d
 				struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	struct cooling_dev_stats *stats = cdev->stats;
+	struct cooling_dev_stats *stats;
 	ssize_t len = 0;
 	int i, j;
 
+	mutex_lock(&cdev->lock);
+
+	stats = cdev->stats;
+	if (!stats) {
+		len = -ENODATA;
+		goto unlock;
+	}
+
 	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
 	for (i = 0; i <= cdev->max_state; i++) {
@@ -775,8 +815,10 @@ static ssize_t trans_table_show(struct d
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+	if (len >= PAGE_SIZE) {
+		len = PAGE_SIZE;
+		goto unlock;
+	}
 
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
@@ -799,8 +841,12 @@ static ssize_t trans_table_show(struct d
 
 	if (len >= PAGE_SIZE) {
 		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
-		return -EFBIG;
+		len = -EFBIG;
 	}
+
+unlock:
+	mutex_unlock(&cdev->lock);
+
 	return len;
 }
 
@@ -830,6 +876,8 @@ static void cooling_device_stats_setup(s
 	unsigned long states = cdev->max_state + 1;
 	int var;
 
+	lockdep_assert_held(&cdev->lock);
+
 	var = sizeof(*stats);
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
@@ -855,6 +903,8 @@ out:
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
+	lockdep_assert_held(&cdev->lock);
+
 	kfree(cdev->stats);
 	cdev->stats = NULL;
 }
@@ -879,6 +929,12 @@ void thermal_cooling_device_destroy_sysf
 	cooling_device_stats_destroy(cdev);
 }
 
+void thermal_cooling_device_stats_reinit(struct thermal_cooling_device *cdev)
+{
+	cooling_device_stats_destroy(cdev);
+	cooling_device_stats_setup(cdev);
+}
+
 /* these helper will be used only at the time of bindig */
 ssize_t
 trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -127,6 +127,7 @@ int thermal_zone_create_device_groups(st
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
 void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
+void thermal_cooling_device_stats_reinit(struct thermal_cooling_device *cdev);
 /* used only at binding time */
 ssize_t trip_point_show(struct device *, struct device_attribute *, char *);
 ssize_t weight_show(struct device *, struct device_attribute *, char *);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -388,6 +388,7 @@ devm_thermal_of_cooling_device_register(
 				struct device_node *np,
 				char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops);
+void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);



