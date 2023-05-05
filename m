Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4116F8C1B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjEEWBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjEEWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:01:00 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7D618C;
        Fri,  5 May 2023 15:00:55 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19290ad942aso1828993fac.2;
        Fri, 05 May 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324054; x=1685916054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1nGKw8f/dxP/7jJzTv/z34Dnb7AGXeIum1HL28SVVc=;
        b=HHPgukUHAeVmOuiioUz2OFp+3766DqedQV22dmu8CegomhVT2l/FU7UX9Qcnlj8oz4
         Ktr+6FV5ldXb5liCrkwtn91jRtStOHpy4ZfiduBKsVCxZhbRiP4Ksv6JzppvXauar6tp
         dOAnHzNzv4nQ80UlM5Wd6mbUsO0QXMeSF2H6tKp/T6rKH/Dtc8T9y6ncLAJ09AOo4qXK
         btmeOdkT0K8+/wMNGHqCs5lnPk1Q/XwmDBC4d65TYy6NJMxQqE8rBiLByG4wQpE4cqj3
         XW3t2Qytw5Dh0Hw6I+HzLHlXXgXXWxd76RUxaHfWvh6iqgyrZHA3LdEni6vJdrK/XnA0
         HJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324054; x=1685916054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1nGKw8f/dxP/7jJzTv/z34Dnb7AGXeIum1HL28SVVc=;
        b=NfiIuJNI9HA5yMbJn115kXbWLkslme6SbtYQtrBbJDX5s0WSsKSEcF4eTKVizXrqSb
         6Qjx18q9TfHViOjUTjw2nfYiX2psfnA13W82glcNukofKxUVL+gt1Lc0bqnzeJWure8l
         YvSE43E09tCq0GzZcFmM4U4l/PD57BdULd+7ggCY6LYL5eUzqeYZBpiwGb2qGRpB2QFQ
         TEvwWyENUmEJVFNFOECl5bJ4EO8no8kJPiaGrb2WrMSawbAvKbbcRIC1c/UvgakiBg3a
         bKdDw4YM9n+VZNaqZKJ+WYfBdkhpN+HlUXsHEzKeuAdq2OFqwzy2hzDeB+wnw2y4M1uU
         YfFg==
X-Gm-Message-State: AC+VfDwIVjGlsphjuMkFNFfJd8oGLF89lMNrZEJOePWwSS0sWkzrdNM9
        Co1Kq6/hVBCLyi7BgroeiU0=
X-Google-Smtp-Source: ACHHUZ5Rchy+0qePd0XVRETNq7anQvkAOdsE72F9qK3CVmRhQQvAYW55rQJ7kPLacTQtJ9xGvDC24g==
X-Received: by 2002:a05:6870:b785:b0:187:7733:bcdb with SMTP id ed5-20020a056870b78500b001877733bcdbmr1751885oab.31.1683324054643;
        Fri, 05 May 2023 15:00:54 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:90cc:2e0a:7522:8ecc])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006a61bef7968sm1359547oti.53.2023.05.05.15.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:00:54 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v12 07/13] HP BIOSCFG driver  - string-attributes
Date:   Fri,  5 May 2023 17:00:37 -0500
Message-Id: <20230505220043.39036-8-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505220043.39036-1-jorge.lopez2@hp.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++++++++++++
 1 file changed, 415 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
new file mode 100644
index 000000000000..d74ecc973703
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to string type attributes under
+ * HP_WMI_BIOS_STRING_GUID for use with hp-bioscfg driver.
+ *
+ * Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+
+#define WMI_STRING_TYPE "HPBIOS_BIOSString"
+
+GET_INSTANCE_ID(string);
+
+static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int instance_id = get_string_instance_id(kobj);
+
+	if (instance_id < 0)
+		return -EIO;
+
+	return  sysfs_emit(buf, "%s\n",
+			 bioscfg_drv.string_data[instance_id].current_value);
+}
+
+/*
+ * validate_string_input() -
+ * Validate input of current_value against min and max lengths
+ *
+ * @instance_id: The instance on which input is validated
+ * @buf: Input value
+ */
+static int validate_string_input(int instance_id, const char *buf)
+{
+	int in_len = strlen(buf);
+	struct string_data *string_data = &bioscfg_drv.string_data[instance_id];
+
+	/* BIOS treats it as a read only attribute */
+	if (string_data->common.is_readonly)
+		return -EIO;
+
+	if (in_len < string_data->min_length ||
+	    in_len > string_data->max_length)
+		return -ERANGE;
+
+	/*
+	 * set pending reboot flag depending on
+	 * "RequiresPhysicalPresence" value
+	 */
+	if (string_data->common.requires_physical_presence)
+		set_reboot_and_signal_event();
+	return 0;
+}
+
+static void update_string_value(int instance_id, char *attr_value)
+{
+	struct string_data *string_data = &bioscfg_drv.string_data[instance_id];
+
+	/* Write settings to BIOS */
+	strscpy(string_data->current_value,
+		attr_value,
+		sizeof(string_data->current_value));
+}
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, string);
+static struct kobj_attribute string_display_langcode =
+	__ATTR_RO(display_name_language_code);
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, string);
+static struct kobj_attribute string_display_name =
+	__ATTR_RO(display_name);
+
+ATTRIBUTE_PROPERTY_STORE(current_value, string);
+static struct kobj_attribute string_current_val =
+	__ATTR_RW_MODE(current_value, 0644);
+
+ATTRIBUTE_N_PROPERTY_SHOW(min_length, string);
+static struct kobj_attribute string_min_length =
+	__ATTR_RO(min_length);
+
+ATTRIBUTE_N_PROPERTY_SHOW(max_length, string);
+static struct kobj_attribute string_max_length =
+	__ATTR_RO(max_length);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "string\n");
+}
+
+static struct kobj_attribute string_type =
+	__ATTR_RO(type);
+
+static struct attribute *string_attrs[] = {
+	&string_display_langcode.attr,
+	&string_display_name.attr,
+	&string_current_val.attr,
+	&string_min_length.attr,
+	&string_max_length.attr,
+	&string_type.attr,
+	NULL,
+};
+
+static const struct attribute_group string_attr_group = {
+	.attrs = string_attrs,
+};
+
+int alloc_string_data(void)
+{
+	bioscfg_drv.string_instances_count = get_instance_count(HP_WMI_BIOS_STRING_GUID);
+	bioscfg_drv.string_data = kcalloc(bioscfg_drv.string_instances_count,
+					  sizeof(struct string_data), GFP_KERNEL);
+	if (!bioscfg_drv.string_data) {
+		bioscfg_drv.string_instances_count = 0;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* Expected Values types associated with each element */
+static const acpi_object_type expected_string_types[] = {
+	[NAME] = ACPI_TYPE_STRING,
+	[VALUE] = ACPI_TYPE_STRING,
+	[PATH] = ACPI_TYPE_STRING,
+	[IS_READONLY] = ACPI_TYPE_INTEGER,
+	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
+	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
+	[SEQUENCE] = ACPI_TYPE_INTEGER,
+	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
+	[PREREQUISITES] = ACPI_TYPE_STRING,
+	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
+	[STR_MIN_LENGTH] = ACPI_TYPE_INTEGER,
+	[STR_MAX_LENGTH] = ACPI_TYPE_INTEGER,
+};
+
+/*
+ * populate_string_package_data() -
+ * Populate all properties of an instance under string attribute
+ *
+ * @string_obj: ACPI object with string data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_string_package_data(union acpi_object *string_obj,
+				 int instance_id,
+				 struct kobject *attr_name_kobj)
+{
+	struct string_data *string_data = &bioscfg_drv.string_data[instance_id];
+
+	string_data->attr_name_kobj = attr_name_kobj;
+
+	populate_string_elements_from_package(string_obj,
+					      string_obj->package.count,
+					      instance_id);
+
+	update_attribute_permissions(string_data->common.is_readonly,
+				     &string_current_val);
+	friendly_user_name_update(string_data->common.path,
+				  attr_name_kobj->name,
+				  string_data->common.display_name,
+				  sizeof(string_data->common.display_name));
+	return sysfs_create_group(attr_name_kobj, &string_attr_group);
+}
+
+int populate_string_elements_from_package(union acpi_object *string_obj,
+					  int string_obj_count,
+					  int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	int ret = 0;
+	u32 int_value;
+	int elem;
+	int reqs;
+	int eloc;
+	struct string_data *string_data = &bioscfg_drv.string_data[instance_id];
+
+	if (!string_obj)
+		return -EINVAL;
+
+	strscpy(string_data->common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(string_data->common.display_name_language_code));
+
+	for (elem = 1, eloc = 1; elem < string_obj_count; elem++, eloc++) {
+		/* ONLY look at the first STRING_ELEM_CNT elements */
+		if (eloc == STR_ELEM_CNT)
+			goto exit_string_package;
+
+		switch (string_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+
+			if (elem != PREREQUISITES) {
+				ret = convert_hexstr_to_str(string_obj[elem].string.pointer,
+							    string_obj[elem].string.length,
+							    &str_value, &value_len);
+
+				if (ret)
+					continue;
+			}
+			break;
+		case ACPI_TYPE_INTEGER:
+			int_value = (u32)string_obj[elem].integer.value;
+			break;
+		default:
+			pr_warn("Unsupported object type [%d]\n", string_obj[elem].type);
+			continue;
+		}
+
+		/* Check that both expected and read object type match */
+		if (expected_string_types[eloc] != string_obj[elem].type) {
+			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
+			       expected_string_types[eloc], elem, string_obj[elem].type);
+			return -EIO;
+		}
+
+		/* Assign appropriate element value to corresponding field*/
+		switch (eloc) {
+		case VALUE:
+			strscpy(string_data->current_value,
+				str_value, sizeof(string_data->current_value));
+			break;
+		case PATH:
+			strscpy(string_data->common.path, str_value,
+				sizeof(string_data->common.path));
+			break;
+		case IS_READONLY:
+			string_data->common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			string_data->common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			string_data->common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			string_data->common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			if (string_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+			/*
+			 * This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero.  PREREQUISITES
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (string_data->common.prerequisites_size == 0)
+				eloc++;
+			break;
+		case PREREQUISITES:
+			for (reqs = 0;
+			     reqs < string_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;
+			     reqs++) {
+				if (elem >= string_obj_count) {
+					pr_err("Error elem-objects package is too small\n");
+					return -EINVAL;
+				}
+
+				ret = convert_hexstr_to_str(string_obj[elem + reqs].string.pointer,
+							    string_obj[elem + reqs].string.length,
+							    &str_value, &value_len);
+
+				if (ret)
+					continue;
+
+				strscpy(string_data->common.prerequisites[reqs],
+					str_value,
+					sizeof(string_data->common.prerequisites[reqs]));
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			string_data->common.security_level = int_value;
+			break;
+		case STR_MIN_LENGTH:
+			string_data->min_length = int_value;
+			break;
+		case STR_MAX_LENGTH:
+			string_data->max_length = int_value;
+			break;
+		default:
+			pr_warn("Invalid element: %d found in String attribute or data may be malformed\n", elem);
+			break;
+		}
+
+		kfree(str_value);
+	}
+
+exit_string_package:
+	kfree(str_value);
+	return 0;
+}
+
+/*
+ * populate_string_data() -
+ * Populate all properties of an instance under string attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+				int instance_id,
+				struct kobject *attr_name_kobj)
+{
+	struct string_data *string_data = &bioscfg_drv.string_data[instance_id];
+
+	string_data->attr_name_kobj = attr_name_kobj;
+
+	populate_string_elements_from_buffer(buffer_ptr, buffer_size,
+					     instance_id);
+
+	update_attribute_permissions(string_data->common.is_readonly,
+				     &string_current_val);
+	friendly_user_name_update(string_data->common.path,
+				  attr_name_kobj->name,
+				  string_data->common.display_name,
+				  sizeof(string_data->common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &string_attr_group);
+}
+
+int populate_string_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+					 int instance_id)
+{
+	int reqs;
+	struct string_data *string_data = &bioscfg_drv.string_data[instance_id];
+
+	strscpy(string_data->common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(string_data->common.display_name_language_code));
+
+	// VALUE:
+	get_string_from_buffer(&buffer_ptr, buffer_size, string_data->current_value,
+			       sizeof(string_data->current_value));
+
+	// PATH:
+	get_string_from_buffer(&buffer_ptr, buffer_size, string_data->common.path,
+			       sizeof(string_data->common.path));
+
+	// IS_READONLY:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->common.is_readonly);
+
+	//DISPLAY_IN_UI:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->common.display_in_ui);
+
+	// REQUIRES_PHYSICAL_PRESENCE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->common.requires_physical_presence);
+
+	// SEQUENCE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->common.sequence);
+
+	// PREREQUISITES_SIZE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->common.prerequisites_size);
+
+	if (string_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
+		/* Report a message and limit prerequisite size to maximum value */
+		pr_warn("String Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+		string_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
+	}
+
+	// PREREQUISITES:
+	for (reqs = 0;
+	     reqs < string_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;
+	     reqs++)
+		get_string_from_buffer(&buffer_ptr, buffer_size,
+				       string_data->common.prerequisites[reqs],
+				       sizeof(string_data->common.prerequisites[reqs]));
+
+	// SECURITY_LEVEL:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->common.security_level);
+
+	// STR_MIN_LENGTH:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->min_length);
+
+	// STR_MAX_LENGTH:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&string_data->max_length);
+
+	return 0;
+}
+
+/*
+ * exit_string_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void exit_string_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.string_instances_count;
+	     instance_id++) {
+		struct kobject *attr_name_kobj =
+			bioscfg_drv.string_data[instance_id].attr_name_kobj;
+
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj, &string_attr_group);
+	}
+	bioscfg_drv.string_instances_count = 0;
+
+	kfree(bioscfg_drv.string_data);
+	bioscfg_drv.string_data = NULL;
+}
-- 
2.34.1

