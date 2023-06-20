Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3E737369
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjFTSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjFTSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A11712;
        Tue, 20 Jun 2023 11:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2571961335;
        Tue, 20 Jun 2023 18:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31585C433C0;
        Tue, 20 Jun 2023 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687284102;
        bh=8quhV2tbMNIcgNf0FhcdhJPJLP35KK5ja15vVIBxFig=;
        h=From:To:Cc:Subject:Date:From;
        b=dJGwm2likr5rT11+8rajKw5U/eZHzuSqZCyiV2suyc1xrg82/ACKXFepTzj0OIj9T
         nRND2povsk8RV9FaIP66Ot7MiiCUddSyao0ot0Dh5PLQhZIRsjYXQnFnmLXdjm7/2Y
         iA4GPYwWhZCbALjdLqr/pn9X1Edo125ekomqkvWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/4] block/rnbd: make all 'class' structures const
Date:   Tue, 20 Jun 2023 20:01:30 +0200
Message-ID: <20230620180129.645646-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4016; i=gregkh@linuxfoundation.org; h=from:subject; bh=N9xk1YXDw7PpnjqnEHXwkGzYSFFfX4Ar5jAK0R5WDu0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTX1Z2Xt7isuaT03bzgzPMlk1q09R2SXAQchQ+6te67 m9IwZtdHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR/RIM82Mm7LOJC5nOfu/b P8tNJrvd7yk38TIs2NqVHxtkMe2z2uYXavpfqrZ1Pj/VDgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 20 +++++++++++---------
 drivers/block/rnbd/rnbd-srv-sysfs.c | 22 ++++++++++++----------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 8c6087949794..e84abac04f4f 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -24,7 +24,9 @@
 #include "rnbd-clt.h"
 
 static struct device *rnbd_dev;
-static struct class *rnbd_dev_class;
+static const struct class rnbd_dev_class = {
+	.name = "rnbd_client",
+};
 static struct kobject *rnbd_devs_kobj;
 
 enum {
@@ -646,11 +648,11 @@ int rnbd_clt_create_sysfs_files(void)
 {
 	int err;
 
-	rnbd_dev_class = class_create("rnbd-client");
-	if (IS_ERR(rnbd_dev_class))
-		return PTR_ERR(rnbd_dev_class);
+	err = class_register(&rnbd_dev_class);
+	if (err)
+		return err;
 
-	rnbd_dev = device_create_with_groups(rnbd_dev_class, NULL,
+	rnbd_dev = device_create_with_groups(&rnbd_dev_class, NULL,
 					      MKDEV(0, 0), NULL,
 					      default_attr_groups, "ctl");
 	if (IS_ERR(rnbd_dev)) {
@@ -666,9 +668,9 @@ int rnbd_clt_create_sysfs_files(void)
 	return 0;
 
 dev_destroy:
-	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+	device_destroy(&rnbd_dev_class, MKDEV(0, 0));
 cls_destroy:
-	class_destroy(rnbd_dev_class);
+	class_unregister(&rnbd_dev_class);
 
 	return err;
 }
@@ -678,6 +680,6 @@ void rnbd_clt_destroy_sysfs_files(void)
 	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
 	kobject_del(rnbd_devs_kobj);
 	kobject_put(rnbd_devs_kobj);
-	device_destroy(rnbd_dev_class, MKDEV(0, 0));
-	class_destroy(rnbd_dev_class);
+	device_destroy(&rnbd_dev_class, MKDEV(0, 0));
+	class_unregister(&rnbd_dev_class);
 }
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index d5d9267e1fa5..5e69c0112e23 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -20,7 +20,9 @@
 #include "rnbd-srv.h"
 
 static struct device *rnbd_dev;
-static struct class *rnbd_dev_class;
+static const struct class rnbd_dev_class = {
+	.name = "rnbd-server",
+};
 static struct kobject *rnbd_devs_kobj;
 
 static void rnbd_srv_dev_release(struct kobject *kobj)
@@ -215,12 +217,12 @@ int rnbd_srv_create_sysfs_files(void)
 {
 	int err;
 
-	rnbd_dev_class = class_create("rnbd-server");
-	if (IS_ERR(rnbd_dev_class))
-		return PTR_ERR(rnbd_dev_class);
+	err = class_register(&rnbd_dev_class);
+	if (err)
+		return err;
 
-	rnbd_dev = device_create(rnbd_dev_class, NULL,
-				  MKDEV(0, 0), NULL, "ctl");
+	rnbd_dev = device_create(&rnbd_dev_class, NULL,
+				 MKDEV(0, 0), NULL, "ctl");
 	if (IS_ERR(rnbd_dev)) {
 		err = PTR_ERR(rnbd_dev);
 		goto cls_destroy;
@@ -234,9 +236,9 @@ int rnbd_srv_create_sysfs_files(void)
 	return 0;
 
 dev_destroy:
-	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+	device_destroy(&rnbd_dev_class, MKDEV(0, 0));
 cls_destroy:
-	class_destroy(rnbd_dev_class);
+	class_unregister(&rnbd_dev_class);
 
 	return err;
 }
@@ -245,6 +247,6 @@ void rnbd_srv_destroy_sysfs_files(void)
 {
 	kobject_del(rnbd_devs_kobj);
 	kobject_put(rnbd_devs_kobj);
-	device_destroy(rnbd_dev_class, MKDEV(0, 0));
-	class_destroy(rnbd_dev_class);
+	device_destroy(&rnbd_dev_class, MKDEV(0, 0));
+	class_unregister(&rnbd_dev_class);
 }
-- 
2.41.0

