Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B04731D91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFOQRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjFOQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:17:07 -0400
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 09:17:04 PDT
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB77ED
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:17:04 -0700 (PDT)
Received: from fedora.. (p5b3d25f5.dip0.t-ipconnect.de [91.61.37.245])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4A1AACECD7;
        Thu, 15 Jun 2023 18:08:10 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org
Subject: [PATCH] cachefiles: allocate static minor for /dev/cachefiles
Date:   Thu, 15 Jun 2023 18:08:06 +0200
Message-Id: <20230615160806.94000-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cachefiles misc character device uses MISC_DYNAMIC_MINOR and thus
doesn't support module auto-loading. Assign a static minor number for it
and provide appropriate module aliases for it. This is enough for kmod to
create the /dev/cachefiles device node on startup and facility module
auto-loading.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 Documentation/admin-guide/devices.txt | 3 ++-
 fs/cachefiles/main.c                  | 4 +++-
 include/linux/miscdevice.h            | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 06c525e01ea5..21b2dda10006 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -376,8 +376,9 @@
 		240 = /dev/userio	Serio driver testing device
 		241 = /dev/vhost-vsock	Host kernel driver for virtio vsock
 		242 = /dev/rfkill	Turning off radio transmissions (rfkill)
+		243 = /dev/cachefiles	Filesystem caching on files
 
-		243-254			Reserved for local use
+		244-254			Reserved for local use
 		255			Reserved for MISC_DYNAMIC_MINOR
 
   11 char	Raw keyboard device	(Linux/SPARC only)
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 3f369c6f816d..eead7b5016a7 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -30,11 +30,13 @@ MODULE_PARM_DESC(cachefiles_debug, "CacheFiles debugging mask");
 MODULE_DESCRIPTION("Mounted-filesystem based cache");
 MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("devname:cachefiles");
+MODULE_ALIAS_MISCDEV(CACHEFILES_MINOR);
 
 struct kmem_cache *cachefiles_object_jar;
 
 static struct miscdevice cachefiles_dev = {
-	.minor	= MISC_DYNAMIC_MINOR,
+	.minor	= CACHEFILES_MINOR,
 	.name	= "cachefiles",
 	.fops	= &cachefiles_daemon_fops,
 };
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index c0fea6ca5076..d7f989f593b0 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -71,6 +71,7 @@
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
 #define RFKILL_MINOR		242
+#define CACHEFILES_MINOR	243
 #define MISC_DYNAMIC_MINOR	255
 
 struct device;
-- 
2.40.1

