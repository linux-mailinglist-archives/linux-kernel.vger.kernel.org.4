Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCEE6FB9F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEHVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjEHVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:36:31 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00624527F;
        Mon,  8 May 2023 14:35:53 -0700 (PDT)
Date:   Mon, 8 May 2023 23:35:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683581752; bh=kPdB5N4u0b1Y5tfke6nehaQUQ9i4MgQdHJfRtnrj3I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9fEW1uzLp8I3dYQgZfAysJGgj7QTaQAbVdOfn1x7FDr4Ujy7tRmAIlwoXtAk8ykL
         2u8lG58Pd2EA/kYTScqvuoOo4A2bjTQrqMZozbu3NPhRENBlWtk8EJtucCQDoE3FvM
         6Hv5n8s9ZnBRmo0fxhWNSJEAqj5rhPlQovNQlKB8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 05/13] HP BIOSCFG driver  - ordered-attributes
Message-ID: <41331cf6-cd60-43e1-b53a-8f74a46a8d28@t-8ch.de>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
 <20230505220043.39036-6-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505220043.39036-6-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 17:00:35-0500, Jorge Lopez wrote:

<snip>

> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++++++++++++
>  1 file changed, 443 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c

Should be named order-list-attributes.

> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> new file mode 100644
> index 000000000000..1d06fbefceca
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> @@ -0,0 +1,443 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to ordered list type attributes under
> + * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 HP Development Company, L.P.
> + */
> +
> +#include "bioscfg.h"
> +
> +GET_INSTANCE_ID(ordered_list);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id = get_ordered_list_instance_id(kobj);
> +
> +	if (instance_id < 0)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "%s\n",
> +			 bioscfg_drv.ordered_list_data[instance_id].current_value);
> +}
> +
> +/**
> + * validate_ordered_list_input() -
> + * Validate input of current_value against possible values
> + *
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + */
> +static int validate_ordered_list_input(int instance_id, const char *buf)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	if (ordered_list_data->common.requires_physical_presence)
> +		set_reboot_and_signal_event();

I think the block above can actually be pulled up into
ATTRIBUTE_PROPERTY_STORE() and removed from all the attributes.

> +
> +	return 0;
> +}
> +
> +static void update_ordered_list_value(int instance_id, char *attr_value)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	strscpy(ordered_list_data->current_value,
> +		attr_value,
> +		sizeof(ordered_list_data->current_value));
> +}
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, ordered_list);
> +static struct kobj_attribute ordered_list_display_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, ordered_list);
> +static struct kobj_attribute ordered_list_display_name =
> +	__ATTR_RO(display_name);
> +
> +ATTRIBUTE_PROPERTY_STORE(current_value, ordered_list);
> +static struct kobj_attribute ordered_list_current_val =
> +	__ATTR_RW_MODE(current_value, 0644);
> +
> +ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list, COMMA_SEP);
> +static struct kobj_attribute  ordered_list_elements_val =
> +	__ATTR_RO(elements);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "ordered-list\n");
> +}
> +
> +static struct kobj_attribute ordered_list_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *ordered_list_attrs[] = {
> +	&ordered_list_display_langcode.attr,
> +	&ordered_list_display_name.attr,
> +	&ordered_list_current_val.attr,
> +	&ordered_list_elements_val.attr,
> +	&ordered_list_type.attr,
> +	NULL,

No comma.

> +};
> +
> +static const struct attribute_group ordered_list_attr_group = {
> +	.attrs = ordered_list_attrs,
> +};
> +
> +int alloc_ordered_list_data(void)
> +{
> +	bioscfg_drv.ordered_list_instances_count =
> +		get_instance_count(HP_WMI_BIOS_ORDERED_LIST_GUID);
> +	bioscfg_drv.ordered_list_data = kcalloc(bioscfg_drv.ordered_list_instances_count,
> +						sizeof(struct ordered_list_data), GFP_KERNEL);
> +	if (!bioscfg_drv.ordered_list_data) {
> +		bioscfg_drv.ordered_list_instances_count = 0;
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * populate_ordered_list_package_data() -
> + * Populate all properties of an instance under ordered_list attribute
> + *
> + * @order_obj: ACPI object with ordered_list data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_ordered_list_package_data(union acpi_object *order_obj, int instance_id,
> +				       struct kobject *attr_name_kobj)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	ordered_list_data->attr_name_kobj = attr_name_kobj;
> +
> +	populate_ordered_list_elements_from_package(order_obj,
> +						    order_obj->package.count,
> +						    instance_id);
> +	update_attribute_permissions(ordered_list_data->common.is_readonly,
> +				     &ordered_list_current_val);
> +	friendly_user_name_update(ordered_list_data->common.path,
> +				  attr_name_kobj->name,
> +				  ordered_list_data->common.display_name,
> +				  sizeof(ordered_list_data->common.display_name));
> +	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
> +}
> +
> +/* Expected Values types associated with each element */
> +static const acpi_object_type expected_order_types[] = {
> +	[NAME]	= ACPI_TYPE_STRING,
> +	[VALUE] = ACPI_TYPE_STRING,
> +	[PATH] = ACPI_TYPE_STRING,
> +	[IS_READONLY] = ACPI_TYPE_INTEGER,
> +	[DISPLAY_IN_UI] = ACPI_TYPE_INTEGER,
> +	[REQUIRES_PHYSICAL_PRESENCE] = ACPI_TYPE_INTEGER,
> +	[SEQUENCE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES_SIZE] = ACPI_TYPE_INTEGER,
> +	[PREREQUISITES] = ACPI_TYPE_STRING,
> +	[SECURITY_LEVEL] = ACPI_TYPE_INTEGER,
> +	[ORD_LIST_SIZE] = ACPI_TYPE_INTEGER,
> +	[ORD_LIST_ELEMENTS] = ACPI_TYPE_STRING,
> +};
> +
> +int populate_ordered_list_elements_from_package(union acpi_object *order_obj,
> +						int order_obj_count,
> +						int instance_id)

Can be static. Same for the other attributes.

> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret;
> +	u32 size;
> +	u32 int_value;
> +	int elem;
> +	int reqs;
> +	int eloc;
> +	char *tmpstr = NULL;
> +	char *part_tmp = NULL;
> +	int tmp_len = 0;
> +	char *part = NULL;
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	if (!order_obj)
> +		return -EINVAL;
> +
> +	strscpy(ordered_list_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(ordered_list_data->common.display_name_language_code));
> +
> +	for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
> +		/* ONLY look at the first ORDERED_ELEM_CNT elements */
> +		if (eloc == ORD_ELEM_CNT)
> +			goto exit_list_package;
> +
> +		switch (order_obj[elem].type) {
> +		case ACPI_TYPE_STRING:
> +
> +			if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
> +				ret = convert_hexstr_to_str(order_obj[elem].string.pointer,
> +							    order_obj[elem].string.length,
> +							    &str_value, &value_len);
> +				if (ret)
> +					continue;
> +			}
> +			break;
> +		case ACPI_TYPE_INTEGER:
> +			int_value = (u32)order_obj[elem].integer.value;
> +			break;
> +		default:
> +			pr_warn("Unsupported object type [%d]\n", order_obj[elem].type);
> +			continue;
> +		}
> +
> +		/* Check that both expected and read object type match */
> +		if (expected_order_types[eloc] != order_obj[elem].type) {
> +			pr_err("Error expected type %d for elem  %d, but got type %d instead\n",
> +			       expected_order_types[eloc], elem, order_obj[elem].type);
> +			return -EIO;
> +		}
> +
> +		/* Assign appropriate element value to corresponding field*/
> +		switch (eloc) {
> +		case VALUE:
> +			strscpy(ordered_list_data->current_value,
> +				str_value, sizeof(ordered_list_data->current_value));
> +			break;
> +		case PATH:
> +			strscpy(ordered_list_data->common.path, str_value,
> +				sizeof(ordered_list_data->common.path));
> +			break;
> +		case IS_READONLY:
> +			ordered_list_data->common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			ordered_list_data->common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			ordered_list_data->common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			ordered_list_data->common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			ordered_list_data->common.prerequisites_size = int_value;
> +			if (int_value > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +
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
> +			size = ordered_list_data->common.prerequisites_size;
> +
> +			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
> +				ret = convert_hexstr_to_str(order_obj[elem + reqs].string.pointer,
> +							    order_obj[elem + reqs].string.length,
> +							    &str_value, &value_len);
> +
> +				if (ret)
> +					continue;
> +
> +				strscpy(ordered_list_data->common.prerequisites[reqs],
> +					str_value,
> +					sizeof(ordered_list_data->common.prerequisites[reqs]));
> +
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			ordered_list_data->common.security_level = int_value;
> +			break;
> +
> +		case ORD_LIST_SIZE:
> +			ordered_list_data->elements_size = int_value;
> +			if (int_value > MAX_ELEMENTS_SIZE)
> +				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  ORD_LIST_ELEMENTS
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (int_value == 0)
> +				eloc++;
> +			break;
> +		case ORD_LIST_ELEMENTS:
> +			size = ordered_list_data->elements_size;
> +
> +			/*
> +			 * Ordered list data is stored in hex and comma separated format
> +			 * Convert the data and split it to show each element
> +			 */
> +			ret = convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
> +			if (ret)
> +				goto exit_list_package;
> +
> +			part_tmp = tmpstr;
> +			part = strsep(&part_tmp, ",");
> +			if (!part)
> +				strscpy(ordered_list_data->elements[0],
> +					tmpstr,
> +					sizeof(ordered_list_data->elements[0]));
> +
> +			for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
> +				strscpy(ordered_list_data->elements[elem],
> +					part,
> +					sizeof(ordered_list_data->elements[elem]));
> +				part = strsep(&part_tmp, ",");
> +			}
> +
> +			kfree(tmpstr);

This will be freed below anyways.

> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Ordered_List attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +		kfree(tmpstr);
> +		kfree(str_value);
> +	}
> +
> +exit_list_package:

No need for function name in jump label.

> +	kfree(tmpstr);
> +	kfree(str_value);
> +	return 0;
> +}
> +
> +/**
> + * populate_ordered_list_buffer_data() - Populate all properties of an
> + * instance under ordered list attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */
> +int populate_ordered_list_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				      struct kobject *attr_name_kobj)
> +{
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	ordered_list_data->attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate ordered list elements */
> +	populate_ordered_list_elements_from_buffer(buffer_ptr, buffer_size,
> +						   instance_id);
> +	update_attribute_permissions(ordered_list_data->common.is_readonly,
> +				     &ordered_list_current_val);
> +	friendly_user_name_update(ordered_list_data->common.path,
> +				  attr_name_kobj->name,
> +				  ordered_list_data->common.display_name,
> +				  sizeof(ordered_list_data->common.display_name));
> +
> +	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
> +}
> +
> +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					       int instance_id)

Can be static. Same for the other attributes.

> +{
> +	int reqs;
> +	int values;
> +	struct ordered_list_data *ordered_list_data = &bioscfg_drv.ordered_list_data[instance_id];
> +
> +	strscpy(ordered_list_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(ordered_list_data->common.display_name_language_code));
> +
> +	// VALUE:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_data->current_value,
> +			       sizeof(ordered_list_data->current_value));
> +
> +	// PATH:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_data->common.path,
> +			       sizeof(ordered_list_data->common.path));
> +
> +	// IS_READONLY:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.is_readonly);
> +
> +	//DISPLAY_IN_UI:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.display_in_ui);
> +
> +	// REQUIRES_PHYSICAL_PRESENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.requires_physical_presence);
> +
> +	// SEQUENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.sequence);
> +
> +	// PREREQUISITES_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.prerequisites_size);
> +
> +	if (ordered_list_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
> +		/* Report a message and limit prerequisite size to maximum value */
> +		pr_warn("String Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		ordered_list_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
> +	}
> +
> +	// PREREQUISITES:
> +	for (reqs = 0;
> +	     reqs < ordered_list_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;
> +	     reqs++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       ordered_list_data->common.prerequisites[reqs],
> +				       sizeof(ordered_list_data->common.prerequisites[reqs]));
> +
> +	// SECURITY_LEVEL:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->common.security_level);
> +
> +	// ORD_LIST_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&ordered_list_data->elements_size);
> +
> +	if (ordered_list_data->elements_size > MAX_ELEMENTS_SIZE) {
> +		/* Report a message and limit elements size to maximum value */
> +		pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		ordered_list_data->elements_size = MAX_ELEMENTS_SIZE;
> +	}
> +
> +	// ORD_LIST_ELEMENTS:
> +	for (values = 0; values < ordered_list_data->elements_size && values < MAX_ELEMENTS_SIZE;

values < min(ordered_list_data->elements_size, MAX_ELEMENTS_SIZE)

Also elements_size can actually never be > MAX_ELEMENTS_SIZE here.
Same for PREREQUISITES.
But as discussed before this limiting to a max amount of elements is
invalid, as following data will be misinterpreted.

> +	     values++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       ordered_list_data->elements[values],
> +				       sizeof(ordered_list_data->elements[values]));
> +
> +	return 0;
> +}
> +
> +/**
> + * exit_ordered_list_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + */
> +void exit_ordered_list_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < bioscfg_drv.ordered_list_instances_count;
> +	     instance_id++) {
> +		struct kobject *attr_name_kobj =
> +			bioscfg_drv.ordered_list_data[instance_id].attr_name_kobj;
> +
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj,
> +					   &ordered_list_attr_group);
> +	}
> +	bioscfg_drv.ordered_list_instances_count = 0;
> +
> +	kfree(bioscfg_drv.ordered_list_data);
> +	bioscfg_drv.ordered_list_data = NULL;
> +}
> -- 
> 2.34.1
> 
