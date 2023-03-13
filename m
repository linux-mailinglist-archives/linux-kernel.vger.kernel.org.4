Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8856B80C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjCMSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCMSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F20856A5;
        Mon, 13 Mar 2023 11:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7115E61481;
        Mon, 13 Mar 2023 18:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835B4C433D2;
        Mon, 13 Mar 2023 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732235;
        bh=jbSk29LRT47p9ipZ5FjfZEDf0clY16OD8paogIGp0U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvbKwuPvAphpBvTFrJRHcAYcuVbgey6nHCGTDYa84OqaX7Ar+MbX7RcZMcXmkavWW
         u8uKWKqKN7Eb1xruK6sCAbIa8Up3O7z4a4v+i/Z0s6u82Ym+G5jRx3Z+HWw93ZLZWm
         K5yU2yo5d2pfLqFJL78t5g0yQJ4V4oH9qfqX7pTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: [PATCH 36/36] USB: mark all struct bus_type as const
Date:   Mon, 13 Mar 2023 19:29:18 +0100
Message-Id: <20230313182918.1312597-36-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4943; i=gregkh@linuxfoundation.org; h=from:subject; bh=jbSk29LRT47p9ipZ5FjfZEDf0clY16OD8paogIGp0U0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82bXf337cOuFPbenUyOu8VzZN8jjq9/7D3CkchwI4R dg0j3992xHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATia9hmKfkED3xyrsX215d /Gfo5VIxYelVQW2GBRvKsmVqCjsC21vFMrw+ZqTIugqfAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core can properly handle constant struct bus_type,
move all of the USB subsystem struct bus_type structures as const,
placing them into read-only memory which can not be modified at runtime.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/ulpi.c     | 2 +-
 drivers/usb/core/driver.c     | 2 +-
 drivers/usb/core/usb.h        | 2 +-
 drivers/usb/gadget/udc/core.c | 4 ++--
 drivers/usb/serial/bus.c      | 2 +-
 drivers/usb/typec/bus.c       | 2 +-
 drivers/usb/typec/bus.h       | 2 +-
 include/linux/usb/serial.h    | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index a98b2108376a..8305a5dfb910 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -90,7 +90,7 @@ static void ulpi_remove(struct device *dev)
 		drv->remove(to_ulpi_dev(dev));
 }
 
-static struct bus_type ulpi_bus = {
+static const struct bus_type ulpi_bus = {
 	.name = "ulpi",
 	.match = ulpi_match,
 	.uevent = ulpi_uevent,
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index a0e076c6f3a4..f58a0299fb3b 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -2025,7 +2025,7 @@ int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
 
 #endif /* CONFIG_PM */
 
-struct bus_type usb_bus_type = {
+const struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 0eac7d4285d1..cd434af259c3 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -140,7 +140,7 @@ static inline int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
 
 #endif
 
-extern struct bus_type usb_bus_type;
+extern const struct bus_type usb_bus_type;
 extern struct mutex usb_port_peer_mutex;
 extern struct device_type usb_device_type;
 extern struct device_type usb_if_device_type;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629a8774..61a9c231deb9 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -26,7 +26,7 @@
 
 static DEFINE_IDA(gadget_id_numbers);
 
-static struct bus_type gadget_bus_type;
+static const struct bus_type gadget_bus_type;
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -1747,7 +1747,7 @@ static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-static struct bus_type gadget_bus_type = {
+static const struct bus_type gadget_bus_type = {
 	.name = "gadget",
 	.probe = gadget_bind_driver,
 	.remove = gadget_unbind_driver,
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e38142acd38..3eb8dc3a1a8f 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -144,7 +144,7 @@ static void free_dynids(struct usb_serial_driver *drv)
 	spin_unlock(&drv->dynids.lock);
 }
 
-struct bus_type usb_serial_bus_type = {
+const struct bus_type usb_serial_bus_type = {
 	.name =		"usb-serial",
 	.match =	usb_serial_device_match,
 	.probe =	usb_serial_device_probe,
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 098f0efaa58d..fe5b9a2e61f5 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -431,7 +431,7 @@ static void typec_remove(struct device *dev)
 	adev->ops = NULL;
 }
 
-struct bus_type typec_bus = {
+const struct bus_type typec_bus = {
 	.name = "typec",
 	.dev_groups = typec_groups,
 	.match = typec_match,
diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
index c89168857417..643b8c81786d 100644
--- a/drivers/usb/typec/bus.h
+++ b/drivers/usb/typec/bus.h
@@ -28,7 +28,7 @@ struct altmode {
 
 #define to_altmode(d) container_of(d, struct altmode, adev)
 
-extern struct bus_type typec_bus;
+extern const struct bus_type typec_bus;
 extern const struct device_type typec_altmode_dev_type;
 
 #define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index f7bfedb740f5..7eeb5f9c4f0d 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -378,7 +378,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
 int usb_serial_bus_register(struct usb_serial_driver *device);
 void usb_serial_bus_deregister(struct usb_serial_driver *device);
 
-extern struct bus_type usb_serial_bus_type;
+extern const struct bus_type usb_serial_bus_type;
 extern struct tty_driver *usb_serial_tty_driver;
 
 static inline void usb_serial_debug_data(struct device *dev,
-- 
2.39.2

