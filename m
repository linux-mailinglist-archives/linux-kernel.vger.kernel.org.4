Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3099B6E7DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjDSPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDSPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C43FA;
        Wed, 19 Apr 2023 08:13:01 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38be7a5ab37so1156312b6e.3;
        Wed, 19 Apr 2023 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917181; x=1684509181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmAixmqpOZCl9cw1rEFGwiFV9Ovec6fyIqpA7BgeVOM=;
        b=kFUce2EvomVbAw99MsefpO0ywxvv8cXfcpUgvuTGDxVzaoVe0mpElpNe0dzOndIYJo
         wtGSYZEOOuPXnwBA5ocpgNNwujLLy4NeJwmoNSKYzBu/qxVELfd1SYSfrYgkwuHh06of
         EZyqZ+eqbGPpYXvq0K83L9XvWA5eDtkSEKR7AHQQzDz66TKKoJMnWRyUi29INaUtLsq6
         yHhbFib7UEOlpUjUzZAWi9ANMNh4vWpE5iZUTzYnCPqIc1qTR831731aNaGDhdT6na8q
         W/Kbfwyi088iNSkziYLmKUGN9mJP6z3c5/XXtZ0Lp+Qonep54JvQfQfsFtkaKI/yBedv
         iXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917181; x=1684509181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmAixmqpOZCl9cw1rEFGwiFV9Ovec6fyIqpA7BgeVOM=;
        b=jl278ibh63SUKL8kq9noaY92rA//YhPLY4Fy2yDATJzNhWhU30bbUSTKN5G3prsX5X
         tqYhPxUvIKk+npoNEKup4Fb8t0M6xoIvEF9jtQhPKGkMMBmePx6oH5a/SXYADbDpmenE
         gBq1qILS4KA655ihq8wHBQ5puYkHvkWEvLCullGqRx/TMlmv8xbdFwGlQ/+VEDDCpJYF
         3Oze82G2KJQNMDrafErGoWxyDaBGhasWzLpfpWlzpw6c8O3BVHdOeYcIBe4QSudLlGaI
         5cOpYWfBhDXYjeaflII/ogbcTuEr0hyoOyfrU5bz7ciL3aIUoF+Tjat+6xeBrbl9cFjG
         mSWA==
X-Gm-Message-State: AAQBX9fdwER8h1NeZuiPaH3nudxuAjBvX3apMAr6mA+Pp4O5vn6HlpGr
        Qu7v/G30D8sroXwR5PtlYgE=
X-Google-Smtp-Source: AKy350Ycfhppm8vteze9s5thTsl0QQE3e8tnWsWu6zOvRiNzvJVPUQ3EZTuiRhxnmAzQJXwncfowtQ==
X-Received: by 2002:a05:6808:2790:b0:389:15a5:179e with SMTP id es16-20020a056808279000b0038915a5179emr2706051oib.20.1681917181082;
        Wed, 19 Apr 2023 08:13:01 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id o10-20020acad70a000000b0038bae910f7bsm5766847oig.1.2023.04.19.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:00 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 06/14] HP BIOSCFG driver  - passwdobj-attributes
Date:   Wed, 19 Apr 2023 10:12:46 -0500
Message-Id: <20230419151249.6126-7-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 668 ++++++++++++++++++
 1 file changed, 668 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
new file mode 100644
index 000000000000..861fad3baed4
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -0,0 +1,668 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to password object type attributes under
+ * BIOS PASSWORD for use with hp-bioscfg driver.
+ *
+ *  Copyright (c) 2022 HP Development Company, L.P.
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
+int clear_passwords(const int instance)
+{
+	if (!bioscfg_drv.password_data[instance].is_enabled)
+		return 0;
+
+	memset(bioscfg_drv.password_data[instance].current_password,
+	       0, sizeof(bioscfg_drv.password_data[instance].current_password));
+	memset(bioscfg_drv.password_data[instance].new_password,
+	       0, sizeof(bioscfg_drv.password_data[instance].new_password));
+
+	return 0;
+}
+
+/*
+ * Clear all credentials copied to memory for both Power-ON and Setup
+ * BIOS instances
+ */
+int clear_all_credentials(void)
+{
+	int instance;
+
+	/* clear all passwords */
+	for (instance = 0; instance < bioscfg_drv.password_instances_count; instance++)
+		clear_passwords(instance);
+
+	/* clear auth_token */
+	kfree(bioscfg_drv.spm_data.auth_token);
+	bioscfg_drv.spm_data.auth_token = NULL;
+
+	return 0;
+}
+
+int get_password_instance_for_type(const char *name)
+{
+	int count = bioscfg_drv.password_instances_count;
+	int instance;
+
+	for (instance = 0; instance < count; instance++) {
+		if (strcmp(bioscfg_drv.password_data[instance].common.display_name, name) == 0)
+			return instance;
+	}
+	return -EINVAL;
+}
+
+int validate_password_input(int instance_id, const char *buf)
+{
+	int length;
+
+	length = strlen(buf);
+	if (buf[length-1] == '\n')
+		length--;
+
+	if (length > MAX_PASSWD_SIZE)
+		return INVALID_BIOS_AUTH;
+
+	if (bioscfg_drv.password_data[instance_id].min_password_length > length ||
+	    bioscfg_drv.password_data[instance_id].max_password_length < length)
+		return INVALID_BIOS_AUTH;
+	return SUCCESS;
+}
+
+int password_is_set(const char *name)
+{
+	int id;
+
+	id = get_password_instance_for_type(name);
+	if (id < 0)
+		return 0;
+
+	return bioscfg_drv.password_data[id].is_enabled;
+}
+
+ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
+static struct kobj_attribute password_is_password_set = __ATTR_RO(is_enabled);
+
+static ssize_t current_password_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	char *p, *buf_cp;
+	int id, ret = 0;
+
+	buf_cp = kstrdup(buf, GFP_KERNEL);
+	if (!buf_cp) {
+		ret = -ENOMEM;
+		goto exit_password;
+	}
+
+	p = memchr(buf_cp, '\n', count);
+
+	if (p != NULL)
+		*p = '\0';
+
+	id = get_password_instance_id(kobj);
+
+	if (id >= 0)
+		ret = validate_password_input(id, buf_cp);
+
+	if (!ret) {
+		strscpy(bioscfg_drv.password_data[id].current_password,
+			buf_cp,
+			sizeof(bioscfg_drv.password_data[id].current_password));
+		/*
+		 * set pending reboot flag depending on
+		 * "RequiresPhysicalPresence" value
+		 */
+		if (bioscfg_drv.password_data[id].common.requires_physical_presence)
+			bioscfg_drv.pending_reboot = true;
+	}
+
+exit_password:
+	kfree(buf_cp);
+	return ret ? ret : count;
+}
+static struct kobj_attribute password_current_password = __ATTR_WO(current_password);
+
+static ssize_t new_password_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
+{
+	char *p, *buf_cp = NULL;
+	int id, ret = -EIO;
+
+	buf_cp = kstrdup(buf, GFP_KERNEL);
+	if (!buf_cp) {
+		ret = -ENOMEM;
+		goto exit_password;
+	}
+
+	p = memchr(buf_cp, '\n', count);
+
+	if (p != NULL)
+		*p = '\0';
+
+	id = get_password_instance_id(kobj);
+
+	if (id >= 0)
+		ret = validate_password_input(id, buf_cp);
+
+	if (!ret)
+		strscpy(bioscfg_drv.password_data[id].new_password,
+			buf_cp,
+			sizeof(bioscfg_drv.password_data[id].new_password));
+
+	if (!ret)
+		ret = hp_set_attribute(kobj->name, buf_cp);
+
+exit_password:
+	/*
+	 * Regardless of the results both new and current passwords
+	 * will be set to zero and avoid security issues
+	 */
+	clear_passwords(id);
+
+	kfree(buf_cp);
+	return ret ? ret : count;
+}
+
+static struct kobj_attribute password_new_password = __ATTR_WO(new_password);
+
+
+ATTRIBUTE_N_PROPERTY_SHOW(min_password_length, password);
+static struct kobj_attribute password_min_password_length = __ATTR_RO(min_password_length);
+
+ATTRIBUTE_N_PROPERTY_SHOW(max_password_length, password);
+static struct kobj_attribute password_max_password_length = __ATTR_RO(max_password_length);
+
+static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	if (strcmp(kobj->name, SETUP_PASSWD) == 0)
+		return sysfs_emit(buf, "%s\n", BIOS_ADMIN);
+
+	if (strcmp(kobj->name, POWER_ON_PASSWD) == 0)
+		return sysfs_emit(buf,  "%s\n", POWER_ON);
+
+	return -EIO;
+}
+static struct kobj_attribute password_role = __ATTR_RO(role);
+
+static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
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
+static struct kobj_attribute password_mechanism = __ATTR_RO(mechanism);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "password\n");
+}
+static struct kobj_attribute password_type = __ATTR_RO(type);
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, password);
+static struct kobj_attribute password_display_name =
+		__ATTR_RO(display_name);
+
+ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, password);
+static struct kobj_attribute password_display_langcode =
+		__ATTR_RO(display_name_language_code);
+
+ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, password);
+static struct kobj_attribute  password_prerequisites_size_val =
+		__ATTR_RO(prerequisites_size);
+
+ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, password);
+static struct kobj_attribute  password_prerequisites_val =
+		__ATTR_RO(prerequisites);
+
+ATTRIBUTE_N_PROPERTY_SHOW(encodings_size, password);
+static struct kobj_attribute  password_encodings_size_val =
+		__ATTR_RO(encodings_size);
+
+ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password);
+static struct kobj_attribute  password_encodings_val =
+		__ATTR_RO(encodings);
+
+
+static struct attribute *password_attrs[] = {
+	&password_is_password_set.attr,
+	&password_min_password_length.attr,
+	&password_max_password_length.attr,
+	&password_current_password.attr,
+	&password_new_password.attr,
+	&password_role.attr,
+	&password_mechanism.attr,
+	&password_type.attr,
+	&password_display_name.attr,
+	&password_display_langcode.attr,
+	&password_prerequisites_size_val.attr,
+	&password_prerequisites_val.attr,
+	&password_encodings_val.attr,
+	&password_encodings_size_val.attr,
+	NULL
+};
+
+static const struct attribute_group bios_password_attr_group = {
+	.attrs = password_attrs
+};
+
+static const struct attribute_group system_password_attr_group = {
+	.attrs = password_attrs
+};
+
+int alloc_password_data(void)
+{
+	int ret = 0;
+
+	bioscfg_drv.password_instances_count = get_instance_count(HP_WMI_BIOS_PASSWORD_GUID);
+	bioscfg_drv.password_data = kcalloc(bioscfg_drv.password_instances_count,
+					    sizeof(struct password_data), GFP_KERNEL);
+	if (!bioscfg_drv.password_data) {
+		bioscfg_drv.password_instances_count = 0;
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+/*
+ * populate_password_package_data -
+ *	Populate all properties for an instance under password attribute
+ *
+ * @password_obj: ACPI object with password data
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_password_package_data(union acpi_object *password_obj, int instance_id,
+				   struct kobject *attr_name_kobj)
+{
+	bioscfg_drv.password_data[instance_id].attr_name_kobj = attr_name_kobj;
+
+	populate_password_elements_from_package(password_obj,
+						password_obj->package.count,
+						instance_id);
+
+	if (strcmp(attr_name_kobj->name, "Setup Password") == 0) {
+		/* Save  system authentication instance for easy access */
+		return sysfs_create_group(attr_name_kobj, &bios_password_attr_group);
+	}
+
+	return sysfs_create_group(attr_name_kobj, &system_password_attr_group);
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
+	[PSWD_IS_SET] = ACPI_TYPE_INTEGER
+};
+
+
+int populate_password_elements_from_package(union acpi_object *password_obj,
+					    int password_obj_count,
+					    int instance_id)
+{
+	char *str_value = NULL;
+	int value_len;
+	int ret = 0;
+	u32 size = 0;
+	u32 int_value;
+	int elem = 0;
+	int reqs;
+	int eloc;
+	int pos_values;
+
+
+	if (!password_obj)
+		return -EINVAL;
+
+	strscpy(bioscfg_drv.password_data[instance_id].common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(bioscfg_drv.password_data[instance_id].common.display_name_language_code));
+
+	for (elem = 1, eloc = 1; elem < password_obj_count; elem++, eloc++) {
+
+		/* ONLY look at the first PASSWORD_ELEM_CNT elements */
+		if (eloc == PASSWORD_ELEM_CNT)
+			goto exit_package;
+
+		switch (password_obj[elem].type) {
+		case ACPI_TYPE_STRING:
+
+			if (PREREQUISITES != elem && PSWD_ENCODINGS != elem) {
+				ret = convert_hexstr_to_str(password_obj[elem].string.pointer,
+							    password_obj[elem].string.length,
+							    &str_value, &value_len);
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
+			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
+			       expected_password_types[eloc], elem, password_obj[elem].type);
+			return -EIO;
+		}
+
+		/* Assign appropriate element value to corresponding field*/
+		switch (eloc) {
+		case VALUE:
+			break;
+		case PATH:
+			strscpy(bioscfg_drv.password_data[instance_id].common.path, str_value,
+				sizeof(bioscfg_drv.password_data[instance_id].common.path));
+			break;
+		case IS_READONLY:
+			bioscfg_drv.password_data[instance_id].common.is_readonly = int_value;
+			break;
+		case DISPLAY_IN_UI:
+			bioscfg_drv.password_data[instance_id].common.display_in_ui = int_value;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			bioscfg_drv.password_data[instance_id].common.requires_physical_presence = int_value;
+			break;
+		case SEQUENCE:
+			bioscfg_drv.password_data[instance_id].common.sequence = int_value;
+			break;
+		case PREREQUISITES_SIZE:
+			bioscfg_drv.password_data[instance_id].common.prerequisites_size = int_value;
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
+			size = bioscfg_drv.password_data[instance_id].common.prerequisites_size;
+
+			for (reqs = 0; reqs < size; reqs++) {
+				ret = convert_hexstr_to_str(password_obj[elem + reqs].string.pointer,
+							    password_obj[elem + reqs].string.length,
+							    &str_value, &value_len);
+
+				if (ret)
+					break;
+
+				strscpy(bioscfg_drv.password_data[instance_id].common.prerequisites[reqs],
+					str_value,
+					sizeof(bioscfg_drv.password_data[instance_id].common.prerequisites[reqs]));
+
+				kfree(str_value);
+			}
+			break;
+
+		case SECURITY_LEVEL:
+			bioscfg_drv.password_data[instance_id].common.security_level = int_value;
+			break;
+
+		case PSWD_MIN_LENGTH:
+			bioscfg_drv.password_data[instance_id].min_password_length = int_value;
+			break;
+		case PSWD_MAX_LENGTH:
+			bioscfg_drv.password_data[instance_id].max_password_length = int_value;
+			break;
+		case PSWD_SIZE:
+			bioscfg_drv.password_data[instance_id].encodings_size = int_value;
+			if (int_value > MAX_ENCODINGS_SIZE)
+				pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			/*
+			 * This HACK is needed to keep the expected
+			 * element list pointing to the right obj[elem].type
+			 * when the size is zero. PSWD_ENCODINGS
+			 * object is omitted by BIOS when the size is
+			 * zero.
+			 */
+			if (int_value == 0)
+				eloc++;
+			break;
+
+		case PSWD_ENCODINGS:
+			size = bioscfg_drv.password_data[instance_id].encodings_size;
+
+			for (pos_values = 0; pos_values < size && pos_values < MAX_ENCODINGS_SIZE; pos_values++) {
+				ret = convert_hexstr_to_str(password_obj[elem + pos_values].string.pointer,
+							    password_obj[elem + pos_values].string.length,
+							    &str_value, &value_len);
+				if (ret)
+					break;
+
+				strscpy(bioscfg_drv.password_data[instance_id].encodings[pos_values],
+					str_value,
+					sizeof(bioscfg_drv.password_data[instance_id].encodings[pos_values]));
+				kfree(str_value);
+			}
+			break;
+		case PSWD_IS_SET:
+			bioscfg_drv.password_data[instance_id].is_enabled = int_value;
+			break;
+
+		default:
+			pr_warn("Invalid element: %d found in Password attribute or data may be malformed\n", elem);
+			break;
+		}
+		kfree(str_value);
+	}
+
+exit_package:
+	kfree(str_value);
+	return 0;
+}
+
+/*
+ * populate_password_buffer_data -
+ * Populate all properties for an instance under password object attribute
+ *
+ * @buffer_ptr: Buffer pointer
+ * @buffer_size: Buffer size
+ * @instance_id: The instance to enumerate
+ * @attr_name_kobj: The parent kernel object
+ */
+int populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
+				  struct kobject *attr_name_kobj)
+{
+	bioscfg_drv.password_data[instance_id].attr_name_kobj = attr_name_kobj;
+
+	/* Populate Password attributes */
+	populate_password_elements_from_buffer(buffer_ptr, buffer_size,
+					       instance_id);
+	friendly_user_name_update(bioscfg_drv.password_data[instance_id].common.path,
+				  attr_name_kobj->name,
+				  bioscfg_drv.password_data[instance_id].common.display_name,
+				  sizeof(bioscfg_drv.password_data[instance_id].common.display_name));
+	if (strcmp(attr_name_kobj->name, "Setup Password") == 0)
+		return sysfs_create_group(attr_name_kobj, &bios_password_attr_group);
+
+	return sysfs_create_group(attr_name_kobj, &system_password_attr_group);
+}
+
+int populate_password_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
+					   int instance_id)
+{
+	int ret;
+	char *dst = NULL;
+	int elem;
+	int reqs;
+	int integer;
+	int size = 0;
+	int values;
+	int dst_size = *buffer_size / sizeof(u16);
+
+	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+
+	elem = 0;
+	strscpy(bioscfg_drv.password_data[instance_id].common.display_name_language_code,
+		LANG_CODE_STR,
+		sizeof(bioscfg_drv.password_data[instance_id].common.display_name_language_code));
+
+	for (elem = 1; elem < 3; elem++) {
+
+		ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+		if (ret < 0)
+			continue;
+
+		switch (elem) {
+		case VALUE:
+			strscpy(bioscfg_drv.password_data[instance_id].current_password,
+				dst, sizeof(bioscfg_drv.password_data[instance_id].current_password));
+			break;
+		case PATH:
+			strscpy(bioscfg_drv.password_data[instance_id].common.path, dst,
+				sizeof(bioscfg_drv.password_data[instance_id].common.path));
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Password  attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+
+	for (elem = 3; elem < PASSWORD_ELEM_CNT; elem++) {
+
+		if (elem != PREREQUISITES  && elem != PSWD_ENCODINGS) {
+			ret = get_integer_from_buffer((int **)&buffer_ptr, buffer_size, (int *)&integer);
+			if (ret)
+				continue;
+		}
+
+		switch (elem) {
+		case IS_READONLY:
+			bioscfg_drv.password_data[instance_id].common.is_readonly = integer;
+			break;
+		case DISPLAY_IN_UI:
+			bioscfg_drv.password_data[instance_id].common.display_in_ui = integer;
+			break;
+		case REQUIRES_PHYSICAL_PRESENCE:
+			bioscfg_drv.password_data[instance_id].common.requires_physical_presence = integer;
+			break;
+		case SEQUENCE:
+			bioscfg_drv.password_data[instance_id].common.sequence = integer;
+			break;
+		case PREREQUISITES_SIZE:
+			bioscfg_drv.password_data[instance_id].common.prerequisites_size = integer;
+			if (integer > MAX_PREREQUISITES_SIZE)
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			// PREREQUISITES:
+			elem++;
+			size = bioscfg_drv.password_data[instance_id].common.prerequisites_size;
+			for (reqs = 0; reqs < size && reqs > MAX_PREREQUISITES_SIZE; reqs++) {
+				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+				if (ret < 0)
+					continue;
+
+				strscpy(bioscfg_drv.password_data[instance_id].common.prerequisites[reqs],
+					dst,
+					sizeof(bioscfg_drv.password_data[instance_id].common.prerequisites[reqs]));
+			}
+			break;
+		case SECURITY_LEVEL:
+			bioscfg_drv.password_data[instance_id].common.security_level = integer;
+			break;
+
+		case PSWD_MIN_LENGTH:
+			bioscfg_drv.password_data[instance_id].min_password_length = integer;
+			break;
+		case PSWD_MAX_LENGTH:
+			bioscfg_drv.password_data[instance_id].max_password_length = integer;
+			break;
+		case PSWD_SIZE:
+			bioscfg_drv.password_data[instance_id].encodings_size = integer;
+			if (integer > MAX_ENCODINGS_SIZE)
+				pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
+
+			// PSWD_ENCODINGS:
+			elem++;
+			size = bioscfg_drv.password_data[instance_id].encodings_size;
+			for (values = 0; values < size && values < MAX_ENCODINGS_SIZE; values++) {
+				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+				if (ret < 0)
+					continue;
+
+				strscpy(bioscfg_drv.password_data[instance_id].encodings[values],
+					dst,
+					sizeof(bioscfg_drv.password_data[instance_id].encodings[values]));
+
+			}
+			break;
+		case PSWD_IS_SET:
+			bioscfg_drv.password_data[instance_id].is_enabled = integer;
+			break;
+		default:
+			pr_warn("Invalid element: %d found in Password  attribute or data may be malformed\n", elem);
+			break;
+		}
+	}
+	kfree(dst);
+	return 0;
+}
+
+/*
+ * exit_password_attributes() - Clear all attribute data
+ *
+ * Clears all data allocated for this group of attributes
+ */
+void exit_password_attributes(void)
+{
+	int instance_id;
+
+	for (instance_id = 0; instance_id < bioscfg_drv.password_instances_count; instance_id++) {
+		struct kobject *attr_name_kobj = bioscfg_drv.password_data[instance_id].attr_name_kobj;
+
+		if (attr_name_kobj) {
+			if (strcmp(attr_name_kobj->name, SETUP_PASSWD) == 0)
+				sysfs_remove_group(attr_name_kobj,
+						   &bios_password_attr_group);
+			else
+				sysfs_remove_group(attr_name_kobj,
+						   &system_password_attr_group);
+		}
+	}
+	bioscfg_drv.password_instances_count = 0;
+	kfree(bioscfg_drv.password_data);
+	bioscfg_drv.password_data = NULL;
+}
-- 
2.34.1

