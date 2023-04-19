Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9824C6E7DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjDSPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjDSPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:46 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465D6A55;
        Wed, 19 Apr 2023 08:13:37 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1879e28ab04so1255574fac.2;
        Wed, 19 Apr 2023 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917216; x=1684509216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8MDowcdCyHRBFtM9QJqVy9DUXrPddSgYQvuHIZ0L1A=;
        b=pFK3AT5atlAhw9Nrb6mbC9ffvhBBL1jCY19zQfWMDFlznlRstZdkWGqgv4GuYaMoEW
         S/TfNSDCh7/qiRKD/6ma/SycvmegeAmIDjvmo/pRHj6wVZlr/IvA2cXdYrWt7Dk3SC9N
         wAARwW8Tfq3zup3ElKch6WxuBhUFsLpVNgTnRr+XgbZgdW8WbeJQcOQ+fql0EJEhJwPD
         x+us8PUbQMuEiedKEBuO0/T5cSvuXRBgeqUMuWvgecVSDWyLdMXOUGzlZVS94mMkxOb2
         AkYic5QkqRRV+yNlnVH1Bhl2JWy7twlzsIxlKoA8tw25qxnk+imVlULVmi2HLtUfoXoc
         deDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917216; x=1684509216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8MDowcdCyHRBFtM9QJqVy9DUXrPddSgYQvuHIZ0L1A=;
        b=RI6RDOMYy94vLy0+IcwqvvNt9RsCME1Ncl8rkBCOg+BnLgrYuwWFpGy8C+sFKUNwjn
         1GI6fPnnHv/VjIJd1UzdhQXCT4oVV7b6oS03i3ybXME14ba1lE3udqX8wUoIGvtW8AX2
         JtR61kdW/XxB+K1qFNx1HIcjYiljqnGaCyYtFVq9lpSae07xx7K3ZHGIpbCDNp3QdzUD
         Zv9a11U0gciAaxlZaXuyIj1QRRBStJOVchSxtUkCz/LXgmkBKsxA42UHffdZgth5TXMQ
         wbecwClFZ3n172VpzSsfTmdPr49aqI6lXADVqmPUqymnx3iZoTAZM4gRaRYgelgwIA6g
         GXfw==
X-Gm-Message-State: AAQBX9edebZcmwIC9ru/XRDw+tguJw/xes1tESGkac4tPHDixoctsqa2
        qNsWp65xuul0wDmgfxJ0uHw=
X-Google-Smtp-Source: AKy350Y8IJaOHKb/4HAhpFlGzbrXqslEHZ4VQsqQ2w7NgQqkKrFeR97SYIHUMKe+sBlzO7oUqdSQ/g==
X-Received: by 2002:a05:6870:9a23:b0:187:d955:af79 with SMTP id fo35-20020a0568709a2300b00187d955af79mr65392oab.12.1681917215843;
        Wed, 19 Apr 2023 08:13:35 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:35 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 09/14] HP BIOSCFG driver  - enum-attributes
Date:   Wed, 19 Apr 2023 10:13:16 -0500
Message-Id: <20230419151321.6167-10-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151321.6167-1-jorge.lopez2@hp.com>
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 543 ++++++++++++++++++
 1 file changed, 543 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
new file mode 100644
index 000000000000..20defa92da6f
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -0,0 +1,543 @@
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
+/*
+ * validate_enumeration_input() -
+ * Validate input of current_value against possible values
+ *
+ * @instance_id: The instance on which input is validated
+ * @buf: Input value
+ */
+static int validate_enumeration_input(int instance_id, const char *buf)
+{
+	int ret = 0;
+	int found = 0;
+	int i;
+	int possible_values;
+
+	/* Is it a read only attribute */
+	if (bioscfg_drv.enumeration_data[instance_id].common.is_readonly)
+		return -EIO;
+
+	possible_values = bioscfg_drv.enumeration_data[instance_id].possible_values_size;
+	for (i = 0; i < possible_values && !found; i++)
+		if (!strcasecmp(bioscfg_drv.enumeration_data[instance_id].possible_values[i], buf))
+			found = 1;
+
+	if (!found) {
+		ret = -EINVAL;
+		goto exit_enum_input;
+	}
+
+	/*
+	 * set pending reboot flag depending on
+	 * "RequiresPhysicalPresence" value
+	 */
+	if (bioscfg_drv.enumeration_data[instance_id].common.requires_physical_presence)
+		bioscfg_drv.pending_reboot = true;
+
+exit_enum_input:
+	return ret;
+}
+
+static void update_enumeration_value(int instance_id, char *attr_value)
+{
+	strscpy(bioscfg_drv.enumeration_data[instance_id].current_value,
+		attr_value,
+		sizeof(bioscfg_drv.enumeration_data[instance_id].current_value));
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
+	__ATTR_RW_MODE(current_value, 0644);
+
+ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, enumeration);
+static struct kobj_attribute  enumeration_prerequisites_size_val =
+		__ATTR_RO(prerequisites_size);
+
+ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, enumeration);
+static struct kobj_attribute  enumeration_prerequisites_val =
+		__ATTR_RO(prerequisites);
+
+ATTRIBUTE_N_PROPERTY_SHOW(possible_values_size, enumeration);
+static struct kobj_attribute  enumeration_possible_values_size_val =
+		__ATTR_RO(possible_values_size);
+
+ATTRIBUTE_VALUES_PROPERTY_SHOW(possible_values, enumeration);
+static struct kobj_attribute  enumeration_poss_val =
+		__ATTR_RO(possible_values);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "enumeration\n");
+}
+static struct kobj_attribute enumeration_type =
+		__ATTR_RO(type);
+
+static struct attribute *enumeration_attrs[] = {
+	&enumeration_display_langcode.attr,
+	&enumeration_display_name.attr,
+	&enumeration_current_val.attr,
+	&enumeration_prerequisites_size_val.attr,
+	&enumeration_prerequisites_val.attr,
+	&enumeration_possible_values_size_val.attr,
+	&enumeration_poss_val.attr,
+	&enumeration_type.attr,
+	NULL
+};
+
+static const struct attribute_group enumeration_attr_group = {
+	.attrs = enumeration_attrs,
+};
+
+int alloc_enumeration_data(void)
+{
+	int ret = 0;
+
+	bioscfg_drv.enumeration_instances_count =
+		get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
+
+	bioscfg_drv.enumeration_data = kcalloc(bioscfg_drv.enumeration_instances_count,
+					       sizeof(struct enumeration_data), GFP_KERNEL);
+	if (!bioscfg_drv.enumeration_data) {
+		bioscfg_drv.enumeration_instances_count = 0;
+		ret = -ENOMEM;
+	}
+	return ret;
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
+	[ENUM_POSSIBLE_VALUES] = ACPI_TYPE_STRING
+};
+
+/*
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
+	bioscfg_drv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
+
+	populate_enumeration_elements_from_package(enum_obj,
+						   enum_obj->package.count,
+						   instance_id);
+	update_attribute_permissions(bioscfg_drv.enumeration_data[instance_id].common.is_readonly,
+				     &enumeration_current_val);
+	/*
+	 * Several attributes have names such "MONDAY".  Friendly
+	 * user nane is generated to make the name more descriptive
+	 */
+	friendly_user_name_update(bioscfg_drv.enumeration_data[instance_id].common.path,
+				  attr_name_kobj->name,
+				  bioscfg_drv.enumeration_data[instance_id].common.display_name,
+				  sizeof(bioscfg_drv.enumeration_data[instance_id].common.display_name));
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
+
+	strscpy(bioscfg_drv.enumeration_data[instance_id].common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(bioscfg_drv.enumeration_data[instance_id].common.display_name_language_code));
+
+	for (elem = 1, eloc = 1; elem < enum_obj_count; elem++, eloc++) {
+
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
+
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
+			strscpy(bioscfg_drv.enumeration_data[instance_id].common.path, str_value,
+				sizeof(bioscfg_drv.enumeration_data[instance_id].common.path));
+			break;
+		case IS_READONLY:
+			bioscfg_drv.enumeration_data[instance_id].common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			bioscfg_drv.enumeration_data[instance_id].common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			bioscfg_drv.enumeration_data[instance_id].common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			bioscfg_drv.enumeration_data[instance_id].common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			bioscfg_drv.enumeration_data[instance_id].common.prerequisites_size = int_value;
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
+			size = bioscfg_drv.enumeration_data[instance_id].common.prerequisites_size;
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
+				strlcpy(bioscfg_drv.enumeration_data[instance_id].common.prerequisites[reqs],
+					str_value,
+					sizeof(bioscfg_drv.enumeration_data[instance_id].common.prerequisites[reqs]));
+
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			bioscfg_drv.enumeration_data[instance_id].common.security_level = int_value;
+			break;
+
+		case ENUM_CURRENT_VALUE:
+			strscpy(bioscfg_drv.enumeration_data[instance_id].current_value,
+				str_value, sizeof(bioscfg_drv.enumeration_data[instance_id].current_value));
+			break;
+		case ENUM_SIZE:
+			bioscfg_drv.enumeration_data[instance_id].possible_values_size = int_value;
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
+			size = bioscfg_drv.enumeration_data[instance_id].possible_values_size;
+
+			for (pos_values = 0; pos_values < size && pos_values < MAX_VALUES_SIZE; pos_values++) {
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
+					strlcpy(bioscfg_drv.enumeration_data[instance_id].possible_values[pos_values],
+						str_value,
+						sizeof(bioscfg_drv.enumeration_data[instance_id].possible_values[pos_values]));
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
+/*
+ * populate_enumeration_buffer_data() -
+ * Populate all properties of an instance under enumeration attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @enum_obj: ACPI object with enumeration data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ * @enumeration_property_count: Total properties count under enumeration type
+ */
+int populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+				     int instance_id,
+				     struct kobject *attr_name_kobj)
+{
+
+	bioscfg_drv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
+
+	/* Populate enumeration elements */
+	populate_enumeration_elements_from_buffer(buffer_ptr, buffer_size,
+						  instance_id);
+
+	update_attribute_permissions(bioscfg_drv.enumeration_data[instance_id].common.is_readonly,
+				     &enumeration_current_val);
+	/*
+	 * Several attributes have names such "MONDAY". A Friendlier
+	 * user nane is generated to make the name more descriptive
+	 */
+	friendly_user_name_update(bioscfg_drv.enumeration_data[instance_id].common.path,
+				  attr_name_kobj->name,
+				  bioscfg_drv.enumeration_data[instance_id].common.display_name,
+				  sizeof(bioscfg_drv.enumeration_data[instance_id].common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
+}
+
+int populate_enumeration_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+					      int instance_id)
+{
+	char *dst = NULL;
+	int elem;
+	int reqs;
+	int integer;
+	int size = 0;
+	int values;
+	int ret;
+	int dst_size = *buffer_size / sizeof(u16);
+
+	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+
+	elem = 0;
+
+	strscpy(bioscfg_drv.enumeration_data[instance_id].common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(bioscfg_drv.enumeration_data[instance_id].common.display_name_language_code));
+
+	for (elem = 1; elem < 3; elem++) {
+
+		ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+		/* Ignore. Zero length string values */
+		if (ret < 0)
+			continue;
+
+		switch (elem) {
+		case VALUE:
+			/* Skip 'Value' since 'CurrentValue' is reported. */
+			break;
+		case PATH:
+			strscpy(bioscfg_drv.enumeration_data[instance_id].common.path,
+				dst, sizeof(bioscfg_drv.enumeration_data[instance_id].common.path));
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Enumeration attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+
+	for (elem = 3; elem < ENUM_ELEM_CNT; elem++) {
+		if (PREREQUISITES != elem && ENUM_CURRENT_VALUE != elem && ENUM_POSSIBLE_VALUES != elem) {
+			ret = get_integer_from_buffer((int **)&buffer_ptr, buffer_size, (int *)&integer);
+			if (ret < 0)
+				continue;
+		}
+
+		switch (elem) {
+		case IS_READONLY:
+			bioscfg_drv.enumeration_data[instance_id].common.is_readonly = integer;
+			break;
+		case DISPLAY_IN_UI:
+			bioscfg_drv.enumeration_data[instance_id].common.display_in_ui = integer;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			bioscfg_drv.enumeration_data[instance_id].common.requires_physical_presence = integer;
+			break;
+		case SEQUENCE:
+			bioscfg_drv.enumeration_data[instance_id].common.sequence = integer;
+			break;
+		case PREREQUISITES_SIZE:
+			bioscfg_drv.enumeration_data[instance_id].common.prerequisites_size = integer;
+			if (integer > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			// PREREQUISITES:
+			elem++;
+
+			size = bioscfg_drv.enumeration_data[instance_id].common.prerequisites_size;
+			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
+				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+				/* Ignore. expect zero length strings at the end of prerequisite values */
+				if (ret < 0)
+					continue;
+
+				strscpy(bioscfg_drv.enumeration_data[instance_id].common.prerequisites[reqs],
+					dst,
+					sizeof(bioscfg_drv.enumeration_data[instance_id].common.prerequisites[reqs]));
+			}
+			break;
+		case SECURITY_LEVEL:
+			bioscfg_drv.enumeration_data[instance_id].common.security_level = integer;
+			break;
+		case ENUM_CURRENT_VALUE:
+			ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+			if (ret < 0)
+				continue;
+
+			strscpy(bioscfg_drv.enumeration_data[instance_id].current_value,
+				dst,
+				sizeof(bioscfg_drv.enumeration_data[instance_id].current_value));
+			break;
+		case ENUM_SIZE:
+			bioscfg_drv.enumeration_data[instance_id].possible_values_size = integer;
+			if (integer > MAX_VALUES_SIZE)
+				pr_warn("Possible size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			// ENUM_POSSIBLE_VALUES:
+			elem++;
+
+			size = bioscfg_drv.enumeration_data[instance_id].possible_values_size;
+			for (values = 0; values < size && values < MAX_VALUES_SIZE; values++) {
+				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+				/* Ignore expect zero size strings at the end of all possible values */
+				if (ret < 0)
+					continue;
+
+				strscpy(bioscfg_drv.enumeration_data[instance_id].possible_values[values],
+					dst,
+					sizeof(bioscfg_drv.enumeration_data[instance_id].possible_values[values]));
+			}
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Enumeration attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+
+	kfree(dst);
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
+	for (instance_id = 0; instance_id < bioscfg_drv.enumeration_instances_count; instance_id++) {
+		struct kobject *attr_name_kobj = bioscfg_drv.enumeration_data[instance_id].attr_name_kobj;
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

