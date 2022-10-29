Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247D6122BF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJ2MFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJ2ME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F56264D;
        Sat, 29 Oct 2022 05:04:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so9742786wrh.1;
        Sat, 29 Oct 2022 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGXCA0Znhtrtl7WIWCmuh0pNAj0t973nks/+SqSOkMk=;
        b=Kq8d9swEZJC+nW0K/BpjOuYHo34ZPHFZEu1GdCBJ2Ryp6xRclVEF8I5xy5YRvHJkea
         Zc3lRb5iduKxGyXp5ZVk90Qt6j1cLtyfl69DYFhj/P5dLwu0AbkBWyOJunzG14QgX+ZR
         UpuXyr3ukJ/J+uv2Hq2eBNlWGFH67LA+aU/L3pDs8JBiXiIq9M1SfwptnHLJqHyWEilr
         EHIhivbySeLMFSwx2a7hSPIiKQqPEtKpbqbQ+EbiElZ+Jk3upszJSrN0k5E5417rgK/L
         qwIktXArFlXrqJrtW4jGoMQ4bXI0igdrJ7b+Gut0bglwfLP9DLWSoUQCvrSvUfyyV7o/
         +Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGXCA0Znhtrtl7WIWCmuh0pNAj0t973nks/+SqSOkMk=;
        b=uJ06JhYMcyuRTo7XWFD2yrE9g3tLZ9EBCQQ/ltLHgruNMydvPpl/Dqvw8ttKobtZND
         jq/8xVfV6X8bWl54WAzPI6uIEvScatBHj/wJcI/rHBPOwWv2gPjTAJlhkYFObBAFOSOM
         crOVkY6dhnsh/A6qxwp+aCBZfzshBr3qaIINJ9AP90Q4xhw1s921IfSkZZU5EdK4Za7e
         MEjZ0G06OvJR75japOK6ztNmNAo2CXPiaVfpEdff16rRCsFPLaSNcowq/mfVfDKm5Mng
         CoVTT1BDx6WcXP+xrQGslniocg/VYDFMluvL1/g7b/2b+CshF4xrueMMVqefCfHyoIsV
         OPPA==
X-Gm-Message-State: ACrzQf31u6Wcpaz7Fc3RqZ1n1y35UpzQKcPoWTRD7JYS2Vy+A9q1/C3S
        HKvnolSAvCS9SwKuB49iWSeCYTSJkAAicg==
X-Google-Smtp-Source: AMsMyM7ZorsaTFpTIFUl8LTrz6j44QvR1x8lObMqc3pbgW+78LO5dep6owdwXzTEEDymMGOkEEHYGw==
X-Received: by 2002:a05:6000:184:b0:236:7685:7e6d with SMTP id p4-20020a056000018400b0023676857e6dmr2196773wrx.305.1667045073003;
        Sat, 29 Oct 2022 05:04:33 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:32 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 5/7] platform/x86: ideapad-laptop: Expose camera_power only if supported
Date:   Sat, 29 Oct 2022 15:03:10 +0300
Message-Id: <20221029120311.11152-6-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029120311.11152-1-erayorcunus@gmail.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/platform/x86/ideapad-laptop.c | 52 ++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index f3d4f2beda07..e8c088e7a53d 100644
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
@@ -163,6 +164,24 @@ static bool no_bt_rfkill;
 module_param(no_bt_rfkill, bool, 0444);
 MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
 
+static acpi_status acpi_find_device_callback(acpi_handle handle, u32 level,
+					     void *context, void **return_value)
+{
+	struct acpi_buffer ret_buf;
+	char buffer[8];
+
+	ret_buf.length = sizeof(buffer);
+	ret_buf.pointer = buffer;
+
+	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &ret_buf)))
+		if (strstarts(ret_buf.pointer, context)) {
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
@@ -675,7 +694,7 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
 	bool supported = true;
 
 	if (attr == &dev_attr_camera_power.attr)
-		supported = test_bit(CFG_CAP_CAM_BIT, &priv->cfg);
+		supported = priv->features.cam_ctrl_via_ec;
 	else if (attr == &dev_attr_conservation_mode.attr)
 		supported = priv->features.conservation_mode;
 	else if (attr == &dev_attr_fan_mode.attr)
@@ -1527,6 +1546,37 @@ static void ideapad_check_features(struct ideapad_private *priv)
 
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
+		acpi_handle temp_handle = NULL;
+		acpi_handle pci_handle;
+		acpi_status status;
+
+		status = acpi_get_handle(handle, "^^^", &pci_handle);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_walk_namespace(ACPI_TYPE_DEVICE, pci_handle,
+						     ACPI_UINT32_MAX,
+						     acpi_find_device_callback,
+						     NULL, "CAM",
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

