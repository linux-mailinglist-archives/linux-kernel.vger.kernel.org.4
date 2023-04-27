Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513756F0A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbjD0Q6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbjD0Q6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:58:48 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD4C1739
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:58:47 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64115ef7234so5016054b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682614727; x=1685206727;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Lzzj27mp2U/iXO+CebupzdoIBWSksazoxVaz64r1B0=;
        b=wPcAqL+iVul3uutVHxWzVqPpl0+umqjfEAYMMNSNOHj6zDK3uwg3gH/VRjMzWS26k9
         7xvUTh9PO2llmUmFKJ7KDU+XTrmI1gktLOw1ota2AwVxdT1NafzGAKk+k77/4kB7RsFY
         xa0dyDnvUQ+IFB00opEbYFjqx85RFrV/ROwTUvJrg/1OY2qQAbRSCbatkFbxI4MgSe/C
         SX/6F6yd5W23qDVhbQRcq81GiRgpNbQ94J6J2bC5Fy3mmf+prknc/6gsR981qmMUiiKh
         9C9ugqezyNCvOM054EJ1uxCdHG/Xrl1mDQFT5P6/1688pqy7ejFT2JxHP3siT4gZuOUG
         zzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614727; x=1685206727;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Lzzj27mp2U/iXO+CebupzdoIBWSksazoxVaz64r1B0=;
        b=NiO6T55Quqk1WtMdn3QSeYv7C4rTleBW8JVi8rchqhkV1n8KpfOPhLFqltoaqxeeCy
         h/GNX1lbekd+4R1FnZviNJcFB2tnwjLdzX1AuXtIo1XP4u7zxi0LvDG+8qjZFuu2oWKe
         uMwesa9oYxVdktOYqbsFcBTzW1leSmgD9eXs+cyxsStalHiNfig2qyUOyC/2ZEhrE4HM
         9lAVfiUrNMxpABms1iXP6HTUZn5uwncXzN8cGsAH8NwI/YSZQJ4hKJxyUQs5Zx8hk9Lj
         G8ppXw/dpjLzm7Z+5+dDWQQQMDdo+sSh2k63oUf0TUTm4Yw/+a8VjM6VkDUGWx0zXdQt
         OqEQ==
X-Gm-Message-State: AC+VfDwj4afryTOX9xdOwlioKihhOSGvo43mOnb7fhwNebJ9Kaw0cGFO
        FB8FuPWV7VIxP8ti842FyNL7knE8ah5rZw==
X-Google-Smtp-Source: ACHHUZ7aBT09JGq1ZUP+qf1beSjVT9Yn2NwVm9PfOTW0h2PofJc8UQjczDIG2kyzpYdoZPnTw412VW9RSIS1xA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90a:9aa:b0:23d:30a:692b with SMTP id
 39-20020a17090a09aa00b0023d030a692bmr710483pjo.4.1682614726906; Thu, 27 Apr
 2023 09:58:46 -0700 (PDT)
Date:   Thu, 27 Apr 2023 16:58:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427165813.2844530-1-wonchung@google.com>
Subject: [PATCH v6] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
From:   Won Chung <wonchung@google.com>
To:     wonchung@google.com, bleung@google.com, pmalani@chromium.org,
        heikki.krogerus@linux.intel.com, imre.deak@intel.com,
        gildekel@chromium.org, seanpaul@chromium.org, daniel@ffwll.ch,
        navaremanasi@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a symlink pointing to USB Type-C connector for DRM connectors
when they are created. The link will be created only if the firmware is
able to describe the connection beween the two connectors.

Currently, even if a display uses a USB Type-C port, there is no way for
the userspace to find which port is used for which display. With the
symlink, display information would be accessible from Type-C connectors
and port information would be accessible from DRM connectors.

Associating the two subsystems, userspace would have potential to expose
and utilize more complex information. ChromeOS intend to use this
information for metrics collection. For example, we want to tell which
port is deriving which displays. Also, combined with USB PD information,
we can tell whether user is charging their device through display.
Chromium patch for parsing the symlink from the kernel is at
http://crrev.com/c/4317207.

We already have a framework in typec port-mapper.c where it goes through
component devices and runs the bind functions for those with matching
_PLD (physical location of device).
https://elixir.bootlin.com/linux/v5.18.1/source/drivers/usb/typec/port-mapper.c
Since _PLD is ACPI specific field, this linking would only work on ACPI
x86 as long as _PLD field for Type-C connectors and DRM connectors are
correctly added to the firmware.

Currently, USB ports and USB4 ports are added as components to create a
symlink with Type C connector.
USB:
https://lore.kernel.org/all/20211223082349.45616-1-heikki.krogerus@linux.intel.com/
USB4:
https://lore.kernel.org/all/20220418175932.1809770-3-wonchung@google.com/
So, we follow the same pattern in this patch.

Signed-off-by: Won Chung <wonchung@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Manasi Navare <navaremanasi@chromium.org>
---
Changes from v5:
- Add more details to the error message

Changes from v4: (4 months ago)
- Update commit message with an actual use case from cros userspace
- Move component_add to before ddc check which possibly returns
- Rebased

Changes from v3:
- Append to the commit message on why this patch is needed

Changes from v2:
- Resend the patch to dri-devel list

Changes from v1:
- Fix multiple lines to single line


 drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 183130355997..bc869c6fa420 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -11,12 +11,14 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/component.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/i2c.h>
 #include <linux/kdev_t.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <drm/drm_accel.h>
@@ -96,6 +98,34 @@ static char *drm_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
 }
 
+static int typec_connector_bind(struct device *dev,
+	struct device *typec_connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj, "typec_connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj, "drm_connector");
+	if (ret)
+		sysfs_remove_link(&dev->kobj, "typec_connector");
+
+	return ret;
+}
+
+static void typec_connector_unbind(struct device *dev,
+	struct device *typec_connector, void *data)
+{
+	sysfs_remove_link(&typec_connector->kobj, "drm_connector");
+	sysfs_remove_link(&dev->kobj, "typec_connector");
+}
+
+static const struct component_ops typec_connector_ops = {
+	.bind = typec_connector_bind,
+	.unbind = typec_connector_unbind,
+};
+
 static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
 
 /**
@@ -353,9 +383,16 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 
 	connector->kdev = kdev;
 
+	if (dev_fwnode(kdev)) {
+		r = component_add(kdev, &typec_connector_ops);
+		if (r)
+			drm_err(dev, "failed to add component to create link to typec connector\n");
+	}
+
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
+
 	return 0;
 
 err_free:
@@ -371,6 +408,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
 	if (connector->ddc)
 		sysfs_remove_link(&connector->kdev->kobj, "ddc");
 
+	if (dev_fwnode(connector->kdev))
+		component_del(connector->kdev, &typec_connector_ops);
+
 	DRM_DEBUG("removing \"%s\" from sysfs\n",
 		  connector->name);
 
-- 
2.40.1.495.gc816e09b53d-goog

