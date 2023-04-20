Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2C6E99FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDTQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDTQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:55:01 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF21FDA;
        Thu, 20 Apr 2023 09:54:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1842c7c2daaso382433fac.0;
        Thu, 20 Apr 2023 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009699; x=1684601699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TssjylOZexEMAMfaEjdEtOjrRg1jd4qjFlWCipzYcuM=;
        b=k+xlPqDpzwgJNB5ta0Vl8afYIHNFMvzdI5cwPwSmSeIJjF4hA9q0MsYTVVLLDwagDl
         3wEqKowkRlHU9dydZw1tu0Rl/R3VTkTMe7byKG74rDf7v+cOQINYoR8nkvpFJF4S/2XU
         GNUFkQneNw4/6SbGLp0Iqc/WQznVHggmfncwM3LEJHQzkyoPnYydA7Dusb0dzXpoconR
         +amolmojEPtHMGidODiGrevgQJOSgecqW2IcHea5D2SloheKwfyeuRwoK4M1zZtWkJvE
         BAau8tPvXq7TNDgW0xfkHiMX23rk9GH/66yBUqxdPHNQ5E9AiM72Hn3Fowvr81D5FvhO
         +DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009699; x=1684601699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TssjylOZexEMAMfaEjdEtOjrRg1jd4qjFlWCipzYcuM=;
        b=eKigWagP0P6xs1D42/B2qcAvz7Kx+H9Co31gKfUcN8ZnAMHfi4glLUKq2nGp0W/PEC
         7LDUTVk1OsWf6NhAMxV3LfEEvnGgjNyanWZQBohZogEvZ/sFa8YacwPfKIVcppbJ36jW
         h33YPM3UdcTpIckAOItGdeveVUDtyYdeSrOkH2BuHArOA80+XVXFC1ELIspXvfhBGtYj
         QBT5weSiuiuCSlhYXeMnuiL5ABMNyRni1rDwnboBeJfbnSjKfVyCXwePHX33ewj+1BGT
         k8HKCl4hvZ6D5aeEZ0nzSf6YnG74o/mQ5YXTcuFO74L2xHW9AxmT0lq8KWsLfjx8bVLS
         4eIQ==
X-Gm-Message-State: AAQBX9dkmfPDJOEt4EiBWc7AQLumBYjsy+PAGh9wG1CEFFRDs6otlOzh
        LB5adYdF167iCwLGlyKaJuWBF0OU8rk=
X-Google-Smtp-Source: AKy350Z7JkFEDZHxGtBuOpdO71I5SBxmS6uTM414zGWCw/+pGcavHTh4p9a4UV+CkrEowaPixeeCmA==
X-Received: by 2002:a05:6870:828f:b0:187:8189:86ad with SMTP id q15-20020a056870828f00b00187818986admr1666910oae.14.1682009698751;
        Thu, 20 Apr 2023 09:54:58 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:d090:9746:e449:eb46])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm791913ooa.36.2023.04.20.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:54:58 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v11 02/14] HP BIOSCFG driver - biosattr-interface
Date:   Thu, 20 Apr 2023 11:54:42 -0500
Message-Id: <20230420165454.9517-3-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420165454.9517-1-jorge.lopez2@hp.com>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
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

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 307 ++++++++++++++++++
 1 file changed, 307 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
new file mode 100644
index 000000000000..f09dd41867f7
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
@@ -0,0 +1,307 @@
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
+#define SET_DEFAULT_VALUES_METHOD_ID	0x02
+#define SET_BIOS_DEFAULTS_METHOD_ID	0x03
+#define SET_ATTRIBUTE_METHOD_ID		0x04
+
+/*
+ * set_attribute() - Update an attribute value
+ * @a_name: The attribute name
+ * @a_value: The attribute value
+ *
+ * Sets an attribute to new value
+ */
+int hp_set_attribute(const char *a_name, const char *a_value)
+{
+	size_t security_area_size;
+	size_t a_name_size, a_value_size;
+	u16 *buffer = NULL;
+	u16 *start = NULL;
+	int  buffer_size;
+	int ret = 0;
+	int instance;
+	char *auth_empty_value = "";
+	char *auth_token_choice = NULL;
+
+
+	mutex_lock(&bioscfg_drv.mutex);
+	if (!bioscfg_drv.bios_attr_wdev) {
+		ret = -ENODEV;
+		goto out_set_attribute;
+	}
+
+	instance = get_password_instance_for_type(SETUP_PASSWD);
+	if (instance < 0) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	if (strlen(bioscfg_drv.password_data[instance].current_password) == 0)
+		strscpy(bioscfg_drv.password_data[instance].current_password,
+			auth_empty_value,
+			sizeof(bioscfg_drv.password_data[instance].current_password));
+
+	/* Select which auth token to use; password or [auth token] */
+
+	if (bioscfg_drv.spm_data.auth_token != NULL)
+		auth_token_choice = bioscfg_drv.spm_data.auth_token;
+	else
+		auth_token_choice = bioscfg_drv.password_data[instance].current_password;
+
+	a_name_size = bioscfg_calculate_string_buffer(a_name);
+	a_value_size = bioscfg_calculate_string_buffer(a_value);
+	security_area_size = calculate_security_buffer(auth_token_choice);
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
+	start = ascii_to_utf16_unicode(start, a_name);
+	if (!start)
+		goto out_set_attribute;
+
+	start = ascii_to_utf16_unicode(start, a_value);
+	if (!start)
+		goto out_set_attribute;
+
+	populate_security_buffer(start, auth_token_choice);
+
+	ret = hp_wmi_set_bios_setting(buffer, buffer_size);
+
+
+out_set_attribute:
+	kfree(buffer);
+	mutex_unlock(&bioscfg_drv.mutex);
+	return ret;
+}
+
+/*
+ * hp_wmi_perform_query
+ *
+ * query:	The commandtype (enum hp_wmi_commandtype)
+ * write:	The command (enum hp_wmi_command)
+ * buffer:	Buffer used as input and/or output
+ * insize:	Size of input buffer
+ * outsize:	Size of output buffer
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
+			 int insize, int outsize)
+{
+	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct bios_return *bios_return;
+	union acpi_object *obj = NULL;
+	struct bios_args *args = NULL;
+	int mid, actual_outsize;
+	size_t bios_args_size;
+	int ret;
+
+	mid = encode_outsize_for_pvsz(outsize);
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
+	args->signature = 0x55434553;
+	args->command = command;
+	args->commandtype = query;
+	args->datasize = insize;
+	memcpy(args->data, buffer, flex_array_size(args, data, insize));
+
+	ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);
+	bioscfg_wmi_error_and_message(ret);
+
+	if (ret)
+		goto out_free;
+
+	obj = output.pointer;
+	if (!obj) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+	if (query != HPWMI_SECUREPLATFORM_GET_STATE &&
+	    command != HPWMI_SECUREPLATFORM)
+		if (obj->type != ACPI_TYPE_BUFFER ||
+		    obj->buffer.length < sizeof(*bios_return)) {
+			pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+
+	bios_return = (struct bios_return *)obj->buffer.pointer;
+	ret = bios_return->return_code;
+	bioscfg_wmi_error_and_message(ret);
+
+	if (ret) {
+		if (ret != HPWMI_RET_UNKNOWN_COMMAND &&
+		    ret != HPWMI_RET_UNKNOWN_CMDTYPE)
+			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
+		goto out_free;
+	}
+
+	/* Ignore output data of zero size */
+	if (!outsize)
+		goto out_free;
+
+	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
+	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
+
+out_free:
+	kfree(obj);
+	kfree(args);
+	return ret;
+}
+
+static void *utf16_empty_string(u16 *p)
+{
+	*p++ = 2;
+	*p++ = (u8)0x00;
+	return p;
+}
+
+/*
+ * ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
+ *
+ * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
+ * multi-byte language supported.
+ *
+ * @p:   Unicode buffer address
+ * @str: string to convert to unicode
+ *
+ * Returns a void pointer to the buffer containing unicode string
+ */
+void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
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
+		goto ascii_to_utf16_unicode_out;
+	}
+
+	if ((ret * sizeof(u16)) > U16_MAX) {
+		dev_err(bioscfg_drv.class_dev, "Error string too long\n");
+		goto ascii_to_utf16_unicode_out;
+	}
+
+ascii_to_utf16_unicode_out:
+	p += len;
+	return p;
+}
+
+/*
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
+	int ret = 0;
+
+	ret = wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &input, &output);
+
+	obj = output.pointer;
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_INTEGER)
+		ret = -EINVAL;
+
+	ret = obj->integer.value;
+	bioscfg_wmi_error_and_message(ret);
+
+	kfree(obj);
+	return ret;
+}
+
+static int bios_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	bioscfg_drv.bios_attr_wdev = wdev;
+	mutex_unlock(&bioscfg_drv.mutex);
+	return 0;
+}
+
+static void bios_attr_set_interface_remove(struct wmi_device *wdev)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	bioscfg_drv.bios_attr_wdev = NULL;
+	mutex_unlock(&bioscfg_drv.mutex);
+}
+
+static const struct wmi_device_id bios_attr_set_interface_id_table[] = {
+	{ .guid_string = HP_WMI_BIOS_GUID},
+	{ }
+};
+static struct wmi_driver bios_attr_set_interface_driver = {
+	.driver = {
+		.name = DRIVER_NAME
+	},
+	.probe = bios_attr_set_interface_probe,
+	.remove = bios_attr_set_interface_remove,
+	.id_table = bios_attr_set_interface_id_table
+};
+
+int init_bios_attr_set_interface(void)
+{
+	return wmi_driver_register(&bios_attr_set_interface_driver);
+}
+
+void exit_bios_attr_set_interface(void)
+{
+	wmi_driver_unregister(&bios_attr_set_interface_driver);
+}
+
+MODULE_DEVICE_TABLE(wmi, bios_attr_set_interface_id_table);
-- 
2.34.1

