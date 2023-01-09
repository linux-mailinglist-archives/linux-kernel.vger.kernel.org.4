Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56A662751
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjAINj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjAINia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:38:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF991392F7;
        Mon,  9 Jan 2023 05:36:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so20150611ejc.4;
        Mon, 09 Jan 2023 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UcQHq5l0wpBjI+AxrKEaHx72O2ku65M7tu8mRiPq9ms=;
        b=R37BRnLrURr51HoEOBwZgPNTFhrBBnEi0ZKJgN0A3WdBrLqegypW2eCr5y7RUOCbB8
         MyPbFJeTO2oPzmtNZhouHcgWLRNko0/1CuH+eMI8KfZT4PllyIluO0k1tivUMMs1EQbz
         XmYrzrL4IhLqVFM+H/hih3Oie1W0XeKJbaudSrRvsy8lM96PdQZxXWCk/VPG3giZZFeS
         j4N2g/53Iby/mzChLwG9vI5wRykvjN1YmPwS2vM0rm3VJa0UZ11+MgEJ/VwpR0A/IKwL
         OavtL1eSIto/IFnl53cnSGgO1bgUEg7XzCzwl4FTIyGTgc+zq+adZKZvsaXfE7zTpot6
         zIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcQHq5l0wpBjI+AxrKEaHx72O2ku65M7tu8mRiPq9ms=;
        b=K9UiMJ5kUnOHSzKZPu4xloqYRamMcoaKBBuwUTk2L9xNOPWm03mKIgLH/bZP5ze9hI
         S+pMJuWnC5lUE1vTze4o3Ge3abJHkxNiX7TVg/Cb7YEAGKxy3dYgzz9Vb6itRLNYa2zg
         gFO2GGq6RgIfwCd9D+FFqfUlgAf4btp8dW7oXtd5LnQZwMxcBxVXcOVuzBJRNrP3nBeD
         oC60FgFw1EJ80OHPZ6RPcbHrOY9E/piy3dOc0qdPCt6lRmo9Ytz4MqF9peWOZ2lP42Xj
         VwjNjw5GtdVt63eohfCb1YQbGA7TxI6WRHsF94xnUhxGOhhlLhpk3z0maqRFecQZFwEW
         hZ0w==
X-Gm-Message-State: AFqh2koB9ihHEt0dKdvb5dsxG8KDQp9raWIVKUY9q47gqDVUhPuMO8lR
        RDqt8PhsOL5fgLHogHknpybP0JcgzGpAew==
X-Google-Smtp-Source: AMrXdXsOYTedM5hrecM23aIPeO2XUguMYbE7bhqA5atfiTMQLzwwNGrbDeZAZadQB9JBQkJLjhiLBA==
X-Received: by 2002:a17:906:9c8e:b0:7c1:4a3a:dc97 with SMTP id fj14-20020a1709069c8e00b007c14a3adc97mr68688573ejc.0.1673271376849;
        Mon, 09 Jan 2023 05:36:16 -0800 (PST)
Received: from localhost.localdomain ([46.211.15.47])
        by smtp.googlemail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm812918ejb.99.2023.01.09.05.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:36:16 -0800 (PST)
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
        sebastian.arnhold@posteo.de, sefoci9222@rerunway.com,
        sst@poczta.fm, to.eivind@gmail.com, torvic9@mailbox.org
Subject: [PATCH 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI method
Date:   Mon,  9 Jan 2023 15:35:35 +0200
Message-Id: <20230109133536.5720-1-pauk.denis@gmail.com>
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
 drivers/hwmon/Kconfig            |   2 +-
 drivers/hwmon/nct6775-platform.c | 100 ++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 30 deletions(-)

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
index bf43f73dc835..7f5b430e1e2c 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/wmi.h>
 
 #include "nct6775.h"
 
@@ -107,40 +106,44 @@ struct nct6775_sio_data {
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
+struct acpi_device *asus_acpi_dev;
 
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
@@ -1099,6 +1102,53 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING Z490-PLUS (WI-FI)",
 };
 
+struct each_port_arg {
+	struct acpi_device *adev;
+	const char *match;
+};
+
+/*
+ * Callback for acpi_bus_for_each_dev() to find the
+ * right device by _UID and _HID and stop.
+ * return is an error to exit the loop
+ */
+static int nct6775_find_asus_acpi(struct device *dev, void *data)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	const char *uid = acpi_device_uid(adev);
+	const char *hid = acpi_device_hid(adev);
+	struct each_port_arg *arg = data;
+
+	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) &&
+		uid && !strcmp(uid, arg->match)) {
+		arg->adev = adev;
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+static enum sensor_access nct6775_determine_access(const char *device_uid)
+{
+	struct each_port_arg arg;
+	u8 tmp;
+
+	arg.match = device_uid;
+	acpi_bus_for_each_dev(nct6775_find_asus_acpi, &arg);
+	if (!arg.adev)
+		return access_direct;
+
+	asus_acpi_dev = arg.adev;
+	/* if reading chip id via ACPI succeeds, use WMI "WMBD" method for access */
+	if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
+		pr_info("Using Asus ACPI to access %#x chip.\n", tmp);
+		return access_asuswmi;
+	}
+
+	pr_err("Can't read ChipID by Asus ACPI %s device.\n", device_uid);
+	return access_direct;
+}
+
 static int __init sensors_nct6775_platform_init(void)
 {
 	int i, err;
@@ -1109,7 +1159,6 @@ static int __init sensors_nct6775_platform_init(void)
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
 	const char *board_vendor, *board_name;
-	u8 tmp;
 
 	err = platform_driver_register(&nct6775_driver);
 	if (err)
@@ -1122,15 +1171,8 @@ static int __init sensors_nct6775_platform_init(void)
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

