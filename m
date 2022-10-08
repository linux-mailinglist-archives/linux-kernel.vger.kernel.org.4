Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8705F8705
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJHTLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJHTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:10:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21392F643;
        Sat,  8 Oct 2022 12:10:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bv10so8062585wrb.4;
        Sat, 08 Oct 2022 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wbrHIINWpNtq1uT4Jf3QIYAe/wvpMtUNlJq6URPo7Y=;
        b=gWoU7Rx2ibfkGptoYG9FDbP0gxfTtzkWf1ilHfG+T3uESHxU32ANZzJ2JF4sWQOVkk
         YWv7mQdLwAOueULcAyuZ7rg1cuEGPUU5G5OI+h7Oecpc2SHWAVQFt4jIZDAeIJfp4INL
         yo3kk5sPu0gHjkXJZAXXeHRaI+/zBx4wpgiFeacC1YQ3JCnpyeks6ZC9++/XuAzbDdq0
         6IazpEkmbbMePGeovpcOoVKtC9kjCUthFH35UiasyExZtoKbf/C3h0L8lEV184dDtPOG
         aJz/+FTM5IHHqapZ8bYyBvOa0w44qIWy191BzoxLKE4NIgGuKQkqK42tWrl6E/1JyqQ3
         oq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wbrHIINWpNtq1uT4Jf3QIYAe/wvpMtUNlJq6URPo7Y=;
        b=bkqEjnrPPzWWB2cLMx/bCgioaI9Om8sON+zYXgqv9WRBZ2Pcn0be1Ce++m2F4deRGk
         hdwW54mm0JjNh6kp3KNxNL+c5iE629QMrfDFaSxT5fvKGptHoDE9aafJCZa5N7EfxX4e
         ORKxyUVeIAJuEGpTVMUwxeJ8cA6Aulbc9XrEtbOgn2jmj6wc75IflI0Huk7Ca/fJlQbb
         Vai+38Vv5daTNY72qnKXJiXwtPsC0SGfuwhE2KTQv4AXF/vdAPPZi4NaQ+RuFiwe5pek
         o6how6Sw3mMyH85iyBcmHR5jmGtFozC2XHSXGFC1g94cT/GTmCdOn/rrlhyWBP21sk4y
         OLlw==
X-Gm-Message-State: ACrzQf0I1zixsqkLDf0MGksTXBbuVYQZUYeVLEafiBOT22zUIIbk2F/m
        TotVdUSOqumyEU62Un4Ubw==
X-Google-Smtp-Source: AMsMyM7ds93yz+i63Lvzrb/741kz+lZLJ7NheYdFKnuCQPCx1YGqA/LKhss9WIikPqnthopYaei6UA==
X-Received: by 2002:a5d:5552:0:b0:22e:6941:81f8 with SMTP id g18-20020a5d5552000000b0022e694181f8mr6563177wrw.521.1665256255039;
        Sat, 08 Oct 2022 12:10:55 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id q3-20020a1c4303000000b003b4bd18a23bsm10912968wma.12.2022.10.08.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:10:54 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Sat, 8 Oct 2022 20:10:52 +0100
To:     erazor_de@users.sourceforge.net
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] HID: roccat: Convert snprintf() to sysfs_emit()
Message-ID: <Y0HLPBTodPxVRbe4@octinomon>
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
 drivers/hid/hid-roccat-kone.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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
-- 
2.37.3

