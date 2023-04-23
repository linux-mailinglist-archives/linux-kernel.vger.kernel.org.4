Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFE06EBD8A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDWG4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 02:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjDWG4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 02:56:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5CB2D4D;
        Sat, 22 Apr 2023 23:55:28 -0700 (PDT)
Date:   Sun, 23 Apr 2023 08:54:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682232926; bh=ihWx9QjcrVox079RqfKi29+3J4wzOG6/rukF0kV2WSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h98bv81bHfN3RYXgtd6e2CPLNLZMiG2mGVjMalq806IZ5dV8diO7YvAuRb3GzPyzJ
         WMRt/9Pdo7QQE8czkVl++Wu8t1y8b0NSmRlZWfOuzF7g2kJ7DxsvNXNnD0fGbNvN9J
         4obTw9EU9mLz9c3G1/x/yDKXrdJuByq0CvJaCRbw=
From:   thomas@t-8ch.de
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 05/14] HP BIOSCFG driver  - ordered-attributes
Message-ID: <24fb56f9-49c6-432d-8c2f-17df7f7e37b2@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-6-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-6-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 11:54:45-0500, Jorge Lopez wrote:
>  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++++++++++
>  1 file changed, 563 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> new file mode 100644
> index 000000000000..5e5d540f728d
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> @@ -0,0 +1,563 @@
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
> +
> +	int instance_id = get_ordered_list_instance_id(kobj);
> +
> +	if (instance_id < 0)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "%s\n",
> +			 bioscfg_drv.ordered_list_data[instance_id].current_value);
> +}
> +
> +/*
> + * validate_ordered_list_value -
> + * Validate input of current_value against possible values

Does the firmware not also validate this?

If so it may be easier to just let it do so and remove the validations
from the driver.

> + *
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + */
> +static int validate_ordered_list_values(int instance_id, const char *buf)
> +{
> +	int ret = 0;
> +	int found = 0;
> +	char *new_values = NULL;
> +	char *value;
> +	int elem;
> +	int elem_found = 0;
> +
> +	/* Is it a read only attribute */
> +	if (bioscfg_drv.ordered_list_data[instance_id].common.is_readonly)
> +		return -EIO;
> +
> +	new_values = kstrdup(buf, GFP_KERNEL);
> +
> +	/*
> +	 * Changes to ordered list values require checking that new
> +	 * values are found in the list of elements.
> +	 */
> +	elem_found = 0;
> +	while (elem_found < bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> +
> +		value = strsep(&new_values, ",");

The docs say the separator is semicolon.

> +		if (value != NULL) {
> +			if (!*value)
> +				continue;
> +			elem_found++;
> +		}
> +
> +		found = 0;
> +		for (elem = 0; elem < bioscfg_drv.ordered_list_data[instance_id].elements_size; elem++) {
> +			if (!strcasecmp(bioscfg_drv.ordered_list_data[instance_id].elements[elem], value)) {

It's surprising that this is case-insensitive.

> +				found = 1;
> +				break;
> +			}
> +		}
> +
> +
> +		if (!found) {
> +			ret = -EINVAL;
> +			goto out_list_value;
> +		}
> +	}
> +
> +	if (elem_found == bioscfg_drv.ordered_list_data[instance_id].elements_size) {
> +		pr_warn("Number of new values is not equal to number of ordered list elements (%d)\n",
> +			bioscfg_drv.ordered_list_data[instance_id].elements_size);
> +		ret = -EINVAL;
> +		goto out_list_value;
> +	}
> +
> +out_list_value:
> +	kfree(new_values);
> +	return ret;
> +}

This algorithm does not seem to validate that different values are
provided.

So if "possible_values" is "foo,bar,baz" this function would accept
"foo,foo,foo".

> +
> +/*
> + * validate_ordered_input() -
> + * Validate input of current_value against possible values
> + *
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + */
> +static int validate_ordered_list_input(int instance_id, const char *buf)
> +{
> +	int ret = 0;
> +
> +	ret = validate_ordered_list_values(instance_id, buf);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * set pending reboot flag depending on
> +	 * "RequiresPhysicalPresence" value
> +	 */
> +	if (bioscfg_drv.ordered_list_data[instance_id].common.requires_physical_presence)
> +		bioscfg_drv.pending_reboot = true;
> +
> +	return ret;
> +}
> +
> +static void update_ordered_list_value(int instance_id, char *attr_value)
> +{
> +	strscpy(bioscfg_drv.ordered_list_data[instance_id].current_value,
> +		attr_value,
> +		sizeof(bioscfg_drv.ordered_list_data[instance_id].current_value));
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
> +
> +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, ordered_list);
> +static struct kobj_attribute  ordered_list_prerequisites_size_val =
> +	__ATTR_RO(prerequisites_size);
> +
> +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, ordered_list);
> +static struct kobj_attribute  ordered_list_prerequisites_val =
> +	__ATTR_RO(prerequisites);
> +
> +ATTRIBUTE_N_PROPERTY_SHOW(elements_size, ordered_list);
> +static struct kobj_attribute  ordered_list_elements_size_val =
> +	__ATTR_RO(elements_size);

"size" and "length" attributes are fairly useless to userspace.
They can't be trusted to provide information about another attribute as
the information can be out of date when the other attribute is read.

> +
> +ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list);
> +static struct kobj_attribute  ordered_list_elements_val =
> +	__ATTR_RO(elements);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "ordered-list\n");
> +}
> +static struct kobj_attribute ordered_list_type =
> +	__ATTR_RO(type);
> +
> +static struct attribute *ordered_list_attrs[] = {
> +	&ordered_list_display_langcode.attr,
> +	&ordered_list_display_name.attr,
> +	&ordered_list_current_val.attr,
> +	&ordered_list_prerequisites_size_val.attr,
> +	&ordered_list_prerequisites_val.attr,
> +	&ordered_list_elements_val.attr,
> +	&ordered_list_elements_size_val.attr,
> +	&ordered_list_type.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ordered_list_attr_group = {
> +	.attrs = ordered_list_attrs,
> +};
> +
> +int alloc_ordered_list_data(void)
> +{
> +	int ret = 0;
> +
> +	bioscfg_drv.ordered_list_instances_count =
> +		get_instance_count(HP_WMI_BIOS_ORDERED_LIST_GUID);
> +	bioscfg_drv.ordered_list_data = kcalloc(bioscfg_drv.ordered_list_instances_count,
> +						sizeof(struct ordered_list_data), GFP_KERNEL);
> +	if (!bioscfg_drv.ordered_list_data) {
> +		bioscfg_drv.ordered_list_instances_count = 0;
> +		ret = -ENOMEM;
> +	}
> +	return ret;
> +}
> +
> +/*
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
> +	bioscfg_drv.ordered_list_data[instance_id].attr_name_kobj = attr_name_kobj;
> +
> +	populate_ordered_list_elements_from_package(order_obj,
> +						    order_obj->package.count,
> +						    instance_id);
> +	update_attribute_permissions(bioscfg_drv.ordered_list_data[instance_id].common.is_readonly,
> +				     &ordered_list_current_val);
> +	friendly_user_name_update(bioscfg_drv.ordered_list_data[instance_id].common.path,
> +				  attr_name_kobj->name,
> +				  bioscfg_drv.ordered_list_data[instance_id].common.display_name,
> +				  sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name));
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
> +	[ORD_LIST_ELEMENTS] = ACPI_TYPE_STRING
> +};
> +
> +
> +int populate_ordered_list_elements_from_package(union acpi_object *order_obj,
> +						int order_obj_count,
> +						int instance_id)
> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret = 0;
> +	u32 size = 0;
> +	u32 int_value;
> +	int elem = 0;
> +	int reqs;
> +	int eloc;
> +	char *tmpstr = NULL;
> +	char *part_tmp = NULL;
> +	int tmp_len = 0;
> +	char *part = NULL;
> +
> +	if (!order_obj)
> +		return -EINVAL;
> +
> +	strscpy(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code));

This seems to be the same for every type. Can it not be moved into
common code?

> +
> +	for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
> +
> +		/* ONLY look at the first ORDERED_ELEM_CNT elements */
> +		if (eloc == ORDERED_ELEM_CNT)
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
> +			strscpy(bioscfg_drv.ordered_list_data[instance_id].current_value,
> +				str_value, sizeof(bioscfg_drv.ordered_list_data[instance_id].current_value));
> +			break;
> +		case PATH:
> +			strscpy(bioscfg_drv.ordered_list_data[instance_id].common.path, str_value,
> +				sizeof(bioscfg_drv.ordered_list_data[instance_id].common.path));
> +			break;
> +		case IS_READONLY:
> +			bioscfg_drv.ordered_list_data[instance_id].common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			bioscfg_drv.ordered_list_data[instance_id].common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			bioscfg_drv.ordered_list_data[instance_id].common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			bioscfg_drv.ordered_list_data[instance_id].common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			bioscfg_drv.ordered_list_data[instance_id].common.prerequisites_size = int_value;
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
> +			size = bioscfg_drv.ordered_list_data[instance_id].common.prerequisites_size;
> +
> +			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
> +				ret = convert_hexstr_to_str(order_obj[elem + reqs].string.pointer,
> +							    order_obj[elem + reqs].string.length,
> +							    &str_value, &value_len);
> +
> +				if (ret)
> +					continue;
> +
> +				strscpy(bioscfg_drv.ordered_list_data[instance_id].common.prerequisites[reqs],
> +					str_value,
> +					sizeof(bioscfg_drv.ordered_list_data[instance_id].common.prerequisites[reqs]));
> +
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			bioscfg_drv.ordered_list_data[instance_id].common.security_level = int_value;
> +			break;
> +
> +		case ORD_LIST_SIZE:
> +			bioscfg_drv.ordered_list_data[instance_id].elements_size = int_value;
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
> +			size = bioscfg_drv.ordered_list_data[instance_id].elements_size;
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
> +				strscpy(bioscfg_drv.ordered_list_data[instance_id].elements[0],
> +					tmpstr,
> +					sizeof(bioscfg_drv.ordered_list_data[instance_id].elements[0]));
> +
> +			for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
> +				strscpy(bioscfg_drv.ordered_list_data[instance_id].elements[elem],
> +					part,
> +					sizeof(bioscfg_drv.ordered_list_data[instance_id].elements[elem]));
> +				part = strsep(&part_tmp, ",");
> +			}
> +
> +			kfree(tmpstr);
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
> +	kfree(tmpstr);
> +	kfree(str_value);
> +	return 0;
> +}
> +
> +/*
> + * populate_ordered_list_data() - Populate all properties of an
> + * instance under ordered list attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + * @enum_property_count: Total properties count under ordered list type
> + */
> +int populate_ordered_list_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				      struct kobject *attr_name_kobj)
> +{
> +
> +	bioscfg_drv.ordered_list_data[instance_id].attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate ordered list elements */
> +	populate_ordered_list_elements_from_buffer(buffer_ptr, buffer_size,
> +						   instance_id);
> +	update_attribute_permissions(bioscfg_drv.ordered_list_data[instance_id].common.is_readonly,
> +				     &ordered_list_current_val);
> +	friendly_user_name_update(bioscfg_drv.ordered_list_data[instance_id].common.path,
> +				  attr_name_kobj->name,
> +				  bioscfg_drv.ordered_list_data[instance_id].common.display_name,
> +				  sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name));
> +
> +	return sysfs_create_group(attr_name_kobj, &ordered_list_attr_group);
> +}
> +
> +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					       int instance_id)
> +{
> +	int ret;
> +	char *dst = NULL;
> +	int elem;
> +	int reqs;
> +	int integer;
> +	int size = 0;
> +	int values;
> +	int dst_size = *buffer_size / sizeof(u16);
> +
> +	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> +	if (!dst)
> +		return -ENOMEM;
> +
> +	elem = 0;
> +	strscpy(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(bioscfg_drv.ordered_list_data[instance_id].common.display_name_language_code));
> +
> +	for (elem = 1; elem < 3; elem++) {
> +
> +		ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +		if (ret < 0)
> +			continue;
> +
> +		switch (elem) {
> +		case VALUE:
> +			strscpy(bioscfg_drv.ordered_list_data[instance_id].current_value,
> +				dst, sizeof(bioscfg_drv.ordered_list_data[instance_id].current_value));
> +			break;
> +		case PATH:
> +			strscpy(bioscfg_drv.ordered_list_data[instance_id].common.path, dst,
> +				sizeof(bioscfg_drv.ordered_list_data[instance_id].common.path));
> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Ordered list attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +	}
> +	for (elem = 3; elem < ORDERED_ELEM_CNT; elem++) {
> +
> +		if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
> +			ret = get_integer_from_buffer((int **)&buffer_ptr, buffer_size, (int *)&integer);
> +			if (ret < 0)
> +				continue;
> +		}
> +
> +		switch (elem) {
> +
> +		case IS_READONLY:
> +			bioscfg_drv.ordered_list_data[instance_id].common.is_readonly = integer;
> +			break;
> +		case DISPLAY_IN_UI:
> +			bioscfg_drv.ordered_list_data[instance_id].common.display_in_ui = integer;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			bioscfg_drv.ordered_list_data[instance_id].common.requires_physical_presence = integer;
> +			break;
> +		case SEQUENCE:
> +			bioscfg_drv.ordered_list_data[instance_id].common.sequence = integer;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			bioscfg_drv.ordered_list_data[instance_id].common.prerequisites_size = integer;
> +			if (integer > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +
> +			// PREREQUISITES:
> +			elem++;
> +			size = bioscfg_drv.ordered_list_data[instance_id].common.prerequisites_size;
> +			for (reqs = 0; reqs < size && reqs < MAX_PREREQUISITES_SIZE; reqs++) {
> +				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +				if (ret < 0)
> +					continue;
> +
> +				strscpy(bioscfg_drv.ordered_list_data[instance_id].common.prerequisites[reqs],
> +					dst,
> +					sizeof(bioscfg_drv.ordered_list_data[instance_id].common.prerequisites[reqs]));
> +			}
> +			break;
> +		case SECURITY_LEVEL:
> +			bioscfg_drv.ordered_list_data[instance_id].common.security_level = integer;
> +			break;
> +		case ORD_LIST_SIZE:
> +			bioscfg_drv.ordered_list_data[instance_id].elements_size = integer;
> +			if (integer > MAX_ELEMENTS_SIZE)
> +				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
> +
> +			// ORD_LIST_ELEMENTS:
> +			elem++;
> +			size = bioscfg_drv.ordered_list_data[instance_id].elements_size;
> +			for (values = 0; values < size && values < MAX_ELEMENTS_SIZE; values++) {
> +				ret = get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +				if (ret < 0)
> +					continue;
> +
> +				strscpy(bioscfg_drv.ordered_list_data[instance_id].elements[values],
> +					dst,
> +					sizeof(bioscfg_drv.ordered_list_data[instance_id].elements)[values]);
> +			}
> +			break;
> +		default:
> +			pr_warn("Invalid element: %d found in Ordered list attribute or data may be malformed\n", elem);
> +			break;
> +		}
> +	}
> +	kfree(dst);
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * exit_ordered_list_attributes() - Clear all attribute data
> + *
> + * Clears all data allocated for this group of attributes
> + */
> +void exit_ordered_list_attributes(void)
> +{
> +	int instance_id;
> +
> +	for (instance_id = 0; instance_id < bioscfg_drv.ordered_list_instances_count; instance_id++) {
> +		struct kobject *attr_name_kobj = bioscfg_drv.ordered_list_data[instance_id].attr_name_kobj;
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
