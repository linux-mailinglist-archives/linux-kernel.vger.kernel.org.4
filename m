Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407D76643B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbjAJOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjAJOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:53:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00BBBA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:53:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78D84B816C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA872C433EF;
        Tue, 10 Jan 2023 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673362396;
        bh=kEf4K77L/9+aidCY2Zndyt40Xxpu4WmToJYZaRqPqdc=;
        h=From:To:Cc:Subject:Date:From;
        b=JRyFPr2fRMlcI61vHOzV3H2SQJ3mG0z2sGWxbMarpMfWn1wZvKmkE8YmnHjpZd6kl
         6tUxbgcXzkKe8Wm5B4tDFo+1DQRtZ/hXLnNTyZGX8SP6mn4/+0cH/OXrX9PO5Buo+P
         8T3MXrS1X87Z+2hTKdZYeCFpo2fzXyqFaY+/M65w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/2] driver core: bus.h: document bus notifiers better
Date:   Tue, 10 Jan 2023 15:53:02 +0100
Message-Id: <20230110145303.2087563-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3257; i=gregkh@linuxfoundation.org; h=from:subject; bh=kEf4K77L/9+aidCY2Zndyt40Xxpu4WmToJYZaRqPqdc=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7q0+b5CT/zzcvvcw5+3lY9mKZCWsTFwdxP7J5t2m9yLnI 2QaWHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARlZcM84xXWx2Zv+Cfpt71eY5d8c mh8jYTPzPMd3VxvLzoecaEvTM3rVhhLvtwkmCQFgA=
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

The bus notifier values are not documented all that well, so clean this
up and make a real enumerated type for them and document them much
better.  Also change the values from being in hex to just decimal as it
didn't make any sense to have them in hex.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: move the values to decimal from hex as pointed out by Rafael.

 include/linux/device/bus.h | 43 +++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index d529f644e92b..fbec1c7c34c0 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -257,21 +257,36 @@ extern int bus_register_notifier(struct bus_type *bus,
 extern int bus_unregister_notifier(struct bus_type *bus,
 				   struct notifier_block *nb);
 
-/* All 4 notifers below get called with the target struct device *
- * as an argument. Note that those functions are likely to be called
- * with the device lock held in the core, so be careful.
+/**
+ * enum bus_notifier_event: Bus Notifier events that have happened
+ *
+ * These are the value passed to a bus notifier when a specific event happens.
+ *
+ * Note that bus notifiers are likely to be called with the device lock already
+ * held by the driver core, so be careful in any notifier callback as to what
+ * you do with the device structure.
+ *
+ * All bus notifiers are called with the target struct device * as an argument.
+ *
+ * BUS_NOTIFY_ADD_DEVICE: device is added to this bus
+ * BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
+ * BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
+ * BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
+ * BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
+ * BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
+ * BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
+ * BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
  */
-#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
-#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device to be removed */
-#define BUS_NOTIFY_REMOVED_DEVICE	0x00000003 /* device removed */
-#define BUS_NOTIFY_BIND_DRIVER		0x00000004 /* driver about to be
-						      bound */
-#define BUS_NOTIFY_BOUND_DRIVER		0x00000005 /* driver bound to device */
-#define BUS_NOTIFY_UNBIND_DRIVER	0x00000006 /* driver about to be
-						      unbound */
-#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
-						      from the device */
-#define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
+enum bus_notifier_event {
+	BUS_NOTIFY_ADD_DEVICE =		1,
+	BUS_NOTIFY_DEL_DEVICE =		2,
+	BUS_NOTIFY_REMOVED_DEVICE =	3,
+	BUS_NOTIFY_BIND_DRIVER =	4,
+	BUS_NOTIFY_BOUND_DRIVER =	5,
+	BUS_NOTIFY_UNBIND_DRIVER =	6,
+	BUS_NOTIFY_UNBOUND_DRIVER =	7,
+	BUS_NOTIFY_DRIVER_NOT_BOUND =	8,
+};
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
 
-- 
2.39.0

