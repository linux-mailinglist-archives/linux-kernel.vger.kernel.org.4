Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C66EBC04
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 00:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDVWn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVWnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 18:43:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C326B5;
        Sat, 22 Apr 2023 15:43:52 -0700 (PDT)
Date:   Sun, 23 Apr 2023 00:43:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682203430; bh=0nBuXr0/0XsiDx6nJgKPyTZeTr+26GgYeqsOw8gB/PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3/CtKGLXmWkB0eW7J8gFMbfFooOiMdhkfDjnMBdg2L6f4dfAPYcTQBVWsc2VbMWz
         SeZRHk3UKSougaFy8c2aWMVz3L9nOKrSkplPWpU63KUEuhJaoN6Ue2TlHuKfUVLe5+
         UWM3z/JIgDIqOy5Ooaltcz7fzHm8IFNpZnoD5agE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/14] HP BIOSCFG driver  - int-attributes
Message-ID: <26f0a80e-d3f8-4d6c-83ff-d756abed7b6b@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-5-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-5-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

one thing I noticed:

When I recommended to cut down the driver to a minimal feature set I
meant the minimal feature set currently known to the kernel.

This would *not* be sufficient for your HP-specific agent software.
Just the standard type attributes, ordered-list and authentication.

But in the end it would most probably still be a faster path to a
solution that *does* include the full featureset of your requirements.


Also when fixing review comments please try to fix them everywhere where
applicable. Most comments affect many parts of the code.

On 2023-04-20 11:54:44-0500, Jorge Lopez wrote:
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../x86/hp/hp-bioscfg/int-attributes.c        | 474 ++++++++++++++++++
>  1 file changed, 474 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> new file mode 100644
> index 000000000000..d8ee39dac3f9
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to integer type attributes under
> + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 Hewlett-Packard Inc.
> + */
> +
> +#include "bioscfg.h"
> +
> +GET_INSTANCE_ID(integer);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id = get_integer_instance_id(kobj);
> +
> +	if (instance_id < 0)
> +		return instance_id;

Some attributes return -EIO here, some instance_id. This should be
consistent.

> +
> +	return sysfs_emit(buf, "%d\n",
> +			  bioscfg_drv.integer_data[instance_id].current_value);
> +}
> +
> +/*
> + * validate_integer_input() -
> + * Validate input of current_value against lower and upper bound
> + *
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + */
> +static int validate_integer_input(int instance_id, char *buf)
> +{
> +	int in_val;
> +	int ret;
> +
> +
> +	/* BIOS treats it as a read only attribute */
> +	if (bioscfg_drv.integer_data[instance_id].common.is_readonly)
> +		return -EIO;
> +
> +	ret = kstrtoint(buf, 10, &in_val);
> +	if (ret < 0)
> +		return ret;
> +
> +
> +	if (in_val < bioscfg_drv.integer_data[instance_id].lower_bound ||
> +	    in_val > bioscfg_drv.integer_data[instance_id].upper_bound)
> +		return -ERANGE;
> +
> +	/*
> +	 * set pending reboot flag depending on
> +	 * "RequiresPhysicalPresence" value
> +	 */
> +	if (bioscfg_drv.integer_data[instance_id].common.requires_physical_presence)
> +		bioscfg_drv.pending_reboot = true;
> +	return 0;
> +}
> +
> +static void update_integer_value(int instance_id, char *attr_value)
> +{
> +	int in_val;
> +	int ret;
> +
> +	ret = kstrtoint(attr_value, 10, &in_val);
> +	if (ret == 0)
> +		bioscfg_drv.integer_data[instance_id].current_value = in_val;

If the error is not propagated there should be at least be a warning.

> +}
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, integer);
> +static struct kobj_attribute integer_display_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, integer);
> +static struct kobj_attribute integer_display_name =
> +	__ATTR_RO(display_name);
> +
> +ATTRIBUTE_PROPERTY_STORE(current_value, integer);
> +static struct kobj_attribute integer_current_val =
> +	__ATTR_RW_MODE(current_value, 0644);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(lower_bound, integer);
> +static struct kobj_attribute integer_lower_bound =
> +	__ATTR_RO(lower_bound);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(upper_bound, integer);
> +static struct kobj_attribute integer_upper_bound =
> +	__ATTR_RO(upper_bound);
> +
> +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, integer);
> +static struct kobj_attribute  integer_prerequisites_size_val =
> +	__ATTR_RO(prerequisites_size);
> +
> +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, integer);
> +static struct kobj_attribute  integer_prerequisites_val =
> +	__ATTR_RO(prerequisites);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(scalar_increment, integer);
> +static struct kobj_attribute integer_scalar_increment =
> +	__ATTR_RO(scalar_increment);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "integer\n");
> +}
> +static struct kobj_attribute integer_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *integer_attrs[] = {
> +	&integer_display_langcode.attr,
> +	&integer_display_name.attr,
> +	&integer_current_val.attr,
> +	&integer_lower_bound.attr,
> +	&integer_upper_bound.attr,
> +	&integer_scalar_increment.attr,
> +	&integer_prerequisites_size_val.attr,
> +	&integer_prerequisites_val.attr,
> +	&integer_type.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group integer_attr_group = {
> +	.attrs = integer_attrs,
> +};
> +
> +int alloc_integer_data(void)
> +{
> +	int ret = 0;

No need for the ret variable.

> +
> +	bioscfg_drv.integer_instances_count = get_instance_count(HP_WMI_BIOS_INTEGER_GUID);
> +	bioscfg_drv.integer_data = kcalloc(bioscfg_drv.integer_instances_count,
> +					   sizeof(struct integer_data), GFP_KERNEL);

sizeof(bioscfg_drv.integer_data);

> +
> +	if (!bioscfg_drv.integer_data) {
> +		bioscfg_drv.integer_instances_count = 0;
> +		ret = -ENOMEM;
> +	}
> +	return ret;
> +}
> +
> +/* Expected Values types associated with each element */
> +static const acpi_object_type expected_integer_types[] = {
> +	[NAME] = ACPI_TYPE_STRING,
> +	[VALUE] = ACPI_TYPE_STRING,
> +	[PATH] = ACPI_TYPE_STRING,
> +	[IS_READONLY] = ACPI_TYPE_INTEGER,
> +	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
> +	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
> +	[SEQUENCE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES] = ACPI_TYPE_STRING,
> +	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
> +	[INT_LOWER_BOUND] = ACPI_TYPE_INTEGER,
> +	[INT_UPPER_BOUND] = ACPI_TYPE_INTEGER,
> +	[INT_SCALAR_INCREMENT] = ACPI_TYPE_INTEGER

Trailing comma.

> +};
> +
> +/*
> + * populate_int_data() -
> + * Populate all properties of an instance under integer attribute
> + *
> + * @integer_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_integer_package_data(union acpi_object *integer_obj,
> +				  int instance_id,
> +				  struct kobject *attr_name_kobj)
> +{
> +	bioscfg_drv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	populate_integer_elements_from_package(integer_obj,
> +					       integer_obj->package.count,
> +					       instance_id);
> +	update_attribute_permissions(bioscfg_drv.integer_data[instance_id].common.is_readonly,
> +				     &integer_current_val);
> +	friendly_user_name_update(bioscfg_drv.integer_data[instance_id].common.path,
> +				  attr_name_kobj->name,
> +				  bioscfg_drv.integer_data[instance_id].common.display_name,
> +				  sizeof(bioscfg_drv.integer_data[instance_id].common.display_name));
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +int populate_integer_elements_from_package(union acpi_object *integer_obj,
> +					   int integer_obj_count,
> +					   int instance_id)
> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret = 0;
> +	u32 size = 0;
> +	u32 int_value;
> +	int elem = 0;
> +	int reqs;
> +	int eloc;
> +
> +	if (!integer_obj)
> +		return -EINVAL;
> +
> +	strscpy(bioscfg_drv.integer_data[instance_id].common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(bioscfg_drv.integer_data[instance_id].common.display_name_language_code));
> +
> +	for (elem = 1, eloc = 1; elem < integer_obj_count; elem++, eloc++) {
> +
> +		/* ONLY look at the first INTEGER_ELEM_CNT elements */

Why?

> +		if (eloc == INTEGER_ELEM_CNT)
> +			goto exit_integer_package;
> +
> +		switch (integer_obj[elem].type) {
> +		case ACPI_TYPE_STRING:
> +
> +			if (elem != PREREQUISITES) {
> +				ret = convert_hexstr_to_str(integer_obj[elem].string.pointer,
> +							    integer_obj[elem].string.length,
> +							    &str_value, &value_len);
> +				if (ret)
> +					continue;
> +			}
> +			break;
> +		case ACPI_TYPE_INTEGER:
> +			int_value = (u32)integer_obj[elem].integer.value;
> +			break;
> +		default:
> +			pr_warn("Unsupported object type [%d]\n", integer_obj[elem].type);
> +			continue;
> +		}
> +		/* Check that both expected and read object type match */
> +		if (expected_integer_types[eloc] != integer_obj[elem].type) {
> +			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
> +			       expected_integer_types[eloc], elem, integer_obj[elem].type);
> +			return -EIO;
> +		}
> +		/* Assign appropriate element value to corresponding field*/
> +		switch (eloc) {
> +		case VALUE:
> +			ret = kstrtoint(str_value, 10, &int_value);
> +			if (ret)
> +				continue;
> +
> +			bioscfg_drv.integer_data[instance_id].current_value = int_value;
> +			break;
> +		case PATH:
> +			strscpy(bioscfg_drv.integer_data[instance_id].common.path, str_value,
> +				sizeof(bioscfg_drv.integer_data[instance_id].common.path));
> +			break;
> +		case IS_READONLY:
> +			bioscfg_drv.integer_data[instance_id].common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			bioscfg_drv.integer_data[instance_id].common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			bioscfg_drv.integer_data[instance_id].common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			bioscfg_drv.integer_data[instance_id].common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			bioscfg_drv.integer_data[instance_id].common.prerequisites_size = int_value;
> +
> +			if (int_value > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  PREREQUISITES
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (int_value == 0)
> +				eloc++;
> +			break;
> +		case PREREQUISITES:
> +			size = bioscfg_drv.integer_data[instance_id].common.prerequisites_size;
> +
> +			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
> +				if (elem >= integer_obj_count) {
> +					pr_err("Error elem-objects package is too small\n");
> +					return -EINVAL;
> +				}
> +
> +				ret = convert_hexstr_to_str(integer_obj[elem + reqs].string.pointer,
> +							    integer_obj[elem + reqs].string.length,
> +							    &str_value, &value_len);
> +
> +				if (ret)
> +					continue;
> +
> +				strscpy(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs],
> +					str_value,
> +					sizeof(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs]));
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			bioscfg_drv.integer_data[instance_id].common.security_level = int_value;
> +			break;
> +		case INT_LOWER_BOUND:
> +			bioscfg_drv.integer_data[instance_id].lower_bound = int_value;
> +			break;
> +		case INT_UPPER_BOUND:
> +			bioscfg_drv.integer_data[instance_id].upper_bound = int_value;
> +			break;
> +		case INT_SCALAR_INCREMENT:
> +			bioscfg_drv.integer_data[instance_id].scalar_increment = int_value;
> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +	}
> +exit_integer_package:
> +	kfree(str_value);
> +	return 0;
> +}
> +
> +
> +/*
> + * populate_integer_buffer_data() -
> + * Populate all properties of an instance under integer attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				 struct kobject *attr_name_kobj)
> +{
> +	bioscfg_drv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate integer elements */
> +	populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
> +					      instance_id);
> +	update_attribute_permissions(bioscfg_drv.integer_data[instance_id].common.is_readonly,
> +				     &integer_current_val);
> +	friendly_user_name_update(bioscfg_drv.integer_data[instance_id].common.path,
> +				  attr_name_kobj->name,
> +				  bioscfg_drv.integer_data[instance_id].common.display_name,
> +				  sizeof(bioscfg_drv.integer_data[instance_id].common.display_name));
> +
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					  int instance_id)
> +{
> +	char *dst = NULL;
> +	int elem;
> +	int reqs;
> +	int integer;
> +	int size = 0;
> +	int ret;
> +	int dst_size = *buffer_size / sizeof(u16);
> +
> +	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> +	if (!dst)
> +		return -ENOMEM;
> +
> +	elem = 0;
> +	strscpy(bioscfg_drv.integer_data[instance_id].common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(bioscfg_drv.integer_data[instance_id].common.display_name_language_code));
> +
> +	for (elem = 1; elem < 3; elem++) {
> +
> +		ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +		if (ret < 0)
> +			continue;
> +
> +		switch (elem) {
> +		case VALUE:
> +			ret = kstrtoint(dst, 10, &integer);
> +			if (ret)
> +				continue;
> +
> +			bioscfg_drv.integer_data[instance_id].current_value = integer;
> +			break;
> +		case PATH:
> +			strscpy(bioscfg_drv.integer_data[instance_id].common.path, dst,
> +				sizeof(bioscfg_drv.integer_data[instance_id].common.path));
> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +	}
> +
> +	for (elem = 3; elem < INTEGER_ELEM_CNT; elem++) {

This loop pattern seems weird to me.
It is not obvious that the values are read in the order of the switch()
branches from the buffer.

Something more obvious would be:

instance.common.is_readonly = read_int_from_buf(&buffer_ptr);
instance.common.display_in_ui = read_int_from_buf(&buffer_ptr);
instance.common.requires_physical_presence = read_int_from_buf(&buffer_ptr);

This would make it clear that these are fields read in order from the
buffer. Without having to also look at the numeric values of the
defines.

Furthermore it would make the code shorter and errorhandling would be
clearer and the API similar to the netlink APIs.

Or maybe with error reporting:

ret = read_int_from_buf(&buffer_ptr, &instance.common.is_readonly);
if (ret)
    ...
ret = read_int_from_buf(&buffer_ptr, &instance.common.display_in_ui);
if (ret)
    ...

> +
> +		if (elem != PREREQUISITES) {
> +			ret = get_integer_from_buffer((int **)&buffer_ptr, buffer_size, (int *)&integer);
> +			if (ret < 0)
> +				continue;
> +		}
> +
> +		switch (elem) {
> +
> +		case IS_READONLY:
> +			bioscfg_drv.integer_data[instance_id].common.is_readonly = integer;
> +			break;
> +		case DISPLAY_IN_UI:
> +			bioscfg_drv.integer_data[instance_id].common.display_in_ui = integer;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			bioscfg_drv.integer_data[instance_id].common.requires_physical_presence = integer;
> +			break;
> +		case SEQUENCE:
> +			bioscfg_drv.integer_data[instance_id].common.sequence = integer;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			bioscfg_drv.integer_data[instance_id].common.prerequisites_size = integer;
> +			size = integer;
> +			if (size > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +
> +			// PREREQUISITES:
> +			elem++;
> +			for (reqs = 0; reqs < size && reqs  < MAX_PREREQUISITES_SIZE; reqs++) {
> +				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +				if (ret < 0)
> +					continue;
> +
> +				strscpy(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs],
> +					dst,
> +					sizeof(bioscfg_drv.integer_data[instance_id].common.prerequisites[reqs]));
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			bioscfg_drv.integer_data[instance_id].common.security_level = integer;
> +			break;
> +		case INT_LOWER_BOUND:
> +			bioscfg_drv.integer_data[instance_id].lower_bound = integer;
> +			break;
> +		case INT_UPPER_BOUND:
> +			bioscfg_drv.integer_data[instance_id].upper_bound = integer;
> +			break;
> +		case INT_SCALAR_INCREMENT:
> +			bioscfg_drv.integer_data[instance_id].scalar_increment = integer;
> +			break;
> +
> +		default:
> +			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +	}
> +	kfree(dst);
> +
> +	return 0;
> +}
> +
> +/*
> + * exit_integer_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + */
> +void exit_integer_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < bioscfg_drv.integer_instances_count; instance_id++) {
> +
> +		struct kobject *attr_name_kobj = bioscfg_drv.integer_data[instance_id].attr_name_kobj;
> +
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj, &integer_attr_group);
> +	}
> +	bioscfg_drv.integer_instances_count = 0;
> +
> +	kfree(bioscfg_drv.integer_data);
> +	bioscfg_drv.integer_data = NULL;
> +}
