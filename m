Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4279A69B8BF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBRIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBRIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:33:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683C3B672
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:32:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536629fa4ceso25129197b3.16
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp1QbPjY6w8y+NO/uU7s1tByY9HWUIkH8CY141/p1Bw=;
        b=rTZzHduXbHELGzBYp2cxb7eG1N/9akFJXJjXnGRACIXOuguCjzoX9z0hXDTI96wh+I
         JFzx+h++S/vEheLmbd9a1WHdaawwRSNzK+p8nZuK/E+A4VPcqspje6CYkI5ORiQVpKxK
         vWV8ljEeB6aJJbQNEDj+6l/ynEqsPtLZ4YZVQeaRaHkj+coBPO2V+Djgh47VH19ztR2L
         i/X4AcxYu2IzRmbvQUdTZMtfL4UyfS20FXeH2K0j7ji524mBNUnu8sEXBN1jo2n1Nkdl
         qtfNPJiBJP0hgXaF/LvbUraJFt0Il/nttBByjo3HROfGG+/UvQk9pvBgXPqZ6gMHrgYb
         G7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp1QbPjY6w8y+NO/uU7s1tByY9HWUIkH8CY141/p1Bw=;
        b=YpgDyftNL7DROQzNy6icd/pXWjgAXusJBUeboZvmbU7UgxrRGsXfaUkBs7BIXhtv/y
         9BxyJJdOAroUaEpnsdFGecY3+hIiumr5Agd/FfXDqASPet8Tg1tx0dleFx3+Vtj2l1tQ
         dKU7moKZY8gp8QdJJjck7nm+kJ05ptoUCHWqIae4IaQCbtaXDVSJ0djw2jSBaeqPtMxr
         T406V9v4RUEeRHbcAmHso8iwSn2KZPubv0kvRNRBCb0bfmLzfeEKkyUX0WgyheM9cdIB
         LYtOci0zlwwz2NZuMj8euZpKiTibJ9/o4oHRyIBXyTrxvUg21o1hpJZgOX/a3ArAbT4A
         gvOQ==
X-Gm-Message-State: AO0yUKVDtF5sdG4CSzzu9j/02HxRrl/5wptgEAOJonxIVu7ttV8hWpM+
        oPfktRdP6Mgt0t4LhED5+1OIiXAjwxGykiE=
X-Google-Smtp-Source: AK7set8RfNZQIJa7rBKYqnPS1tC4ip0mPfPQINLGkRurPv1uWqBScGpYrPt9r4A/IMbwUqlqMTH/2YJbs7qhaec=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:382:7632:f7fc:4737])
 (user=saravanak job=sendgmr) by 2002:a5b:ec1:0:b0:905:372:12ad with SMTP id
 a1-20020a5b0ec1000000b00905037212admr1825699ybs.539.1676709179075; Sat, 18
 Feb 2023 00:32:59 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:32:48 -0800
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
Message-Id: <20230218083252.2044423-2-saravanak@google.com>
Mime-Version: 1.0
References: <20230218083252.2044423-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [RFC v1 1/4] regulator: core: Add regulator devices to bus instead of class
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator devices to a bus instead of a class. This allows us to
probe these devices in later patches.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c         | 45 ++++++++++++++++----------------
 drivers/regulator/internal.h     |  2 +-
 drivers/regulator/of_regulator.c |  2 +-
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ae69e493913d..1a212edcf216 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1918,7 +1918,7 @@ static struct regulator_dev *regulator_lookup_by_name(const char *name)
 {
 	struct device *dev;
 
-	dev = class_find_device(&regulator_class, NULL, name, regulator_match);
+	dev = bus_find_device(&regulator_bus, NULL, name, regulator_match);
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }
@@ -5539,7 +5539,7 @@ regulator_register(struct device *dev,
 		rdev->supply_name = regulator_desc->supply_name;
 
 	/* register with sysfs */
-	rdev->dev.class = &regulator_class;
+	rdev->dev.bus = &regulator_bus;
 	rdev->dev.parent = config->dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
 		    (unsigned long) atomic_inc_return(&regulator_no));
@@ -5644,8 +5644,8 @@ regulator_register(struct device *dev,
 	mutex_unlock(&regulator_list_mutex);
 
 	/* try to resolve regulators supply since a new one was registered */
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_register_resolve_supply);
+	bus_for_each_dev(&regulator_bus, NULL, NULL,
+			 regulator_register_resolve_supply);
 	kfree(config);
 	return rdev;
 
@@ -5772,14 +5772,15 @@ static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
 };
 #endif
 
-struct class regulator_class = {
+struct bus_type regulator_bus = {
 	.name = "regulator",
-	.dev_release = regulator_dev_release,
+	.remove = regulator_dev_release,
 	.dev_groups = regulator_dev_groups,
 #ifdef CONFIG_PM
 	.pm = &regulator_pm_ops,
 #endif
 };
+
 /**
  * regulator_has_full_constraints - the system has fully specified constraints
  *
@@ -5939,7 +5940,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	seq_puts(s, "\n");
 
 	list_for_each_entry(consumer, &rdev->consumer_list, list) {
-		if (consumer->dev && consumer->dev->class == &regulator_class)
+		if (consumer->dev && consumer->dev->bus == &regulator_bus)
 			continue;
 
 		seq_printf(s, "%*s%-*s ",
@@ -5969,8 +5970,8 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	summary_data.level = level;
 	summary_data.parent = rdev;
 
-	class_for_each_device(&regulator_class, NULL, &summary_data,
-			      regulator_summary_show_children);
+	bus_for_each_dev(&regulator_bus, NULL, &summary_data,
+			 regulator_summary_show_children);
 }
 
 struct summary_lock_data {
@@ -6025,11 +6026,11 @@ static int regulator_summary_lock_all(struct ww_acquire_ctx *ww_ctx,
 	lock_data.new_contended_rdev = new_contended_rdev;
 	lock_data.old_contended_rdev = old_contended_rdev;
 
-	ret = class_for_each_device(&regulator_class, NULL, &lock_data,
-				    regulator_summary_lock_one);
+	ret = bus_for_each_dev(&regulator_bus, NULL, &lock_data,
+			       regulator_summary_lock_one);
 	if (ret)
-		class_for_each_device(&regulator_class, NULL, &lock_data,
-				      regulator_summary_unlock_one);
+		bus_for_each_dev(&regulator_bus, NULL, &lock_data,
+				 regulator_summary_unlock_one);
 
 	return ret;
 }
@@ -6065,8 +6066,8 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 
 static void regulator_summary_unlock(struct ww_acquire_ctx *ww_ctx)
 {
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_summary_unlock_one);
+	bus_for_each_dev(&regulator_bus, NULL, NULL,
+			 regulator_summary_unlock_one);
 	ww_acquire_fini(ww_ctx);
 
 	mutex_unlock(&regulator_list_mutex);
@@ -6092,8 +6093,8 @@ static int regulator_summary_show(struct seq_file *s, void *data)
 
 	regulator_summary_lock(&ww_ctx);
 
-	class_for_each_device(&regulator_class, NULL, s,
-			      regulator_summary_show_roots);
+	bus_for_each_dev(&regulator_bus, NULL, s,
+			 regulator_summary_show_roots);
 
 	regulator_summary_unlock(&ww_ctx);
 
@@ -6106,7 +6107,7 @@ static int __init regulator_init(void)
 {
 	int ret;
 
-	ret = class_register(&regulator_class);
+	ret = bus_register(&regulator_bus);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (!debugfs_root)
@@ -6182,16 +6183,16 @@ static void regulator_init_complete_work_function(struct work_struct *work)
 	 * bound yet. So attempt to resolve the input supplies for
 	 * pending regulators before trying to disable unused ones.
 	 */
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_register_resolve_supply);
+	bus_for_each_dev(&regulator_bus, NULL, NULL,
+			 regulator_register_resolve_supply);
 
 	/* If we have a full configuration then disable any regulators
 	 * we have permission to change the status for and which are
 	 * not in use or always_on.  This is effectively the default
 	 * for DT and ACPI as they have full constraints.
 	 */
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_late_cleanup);
+	bus_for_each_dev(&regulator_bus, NULL, NULL,
+			 regulator_late_cleanup);
 }
 
 static DECLARE_DELAYED_WORK(regulator_init_complete_work,
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index fb4433068d29..6e489b3cffad 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -58,7 +58,7 @@ struct regulator {
 	struct dentry *debugfs;
 };
 
-extern struct class regulator_class;
+extern struct bus_type regulator_bus;
 
 static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 {
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 1b65e5e4e40f..f0590e68f31d 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -545,7 +545,7 @@ struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&regulator_class, np);
+	dev = bus_find_device_by_of_node(&regulator_bus, np);
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }
-- 
2.39.2.637.g21b0678d19-goog

