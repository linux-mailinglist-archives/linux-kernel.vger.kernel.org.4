Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC872850F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjFHQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjFHQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694FE19B;
        Thu,  8 Jun 2023 09:33:26 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-392116ae103so612483b6e.0;
        Thu, 08 Jun 2023 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242005; x=1688834005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ms8uHnHsmA6999WHK/dFtKFqpd3DcGNarvssVUZd3Vc=;
        b=UN1Y7iRfvUqIbvdJF3AJ52h+3PSClb0HnKOfMRTFTLspEZnchJG9KBrv8TJ4bynq/o
         YDI4T2f6zx0cRDvcWZcbqFMDS313TWZHC6dt/e/AdYkWUYC6YPBETgGs8qs2ilB1qRgD
         RcqsFZ25hsBgKlsO6XG5TjFTxqkfsIcbnOlITIlfn2KSEty5O3so757597j3zGkPLF/v
         4+zMJcYTa/0zH0ZM6R4e5Vk/e105H5RdS6Ub5y1j3aFbY2gDzgvuFJBrFJSP48bdwxg1
         /Q/qQTj2tG70tWjWaDcadOvpD0F8Ti8i0qEzJSPlxGjeL4IOCVq+o1CZvjAobbR4PRmP
         alWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242005; x=1688834005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms8uHnHsmA6999WHK/dFtKFqpd3DcGNarvssVUZd3Vc=;
        b=c89kmp2KVvD8S7dx3EvmW9FhRyHg8nk40Q0RjxHXeoQ4f74CQtTM/ylKbsg3YH/1iX
         lmqXVo3oi1+aVE94/j7r2BcqX/MW63gxs/rZOqOBLZGT38idb2ZmEJ1tMdoP5zA52UsI
         syyF9oMLb+jlHD3gfSnXWMGYXYcaCGqU9OU63GDvLBjiTuFcyh2OlNjyJfpz+P0MFnlY
         AA+0CdQNPBaL9EoEJfHamkx7xRuqELIJKUiGvL6Voi258JzARQFmlJwLvKtlP584yTP4
         lD3iVQmYVz5nzFYpiVRl933qFSxevnH9BOW5K/eJYAfM6KYqKBr3OWr+reNsgUK3SdYf
         w6NA==
X-Gm-Message-State: AC+VfDzKT46hCIGalLcjuWvtBWo3/02DNRpA7q4OmFg38IL9ei2BNX+6
        NG2o+tPeZR7No0sr/lTEryw=
X-Google-Smtp-Source: ACHHUZ6693ihosCbTZPmC3dmOHLWvkHCSteS3vLhrH3/qjPYZaQS00ZBtpkT3tBnfCbNhCsuFENIQA==
X-Received: by 2002:a05:6808:9a7:b0:396:1bf6:d781 with SMTP id e7-20020a05680809a700b003961bf6d781mr5591307oig.6.1686242005550;
        Thu, 08 Jun 2023 09:33:25 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:a60f:2d4d:e52b:2fca])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm577500oif.46.2023.06.08.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:33:25 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v17 04/13] hp-bioscfg: biosattr-interface
Date:   Thu,  8 Jun 2023 11:33:10 -0500
Message-Id: <20230608163319.18934-5-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add WMI interface worker functions to hp-bioscfg.

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 312 ++++++++++++++++++
 1 file changed, 312 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
new file mode 100644
index 000000000000..1d59ad600b84
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to methods under BIOS interface GUID
+ * for use with hp-bioscfg driver.
+ *
+ *  Copyright (c) 2022 Hewlett-Packard Inc.
+ */
+
+#include <linux/wmi.h>
+#include "bioscfg.h"
+
+/*
+ * struct bios_args buffer is dynamically allocated.  New WMI command types
+ * were introduced that exceeds 128-byte data size.  Changes to handle
+ * the data size allocation scheme were kept in hp_wmi_perform_query function.
+ */
+struct bios_args {
+	u32 signature;
+	u32 command;
+	u32 commandtype;
+	u32 datasize;
+	u8 data[];
+};
+
+/**
+ * hp_set_attribute
+ *
+ * @a_name: The attribute name
+ * @a_value: The attribute value
+ *
+ * Sets an attribute to new value
+ *
+ * Returns zero on success
+ *	-ENODEV if device is not found
+ *	-EINVAL if the instance of 'Setup Admin' password is not found.
+ *	-ENOMEM unable to allocate memory
+ */
+int hp_set_attribute(const char *a_name, const char *a_value)
+{
+	int security_area_size;
+	int a_name_size, a_value_size;
+	u16 *buffer = NULL;
+	u16 *start;
+	int  buffer_size, instance, ret;
+	char *auth_token_choice;
+
+	mutex_lock(&bioscfg_drv.mutex);
+
+	instance = hp_get_password_instance_for_type(SETUP_PASSWD);
+	if (instance < 0) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	/* Select which auth token to use; password or [auth token] */
+	if (bioscfg_drv.spm_data.auth_token)
+		auth_token_choice = bioscfg_drv.spm_data.auth_token;
+	else
+		auth_token_choice = bioscfg_drv.password_data[instance].current_password;
+
+	a_name_size = hp_calculate_string_buffer(a_name);
+	a_value_size = hp_calculate_string_buffer(a_value);
+	security_area_size = hp_calculate_security_buffer(auth_token_choice);
+	buffer_size = a_name_size + a_value_size + security_area_size;
+
+	buffer = kmalloc(buffer_size + 1, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out_set_attribute;
+	}
+
+	/* build variables to set */
+	start = buffer;
+	start = hp_ascii_to_utf16_unicode(start, a_name);
+	if (!start) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	start = hp_ascii_to_utf16_unicode(start, a_value);
+	if (!start) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	ret = hp_populate_security_buffer(start, auth_token_choice);
+	if (ret < 0)
+		goto out_set_attribute;
+
+	ret = hp_wmi_set_bios_setting(buffer, buffer_size);
+
+out_set_attribute:
+	kfree(buffer);
+	mutex_unlock(&bioscfg_drv.mutex);
+	return ret;
+}
+
+/**
+ * hp_wmi_perform_query
+ *
+ * @query:	The commandtype (enum hp_wmi_commandtype)
+ * @command:	The command (enum hp_wmi_command)
+ * @buffer:	Buffer used as input and/or output
+ * @insize:	Size of input buffer
+ * @outsize:	Size of output buffer
+ *
+ * returns zero on success
+ *         an HP WMI query specific error code (which is positive)
+ *         -EINVAL if the query was not successful at all
+ *         -EINVAL if the output buffer size exceeds buffersize
+ *
+ * Note: The buffersize must at least be the maximum of the input and output
+ *       size. E.g. Battery info query is defined to have 1 byte input
+ *       and 128 byte output. The caller would do:
+ *       buffer = kzalloc(128, GFP_KERNEL);
+ *       ret = hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ,
+ *				    buffer, 1, 128)
+ */
+int hp_wmi_perform_query(int query, enum hp_wmi_command command, void *buffer,
+			 u32 insize, u32 outsize)
+{
+	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct bios_return *bios_return;
+	union acpi_object *obj = NULL;
+	struct bios_args *args = NULL;
+	u32 mid, actual_outsize, ret;
+	size_t bios_args_size;
+
+	mid = hp_encode_outsize_for_pvsz(outsize);
+	if (WARN_ON(mid < 0))
+		return mid;
+
+	bios_args_size = struct_size(args, data, insize);
+	args = kmalloc(bios_args_size, GFP_KERNEL);
+	if (!args)
+		return -ENOMEM;
+
+	input.length = bios_args_size;
+	input.pointer = args;
+
+	/* BIOS expects 'SECU' in hex as the signature value*/
+	args->signature = 0x55434553;
+	args->command = command;
+	args->commandtype = query;
+	args->datasize = insize;
+	memcpy(args->data, buffer, flex_array_size(args, data, insize));
+
+	ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);
+	if (ret)
+		goto out_free;
+
+	obj = output.pointer;
+	if (!obj) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	bios_return = (struct bios_return *)obj->buffer.pointer;
+	ret = bios_return->return_code;
+	if (ret) {
+		if (ret != INVALID_CMD_VALUE && ret != INVALID_CMD_TYPE)
+			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
+		goto out_free;
+	}
+
+	/* Ignore output data of zero size */
+	if (!outsize)
+		goto out_free;
+
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
+	memcpy_and_pad(buffer, outsize, obj->buffer.pointer + sizeof(*bios_return),
+		       actual_outsize, 0);
+
+out_free:
+	ret = hp_wmi_error_and_message(ret);
+
+	kfree(obj);
+	kfree(args);
+	return ret;
+}
+
+static void *utf16_empty_string(u16 *p)
+{
+	*p++ = 2;
+	*p++ = 0x00;
+	return p;
+}
+
+/**
+ * hp_ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
+ *
+ * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
+ * multi-byte language supported.
+ *
+ * @p:   Unicode buffer address
+ * @str: string to convert to unicode
+ *
+ * Returns a void pointer to the buffer string
+ */
+void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str)
+{
+	int len = strlen(str);
+	int ret;
+
+	/*
+	 * Add null character when reading an empty string
+	 * "02 00 00 00"
+	 */
+	if (len == 0)
+		return utf16_empty_string(p);
+
+	/* Move pointer len * 2 number of bytes */
+	*p++ = len * 2;
+	ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, len);
+	if (ret < 0) {
+		dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n");
+		return NULL;
+	}
+
+	if (ret * sizeof(u16) > U16_MAX) {
+		dev_err(bioscfg_drv.class_dev, "Error string too long\n");
+		return NULL;
+	}
+
+	p += len;
+	return p;
+}
+
+/**
+ * hp_wmi_set_bios_setting - Set setting's value in BIOS
+ *
+ * @input_buffer: Input buffer address
+ * @input_size:   Input buffer size
+ *
+ * Returns: Count of unicode characters written to BIOS if successful, otherwise
+ *		-ENOMEM unable to allocate memory
+ *		-EINVAL buffer not allocated or too small
+ */
+int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size)
+{
+	union acpi_object *obj;
+	struct acpi_buffer input = {input_size, input_buffer};
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	int ret;
+
+	ret = wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &input, &output);
+
+	obj = output.pointer;
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	ret = obj->integer.value;
+	if (ret) {
+		ret = hp_wmi_error_and_message(ret);
+		goto out_free;
+	}
+
+out_free:
+	kfree(obj);
+	return ret;
+}
+
+static int hp_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	mutex_unlock(&bioscfg_drv.mutex);
+	return 0;
+}
+
+static void hp_attr_set_interface_remove(struct wmi_device *wdev)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	mutex_unlock(&bioscfg_drv.mutex);
+}
+
+static const struct wmi_device_id hp_attr_set_interface_id_table[] = {
+	{ .guid_string = HP_WMI_BIOS_GUID},
+	{ }
+};
+
+static struct wmi_driver hp_attr_set_interface_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+	},
+	.probe = hp_attr_set_interface_probe,
+	.remove = hp_attr_set_interface_remove,
+	.id_table = hp_attr_set_interface_id_table,
+};
+
+int hp_init_attr_set_interface(void)
+{
+	return wmi_driver_register(&hp_attr_set_interface_driver);
+}
+
+void hp_exit_attr_set_interface(void)
+{
+	wmi_driver_unregister(&hp_attr_set_interface_driver);
+}
+
+MODULE_DEVICE_TABLE(wmi, hp_attr_set_interface_id_table);
-- 
2.34.1

