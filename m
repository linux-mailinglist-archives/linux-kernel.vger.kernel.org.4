Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1126D6F8CC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjEEXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjEEXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:24:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB7172D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:24:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64359d9c531so1847340b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683329059; x=1685921059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKLAfQ+XdRp0UM94hCtSrE5esZwKrW294YS+Ttx9oOQ=;
        b=ZJ3jsPEwRlg76oKOSRpSUBfW+D+nc+3Xm7uZdmvIgP2yqAOq0tNsRw5hGBiuLydPhP
         34pbfqDv26JAPKb1tmv6C/wb5HSZ8aQujzeIJ0I+oATGDlKhIDuIKBhLHKZAscXeP1u1
         tiNcrl0I/LPQIzxLfQd5bfG99UFIY/xJGzzGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683329059; x=1685921059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKLAfQ+XdRp0UM94hCtSrE5esZwKrW294YS+Ttx9oOQ=;
        b=KprcWNb0SQhNVSq7QwWP79DSyFY5JZ4bX9irKJFfmK56Jvio5I32uDmTWMzn0pIJFM
         0TcFM7H97+NWMyqYKqZv/kN8Nbco0kJ3jQvWGST43HV+eEPz8U04YV1g3OIQtYoeKvaN
         ClMMLy3FalMca57qQA0AfxNS70nucSqfGJQ3QluWUY/3+YsT3m6MNgZ/p0D7Ft4y1uNj
         Wk1sYAgvxoKd34/wYFhjG7SJesknlaoj2xk8i5oi0yyhqeh1yT7g/DJ/0oNL35e2pSNm
         o4TAZhYcE7MIiy3i6QJnSB+jEz807kMfpk3QSPin8RdwU5J56IZwKkO5JbsU33vNhPXI
         9c6w==
X-Gm-Message-State: AC+VfDyv5pvrnKOBY5WISp06znt0+KTn+wDcikiznQahjH1mJuAOUZvB
        c6kjgY23CqHIy9KMiJOBuvG7qQ==
X-Google-Smtp-Source: ACHHUZ6vAi6Y3g8TdEqafnS+y9IbU+RTnliBu7VGQb+/9r2d/tK73wImW6vOpHdU9YlDstOdwgsqsg==
X-Received: by 2002:a05:6a21:2d8a:b0:ee:73bf:425d with SMTP id ty10-20020a056a212d8a00b000ee73bf425dmr3288313pzb.39.1683329059346;
        Fri, 05 May 2023 16:24:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:e1a8:5a47:8ccc:adb3])
        by smtp.gmail.com with ESMTPSA id c1-20020aa781c1000000b0062e0010c6c1sm2070080pfn.164.2023.05.05.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 16:24:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: google: Don't use devm for hid_hw_stop()
Date:   Fri,  5 May 2023 16:24:16 -0700
Message-ID: <20230505232417.1377393-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We (ChromeOS) got a syzkaller report of a KASAN use after free read in
hidinput_find_key(). The callstack is from evdev_ioctl() calling
hidinput_setkeycode():

 __asan_report_load4_noabort+0x44/0x50
 hidinput_find_key+0x25c/0x340
 hidinput_locate_usage+0x31c/0x400
 hidinput_setkeycode+0x70/0x460
 input_set_keycode+0xd4/0x3f8
 evdev_do_ioctl+0x2508/0x6678
 evdev_ioctl_handler+0x12c/0x180
 evdev_ioctl+0x40/0x54

The memory being read was allocated during hammer_probe() by
hid_open_report():

 Allocated by task 19025:
 kasan_save_stack+0x38/0x68
 __kasan_kmalloc+0x90/0xac
 __kmalloc+0x27c/0x45c
 hid_add_field+0x4b0/0x125c
 hid_parser_main+0x214/0x994
 hid_open_report+0x388/0x7a8
 hammer_probe+0x80/0x698 [hid_google_hammer]

and the memory was freed by hid_close_report() called from
hid_destroy_device().

 Freed by task 19025:
 kasan_save_stack+0x38/0x68
 kasan_set_track+0x28/0x3c
 kasan_set_free_info+0x28/0x4c
 ____kasan_slab_free+0x110/0x164
 __kasan_slab_free+0x18/0x28
 kfree+0x208/0x950
 hid_close_report+0xd0/0x29c
 hid_device_remove+0x104/0x198
 device_release_driver_internal+0x204/0x400
 device_release_driver+0x30/0x40
 bus_remove_device+0x2a0/0x390
 device_del+0x49c/0x858
 hid_destroy_device+0x78/0x11c
 usbhid_disconnect+0xb4/0x100
 usb_unbind_interface+0x178/0x6f4
 device_release_driver_internal+0x240/0x400
 device_release_driver+0x30/0x40
 bus_remove_device+0x2a0/0x390

The memory that's being read by the ioctl is an HID report that's been
freed when the HID device is destroyed because the usb interface is
unbound. In hid_device_remove() we assume that the hid report can be
closed with hid_close_report() after the hid_driver is unbound, which is
generally safe because the driver should have stopped the hardware with
hid_hw_stop() when it was unbound. In fact, hid_device_remove() falls
back to calling hid_hw_stop() directly if the hid driver doesn't have a
remove() function, so the assumption is that hid_hw_stop() has been
called once the hid_driver::remove() function returns. hid_hw_stop()
will eventually call hidinput_disconnect() which will unregister the
hidinput device; ensuring that userspace can't call ioctls on the
hidinput device when hid_hw_stop() returns.

Unfortunately, the hid google hammer driver hand rolls a devm function
to call hid_hw_stop() when the driver is unbound and implements an
hid_driver::remove() function. The driver core doesn't call the devm
release functions until _after_ the bus unbinds the driver, so the order
of operations is like this:

  __device_release_driver()
   ...
   device_remove(dev)
    hid_device_remove(hdev)
      hdrv->remove(hdev);
      hid_close_report(hdev)  <---- Frees the report
   device_unbind_cleanup(dev)
    devres_release_all(dev)
      ...
      hid_hw_stop(hdev) <--- Removes the hid_input device

We want the order of operations to be hid_hw_stop() and then
hid_close_report() so that the report can be freed without the hid_input
device hanging around attempting to deref the report. Remove the hand
rolled devm function and call hid_hw_stop() from the hammer_remove()
function to fix the ordering.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: d950db3f80a8 ("HID: google: switch to devm when registering keyboard backlight LED")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 7ae5f27df54d..e7f7c3c68747 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -495,11 +495,6 @@ static void hammer_get_folded_state(struct hid_device *hdev)
 	kfree(buf);
 }
 
-static void hammer_stop(void *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static int hammer_probe(struct hid_device *hdev,
 			const struct hid_device_id *id)
 {
@@ -520,10 +515,6 @@ static int hammer_probe(struct hid_device *hdev,
 	if (error)
 		return error;
 
-	error = devm_add_action(&hdev->dev, hammer_stop, hdev);
-	if (error)
-		return error;
-
 	/*
 	 * We always want to poll for, and handle tablet mode events from
 	 * devices that have folded usage, even when nobody has opened the input
@@ -533,8 +524,10 @@ static int hammer_probe(struct hid_device *hdev,
 	if (hammer_has_folded_event(hdev)) {
 		hdev->quirks |= HID_QUIRK_ALWAYS_POLL;
 		error = hid_hw_open(hdev);
-		if (error)
+		if (error) {
+			hid_hw_stop(hdev);
 			return error;
+		}
 
 		hammer_get_folded_state(hdev);
 	}
@@ -576,7 +569,8 @@ static void hammer_remove(struct hid_device *hdev)
 		spin_unlock_irqrestore(&cbas_ec_lock, flags);
 	}
 
-	/* Unregistering LEDs and stopping the hardware is done via devm */
+	/* Unregistering LEDs is done via devm */
+	hid_hw_stop(hdev);
 }
 
 static const struct hid_device_id hammer_devices[] = {

base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
-- 
https://chromeos.dev

