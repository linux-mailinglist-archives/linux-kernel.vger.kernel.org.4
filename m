Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04226E7DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjDSPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjDSPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:02 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDBF4486;
        Wed, 19 Apr 2023 08:12:58 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-541b61d166aso1233184eaf.2;
        Wed, 19 Apr 2023 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917178; x=1684509178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFSUReylnms78o9Ra2IqvMYEWG7+IT6tmyoTJ3+uXcs=;
        b=qxmMU1sekKCMxIFFuitUpyLpN1w4SZtxb1OymoGRW6rsg7x4v8k9y1X0UrwoKvgKgD
         NVMPWLOWgqAsmwxLoaQQ75YSTGjHz8pqoxipPByjXGUDa8RYjGqd29ZWMOUY04y2Om2b
         S/zw1tS21bo/DPrBMbJ6EO21jR9nY7ZsH0NoyFDeJubs6fXpNXWqSbZ1eK5yf3/gnuiB
         Eme8QBNZx818+ItG48TKAK5w0h7Mo2t1rc2wYCrv3FDR2oQ6mp+bMrm/hmQND0ecnUa+
         s1Zk5VIwN1oYgAeAZMeNMhjA0EbZAp/J5yaMyW4syB5MoTaxm01HOUqHxdgXgXrwFdBP
         B4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917178; x=1684509178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFSUReylnms78o9Ra2IqvMYEWG7+IT6tmyoTJ3+uXcs=;
        b=MahfCREaTkTCP91lO2KRKZg3hX821zU1MRxymX8CykikUDWKtV+1B1XVDGb2F1hQwY
         Yf+kZmFoEI9AQz6H7HbjIzSLU8DTWfDD08ZS4x+Qd267Xk+p6IhKv2xEp/AEuA5iCPuq
         GgzTrQRB7yjSjPFAtWsxBcicMttlKihbOaH+uDXn+NwTx9aDl8rqxCh685mT9lGkMeef
         ShzCtTx3Z2P/8vwOgB/A3DJmQWAWBm7LkgoBmjBkx18uw+v6PnS1A74hI6ubCP1OzwSG
         ZMFOK9n40Z1jFxkoZuzDlx89qd5ISa6FZp6TAJOLQMdLTxduBTd9GnC6ARCCQUc1bs//
         PE9g==
X-Gm-Message-State: AAQBX9eqXgqknKrDVub1yBc7Lywb1ktRCNUJdikEujODKqaB3HOjJ9kC
        O/Zpmj64duaq2NrfRoFwA/lnyU+8++0=
X-Google-Smtp-Source: AKy350b9/K6RzuFwm4sjOZQS6ZojlBRNQE1oamWuKPrNEXX/gtReKkP4ixcY7T7zKW01dc1bIk/73g==
X-Received: by 2002:a05:6808:1891:b0:38e:4a25:2125 with SMTP id bi17-20020a056808189100b0038e4a252125mr1801200oib.18.1681917177590;
        Wed, 19 Apr 2023 08:12:57 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id o10-20020acad70a000000b0038bae910f7bsm5766847oig.1.2023.04.19.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:12:57 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 03/14] HP BIOSCFG driver  - bioscfg
Date:   Wed, 19 Apr 2023 10:12:43 -0500
Message-Id: <20230419151249.6126-4-jorge.lopez2@hp.com>
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
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 961 +++++++++++++++++++
 1 file changed, 961 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
new file mode 100644
index 000000000000..4b0d4f56e65f
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -0,0 +1,961 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common methods for use with hp-bioscfg driver
+ *
+ *  Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/wmi.h>
+#include "bioscfg.h"
+#include "../../firmware_attributes_class.h"
+#include <linux/nls.h>
+#include <linux/errno.h>
+
+MODULE_AUTHOR("Jorge Lopez <jorge.lopez2@hp.com>");
+MODULE_DESCRIPTION("HP BIOS Configuration Driver");
+MODULE_LICENSE("GPL");
+
+struct bioscfg_priv bioscfg_drv = {
+	.mutex = __MUTEX_INITIALIZER(bioscfg_drv.mutex),
+};
+
+static struct class *fw_attr_class;
+
+int get_integer_from_buffer(int **buffer, u32 *buffer_size, int *integer)
+{
+	int *ptr = PTR_ALIGN(*buffer, 4);
+
+	/* Ensure there is enough space remaining to read the integer */
+	if (*buffer_size < sizeof(int))
+		return -EINVAL;
+
+	*integer = *(ptr++);
+	*buffer = ptr;
+	*buffer_size -= sizeof(int);
+
+	return 0;
+}
+
+
+int get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size)
+{
+	u16 *src = (u16 *)*buffer;
+	u16 src_size;
+
+	u16 size;
+	int i;
+	int escape = 0;
+	int conv_dst_size;
+
+	if (*buffer_size < sizeof(u16))
+		return -EINVAL;
+
+	src_size = *(src++);
+	/* size value in u16 chars */
+	size = src_size / sizeof(u16);
+
+	/* Ensure there is enough space remaining to read and convert
+	 * the string
+	 */
+	if (*buffer_size < src_size)
+		return -EINVAL;
+
+	for (i = 0; i < size; i++)
+		if (src[i] == '\\' ||
+		    src[i] == '\r' ||
+		    src[i] == '\n' ||
+		    src[i] == '\t')
+			escape++;
+
+	size += escape;
+
+	/*
+	 * Conversion is limited to destination string max number of
+	 * bytes.
+	 */
+	conv_dst_size = size;
+	if (size > dst_size)
+		conv_dst_size = dst_size - 1;
+
+	/*
+	 * convert from UTF-16 unicode to ASCII
+	 */
+	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
+	dst[conv_dst_size] = 0;
+
+	for (i = 0; i < size && i < conv_dst_size; i++) {
+		if (*src == '\\' ||
+		    *src == '\r' ||
+		    *src == '\n' ||
+		    *src == '\t')
+			dst[i++] = '\\';
+
+		if (*src == '\r')
+			dst[i] = 'r';
+		else if (*src == '\n')
+			dst[i] = 'n';
+		else if (*src == '\t')
+			dst[i] = 't';
+		else if (*src == '"')
+			dst[i] = '\'';
+		else
+			dst[i] = *src;
+		src++;
+	}
+
+	*buffer = (u8 *)src;
+	*buffer_size -= size * sizeof(u16);
+
+	return size;
+}
+
+
+/*
+ * calculate_string_buffer() - determines size of string buffer for use with BIOS communication
+ * @str: the string to calculate based upon
+ */
+size_t bioscfg_calculate_string_buffer(const char *str)
+{
+	int length = strlen(str);
+	int size;
+
+	/* BIOS expects 4 bytes when an empty string is found */
+	if (!length)
+		length = 1;
+
+	/* u16 length field + one UTF16 char for each input char */
+	size = sizeof(u16) + length * sizeof(u16);
+
+	return size;
+}
+
+int bioscfg_wmi_error_and_message(int error_code)
+{
+	char *error_msg = NULL;
+	int ret;
+
+	switch (error_code) {
+	case SUCCESS:
+		error_msg = "Success";
+		ret = 0;
+		break;
+	case CMD_FAILED:
+		error_msg = "Command failed";
+		ret = -EINVAL;
+		break;
+	case INVALID_SIGN:
+		error_msg = "Invalid signature";
+		ret = -EINVAL;
+		break;
+	case INVALID_CMD_VALUE:
+		error_msg = "Invalid command value/Feature not supported";
+		ret = -EOPNOTSUPP;
+		break;
+	case INVALID_CMD_TYPE:
+		error_msg = "Invalid command type";
+		ret = -EINVAL;
+		break;
+	case INVALID_DATA_SIZE:
+		error_msg = "Invalid data size";
+		ret = -EINVAL;
+		break;
+	case INVALID_CMD_PARAM:
+		error_msg = "Invalid command parameter";
+		ret = -EINVAL;
+		break;
+	case ENCRYP_CMD_REQUIRED:
+		error_msg = "Secure/encrypted command required";
+		ret = -EACCES;
+		break;
+	case NO_SECURE_SESSION:
+		error_msg = "No secure session established";
+		ret = -EACCES;
+		break;
+	case SECURE_SESSION_FOUND:
+		error_msg = "Secure session already established";
+		ret = -EACCES;
+		break;
+	case SECURE_SESSION_FAILED:
+		error_msg = "Secure session failed";
+		ret = -EIO;
+		break;
+	case AUTH_FAILED:
+		error_msg = "Other permission/Authentication failed";
+		ret = -EACCES;
+		break;
+	case INVALID_BIOS_AUTH:
+		error_msg = "Invalid BIOS administrator password";
+		ret = -EINVAL;
+		break;
+	case NONCE_DID_NOT_MATCH:
+		error_msg = "Nonce did not match";
+		ret = -EINVAL;
+		break;
+	case GENERIC_ERROR:
+		error_msg = "Generic/Other error";
+		ret = -EIO;
+		break;
+	case BIOS_ADMIN_POLICY_NOT_MET:
+		error_msg = "BIOS Admin password does not meet password policy requirements";
+		ret = -EINVAL;
+		break;
+	case BIOS_ADMIN_NOT_SET:
+		error_msg = "BIOS Setup password is not set.";
+		ret = -EPERM;
+		break;
+	case P21_NO_PROVISIONED:
+		error_msg = "P21 is not provisioned";
+		ret = -EPERM;
+		break;
+	case P21_PROVISION_IN_PROGRESS:
+		error_msg = "P21 is already provisioned or provisioning is in progress and a signing key has already been sent.";
+		ret = -EINPROGRESS;
+		break;
+	case P21_IN_USE:
+		error_msg = "P21 in use (cannot deprovision)";
+		ret = -EPERM;
+		break;
+	case HEP_NOT_ACTIVE:
+		error_msg = "HEP not activated";
+		ret = -EPERM;
+		break;
+	case HEP_ALREADY_SET:
+		error_msg = "HEP Transport already set";
+		ret = -EINVAL;
+		break;
+	case HEP_CHECK_STATE:
+		error_msg = "Check the current HEP state";
+		ret = -EINVAL;
+		break;
+	default:
+		error_msg = "Generic/Other error";
+		ret = -EIO;
+		break;
+	}
+
+	if (error_code)
+		pr_warn_ratelimited("Returned error 0x%x, \"%s\"\n", error_code, error_msg);
+
+	return ret;
+}
+
+
+/*
+ * pending_reboot_show() - sysfs implementaton for read pending_reboot
+ * @kobj: Kernel object for this attribute
+ * @attr: Kernel object attribute
+ * @buf: The buffer to display to userspace
+ *
+ * Stores default value as 0
+ * When current_value is changed this attribute is set to 1 to notify reboot may be required
+ */
+static ssize_t pending_reboot_show(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bioscfg_drv.pending_reboot);
+}
+static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
+
+/*
+ * create_attributes_level_sysfs_files() - Creates pending_reboot attributes
+ */
+static int create_attributes_level_sysfs_files(void)
+{
+	int ret;
+
+	ret = sysfs_create_file(&bioscfg_drv.main_dir_kset->kobj, &pending_reboot.attr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+
+static void attr_name_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static const struct kobj_type attr_name_ktype = {
+	.release	= attr_name_release,
+	.sysfs_ops	= &kobj_sysfs_ops,
+};
+
+/*
+ * get_wmiobj_pointer() - Get Content of WMI block for particular instance
+ *
+ * @instance_id: WMI instance ID
+ * @guid_string: WMI GUID (in str form)
+ *
+ * Fetches the content for WMI block (instance_id) under GUID (guid_string)
+ * Caller must kfree the return
+ */
+union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string)
+{
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+
+	status = wmi_query_block(guid_string, instance_id, &out);
+	return ACPI_SUCCESS(status) ? (union acpi_object *)out.pointer : NULL;
+}
+
+/*
+ * get_instance_count() - Compute total number of instances under guid_string
+ *
+ * @guid_string: WMI GUID (in string form)
+ */
+int get_instance_count(const char *guid_string)
+{
+	union acpi_object *wmi_obj = NULL;
+	int i = 0;
+
+	do {
+		kfree(wmi_obj);
+		wmi_obj = get_wmiobj_pointer(i, guid_string);
+		i++;
+	} while (wmi_obj);
+
+	return i-1;
+}
+
+/*
+ * alloc_attributes_data() - Allocate attributes data for a particular type
+ *
+ * @attr_type: Attribute type to allocate
+ */
+static int alloc_attributes_data(int attr_type)
+{
+	int retval = 0;
+
+	switch (attr_type) {
+	case HPWMI_STRING_TYPE:
+		retval = alloc_string_data();
+		break;
+	case HPWMI_INTEGER_TYPE:
+		retval = alloc_integer_data();
+		break;
+	case HPWMI_ENUMERATION_TYPE:
+		retval = alloc_enumeration_data();
+		break;
+	case HPWMI_ORDERED_LIST_TYPE:
+		retval = alloc_ordered_list_data();
+		break;
+	case HPWMI_PASSWORD_TYPE:
+		retval = alloc_password_data();
+		break;
+	default:
+		break;
+	}
+
+	return retval;
+}
+
+int convert_hexstr_to_str(const char *input, u32 input_len, char **str, int *len)
+{
+	int ret = 0;
+	int new_len = 0;
+	char tmp[] = "0x00";
+	char *new_str = NULL;
+	long  ch;
+	int i;
+
+	if (input_len <= 0 || input == NULL || str == NULL || len == NULL)
+		return -EINVAL;
+
+	*len = 0;
+	*str = NULL;
+
+	new_str = kmalloc(input_len, GFP_KERNEL);
+	if (!new_str)
+		return -ENOMEM;
+
+	for (i = 0; i < input_len; i += 5) {
+		strncpy(tmp, input + i, strlen(tmp));
+		if (kstrtol(tmp, 16, &ch) == 0) {
+			// escape char
+			if (ch == '\\' || ch == '\r' || ch == '\n' || ch == '\t') {
+				if (ch == '\r')
+					ch = 'r';
+				else if (ch == '\n')
+					ch = 'n';
+				else if (ch == '\t')
+					ch = 't';
+				new_str[new_len++] = '\\';
+			}
+			new_str[new_len++] = ch;
+			if (ch == '\0')
+				break;
+		}
+	}
+
+	if (new_len) {
+		new_str[new_len] = '\0';
+		*str = krealloc(new_str, (new_len + 1) * sizeof(char), GFP_KERNEL);
+		if (*str)
+			*len = new_len;
+		else
+			ret = -ENOMEM;
+	} else {
+		ret = -EFAULT;
+	}
+
+	if (ret)
+		kfree(new_str);
+	return ret;
+}
+
+/* map output size to the corresponding WMI method id */
+int encode_outsize_for_pvsz(int outsize)
+{
+	if (outsize > 4096)
+		return -EINVAL;
+	if (outsize > 1024)
+		return 5;
+	if (outsize > 128)
+		return 4;
+	if (outsize > 4)
+		return 3;
+	if (outsize > 0)
+		return 2;
+	return 1;
+}
+
+/*
+ * Update friendly display name for several attributes associated to
+ * 'Schedule Power-On'
+ */
+void friendly_user_name_update(char *path, const char *attr_name,
+			       char *attr_display, int attr_size)
+{
+	char *found = NULL;
+
+	found = strstr(path, SCHEDULE_POWER_ON);
+	if (found)
+		snprintf(attr_display,
+			 attr_size,
+			 "%s - %s",
+			 SCHEDULE_POWER_ON,
+			 attr_name);
+	else
+		strscpy(attr_display, attr_name, attr_size);
+}
+
+/*
+ * update_attribute_permissions() - Update attributes permissions when
+ * isReadOnly value is 1
+ *
+ * @isReadOnly:  ReadOnly value
+ * @current_val: kobj_attribute corresponding to attribute.
+ *
+ */
+void update_attribute_permissions(u32 isReadOnly, struct kobj_attribute *current_val)
+{
+	if (isReadOnly)
+		current_val->attr.mode = (umode_t)0444;
+	else
+		current_val->attr.mode = (umode_t)0644;
+}
+
+
+/**
+ * destroy_attribute_objs() - Free a kset of kobjects
+ * @kset: The kset to destroy
+ *
+ * Fress kobjects created for each attribute_name under attribute type kset
+ */
+static void destroy_attribute_objs(struct kset *kset)
+{
+	struct kobject *pos, *next;
+
+	list_for_each_entry_safe(pos, next, &kset->list, entry)
+		kobject_put(pos);
+}
+
+/**
+ * release_attributes_data() - Clean-up all sysfs directories and files created
+ */
+static void release_attributes_data(void)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+
+	exit_string_attributes();
+	exit_integer_attributes();
+	exit_enumeration_attributes();
+	exit_ordered_list_attributes();
+	exit_password_attributes();
+	exit_sure_start_attributes();
+	exit_secure_platform_attributes();
+
+	if (bioscfg_drv.authentication_dir_kset) {
+		destroy_attribute_objs(bioscfg_drv.authentication_dir_kset);
+		kset_unregister(bioscfg_drv.authentication_dir_kset);
+		bioscfg_drv.authentication_dir_kset = NULL;
+	}
+	if (bioscfg_drv.main_dir_kset) {
+		sysfs_remove_file(&bioscfg_drv.main_dir_kset->kobj, &pending_reboot.attr);
+		destroy_attribute_objs(bioscfg_drv.main_dir_kset);
+		kset_unregister(bioscfg_drv.main_dir_kset);
+		bioscfg_drv.main_dir_kset = NULL;
+	}
+	mutex_unlock(&bioscfg_drv.mutex);
+}
+
+
+/*
+ * hp_add_other_attributes - Initialize HP custom attributes not reported by
+ * BIOS and required to support Secure Platform, Sure Start, and Sure
+ * Admin.
+ * @attr_type: Custom HP attribute not reported by BIOS
+ *
+ * Initialiaze all 3 types of attributes: Platform, Sure Start, and Sure
+ * Admin object.  Populates each attrbute types respective properties
+ * under sysfs files.
+ *
+ * Returns zero(0) if successful.  Otherwise, a negative value.
+ */
+static int hp_add_other_attributes(int attr_type)
+{
+	struct kobject *attr_name_kobj;
+	union acpi_object *obj = NULL;
+	int retval = 0;
+	u8 *attr_name;
+
+	mutex_lock(&bioscfg_drv.mutex);
+
+	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
+	if (!attr_name_kobj) {
+		retval = -ENOMEM;
+		goto err_other_attr_init;
+	}
+
+	/* Check if attribute type is supported */
+	switch (attr_type) {
+	case HPWMI_SECURE_PLATFORM_TYPE:
+		attr_name_kobj->kset = bioscfg_drv.authentication_dir_kset;
+		attr_name = SPM_STR;
+		break;
+
+	case HPWMI_SURE_START_TYPE:
+		attr_name_kobj->kset = bioscfg_drv.main_dir_kset;
+		attr_name = SURE_START_STR;
+		break;
+
+	default:
+		pr_err("Error: Unknown attr_type: %d\n", attr_type);
+		retval = -EINVAL;
+		goto err_other_attr_init;
+	}
+
+	retval = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
+				      NULL, "%s", attr_name);
+	if (retval) {
+		pr_err("Error encountered [%d]\n", retval);
+		kobject_put(attr_name_kobj);
+		goto err_other_attr_init;
+	}
+
+	/* Populate attribute data */
+	switch (attr_type) {
+	case HPWMI_SECURE_PLATFORM_TYPE:
+		retval = populate_secure_platform_data(attr_name_kobj);
+		break;
+
+	case HPWMI_SURE_START_TYPE:
+		retval = populate_sure_start_data(attr_name_kobj);
+		break;
+
+	default:
+		goto err_other_attr_init;
+	}
+
+	mutex_unlock(&bioscfg_drv.mutex);
+	return 0;
+
+err_other_attr_init:
+	mutex_unlock(&bioscfg_drv.mutex);
+	kfree(obj);
+	return retval;
+}
+
+/*
+ * hp_init_bios_attributes - Initialize all attributes for a type
+ * @attr_type: The attribute type to initialize
+ * @guid: The WMI GUID associated with this type to initialize
+ *
+ * Initialiaze all 5 types of attributes: enumeration, integer,
+ * string, password, ordered list  object.  Populates each attrbute types
+ * respective properties under sysfs files
+ */
+static int hp_init_bios_attributes(int attr_type, const char *guid)
+{
+	struct kobject *attr_name_kobj;
+	union acpi_object *obj = NULL;
+	union acpi_object *elements;
+	struct kset *tmp_set;
+	int min_elements;
+	char str[MAX_BUFF];
+
+	char *temp_str = NULL;
+	char *str_value = NULL;
+	int str_len;
+	int ret = 0;
+
+	u8 *buffer_ptr = NULL;
+	int buffer_size;
+
+
+	/* instance_id needs to be reset for each type GUID
+	 * also, instance IDs are unique within GUID but not across
+	 */
+	int instance_id = 0;
+	int retval = 0;
+
+	retval = alloc_attributes_data(attr_type);
+	if (retval)
+		return retval;
+
+	switch (attr_type) {
+	case HPWMI_STRING_TYPE:
+		min_elements = 12;
+		break;
+	case HPWMI_INTEGER_TYPE:
+		min_elements = 13;
+		break;
+	case HPWMI_ENUMERATION_TYPE:
+		min_elements = 13;
+		break;
+	case HPWMI_ORDERED_LIST_TYPE:
+		min_elements = 12;
+		break;
+	case HPWMI_PASSWORD_TYPE:
+		min_elements = 15;
+		break;
+	default:
+		pr_err("Error: Unknown attr_type: %d\n", attr_type);
+		return -EINVAL;
+	}
+
+	/* need to use specific instance_id and guid combination to get right data */
+	obj = get_wmiobj_pointer(instance_id, guid);
+	if (!obj)
+		return -ENODEV;
+
+	mutex_lock(&bioscfg_drv.mutex);
+	while (obj) {
+		if (obj->type != ACPI_TYPE_PACKAGE && obj->type != ACPI_TYPE_BUFFER) {
+			pr_err("Error: Expected ACPI-package or buffer type, got: %d\n", obj->type);
+			retval = -EIO;
+			goto err_attr_init;
+		}
+
+		/* Take action appropriate to each ACPI TYPE */
+		if (obj->type == ACPI_TYPE_PACKAGE) {
+			if (obj->package.count < min_elements) {
+				pr_err("ACPI-package does not have enough elements: %d < %d\n",
+				       obj->package.count, min_elements);
+				goto nextobj;
+			}
+
+			elements = obj->package.elements;
+
+			/* sanity checking */
+			if (elements[NAME].type != ACPI_TYPE_STRING) {
+				pr_debug("incorrect element type\n");
+				goto nextobj;
+			}
+			if (strlen(elements[NAME].string.pointer) == 0) {
+				pr_debug("empty attribute found\n");
+				goto nextobj;
+			}
+
+			if (attr_type == HPWMI_PASSWORD_TYPE)
+				tmp_set = bioscfg_drv.authentication_dir_kset;
+			else
+				tmp_set = bioscfg_drv.main_dir_kset;
+
+			/* convert attribute name to string */
+			retval = convert_hexstr_to_str(elements[NAME].string.pointer,
+						       elements[NAME].string.length,
+						       &str_value, &str_len);
+
+			if (retval) {
+				pr_debug("Failed to populate integer package data. Error [0%0x]\n", ret);
+				kfree(str_value);
+				return ret;
+			}
+
+			if (kset_find_obj(tmp_set, str_value)) {
+				pr_debug("Duplicate attribute name found - %s\n",
+					 str_value);
+				goto nextobj;
+			}
+
+			/* build attribute */
+			attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
+			if (!attr_name_kobj) {
+				retval = -ENOMEM;
+				goto err_attr_init;
+			}
+
+			attr_name_kobj->kset = tmp_set;
+
+			retval = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
+						      NULL, "%s", str_value);
+
+			if (retval) {
+				kobject_put(attr_name_kobj);
+				goto err_attr_init;
+			}
+
+			/* enumerate all of these attributes */
+			switch (attr_type) {
+			case HPWMI_STRING_TYPE:
+				retval = populate_string_package_data(elements,
+								      instance_id,
+								      attr_name_kobj);
+				break;
+			case HPWMI_INTEGER_TYPE:
+				retval = populate_integer_package_data(elements,
+								       instance_id,
+								       attr_name_kobj);
+				break;
+			case HPWMI_ENUMERATION_TYPE:
+				retval = populate_enumeration_package_data(elements,
+									   instance_id,
+									   attr_name_kobj);
+				break;
+			case HPWMI_ORDERED_LIST_TYPE:
+				retval = populate_ordered_list_package_data(elements,
+									    instance_id,
+									    attr_name_kobj);
+				break;
+			case HPWMI_PASSWORD_TYPE:
+				retval = populate_password_package_data(elements,
+									instance_id,
+									attr_name_kobj);
+				break;
+			default:
+				break;
+			}
+
+			kfree(str_value);
+		}
+
+		if (obj->type == ACPI_TYPE_BUFFER) {
+
+			buffer_size = obj->buffer.length;
+			buffer_ptr = obj->buffer.pointer;
+
+			retval = get_string_from_buffer(&buffer_ptr, &buffer_size, str, MAX_BUFF);
+			if (retval < 0)
+				goto err_attr_init;
+
+			if (attr_type == HPWMI_PASSWORD_TYPE || attr_type == HPWMI_SECURE_PLATFORM_TYPE)
+				tmp_set = bioscfg_drv.authentication_dir_kset;
+			else
+				tmp_set = bioscfg_drv.main_dir_kset;
+
+			if (kset_find_obj(tmp_set, str)) {
+				pr_warn("Duplicate attribute name found - %s\n", str);
+				goto nextobj;
+			}
+
+			/* build attribute */
+			attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
+			if (!attr_name_kobj) {
+				retval = -ENOMEM;
+				goto err_attr_init;
+			}
+
+			attr_name_kobj->kset = tmp_set;
+
+			temp_str = str;
+			if (attr_type == HPWMI_SECURE_PLATFORM_TYPE)
+				temp_str = "SPM";
+
+			retval = kobject_init_and_add(attr_name_kobj,
+						      &attr_name_ktype, NULL, "%s",
+						      temp_str);
+			if (retval) {
+				kobject_put(attr_name_kobj);
+				goto err_attr_init;
+			}
+
+			/* enumerate all of these attributes */
+			switch (attr_type) {
+			case HPWMI_STRING_TYPE:
+				retval = populate_string_buffer_data(buffer_ptr,
+								     &buffer_size,
+								     instance_id,
+								     attr_name_kobj);
+				break;
+			case HPWMI_INTEGER_TYPE:
+				retval = populate_integer_buffer_data(buffer_ptr,
+								      &buffer_size,
+								      instance_id,
+								      attr_name_kobj);
+				break;
+			case HPWMI_ENUMERATION_TYPE:
+				retval = populate_enumeration_buffer_data(buffer_ptr,
+									  &buffer_size,
+									  instance_id,
+									  attr_name_kobj);
+				break;
+			case HPWMI_ORDERED_LIST_TYPE:
+				retval = populate_ordered_list_buffer_data(buffer_ptr,
+									   &buffer_size,
+									   instance_id,
+									   attr_name_kobj);
+				break;
+			case HPWMI_PASSWORD_TYPE:
+				retval = populate_password_buffer_data(buffer_ptr,
+								       &buffer_size,
+								       instance_id,
+								       attr_name_kobj);
+				break;
+			default:
+				break;
+			}
+		}
+nextobj:
+		kfree(str_value);
+		kfree(obj);
+		instance_id++;
+		obj = get_wmiobj_pointer(instance_id, guid);
+	}
+	mutex_unlock(&bioscfg_drv.mutex);
+	return 0;
+
+err_attr_init:
+	mutex_unlock(&bioscfg_drv.mutex);
+	kfree(obj);
+	return retval;
+}
+
+static int __init bioscfg_init(void)
+{
+	int ret = 0;
+	int bios_capable = wmi_has_guid(HP_WMI_BIOS_GUID);
+
+	if (!bios_capable) {
+		pr_err("Unable to run on non-HP system\n");
+		return -ENODEV;
+	}
+
+	ret = init_bios_attr_set_interface();
+	if (ret)
+		return ret;
+
+	ret = init_bios_attr_pass_interface();
+	if (ret)
+		goto err_exit_bios_attr_set_interface;
+
+	if (!bioscfg_drv.bios_attr_wdev || !bioscfg_drv.password_attr_wdev) {
+		pr_debug("Failed to find set or pass interface\n");
+		ret = -ENODEV;
+		goto err_exit_bios_attr_pass_interface;
+	}
+
+	ret = fw_attributes_class_get(&fw_attr_class);
+	if (ret)
+		goto err_exit_bios_attr_pass_interface;
+
+	bioscfg_drv.class_dev = device_create(fw_attr_class, NULL, MKDEV(0, 0),
+					      NULL, "%s", DRIVER_NAME);
+	if (IS_ERR(bioscfg_drv.class_dev)) {
+		ret = PTR_ERR(bioscfg_drv.class_dev);
+		goto err_unregister_class;
+	}
+
+	bioscfg_drv.main_dir_kset = kset_create_and_add("attributes", NULL,
+							&bioscfg_drv.class_dev->kobj);
+	if (!bioscfg_drv.main_dir_kset) {
+		ret = -ENOMEM;
+		pr_debug("Failed to create and add attributes\n");
+		goto err_destroy_classdev;
+	}
+
+	bioscfg_drv.authentication_dir_kset = kset_create_and_add("authentication", NULL,
+								  &bioscfg_drv.class_dev->kobj);
+	if (!bioscfg_drv.authentication_dir_kset) {
+		ret = -ENOMEM;
+		pr_debug("Failed to create and add authentication\n");
+		goto err_release_attributes_data;
+	}
+
+	/*
+	 * sysfs level attributes.
+	 * - pending_reboot
+	 */
+	ret = create_attributes_level_sysfs_files();
+	if (ret)
+		pr_debug("Failed to create sysfs level attributes\n");
+
+	ret = hp_init_bios_attributes(HPWMI_STRING_TYPE, HP_WMI_BIOS_STRING_GUID);
+	if (ret)
+		pr_debug("Failed to populate string type attributes\n");
+
+	ret = hp_init_bios_attributes(HPWMI_INTEGER_TYPE, HP_WMI_BIOS_INTEGER_GUID);
+	if (ret)
+		pr_debug("Failed to populate integer type attributes\n");
+
+	ret = hp_init_bios_attributes(HPWMI_ENUMERATION_TYPE, HP_WMI_BIOS_ENUMERATION_GUID);
+	if (ret)
+		pr_debug("Failed to populate enumeration type attributes\n");
+
+	ret = hp_init_bios_attributes(HPWMI_ORDERED_LIST_TYPE, HP_WMI_BIOS_ORDERED_LIST_GUID);
+	if (ret)
+		pr_debug("Failed to populate ordered list object type attributes\n");
+
+	ret = hp_init_bios_attributes(HPWMI_PASSWORD_TYPE, HP_WMI_BIOS_PASSWORD_GUID);
+	if (ret)
+		pr_debug("Failed to populate password object type attributes\n");
+
+	bioscfg_drv.spm_data.attr_name_kobj = NULL;
+	ret = hp_add_other_attributes(HPWMI_SECURE_PLATFORM_TYPE);
+	if (ret)
+		pr_debug("Failed to populate secure platform object type attribute\n");
+
+	bioscfg_drv.sure_start_attr_kobj = NULL;
+	ret = hp_add_other_attributes(HPWMI_SURE_START_TYPE);
+	if (ret)
+		pr_debug("Failed to populate sure start object type attribute\n");
+
+	return 0;
+
+err_release_attributes_data:
+	release_attributes_data();
+
+err_destroy_classdev:
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+
+err_unregister_class:
+	fw_attributes_class_put();
+
+err_exit_bios_attr_pass_interface:
+	exit_bios_attr_pass_interface();
+
+err_exit_bios_attr_set_interface:
+	exit_bios_attr_set_interface();
+
+	return ret;
+}
+
+static void __exit bioscfg_exit(void)
+{
+	release_attributes_data();
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+
+	fw_attributes_class_put();
+	exit_bios_attr_set_interface();
+	exit_bios_attr_pass_interface();
+}
+
+module_init(bioscfg_init);
+module_exit(bioscfg_exit);
-- 
2.34.1

