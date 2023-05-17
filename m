Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222FC706D43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjEQPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjEQPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:50:38 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1815FC4;
        Wed, 17 May 2023 08:50:36 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19a16355c51so545347fac.0;
        Wed, 17 May 2023 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684338636; x=1686930636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkmqTOnqH10zqck+vlU1cotzouf6/Ip6L8zG46cMmoY=;
        b=CAU17i1l7jtC89q381glB5a6BzvhjXTFypQbNJ7Sf6n2+fxRBrYfiboVoZSy17Mz3V
         r9uOxL72Iseoa6t0PXooLZyT2DAZVjdMmghadwFj1E7z+N3ln2RU3H7TU1siEMr2VmAy
         wbHjBn4KTkPK9H86q9ZgFX+ZOYByR7A75AqvEipP+/CXoJkQkRfCuu1XmeCSBh/mD/oF
         SmLGKTixmxvfSKBLHCSdM6W0mezvNJfOb2VV0/do6yRoSa9FL7f4WQUtTNzw4WM/P/ed
         KPtdmxcGwQSf2FAEZVR65JHdHe3gbRAZu11j8nhHVDuhWRGnD6vpcBXBemBiKvPJJoUu
         0C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338636; x=1686930636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkmqTOnqH10zqck+vlU1cotzouf6/Ip6L8zG46cMmoY=;
        b=T8Zr77DS/lRaskaumcCXzC+mSazB+9SLm3ZulnQACIBa4XmmXSLXTHihEp7ds3kK5J
         GOLqARd6LkUG68dBH/RpF8k36gtrvWKHYa2sTn0aid1LWWxk5NiRMkCbKxbYI+yBvWCa
         AHrt1KvE80CZYlIQAurwqiqMUhdegAkvOXdi3DD2CW3oqcqtkUGM1cD5Q+7TcwwqNh4Y
         VLsk8/vEke+7t2nCK3n3raxIAZkMRYWjTBR/WiRFLdf3MTYdQzGMWK9+05JSIerjzCUJ
         XrMtN3HtP3osrhXcGeshsw2kvka+gp6RUtfyNhGYc+RBAmGcXQW7U9e8HE0m35uLa5UL
         BaKQ==
X-Gm-Message-State: AC+VfDwngWfXytH9KPMaQL2ml80EThk6BR4agdpsf0waOj251nKfazkM
        xapaa7aSbR5bdt8q+IeFSbE=
X-Google-Smtp-Source: ACHHUZ42iI0WNXHF/scQAgXp5TMrW5VyQc13KPQcxeuNDiyzS6BrI1WTTKben5/TO+dMtX4LT5aIXA==
X-Received: by 2002:a05:6870:4c4:b0:17e:32dd:6003 with SMTP id u4-20020a05687004c400b0017e32dd6003mr20518935oam.26.1684338635702;
        Wed, 17 May 2023 08:50:35 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:3754:4771:3b5:e909])
        by smtp.gmail.com with ESMTPSA id j5-20020a056870a48500b0018b12e3a392sm14214468oal.42.2023.05.17.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:50:35 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v14 05/13] hp-bioscfg: enum-attributes
Date:   Wed, 17 May 2023 10:50:18 -0500
Message-Id: <20230517155026.28535-6-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517155026.28535-1-jorge.lopez2@hp.com>
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 ++++++++++++++++++
 1 file changed, 465 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
new file mode 100644
index 000000000000..80842835606d
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to enumeration type attributes under
+ * BIOS Enumeration GUID for use with hp-bioscfg driver.
+ *
+ * Copyright (c) 2022 HP Development Company, L.P.
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
+		if (!strcmp(enum_data->possible_values[i], buf))
+			found = 1;
+
+	if (!found)
+		return -EINVAL;
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
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, enumeration);
+static struct kobj_attribute enumeration_display_name =
+		__ATTR_RO(display_name);
+
+ATTRIBUTE_PROPERTY_STORE(current_value, enumeration);
+static struct kobj_attribute enumeration_current_val =
+		__ATTR_RW(current_value);
+
+ATTRIBUTE_VALUES_PROPERTY_SHOW(possible_values, enumeration, SEMICOLON_SEP);
+static struct kobj_attribute enumeration_poss_val =
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
+static struct kobj_attribute common_display_langcode =
+	__ATTR_RO(display_name_language_code);
+
+static struct attribute *enumeration_attrs[] = {
+	&common_display_langcode.attr,
+	&enumeration_display_name.attr,
+	&enumeration_current_val.attr,
+	&enumeration_poss_val.attr,
+	&enumeration_type.attr,
+	NULL
+};
+
+static const struct attribute_group enumeration_attr_group = {
+	.attrs = enumeration_attrs,
+};
+
+int hp_alloc_enumeration_data(void)
+{
+	bioscfg_drv.enumeration_instances_count =
+		hp_get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
+
+	bioscfg_drv.enumeration_data = kcalloc(bioscfg_drv.enumeration_instances_count,
+					       sizeof(*bioscfg_drv.enumeration_data), GFP_KERNEL);
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
+static int hp_populate_enumeration_elements_from_package(union acpi_object *enum_obj,
+							 int enum_obj_count,
+							 int instance_id)
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
+	for (elem = 1, eloc = 1; elem < enum_obj_count; elem++, eloc++) {
+		/* ONLY look at the first ENUM_ELEM_CNT elements */
+		if (eloc == ENUM_ELEM_CNT)
+			goto exit_enumeration_package;
+
+		switch (enum_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+			if (PREREQUISITES != elem && ENUM_POSSIBLE_VALUES != elem) {
+				ret = hp_convert_hexstr_to_str(enum_obj[elem].string.pointer,
+							       enum_obj[elem].string.length,
+							       &str_value, &value_len);
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
+			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
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
+			 * when the size is zero. PREREQUISITES
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+
+		case PREREQUISITES:
+			size = min_t(u32, enum_data->common.prerequisites_size, MAX_PREREQUISITES_SIZE);
+			for (reqs = 0; reqs < size; reqs++) {
+				if (elem >= enum_obj_count) {
+					pr_err("Error enum-objects package is too small\n");
+					return -EINVAL;
+				}
+
+				ret = hp_convert_hexstr_to_str(enum_obj[elem + reqs].string.pointer,
+							       enum_obj[elem + reqs].string.length,
+							       &str_value, &value_len);
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
+			 * when the size is zero. POSSIBLE_VALUES
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
+				ret = hp_convert_hexstr_to_str(enum_obj[elem + pos_values].string.pointer,
+							       enum_obj[elem + pos_values].string.length,
+							       &str_value, &value_len);
+
+				if (ret)
+					return -EINVAL;
+
+				/*
+				 * ignore strings when possible values size
+				 * is greater than MAX_VALUES_SIZE
+				 */
+				if (size < MAX_VALUES_SIZE)
+					strscpy(enum_data->possible_values[pos_values],
+						str_value,
+						sizeof(enum_data->possible_values[pos_values]));
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
+ * hp_populate_enumeration_package_data() -
+ * Populate all properties of an instance under enumeration attribute
+ *
+ * @enum_obj: ACPI object with enumeration data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
+					 int instance_id,
+					 struct kobject *attr_name_kobj)
+{
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	enum_data->attr_name_kobj = attr_name_kobj;
+
+	hp_populate_enumeration_elements_from_package(enum_obj,
+						      enum_obj->package.count,
+						      instance_id);
+	hp_update_attribute_permissions(enum_data->common.is_readonly,
+					&enumeration_current_val);
+	/*
+	 * Several attributes have names such "MONDAY". Friendly
+	 * user nane is generated to make the name more descriptive
+	 */
+	hp_friendly_user_name_update(enum_data->common.path,
+				     attr_name_kobj->name,
+				     enum_data->common.display_name,
+				     sizeof(enum_data->common.display_name));
+	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
+}
+
+static int hp_populate_enumeration_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+							int instance_id)
+{
+	int reqs;
+	int values;
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	/*
+	 * In earlier implementation, reported errors were ignored
+	 * causing the data to remain uninitialized. It is for this
+	 * reason functions may return an error and no validation
+	 * takes place.
+	 */
+
+	// VALUE:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->current_value,
+				  sizeof(enum_data->current_value));
+
+	// PATH:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->common.path,
+				  sizeof(enum_data->common.path));
+
+	// IS_READONLY:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->common.is_readonly);
+
+	//DISPLAY_IN_UI:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->common.display_in_ui);
+
+	// REQUIRES_PHYSICAL_PRESENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->common.requires_physical_presence);
+
+	// SEQUENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->common.sequence);
+
+	// PREREQUISITES_SIZE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->common.prerequisites_size);
+
+	if (enum_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
+		/* Report a message and limit prerequisite size to maximum value */
+		pr_warn("Enum Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+		enum_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
+	}
+
+	// PREREQUISITES:
+	for (reqs = 0; reqs < enum_data->common.prerequisites_size; reqs++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  enum_data->common.prerequisites[reqs],
+					  sizeof(enum_data->common.prerequisites[reqs]));
+
+	// SECURITY_LEVEL:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->common.security_level);
+
+	// ENUM_CURRENT_VALUE:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+				  enum_data->current_value,
+				  sizeof(enum_data->current_value));
+	// ENUM_SIZE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &enum_data->possible_values_size);
+
+	if (enum_data->possible_values_size > MAX_VALUES_SIZE) {
+		/* Report a message and limit possible values size to maximum value */
+		pr_warn("Enum Possible size value exceeded the maximum number of elements supported or data may be malformed\n");
+		enum_data->possible_values_size = MAX_VALUES_SIZE;
+	}
+
+	// ENUM_POSSIBLE_VALUES:
+
+	for (values = 0; values < enum_data->possible_values_size; values++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  enum_data->possible_values[values],
+					  sizeof(enum_data->possible_values[values]));
+
+	return 0;
+}
+
+/**
+ * hp_populate_enumeration_buffer_data() -
+ * Populate all properties of an instance under enumeration attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+					int instance_id,
+					struct kobject *attr_name_kobj)
+{
+	struct enumeration_data *enum_data = &bioscfg_drv.enumeration_data[instance_id];
+
+	enum_data->attr_name_kobj = attr_name_kobj;
+
+	/* Populate enumeration elements */
+	hp_populate_enumeration_elements_from_buffer(buffer_ptr, buffer_size, instance_id);
+
+	hp_update_attribute_permissions(enum_data->common.is_readonly,
+					&enumeration_current_val);
+	/*
+	 * Several attributes have names such "MONDAY". A Friendlier
+	 * user nane is generated to make the name more descriptive
+	 */
+	hp_friendly_user_name_update(enum_data->common.path,
+				     attr_name_kobj->name,
+				     enum_data->common.display_name,
+				     sizeof(enum_data->common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
+}
+
+/**
+ * hp_exit_enumeration_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void hp_exit_enumeration_attributes(void)
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

