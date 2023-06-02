Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114027202C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjFBNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjFBNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:11:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FA1BF;
        Fri,  2 Jun 2023 06:10:56 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3909756b8b1so895729b6e.1;
        Fri, 02 Jun 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711455; x=1688303455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G49atfAQCgSCYBfeGPg2LE9mmP22glB+FYscmE+VeHo=;
        b=V3y8xygPuKwntv2luacIZqYS5YXadR5C40+Z/oZE4540GHYzZb3QcxtnRs9H1vojVm
         6yRYN32/mwpJJB1Yge7Yfdq/afgmsyLsdi6mDg4VDD81Ol+3tPWwVTqLKkg4JTRih8rj
         tZuTdYkjw/9DUK87VQNISVuRlpy+QkTeW3rsSLg2y62Wo/CwMtoOHYTtMmmbfpR9U/Wc
         vnIJDMcTkVsryiU5QJuFQMVx+KRT02cNVNqd5VL0O4DkvjdCNWVwAHaCn8ZDRSRe1h/K
         BdIIRTbvPekR9Gzq7N8CmK00h2ta4YDOsDSq6EjTPUt/XRjXzZIaFOpXzjVnhSd35MrL
         8zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711455; x=1688303455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G49atfAQCgSCYBfeGPg2LE9mmP22glB+FYscmE+VeHo=;
        b=bjeOAA02Mm5HXdWSy90s2HwthUMOSRuXtKz8r7S3gBq4s2OHjbPGvOm49XtRVOMglc
         KV/btdTiPyq7qqrZna1QsY/ZaCpZvSwQG2TUosyt4XVRvUAiv+IA2HWGU4TXnxu/ITV8
         YfZ9k6PE/nrYSeQY6w8OuhPJuOg97YsR67mN81efhu4/pLRuvvteu+7uN+IOIRsZDAs+
         DEc3D/vBo6mq2yahbeyd/d/rk0LzDHHE48DRaqPXutcl+JCZfy/whDEFuG7dedkh8Oxx
         7n10YwviIP4hjWalZEsAHWBZfdmcLGkCf5RTlrJkMQLtZnv85M9SPCGarilLI/F8Wiy9
         VYpg==
X-Gm-Message-State: AC+VfDyuUFn9LBw7TM0M8stHvchEH7RT+VqAMTlaRDPXaRPC0EhFi5Yx
        kGEFfIFckkQvwfr4P1ve3VA=
X-Google-Smtp-Source: ACHHUZ6CNgEZPSrzXw36MTbhl32T1ti10S+QwiuuQkQgb5f0Halk+Tif3zQgJ4fcjUwbAVxBC1KAEw==
X-Received: by 2002:a54:4691:0:b0:39a:815d:8ab6 with SMTP id k17-20020a544691000000b0039a815d8ab6mr607187oic.34.1685711455246;
        Fri, 02 Jun 2023 06:10:55 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:125c:6b6d:18e9:9361])
        by smtp.gmail.com with ESMTPSA id k17-20020a544691000000b0039a531d9b92sm483762oic.56.2023.06.02.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:10:54 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v16 07/13] hp-bioscfg: order-list-attributes
Date:   Fri,  2 Jun 2023 08:10:38 -0500
Message-Id: <20230602131044.3297-8-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602131044.3297-1-jorge.lopez2@hp.com>
References: <20230602131044.3297-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 451 ++++++++++++++++++
 1 file changed, 451 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
new file mode 100644
index 000000000000..6a4cb8e53108
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to ordered list type attributes under
+ * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
+ *
+ * Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+
+GET_INSTANCE_ID(ordered_list);
+
+static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int instance_id = get_ordered_list_instance_id(kobj);
+
+	if (instance_id < 0)
+		return -EIO;
+
+	return sysfs_emit(buf, "%s\n",
+			 bioscfg_drv.ordered_list_data[instance_id].current_value);
+}
+
+static int replace_char_str(u8 *buffer, char *repl_char, char *repl_with)
+{
+	char *src = buffer;
+	int buflen = strlen(buffer);
+	int item;
+
+	if (buflen < 1)
+		return -EINVAL;
+
+	for (item = 0; item < buflen; item++)
+		if (src[item] == *repl_char)
+			src[item] = *repl_with;
+
+	return 0;
+}
+
+/**
+ * validate_ordered_list_input() -
+ * Validate input of current_value against possible values
+ *
+ * @instance: The instance on which input is validated
+ * @buf: Input value
+ */
+static int validate_ordered_list_input(int instance, char *buf)
+{
+	/* validation is done by BIOS. This validation function will
+	 * convert semicolon to commas. BIOS uses commas as
+	 * separators when reporting ordered-list values.
+	 */
+	return replace_char_str(buf, SEMICOLON_SEP, COMMA_SEP);
+}
+
+static void update_ordered_list_value(int instance, char *attr_value)
+{
+	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance];
+
+	strscpy(ordered_list_data->current_value,
+		attr_value,
+		sizeof(ordered_list_data->current_value));
+}
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, ordered_list);
+static struct kobj_attribute ordered_list_display_name =
+	__ATTR_RO(display_name);
+
+ATTRIBUTE_PROPERTY_STORE(current_value, ordered_list);
+static struct kobj_attribute ordered_list_current_val =
+	__ATTR_RW_MODE(current_value, 0644);
+
+ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list, SEMICOLON_SEP);
+static struct kobj_attribute ordered_list_elements_val =
+	__ATTR_RO(elements);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "ordered-list\n");
+}
+
+static struct kobj_attribute ordered_list_type =
+	__ATTR_RO(type);
+
+static struct attribute *ordered_list_attrs[] = {
+	&common_display_langcode.attr,
+	&ordered_list_display_name.attr,
+	&ordered_list_current_val.attr,
+	&ordered_list_elements_val.attr,
+	&ordered_list_type.attr,
+	NULL
+};
+
+static const struct attribute_group ordered_list_attr_group = {
+	.attrs = ordered_list_attrs,
+};
+
+int hp_alloc_ordered_list_data(void)
+{
+	bioscfg_drv.ordered_list_instances_count =
+		hp_get_instance_count(HP_WMI_BIOS_ORDERED_LIST_GUID);
+	bioscfg_drv.ordered_list_data = kcalloc(bioscfg_drv.ordered_list_instances_count,
+						sizeof(*bioscfg_drv.ordered_list_data),
+						GFP_KERNEL);
+	if (!bioscfg_drv.ordered_list_data) {
+		bioscfg_drv.ordered_list_instances_count = 0;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* Expected Values types associated with each element */
+static const acpi_object_type expected_order_types[] = {
+	[NAME]	= ACPI_TYPE_STRING,
+	[VALUE] = ACPI_TYPE_STRING,
+	[PATH] = ACPI_TYPE_STRING,
+	[IS_READONLY] = ACPI_TYPE_INTEGER,
+	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
+	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
+	[SEQUENCE] = ACPI_TYPE_INTEGER,
+	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
+	[PREREQUISITES] = ACPI_TYPE_STRING,
+	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
+	[ORD_LIST_SIZE] = ACPI_TYPE_INTEGER,
+	[ORD_LIST_ELEMENTS] = ACPI_TYPE_STRING,
+};
+
+static int hp_populate_ordered_list_elements_from_package(union acpi_object *order_obj,
+							  int order_obj_count,
+							  int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	int ret;
+	u32 size;
+	u32 int_value;
+	int elem;
+	int reqs;
+	int eloc;
+	char *tmpstr = NULL;
+	char *part_tmp = NULL;
+	int tmp_len = 0;
+	char *part = NULL;
+	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
+
+	if (!order_obj)
+		return -EINVAL;
+
+	for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
+		/* ONLY look at the first ORDERED_ELEM_CNT elements */
+		if (eloc == ORD_ELEM_CNT)
+			goto exit_list;
+
+		switch (order_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+			if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
+				ret = hp_convert_hexstr_to_str(order_obj[elem].string.pointer,
+							       order_obj[elem].string.length,
+							       &str_value, &value_len);
+				if (ret)
+					continue;
+			}
+			break;
+		case ACPI_TYPE_INTEGER:
+			int_value = (u32)order_obj[elem].integer.value;
+			break;
+		default:
+			pr_warn("Unsupported object type [%d]\n", order_obj[elem].type);
+			continue;
+		}
+
+		/* Check that both expected and read object type match */
+		if (expected_order_types[eloc] != order_obj[elem].type) {
+			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
+			       expected_order_types[eloc], elem, order_obj[elem].type);
+			return -EIO;
+		}
+
+		/* Assign appropriate element value to corresponding field*/
+		switch (eloc) {
+		case VALUE:
+			strscpy(ordered_list_data->current_value,
+				str_value, sizeof(ordered_list_data->current_value));
+			replace_char_str(ordered_list_data->current_value, COMMA_SEP, SEMICOLON_SEP);
+			break;
+		case PATH:
+			strscpy(ordered_list_data->common.path, str_value,
+				sizeof(ordered_list_data->common.path));
+			break;
+		case IS_READONLY:
+			ordered_list_data->common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			ordered_list_data->common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			ordered_list_data->common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			ordered_list_data->common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			ordered_list_data->common.prerequisites_size = int_value;
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
+		case PREREQUISITES:
+			size = min_t(u32, ordered_list_data->common.prerequisites_size,
+				     MAX_PREREQUISITES_SIZE);
+			for (reqs = 0; reqs < size; reqs++) {
+				ret = hp_convert_hexstr_to_str(order_obj[elem + reqs].string.pointer,
+							       order_obj[elem + reqs].string.length,
+							       &str_value, &value_len);
+
+				if (ret)
+					continue;
+
+				strscpy(ordered_list_data->common.prerequisites[reqs],
+					str_value,
+					sizeof(ordered_list_data->common.prerequisites[reqs]));
+
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			ordered_list_data->common.security_level = int_value;
+			break;
+
+		case ORD_LIST_SIZE:
+			ordered_list_data->elements_size = int_value;
+			if (int_value > MAX_ELEMENTS_SIZE)
+				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
+			/*
+			 * This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero. ORD_LIST_ELEMENTS
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+		case ORD_LIST_ELEMENTS:
+			size = ordered_list_data->elements_size;
+
+			/*
+			 * Ordered list data is stored in hex and comma separated format
+			 * Convert the data and split it to show each element
+			 */
+			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
+			if (ret)
+				goto exit_list;
+
+			part_tmp = tmpstr;
+			part = strsep(&part_tmp, COMMA_SEP);
+			if (!part)
+				strscpy(ordered_list_data->elements[0],
+					tmpstr,
+					sizeof(ordered_list_data->elements[0]));
+
+			for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
+				strscpy(ordered_list_data->elements[elem],
+					part,
+					sizeof(ordered_list_data->elements[elem]));
+				part = strsep(&part_tmp, SEMICOLON_SEP);
+			}
+
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Ordered_List attribute or data may be malformed\n", elem);
+			break;
+		}
+		kfree(tmpstr);
+		kfree(str_value);
+	}
+
+exit_list:
+	kfree(tmpstr);
+	kfree(str_value);
+	return 0;
+}
+
+/**
+ * hp_populate_ordered_list_package_data() -
+ * Populate all properties of an instance under ordered_list attribute
+ *
+ * @order_obj: ACPI object with ordered_list data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_ordered_list_package_data(union acpi_object *order_obj, int instance_id,
+					  struct kobject *attr_name_kobj)
+{
+	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
+
+	ordered_list_data->attr_name_kobj = attr_name_kobj;
+
+	hp_populate_ordered_list_elements_from_package(order_obj,
+						       order_obj->package.count,
+						       instance_id);
+	hp_update_attribute_permissions(ordered_list_data->common.is_readonly,
+					&ordered_list_current_val);
+	hp_friendly_user_name_update(ordered_list_data->common.path,
+				     attr_name_kobj->name,
+				     ordered_list_data->common.display_name,
+				     sizeof(ordered_list_data->common.display_name));
+	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
+}
+
+static int hp_populate_ordered_list_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+							 int instance_id)
+{
+	int reqs;
+	int values;
+	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
+
+	/*
+	 * In earlier implementation, reported errors were ignored
+	 * causing the data to remain uninitialized. It is for this
+	 * reason functions may return an error and no validation
+	 * takes place.
+	 */
+
+	// VALUE:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_data->current_value,
+				  sizeof(ordered_list_data->current_value));
+	replace_char_str(ordered_list_data->current_value, COMMA_SEP, SEMICOLON_SEP);
+
+	// PATH:
+	hp_get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_data->common.path,
+				  sizeof(ordered_list_data->common.path));
+
+	// IS_READONLY:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->common.is_readonly);
+
+	//DISPLAY_IN_UI:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->common.display_in_ui);
+
+	// REQUIRES_PHYSICAL_PRESENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->common.requires_physical_presence);
+
+	// SEQUENCE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->common.sequence);
+
+	// PREREQUISITES_SIZE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->common.prerequisites_size);
+
+	if (ordered_list_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
+		/* Report a message and limit prerequisite size to maximum value */
+		pr_warn("String Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+		ordered_list_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
+	}
+
+	// PREREQUISITES:
+	for (reqs = 0; reqs < ordered_list_data->common.prerequisites_size; reqs++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  ordered_list_data->common.prerequisites[reqs],
+					  sizeof(ordered_list_data->common.prerequisites[reqs]));
+
+	// SECURITY_LEVEL:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->common.security_level);
+
+	// ORD_LIST_SIZE:
+	hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
+				   &ordered_list_data->elements_size);
+
+	if (ordered_list_data->elements_size > MAX_ELEMENTS_SIZE) {
+		/* Report a message and limit elements size to maximum value */
+		pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
+		ordered_list_data->elements_size = MAX_ELEMENTS_SIZE;
+	}
+
+	// ORD_LIST_ELEMENTS:
+	for (values = 0; values < ordered_list_data->elements_size; values++)
+		hp_get_string_from_buffer(&buffer_ptr, buffer_size,
+					  ordered_list_data->elements[values],
+					  sizeof(ordered_list_data->elements[values]));
+
+	return 0;
+}
+
+/**
+ * hp_populate_ordered_list_buffer_data() - Populate all properties of an
+ * instance under ordered list attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int hp_populate_ordered_list_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
+					 struct kobject *attr_name_kobj)
+{
+	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
+
+	ordered_list_data->attr_name_kobj = attr_name_kobj;
+
+	/* Populate ordered list elements */
+	hp_populate_ordered_list_elements_from_buffer(buffer_ptr, buffer_size,
+						      instance_id);
+	hp_update_attribute_permissions(ordered_list_data->common.is_readonly,
+					&ordered_list_current_val);
+	hp_friendly_user_name_update(ordered_list_data->common.path,
+				     attr_name_kobj->name,
+				     ordered_list_data->common.display_name,
+				     sizeof(ordered_list_data->common.display_name));
+
+	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
+}
+
+/**
+ * hp_exit_ordered_list_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void hp_exit_ordered_list_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.ordered_list_instances_count;
+	     instance_id++) {
+		struct kobject *attr_name_kobj =
+			bioscfg_drv.ordered_list_data[instance_id].attr_name_kobj;
+
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj,
+					   &ordered_list_attr_group);
+	}
+	bioscfg_drv.ordered_list_instances_count = 0;
+
+	kfree(bioscfg_drv.ordered_list_data);
+	bioscfg_drv.ordered_list_data = NULL;
+}
-- 
2.34.1

