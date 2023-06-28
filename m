Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED4F7419D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjF1UnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjF1Um7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:42:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E3F19B0;
        Wed, 28 Jun 2023 13:42:58 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b71eef1bc0so71708a34.2;
        Wed, 28 Jun 2023 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687984977; x=1690576977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqlJ5JlG8i8Z4ZEnVs4+m1XuwLd946F1VZ0OC/IFAj8=;
        b=dy1w3MLQ6LQ3dyJunyGKMLumz0Sdg68bs/UbUWorYVpOxPpSFLIdFfb59iTSlJCmkl
         GmW2zEA+d9eN9bTf1RVy4tOXlw38xEHpJaKT2VpC+ALjVIHa1FpcMBTkn5lGbrXkWyNv
         IKHIF7/LeITaVpU0XPPKUb1x6ydBqCV7tKuqr+T625wyYCaiAhhRAXb/yYYn6x0IlAb+
         hz6gz2G6xxKlWrR+PaY7MMhjJQ2KdimaAJDwZbToD5H4jz1HBmtNme53NRII5u7Mz5oA
         DDW92KzukbBO52VgAM6GmEm8JliEcFYI7RdEpekFPDFNWwM9RyqNoR1QEKBy5eyzwNKG
         NFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984977; x=1690576977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqlJ5JlG8i8Z4ZEnVs4+m1XuwLd946F1VZ0OC/IFAj8=;
        b=YveYBWZsDLiC+8ZypbgvBXJ3MeJ5cFWo4uQn4LYHG40mYUUJh+38xjvar5fCAduuqs
         ZOrIwyvOMXy7LQNRV6CUyWzrf8ju3wroATv6c0wCDxiVQ325LBp00HAHjeE768F7qc6M
         hFTEV/8dYkRBxr44eM6/Vj6WgYCpZyNE2Js2mF0q8o6kYHRsdjPC9m+1SMaLO9Tt4qJd
         cl9cln96WHFYXQehMOG7Hd08EzaXgXJ1SZPjp5AHwNzn1Bv8/5s++hwS5999NUPrSois
         joz/SZrpHkW8W2BHPyOAtRavWjyIqLJojnN0hDUUkSTSlEy73i5HXJ5/bUoTaoGLZzeT
         0JJA==
X-Gm-Message-State: AC+VfDydtuXoYAZqaM8sAIWGKLaJq5aZh2GQIzbys2fpXPgFeiUkZSEo
        KPffJ+BTWUIxiYzEZPgmQCpzZeKeugM=
X-Google-Smtp-Source: ACHHUZ7y9l1tWhJ+Dj39NisK3y0lmmYkUN6vU2ho2v/gD4qFZhsWIL7W4OeP4bSg2qWvEsHYe+lqYQ==
X-Received: by 2002:a05:6808:2a5c:b0:3a1:de5c:3279 with SMTP id fa28-20020a0568082a5c00b003a1de5c3279mr8975185oib.14.1687984977188;
        Wed, 28 Jun 2023 13:42:57 -0700 (PDT)
Received: from policorp.cardume.local ([177.91.232.54])
        by smtp.gmail.com with ESMTPSA id n7-20020aca2407000000b0039eb5f4543csm5025951oic.34.2023.06.28.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:42:56 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] platform/x86: wmi: add Positivo WMI key driver
Date:   Wed, 28 Jun 2023 18:40:15 -0300
Message-Id: <20230628214015.68558-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function keys on the built in keyboard on Positivo's notebooks does
not produce any key events when pressed in combination with the function
key. Some of these keys do report that they are being pressed via WMI
events.

This driver reports key events for Fn+F10,Fn+F11  and a custom key to
launch a custom program.

Other WMI events that are reported by the hardware but not utilized by
this driver are Caps Lock(which already work).

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/platform/x86/Kconfig        |  11 +++
 drivers/platform/x86/Makefile       |   1 +
 drivers/platform/x86/positivo-wmi.c | 136 ++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/platform/x86/positivo-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 22052031c719..f3ad84479460 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -134,6 +134,17 @@ config YOGABOOK_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called lenovo-yogabook-wmi.
 
+config POSITIVO_WMI
+	tristate "Positivo WMI key driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for Positvo WMI hotkeys.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called positivo-wmi.
+
 config ACERHDF
 	tristate "Acer Aspire One temperature and fan driver"
 	depends on ACPI && THERMAL
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2cafe51ec4d8..5458bb9a56d3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
 obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
 obj-$(CONFIG_YOGABOOK_WMI)		+= lenovo-yogabook-wmi.o
+obj-$(CONFIG_POSITIVO_WMI)		+= positivo-wmi.o
 
 # Acer
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
diff --git a/drivers/platform/x86/positivo-wmi.c b/drivers/platform/x86/positivo-wmi.c
new file mode 100644
index 000000000000..5fbb4cf42154
--- /dev/null
+++ b/drivers/platform/x86/positivo-wmi.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* WMI driver for Positivo Laptops
+ *
+ * Copyright (C) 2023 Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
+ * 
+ * */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/dmi.h>
+#include <linux/module.h>
+
+MODULE_AUTHOR("Edson Juliano Drosdeck");
+MODULE_DESCRIPTION("Positivo WMI Hotkey Driver");
+MODULE_LICENSE("GPL");
+
+#define POSITIVO_WMI_EVENT_GUID "ABBC0F72-8EA1-11D1-00A0-C90629100000"
+
+MODULE_ALIAS("wmi:"POSITIVO_WMI_EVENT_GUID);
+
+static const struct key_entry positivo_wmi_keymap[] = {
+	{ KE_KEY, 0x1c, { KEY_PROG1} },
+	{ KE_KEY, 0x36, { KEY_WLAN } },
+	{ KE_KEY, 0x37, { KEY_BLUETOOTH } },
+	{ KE_END, 0},
+};
+
+static struct input_dev *positivo_wmi_input_dev;
+
+static void positivo_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	int eventcode;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		pr_err("bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
+		eventcode = obj->integer.value;
+
+		if (!sparse_keymap_report_event(positivo_wmi_input_dev,
+						eventcode, 1, true))
+			pr_err("Unknown key %x pressed\n", eventcode);
+	}
+
+	kfree(response.pointer);
+}
+
+static int positivo_wmi_input_setup(void)
+{
+
+	int err;
+
+	positivo_wmi_input_dev = input_allocate_device();
+	if (!positivo_wmi_input_dev)
+		return -ENOMEM;
+
+	positivo_wmi_input_dev->name = "Positivo laptop WMI hotkeys";
+	positivo_wmi_input_dev->phys = "wmi/input0";
+	positivo_wmi_input_dev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(positivo_wmi_input_dev,
+				  positivo_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+	
+	err = input_register_device(positivo_wmi_input_dev);
+	
+	if (err){
+		pr_info("Unable to register input device\n");
+		goto err_free_dev;
+	}
+
+	return 0;
+
+err_free_dev:
+	input_free_device(positivo_wmi_input_dev);
+	return err;
+}
+
+static const struct dmi_system_id positivo_wmi_dmi_table[] __initconst = {
+	{
+		.ident = "Positivo laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+		},
+	},
+	{}
+};
+
+static int __init positivo_wmi_init(void)
+{
+	int err;
+
+	if (!wmi_has_guid(POSITIVO_WMI_EVENT_GUID) ||
+	    !dmi_check_system(positivo_wmi_dmi_table))
+		return -ENODEV;
+
+	err = positivo_wmi_input_setup();
+	if (err)
+		return err;
+
+	err = wmi_install_notify_handler(POSITIVO_WMI_EVENT_GUID,
+					positivo_wmi_notify, NULL);
+		if (ACPI_FAILURE(err)) {
+			pr_err("Unable to setup WMI notify handler\n");
+			goto err_free_input;
+		}
+
+	return 0;
+
+err_free_input:
+	input_unregister_device(positivo_wmi_input_dev);
+	return err;
+
+}
+
+static void __exit positivo_wmi_exit(void)
+{
+       wmi_remove_notify_handler(POSITIVO_WMI_EVENT_GUID);
+       input_free_device(positivo_wmi_input_dev);
+}
+
+module_init(positivo_wmi_init);
+module_exit(positivo_wmi_exit);
-- 
2.39.2

