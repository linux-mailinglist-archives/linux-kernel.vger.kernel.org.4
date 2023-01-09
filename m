Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C259663296
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjAIVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjAIVRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:17:35 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745315F2A;
        Mon,  9 Jan 2023 13:15:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so23504791ejc.3;
        Mon, 09 Jan 2023 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nnBH5ZMjXLF2tH4a7jq3e0DVjx0dsBGBwNvgLnls+0=;
        b=hPjmT+Zn+mbO/HJ41m/tUcyqcqnN+H8Di9Ykb2Aw1SFyMvT9DZs/XtlVjHUaxqyyMU
         bcIsCT6ZLj18iFNMVklbbOzNqfloqeb2rmYUbiOCv9GeppSiiariYban6xJ9PRagZ5Ri
         6EywIyxqxgyXjREbNKj+LVdZ7i42zCDf29lqkUQZ40xW1bXcAQX2aGdOihmYcxIHsgox
         USDoxDQlC1Kw/lBCJrm/bq/csoanwUnAt7OMlaeQJCi8vquOLZxIm8ApQ3ZuDT2mbODg
         y1PL0pQKQMPXoZ0FAQR5as9sa4wKoA0Q9RCv4JkDYlYbuif9K6OZ9t5wSi3qKampUTLP
         jMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nnBH5ZMjXLF2tH4a7jq3e0DVjx0dsBGBwNvgLnls+0=;
        b=BBOOK0PdtWwJvw39yuErzCnZU4UdJlP2nfAdCVAOw6VQ9rRVlx/NwZ89sjHWKpGBnV
         rdFEFWPCrSR5GSywK2z8BeTAJF1R3UeUufdDQqNRj5O4PDj/WlhOJFOv7jP+gJMl7gi4
         /axfCMKcODmaDMtUYO7nHfg4lT4L568HVzYH7896g+x2YLAHG70AmH8wxO9pQ/M5zSo5
         HB/sn9yOQCtLAdOPooHbkiJzFjUrd4Pjkza0R8vxt0oSP5cbOPy4672rvwevuZYYwJ40
         QIpVyhGbaJMQiHcLl7nTsFAVQ9TelIdNr7wy9JJ/Rlsq5JrwzxMhn+k/5wi/7+eT5yVr
         DT2w==
X-Gm-Message-State: AFqh2krcqe2z5/G1dlKfGF3e7wmKRrTTAGt8Wq7aRH3pLcTvmpEKG1Xb
        g7Yh3vOS2H91VR0n4gWKkpY=
X-Google-Smtp-Source: AMrXdXuYM4pGNrBj+U1x1n6y3L3LmWyzLFlfQKgk05DH5CHprzSsXYUghzRluxyEWcxzFpahncI+zQ==
X-Received: by 2002:a17:906:ca56:b0:84d:363c:888b with SMTP id jx22-20020a170906ca5600b0084d363c888bmr7069118ejb.58.1673298936526;
        Mon, 09 Jan 2023 13:15:36 -0800 (PST)
Received: from localhost.localdomain ([46.211.224.63])
        by smtp.googlemail.com with ESMTPSA id ba6-20020a0564021ac600b0045cf4f72b04sm4143824edb.94.2023.01.09.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 13:15:36 -0800 (PST)
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
Subject: [PATCH v2 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI method
Date:   Mon,  9 Jan 2023 23:15:07 +0200
Message-Id: <20230109211508.4969-1-pauk.denis@gmail.com>
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
  rename each_port_arg to each_device_arg
  rename nct6775_find_asus_acpi to nct6775_asuswmi_device_match
  remove unrequired return -EEXIST, and iterate whole list of devices
  make asus_acpi_dev static

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
index bf43f73dc835..1f7885af524e 100644
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
@@ -1099,6 +1102,50 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING Z490-PLUS (WI-FI)",
 };
 
+struct each_device_arg {
+	struct acpi_device *adev;
+	const char *match;
+};
+
+/*
+ * Callback for acpi_bus_for_each_dev() to find the right device
+ * by _UID and _HID and store to each_device_arg.
+ */
+static int nct6775_asuswmi_device_match(struct device *dev, void *data)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	const char *uid = acpi_device_uid(adev);
+	const char *hid = acpi_device_hid(adev);
+	struct each_device_arg *arg = data;
+
+	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) &&
+		uid && !strcmp(uid, arg->match)) {
+		arg->adev = adev;
+	}
+
+	return 0;
+}
+
+static enum sensor_access nct6775_determine_access(const char *device_uid)
+{
+	struct each_device_arg arg;
+	u8 tmp;
+
+	arg.match = device_uid;
+	acpi_bus_for_each_dev(nct6775_asuswmi_device_match, &arg);
+	if (!arg.adev)
+		return access_direct;
+
+	asus_acpi_dev = arg.adev;
+	/* if reading chip id via ACPI succeeds, use WMI "WMBD" method for access */
+	if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) && tmp) {
+		pr_debug("Using Asus WMBD method of %s to access %#x chip.\n", device_uid, tmp);
+		return access_asuswmi;
+	}
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

