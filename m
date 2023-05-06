Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EC16F8FC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEFHPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjEFHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:15:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BB4C1E;
        Sat,  6 May 2023 00:15:46 -0700 (PDT)
Date:   Sat, 6 May 2023 09:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683357345; bh=bhEgipdEVYR8FJKCRohwbojD4zArxXeQZvOIVgZhQiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGftkgFC1unjj9VfPoOIC9fq6NZD6500ovqNdGy1vXtLlBvtIBG3qiVMIzFE7FAvx
         xJpudRx1Prtr7YMlJNH2GWZwyIlLlWBuVdSSszeSyoXEmVQtjulZkz3snJm+furA1Y
         HaU0mW+jwCLdKEUwa4PNvurWeRlDinUioK23d3jc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 08/13] HP BIOSCFG driver  - bioscfg-h
Message-ID: <83b3f3ac-74e8-4681-828e-a82d64d6f104@t-8ch.de>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
 <20230505220043.39036-9-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505220043.39036-9-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 17:00:38-0500, Jorge Lopez wrote:
<snip>

> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 523 +++++++++++++++++++
>  1 file changed, 523 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> new file mode 100644
> index 000000000000..f27667d7ba9f
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> @@ -0,0 +1,523 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using hp_bioscfg driver
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#ifndef _HP_BIOSCFG_H_
> +#define _HP_BIOSCFG_H_
> +
> +#include <linux/wmi.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/capability.h>
> +#include <linux/nls.h>
> +
> +#define DRIVER_NAME		"hp-bioscfg"
> +
> +#define MAX_BUFF		512
> +#define MAX_KEY_MOD		256

Seems to need _SIZE suffix.

> +#define MAX_PASSWD_SIZE		64
> +#define MAX_MESSAGE_SIZE	256

Never used.

> +#define MAX_PREREQUISITES_SIZE	20
> +#define MAX_REQ_ELEM_SIZE	128
> +#define MAX_VALUES_SIZE		16
> +#define MAX_ENCODINGS_SIZE	16
> +#define MAX_ELEMENTS_SIZE	16
> +
> +#define SPM_STR_DESC		"Secure Platform Management"
> +#define SPM_STR			"SPM"
> +#define SURE_START_DESC		"Sure Start"
> +#define SURE_START_STR		"Sure_Start"
> +#define SETUP_PASSWD		"Setup Password"
> +#define POWER_ON_PASSWD		"Power-On Password"
> +
> +#define LANG_CODE_STR		"en_US.UTF-8"
> +#define SCHEDULE_POWER_ON	"Scheduled Power-On"
> +
> +#define COMMA_SEP		","
> +#define SEMICOLON_SEP		";"
> +
> +/* Sure Admin Functions */
> +
> +#define UTF_PREFIX		"<utf-16/>"
> +#define BEAM_PREFIX		"<BEAM/>"
> +
> +/* mechanism - Authentication attribute */
> +
> +#define MAX_MECHANISM_TYPES	3

Never used.

> +
> +enum mechanism_values {
> +	PASSWORD		= 0x00,
> +	NOT_PROVISION		= 0x00,

Never used.

> +	SIGNING_KEY		= 0x01,
> +	ENDORSEMENT_KEY		= 0x02,
> +};
> +
> +#define BIOS_ADMIN		"bios-admin"
> +#define POWER_ON		"power-on"
> +#define BIOS_SPM		"enhanced-bios-auth"
> +
> +#define PASSWD_MECHANISM_TYPES "password"
> +
> +#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
> +
> +#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4c35-AF3E-6A1B8106F83C"
> +#define HP_WMI_BIOS_INTEGER_GUID	"8232DE3D-663D-4327-A8F4-E293ADB9BF05"
> +#define HP_WMI_BIOS_ENUMERATION_GUID	"2D114B49-2DFB-4130-B8FE-4A3C09E75133"
> +#define HP_WMI_BIOS_ORDERED_LIST_GUID	"14EA9746-CE1F-4098-A0E0-7045CB4DA745"
> +#define HP_WMI_BIOS_PASSWORD_GUID	"322F2028-0F84-4901-988E-015176049E2D"
> +#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460b-951D-C7CB9B4B8D5E"
> +
> +enum hp_wmi_spm_commandtype {
> +	HPWMI_SECUREPLATFORM_GET_STATE  = 0x10,
> +	HPWMI_SECUREPLATFORM_SET_KEK	= 0x11,
> +	HPWMI_SECUREPLATFORM_SET_SK	= 0x12,
> +};
> +
> +enum hp_wmi_surestart_commandtype {
> +	HPWMI_SURESTART_GET_LOG_COUNT	= 0x01,
> +	HPWMI_SURESTART_GET_LOG		= 0x02,
> +};
> +
> +enum hp_wmi_command {
> +	HPWMI_READ		= 0x01,
> +	HPWMI_WRITE		= 0x02,
> +	HPWMI_ODM		= 0x03,
> +	HPWMI_SURESTART		= 0x20006,
> +	HPWMI_GM		= 0x20008,
> +	HPWMI_SECUREPLATFORM	= 0x20010,
> +};
> +
> +struct bios_return {
> +	u32 sigpass;
> +	u32 return_code;
> +};
> +
> +enum wmi_error_values {
> +	SUCCESS				= 0x00,
> +	CMD_FAILED			= 0x01,
> +	INVALID_SIGN			= 0x02,
> +	INVALID_CMD_VALUE		= 0x03,
> +	INVALID_CMD_TYPE		= 0x04,
> +	INVALID_DATA_SIZE		= 0x05,
> +	INVALID_CMD_PARAM		= 0x06,
> +	ENCRYP_CMD_REQUIRED		= 0x07,
> +	NO_SECURE_SESSION		= 0x08,
> +	SECURE_SESSION_FOUND		= 0x09,
> +	SECURE_SESSION_FAILED		= 0x0A,
> +	AUTH_FAILED			= 0x0B,
> +	INVALID_BIOS_AUTH		= 0x0E,
> +	NONCE_DID_NOT_MATCH		= 0x18,
> +	GENERIC_ERROR			= 0x1C,
> +	BIOS_ADMIN_POLICY_NOT_MET	= 0x28,
> +	BIOS_ADMIN_NOT_SET		= 0x38,
> +	P21_NO_PROVISIONED		= 0x1000,
> +	P21_PROVISION_IN_PROGRESS	= 0x1001,
> +	P21_IN_USE			= 0x1002,
> +	HEP_NOT_ACTIVE			= 0x1004,
> +	HEP_ALREADY_SET			= 0x1006,
> +	HEP_CHECK_STATE			= 0x1007,
> +};
> +
> +enum spm_features {
> +	HEP_ENABLED			= 0x01,
> +	PLATFORM_RECOVERY		= 0x02,
> +	ENHANCED_BIOS_AUTH_MODE		= 0x04,
> +};
> +
> +enum spm_states_values {
> +	NOT_PROVISIONED			= 0x00,
> +	PROVISIONED			= 0x01,
> +	PROVISIONING_IN_PROGRESS	= 0x02,
> +};

Are these enums used?

> +
> +struct common_data {
> +	u8 display_name[MAX_BUFF];
> +	u8 path[MAX_BUFF];
> +	u32 is_readonly;
> +	u32 display_in_ui;
> +	u32 requires_physical_presence;
> +	u32 sequence;
> +	u32 prerequisites_size;
> +	u8 prerequisites[MAX_PREREQUISITES_SIZE][MAX_BUFF];
> +	u32 security_level;
> +	u8 display_name_language_code[MAX_BUFF];
> +};
> +
> +struct string_data {
> +	struct common_data common;
> +	struct kobject *attr_name_kobj;
> +	u8 current_value[MAX_BUFF];
> +	u8 new_value[MAX_BUFF];
> +	u32 min_length;
> +	u32 max_length;
> +};
> +
> +struct integer_data {
> +	struct common_data common;
> +	struct kobject *attr_name_kobj;
> +	u32 current_value;
> +	u32 new_value;
> +	u32 lower_bound;
> +	u32 upper_bound;
> +	u32 scalar_increment;
> +};
> +
> +struct enumeration_data {
> +	struct common_data common;
> +	struct kobject *attr_name_kobj;
> +	u8 current_value[MAX_BUFF];
> +	u8 new_value[MAX_BUFF];
> +	u32 possible_values_size;
> +	u8 possible_values[MAX_VALUES_SIZE][MAX_BUFF];
> +};
> +
> +struct ordered_list_data {
> +	struct common_data common;
> +	struct kobject *attr_name_kobj;
> +	u8 current_value[MAX_BUFF];
> +	u8 new_value[MAX_BUFF];
> +	u32 elements_size;
> +	u8 elements[MAX_ELEMENTS_SIZE][MAX_BUFF];
> +};
> +
> +struct password_data {
> +	struct common_data common;
> +	struct kobject *attr_name_kobj;
> +	u8 current_password[MAX_PASSWD_SIZE];
> +	u8 new_password[MAX_PASSWD_SIZE];
> +	u32 min_password_length;
> +	u32 max_password_length;
> +	u32 encodings_size;
> +	u8 encodings[MAX_ENCODINGS_SIZE][MAX_BUFF];
> +	u32 is_enabled;

If it is only being used as a boolean, bool is nicer.

> +
> +	// 'bios-admin' 'power-on'
> +	u32 role;

Are the comments about the possible values or the context in which this
field will be used?
This should be clear.

> +
> +	//'password'
> +	u32 mechanism;
> +};
> +
> +struct secure_platform_data {
> +	struct kobject *attr_name_kobj;
> +	u8 attribute_name[MAX_BUFF];
> +	u8 *endorsement_key;
> +	u8 *signing_key;
> +	u8 *auth_token;
> +	u32 is_enabled;

Also bool.

> +	u32 mechanism;
> +};
> +
> +struct bioscfg_priv {
> +	struct wmi_device *bios_attr_wdev;
> +	struct kset *authentication_dir_kset;
> +	struct kset *main_dir_kset;
> +	struct device *class_dev;
> +	struct string_data *string_data;
> +	u32 string_instances_count;
> +	struct integer_data *integer_data;
> +	u32 integer_instances_count;
> +	struct enumeration_data *enumeration_data;
> +	u32 enumeration_instances_count;
> +	struct ordered_list_data *ordered_list_data;
> +	u32 ordered_list_instances_count;
> +	struct password_data *password_data;
> +	u32 password_instances_count;
> +
> +	struct kobject *sure_start_attr_kobj;
> +	struct secure_platform_data spm_data;
> +
> +	bool pending_reboot;
> +	struct mutex mutex;
> +};
> +
> +/* global structure used by multiple WMI interfaces */
> +extern struct bioscfg_priv bioscfg_drv;
> +
> +enum hp_wmi_data_type {
> +	HPWMI_STRING_TYPE		= 0x00,
> +	HPWMI_INTEGER_TYPE		= 0x01,
> +	HPWMI_ENUMERATION_TYPE		= 0x02,
> +	HPWMI_ORDERED_LIST_TYPE		= 0x03,
> +	HPWMI_PASSWORD_TYPE		= 0x04,
> +	HPWMI_SECURE_PLATFORM_TYPE	= 0x05,
> +	HPWMI_SURE_START_TYPE		= 0x06,
> +};

There is no need to explicitly specify enum values when they don't
matter.
This makes it clear if an enum represents values for an external ABI or
if it is just for internal use.

> +
> +enum hp_wmi_data_elements {
> +	/* Common elements */
> +	NAME = 0,
> +	VALUE = 1,
> +	PATH = 2,
> +	IS_READONLY = 3,
> +	DISPLAY_IN_UI = 4,
> +	REQUIRES_PHYSICAL_PRESENCE = 5,
> +	SEQUENCE = 6,
> +	PREREQUISITES_SIZE = 7,
> +	PREREQUISITES = 8,
> +	SECURITY_LEVEL = 9,
> +
> +	/* String elements */
> +	STR_MIN_LENGTH = 10,
> +	STR_MAX_LENGTH = 11,
> +	STR_ELEM_CNT = 12,
> +
> +	/* Integer elements */
> +	INT_LOWER_BOUND = 10,
> +	INT_UPPER_BOUND = 11,
> +	INT_SCALAR_INCREMENT = 12,
> +	INT_ELEM_CNT = 13,
> +
> +	/* Enumeration elements */
> +	ENUM_CURRENT_VALUE = 10,
> +	ENUM_SIZE = 11,
> +	ENUM_POSSIBLE_VALUES = 12,
> +	ENUM_ELEM_CNT = 13,
> +
> +	/* Ordered list elements */
> +	ORD_LIST_SIZE = 10,
> +	ORD_LIST_ELEMENTS = 11,
> +	ORD_ELEM_CNT = 12,
> +
> +	/* Password elements */
> +	PSWD_MIN_LENGTH = 10,
> +	PSWD_MAX_LENGTH = 11,
> +	PSWD_SIZE = 12,
> +	PSWD_ENCODINGS = 13,
> +	PSWD_IS_SET = 14,
> +	PSWD_ELEM_CNT = 15,
> +};
> +
> +#define GET_INSTANCE_ID(type)						\
> +	static int get_##type##_instance_id(struct kobject *kobj)	\
> +	{								\
> +		int i;							\
> +									\
> +		for (i = 0; i <= bioscfg_drv.type##_instances_count; i++) { \
> +			if (!strcmp(kobj->name, bioscfg_drv.type##_data[i].attr_name_kobj->name)) \
> +				return i;				\
> +		}							\
> +		return -EIO;						\
> +	}
> +
> +#define ATTRIBUTE_S_PROPERTY_SHOW(name, type)				\
> +	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, \
> +				   char *buf)				\
> +	{								\
> +		int i = get_##type##_instance_id(kobj);			\
> +		if (i >= 0)						\
> +			return sysfs_emit(buf, "%s\n", bioscfg_drv.type##_data[i].name); \
> +		return -EIO;						\
> +	}
> +
> +#define ATTRIBUTE_N_PROPERTY_SHOW(name, type)				\
> +	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, \
> +				   char *buf)				\
> +	{								\
> +		int i = get_##type##_instance_id(kobj);			\
> +		if (i >= 0)						\
> +			return sysfs_emit(buf, "%d\n", bioscfg_drv.type##_data[i].name); \
> +		return -EIO;						\
> +	}
> +
> +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)			\
> +	static ssize_t curr_val##_store(struct kobject *kobj,		\
> +					struct kobj_attribute *attr,	\
> +					const char *buf, size_t count)	\
> +	{								\
> +		char *attr_value = NULL;				\
> +		int i;							\
> +		int ret = -EIO;						\
> +									\
> +		attr_value = kstrdup(buf, GFP_KERNEL);			\
> +		if (!attr_value)					\
> +			return -ENOMEM;					\
> +									\
> +		ret = enforce_single_line_input(attr_value, count);	\
> +		if (!ret) {						\
> +			i = get_##type##_instance_id(kobj);		\
> +			if (i >= 0)					\
> +				ret = validate_##type##_input(i, attr_value); \
> +		}							\
> +		if (!ret)						\
> +			ret = hp_set_attribute(kobj->name, attr_value);	\
> +		if (!ret)						\
> +			update_##type##_value(i, attr_value);		\
> +									\
> +		clear_all_credentials();				\
> +		kfree(attr_value);					\
> +									\
> +		return ret ? ret : count;				\
> +	}
> +
> +#define ATTRIBUTE_SPM_N_PROPERTY_SHOW(name, type)			\
> +	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> +	{								\
> +		return sysfs_emit(buf, "%d\n", bioscfg_drv.type##_data.name); \
> +	}
> +
> +#define ATTRIBUTE_SPM_S_PROPERTY_SHOW(name, type)			\
> +	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> +	{								\
> +		return sysfs_emit(buf, "%s\n", bioscfg_drv.type##_data.name); \
> +	}
> +
> +#define ATTRIBUTE_VALUES_PROPERTY_SHOW(name, type, sep)			\
> +	static ssize_t name##_show(struct kobject *kobj,		\
> +				   struct kobj_attribute *attr, char *buf) \
> +	{								\
> +		int i;							\
> +		int len = 0;						\
> +		int instance_id = get_##type##_instance_id(kobj);	\
> +									\
> +		if (instance_id < 0)					\
> +			return 0;					\
> +									\
> +		for (i = 0; i < bioscfg_drv.type##_data[instance_id].name##_size; i++) { \
> +			if (i)						\
> +				len += sysfs_emit_at(buf, len, "%s", sep); \
> +									\
> +			len += sysfs_emit_at(buf, len, "%s",		\
> +					     bioscfg_drv.type##_data[instance_id].name[i]); \
> +		}							\
> +		len += sysfs_emit_at(buf, len, "\n");			\
> +		return len;						\
> +	}
> +
> +#define ATTRIBUTE_S_COMMON_PROPERTY_SHOW(name, type)		\
> +	static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr, \
> +				   char *buf)				\
> +	{								\
> +		int i = get_##type##_instance_id(kobj);			\
> +		if (i >= 0)						\
> +			return sysfs_emit(buf, "%s\n", bioscfg_drv.type##_data[i].common.name); \
> +		return -EIO;						\
> +	}
> +
> +/*
> + * Prototypes
> + */
> +union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);

Weren't all non-static functions supposed to gain a common prefix?

> +int get_instance_count(const char *guid_string);
> +void update_attribute_permissions(u32 isreadonly, struct kobj_attribute *current_val);

"bool readonly" should be enough.

> +void friendly_user_name_update(char *path, const char *attr_name,
> +			       char *attr_display, int attr_size);
> +int hp_wmi_error_and_message(int error_code);
> +
> +/* String attributes */
> +int populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> +				int instance_id,
> +				struct kobject *attr_name_kobj);
> +
> +int populate_string_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					 int instance_id);
> +int alloc_string_data(void);
> +void exit_string_attributes(void);
> +int populate_string_package_data(union acpi_object *str_obj,
> +				 int instance_id,
> +				 struct kobject *attr_name_kobj);
> +int populate_string_elements_from_package(union acpi_object *str_obj,
> +					  int str_obj_count,
> +					  int instance_id);
> +
> +/* Integer attributes */
> +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> +				 int instance_id,
> +				 struct kobject *attr_name_kobj);
> +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					  int instance_id);
> +int alloc_integer_data(void);
> +void exit_integer_attributes(void);
> +int populate_integer_package_data(union acpi_object *integer_obj,
> +				  int instance_id,
> +				  struct kobject *attr_name_kobj);
> +int populate_integer_elements_from_package(union acpi_object *integer_obj,
> +					   int integer_obj_count,
> +					   int instance_id);
> +
> +/* Enumeration attributes */
> +int populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> +				     int instance_id,
> +				     struct kobject *attr_name_kobj);
> +int populate_enumeration_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					      int instance_id);
> +int alloc_enumeration_data(void);
> +void exit_enumeration_attributes(void);
> +int populate_enumeration_package_data(union acpi_object *enum_obj,
> +				      int instance_id,
> +				      struct kobject *attr_name_kobj);
> +int populate_enumeration_elements_from_package(union acpi_object *enum_obj,
> +					       int enum_obj_count,
> +					       int instance_id);
> +
> +/* Ordered list */
> +int populate_ordered_list_buffer_data(u8 *buffer_ptr,
> +				      u32 *buffer_size,
> +				      int instance_id,
> +				      struct kobject *attr_name_kobj);
> +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr,
> +					       u32 *buffer_size,
> +					       int instance_id);
> +int alloc_ordered_list_data(void);
> +void exit_ordered_list_attributes(void);
> +int populate_ordered_list_package_data(union acpi_object *order_obj,
> +				       int instance_id,
> +				       struct kobject *attr_name_kobj);
> +int populate_ordered_list_elements_from_package(union acpi_object *order_obj,
> +						int order_obj_count,
> +						int instance_id);
> +
> +/* Password authentication attributes */
> +int populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> +				  int instance_id,
> +				  struct kobject *attr_name_kobj);
> +int populate_password_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					   int instance_id);
> +int populate_password_package_data(union acpi_object *password_obj,
> +				   int instance_id,
> +				   struct kobject *attr_name_kobj);
> +int populate_password_elements_from_package(union acpi_object *password_obj,
> +					    int password_obj_count,
> +					    int instance_id);
> +int alloc_password_data(void);
> +int alloc_secure_platform_data(void);
> +void exit_password_attributes(void);
> +void exit_secure_platform_attributes(void);
> +int populate_secure_platform_data(struct kobject *attr_name_kobj);
> +int check_spm_is_enabled(void);
> +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size);
> +int hp_wmi_perform_query(int query, enum hp_wmi_command command,
> +			 void *buffer, u32 insize, u32 outsize);
> +int validate_password_input(int instance_id, const char *buf);
> +
> +/* Sure Start attributes */
> +void exit_sure_start_attributes(void);
> +int populate_sure_start_data(struct kobject *attr_name_kobj);
> +
> +int set_bios_defaults(u8 deftype);

This seems not to actually exist.

> +int get_password_instance_for_type(const char *name);
> +int clear_all_credentials(void);
> +int clear_passwords(const int instance);
> +void exit_hp_attr_set_interface(void);
> +int init_hp_attr_set_interface(void);
> +size_t hp_calculate_string_buffer(const char *str);
> +size_t calculate_security_buffer(const char *authentication);
> +int populate_security_buffer(u16 *buffer, const char *authentication);
> +int set_new_password(const char *password_type, const char *new_password);
> +int init_hp_attr_pass_interface(void);
> +void exit_hp_attr_pass_interface(void);
> +void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str);
> +int get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer);
> +int get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size);
> +int convert_hexstr_to_str(const char *input, u32 input_len, char **str, int *len);
> +int encode_outsize_for_pvsz(int outsize);
> +int hp_set_attribute(const char *a_name, const char *a_value);
> +int enforce_single_line_input(char *buf, size_t count);
> +void set_reboot_and_signal_event(void);
> +
> +#endif
> -- 
> 2.34.1
> 
