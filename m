Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6288736ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjFTOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjFTOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992B8199B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A017612B1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E2C433C9;
        Tue, 20 Jun 2023 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271895;
        bh=PAixi759Cz1x+tiJzMc3suOwGcDgCCsJLx/WttsdMWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/VVDyNPTy6shHFXNSyLza0tEw+ynXaKDdMVpC6amPiWtuJnqDJBoB4JMvwC/YQ2+
         w8Xtdsc1KhRZsZi2y7msPOArg762c6WPHih7R9DgCoe13wWWGWNbc0CxlZvTDTVot5
         r/A9C1JKzIBSzdIYBP77KaCXWYfT4eQpYrlgvqXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/9] virtio_console: make port class a static const structure
Date:   Tue, 20 Jun 2023 16:37:58 +0200
Message-ID: <20230620143751.578239-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508; i=gregkh@linuxfoundation.org; h=from:subject; bh=nRhWIu09KBDqvQssi6osu1p4RellAMun0YZOyYbob5w=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdx4wjtUKP3DdcUau9qOZotND0y2UwqzCIjZG8D/R/ lgTUX6pI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZyKJdhvn/LtuVmYSmGPKqv znJs3T+Pg23RZ4b5+Z4m4We/c2obOEXz/K+WO7lbNfQaAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, remove the class field of the ports_driver_data structure and
create the port_class static class structure declared at build time
which places it into read-only memory, instead of having it to be
dynamically allocated at load time.

Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b65c809a4e97..1f8da0a71ce9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -40,9 +40,6 @@
  * across multiple devices and multiple ports per device.
  */
 struct ports_driver_data {
-	/* Used for registering chardevs */
-	struct class *class;
-
 	/* Used for exporting per-port information to debugfs */
 	struct dentry *debugfs_dir;
 
@@ -55,6 +52,10 @@ struct ports_driver_data {
 
 static struct ports_driver_data pdrvdata;
 
+static const struct class port_class = {
+	.name = "virtio-ports",
+};
+
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
 
@@ -1399,7 +1400,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 			"Error %d adding cdev for port %u\n", err, id);
 		goto free_cdev;
 	}
-	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
+	port->dev = device_create(&port_class, &port->portdev->vdev->dev,
 				  devt, port, "vport%up%u",
 				  port->portdev->vdev->index, id);
 	if (IS_ERR(port->dev)) {
@@ -1465,7 +1466,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 free_inbufs:
 free_device:
-	device_destroy(pdrvdata.class, port->dev->devt);
+	device_destroy(&port_class, port->dev->devt);
 free_cdev:
 	cdev_del(port->cdev);
 free_port:
@@ -1540,7 +1541,7 @@ static void unplug_port(struct port *port)
 	port->portdev = NULL;
 
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
-	device_destroy(pdrvdata.class, port->dev->devt);
+	device_destroy(&port_class, port->dev->devt);
 	cdev_del(port->cdev);
 
 	debugfs_remove(port->debugfs_file);
@@ -2244,12 +2245,9 @@ static int __init virtio_console_init(void)
 {
 	int err;
 
-	pdrvdata.class = class_create("virtio-ports");
-	if (IS_ERR(pdrvdata.class)) {
-		err = PTR_ERR(pdrvdata.class);
-		pr_err("Error %d creating virtio-ports class\n", err);
+	err = class_register(&port_class);
+	if (err)
 		return err;
-	}
 
 	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
 	INIT_LIST_HEAD(&pdrvdata.consoles);
@@ -2271,7 +2269,7 @@ static int __init virtio_console_init(void)
 	unregister_virtio_driver(&virtio_console);
 free:
 	debugfs_remove_recursive(pdrvdata.debugfs_dir);
-	class_destroy(pdrvdata.class);
+	class_unregister(&port_class);
 	return err;
 }
 
@@ -2282,7 +2280,7 @@ static void __exit virtio_console_fini(void)
 	unregister_virtio_driver(&virtio_console);
 	unregister_virtio_driver(&virtio_rproc_serial);
 
-	class_destroy(pdrvdata.class);
+	class_unregister(&port_class);
 	debugfs_remove_recursive(pdrvdata.debugfs_dir);
 }
 module_init(virtio_console_init);
-- 
2.41.0

