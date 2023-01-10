Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64BD664F17
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjAJWtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjAJWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:48:39 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053F6719C;
        Tue, 10 Jan 2023 14:48:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id az20so13441174ejc.1;
        Tue, 10 Jan 2023 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34537CkeJxWsVZTQczdlqXJHFUpRJcXE3fQV9p0bzUg=;
        b=PNUReIF07qSG+ocQwY+s1juEWesK6/5LrWPlYzQ21yXgQpHG/QbTpbc8KPHbfhU8e4
         GwAMVVlIN6v1tI/NaRUHbLd8rsgUsUPBDgauXXIH7jOKYV2bR+G8KBVv0ksPW6c6R0PS
         OncT8Vqj4Q9rLEFMuq4alVENilvR3XDc34yjQr84YOpynusT+GbSDVbYy49ZtH6K9AJ9
         OxDbxZpBh9KW7XlU0HefKpr2rFKL4qGGsMzUJvBXc+bQwI8aMwDx4XRA+EPHgOZuH/ll
         1W2mZa1Bh3dbkR9RB5a5Tl69KZWGt6BRGg0EWTWmq7ykmofufuqmJnmdqWF1br/NR1aL
         rYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34537CkeJxWsVZTQczdlqXJHFUpRJcXE3fQV9p0bzUg=;
        b=HOm/1UTGWOMBRxCJTJ34bjixHnB82QK36PyyfH4PnxpfRuJXwg9szBzK8leqCnX5Ri
         N++/1NRZtqbxI94Bra2s0RYVUWTjFME0M4cjjHwgvaoo9q18HU1TgrkmJGf7z651FzqO
         a4fvCcRBsSc4C5lfLxBfGUXlQACLA5l10cVxj75WEExRcITOrpTvUr2cQzKth1XmgbML
         uzMMht75IdtqfzJckugtwIjjO0bRcpDagv9qxK2zg6BFfTC8hSto4uo7iZewPNfMyyA4
         3ceKnEKgblDVoQwYPmNu/StS5BFpeHNx7lSBLFh6QFI4Xj9mInlWDhhwLUiWUlDFM4bR
         iQ/Q==
X-Gm-Message-State: AFqh2kr4Za402jp/TDp1nBTjjkDAY8JXx3tlPxOKPnkVvfZi+X/0zNC9
        Yj/JaWskNYzI+317JTUdR20=
X-Google-Smtp-Source: AMrXdXtPyQ+UIS58yTdikDdyh24fXmuwCQoPersO6sapASu5nkMEgllGtSMMGT9r2bNeTDpEbENrTg==
X-Received: by 2002:a17:907:2587:b0:7c0:ac4b:8b9 with SMTP id ad7-20020a170907258700b007c0ac4b08b9mr50615437ejc.14.1673390917289;
        Tue, 10 Jan 2023 14:48:37 -0800 (PST)
Received: from localhost.localdomain ([46.211.6.169])
        by smtp.googlemail.com with ESMTPSA id d14-20020a170906304e00b0077077c62cadsm5462089ejd.31.2023.01.10.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:48:36 -0800 (PST)
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
Subject: [PATCH v3 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI method
Date:   Wed, 11 Jan 2023 00:48:22 +0200
Message-Id: <20230110224823.14524-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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
v1:
  Rename each_port_arg to each_device_arg
  Rename nct6775_find_asus_acpi to nct6775_asuswmi_device_match
  Remove unrequired return -EEXIST, and iterate whole list of devices
  Make asus_acpi_dev static
v2:
  Restore break iteration logic in nct6775_asuswmi_device_match
  Add config check if ACPI disabled and acpi_device_* are undefined
  Pass device_id as data parameter of acpi_bus_for_each_dev

>> Also, the use of a static variable makes me wonder: would asus_acpi_dev
   be the same for both chips if there are two Super-IO chips in the system ?

Available B550/X570/B650/B660/X670 firmwares have contained only one device 
with WMBD method and provided proxy only to 0x0270 port. Difference between 
board generation is only in name of the such device.

 drivers/hwmon/Kconfig            |  2 +-
 drivers/hwmon/nct6775-platform.c | 97 ++++++++++++++++++++++----------
 2 files changed, 69 insertions(+), 30 deletions(-)

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
index bf43f73dc835..082f48785999 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/wmi.h>
 
 #include "nct6775.h"
 
@@ -107,40 +106,48 @@ struct nct6775_sio_data {
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
+/*
+ * ASUS boards have only one device with WMI "WMBD" method and have provided
+ * access to only one SuperIO chip at 0x0290.
+ */
+static struct acpi_device *asus_acpi_dev;
 
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
-
-	kfree(obj);
+		*retval = (u32)result & 0xFFFFFFFF;
 
-	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
-		return -ENODEV;
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -1099,6 +1106,46 @@ static const char * const asus_wmi_boards[] = {
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
@@ -1109,7 +1156,6 @@ static int __init sensors_nct6775_platform_init(void)
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
 	const char *board_vendor, *board_name;
-	u8 tmp;
 
 	err = platform_driver_register(&nct6775_driver);
 	if (err)
@@ -1122,15 +1168,8 @@ static int __init sensors_nct6775_platform_init(void)
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

