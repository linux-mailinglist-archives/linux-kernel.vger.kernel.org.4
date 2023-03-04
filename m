Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D66AA6B1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCDAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCDAyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:54:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6514229
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:54:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso3984217ybu.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677891241;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3KLIsJ5XjymrzajSG4hOMtFPW7EJIs/FRVq4ltjBx8=;
        b=CpDQBu2btyd5ZDMEYcKgfV0+dPoG2/Nl882vCUbq5opZ/DyGFyvg6w53zwTIq/ArWg
         OWPfAo61xb4ZGc5534GNyz3TxcZLmENypsmBZ5iRpB9IbgieEjSfO1UFpLVtJnuzsLZf
         1G6a+WarDzhoArZtDsEccWBSglPCialIYSXCqzIBRdv12TeoRg/KLpEY0zoK3sdRXLA8
         LwpSAfsTL8233bExDD/FJMl4X2IQyous1IRIeXWOsXg4axysyk5ZYa7kwbI6uSu2P/7T
         dGm07CjSTWYppFAC7lUzwli9C5OCGf2oYksMjFTkNMBZA1hP/15aOGy+qLDDJU4pIX2X
         1IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677891241;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3KLIsJ5XjymrzajSG4hOMtFPW7EJIs/FRVq4ltjBx8=;
        b=hL77upGx7RcgUS4bzUxpsHKJ5PDvzfUDuSCU2ADpec8+II5wBv4Mx3M3tDakHiwAhe
         F53c5UAxRsbGGGfiWhdsVB+DYCrhm/8rfllAZh22r5kKs6WW3fIwxkuTQutKe2pZpqK3
         mcCTiqmCZ8z6/RNy8ai3i+4rTeXsrhCED7jkZeOEiGq3symYfC3sMKJwwqTUxoWh65Rb
         dtttLw1vTFLtWCZfjaKHYHc/cR+GjN+afJ/EW0JY/FM4jqdLLvXA4s7dptOpW2Jq8dkx
         rtUnevpLZvYmIINxS9i9u7B0SKGi1kyS51h3zdGR9z4Zetd7hBIWehGBarkQoYm1VQK6
         mMzg==
X-Gm-Message-State: AO0yUKVHaByA5OhB5mpQ1HI8nB1pBbQWvyxPu2L5ht6MJKCM6/abkwfH
        xTs9eoZdcGV/x2n5nQxtIj3hhzXj0QDfRWU=
X-Google-Smtp-Source: AK7set8JH8cdKAM17rBxAnupjfmwqJ9lReTOeCfpxlJKqWEhmnxN9rkv4CScgvpFqicBtVyDeo0xYffqUKOwhxI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ef0c:d8be:ebb3:b639])
 (user=saravanak job=sendgmr) by 2002:a81:c254:0:b0:52e:e6ed:3089 with SMTP id
 t20-20020a81c254000000b0052ee6ed3089mr1ywg.521.1677891240787; Fri, 03 Mar
 2023 16:54:00 -0800 (PST)
Date:   Fri,  3 Mar 2023 16:53:53 -0800
In-Reply-To: <20230304005355.746421-1-saravanak@google.com>
Message-Id: <20230304005355.746421-2-saravanak@google.com>
Mime-Version: 1.0
References: <20230304005355.746421-1-saravanak@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 1/2] driver core: Add fw_devlink.sync_state command line param
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

When all devices that could probe have finished probing (based on
deferred_probe_timeout configuration or late_initcall() when
!CONFIG_MODULES), this parameter controls what to do with devices that
haven't yet received their sync_state() calls.

fw_devlink.sync_state=strict is the default and the driver core will
continue waiting on all consumers of a device to probe successfully
before sync_state() is called for the device. This is the default
behavior since calling sync_state() on a device when all its consumers
haven't probed could make some systems unusable/unstable. When this
option is selected, we also print the list of devices that haven't had
sync_state() called on them by the time all devices the could probe have
finished probing.

fw_devlink.sync_state=timeout will cause the driver core to give up
waiting on consumers and call sync_state() on any devices that haven't
yet received their sync_state() calls. This option is provided for
systems that won't become unusable/unstable as they might be able to
save power (depends on state of hardware before kernel starts) if all
devices get their sync_state().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 +++++
 drivers/base/base.h                           |  1 +
 drivers/base/core.c                           | 58 +++++++++++++++++++
 drivers/base/dd.c                             |  6 ++
 4 files changed, 79 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..fc5dc4dc9a5c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1582,6 +1582,20 @@
 			dependencies. This only applies for fw_devlink=on|rpm.
 			Format: <bool>
 
+	fw_devlink.sync_state =
+			[KNL] When all devices that could probe have finished
+			probing, this parameter controls what to do with
+			devices that haven't yet received their sync_state()
+			calls.
+			Format: { strict | timeout }
+			strict -- Default. Continue waiting on consumers to
+				probe successfully.
+			timeout -- Give up waiting on consumers and call
+				sync_state() on any devices that haven't yet
+				received their sync_state() calls after
+				deferred_probe_timeout has expired or by
+				late_initcall() if !CONFIG_MODULES.
+
 	gamecon.map[2|3]=
 			[HW,JOY] Multisystem joystick and NES/SNES/PSX pad
 			support via parallel port (up to 5 devices per port)
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 726a12a244c0..6fcd71803d35 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -209,6 +209,7 @@ extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
 extern void fw_devlink_drivers_done(void);
+extern void fw_devlink_probing_done(void);
 
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6878dfcbf0d6..4c7e1550bb02 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1685,6 +1685,26 @@ static int __init fw_devlink_strict_setup(char *arg)
 }
 early_param("fw_devlink.strict", fw_devlink_strict_setup);
 
+#define FW_DEVLINK_SYNC_STATE_STRICT	0
+#define FW_DEVLINK_SYNC_STATE_TIMEOUT	1
+
+static int fw_devlink_sync_state;
+static int __init fw_devlink_sync_state_setup(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "strict") == 0) {
+		fw_devlink_sync_state = FW_DEVLINK_SYNC_STATE_STRICT;
+		return 0;
+	} else if (strcmp(arg, "timeout") == 0) {
+		fw_devlink_sync_state = FW_DEVLINK_SYNC_STATE_TIMEOUT;
+		return 0;
+	}
+	return -EINVAL;
+}
+early_param("fw_devlink.sync_state", fw_devlink_sync_state_setup);
+
 static inline u32 fw_devlink_get_flags(u8 fwlink_flags)
 {
 	if (fwlink_flags & FWLINK_FLAG_CYCLE)
@@ -1755,6 +1775,44 @@ void fw_devlink_drivers_done(void)
 	device_links_write_unlock();
 }
 
+static int fw_devlink_dev_sync_state(struct device *dev, void *data)
+{
+	struct device_link *link = to_devlink(dev);
+	struct device *sup = link->supplier;
+
+	if (!(link->flags & DL_FLAG_MANAGED) ||
+	    link->status == DL_STATE_ACTIVE || sup->state_synced ||
+	    !dev_has_sync_state(sup))
+		return 0;
+
+	if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
+		dev_warn(sup, "sync_state() pending due to %s\n",
+			 dev_name(link->consumer));
+		return 0;
+	}
+
+	if (!list_empty(&sup->links.defer_sync))
+		return 0;
+
+	dev_warn(sup, "Timed out. Forcing sync_state()\n");
+	sup->state_synced = true;
+	get_device(sup);
+	list_add_tail(&sup->links.defer_sync, data);
+
+	return 0;
+}
+
+void fw_devlink_probing_done(void)
+{
+	LIST_HEAD(sync_list);
+
+	device_links_write_lock();
+	class_for_each_device(&devlink_class, NULL, &sync_list,
+			      fw_devlink_dev_sync_state);
+	device_links_write_unlock();
+	device_links_flush_sync_list(&sync_list, NULL);
+}
+
 /**
  * wait_for_init_devices_probe - Try to probe any device needed for init
  *
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8def2ba08a82..84f07e0050dd 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -315,6 +315,8 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 	list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
 		dev_info(p->device, "deferred probe pending\n");
 	mutex_unlock(&deferred_probe_mutex);
+
+	fw_devlink_probing_done();
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
@@ -364,6 +366,10 @@ static int deferred_probe_initcall(void)
 		schedule_delayed_work(&deferred_probe_timeout_work,
 			driver_deferred_probe_timeout * HZ);
 	}
+
+	if (!IS_ENABLED(CONFIG_MODULES))
+		fw_devlink_probing_done();
+
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

