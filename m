Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92A736EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjFTOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFTOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F6E9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8A461299
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B743CC433C0;
        Tue, 20 Jun 2023 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687272101;
        bh=hvbXMqheBFWdGYdFFklc6ImvCYGr5XJYGL17GhACj1A=;
        h=From:To:Cc:Subject:Date:From;
        b=X8HBHG1l+0J2k91UVnFvjaaSFaVYCsx8HmXNpe6RGG5MsPkmczdr3xwW+TtKh3CTO
         oLN1OB7F82yUI+AK67aiKRQe+gYseeQPyRAWqHn95msbiUiYi26BPcEeSGYRI4Szbj
         +Tz17z4rAmufJO6QOw/WfuXy3lVr47FYy71rJBuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] comedi: make all 'class' structures const
Date:   Tue, 20 Jun 2023 16:41:38 +0200
Message-ID: <20230620144137.581406-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6420; i=gregkh@linuxfoundation.org; h=from:subject; bh=MUWmvfX9HE4SupExk5qC8mv1/uPty1xr5ic/Cayo/4Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdy18skDx2SpWgVl7z8rxzF79IVHZzE099MT+raZTZ jKzvp6n2hHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATSRNkmO+4pvF/DR/T3Q/a opE2HgzZ9v+SrzDMD20OLTPMameesb9JM/2nv5774qIKAA==
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
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/comedi_fops.c         | 47 ++++++++++++++--------------
 drivers/comedi/drivers/comedi_test.c | 23 +++++++-------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 8e43918d38c4..1548dea15df1 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -97,7 +97,6 @@ static DEFINE_MUTEX(comedi_subdevice_minor_table_lock);
 static struct comedi_subdevice
 *comedi_subdevice_minor_table[COMEDI_NUM_SUBDEVICE_MINORS];
 
-static struct class *comedi_class;
 static struct cdev comedi_cdev;
 
 static void comedi_device_init(struct comedi_device *dev)
@@ -187,18 +186,6 @@ static struct comedi_device *comedi_clear_board_minor(unsigned int minor)
 	return dev;
 }
 
-static void comedi_free_board_dev(struct comedi_device *dev)
-{
-	if (dev) {
-		comedi_device_cleanup(dev);
-		if (dev->class_dev) {
-			device_destroy(comedi_class,
-				       MKDEV(COMEDI_MAJOR, dev->minor));
-		}
-		comedi_dev_put(dev);
-	}
-}
-
 static struct comedi_subdevice *
 comedi_subdevice_from_minor(const struct comedi_device *dev, unsigned int minor)
 {
@@ -611,6 +598,23 @@ static struct attribute *comedi_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(comedi_dev);
 
+static const struct class comedi_class = {
+	.name = "comedi",
+	.dev_groups = comedi_dev_groups,
+};
+
+static void comedi_free_board_dev(struct comedi_device *dev)
+{
+	if (dev) {
+		comedi_device_cleanup(dev);
+		if (dev->class_dev) {
+			device_destroy(&comedi_class,
+				       MKDEV(COMEDI_MAJOR, dev->minor));
+		}
+		comedi_dev_put(dev);
+	}
+}
+
 static void __comedi_clear_subdevice_runflags(struct comedi_subdevice *s,
 					      unsigned int bits)
 {
@@ -3263,7 +3267,7 @@ struct comedi_device *comedi_alloc_board_minor(struct device *hardware_device)
 		return ERR_PTR(-EBUSY);
 	}
 	dev->minor = i;
-	csdev = device_create(comedi_class, hardware_device,
+	csdev = device_create(&comedi_class, hardware_device,
 			      MKDEV(COMEDI_MAJOR, i), NULL, "comedi%i", i);
 	if (!IS_ERR(csdev))
 		dev->class_dev = get_device(csdev);
@@ -3312,7 +3316,7 @@ int comedi_alloc_subdevice_minor(struct comedi_subdevice *s)
 	}
 	i += COMEDI_NUM_BOARD_MINORS;
 	s->minor = i;
-	csdev = device_create(comedi_class, dev->class_dev,
+	csdev = device_create(&comedi_class, dev->class_dev,
 			      MKDEV(COMEDI_MAJOR, i), NULL, "comedi%i_subd%i",
 			      dev->minor, s->index);
 	if (!IS_ERR(csdev))
@@ -3337,7 +3341,7 @@ void comedi_free_subdevice_minor(struct comedi_subdevice *s)
 		comedi_subdevice_minor_table[i] = NULL;
 	mutex_unlock(&comedi_subdevice_minor_table_lock);
 	if (s->class_dev) {
-		device_destroy(comedi_class, MKDEV(COMEDI_MAJOR, s->minor));
+		device_destroy(&comedi_class, MKDEV(COMEDI_MAJOR, s->minor));
 		s->class_dev = NULL;
 	}
 }
@@ -3383,15 +3387,12 @@ static int __init comedi_init(void)
 	if (retval)
 		goto out_unregister_chrdev_region;
 
-	comedi_class = class_create("comedi");
-	if (IS_ERR(comedi_class)) {
-		retval = PTR_ERR(comedi_class);
+	retval = class_register(&comedi_class);
+	if (retval) {
 		pr_err("failed to create class\n");
 		goto out_cdev_del;
 	}
 
-	comedi_class->dev_groups = comedi_dev_groups;
-
 	/* create devices files for legacy/manual use */
 	for (i = 0; i < comedi_num_legacy_minors; i++) {
 		struct comedi_device *dev;
@@ -3413,7 +3414,7 @@ static int __init comedi_init(void)
 
 out_cleanup_board_minors:
 	comedi_cleanup_board_minors();
-	class_destroy(comedi_class);
+	class_unregister(&comedi_class);
 out_cdev_del:
 	cdev_del(&comedi_cdev);
 out_unregister_chrdev_region:
@@ -3425,7 +3426,7 @@ module_init(comedi_init);
 static void __exit comedi_cleanup(void)
 {
 	comedi_cleanup_board_minors();
-	class_destroy(comedi_class);
+	class_unregister(&comedi_class);
 	cdev_del(&comedi_cdev);
 	unregister_chrdev_region(MKDEV(COMEDI_MAJOR, 0), COMEDI_NUM_MINORS);
 
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index c02dc19a679b..30ea8b53ebf8 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -60,7 +60,9 @@
 static bool config_mode;
 static unsigned int set_amplitude;
 static unsigned int set_period;
-static struct class *ctcls;
+static const struct class ctcls = {
+	.name = CLASS_NAME,
+};
 static struct device *ctdev;
 
 module_param_named(noauto, config_mode, bool, 0444);
@@ -795,13 +797,13 @@ static int __init comedi_test_init(void)
 	}
 
 	if (!config_mode) {
-		ctcls = class_create(CLASS_NAME);
-		if (IS_ERR(ctcls)) {
+		ret = class_register(&ctcls);
+		if (ret) {
 			pr_warn("comedi_test: unable to create class\n");
 			goto clean3;
 		}
 
-		ctdev = device_create(ctcls, NULL, MKDEV(0, 0), NULL, DEV_NAME);
+		ctdev = device_create(&ctcls, NULL, MKDEV(0, 0), NULL, DEV_NAME);
 		if (IS_ERR(ctdev)) {
 			pr_warn("comedi_test: unable to create device\n");
 			goto clean2;
@@ -817,13 +819,10 @@ static int __init comedi_test_init(void)
 	return 0;
 
 clean:
-	device_destroy(ctcls, MKDEV(0, 0));
+	device_destroy(&ctcls, MKDEV(0, 0));
 clean2:
-	class_destroy(ctcls);
-	ctdev = NULL;
+	class_unregister(&ctcls);
 clean3:
-	ctcls = NULL;
-
 	return 0;
 }
 module_init(comedi_test_init);
@@ -833,9 +832,9 @@ static void __exit comedi_test_exit(void)
 	if (ctdev)
 		comedi_auto_unconfig(ctdev);
 
-	if (ctcls) {
-		device_destroy(ctcls, MKDEV(0, 0));
-		class_destroy(ctcls);
+	if (class_is_registered(&ctcls)) {
+		device_destroy(&ctcls, MKDEV(0, 0));
+		class_unregister(&ctcls);
 	}
 
 	comedi_driver_unregister(&waveform_driver);
-- 
2.41.0

