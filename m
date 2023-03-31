Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DB6D1C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjCaJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjCaJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594FB1E71C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2488D62694
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368FDC433EF;
        Fri, 31 Mar 2023 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255215;
        bh=TCGFo3EUGQQgskyrs3hZqnkhFTHNXk7zL68YZuL2WDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAkEA3ue7aasfHOd8CoMIvVFdDS897IUCmjhHXLlfUn0/BDrSNgvZqBh5f7qN7txl
         Gbr1WCvr8KKdbyNyzBxDL+Efs/I55xDwWfmzCaeklH24MsNCK9NRE7vvVdK3L6EX0w
         4FzGCq6EvJvucARKE1wQG/476GGWxIb9qzUjMlGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/7] driver core: clean up the logic to determine which /sys/dev/ directory to use
Date:   Fri, 31 Mar 2023 11:33:15 +0200
Message-Id: <20230331093318.82288-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=gregkh@linuxfoundation.org; h=from:subject; bh=TCGFo3EUGQQgskyrs3hZqnkhFTHNXk7zL68YZuL2WDw=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK+7eLN65QvTa+6q/8fmJr/mFwyXmulf39P9+8/9n0 +dpG2U/d8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBELrAyLGi8eFLuUNweyWeG p+wnW4n/0imeIsKwYOKjjN5/x87HM/XzfTGZprX96D6nrwA=
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

When a dev_t is set in a struct device, an symlink in /sys/dev/ is
created for it either under /sys/dev/block/ or /sys/dev/char/ depending
on the device type.

The logic to determine this would trigger off of the class of the
object, and the kobj_type set in that location.  But it turns out that
this deep nesting isn't needed at all, as it's either a choice of block
or "everything else" which is a char device.  So make the logic a lot
more simple and obvious, and remove the incorrect comments in the code
that tried to document something that was not happening at all (it is
impossible to set class->dev_kobj to NULL as the class core prevented
that from happening.

This removes the only place that class->dev_kobj was being used, so
after this, it can be removed entirely.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h     | 10 ++++++++++
 drivers/base/core.c     | 22 ++++------------------
 drivers/base/devtmpfs.c |  9 ---------
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 6296164bb7f3..4660e1159ee0 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -209,6 +209,16 @@ int devtmpfs_init(void);
 static inline int devtmpfs_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_BLOCK
+extern struct class block_class;
+static inline bool is_blockdev(struct device *dev)
+{
+	return dev->class == &block_class;
+}
+#else
+static inline bool is_blockdev(struct device *dev) { return false; }
+#endif
+
 /* Device links support */
 int device_links_read_lock(void);
 void device_links_read_unlock(int idx);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e3bc34fcf779..dbc2ba6dfffc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3430,27 +3430,13 @@ int dev_set_name(struct device *dev, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(dev_set_name);
 
-/**
- * device_to_dev_kobj - select a /sys/dev/ directory for the device
- * @dev: device
- *
- * By default we select char/ for new entries.  Setting class->dev_obj
- * to NULL prevents an entry from being created.  class->dev_kobj must
- * be set (or cleared) before any devices are registered to the class
- * otherwise device_create_sys_dev_entry() and
- * device_remove_sys_dev_entry() will disagree about the presence of
- * the link.
- */
+/* select a /sys/dev/ directory for the device */
 static struct kobject *device_to_dev_kobj(struct device *dev)
 {
-	struct kobject *kobj;
-
-	if (dev->class)
-		kobj = dev->class->dev_kobj;
+	if (is_blockdev(dev))
+		return sysfs_dev_block_kobj;
 	else
-		kobj = sysfs_dev_char_kobj;
-
-	return kobj;
+		return sysfs_dev_char_kobj;
 }
 
 static int device_create_sys_dev_entry(struct device *dev)
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index ae72d4ba8547..b848764ef018 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -94,15 +94,6 @@ static struct file_system_type dev_fs_type = {
 	.mount = public_dev_mount,
 };
 
-#ifdef CONFIG_BLOCK
-static inline int is_blockdev(struct device *dev)
-{
-	return dev->class == &block_class;
-}
-#else
-static inline int is_blockdev(struct device *dev) { return 0; }
-#endif
-
 static int devtmpfs_submit_req(struct req *req, const char *tmp)
 {
 	init_completion(&req->done);
-- 
2.40.0

