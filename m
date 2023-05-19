Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C19670A053
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjESUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjESUNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:13:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC7FE;
        Fri, 19 May 2023 13:13:05 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1928253dd95so1658732fac.3;
        Fri, 19 May 2023 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684527184; x=1687119184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xReCK6kqZftID/I9QKf+JSAqdshCaBnkUU7jcVqmAtk=;
        b=Sj2Rnke3lmBO3bXMwq0ri8c7ibb4U1jkSutlgZr6BcGFL8HmDOiupOUfkiEKPJfTxq
         4T7ymXoM3sdlTOio2A2Av8BwSPY27ldXFo7wL61zzD6dZbrvrk0r4exp0Xp1PGjCJAGe
         mhKe+Unpac6DRfwJq2UI953aQkPXX52FPb9U17KASpiQ9EljCeAIJBkqw1dpqowdulzr
         RIA8UWhCFjsytBPMJmj96DyFcNpdGPacE63cpWzbyYoaOYOTT41POHIhP3GSwN7CyybT
         AVqeTWy5yx2XlZ8zL+wBJ3rhQYBDhAsmsOBhzvRM4ifhQdjEsT3A7ev8YgfHVPTS8hlq
         71Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527184; x=1687119184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xReCK6kqZftID/I9QKf+JSAqdshCaBnkUU7jcVqmAtk=;
        b=BibiVQSe1y7YEA7RAPTyF7x1hHRubRaIWqzGXLzpkyBszF5beSABF1ayxj6CEPEJnC
         QamAlkHyodYw2zme+qKBphuPmpxy5egX45DkhBqaf01eIDpbDtrVXFcabA23WYFWE328
         jEIgq9ZJh9dwDbz4nHrAMPZBKt/fcbgmjMJwZBbKkNUYrjoeK8A9uv6F8y/jjp/MK6uS
         eLWLIQy10VJk7pCBKl0GX0jXan+2Q64VyxWZxyXTtVMAhtmnu8qbJ9tgp3MkLWmVXu7p
         Ay3nJHd/wtm0jMywo4xoPPd+fY9UBxJCr5ab93rWWEq9MCKbZEIVyTYoC3dtjTjEVmSC
         l1kw==
X-Gm-Message-State: AC+VfDw1NWrgHGWWPreEcKP6k5XnB6AkohY2q3M3P38xwYn4hEs195Ba
        LCDXMzzFU5uqH/Xc/DOrljs=
X-Google-Smtp-Source: ACHHUZ7mwxZkzV12IFfeBJ0ZcCVPHOQYQLNLPuhNCtIPUQvoE/jhacGXIYEOnLXeJdcTdy3NDsDB+Q==
X-Received: by 2002:a05:6870:172b:b0:188:77b:7c59 with SMTP id h43-20020a056870172b00b00188077b7c59mr1556128oae.19.1684527184393;
        Fri, 19 May 2023 13:13:04 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e6dc:4936:31b7:d3d0])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b001964dc3dadesm2325239oac.45.2023.05.19.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:13:03 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v15 02/13] hp-bioscfg: bioscfg-h
Date:   Fri, 19 May 2023 15:12:49 -0500
Message-Id: <20230519201300.12964-3-jorge.lopez2@hp.com>
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
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 486 +++++++++++++++++++
 1 file changed, 486 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
new file mode 100644
index 000000000000..3a3b24f766d2
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -0,0 +1,486 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Definitions for kernel modules using hp_bioscfg driver
+ *
+ *  Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#ifndef _HP_BIOSCFG_H_
+#define _HP_BIOSCFG_H_
+
+#include <linux/wmi.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/capability.h>
+#include <linux/nls.h>
+
+#define DRIVER_NAME		"hp-bioscfg"
+
+#define MAX_BUFF_SIZE		512
+#define MAX_KEY_MOD_SIZE	256
+#define MAX_PASSWD_SIZE		64
+#define MAX_PREREQUISITES_SIZE	20
+#define MAX_REQ_ELEM_SIZE	128
+#define MAX_VALUES_SIZE		16
+#define MAX_ENCODINGS_SIZE	16
+#define MAX_ELEMENTS_SIZE	16
+
+#define SPM_STR_DESC		"Secure Platform Management"
+#define SPM_STR			"SPM"
+#define SURE_START_DESC		"Sure Start"
+#define SURE_START_STR		"Sure_Start"
+#define SETUP_PASSWD		"Setup Password"
+#define POWER_ON_PASSWD		"Power-On Password"
+
+#define LANG_CODE_STR		"en_US.UTF-8"
+#define SCHEDULE_POWER_ON	"Scheduled Power-On"
+
+#define COMMA_SEP		","
+#define SEMICOLON_SEP		";"
+
+/* Sure Admin Functions */
+
+#define UTF_PREFIX		"<utf-16/>"
+#define BEAM_PREFIX		"<BEAM/>"
+
+enum mechanism_values {
+	PASSWORD		= 0x00,
+	SIGNING_KEY		= 0x01,
+	ENDORSEMENT_KEY		= 0x02,
+};
+
+#define BIOS_ADMIN		"bios-admin"
+#define POWER_ON		"power-on"
+#define BIOS_SPM		"enhanced-bios-auth"
+
+#define PASSWD_MECHANISM_TYPES "password"
+
+#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
+
+#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4c35-AF3E-6A1B8106F83C"
+#define HP_WMI_BIOS_INTEGER_GUID	"8232DE3D-663D-4327-A8F4-E293ADB9BF05"
+#define HP_WMI_BIOS_ENUMERATION_GUID	"2D114B49-2DFB-4130-B8FE-4A3C09E75133"
+#define HP_WMI_BIOS_ORDERED_LIST_GUID	"14EA9746-CE1F-4098-A0E0-7045CB4DA745"
+#define HP_WMI_BIOS_PASSWORD_GUID	"322F2028-0F84-4901-988E-015176049E2D"
+#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460b-951D-C7CB9B4B8D5E"
+
+enum hp_wmi_spm_commandtype {
+	HPWMI_SECUREPLATFORM_GET_STATE  = 0x10,
+	HPWMI_SECUREPLATFORM_SET_KEK	= 0x11,
+	HPWMI_SECUREPLATFORM_SET_SK	= 0x12,
+};
+
+enum hp_wmi_surestart_commandtype {
+	HPWMI_SURESTART_GET_LOG_COUNT	= 0x01,
+	HPWMI_SURESTART_GET_LOG		= 0x02,
+};
+
+enum hp_wmi_command {
+	HPWMI_READ		= 0x01,
+	HPWMI_WRITE		= 0x02,
+	HPWMI_ODM		= 0x03,
+	HPWMI_SURESTART		= 0x20006,
+	HPWMI_GM		= 0x20008,
+	HPWMI_SECUREPLATFORM	= 0x20010,
+};
+
+struct bios_return {
+	u32 sigpass;
+	u32 return_code;
+};
+
+enum wmi_error_values {
+	SUCCESS				= 0x00,
+	CMD_FAILED			= 0x01,
+	INVALID_SIGN			= 0x02,
+	INVALID_CMD_VALUE		= 0x03,
+	INVALID_CMD_TYPE		= 0x04,
+	INVALID_DATA_SIZE		= 0x05,
+	INVALID_CMD_PARAM		= 0x06,
+	ENCRYP_CMD_REQUIRED		= 0x07,
+	NO_SECURE_SESSION		= 0x08,
+	SECURE_SESSION_FOUND		= 0x09,
+	SECURE_SESSION_FAILED		= 0x0A,
+	AUTH_FAILED			= 0x0B,
+	INVALID_BIOS_AUTH		= 0x0E,
+	NONCE_DID_NOT_MATCH		= 0x18,
+	GENERIC_ERROR			= 0x1C,
+	BIOS_ADMIN_POLICY_NOT_MET	= 0x28,
+	BIOS_ADMIN_NOT_SET		= 0x38,
+	P21_NO_PROVISIONED		= 0x1000,
+	P21_PROVISION_IN_PROGRESS	= 0x1001,
+	P21_IN_USE			= 0x1002,
+	HEP_NOT_ACTIVE			= 0x1004,
+	HEP_ALREADY_SET			= 0x1006,
+	HEP_CHECK_STATE			= 0x1007,
+};
+
+struct common_data {
+	u8 display_name[MAX_BUFF_SIZE];
+	u8 path[MAX_BUFF_SIZE];
+	u32 is_readonly;
+	u32 display_in_ui;
+	u32 requires_physical_presence;
+	u32 sequence;
+	u32 prerequisites_size;
+	u8 prerequisites[MAX_PREREQUISITES_SIZE][MAX_BUFF_SIZE];
+	u32 security_level;
+};
+
+struct string_data {
+	struct common_data common;
+	struct kobject *attr_name_kobj;
+	u8 current_value[MAX_BUFF_SIZE];
+	u8 new_value[MAX_BUFF_SIZE];
+	u32 min_length;
+	u32 max_length;
+};
+
+struct integer_data {
+	struct common_data common;
+	struct kobject *attr_name_kobj;
+	u32 current_value;
+	u32 new_value;
+	u32 lower_bound;
+	u32 upper_bound;
+	u32 scalar_increment;
+};
+
+struct enumeration_data {
+	struct common_data common;
+	struct kobject *attr_name_kobj;
+	u8 current_value[MAX_BUFF_SIZE];
+	u8 new_value[MAX_BUFF_SIZE];
+	u32 possible_values_size;
+	u8 possible_values[MAX_VALUES_SIZE][MAX_BUFF_SIZE];
+};
+
+struct ordered_list_data {
+	struct common_data common;
+	struct kobject *attr_name_kobj;
+	u8 current_value[MAX_BUFF_SIZE];
+	u8 new_value[MAX_BUFF_SIZE];
+	u32 elements_size;
+	u8 elements[MAX_ELEMENTS_SIZE][MAX_BUFF_SIZE];
+};
+
+struct password_data {
+	struct common_data common;
+	struct kobject *attr_name_kobj;
+	u8 current_password[MAX_PASSWD_SIZE];
+	u8 new_password[MAX_PASSWD_SIZE];
+	u32 min_password_length;
+	u32 max_password_length;
+	u32 encodings_size;
+	u8 encodings[MAX_ENCODINGS_SIZE][MAX_BUFF_SIZE];
+	bool is_enabled;
+
+	/*
+	 * 'role' identifies the type of authentication.
+	 * Two known types are bios-admin and power-on.
+	 * 'bios-admin' represents BIOS administrator password
+	 * 'power-on' represents a password required to use the system
+	 */
+	u32 role;
+
+	/*
+	 * 'mechanism' represents the means of authentication.
+	 * Only supported type currently is "password"
+	 */
+	u32 mechanism;
+};
+
+struct secure_platform_data {
+	struct kobject *attr_name_kobj;
+	u8 attribute_name[MAX_BUFF_SIZE];
+	u8 *endorsement_key;
+	u8 *signing_key;
+	u8 *auth_token;
+	bool is_enabled;
+	u32 mechanism;
+};
+
+struct bioscfg_priv {
+	struct wmi_device *bios_attr_wdev;
+	struct kset *authentication_dir_kset;
+	struct kset *main_dir_kset;
+	struct device *class_dev;
+	struct string_data *string_data;
+	u32 string_instances_count;
+	struct integer_data *integer_data;
+	u32 integer_instances_count;
+	struct enumeration_data *enumeration_data;
+	u32 enumeration_instances_count;
+	struct ordered_list_data *ordered_list_data;
+	u32 ordered_list_instances_count;
+	struct password_data *password_data;
+	u32 password_instances_count;
+
+	struct kobject *sure_start_attr_kobj;
+	struct secure_platform_data spm_data;
+	u8 display_name_language_code[MAX_BUFF_SIZE];
+	bool pending_reboot;
+	struct mutex mutex;
+};
+
+/* global structure used by multiple WMI interfaces */
+extern struct bioscfg_priv bioscfg_drv;
+
+enum hp_wmi_data_type {
+	HPWMI_STRING_TYPE,
+	HPWMI_INTEGER_TYPE,
+	HPWMI_ENUMERATION_TYPE,
+	HPWMI_ORDERED_LIST_TYPE,
+	HPWMI_PASSWORD_TYPE,
+	HPWMI_SECURE_PLATFORM_TYPE,
+	HPWMI_SURE_START_TYPE,
+};
+
+enum hp_wmi_data_elements {
+	/* Common elements */
+	NAME = 0,
+	VALUE = 1,
+	PATH = 2,
+	IS_READONLY = 3,
+	DISPLAY_IN_UI = 4,
+	REQUIRES_PHYSICAL_PRESENCE = 5,
+	SEQUENCE = 6,
+	PREREQUISITES_SIZE = 7,
+	PREREQUISITES = 8,
+	SECURITY_LEVEL = 9,
+
+	/* String elements */
+	STR_MIN_LENGTH = 10,
+	STR_MAX_LENGTH = 11,
+	STR_ELEM_CNT = 12,
+
+	/* Integer elements */
+	INT_LOWER_BOUND = 10,
+	INT_UPPER_BOUND = 11,
+	INT_SCALAR_INCREMENT = 12,
+	INT_ELEM_CNT = 13,
+
+	/* Enumeration elements */
+	ENUM_CURRENT_VALUE = 10,
+	ENUM_SIZE = 11,
+	ENUM_POSSIBLE_VALUES = 12,
+	ENUM_ELEM_CNT = 13,
+
+	/* Ordered list elements */
+	ORD_LIST_SIZE = 10,
+	ORD_LIST_ELEMENTS = 11,
+	ORD_ELEM_CNT = 12,
+
+	/* Password elements */
+	PSWD_MIN_LENGTH = 10,
+	PSWD_MAX_LENGTH = 11,
+	PSWD_SIZE = 12,
+	PSWD_ENCODINGS = 13,
+	PSWD_IS_SET = 14,
+	PSWD_ELEM_CNT = 15,
+};
+
+#define GET_INSTANCE_ID(type)						\
+	static int get_##type##_instance_id(struct kobject *kobj)	\
+	{								\
+		int i;							\
+									\
+		for (i = 0; i <= bioscfg_drv.type##_instances_count; i++) { \
+			if (!strcmp(kobj->name, bioscfg_drv.type##_data[i].attr_name_kobj->name)) \
+				return i;				\
+		}							\
+		return -EIO;						\
+	}
+
+#define ATTRIBUTE_S_PROPERTY_SHOW(name, type)				\
+	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, \
+				   char *buf)				\
+	{								\
+		int i = get_##type##_instance_id(kobj);			\
+		if (i >= 0)						\
+			return sysfs_emit(buf, "%s\n", bioscfg_drv.type##_data[i].name); \
+		return -EIO;						\
+	}
+
+#define ATTRIBUTE_N_PROPERTY_SHOW(name, type)				\
+	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, \
+				   char *buf)				\
+	{								\
+		int i = get_##type##_instance_id(kobj);			\
+		if (i >= 0)						\
+			return sysfs_emit(buf, "%d\n", bioscfg_drv.type##_data[i].name); \
+		return -EIO;						\
+	}
+
+#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)			\
+	static ssize_t curr_val##_store(struct kobject *kobj,		\
+					struct kobj_attribute *attr,	\
+					const char *buf, size_t count)	\
+	{								\
+		char *attr_value = NULL;				\
+		int i;							\
+		int ret = -EIO;						\
+									\
+		attr_value = kstrdup(buf, GFP_KERNEL);			\
+		if (!attr_value)					\
+			return -ENOMEM;					\
+									\
+		ret = hp_enforce_single_line_input(attr_value, count);	\
+		if (!ret) {						\
+			i = get_##type##_instance_id(kobj);		\
+			if (i >= 0)					\
+				ret = validate_##type##_input(i, attr_value); \
+		}							\
+		if (!ret)						\
+			ret = hp_set_attribute(kobj->name, attr_value);	\
+		if (!ret) {						\
+			update_##type##_value(i, attr_value);		\
+			if (bioscfg_drv.type##_data[i].common.requires_physical_presence)	\
+				hp_set_reboot_and_signal_event();	\
+		}							\
+		hp_clear_all_credentials();				\
+		kfree(attr_value);					\
+									\
+		return ret ? ret : count;				\
+	}
+
+#define ATTRIBUTE_SPM_N_PROPERTY_SHOW(name, type)			\
+	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{								\
+		return sysfs_emit(buf, "%d\n", bioscfg_drv.type##_data.name); \
+	}
+
+#define ATTRIBUTE_SPM_S_PROPERTY_SHOW(name, type)			\
+	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{								\
+		return sysfs_emit(buf, "%s\n", bioscfg_drv.type##_data.name); \
+	}
+
+#define ATTRIBUTE_VALUES_PROPERTY_SHOW(name, type, sep)			\
+	static ssize_t name##_show(struct kobject *kobj,		\
+				   struct kobj_attribute *attr, char *buf) \
+	{								\
+		int i;							\
+		int len = 0;						\
+		int instance_id = get_##type##_instance_id(kobj);	\
+									\
+		if (instance_id < 0)					\
+			return 0;					\
+									\
+		for (i = 0; i < bioscfg_drv.type##_data[instance_id].name##_size; i++) { \
+			if (i)						\
+				len += sysfs_emit_at(buf, len, "%s", sep); \
+									\
+			len += sysfs_emit_at(buf, len, "%s",		\
+					     bioscfg_drv.type##_data[instance_id].name[i]); \
+		}							\
+		len += sysfs_emit_at(buf, len, "\n");			\
+		return len;						\
+	}
+
+#define ATTRIBUTE_S_COMMON_PROPERTY_SHOW(name, type)		\
+	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, \
+				   char *buf)				\
+	{								\
+		int i = get_##type##_instance_id(kobj);			\
+		if (i >= 0)						\
+			return sysfs_emit(buf, "%s\n", bioscfg_drv.type##_data[i].common.name); \
+		return -EIO;						\
+	}
+
+/* Prototypes */
+
+/* String attributes */
+int hp_populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+				   int instance_id,
+				   struct kobject *attr_name_kobj);
+int hp_alloc_string_data(void);
+void hp_exit_string_attributes(void);
+int hp_populate_string_package_data(union acpi_object *str_obj,
+				    int instance_id,
+				    struct kobject *attr_name_kobj);
+
+/* Integer attributes */
+int hp_populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+				    int instance_id,
+				    struct kobject *attr_name_kobj);
+int hp_alloc_integer_data(void);
+void hp_exit_integer_attributes(void);
+int hp_populate_integer_package_data(union acpi_object *integer_obj,
+				     int instance_id,
+				     struct kobject *attr_name_kobj);
+
+/* Enumeration attributes */
+int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+					int instance_id,
+					struct kobject *attr_name_kobj);
+int hp_alloc_enumeration_data(void);
+void hp_exit_enumeration_attributes(void);
+int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
+					 int instance_id,
+					 struct kobject *attr_name_kobj);
+
+/* Ordered list */
+int hp_populate_ordered_list_buffer_data(u8 *buffer_ptr,
+					 u32 *buffer_size,
+					 int instance_id,
+					 struct kobject *attr_name_kobj);
+int hp_alloc_ordered_list_data(void);
+void hp_exit_ordered_list_attributes(void);
+int hp_populate_ordered_list_package_data(union acpi_object *order_obj,
+					  int instance_id,
+					  struct kobject *attr_name_kobj);
+
+/* Password authentication attributes */
+int hp_populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
+				     int instance_id,
+				     struct kobject *attr_name_kobj);
+int hp_populate_password_package_data(union acpi_object *password_obj,
+				      int instance_id,
+				      struct kobject *attr_name_kobj);
+int hp_alloc_password_data(void);
+int hp_get_password_instance_for_type(const char *name);
+int hp_clear_all_credentials(void);
+int hp_set_attribute(const char *a_name, const char *a_value);
+
+/* SPM attributes */
+void hp_exit_password_attributes(void);
+void hp_exit_secure_platform_attributes(void);
+int hp_populate_secure_platform_data(struct kobject *attr_name_kobj);
+int hp_populate_security_buffer(u16 *buffer, const char *authentication);
+
+/* Bios Attributes interface */
+int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size);
+int hp_wmi_perform_query(int query, enum hp_wmi_command command,
+			 void *buffer, u32 insize, u32 outsize);
+
+/* Sure Start attributes */
+void hp_exit_sure_start_attributes(void);
+int hp_populate_sure_start_data(struct kobject *attr_name_kobj);
+
+/* Bioscfg */
+
+void hp_exit_attr_set_interface(void);
+int hp_init_attr_set_interface(void);
+size_t hp_calculate_string_buffer(const char *str);
+size_t hp_calculate_security_buffer(const char *authentication);
+void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str);
+int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer);
+int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size);
+int hp_convert_hexstr_to_str(const char *input, u32 input_len, char **str, int *len);
+int hp_encode_outsize_for_pvsz(int outsize);
+int hp_enforce_single_line_input(char *buf, size_t count);
+void hp_set_reboot_and_signal_event(void);
+ssize_t display_name_language_code_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf);
+union acpi_object *hp_get_wmiobj_pointer(int instance_id, const char *guid_string);
+int hp_get_instance_count(const char *guid_string);
+void hp_update_attribute_permissions(bool isreadonly, struct kobj_attribute *current_val);
+void hp_friendly_user_name_update(char *path, const char *attr_name,
+				  char *attr_display, int attr_size);
+int hp_wmi_error_and_message(int error_code);
+
+#endif
-- 
2.34.1

