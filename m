Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904460E836
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiJZTDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiJZTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:03:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2E11DA82;
        Wed, 26 Oct 2022 12:01:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t25so18503018ejb.8;
        Wed, 26 Oct 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2j3t4nzz6tQaWHbnOlMhCLHOCykeeAlsKmfrUyBz6w=;
        b=NCpLWkzFShB30f3P4o1tkFIZDJmYS508r1ad45rK4svollxncCgIHEQUWA8f6gmsQS
         x/kvSEEv+3qply4jnOvgfRkJRVnoktjgmZRHyioHo6MvsvZSZMRZgXrnwhglg5EhhIlj
         rXzyDcPYWJ6AJ1SOD/isCJ548FTqbKy62e74QH1WQfJlxFdJ78YFeKkuBVnx2WoAFBDz
         X5UDHT+Z3wgsGOt+YYky8KRbTQs7PeAaXPavQryBu52IBVRjXn5WhhPpqysUDDS1NMA9
         kkZ+1sBSUNHcxUFBmcOVMKrZhdQBea/JOgdJRwSPiNuUU/dPhpwbF2Ih+aFZoUnoUJAy
         MS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2j3t4nzz6tQaWHbnOlMhCLHOCykeeAlsKmfrUyBz6w=;
        b=Mx50uqLjhzaFSl6UUev9hdOMPaWvxeBQu9DxEt5HDRDcvpT1umiULnPcmJ3bwMRKCC
         P6nvfUUSDXdC1IVGx6RrCDYoMhee1LFZ4vtfzCVQjzq9tud3iS6GmS5WitcpetH+fXNu
         W2wAytpKdEzTSmjKew8Ertuq8adqwb4H5GVwY2r0IAqSFpQFAahz63CkInFryVJpctGo
         f+ej6o9hdr8Qih+f4zId2EsPRHOBpM6pNPzsanmXpITJlT4SFpSV80KK96K3J3BK9MWe
         cX5pZpI4z543F71exLL5pP74b5yDpmVQIN72G2TLWkpbR0sugT9rdUPDe89JBBPdbuXA
         5xVw==
X-Gm-Message-State: ACrzQf12PZ520TUtqucNmFIrUg2tS5vldlAaQ4BPR9tq1HxomZRMHPgS
        c9UkgNQOTt4KftcYQP+zVkHfKZV91uOtOQ==
X-Google-Smtp-Source: AMsMyM5HXhmxF3z1Ji/B3FGA4nTMPZdTtf+/Xe7/UxuKO3cTq/ZyVGtipPEM14naxXtubzd/iW5evw==
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e3 with SMTP id xc10-20020a170907074a00b0077e9455b4e3mr39556945ejb.471.1666810875816;
        Wed, 26 Oct 2022 12:01:15 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:15 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 5/6] platform/x86: ideapad-laptop: Expose camera_power only if supported
Date:   Wed, 26 Oct 2022 22:01:05 +0300
Message-Id: <20221026190106.28441-6-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026190106.28441-1-erayorcunus@gmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IdeaPads dropped support for VPCCMD_W_CAMERA somewhere between 2014-2016,
none of the IdeaPads produced after that I tested supports it. Fortunately
I found a way to check it; if the DSDT has camera device(s) defined, it
shouldn't have working VPCCMD_W_CAMERA, thus camera_power shouldn't be
exposed to sysfs. To accomplish this, walk the ACPI namespace in
ideapad_check_features and check the devices starting with "CAM".
Tested on 520-15IKB and Legion Y520, which successfully didn't expose
the camera_power attribute.

Link: https://www.spinics.net/lists/platform-driver-x86/msg26147.html
Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 53 ++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index f3d4f2beda07..65eea2e65bbe 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -149,6 +149,7 @@ struct ideapad_private {
 		bool fn_lock              : 1;
 		bool hw_rfkill_switch     : 1;
 		bool kbd_bl               : 1;
+		bool cam_ctrl_via_ec      : 1;
 		bool touchpad_ctrl_via_ec : 1;
 		bool usb_charging         : 1;
 	} features;
@@ -163,6 +164,26 @@ static bool no_bt_rfkill;
 module_param(no_bt_rfkill, bool, 0444);
 MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
 
+static char *cam_device_prefix = "CAM";
+
+static acpi_status acpi_find_device_callback(acpi_handle handle, u32 level,
+					     void *context, void **return_value)
+{
+	char buffer[8];
+	struct acpi_buffer ret_buf;
+
+	ret_buf.length = sizeof(buffer);
+	ret_buf.pointer = buffer;
+
+	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &ret_buf)))
+		if (strncmp(ret_buf.pointer, context, strlen(context)) == 0) {
+			*return_value = handle;
+			return AE_CTRL_TERMINATE;
+		}
+
+	return AE_OK;
+}
+
 /*
  * ACPI Helpers
  */
@@ -675,7 +696,7 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
 	bool supported = true;
 
 	if (attr == &dev_attr_camera_power.attr)
-		supported = test_bit(CFG_CAP_CAM_BIT, &priv->cfg);
+		supported = priv->features.cam_ctrl_via_ec;
 	else if (attr == &dev_attr_conservation_mode.attr)
 		supported = priv->features.conservation_mode;
 	else if (attr == &dev_attr_fan_mode.attr)
@@ -1523,10 +1544,40 @@ static const struct dmi_system_id hw_rfkill_list[] = {
 static void ideapad_check_features(struct ideapad_private *priv)
 {
 	acpi_handle handle = priv->adev->handle;
+	acpi_handle pci_handle;
+	acpi_handle temp_handle = NULL;
 	unsigned long val;
+	acpi_status status;
 
 	priv->features.hw_rfkill_switch = dmi_check_system(hw_rfkill_list);
 
+	/*
+	 * Some IdeaPads have camera switch via EC (mostly older ones),
+	 * some don't. Fortunately we know that if DSDT contains device
+	 * object for the camera, camera isn't switchable via EC.
+	 * So, let's walk the namespace and try to find CAM* object.
+	 * If we can't find it, set cam_ctrl_via_ec to true.
+	 */
+
+	priv->features.cam_ctrl_via_ec = false;
+
+	if (test_bit(CFG_CAP_CAM_BIT, &priv->cfg)) {
+		status = acpi_get_handle(handle, "^^^", &pci_handle);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_walk_namespace(ACPI_TYPE_DEVICE, pci_handle,
+						     ACPI_UINT32_MAX,
+						     acpi_find_device_callback,
+						     NULL, cam_device_prefix,
+						     &temp_handle);
+
+			if (ACPI_SUCCESS(status) && temp_handle == NULL)
+				priv->features.cam_ctrl_via_ec = true;
+
+		} else
+			dev_warn(&priv->platform_device->dev,
+				"Could not find PCI* node in the namespace\n");
+	}
+
 	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
 	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
 
-- 
2.34.1

