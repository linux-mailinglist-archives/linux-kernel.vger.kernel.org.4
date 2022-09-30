Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA15F0A07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiI3LYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiI3LXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:23:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD726EF38;
        Fri, 30 Sep 2022 04:15:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso4837177wmq.4;
        Fri, 30 Sep 2022 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date;
        bh=eevZ2HpTstC4kcp5fIZb7JmTWsnNpXEHK3b6JLeamOA=;
        b=KfG4HqIb1ywmVHAH4wXYosGffjPxJ6YyYkW6oWVy65sLndPpZdwOGvL8HAOaqEKwzR
         8wTOBUcylFhaSvxrNEAdWyaHhgfeaKGwl7vamgXR7ZfMQzm1NCVqICrUlOpTdzT0+B4T
         zUyPr+xGOmV5tmuPKUsRpXuyPHWrR7LZzKtrPQIdUYyGbFJD3KhUhuEOXMNpXkngGiIg
         aafgrteHwHVnhwmkNm+tnI1kC6RlpNhRv/huuj7Vbl62co8S1KWUu7lsNMzXxxXur4mm
         bAx+89zp3d2k7u9QAOvBf36ANHb6j812yy+JFDE1xHBHUOt+SIvvrReHs54yPr3ReTtw
         eAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eevZ2HpTstC4kcp5fIZb7JmTWsnNpXEHK3b6JLeamOA=;
        b=60PzJgQfPBvie0/nzCox83ZV9gEHGFbKLCiYRJrzeEWJtDLlnExRkJdLlRjWxcnKzZ
         K0NJ4wpg+NTJL8413epqWy7ujpOXZn7fXc6Yp054sPxToHFOaCTNBhCFAm2hfm+I2Pv9
         kDl46J0czgzZtG2TFRX+hWLgUm+POHyrgbgU45U6WSro6Rtf+0G/+FvbnfNc0HIJ3w4f
         +UYl4wP0TIFJ4TMebD3/yV98ZhDPqP9o3K4MnL78ci79kUezk7ec1YCdN4BIfElfjdsH
         /sbDdrftjDdCXuoehJrsELD+wVdJ5Rk991V2+ag3Ke+0qbZ59c66Dznm3kZzU7opMI5G
         5Eig==
X-Gm-Message-State: ACrzQf0/Lwp3eAVqi/Mlrw+irop242rLgi6vY7dO6uNI4HVIigzarVU8
        hT3WD2BiwNlmbsLeDXbRktbAE4rFw7JH
X-Google-Smtp-Source: AMsMyM5KADB2ntYFuLYSMx0P1/vdNENNizsSPrsGlZlo+TIuPGYhRRZpBEg66+uQOspEeXboVgjXyg==
X-Received: by 2002:a7b:c845:0:b0:3b5:5e45:b266 with SMTP id c5-20020a7bc845000000b003b55e45b266mr5560116wml.82.1664536521150;
        Fri, 30 Sep 2022 04:15:21 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a5f54e3bbbsm7539722wmq.38.2022.09.30.04.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:15:20 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Fri, 30 Sep 2022 12:15:19 +0100
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, Jason@zx2c4.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: lenovo: Convert snprintf() to sysfs_emit()
Message-ID: <YzbPx5TfsW8sH9b1@octinomon>
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
 drivers/hid/hid-lenovo.c | 16 ++++++++--------
 kernel/cpu.c             |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 9dabd6323234..007d82033c61 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -537,7 +537,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -581,7 +581,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		cptkbd_data->sensitivity);
 }
 
@@ -753,7 +753,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -783,7 +783,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -813,7 +813,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -843,7 +843,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -873,7 +873,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		data_pointer->sensitivity);
 }
 
@@ -902,7 +902,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		data_pointer->press_speed);
 }
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..870cc6e859fc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2512,7 +2512,7 @@ static ssize_t control_show(struct device *dev,
 {
 	const char *state = smt_states[cpu_smt_control];
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return sysfs_emit(buf, "%s\n", state);
 }
 
 static ssize_t control_store(struct device *dev, struct device_attribute *attr,
@@ -2525,7 +2525,7 @@ static DEVICE_ATTR_RW(control);
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return sysfs_emit(buf, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR_RO(active);
 
-- 
2.37.3

