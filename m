Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B6737442
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjFTScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFTScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCBB1728;
        Tue, 20 Jun 2023 11:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69B08613F7;
        Tue, 20 Jun 2023 18:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510F3C433C8;
        Tue, 20 Jun 2023 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687285914;
        bh=UODFmXmXja4/VHNHBCXtYvr9dUIGxKFleEwSRPS283Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BO6VLQbD0SFDH+16gvnRRAMC+0ncMvTIoWDKV6/SKDMRIiW7NDTS6WMzS558GVSwz
         CSgkqF5QGRiwviKFEJmOrkJ9FjbxBbGjttJWvtvgE3eByWzVRzdTeeurmIfUe/V1mM
         3N3TMZ256WchlKWQJ7//u6e1shFNeFhNkLwzgQtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: [PATCH 2/2] HID: hidraw: make hidraw_class structure const
Date:   Tue, 20 Jun 2023 20:31:43 +0200
Message-ID: <20230620183141.681353-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620183141.681353-3-gregkh@linuxfoundation.org>
References: <20230620183141.681353-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543; i=gregkh@linuxfoundation.org; h=from:subject; bh=UODFmXmXja4/VHNHBCXtYvr9dUIGxKFleEwSRPS283Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTP/Qy5Yv9Zvy3Y41399KI6wHJAt2cMQ7XCnf/MWQ6s eyWfOicjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZgIPzPDgtl7Jvsfd2F5PVW2 bmZMan5Eb1ZLMMM8k5f1xuu3Lwwuvrcm2kvxOU9w2v+pAA==
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

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hidraw.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 93e62b161501..d44e7a052584 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -32,7 +32,9 @@
 
 static int hidraw_major;
 static struct cdev hidraw_cdev;
-static struct class *hidraw_class;
+static const struct class hidraw_class = {
+	.name = "hidraw",
+};
 static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
 static DECLARE_RWSEM(minors_rwsem);
 
@@ -324,7 +326,7 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
 			hid_hw_close(hidraw->hid);
 			wake_up_interruptible(&hidraw->wait);
 		}
-		device_destroy(hidraw_class,
+		device_destroy(&hidraw_class,
 			       MKDEV(hidraw_major, hidraw->minor));
 	} else {
 		--hidraw->open;
@@ -564,7 +566,7 @@ int hidraw_connect(struct hid_device *hid)
 		goto out;
 	}
 
-	dev->dev = device_create(hidraw_class, &hid->dev, MKDEV(hidraw_major, minor),
+	dev->dev = device_create(&hidraw_class, &hid->dev, MKDEV(hidraw_major, minor),
 				 NULL, "%s%d", "hidraw", minor);
 
 	if (IS_ERR(dev->dev)) {
@@ -618,11 +620,9 @@ int __init hidraw_init(void)
 
 	hidraw_major = MAJOR(dev_id);
 
-	hidraw_class = class_create("hidraw");
-	if (IS_ERR(hidraw_class)) {
-		result = PTR_ERR(hidraw_class);
+	result = class_register(&hidraw_class);
+	if (result)
 		goto error_cdev;
-	}
 
         cdev_init(&hidraw_cdev, &hidraw_ops);
 	result = cdev_add(&hidraw_cdev, dev_id, HIDRAW_MAX_DEVICES);
@@ -634,7 +634,7 @@ int __init hidraw_init(void)
 	return result;
 
 error_class:
-	class_destroy(hidraw_class);
+	class_unregister(&hidraw_class);
 error_cdev:
 	unregister_chrdev_region(dev_id, HIDRAW_MAX_DEVICES);
 	goto out;
@@ -645,7 +645,7 @@ void hidraw_exit(void)
 	dev_t dev_id = MKDEV(hidraw_major, 0);
 
 	cdev_del(&hidraw_cdev);
-	class_destroy(hidraw_class);
+	class_unregister(&hidraw_class);
 	unregister_chrdev_region(dev_id, HIDRAW_MAX_DEVICES);
 
 }
-- 
2.41.0

