Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7706C6CD1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC2GBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjC2GBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B07D35A6;
        Tue, 28 Mar 2023 23:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC4A61A82;
        Wed, 29 Mar 2023 06:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16E3C433D2;
        Wed, 29 Mar 2023 06:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680069696;
        bh=e/e6NgdEZBs2gg1Cm6BMOjLHkLUW706EtV0baW7i3Cs=;
        h=From:To:Cc:Subject:Date:From;
        b=xAQ1QLtHNl3VGdQI8eo0aMCA+N1c6Jp6cmHVTqfAsqGxOZbUtpAX4EmAAL7AYc8mI
         o1CQIAb94vbIFPP9ar0cHjEnGGM65toxXnzGeVFxRtzy7MlggMZUyksM+WbxXeebLd
         tA6noEMjfiC04wvtznOvNb5AveWkY+ZsWE/zJyV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: pvrusb2: clean up unneeded complexity in pvrusb2 class logic
Date:   Wed, 29 Mar 2023 08:01:32 +0200
Message-Id: <20230329060132.2688621-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7499; i=gregkh@linuxfoundation.org; h=from:subject; bh=e/e6NgdEZBs2gg1Cm6BMOjLHkLUW706EtV0baW7i3Cs=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnKV2x2+TROuyKQ+aZlrayIcPPcJW170uPmq4j8vFTV7 nFahzG6I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbSbMKwYHNn4bJPcWtPLNhy 8v9kTvdFPPk22QzzC6cYsyWz/1N/YBZrKumXvC48Q+IeAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pvrusb2 driver struct class logic was dynamically creating a class
that should have just been static as it did not do anything special and
was only a wrapper around a stock "struct class" implementation.  Clean
this all up by making a static struct class and modifying the code to
correctly reference it.

By doing so, lots of unneeded lines of code were removed, and #ifdef
logic was cleaned up so that the .c files are not cluttered up with
extra complexity following the proper kernel coding style.

Cc: Mike Isely <isely@pobox.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note: I would like to take this through the driver-core tree as I have
later struct class cleanups that depend on this change being made to the
tree if that's ok with the maintainer of this file.

 drivers/media/usb/pvrusb2/pvrusb2-main.c  | 18 ++-----
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c | 59 +++++++----------------
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.h | 16 +++---
 3 files changed, 29 insertions(+), 64 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-main.c b/drivers/media/usb/pvrusb2/pvrusb2-main.c
index ce4d566e4e5a..721dafd2c14b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-main.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-main.c
@@ -16,9 +16,7 @@
 #include "pvrusb2-context.h"
 #include "pvrusb2-debug.h"
 #include "pvrusb2-v4l2.h"
-#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
 #include "pvrusb2-sysfs.h"
-#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
 
 #define DRIVER_AUTHOR "Mike Isely <isely@pobox.com>"
 #define DRIVER_DESC "Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner"
@@ -36,10 +34,6 @@ int pvrusb2_debug = DEFAULT_DEBUG_MASK;
 module_param_named(debug,pvrusb2_debug,int,S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(debug, "Debug trace mask");
 
-#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
-static struct pvr2_sysfs_class *class_ptr = NULL;
-#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
-
 static void pvr_setup_attach(struct pvr2_context *pvr)
 {
 	/* Create association with v4l layer */
@@ -48,9 +42,7 @@ static void pvr_setup_attach(struct pvr2_context *pvr)
 	/* Create association with dvb layer */
 	pvr2_dvb_create(pvr);
 #endif
-#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
-	pvr2_sysfs_create(pvr,class_ptr);
-#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
+	pvr2_sysfs_create(pvr);
 }
 
 static int pvr_probe(struct usb_interface *intf,
@@ -115,9 +107,7 @@ static int __init pvr_init(void)
 		return ret;
 	}
 
-#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
-	class_ptr = pvr2_sysfs_class_create();
-#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
+	pvr2_sysfs_class_create();
 
 	ret = usb_register(&pvr_driver);
 
@@ -141,9 +131,7 @@ static void __exit pvr_exit(void)
 
 	pvr2_context_global_done();
 
-#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
-	pvr2_sysfs_class_destroy(class_ptr);
-#endif /* CONFIG_VIDEO_PVRUSB2_SYSFS */
+	pvr2_sysfs_class_destroy();
 
 	pvr2_trace(PVR2_TRACE_INIT,"pvr_exit complete");
 }
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
index 3e42e209be37..a8c0b513e58e 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
@@ -66,10 +66,6 @@ struct pvr2_sysfs_ctl_item {
 	char name[80];
 };
 
-struct pvr2_sysfs_class {
-	struct class class;
-};
-
 static ssize_t show_name(struct device *class_dev,
 			 struct device_attribute *attr,
 			 char *buf)
@@ -487,15 +483,6 @@ static void pvr2_sysfs_tear_down_controls(struct pvr2_sysfs *sfp)
 }
 
 
-static void pvr2_sysfs_class_release(struct class *class)
-{
-	struct pvr2_sysfs_class *clp;
-	clp = container_of(class,struct pvr2_sysfs_class,class);
-	pvr2_sysfs_trace("Destroying pvr2_sysfs_class id=%p",clp);
-	kfree(clp);
-}
-
-
 static void pvr2_sysfs_release(struct device *class_dev)
 {
 	pvr2_sysfs_trace("Releasing class_dev id=%p",class_dev);
@@ -503,6 +490,12 @@ static void pvr2_sysfs_release(struct device *class_dev)
 }
 
 
+static struct class pvr2_class = {
+	.name		= "pvrusb2",
+	.dev_release	= pvr2_sysfs_release,
+};
+
+
 static void class_dev_destroy(struct pvr2_sysfs *sfp)
 {
 	struct device *dev;
@@ -614,8 +607,7 @@ static ssize_t unit_number_show(struct device *class_dev,
 }
 
 
-static void class_dev_create(struct pvr2_sysfs *sfp,
-			     struct pvr2_sysfs_class *class_ptr)
+static void class_dev_create(struct pvr2_sysfs *sfp)
 {
 	struct usb_device *usb_dev;
 	struct device *class_dev;
@@ -628,7 +620,7 @@ static void class_dev_create(struct pvr2_sysfs *sfp,
 
 	pvr2_sysfs_trace("Creating class_dev id=%p",class_dev);
 
-	class_dev->class = &class_ptr->class;
+	class_dev->class = &pvr2_class;
 
 	dev_set_name(class_dev, "%s",
 		     pvr2_hdw_get_device_identifier(sfp->channel.hdw));
@@ -753,47 +745,30 @@ static void pvr2_sysfs_internal_check(struct pvr2_channel *chp)
 }
 
 
-struct pvr2_sysfs *pvr2_sysfs_create(struct pvr2_context *mp,
-				     struct pvr2_sysfs_class *class_ptr)
+void pvr2_sysfs_create(struct pvr2_context *mp)
 {
 	struct pvr2_sysfs *sfp;
 	sfp = kzalloc(sizeof(*sfp),GFP_KERNEL);
-	if (!sfp) return sfp;
+	if (!sfp)
+		return;
 	pvr2_trace(PVR2_TRACE_STRUCT,"Creating pvr2_sysfs id=%p",sfp);
 	pvr2_channel_init(&sfp->channel,mp);
 	sfp->channel.check_func = pvr2_sysfs_internal_check;
 
-	class_dev_create(sfp,class_ptr);
-	return sfp;
+	class_dev_create(sfp);
 }
 
 
-
-struct pvr2_sysfs_class *pvr2_sysfs_class_create(void)
+void pvr2_sysfs_class_create(void)
 {
-	struct pvr2_sysfs_class *clp;
-	clp = kzalloc(sizeof(*clp),GFP_KERNEL);
-	if (!clp) return clp;
-	pvr2_sysfs_trace("Creating and registering pvr2_sysfs_class id=%p",
-			 clp);
-	clp->class.name = "pvrusb2";
-	clp->class.class_release = pvr2_sysfs_class_release;
-	clp->class.dev_release = pvr2_sysfs_release;
-	if (class_register(&clp->class)) {
-		pvr2_sysfs_trace(
-			"Registration failed for pvr2_sysfs_class id=%p",clp);
-		kfree(clp);
-		clp = NULL;
-	}
-	return clp;
+	if (class_register(&pvr2_class))
+		pvr2_sysfs_trace("Registration failed for pvr2_sysfs_class");
 }
 
 
-void pvr2_sysfs_class_destroy(struct pvr2_sysfs_class *clp)
+void pvr2_sysfs_class_destroy(void)
 {
-	pvr2_sysfs_trace("Unregistering pvr2_sysfs_class id=%p", clp);
-	if (clp)
-		class_unregister(&clp->class);
+	class_unregister(&pvr2_class);
 }
 
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h
index ac580ff39b5f..375a5372e95c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h
+++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.h
@@ -10,13 +10,15 @@
 #include <linux/sysfs.h>
 #include "pvrusb2-context.h"
 
-struct pvr2_sysfs;
-struct pvr2_sysfs_class;
+#ifdef CONFIG_VIDEO_PVRUSB2_SYSFS
+void pvr2_sysfs_class_create(void);
+void pvr2_sysfs_class_destroy(void);
+void pvr2_sysfs_create(struct pvr2_context *mp);
+#else
+static inline void pvr2_sysfs_class_create(void) { }
+static inline void pvr2_sysfs_class_destroy(void) { }
+static inline void pvr2_sysfs_create(struct pvr2_context *mp) { }
+#endif
 
-struct pvr2_sysfs_class *pvr2_sysfs_class_create(void);
-void pvr2_sysfs_class_destroy(struct pvr2_sysfs_class *);
-
-struct pvr2_sysfs *pvr2_sysfs_create(struct pvr2_context *,
-				     struct pvr2_sysfs_class *);
 
 #endif /* __PVRUSB2_SYSFS_H */
-- 
2.40.0

