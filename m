Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A516F8C25
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjEEWBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjEEWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:01:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C50B5B84;
        Fri,  5 May 2023 15:00:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5e2289965so1589436a34.3;
        Fri, 05 May 2023 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324057; x=1685916057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urZIMwrXCkmP5r84qg47guHXIJuyCJNmVkD/ave2oAw=;
        b=dCU2zA0d/IzW+dv814g34dw7hiQiwb9mYqatwSWCfQ3XbM3UhxGJC+ifljxeu7WxOR
         XvRS3FiH/b1Ml3cndW8CsDiZROPZEw22d99r0kcknZNX+Bv75PBBfLnR4XLu5cUZyHja
         adM3HoQcIdS57KU9hsml6zcYP1wplDyv7NE7AHOC+gtOXKVkEodpimxbrJhnLOLtyihy
         hCJ3eMYbWxo9YIoSiKGZ18w3htonevlY3fqCqLhQRc9nxKjoK+ROZfX1LCXBYHryeXWW
         U3FLCzOGl1aajaFLEOWmXiIm7VsiMBm83HEzM73JYeXpl3coEAXxIDDwmT1+bcwUDZ1Z
         yehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324057; x=1685916057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urZIMwrXCkmP5r84qg47guHXIJuyCJNmVkD/ave2oAw=;
        b=a6xvM7huiW5DmsvZL7IR4CCqhHvQI4MrXb+yOqpa0QyExZNjQMeboGJWf4aVqclFEs
         cIIRINGVfgtCGNe7Rg0j4fzp2Q0cfVRPjFnqVqeDeZCqNGN0tYogjfphDLCfBsinwOk7
         cL+6o/HFhiuPp5S11/FFB7gBzC8Bknjw99FUsraDO0BAKcPBWGEpD+I8DmwoyvJPBidG
         QTEXCCyz3VHkLipFPCIE1vNNWv3dfld3xMEzfhoRa1VZC6JDgoppayulYW4iHdRKEU58
         OzOyfsjobjqiND0qrs/4Bi8Mw7fOfGouytgsa3QwlaaM7wfTW7k1CsZ0fYHrEva7ZDRD
         k0+g==
X-Gm-Message-State: AC+VfDy5UCyUintv24djHq9QQH1c2D/ythqzisSpMDjF4UjCce9at4EP
        rSvHDk40e7t6/7cNtnltHYfr7X7+Qa4=
X-Google-Smtp-Source: ACHHUZ4mta0fX/JhzKavKvz1iTzq2Uj6f0rbcKx3CEXNk75YRXCrzEsKXhHdvw+rJ5PxvEbop9QTkw==
X-Received: by 2002:a05:6830:1db5:b0:6a6:7dc:131 with SMTP id z21-20020a0568301db500b006a607dc0131mr1152977oti.19.1683324056790;
        Fri, 05 May 2023 15:00:56 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:90cc:2e0a:7522:8ecc])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006a61bef7968sm1359547oti.53.2023.05.05.15.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:00:56 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v12 09/13] HP BIOSCFG driver  - enum-attributes
Date:   Fri,  5 May 2023 17:00:39 -0500
Message-Id: <20230505220043.39036-10-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 482 ++++++++++++++++++
 1 file changed, 482 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
new file mode 100644
index 000000000000..d83b092ba7d8
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to enumeration type attributes under
+ * BIOS Enumeration GUID for use with hp-bioscfg driver.
+ *
+ *  Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+
+GET_INSTANCE_ID(enumeration);
+
+static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int instance_id = get_enumeration_instance_id(kobj);
+
+	if (instance_id < 0)
+		return -EIO;
+
+	return sysfs_emit(buf, "%s\n",
+			 bioscfg_drv.enumeration_data[instance_id].current_value);
+}
+
+/**
+ * validate_enumeration_input() -
+ * Validate input of current_value against possible values
+ *
+ * @instance_id: The instance on which input is validated
+ * @buf: Input value
+ */
+static int validate_enumeration_input(int instance_id, const char *buf)
+{
+	int i;
+	int found = 0;
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	/* Is it a read only attribute */
+	if (enum_data->common.is_readonly)
+		return -EIO;
+
+	for (i = 0; i < enum_data->possible_values_size && !found; i++)
+		if (!strcasecmp(enum_data->possible_values[i], buf))
+			found = 1;
+
+	if (!found)
+		return -EINVAL;
+
+	/*
+	 * set pending reboot flag depending on
+	 * "RequiresPhysicalPresence" value
+	 */
+	if (enum_data->common.requires_physical_presence)
+		set_reboot_and_signal_event();
+
+	return 0;
+}
+
+static void update_enumeration_value(int instance_id, char *attr_value)
+{
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	strscpy(enum_data->current_value,
+		attr_value,
+		sizeof(enum_data->current_value));
+}
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, enumeration);
+static struct kobj_attribute enumeration_display_langcode =
+		__ATTR_RO(display_name_language_code);
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, enumeration);
+static struct kobj_attribute  enumeration_display_name =
+		__ATTR_RO(display_name);
+
+ATTRIBUTE_PROPERTY_STORE(current_value, enumeration);
+static struct kobj_attribute enumeration_current_val =
+		__ATTR_RW(current_value);
+
+ATTRIBUTE_VALUES_PROPERTY_SHOW(possible_values, enumeration, SEMICOLON_SEP);
+static struct kobj_attribute  enumeration_poss_val =
+		__ATTR_RO(possible_values);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "enumeration\n");
+}
+
+static struct kobj_attribute enumeration_type =
+		__ATTR_RO(type);
+
+static struct attribute *enumeration_attrs[] = {
+	&enumeration_display_langcode.attr,
+	&enumeration_display_name.attr,
+	&enumeration_current_val.attr,
+	&enumeration_poss_val.attr,
+	&enumeration_type.attr,
+	NULL,
+};
+
+static const struct attribute_group enumeration_attr_group = {
+	.attrs = enumeration_attrs,
+};
+
+int alloc_enumeration_data(void)
+{
+	bioscfg_drv.enumeration_instances_count =
+		get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
+
+	bioscfg_drv.enumeration_data = kcalloc(bioscfg_drv.enumeration_instances_count,
+					       sizeof(struct enumeration_data), GFP_KERNEL);
+	if (!bioscfg_drv.enumeration_data) {
+		bioscfg_drv.enumeration_instances_count = 0;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* Expected Values types associated with each element */
+static const acpi_object_type expected_enum_types[] = {
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
+	[ENUM_CURRENT_VALUE] = ACPI_TYPE_STRING,
+	[ENUM_SIZE] = ACPI_TYPE_INTEGER,
+	[ENUM_POSSIBLE_VALUES] = ACPI_TYPE_STRING,
+};
+
+/**
+ * populate_enumeration_package_data() -
+ * Populate all properties of an instance under enumeration attribute
+ *
+ * @enum_obj: ACPI object with enumeration data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_enumeration_package_data(union acpi_object *enum_obj,
+				      int instance_id,
+				      struct kobject *attr_name_kobj)
+{
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	enum_data->attr_name_kobj = attr_name_kobj;
+
+	populate_enumeration_elements_from_package(enum_obj,
+						   enum_obj->package.count,
+						   instance_id);
+	update_attribute_permissions(enum_data->common.is_readonly,
+				     &enumeration_current_val);
+	/*
+	 * Several attributes have names such "MONDAY".  Friendly
+	 * user nane is generated to make the name more descriptive
+	 */
+	friendly_user_name_update(enum_data->common.path,
+				  attr_name_kobj->name,
+				  enum_data->common.display_name,
+				  sizeof(enum_data->common.display_name));
+	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
+}
+
+int populate_enumeration_elements_from_package(union acpi_object *enum_obj,
+					       int enum_obj_count,
+					       int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	u32 size = 0;
+	u32 int_value;
+	int elem = 0;
+	int reqs;
+	int pos_values;
+	int ret;
+	int eloc;
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	strscpy(enum_data->common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(enum_data->common.display_name_language_code));
+
+	for (elem = 1, eloc = 1; elem < enum_obj_count; elem++, eloc++) {
+		/* ONLY look at the first ENUM_ELEM_CNT elements */
+		if (eloc == ENUM_ELEM_CNT)
+			goto exit_enumeration_package;
+
+		switch (enum_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+
+			if (PREREQUISITES != elem && ENUM_POSSIBLE_VALUES != elem) {
+				ret = convert_hexstr_to_str(enum_obj[elem].string.pointer,
+							    enum_obj[elem].string.length,
+							    &str_value, &value_len);
+				if (ret)
+					return -EINVAL;
+			}
+			break;
+		case ACPI_TYPE_INTEGER:
+			int_value = (u32)enum_obj[elem].integer.value;
+			break;
+		default:
+			pr_warn("Unsupported object type [%d]\n", enum_obj[elem].type);
+			continue;
+		}
+
+		/* Check that both expected and read object type match */
+		if (expected_enum_types[eloc] != enum_obj[elem].type) {
+			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
+			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			return -EIO;
+		}
+
+		/* Assign appropriate element value to corresponding field */
+		switch (eloc) {
+		case NAME:
+		case VALUE:
+			break;
+		case PATH:
+			strscpy(enum_data->common.path, str_value,
+				sizeof(enum_data->common.path));
+			break;
+		case IS_READONLY:
+			enum_data->common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			enum_data->common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			enum_data->common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			enum_data->common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			enum_data->common.prerequisites_size = int_value;
+			if (int_value > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			/*
+			 * This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero.  PREREQUISITES
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+
+		case PREREQUISITES:
+
+			size = enum_data->common.prerequisites_size;
+
+			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
+				if (elem >= enum_obj_count) {
+					pr_err("Error enum-objects package is too small\n");
+					return -EINVAL;
+				}
+
+				ret = convert_hexstr_to_str(enum_obj[elem + reqs].string.pointer,
+							    enum_obj[elem + reqs].string.length,
+							    &str_value, &value_len);
+
+				if (ret)
+					return -EINVAL;
+
+				strscpy(enum_data->common.prerequisites[reqs],
+					str_value,
+					sizeof(enum_data->common.prerequisites[reqs]));
+
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			enum_data->common.security_level = int_value;
+			break;
+
+		case ENUM_CURRENT_VALUE:
+			strscpy(enum_data->current_value,
+				str_value, sizeof(enum_data->current_value));
+			break;
+		case ENUM_SIZE:
+			enum_data->possible_values_size = int_value;
+			if (int_value > MAX_VALUES_SIZE)
+				pr_warn("Possible number values size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			/*
+			 * This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero.  POSSIBLE_VALUES
+			 * object is omitted by BIOS when the size is zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+
+		case ENUM_POSSIBLE_VALUES:
+			size = enum_data->possible_values_size;
+
+			for (pos_values = 0; pos_values < size && pos_values < MAX_VALUES_SIZE;
+			     pos_values++) {
+				if (elem >= enum_obj_count) {
+					pr_err("Error enum-objects package is too small\n");
+					return -EINVAL;
+				}
+
+				ret = convert_hexstr_to_str(enum_obj[elem + pos_values].string.pointer,
+							    enum_obj[elem  + pos_values].string.length,
+							    &str_value, &value_len);
+
+				if (ret)
+					return -EINVAL;
+
+				/*
+				 * ignore strings when possible values size
+				 * is greater than  MAX_VALUES_SIZE
+				 */
+				if (size < MAX_VALUES_SIZE)
+					strscpy(enum_data->possible_values[pos_values],
+						str_value,
+						sizeof(enum_data->possible_values[pos_values]));
+
+				kfree(str_value);
+			}
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Enumeration attribute or data may be malformed\n", elem);
+			break;
+		}
+
+		kfree(str_value);
+	}
+
+exit_enumeration_package:
+	kfree(str_value);
+	return 0;
+}
+
+/**
+ * populate_enumeration_buffer_data() -
+ * Populate all properties of an instance under enumeration attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+				     int instance_id,
+				     struct kobject *attr_name_kobj)
+{
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	enum_data->attr_name_kobj = attr_name_kobj;
+
+	/* Populate enumeration elements */
+	populate_enumeration_elements_from_buffer(buffer_ptr, buffer_size,
+						  instance_id);
+
+	update_attribute_permissions(enum_data->common.is_readonly,
+				     &enumeration_current_val);
+	/*
+	 * Several attributes have names such "MONDAY". A Friendlier
+	 * user nane is generated to make the name more descriptive
+	 */
+	friendly_user_name_update(enum_data->common.path,
+				  attr_name_kobj->name,
+				  enum_data->common.display_name,
+				  sizeof(enum_data->common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
+}
+
+int populate_enumeration_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+					      int instance_id)
+{
+	int reqs;
+	int values;
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	strscpy(enum_data->common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(enum_data->common.display_name_language_code));
+
+	// VALUE:
+	get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->current_value,
+			       sizeof(enum_data->current_value));
+
+	// PATH:
+	get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->common.path,
+			       sizeof(enum_data->common.path));
+
+	// IS_READONLY:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->common.is_readonly);
+
+	//DISPLAY_IN_UI:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->common.display_in_ui);
+
+	// REQUIRES_PHYSICAL_PRESENCE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->common.requires_physical_presence);
+
+	// SEQUENCE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->common.sequence);
+
+	// PREREQUISITES_SIZE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->common.prerequisites_size);
+
+	if (enum_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
+		/* Report a message and limit prerequisite size to maximum value */
+		pr_warn("Enum Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+		enum_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
+	}
+
+	// PREREQUISITES:
+	for (reqs = 0; reqs < enum_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;
+	     reqs++)
+		get_string_from_buffer(&buffer_ptr, buffer_size,
+				       enum_data->common.prerequisites[reqs],
+				       sizeof(enum_data->common.prerequisites[reqs]));
+
+	// SECURITY_LEVEL:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->common.security_level);
+
+	// ENUM_CURRENT_VALUE:
+	get_string_from_buffer(&buffer_ptr, buffer_size,
+			       enum_data->current_value,
+			       sizeof(enum_data->current_value));
+	// ENUM_SIZE:
+	get_integer_from_buffer(&buffer_ptr, buffer_size,
+				&enum_data->possible_values_size);
+
+	if (enum_data->possible_values_size > MAX_VALUES_SIZE) {
+		/* Report a message and limit possible values size to maximum value */
+		pr_warn("Enum Possible size value exceeded the maximum number of elements supported or data may be malformed\n");
+		enum_data->possible_values_size = MAX_VALUES_SIZE;
+	}
+
+	// ENUM_POSSIBLE_VALUES:
+
+	for (values = 0; values < enum_data->possible_values_size && values < MAX_VALUES_SIZE;
+	     values++)
+		get_string_from_buffer(&buffer_ptr, buffer_size,
+				       enum_data->possible_values[values],
+				       sizeof(enum_data->possible_values[values]));
+
+	return 0;
+}
+
+/**
+ * exit_enumeration_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void exit_enumeration_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.enumeration_instances_count;
+	     instance_id++) {
+		struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+		struct kobject *attr_name_kobj = enum_data->attr_name_kobj;
+
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj, &enumeration_attr_group);
+	}
+	bioscfg_drv.enumeration_instances_count = 0;
+
+	kfree(bioscfg_drv.enumeration_data);
+	bioscfg_drv.enumeration_data = NULL;
+}
-- 
2.34.1

