Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381E70A061
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjESUNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjESUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:13:20 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E2E60;
        Fri, 19 May 2023 13:13:12 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-192b1a4dd2eso1729787fac.1;
        Fri, 19 May 2023 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684527192; x=1687119192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2opJ1+W5HOUNs6DOaSrjyXEyOXFf95SoCXdS03bl+3g=;
        b=G0bslNp1aJnRVrekok2A5lMdXWsdOXNnW/VNd1R/RIIDpzfVEZ9k8aGzrW3iRQAEio
         V9bl33pzy4rG+RsQT8JbRIMiBfTF8+1K9O8Cm6gSAtdWZhdqi+lAwUhwvhPy4t0wi3gc
         pGq7nebmo6L9IEkreHdDWp7GS7ROLvBEg5ABmc/AK1ISZhjKIt9usXogP+75F+N5axJJ
         Yja/m+xLs+I/N3gnRtLnHDAlpV7YcEhXACcyeMqPXcTUya9ZHfFbrL2lbOnqR4S3A/3q
         xBR7Lx4QsCKLvw68UrSJ2ZDRV1Z9yA9okkx589JjGMFzae2+4nUFtUOJ5NfHXXtWmkSr
         NNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527192; x=1687119192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2opJ1+W5HOUNs6DOaSrjyXEyOXFf95SoCXdS03bl+3g=;
        b=VGSMfG1NlwlaVx2kXNaxknaewvAiG3h6nbAb1hedqfnbcev1z9502yOwyZeCPnfzDB
         mWV2GGQbEiIY5qll4Pv7pqRJYYQwgMBjSq1byXHNzxSRfmltx/HWbqi+OLprPFOiuadz
         U1oSHaBe7UugPY+cRcr93pJfXbtoX3gg5/PCfKCjG0FEEPVIYURnIpOFN12ouC3lcJ3i
         EqwbsIm6YSKZ735LJfzpvexQDV8a6WotQ3qAwH8JtVqpT1Hf5os1HTxFFEfQyJ9Uw3K0
         iyjuN2AEnsrUyoIqJPXyDYLLNcuv8UvHwmWj5NgbLFIkIO9rm0upnp/+6sdp67fjHfd0
         W3Hw==
X-Gm-Message-State: AC+VfDwFNr+PtrD2iKXziLWRIWIKHBUu3B9Z3fjk3CLClDuN1QNa2GJt
        +wgDAaYV0YPx6IyZubhOPls=
X-Google-Smtp-Source: ACHHUZ6p0Z9bJyy0HX/JVS2OjnZ84KkC/1JsLDORvaXWL7HcBdhkvJ7fuSlYHogHqtpPg0zdYy08PQ==
X-Received: by 2002:a05:6870:df4b:b0:199:da44:403a with SMTP id ur11-20020a056870df4b00b00199da44403amr1520897oab.33.1684527191961;
        Fri, 19 May 2023 13:13:11 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e6dc:4936:31b7:d3d0])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b001964dc3dadesm2325239oac.45.2023.05.19.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:13:11 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v15 08/13] hp-bioscfg: passwdobj-attributes
Date:   Fri, 19 May 2023 15:12:55 -0500
Message-Id: <20230519201300.12964-9-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519201300.12964-1-jorge.lopez2@hp.com>
References: <20230519201300.12964-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 540 ++++++++++++++++++
 1 file changed, 540 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
new file mode 100644
index 000000000000..483426696144
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to password object type attributes under
+ * BIOS PASSWORD for use with hp-bioscfg driver.
+ *
+ * Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+#include <asm-generic/posix_types.h>
+
+GET_INSTANCE_ID(password);
+/*
+ * Clear all passwords copied to memory for a particular
+ * authentication instance
+ */
+static int clear_passwords(const int instance)
+{
+	struct password_data *password_data = &bioscfg_drv.password_data[instance];
+
+	if (!password_data->is_enabled)
+		return 0;
+
+	memset(password_data->current_password,
+	       0, sizeof(password_data->current_password));
+	memset(password_data->new_password,
+	       0, sizeof(password_data->new_password));
+
+	return 0;
+}
+
+/*
+ * Clear all credentials copied to memory for both Power-ON and Setup
+ * BIOS instances
+ */
+int hp_clear_all_credentials(void)
+{
+	int count = bioscfg_drv.password_instances_count;
+	int instance;
+
+	/* clear all passwords */
+	for (instance = 0; instance < count; instance++)
+		clear_passwords(instance);
+
+	/* clear auth_token */
+	kfree(bioscfg_drv.spm_data.auth_token);
+	bioscfg_drv.spm_data.auth_token = NULL;
+
+	return 0;
+}
+
+int hp_get_password_instance_for_type(const char *name)
+{
+	int count = bioscfg_drv.password_instances_count;
+	int instance;
+
+	for (instance = 0; instance < count; instance++)
+		if (!strcmp(bioscfg_drv.password_data[instance].common.display_name, name))
+			return instance;
+
+	return -EINVAL;
+}
+
+static int validate_password_input(int instance_id, const char *buf)
+{
+	int length;
+	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
+
+	length = strlen(buf);
+	if (buf[length - 1] == '\n')
+		length--;
+
+	if (length > MAX_PASSWD_SIZE)
+		return INVALID_BIOS_AUTH;
+
+	if (password_data->min_password_length > length ||
+	    password_data->max_password_length < length)
+		return INVALID_BIOS_AUTH;
+	return SUCCESS;
+}
+
+ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
+static struct kobj_attribute password_is_password_set = __ATTR_RO(is_enabled);
+
+static int store_password_instance(struct kobject *kobj, const char *buf,
+				   size_t count, bool is_current)
+{
+	char *buf_cp;
+	int id, ret = 0;
+
+	buf_cp = kstrdup(buf, GFP_KERNEL);
+	if (!buf_cp)
+		return -ENOMEM;
+
+	ret = hp_enforce_single_line_input(buf_cp, count);
+	if (!ret) {
+		id = get_password_instance_id(kobj);
+
+		if (id >= 0)
+			ret = validate_password_input(id, buf_cp);
+	}
+
+	if (!ret) {
+		if (is_current)
+			strscpy(bioscfg_drv.password_data[id].current_password,
+				buf_cp,
+				sizeof(bioscfg_drv.password_data[id].current_password));
+		else
+			strscpy(bioscfg_drv.password_data[id].new_password,
+				buf_cp,
+				sizeof(bioscfg_drv.password_data[id].new_password));
+	}
+
+	kfree(buf_cp);
+	return ret < 0 ? ret : count;
+}
+
+static ssize_t current_password_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	return store_password_instance(kobj, buf, count, true);
+}
+
+static struct kobj_attribute password_current_password = __ATTR_WO(current_password);
+
+static ssize_t new_password_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
+{
+	return store_password_instance(kobj, buf, count, true);
+}
+
+static struct kobj_attribute password_new_password = __ATTR_WO(new_password);
+
+ATTRIBUTE_N_PROPERTY_SHOW(min_password_length, password);
+static struct kobj_attribute password_min_password_length = __ATTR_RO(min_password_length);
+
+ATTRIBUTE_N_PROPERTY_SHOW(max_password_length, password);
+static struct kobj_attribute password_max_password_length = __ATTR_RO(max_password_length);
+
+static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	if (!strcmp(kobj->name, SETUP_PASSWD))
+		return sysfs_emit(buf, "%s\n", BIOS_ADMIN);
+
+	if (!strcmp(kobj->name, POWER_ON_PASSWD))
+		return sysfs_emit(buf, "%s\n", POWER_ON);
+
+	return -EIO;
+}
+
+static struct kobj_attribute password_role = __ATTR_RO(role);
+
+static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	int i = get_password_instance_id(kobj);
+
+	if (i < 0)
+		return i;
+
+	if (bioscfg_drv.password_data[i].mechanism != PASSWORD)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", PASSWD_MECHANISM_TYPES);
+}
+
+static struct kobj_attribute password_mechanism = __ATTR_RO(mechanism);
+
+ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password, SEMICOLON_SEP);
+static struct kobj_attribute password_encodings_val = __ATTR_RO(encodings);
+
+static struct attribute *password_attrs[] = {
+	&password_is_password_set.attr,
+	&password_min_password_length.attr,
+	&password_max_password_length.attr,
+	&password_current_password.attr,
+	&password_new_password.attr,
+	&password_role.attr,
+	&password_mechanism.attr,
+	&password_encodings_val.attr,
+	NULL
+};
+
+static const struct attribute_group password_attr_group = {
+	.attrs = password_attrs
+};
+
+int hp_alloc_password_data(void)
+{
+	bioscfg_drv.password_instances_count = hp_get_instance_count(HP_WMI_BIOS_PASSWORD_GUID);
+	bioscfg_drv.password_data = kcalloc(bioscfg_drv.password_instances_count,
+					    sizeof(*bioscfg_drv.password_data), GFP_KERNEL);
+	if (!bioscfg_drv.password_data) {
+		bioscfg_drv.password_instances_count = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/* Expected Values types associated with each element */
+static const acpi_object_type expected_password_types[] = {
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
+	[PSWD_MIN_LENGTH] = ACPI_TYPE_INTEGER,
+	[PSWD_MAX_LENGTH] = ACPI_TYPE_INTEGER,
+	[PSWD_SIZE] = ACPI_TYPE_INTEGER,
+	[PSWD_ENCODINGS] = ACPI_TYPE_STRING,
+	[PSWD_IS_SET] = ACPI_TYPE_INTEGER,
+};
+
+static int hp_populate_password_elements_from_package(union acpi_object *password_obj,
+						      int password_obj_count,
+						      int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	int ret;
+	u32 size;
+	u32 int_value;
+	int elem;
+	int reqs;
+	int eloc;
+	int pos_values;
+	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
+
+	if (!password_obj)
+		return -EINVAL;
+
+	for (elem = 1, eloc = 1; elem < password_obj_count; elem++, eloc++) {
+		/* ONLY look at the first PASSWORD_ELEM_CNT elements */
+		if (eloc == PSWD_ELEM_CNT)
+			goto exit_package;
+
+		switch (password_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+			if (PREREQUISITES != elem && PSWD_ENCODINGS != elem) {
+				ret = hp_convert_hexstr_to_str(password_obj[elem].string.pointer,
+							       password_obj[elem].string.length,
+							       &str_value, &value_len);
+				if (ret)
+					continue;
+			}
+			break;
+		case ACPI_TYPE_INTEGER:
+			int_value = (u32)password_obj[elem].integer.value;
+			break;
+		default:
+			pr_warn("Unsupported object type [%d]\n", password_obj[elem].type);
+			continue;
+		}
+
+		/* Check that both expected and read object type match */
+		if (expected_password_types[eloc] != password_obj[elem].type) {
+			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
+			       expected_password_types[eloc], elem, password_obj[elem].type);
+			return -EIO;
+		}
+
+		/* Assign appropriate element value to corresponding field*/
+		switch (eloc) {
+		case VALUE:
+			break;
+		case PATH:
+			strscpy(password_data->common.path, str_value,
+				sizeof(password_data->common.path));
+			break;
+		case IS_READONLY:
+			password_data->common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			password_data->common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			password_data->common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			password_data->common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			password_data->common.prerequisites_size = int_value;
+			if (int_value > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			/* This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero. PREREQUISITES
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+		case PREREQUISITES:
+			size = min_t(u32, password_data->common.prerequisites_size,
+				     MAX_PREREQUISITES_SIZE);
+
+			for (reqs = 0; reqs < size; reqs++) {
+				ret = hp_convert_hexstr_to_str(password_obj[elem + reqs].string.pointer,
+							       password_obj[elem + reqs].string.length,
+							       &str_value, &value_len);
+
+				if (ret)
+					break;
+
+				strscpy(password_data->common.prerequisites[reqs],
+					str_value,
+					sizeof(password_data->common.prerequisites[reqs]));
+
+				kfree(str_value);
+			}
+			break;
+		case SECURITY_LEVEL:
+			password_data->common.security_level = int_value;
+			break;
+		case PSWD_MIN_LENGTH:
+			password_data->min_password_length = int_value;
+			break;
+		case PSWD_MAX_LENGTH:
+			password_data->max_password_length = int_value;
+			break;
+		case PSWD_SIZE:
+			password_data->encodings_size = int_value;
+			if (int_value > MAX_ENCODINGS_SIZE)
+				pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			/* This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero. PSWD_ENCODINGS
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+		case PSWD_ENCODINGS:
+			size = min_t(u32, password_data->encodings_size, MAX_ENCODINGS_SIZE);
+			for (pos_values = 0; pos_values < size; pos_values++) {
+				ret = hp_convert_hexstr_to_str(password_obj[elem + pos_values].string.pointer,
+							       password_obj[elem + pos_values].string.length,
+							       &str_value, &value_len);
+				if (ret)
+					break;
+
+				strscpy(password_data->encodings[pos_values],
+					str_value,
+					sizeof(password_data->encodings[pos_values]));
+				kfree(str_value);
+			}
+			break;
+		case PSWD_IS_SET:
+			password_data->is_enabled = int_value;
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Password attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+
+exit_package:
+	kfree(str_value);
+	return 0;
+}
+
+/**
+ * hp_populate_password_package_data()
+ *	Populate all properties for an instance under password attribute
+ *
+ * @password_obj: ACPI object with password data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_password_package_data(union acpi_object *password_obj, int instance_id,
+				      struct kobject *attr_name_kobj)
+{
+	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
+
+	password_data->attr_name_kobj = attr_name_kobj;
+
+	hp_populate_password_elements_from_package(password_obj,
+						   password_obj->package.count,
+						   instance_id);
+
+	hp_friendly_user_name_update(password_data->common.path,
+				     attr_name_kobj->name,
+				     password_data->common.display_name,
+				     sizeof(password_data->common.display_name));
+
+	if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
+		return sysfs_create_group(attr_name_kobj, &password_attr_group);
+
+	return sysfs_create_group(attr_name_kobj, &password_attr_group);
+}
+
+static int hp_populate_password_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+						     int instance_id)
+{
+	int reqs;
+	int values;
+	int isreadonly;
+	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
+
+	// VALUE:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, password_data->current_password,
+				  sizeof(password_data->current_password));
+
+	// PATH:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, password_data->common.path,
+				  sizeof(password_data->common.path));
+
+	// IS_READONLY:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->common.is_readonly);
+
+	//DISPLAY_IN_UI:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->common.display_in_ui);
+
+	// REQUIRES_PHYSICAL_PRESENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->common.requires_physical_presence);
+
+	// SEQUENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->common.sequence);
+
+	// PREREQUISITES_SIZE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->common.prerequisites_size);
+
+	if (password_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
+		/* Report a message and limit prerequisite size to maximum value */
+		pr_warn("Password Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+		password_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
+	}
+
+	// PREREQUISITES:
+	for (reqs = 0; reqs < password_data->common.prerequisites_size; reqs++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  password_data->common.prerequisites[reqs],
+					  sizeof(password_data->common.prerequisites[reqs]));
+
+	// SECURITY_LEVEL:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->common.security_level);
+
+	// PSWD_MIN_LENGTH:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->min_password_length);
+
+	// PSWD_MAX_LENGTH:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &password_data->max_password_length);
+
+	// PSWD_SIZE:
+	if (password_data->encodings_size > MAX_ENCODINGS_SIZE) {
+		/* Report a message and limit possible values size to maximum value */
+		pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
+		password_data->encodings_size = MAX_ENCODINGS_SIZE;
+	}
+
+	// PSWD_ENCODINGS:
+	for (values = 0; values < password_data->encodings_size; values++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  password_data->encodings[values],
+					  sizeof(password_data->encodings[values]));
+
+	// PSWD_IS_SET:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size, &isreadonly);
+	password_data->is_enabled = isreadonly ? true : false;
+
+	return 0;
+}
+
+/**
+ * hp_populate_password_buffer_data()
+ * Populate all properties for an instance under password object attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
+				     struct kobject *attr_name_kobj)
+{
+	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
+
+	password_data->attr_name_kobj = attr_name_kobj;
+
+	/* Populate Password attributes */
+	hp_populate_password_elements_from_buffer(buffer_ptr, buffer_size,
+						  instance_id);
+	hp_friendly_user_name_update(password_data->common.path,
+				     attr_name_kobj->name,
+				     password_data->common.display_name,
+				     sizeof(password_data->common.display_name));
+	if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
+		return sysfs_create_group(attr_name_kobj, &password_attr_group);
+
+	return sysfs_create_group(attr_name_kobj, &password_attr_group);
+}
+
+/**
+ * hp_exit_password_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void hp_exit_password_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.password_instances_count;
+	     instance_id++) {
+		struct kobject *attr_name_kobj =
+			bioscfg_drv.password_data[instance_id].attr_name_kobj;
+
+		if (attr_name_kobj) {
+			if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
+				sysfs_remove_group(attr_name_kobj,
+						   &password_attr_group);
+			else
+				sysfs_remove_group(attr_name_kobj,
+						   &password_attr_group);
+		}
+	}
+	bioscfg_drv.password_instances_count = 0;
+	kfree(bioscfg_drv.password_data);
+	bioscfg_drv.password_data = NULL;
+}
-- 
2.34.1

