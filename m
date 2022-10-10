Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B925F9D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiJJK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiJJK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:57:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46B65543;
        Mon, 10 Oct 2022 03:57:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so6166255wmb.3;
        Mon, 10 Oct 2022 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN4r8CDn7pemOqYmN/evGA/y9m/PE8B8URfgxXvBj2U=;
        b=RJYs1I/1ig+l0BWr3VkcGiT1dtJb3UNnOxikQmpe8Wy3CJQbo/Udo0JHtlN0dbd9xS
         YN5HIC1vYmbn/qF+Us/Ni05FQIdwUsV4tiUAYmwacIQqiACHmYDX+wuEUQTz1l/mT8pv
         NQw6dix8Xnh/KDQnPjLXM6GMs2Ro1tkkOPJSkJ56kuyeGIzK0PF9zvVbmUX18pk1oDuw
         8txGv9xryu1FF9QcZFYWII16pHMxP5xUrtNi/JuROH47B9jgc8BPNIX41oRzSmsyOE6o
         I8EeIMsHVXbm6/za15TilJKaQPnAX+Q/Lj2R4IkFjPokvRXuXC6Xidl6f2GNayBPW146
         v/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN4r8CDn7pemOqYmN/evGA/y9m/PE8B8URfgxXvBj2U=;
        b=3IfV1ntqWdaKSZmfDJPh4wF6yy1QlU070LaZj5fcSUHG8yIzTZqCRgVijDE6CBIbXS
         fGYpCK1ABwNE7ViN5yUx2x77v1Zykok3CqGwMQlRXuCfO9uOnojYTa8LzcwjVcpTLewB
         RZ7CBneAGhc/jJk/5+NfuYt0dDHNYslex4lJ0UXWCbQVQZpFVlw0pPUrJMnKE6bSCKL/
         Gkk7YolCErkWttiM6BYRAS0mSkGxlxDxsxh8h1wTrAsE7dNYSgUfceKLFzzboakOdPIr
         KFqig1TXMNIElKqpzjc4hFyJJa3rZzHjeWvYNaT74ZgnOnTt2wyZtkxIb0P0h3Oa1Z+g
         1b3A==
X-Gm-Message-State: ACrzQf0z4HdTfsqJFLFdvht5dhAgqz6l44OgiZwoeO2YgapBtyFktCgu
        QFBS8irk1zd2Vswj/gUK7ltZrIZBpQ==
X-Google-Smtp-Source: AMsMyM7Bu1aO2pQJWWEeX6x3C/IGK3nrIxlnY8K8OGLih8x2wqgJIp3YvVJlJTfCnrNUmflKnOMgsg==
X-Received: by 2002:a05:600c:587:b0:3c6:b64b:81fc with SMTP id o7-20020a05600c058700b003c6b64b81fcmr2940106wmd.123.1665399438907;
        Mon, 10 Oct 2022 03:57:18 -0700 (PDT)
Received: from octinomon ([212.121.210.249])
        by smtp.gmail.com with ESMTPSA id c190-20020a1c35c7000000b003b492338f45sm10252213wma.39.2022.10.10.03.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 03:57:18 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Mon, 10 Oct 2022 11:57:15 +0100
To:     benjamin.tissoires@redhat.com
Cc:     erazor_de@users.sourceforge.net, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elana.Copperman@mobileye.com
Subject: [PATCH v2] HID: roccat-*: Convert snprintf() to sysfs_emit()
Message-ID: <Y0P6i8LTdgVX+0O4@octinomon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf

Following the advice on kernel documentation
https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

For show(device *...) functions we should only use sysfs_emit() or sysfs_emit_at()
especially when formatting the value to be returned to user space.
Convert snprintf() to sysfs_emit()

Signed-off-by: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
---
v2 - Combines the 4 previous patches into one

 drivers/hid/hid-roccat-kone.c     | 12 ++++++------
 drivers/hid/hid-roccat-koneplus.c |  4 ++--
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 drivers/hid/hid-roccat-pyra.c     |  6 +++---
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 76da04801ca9..f0c35c05e702 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -403,7 +403,7 @@ static ssize_t kone_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_profile);
+	return sysfs_emit(buf, "%d\n", kone->actual_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, kone_sysfs_show_actual_profile, NULL);
 
@@ -412,7 +412,7 @@ static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_dpi);
+	return sysfs_emit(buf, "%d\n", kone->actual_dpi);
 }
 static DEVICE_ATTR(actual_dpi, 0440, kone_sysfs_show_actual_dpi, NULL);
 
@@ -435,7 +435,7 @@ static ssize_t kone_sysfs_show_weight(struct device *dev,
 
 	if (retval)
 		return retval;
-	return snprintf(buf, PAGE_SIZE, "%d\n", weight);
+	return sysfs_emit(buf, "%d\n", weight);
 }
 static DEVICE_ATTR(weight, 0440, kone_sysfs_show_weight, NULL);
 
@@ -444,7 +444,7 @@ static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->firmware_version);
+	return sysfs_emit(buf, "%d\n", kone->firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, kone_sysfs_show_firmware_version,
 		   NULL);
@@ -454,7 +454,7 @@ static ssize_t kone_sysfs_show_tcu(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.tcu);
+	return sysfs_emit(buf, "%d\n", kone->settings.tcu);
 }
 
 static int kone_tcu_command(struct usb_device *usb_dev, int number)
@@ -556,7 +556,7 @@ static ssize_t kone_sysfs_show_startup_profile(struct device *dev,
 {
 	struct kone_device *kone =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", kone->settings.startup_profile);
 }
 
 static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 1896c69ea512..1635ddc7c3cf 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -244,7 +244,7 @@ static ssize_t koneplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct koneplus_device *koneplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", koneplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", koneplus->actual_profile);
 }
 
 static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
@@ -311,7 +311,7 @@ static ssize_t koneplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KONEPLUS_SIZE_INFO);
 	mutex_unlock(&koneplus->koneplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   koneplus_sysfs_show_firmware_version, NULL);
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 6fb9b9563769..7f6238a19739 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -274,7 +274,7 @@ static ssize_t kovaplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_profile);
 }
 
 static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
 
@@ -336,7 +336,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_x_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_x, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
@@ -346,7 +346,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_y_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_y, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
@@ -367,7 +367,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KOVAPLUS_SIZE_INFO);
 	mutex_unlock(&kovaplus->kovaplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   kovaplus_sysfs_show_firmware_version, NULL);
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 4fcc8e7d276f..8b4d2519d4c4 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -286,7 +286,7 @@ static ssize_t pyra_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct pyra_device *pyra =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", pyra->actual_cpi);
+	return sysfs_emit(buf, "%d\n", pyra->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
 
@@ -303,7 +303,7 @@ static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 			&settings, PYRA_SIZE_SETTINGS);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", settings.startup_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
 static DEVICE_ATTR(startup_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
@@ -324,7 +324,7 @@ static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
 			&info, PYRA_SIZE_INFO);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, pyra_sysfs_show_firmware_version,
 		   NULL);
-- 
2.37.3

