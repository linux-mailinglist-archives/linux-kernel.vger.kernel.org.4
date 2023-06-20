Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A48737441
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFTScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFTScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB81712;
        Tue, 20 Jun 2023 11:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A90613FB;
        Tue, 20 Jun 2023 18:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F729C433C9;
        Tue, 20 Jun 2023 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687285911;
        bh=VZd1kxbY9t+u2Dyj3VhVS08r87YsyAn76xVaCIreOlg=;
        h=From:To:Cc:Subject:Date:From;
        b=TBVqofcaqa4bYb88Vr6IPv5GN3bGjgTtSe3i1OCvxvPxb/kx7lQTMubVZSV0pHp6B
         1OSH3CfoLpalJAVul9WG0ToVd0f6t/Lw2tIf8vdM7db8CXaeJQ+fVRc3vZpio6dtBG
         4g+AmB036fNNbulcvR32Rg9qC3x68/tW/ptJB2vA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] HID: roccat: make all 'class' structures const
Date:   Tue, 20 Jun 2023 20:31:42 +0200
Message-ID: <20230620183141.681353-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18759; i=gregkh@linuxfoundation.org; h=from:subject; bh=7dWPk3dpdpqCX4oha+xclteqNg2gFJbnNWsee7gg0/8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTP/RqmJz8IiHUKhNq8ObzKcFjk27cOb9fudNbd7Jpw jqBbT6POmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi/QkMCxZJyDMyC9wLF9u+ 6oJN3pPeNRWv5zPMZjvQ9Cnj0pQdndLTF796tWdeYNlDLwA=
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

Cc: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-roccat-arvo.c     | 20 +++++++++++---------
 drivers/hid/hid-roccat-isku.c     | 21 ++++++++++++---------
 drivers/hid/hid-roccat-kone.c     | 24 +++++++++++++-----------
 drivers/hid/hid-roccat-koneplus.c | 22 ++++++++++++----------
 drivers/hid/hid-roccat-konepure.c | 22 ++++++++++++----------
 drivers/hid/hid-roccat-kovaplus.c | 22 ++++++++++++----------
 drivers/hid/hid-roccat-pyra.c     | 22 ++++++++++++----------
 drivers/hid/hid-roccat-ryos.c     | 20 +++++++++++---------
 drivers/hid/hid-roccat-savu.c     | 20 +++++++++++---------
 drivers/hid/hid-roccat.c          |  2 +-
 include/linux/hid-roccat.h        |  2 +-
 11 files changed, 108 insertions(+), 89 deletions(-)

diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index ea6b79b3aeeb..d55aaabab1ed 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -23,8 +23,6 @@
 #include "hid-roccat-common.h"
 #include "hid-roccat-arvo.h"
 
-static struct class *arvo_class;
-
 static ssize_t arvo_sysfs_show_mode_key(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -268,6 +266,11 @@ static const struct attribute_group *arvo_groups[] = {
 	NULL,
 };
 
+static const struct class arvo_class = {
+	.name = "arvo",
+	.dev_groups = arvo_groups,
+};
+
 static int arvo_init_arvo_device_struct(struct usb_device *usb_dev,
 		struct arvo_device *arvo)
 {
@@ -309,7 +312,7 @@ static int arvo_init_specials(struct hid_device *hdev)
 		goto exit_free;
 	}
 
-	retval = roccat_connect(arvo_class, hdev,
+	retval = roccat_connect(&arvo_class, hdev,
 			sizeof(struct arvo_roccat_report));
 	if (retval < 0) {
 		hid_err(hdev, "couldn't init char dev\n");
@@ -433,21 +436,20 @@ static int __init arvo_init(void)
 {
 	int retval;
 
-	arvo_class = class_create("arvo");
-	if (IS_ERR(arvo_class))
-		return PTR_ERR(arvo_class);
-	arvo_class->dev_groups = arvo_groups;
+	retval = class_register(&arvo_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&arvo_driver);
 	if (retval)
-		class_destroy(arvo_class);
+		class_unregister(&arvo_class);
 	return retval;
 }
 
 static void __exit arvo_exit(void)
 {
 	hid_unregister_driver(&arvo_driver);
-	class_destroy(arvo_class);
+	class_unregister(&arvo_class);
 }
 
 module_init(arvo_init);
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 3903a2cea00c..458060403397 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -23,8 +23,6 @@
 #include "hid-roccat-common.h"
 #include "hid-roccat-isku.h"
 
-static struct class *isku_class;
-
 static void isku_profile_activated(struct isku_device *isku, uint new_profile)
 {
 	isku->actual_profile = new_profile;
@@ -248,6 +246,11 @@ static const struct attribute_group *isku_groups[] = {
 	NULL,
 };
 
+static const struct class isku_class = {
+	.name = "isku",
+	.dev_groups = isku_groups,
+};
+
 static int isku_init_isku_device_struct(struct usb_device *usb_dev,
 		struct isku_device *isku)
 {
@@ -289,7 +292,7 @@ static int isku_init_specials(struct hid_device *hdev)
 		goto exit_free;
 	}
 
-	retval = roccat_connect(isku_class, hdev,
+	retval = roccat_connect(&isku_class, hdev,
 			sizeof(struct isku_roccat_report));
 	if (retval < 0) {
 		hid_err(hdev, "couldn't init char dev\n");
@@ -435,21 +438,21 @@ static struct hid_driver isku_driver = {
 static int __init isku_init(void)
 {
 	int retval;
-	isku_class = class_create("isku");
-	if (IS_ERR(isku_class))
-		return PTR_ERR(isku_class);
-	isku_class->dev_groups = isku_groups;
+
+	retval = class_register(&isku_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&isku_driver);
 	if (retval)
-		class_destroy(isku_class);
+		class_unregister(&isku_class);
 	return retval;
 }
 
 static void __exit isku_exit(void)
 {
 	hid_unregister_driver(&isku_driver);
-	class_destroy(isku_class);
+	class_unregister(&isku_class);
 }
 
 module_init(isku_init);
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 945ae236fb45..00a1abc7e839 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -89,9 +89,6 @@ static int kone_send(struct usb_device *usb_dev, uint usb_command,
 	return ((len < 0) ? len : ((len != size) ? -EIO : 0));
 }
 
-/* kone_class is used for creating sysfs attributes via roccat char device */
-static struct class *kone_class;
-
 static void kone_set_settings_checksum(struct kone_settings *settings)
 {
 	uint16_t checksum = 0;
@@ -657,6 +654,12 @@ static const struct attribute_group *kone_groups[] = {
 	NULL,
 };
 
+/* kone_class is used for creating sysfs attributes via roccat char device */
+static const struct class kone_class = {
+	.name = "kone",
+	.dev_groups = kone_groups,
+};
+
 static int kone_init_kone_device_struct(struct usb_device *usb_dev,
 		struct kone_device *kone)
 {
@@ -712,8 +715,8 @@ static int kone_init_specials(struct hid_device *hdev)
 			goto exit_free;
 		}
 
-		retval = roccat_connect(kone_class, hdev,
-				sizeof(struct kone_roccat_report));
+		retval = roccat_connect(&kone_class, hdev,
+					sizeof(struct kone_roccat_report));
 		if (retval < 0) {
 			hid_err(hdev, "couldn't init char dev\n");
 			/* be tolerant about not getting chrdev */
@@ -890,21 +893,20 @@ static int __init kone_init(void)
 	int retval;
 
 	/* class name has to be same as driver name */
-	kone_class = class_create("kone");
-	if (IS_ERR(kone_class))
-		return PTR_ERR(kone_class);
-	kone_class->dev_groups = kone_groups;
+	retval = class_register(&kone_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&kone_driver);
 	if (retval)
-		class_destroy(kone_class);
+		class_unregister(&kone_class);
 	return retval;
 }
 
 static void __exit kone_exit(void)
 {
 	hid_unregister_driver(&kone_driver);
-	class_destroy(kone_class);
+	class_unregister(&kone_class);
 }
 
 module_init(kone_init);
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 97b83b6f53dd..22b895436a7c 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -26,8 +26,6 @@
 
 static uint profile_numbers[5] = {0, 1, 2, 3, 4};
 
-static struct class *koneplus_class;
-
 static void koneplus_profile_activated(struct koneplus_device *koneplus,
 		uint new_profile)
 {
@@ -356,6 +354,11 @@ static const struct attribute_group *koneplus_groups[] = {
 	NULL,
 };
 
+static const struct class koneplus_class = {
+	.name = "koneplus",
+	.dev_groups = koneplus_groups,
+};
+
 static int koneplus_init_koneplus_device_struct(struct usb_device *usb_dev,
 		struct koneplus_device *koneplus)
 {
@@ -394,8 +397,8 @@ static int koneplus_init_specials(struct hid_device *hdev)
 			goto exit_free;
 		}
 
-		retval = roccat_connect(koneplus_class, hdev,
-				sizeof(struct koneplus_roccat_report));
+		retval = roccat_connect(&koneplus_class, hdev,
+					sizeof(struct koneplus_roccat_report));
 		if (retval < 0) {
 			hid_err(hdev, "couldn't init char dev\n");
 		} else {
@@ -549,21 +552,20 @@ static int __init koneplus_init(void)
 	int retval;
 
 	/* class name has to be same as driver name */
-	koneplus_class = class_create("koneplus");
-	if (IS_ERR(koneplus_class))
-		return PTR_ERR(koneplus_class);
-	koneplus_class->dev_groups = koneplus_groups;
+	retval = class_register(&koneplus_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&koneplus_driver);
 	if (retval)
-		class_destroy(koneplus_class);
+		class_unregister(&koneplus_class);
 	return retval;
 }
 
 static void __exit koneplus_exit(void)
 {
 	hid_unregister_driver(&koneplus_driver);
-	class_destroy(koneplus_class);
+	class_unregister(&koneplus_class);
 }
 
 module_init(koneplus_init);
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index a297756f2410..beca8aef8bbb 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -36,8 +36,6 @@ struct konepure_mouse_report_button {
 	uint8_t unknown[2];
 } __packed;
 
-static struct class *konepure_class;
-
 ROCCAT_COMMON2_BIN_ATTRIBUTE_W(control, 0x04, 0x03);
 ROCCAT_COMMON2_BIN_ATTRIBUTE_RW(actual_profile, 0x05, 0x03);
 ROCCAT_COMMON2_BIN_ATTRIBUTE_RW(profile_settings, 0x06, 0x1f);
@@ -72,6 +70,11 @@ static const struct attribute_group *konepure_groups[] = {
 	NULL,
 };
 
+static const struct class konepure_class = {
+	.name = "konepure",
+	.dev_groups = konepure_groups,
+};
+
 static int konepure_init_specials(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -98,8 +101,8 @@ static int konepure_init_specials(struct hid_device *hdev)
 		goto exit_free;
 	}
 
-	retval = roccat_connect(konepure_class, hdev,
-			sizeof(struct konepure_mouse_report_button));
+	retval = roccat_connect(&konepure_class, hdev,
+				sizeof(struct konepure_mouse_report_button));
 	if (retval < 0) {
 		hid_err(hdev, "couldn't init char dev\n");
 	} else {
@@ -207,21 +210,20 @@ static int __init konepure_init(void)
 {
 	int retval;
 
-	konepure_class = class_create("konepure");
-	if (IS_ERR(konepure_class))
-		return PTR_ERR(konepure_class);
-	konepure_class->dev_groups = konepure_groups;
+	retval = class_register(&konepure_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&konepure_driver);
 	if (retval)
-		class_destroy(konepure_class);
+		class_unregister(&konepure_class);
 	return retval;
 }
 
 static void __exit konepure_exit(void)
 {
 	hid_unregister_driver(&konepure_driver);
-	class_destroy(konepure_class);
+	class_unregister(&konepure_class);
 }
 
 module_init(konepure_init);
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 1a1d96e11683..86af538c10d6 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -24,8 +24,6 @@
 
 static uint profile_numbers[5] = {0, 1, 2, 3, 4};
 
-static struct class *kovaplus_class;
-
 static uint kovaplus_convert_event_cpi(uint value)
 {
 	return (value == 7 ? 4 : (value == 4 ? 3 : value));
@@ -409,6 +407,11 @@ static const struct attribute_group *kovaplus_groups[] = {
 	NULL,
 };
 
+static const struct class kovaplus_class = {
+	.name = "kovaplus",
+	.dev_groups = kovaplus_groups,
+};
+
 static int kovaplus_init_kovaplus_device_struct(struct usb_device *usb_dev,
 		struct kovaplus_device *kovaplus)
 {
@@ -463,8 +466,8 @@ static int kovaplus_init_specials(struct hid_device *hdev)
 			goto exit_free;
 		}
 
-		retval = roccat_connect(kovaplus_class, hdev,
-				sizeof(struct kovaplus_roccat_report));
+		retval = roccat_connect(&kovaplus_class, hdev,
+					sizeof(struct kovaplus_roccat_report));
 		if (retval < 0) {
 			hid_err(hdev, "couldn't init char dev\n");
 		} else {
@@ -638,21 +641,20 @@ static int __init kovaplus_init(void)
 {
 	int retval;
 
-	kovaplus_class = class_create("kovaplus");
-	if (IS_ERR(kovaplus_class))
-		return PTR_ERR(kovaplus_class);
-	kovaplus_class->dev_groups = kovaplus_groups;
+	retval = class_register(&kovaplus_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&kovaplus_driver);
 	if (retval)
-		class_destroy(kovaplus_class);
+		class_unregister(&kovaplus_class);
 	return retval;
 }
 
 static void __exit kovaplus_exit(void)
 {
 	hid_unregister_driver(&kovaplus_driver);
-	class_destroy(kovaplus_class);
+	class_unregister(&kovaplus_class);
 }
 
 module_init(kovaplus_init);
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 15528c3b013c..5663b9cd9c69 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -26,9 +26,6 @@
 
 static uint profile_numbers[5] = {0, 1, 2, 3, 4};
 
-/* pyra_class is used for creating sysfs attributes via roccat char device */
-static struct class *pyra_class;
-
 static void profile_activated(struct pyra_device *pyra,
 		unsigned int new_profile)
 {
@@ -366,6 +363,12 @@ static const struct attribute_group *pyra_groups[] = {
 	NULL,
 };
 
+/* pyra_class is used for creating sysfs attributes via roccat char device */
+static const struct class pyra_class = {
+	.name = "pyra",
+	.dev_groups = pyra_groups,
+};
+
 static int pyra_init_pyra_device_struct(struct usb_device *usb_dev,
 		struct pyra_device *pyra)
 {
@@ -413,7 +416,7 @@ static int pyra_init_specials(struct hid_device *hdev)
 			goto exit_free;
 		}
 
-		retval = roccat_connect(pyra_class, hdev,
+		retval = roccat_connect(&pyra_class, hdev,
 				sizeof(struct pyra_roccat_report));
 		if (retval < 0) {
 			hid_err(hdev, "couldn't init char dev\n");
@@ -585,21 +588,20 @@ static int __init pyra_init(void)
 	int retval;
 
 	/* class name has to be same as driver name */
-	pyra_class = class_create("pyra");
-	if (IS_ERR(pyra_class))
-		return PTR_ERR(pyra_class);
-	pyra_class->dev_groups = pyra_groups;
+	retval = class_register(&pyra_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&pyra_driver);
 	if (retval)
-		class_destroy(pyra_class);
+		class_unregister(&pyra_class);
 	return retval;
 }
 
 static void __exit pyra_exit(void)
 {
 	hid_unregister_driver(&pyra_driver);
-	class_destroy(pyra_class);
+	class_unregister(&pyra_class);
 }
 
 module_init(pyra_init);
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 0eb17a3b925d..57714a4525e2 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -28,8 +28,6 @@ struct ryos_report_special {
 	uint8_t data[4];
 } __packed;
 
-static struct class *ryos_class;
-
 ROCCAT_COMMON2_BIN_ATTRIBUTE_W(control, 0x04, 0x03);
 ROCCAT_COMMON2_BIN_ATTRIBUTE_RW(profile, 0x05, 0x03);
 ROCCAT_COMMON2_BIN_ATTRIBUTE_RW(keys_primary, 0x06, 0x7d);
@@ -80,6 +78,11 @@ static const struct attribute_group *ryos_groups[] = {
 	NULL,
 };
 
+static const struct class ryos_class = {
+	.name = "ryos",
+	.dev_groups = ryos_groups,
+};
+
 static int ryos_init_specials(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -106,7 +109,7 @@ static int ryos_init_specials(struct hid_device *hdev)
 		goto exit_free;
 	}
 
-	retval = roccat_connect(ryos_class, hdev,
+	retval = roccat_connect(&ryos_class, hdev,
 			sizeof(struct ryos_report_special));
 	if (retval < 0) {
 		hid_err(hdev, "couldn't init char dev\n");
@@ -216,21 +219,20 @@ static int __init ryos_init(void)
 {
 	int retval;
 
-	ryos_class = class_create("ryos");
-	if (IS_ERR(ryos_class))
-		return PTR_ERR(ryos_class);
-	ryos_class->dev_groups = ryos_groups;
+	retval = class_register(&ryos_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&ryos_driver);
 	if (retval)
-		class_destroy(ryos_class);
+		class_unregister(&ryos_class);
 	return retval;
 }
 
 static void __exit ryos_exit(void)
 {
 	hid_unregister_driver(&ryos_driver);
-	class_destroy(ryos_class);
+	class_unregister(&ryos_class);
 }
 
 module_init(ryos_init);
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 93be7acef673..2baa47a0efc5 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -22,8 +22,6 @@
 #include "hid-roccat-common.h"
 #include "hid-roccat-savu.h"
 
-static struct class *savu_class;
-
 ROCCAT_COMMON2_BIN_ATTRIBUTE_W(control, 0x4, 0x03);
 ROCCAT_COMMON2_BIN_ATTRIBUTE_RW(profile, 0x5, 0x03);
 ROCCAT_COMMON2_BIN_ATTRIBUTE_RW(general, 0x6, 0x10);
@@ -52,6 +50,11 @@ static const struct attribute_group *savu_groups[] = {
 	NULL,
 };
 
+static const struct class savu_class = {
+	.name = "savu",
+	.dev_groups = savu_groups,
+};
+
 static int savu_init_specials(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -78,7 +81,7 @@ static int savu_init_specials(struct hid_device *hdev)
 		goto exit_free;
 	}
 
-	retval = roccat_connect(savu_class, hdev,
+	retval = roccat_connect(&savu_class, hdev,
 			sizeof(struct savu_roccat_report));
 	if (retval < 0) {
 		hid_err(hdev, "couldn't init char dev\n");
@@ -204,21 +207,20 @@ static int __init savu_init(void)
 {
 	int retval;
 
-	savu_class = class_create("savu");
-	if (IS_ERR(savu_class))
-		return PTR_ERR(savu_class);
-	savu_class->dev_groups = savu_groups;
+	retval = class_register(&savu_class);
+	if (retval)
+		return retval;
 
 	retval = hid_register_driver(&savu_driver);
 	if (retval)
-		class_destroy(savu_class);
+		class_unregister(&savu_class);
 	return retval;
 }
 
 static void __exit savu_exit(void)
 {
 	hid_unregister_driver(&savu_driver);
-	class_destroy(savu_class);
+	class_unregister(&savu_class);
 }
 
 module_init(savu_init);
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 6da80e442fdd..c7f7562e22e5 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -295,7 +295,7 @@ EXPORT_SYMBOL_GPL(roccat_report_event);
  * Return value is minor device number in Range [0, ROCCAT_MAX_DEVICES] on
  * success, a negative error code on failure.
  */
-int roccat_connect(struct class *klass, struct hid_device *hid, int report_size)
+int roccat_connect(const struct class *klass, struct hid_device *hid, int report_size)
 {
 	unsigned int minor;
 	struct roccat_device *device;
diff --git a/include/linux/hid-roccat.h b/include/linux/hid-roccat.h
index 3214fb0815fc..753654fff07f 100644
--- a/include/linux/hid-roccat.h
+++ b/include/linux/hid-roccat.h
@@ -16,7 +16,7 @@
 
 #ifdef __KERNEL__
 
-int roccat_connect(struct class *klass, struct hid_device *hid,
+int roccat_connect(const struct class *klass, struct hid_device *hid,
 		int report_size);
 void roccat_disconnect(int minor);
 int roccat_report_event(int minor, u8 const *data);
-- 
2.41.0

