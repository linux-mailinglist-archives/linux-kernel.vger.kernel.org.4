Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C533F6E7DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjDSPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjDSPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:02 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F14489;
        Wed, 19 Apr 2023 08:12:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38ba6bd5a79so1268585b6e.2;
        Wed, 19 Apr 2023 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917179; x=1684509179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gT36Agbu21+vDf9VnVykQzz3eSgEq82FyIGTKTVofkg=;
        b=rqpfhfMCFTTw4ls3creQrBctZkN7Knkn1bVrUZFVevZgf4PUE92Df52o+N2/CQVOaT
         /4nvnnLsizFCUYOUetjXZeUgWm8JnsmxCgM6hm/p4RAEqD5fOk7lqFoQoRUEVtkJ52Fn
         YKx2fy/n8sc9DCcNGgMCMBviuDBBWEMETiGd23V0w3AHCcqdiCVBvP3L3UJ/G8SO4Y2k
         Hh8q7Lh0E6LjG8Rp8PzeK5U9+8Fs4dWKc3uClLxrQ4HfLyJm1DwiMskNR97QLbYzPViE
         /686/LZ89YzP7dvqz5ZYYIlcD2LutAS29B/zcEV1R/BHutqJg8Ih9a24SA4y0YTdWQ1U
         Sj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917179; x=1684509179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT36Agbu21+vDf9VnVykQzz3eSgEq82FyIGTKTVofkg=;
        b=aU8lUACBC/fRz67uEATKYcb3PP05ShwK0OXQuh+x9Pri6G8DEgyzWEtz19aKDzE6FM
         N9lszVPwTR0YcKYm0+og4mNYv72dSuNNERvBRdY5m5nnKtsmqH5QWNu44PZKYsi3NLAO
         473bFg7tYsJKyHjiBhbz8Kxj8gwpTLfsnIm0xJMYx7YTlAmiU1YlNo33YCyWXvDhxXaT
         lUYF5bSAGL6oNFZYRE9L5mVDA+9yKchq6kjALUkRCR3y3L9FqCpwDsLzVEaZ9koXYzpf
         x30ppuK1vrmHyjWERMMHO3l+8KfXfhHR/liGXi6lM4quuIomaSMEbpREjcK7Ob+iKJ3+
         PaDQ==
X-Gm-Message-State: AAQBX9c5zvPx3D5RiwSPGBZ708Io2rpMtPSZLz2tNSV4kImum3ZGKS9y
        xvyX27Xwbeopyoc4OzCjUXM=
X-Google-Smtp-Source: AKy350a3UZ2JP/+2TFUwziWq+4DD22d6BgHdHZq1XEZz3Xq6imjMVZi4ZE25fFEfaneg9VqKiSRUtA==
X-Received: by 2002:aca:320b:0:b0:38c:683d:3581 with SMTP id y11-20020aca320b000000b0038c683d3581mr2734611oiy.59.1681917178784;
        Wed, 19 Apr 2023 08:12:58 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id o10-20020acad70a000000b0038bae910f7bsm5766847oig.1.2023.04.19.08.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:12:58 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 04/14] HP BIOSCFG driver  - int-attributes
Date:   Wed, 19 Apr 2023 10:12:44 -0500
Message-Id: <20230419151249.6126-5-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151249.6126-1-jorge.lopez2@hp.com>
References: <20230419151249.6126-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/int-attributes.c        | 474 ++++++++++++++++++
 1 file changed, 474 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
new file mode 100644
index 000000000000..d8ee39dac3f9
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to integer type attributes under
+ * BIOS Enumeration GUID for use with hp-bioscfg driver.
+ *
+ *  Copyright (c) 2022 Hewlett-Packard Inc.
+ */
+
+#include "bioscfg.h"
+
+GET_INSTANCE_ID(integer);
+
+static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int instance_id = get_integer_instance_id(kobj);
+
+	if (instance_id < 0)
+		return instance_id;
+
+	return sysfs_emit(buf, "%d\n",
+			  bioscfg_drv.integer_data[instance_id].current_value);
+}
+
+/*
+ * validate_integer_input() -
+ * Validate input of current_value against lower and upper bound
+ *
+ * @instance_id: The instance on which input is validated
+ * @buf: Input value
+ */
+static int validate_integer_input(int instance_id, char *buf)
+{
+	int in_val;
+	int ret;
+
+
+	/* BIOS treats it as a read only attribute */
+	if (bioscfg_drv.integer_data[instance_id].common.is_readonly)
+		return -EIO;
+
+	ret = kstrtoint(buf, 10, &in_val);
+	if (ret < 0)
+		return ret;
+
+
+	if (in_val < bioscfg_drv.integer_data[instance_id].lower_bound ||
+	    in_val > bioscfg_drv.integer_data[instance_id].upper_bound)
+		return -ERANGE;
+
+	/*
+	 * set pending reboot flag depending on
+	 * "RequiresPhysicalPresence" value
+	 */
+	if (bioscfg_drv.integer_data[instance_id].common.requires_physical_presence)
+		bioscfg_drv.pending_reboot = true;
+	return 0;
+}
+
+static void update_integer_value(int instance_id, char *attr_value)
+{
+	int in_val;
+	int ret;
+
+	ret = kstrtoint(attr_value, 10, &in_val);
+	if (ret == 0)
+		bioscfg_drv.integer_data[instance_id].current_value = in_val;
+}
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, integer);
+static struct kobj_attribute integer_display_langcode =
+	__ATTR_RO(display_name_language_code);
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, integer);
+static struct kobj_attribute integer_display_name =
+	__ATTR_RO(display_name);
+
+ATTRIBUTE_PROPERTY_STORE(current_value, integer);
+static struct kobj_attribute integer_current_val =
+	__ATTR_RW_MODE(current_value, 0644);
+
+ATTRIBUTE_N_PROPERTY_SHOW(lower_bound, integer);
+static struct kobj_attribute integer_lower_bound =
+	__ATTR_RO(lower_bound);
+
+ATTRIBUTE_N_PROPERTY_SHOW(upper_bound, integer);
+static struct kobj_attribute integer_upper_bound =
+	__ATTR_RO(upper_bound);
+
+ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, integer);
+static struct kobj_attribute  integer_prerequisites_size_val =
+	__ATTR_RO(prerequisites_size);
+
+ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, integer);
+static struct kobj_attribute  integer_prerequisites_val =
+	__ATTR_RO(prerequisites);
+
+ATTRIBUTE_N_PROPERTY_SHOW(scalar_increment, integer);
+static struct kobj_attribute integer_scalar_increment =
+	__ATTR_RO(scalar_increment);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "integer\n");
+}
+static struct kobj_attribute integer_type =
+	__ATTR_RO(type);
+
+static struct attribute *integer_attrs[] = {
+	&integer_display_langcode.attr,
+	&integer_display_name.attr,
+	&integer_current_val.attr,
+	&integer_lower_bound.attr,
+	&integer_upper_bound.attr,
+	&integer_scalar_increment.attr,
+	&integer_prerequisites_size_val.attr,
+	&integer_prerequisites_val.attr,
+	&integer_type.attr,
+	NULL
+};
+
+static const struct attribute_group integer_attr_group = {
+	.attrs = integer_attrs,
+};
+
+int alloc_integer_data(void)
+{
+	int ret = 0;
+
+	bioscfg_drv.integer_instances_count = get_instance_count(HP_WMI_BIOS_INTEGER_GUID);
+	bioscfg_drv.integer_data = kcalloc(bioscfg_drv.integer_instances_count,
+					   sizeof(struct integer_data), GFP_KERNEL);
+
+	if (!bioscfg_drv.integer_data) {
+		bioscfg_drv.integer_instances_count = 0;
+		ret = -ENOMEM;
+	}
+	return ret;
+}
+
+/* Expected Values types associated with each element */
+static const acpi_object_type expected_integer_types[] = {
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
+	[INT_LOWER_BOUND] = ACPI_TYPE_INTEGER,
+	[INT_UPPER_BOUND] = ACPI_TYPE_INTEGER,
+	[INT_SCALAR_INCREMENT] = ACPI_TYPE_INTEGER
+};
+
+/*
+ * populate_int_data() -
+ * Populate all properties of an instance under integer attribute
+ *
+ * @integer_obj: ACPI object with integer data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_integer_package_data(union acpi_object *integer_obj,
+				  int instance_id,
+				  struct kobject *attr_name_kobj)
+{
+	bioscfg_drv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
+	populate_integer_elements_from_package(integer_obj,
+					       integer_obj->package.count,
+					       instance_id);
+	update_attribute_permissions(bioscfg_drv.integer_data[instance_id].common.is_readonly,
+				     &integer_current_val);
+	friendly_user_name_update(bioscfg_drv.integer_data[instance_id].common.path,
+				  attr_name_kobj->name,
+				  bioscfg_drv.integer_data[instance_id].common.display_name,
+				  sizeof(bioscfg_drv.integer_data[instance_id].common.display_name));
+	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
+}
+
+int populate_integer_elements_from_package(union acpi_object *integer_obj,
+					   int integer_obj_count,
+					   int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	int ret = 0;
+	u32 size = 0;
+	u32 int_value;
+	int elem = 0;
+	int reqs;
+	int eloc;
+
+	if (!integer_obj)
+		return -EINVAL;
+
+	strscpy(bioscfg_drv.integer_data[instance_id].common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(bioscfg_drv.integer_data[instance_id].common.display_name_language_code));
+
+	for (elem = 1, eloc = 1; elem < integer_obj_count; elem++, eloc++) {
+
+		/* ONLY look at the first INTEGER_ELEM_CNT elements */
+		if (eloc == INTEGER_ELEM_CNT)
+			goto exit_integer_package;
+
+		switch (integer_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+
+			if (elem != PREREQUISITES) {
+				ret = convert_hexstr_to_str(integer_obj[elem].string.pointer,
+							    integer_obj[elem].string.length,
+							    &str_value, &value_len);
+				if (ret)
+					continue;
+			}
+			break;
+		case ACPI_TYPE_INTEGER:
+			int_value = (u32)integer_obj[elem].integer.value;
+			break;
+		default:
+			pr_warn("Unsupported object type [%d]\n", integer_obj[elem].type);
+			continue;
+		}
+		/* Check that both expected and read object type match */
+		if (expected_integer_types[eloc] != integer_obj[elem].type) {
+			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
+			       expected_integer_types[eloc], elem, integer_obj[elem].type);
+			return -EIO;
+		}
+		/* Assign appropriate element value to corresponding field*/
+		switch (eloc) {
+		case VALUE:
+			ret = kstrtoint(str_value, 10, &int_value);
+			if (ret)
+				continue;
+
+			bioscfg_drv.integer_data[instance_id].current_value = int_value;
+			break;
+		case PATH:
+			strscpy(bioscfg_drv.integer_data[instance_id].common.path, str_value,
+				sizeof(bioscfg_drv.integer_data[instance_id].common.path));
+			break;
+		case IS_READONLY:
+			bioscfg_drv.integer_data[instance_id].common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			bioscfg_drv.integer_data[instance_id].common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			bioscfg_drv.integer_data[instance_id].common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			bioscfg_drv.integer_data[instance_id].common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			bioscfg_drv.integer_data[instance_id].common.prerequisites_size = int_value;
+
+			if (int_value > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
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
+		case PREREQUISITES:
+			size = bioscfg_drv.integer_data[instance_id].common.prerequisites_size;
+
+			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
+				if (elem >= integer_obj_count) {
+					pr_err("Error elem-objects package is too small\n");
+					return -EINVAL;
+				}
+
+				ret = convert_hexstr_to_str(integer_obj[elem + reqs].string.pointer,
+							    integer_obj[elem + reqs].string.length,
+							    &str_value, &value_len);
+
+				if (ret)
+					continue;
+
+				strscpy(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs],
+					str_value,
+					sizeof(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs]));
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			bioscfg_drv.integer_data[instance_id].common.security_level = int_value;
+			break;
+		case INT_LOWER_BOUND:
+			bioscfg_drv.integer_data[instance_id].lower_bound = int_value;
+			break;
+		case INT_UPPER_BOUND:
+			bioscfg_drv.integer_data[instance_id].upper_bound = int_value;
+			break;
+		case INT_SCALAR_INCREMENT:
+			bioscfg_drv.integer_data[instance_id].scalar_increment = int_value;
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+exit_integer_package:
+	kfree(str_value);
+	return 0;
+}
+
+
+/*
+ * populate_integer_buffer_data() -
+ * Populate all properties of an instance under integer attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
+				 struct kobject *attr_name_kobj)
+{
+	bioscfg_drv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
+
+	/* Populate integer elements */
+	populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
+					      instance_id);
+	update_attribute_permissions(bioscfg_drv.integer_data[instance_id].common.is_readonly,
+				     &integer_current_val);
+	friendly_user_name_update(bioscfg_drv.integer_data[instance_id].common.path,
+				  attr_name_kobj->name,
+				  bioscfg_drv.integer_data[instance_id].common.display_name,
+				  sizeof(bioscfg_drv.integer_data[instance_id].common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
+}
+
+int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+					  int instance_id)
+{
+	char *dst = NULL;
+	int elem;
+	int reqs;
+	int integer;
+	int size = 0;
+	int ret;
+	int dst_size = *buffer_size / sizeof(u16);
+
+	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+
+	elem = 0;
+	strscpy(bioscfg_drv.integer_data[instance_id].common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(bioscfg_drv.integer_data[instance_id].common.display_name_language_code));
+
+	for (elem = 1; elem < 3; elem++) {
+
+		ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+		if (ret < 0)
+			continue;
+
+		switch (elem) {
+		case VALUE:
+			ret = kstrtoint(dst, 10, &integer);
+			if (ret)
+				continue;
+
+			bioscfg_drv.integer_data[instance_id].current_value = integer;
+			break;
+		case PATH:
+			strscpy(bioscfg_drv.integer_data[instance_id].common.path, dst,
+				sizeof(bioscfg_drv.integer_data[instance_id].common.path));
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+
+	for (elem = 3; elem < INTEGER_ELEM_CNT; elem++) {
+
+		if (elem != PREREQUISITES) {
+			ret = get_integer_from_buffer((int **)&buffer_ptr, buffer_size, (int *)&integer);
+			if (ret < 0)
+				continue;
+		}
+
+		switch (elem) {
+
+		case IS_READONLY:
+			bioscfg_drv.integer_data[instance_id].common.is_readonly = integer;
+			break;
+		case DISPLAY_IN_UI:
+			bioscfg_drv.integer_data[instance_id].common.display_in_ui = integer;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			bioscfg_drv.integer_data[instance_id].common.requires_physical_presence = integer;
+			break;
+		case SEQUENCE:
+			bioscfg_drv.integer_data[instance_id].common.sequence = integer;
+			break;
+		case PREREQUISITES_SIZE:
+			bioscfg_drv.integer_data[instance_id].common.prerequisites_size = integer;
+			size = integer;
+			if (size > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			// PREREQUISITES:
+			elem++;
+			for (reqs = 0; reqs < size && reqs  < MAX_PREREQUISITES_SIZE; reqs++) {
+				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+				if (ret < 0)
+					continue;
+
+				strscpy(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs],
+					dst,
+					sizeof(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs]));
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			bioscfg_drv.integer_data[instance_id].common.security_level = integer;
+			break;
+		case INT_LOWER_BOUND:
+			bioscfg_drv.integer_data[instance_id].lower_bound = integer;
+			break;
+		case INT_UPPER_BOUND:
+			bioscfg_drv.integer_data[instance_id].upper_bound = integer;
+			break;
+		case INT_SCALAR_INCREMENT:
+			bioscfg_drv.integer_data[instance_id].scalar_increment = integer;
+			break;
+
+		default:
+			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+	kfree(dst);
+
+	return 0;
+}
+
+/*
+ * exit_integer_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void exit_integer_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.integer_instances_count; instance_id++) {
+
+		struct kobject *attr_name_kobj = bioscfg_drv.integer_data[instance_id].attr_name_kobj;
+
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj, &integer_attr_group);
+	}
+	bioscfg_drv.integer_instances_count = 0;
+
+	kfree(bioscfg_drv.integer_data);
+	bioscfg_drv.integer_data = NULL;
+}
-- 
2.34.1

