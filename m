Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3113B6A16E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBXHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXHFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:05:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC361EF9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:05:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a545bfbaso192210277b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=boN8GR+RC2zBXUFGY3OBay8cFyH3d1pnu8yUsPsz3UU=;
        b=Lzu4FZ/2+IAFgD3r2mu4VrNMIWJ/M20IXsMptzTfTL3RQ96fOc8JTZ+X85JOAGW29g
         tFTdVZ9mBY3fqh9dvEkz4O8NzcBgunII/lKVEwJnKemFPnQ6oQ1vI00WhLPJcgpMTe1G
         ILyuFtghlKUwXabXKfzhkcp2SJJzrPRvCV+O7kG0F4ljk8G23ocKoxDM6UWQfffNNbR0
         lFLzIR4dL523V7FHew/eTBbEonBLNHfktmidC8grkjjusUUWnoMSL0OJ9qIlgx/jcb/H
         OBwaMfhiYLb+OWlXZYJoCYxNPOvoTH1zDxjmGd1D9GyY6t6Rw9V2eR8XfyPSF53MpUWb
         rLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boN8GR+RC2zBXUFGY3OBay8cFyH3d1pnu8yUsPsz3UU=;
        b=hUy69hKiOFd/m5TLGFwYEeG4Gs4uZBdSmyz2EyS0mC+JBu6Q44h0yvpYVt2YGKYn+2
         eIrn3RMPVqr1CtHbIPHY9fj05j0EfPG7p2H5LIUQ80PZ7PjOvWh+LmmcNoZE8UCuxyjL
         dlCrl0jGVCdNr4QDD4+D7OmWd454mRTT6nt6jjQ/egXNgvP9bbZOvaMTHYrhCYNyMbN/
         N+gngHJaTERVp9M6edGfQ79MQIGLKK4nUp6PvnsaTABKxcVnp5AtjVb0WygMM5dlPjrX
         Cb+7AxjykcmlaPuXFG2cgjwa+gWHTeJzwIbHWckcHUDVOQyPHpmY6ja+hwkDdwqBw3LL
         DFpg==
X-Gm-Message-State: AO0yUKXsbCTtBksJ1HKdAWcbd6ovjGGEXA1+PUvho8lisVxUX4YaXr6W
        vb+LY0N4JVxM6qTbxVobDG0RXiFKYIQTxWI=
X-Google-Smtp-Source: AK7set+BFvw5AwfqVRQ9cgZZnPmX0Eeckvjo9wYvrimg+TyWEhj7vRVu5PuhKnh+Iiy+/m2WRi2HHd/VpXS6pkU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8a2e:9303:e359:c4d6])
 (user=saravanak job=sendgmr) by 2002:a81:a784:0:b0:52e:ce9e:f0a4 with SMTP id
 e126-20020a81a784000000b0052ece9ef0a4mr4054788ywh.1.1677222315686; Thu, 23
 Feb 2023 23:05:15 -0800 (PST)
Date:   Thu, 23 Feb 2023 23:05:04 -0800
In-Reply-To: <20230224070506.4157738-1-saravanak@google.com>
Message-Id: <20230224070506.4157738-3-saravanak@google.com>
Mime-Version: 1.0
References: <20230224070506.4157738-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 2/2] driver core: Make state_synced device attribute writeable
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

If the file is written to and sync_state() hasn't been called for the
device yet, then call sync_state() for the device independent of the
state of its consumers.

This is useful for supplier devices that have one or more consumers that
don't have a driver but the consumers are in a state that don't use the
resources supplied by the supplier device.

This gives finer grained control than using the
fw_devlink.sync_state=timeout kernel commandline parameter.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../ABI/testing/sysfs-devices-state_synced     |  5 +++++
 drivers/base/base.h                            |  8 ++++++++
 drivers/base/core.c                            |  5 +----
 drivers/base/dd.c                              | 18 +++++++++++++++++-
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Documentation/ABI/testing/sysfs-devices-state_synced
index 0c922d7d02fc..cc4090c9df75 100644
--- a/Documentation/ABI/testing/sysfs-devices-state_synced
+++ b/Documentation/ABI/testing/sysfs-devices-state_synced
@@ -21,4 +21,9 @@ Description:
 		at the time the kernel starts are not affected or limited in
 		any way by sync_state() callbacks.
 
+		Writing anything to this file will force a call to the device's
+		sync_state() function if it hasn't been called already. The
+		sync_state() call happens is independent of the state of the
+		consumer devices.
+
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 6fcd71803d35..b055eba1ec30 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -164,6 +164,14 @@ static inline int driver_match_device(struct device_driver *drv,
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 
+static inline void dev_sync_state(struct device *dev)
+{
+	if (dev->bus->sync_state)
+		dev->bus->sync_state(dev);
+	else if (dev->driver && dev->driver->sync_state)
+		dev->driver->sync_state(dev);
+}
+
 extern int driver_add_groups(struct device_driver *drv,
 			     const struct attribute_group **groups);
 extern void driver_remove_groups(struct device_driver *drv,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 929ec218f180..60bb3551977b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1215,10 +1215,7 @@ static void device_links_flush_sync_list(struct list_head *list,
 		if (dev != dont_lock_dev)
 			device_lock(dev);
 
-		if (dev->bus->sync_state)
-			dev->bus->sync_state(dev);
-		else if (dev->driver && dev->driver->sync_state)
-			dev->driver->sync_state(dev);
+		dev_sync_state(dev);
 
 		if (dev != dont_lock_dev)
 			device_unlock(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 84f07e0050dd..17b51573f794 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -510,6 +510,22 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
 static atomic_t probe_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
+static ssize_t state_synced_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	device_lock(dev);
+	if (!dev->state_synced) {
+		dev->state_synced = true;
+		dev_sync_state(dev);
+	} else {
+		count = -EINVAL;
+	}
+	device_unlock(dev);
+
+	return count;
+}
+
 static ssize_t state_synced_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -521,7 +537,7 @@ static ssize_t state_synced_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", val);
 }
-static DEVICE_ATTR_RO(state_synced);
+static DEVICE_ATTR_RW(state_synced);
 
 static void device_unbind_cleanup(struct device *dev)
 {
-- 
2.39.2.637.g21b0678d19-goog

