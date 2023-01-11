Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09766658B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAKVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjAKVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:23:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B914BB1;
        Wed, 11 Jan 2023 13:23:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z11so24303667ede.1;
        Wed, 11 Jan 2023 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOUpXWIQZVPllnV116T2oRqJpSbva6z4Nv08AK7LaeI=;
        b=g0nLEz5wO+X+wh08R+6Mb6/OJbIARU4vnnbt4JtiBrWCjJplUj4O0SUm14svQDeuEN
         zdm1ZctfsYQuSyPtKisL3mDJp5CpJZzTmuwQi9wdkLnNOHQRVQaxA0aSgP3jgkSSG8cC
         DfkSd/A6ttceyGW1cReQnfbJmn7NBKLJE9wS9ZdUk7aAWVbkBAMoCsFpjKyMvGk4rSsb
         NEwAtK5yVuhPczii4LZH9RvfNqylxq1Dr1nkpB9qzBHwvudehW3jZNYvD50sFGG1Xa7i
         Ohqjn7ycfo29wsUj7AzJqkXE6K/NpwSY4HADYprLtDD0ZfdnrKObzrDwv/e8h80khtDr
         z0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOUpXWIQZVPllnV116T2oRqJpSbva6z4Nv08AK7LaeI=;
        b=hUvkJeW99YiFRg43o6Fyrc3W1fcgxp8ubGzWn1uGBKZX7q7OzQbIU0L1MsSUwa8l8T
         UBAlmUgKbPdjsyy8vU+w2T5FqMoNU+hBcvUit04+5ijgI0GTjaQ+5QgXv7j5/q8QZUWv
         4k22riNJZw0W5hBt1/bodjXTF+OOAuoVsesNdXBykEpzWsk6WuweIxTncpXbXiV0X1GU
         StQtXul9aJt/oDouoPv2dQQHQDbn6ybk7IHANUHXIgY7b/cZfGDJaT/0YwRX2Kp78LyO
         ncMKIoP/kpzBx1hCVPxbTBMBm2XFaxo49I4JFSY8RauwQ/qOEc9wRUViaCjiDwoU5Up3
         KmhA==
X-Gm-Message-State: AFqh2kpVnO7yzv0ytNU9Qw97uH+J/y9DWZtqGNg1Kbb43U3A3Ec8IT96
        q/nCKcgjdH77Zc59+9Hfx3g=
X-Google-Smtp-Source: AMrXdXvJ1kyE6D327ot+PTc7OkAFjXrywdiEXKHA/Fid6j6YBDV8r3c+yRN/aFaKWhGD2/aPcE8P5A==
X-Received: by 2002:a05:6402:3807:b0:47e:eb84:c598 with SMTP id es7-20020a056402380700b0047eeb84c598mr62442473edb.30.1673472184520;
        Wed, 11 Jan 2023 13:23:04 -0800 (PST)
Received: from localhost.localdomain ([46.211.95.50])
        by smtp.googlemail.com with ESMTPSA id s1-20020aa7cb01000000b00463b9d47e1fsm6477588edt.71.2023.01.11.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:23:03 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name,
        pauk.denis@gmail.com, pehlm@pekholm.org, renedis@hotmail.com,
        robert@swiecki.net, sahan.h.fernando@gmail.com,
        sebastian.arnhold@posteo.de, sst@poczta.fm, to.eivind@gmail.com,
        torvic9@mailbox.org
Subject: [PATCH v4 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI method
Date:   Wed, 11 Jan 2023 23:22:40 +0200
Message-Id: <20230111212241.7456-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New ASUS B650/B660/X670 boards firmware have not exposed WMI monitoring
GUID  and entrypoint method WMBD could be implemented for different device
UID.

Implement the direct call to entrypoint method for monitoring the device
UID of B550/X570 boards.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Ahmad Khalifa <ahmad@khalifa.ws>
Signed-off-by: Ahmad Khalifa <ahmad@khalifa.ws>
---
Changes:
v2:
  Rename each_port_arg to each_device_arg
  Rename nct6775_find_asus_acpi to nct6775_asuswmi_device_match
  Remove unrequired return -EEXIST, and iterate whole list of devices
  Make asus_acpi_dev static
v3:
  Restore break iteration logic in nct6775_asuswmi_device_match
  Add config check if ACPI disabled and acpi_device_* are undefined
  Pass device_id as data parameter of acpi_bus_for_each_dev
v4:
  Hide asus_acpi_dev definition inside ifdef ACPI
  
@all
 Could someone please test updated patch with B550/X570 boards?
 
@Guenter Roeck
> 0-day reported various errors. I suspect those are seen with CONFIG_ACPI=n.
> Have you tried the build reported as problematic ?
>
> I get
>
> drivers/hwmon/nct6775-platform.c:122:28: error: ‘asus_acpi_dev’ defined 
>  but not used [-Werror=unused-variable]
>
>   122 | static struct acpi_device *asus_acpi_dev;
>
> if I try to build nct6775-platform.o with W=1 and CONFIG_ACPI=n.
>
> Overall the #ifdefs in the driver get a bit out of hand. I think it
> may be time to consolidate that. Not necessarily now, but sometime soon.

Thank you, I have missed it, I have rechecked with:
make W=1 CONFIG_ACPI=n CONFIG_SENSORS_NCT6775=m drivers/hwmon/ 

 drivers/hwmon/Kconfig            |  2 +-
 drivers/hwmon/nct6775-platform.c | 99 ++++++++++++++++++++++----------
 2 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 3176c33af6c6..300ce8115ce4 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1516,7 +1516,7 @@ config SENSORS_NCT6775_CORE
 config SENSORS_NCT6775
 	tristate "Platform driver for Nuvoton NCT6775F and compatibles"
 	depends on !PPC
-	depends on ACPI_WMI || ACPI_WMI=n
+	depends on ACPI || ACPI=n
 	select HWMON_VID
 	select SENSORS_NCT6775_CORE
 	help
diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index bf43f73dc835..e3c3b35c8138 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/wmi.h>
 
 #include "nct6775.h"
 
@@ -107,40 +106,50 @@ struct nct6775_sio_data {
 	void (*sio_exit)(struct nct6775_sio_data *sio_data);
 };
 
-#define ASUSWMI_MONITORING_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
+#define ASUSWMI_METHOD			"WMBD"
 #define ASUSWMI_METHODID_RSIO		0x5253494F
 #define ASUSWMI_METHODID_WSIO		0x5753494F
 #define ASUSWMI_METHODID_RHWM		0x5248574D
 #define ASUSWMI_METHODID_WHWM		0x5748574D
 #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
+#define ASUSWMI_DEVICE_HID		"PNP0C14"
+#define ASUSWMI_DEVICE_UID		"ASUSWMI"
+
+#if IS_ENABLED(CONFIG_ACPI)
+/*
+ * ASUS boards have only one device with WMI "WMBD" method and have provided
+ * access to only one SuperIO chip at 0x0290.
+ */
+static struct acpi_device *asus_acpi_dev;
+#endif
 
 static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
 {
-#if IS_ENABLED(CONFIG_ACPI_WMI)
+#if IS_ENABLED(CONFIG_ACPI)
+	acpi_handle handle = acpi_device_handle(asus_acpi_dev);
 	u32 args = bank | (reg << 8) | (val << 16);
-	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_object_list input;
+	union acpi_object params[3];
+	unsigned long long result;
 	acpi_status status;
-	union acpi_object *obj;
-	u32 tmp = ASUSWMI_UNSUPPORTED_METHOD;
-
-	status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0,
-				     method_id, &input, &output);
 
+	params[0].type = ACPI_TYPE_INTEGER;
+	params[0].integer.value = 0;
+	params[1].type = ACPI_TYPE_INTEGER;
+	params[1].integer.value = method_id;
+	params[2].type = ACPI_TYPE_BUFFER;
+	params[2].buffer.length = sizeof(args);
+	params[2].buffer.pointer = (void *)&args;
+	input.count = 3;
+	input.pointer = params;
+
+	status = acpi_evaluate_integer(handle, ASUSWMI_METHOD, &input, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	obj = output.pointer;
-	if (obj && obj->type == ACPI_TYPE_INTEGER)
-		tmp = obj->integer.value;
-
 	if (retval)
-		*retval = tmp;
+		*retval = (u32)result & 0xFFFFFFFF;
 
-	kfree(obj);
-
-	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
-		return -ENODEV;
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -1099,6 +1108,46 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING Z490-PLUS (WI-FI)",
 };
 
+#if IS_ENABLED(CONFIG_ACPI)
+/*
+ * Callback for acpi_bus_for_each_dev() to find the right device
+ * by _UID and _HID and return 1 to stop iteration.
+ */
+static int nct6775_asuswmi_device_match(struct device *dev, void *data)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	const char *uid = acpi_device_uid(adev);
+	const char *hid = acpi_device_hid(adev);
+
+	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) &&
+		uid && !strcmp(uid, data)) {
+		asus_acpi_dev = adev;
+		return 1;
+	}
+
+	return 0;
+}
+#endif
+
+static enum sensor_access nct6775_determine_access(const char *device_uid)
+{
+#if IS_ENABLED(CONFIG_ACPI)
+	u8 tmp;
+
+	acpi_bus_for_each_dev(nct6775_asuswmi_device_match, (void *)device_uid);
+	if (!asus_acpi_dev)
+		return access_direct;
+
+	/* if reading chip id via ACPI succeeds, use WMI "WMBD" method for access */
+	if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
+		pr_debug("Using Asus WMBD method of %s to access %#x chip.\n", device_uid, tmp);
+		return access_asuswmi;
+	}
+#endif
+
+	return access_direct;
+}
+
 static int __init sensors_nct6775_platform_init(void)
 {
 	int i, err;
@@ -1109,7 +1158,6 @@ static int __init sensors_nct6775_platform_init(void)
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
 	const char *board_vendor, *board_name;
-	u8 tmp;
 
 	err = platform_driver_register(&nct6775_driver);
 	if (err)
@@ -1122,15 +1170,8 @@ static int __init sensors_nct6775_platform_init(void)
 	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
 		err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
 				   board_name);
-		if (err >= 0) {
-			/* if reading chip id via WMI succeeds, use WMI */
-			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
-				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
-				access = access_asuswmi;
-			} else {
-				pr_err("Can't read ChipID by Asus WMI.\n");
-			}
-		}
+		if (err >= 0)
+			access = nct6775_determine_access(ASUSWMI_DEVICE_UID);
 	}
 
 	/*

base-commit: b0587c87abc891e313d63946ff8c9f4939d1ea1a
-- 
2.39.0

