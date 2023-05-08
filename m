Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE66FB93B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjEHVQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjEHVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:16:29 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073B7D97;
        Mon,  8 May 2023 14:16:12 -0700 (PDT)
Date:   Mon, 8 May 2023 23:16:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683580570; bh=nRSswzxcJ00nBqEoOx4uAmkb59x6Es+YOwDU2aHVpE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDJ5wpUcB5L5jIB/fmp7F+alc0jF2iyFCw4wlW8jzGH1eikb5rJrwVLUREshbccan
         uW2ECw7jUXlX8fEd7t8Ul9QbOAupBIATgTu0/Hw6Ko3WxI4sKU2d06AmJ/BeG+lInj
         YMmBP1B6/oI5NCOLUUkwqCVBMNcxwUq4Gc/1In6Y=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 04/13] HP BIOSCFG driver  - int-attributes
Message-ID: <3ea66370-6898-4d09-8268-9bd9440cd37c@t-8ch.de>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
 <20230505220043.39036-5-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505220043.39036-5-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 17:00:34-0500, Jorge Lopez wrote:

<snip>

> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++++++++++++
>  1 file changed, 448 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> new file mode 100644
> index 000000000000..1395043d5c9f
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> @@ -0,0 +1,448 @@
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
> +		return -EIO;
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
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	/* BIOS treats it as a read only attribute */
> +	if (integer_data->common.is_readonly)
> +		return -EIO;
> +
> +	ret = kstrtoint(buf, 10, &in_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (in_val < integer_data->lower_bound ||
> +	    in_val > integer_data->upper_bound)
> +		return -ERANGE;
> +
> +	/*
> +	 * set pending reboot flag depending on
> +	 * "RequiresPhysicalPresence" value
> +	 */
> +	if (integer_data->common.requires_physical_presence)
> +		set_reboot_and_signal_event();
> +	return 0;
> +}
> +
> +static void update_integer_value(int instance_id, char *attr_value)
> +{
> +	int in_val;
> +	int ret;
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	ret = kstrtoint(attr_value, 10, &in_val);
> +	if (ret == 0)
> +		integer_data->current_value = in_val;
> +	else
> +		pr_warn("Invalid integer value found: %s\n", attr_value);
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
> +ATTRIBUTE_N_PROPERTY_SHOW(scalar_increment, integer);
> +static struct kobj_attribute integer_scalar_increment =
> +	__ATTR_RO(scalar_increment);
> +
> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sysfs_emit(buf, "integer\n");
> +}
> +
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
> +	&integer_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group integer_attr_group = {
> +	.attrs = integer_attrs,
> +};
> +
> +int alloc_integer_data(void)
> +{
> +	bioscfg_drv.integer_instances_count = get_instance_count(HP_WMI_BIOS_INTEGER_GUID);
> +	bioscfg_drv.integer_data = kcalloc(bioscfg_drv.integer_instances_count,
> +					   sizeof(struct integer_data), GFP_KERNEL);
> +
> +	if (!bioscfg_drv.integer_data) {
> +		bioscfg_drv.integer_instances_count = 0;
> +		return -ENOMEM;
> +	}
> +	return 0;
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
> +	[INT_SCALAR_INCREMENT] = ACPI_TYPE_INTEGER,
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
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	integer_data->attr_name_kobj = attr_name_kobj;
> +	populate_integer_elements_from_package(integer_obj,
> +					       integer_obj->package.count,
> +					       instance_id);
> +	update_attribute_permissions(integer_data->common.is_readonly,
> +				     &integer_current_val);
> +	friendly_user_name_update(integer_data->common.path,
> +				  attr_name_kobj->name,
> +				  integer_data->common.display_name,
> +				  sizeof(integer_data->common.display_name));
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +int populate_integer_elements_from_package(union acpi_object *integer_obj,
> +					   int integer_obj_count,
> +					   int instance_id)
> +{
> +	char *str_value = NULL;
> +	int value_len;
> +	int ret;
> +	u32 int_value;
> +	int elem;
> +	int reqs;
> +	int eloc;
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	if (!integer_obj)
> +		return -EINVAL;
> +
> +	strscpy(integer_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(integer_data->common.display_name_language_code));
> +
> +	for (elem = 1, eloc = 1; elem < integer_obj_count; elem++, eloc++) {
> +		/* ONLY look at the first INTEGER_ELEM_CNT elements */
> +		if (eloc == INT_ELEM_CNT)
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

Instead of the loop pattern can this not use the same pattern as 
populate_integer_elements_from_buffer()?

(Same for all attribute types)

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
> +			integer_data->current_value = int_value;
> +			break;
> +		case PATH:
> +			strscpy(integer_data->common.path, str_value,
> +				sizeof(integer_data->common.path));
> +			break;
> +		case IS_READONLY:
> +			integer_data->common.is_readonly = int_value;
> +			break;
> +		case DISPLAY_IN_UI:
> +			integer_data->common.display_in_ui = int_value;
> +			break;
> +		case REQUIRES_PHYSICAL_PRESENCE:
> +			integer_data->common.requires_physical_presence = int_value;
> +			break;
> +		case SEQUENCE:
> +			integer_data->common.sequence = int_value;
> +			break;
> +		case PREREQUISITES_SIZE:
> +			if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
> +				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +			/*
> +			 * This HACK is needed to keep the expected
> +			 * element list pointing to the right obj[elem].type
> +			 * when the size is zero.  PREREQUISITES
> +			 * object is omitted by BIOS when the size is
> +			 * zero.
> +			 */
> +			if (integer_data->common.prerequisites_size == 0)
> +				eloc++;
> +			break;
> +		case PREREQUISITES:
> +			for (reqs = 0;
> +			     reqs < integer_data->common.prerequisites_size &&
> +			     reqs < MAX_PREREQUISITES_SIZE;
> +			     reqs++) {
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
> +				strscpy(integer_data->common.prerequisites[reqs],
> +					str_value,
> +					sizeof(integer_data->common.prerequisites[reqs]));
> +				kfree(str_value);
> +			}
> +			break;
> +
> +		case SECURITY_LEVEL:
> +			integer_data->common.security_level = int_value;
> +			break;
> +		case INT_LOWER_BOUND:
> +			integer_data->lower_bound = int_value;
> +			break;
> +		case INT_UPPER_BOUND:
> +			integer_data->upper_bound = int_value;
> +			break;
> +		case INT_SCALAR_INCREMENT:
> +			integer_data->scalar_increment = int_value;
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
> +/*
> + * populate_integer_buffer_data() -
> + * Populate all properties of an instance under integer attribute
> + *
> + * @buffer_ptr: Buffer pointer
> + * @buffer_size: Buffer size
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + */

Needs /** to be proper kdoc.

> +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int instance_id,
> +				 struct kobject *attr_name_kobj)
> +{
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	integer_data->attr_name_kobj = attr_name_kobj;
> +
> +	/* Populate integer elements */
> +	populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
> +					      instance_id);
> +	update_attribute_permissions(integer_data->common.is_readonly,
> +				     &integer_current_val);
> +	friendly_user_name_update(integer_data->common.path,
> +				  attr_name_kobj->name,
> +				  integer_data->common.display_name,
> +				  sizeof(integer_data->common.display_name));
> +
> +	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +}
> +
> +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_size,
> +					  int instance_id)
> +{
> +	char *dst = NULL;
> +	int reqs;
> +	int ret;
> +	int dst_size = *buffer_size / sizeof(u16);
> +	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
> +
> +	dst = kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> +	if (!dst)
> +		return -ENOMEM;
> +
> +	strscpy(integer_data->common.display_name_language_code,
> +		LANG_CODE_STR,
> +		sizeof(integer_data->common.display_name_language_code));
> +	/*
> +	 * Only data relevant to this driver and its functionality is
> +	 * read. BIOS defines the order in which each * element is
> +	 * read. Element 0 data is not relevant to this
> +	 * driver hence it is ignored.  For clarity, all element names
> +	 * (DISPLAY_IN_UI) which defines the order in which is read
> +	 * and the name matches the variable where the data is stored.
> +	 */
> +
> +	// VALUE:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> +	ret = kstrtoint(dst, 10, &integer_data->current_value);
> +	if (ret)
> +		pr_warn("Unable to convert string to integer: %s\n", dst);

Maybe set current_value to a well-defined value when this error happens.

> +
> +	// PATH:
> +	get_string_from_buffer(&buffer_ptr, buffer_size, integer_data->common.path,
> +			       sizeof(integer_data->common.path));

get_string_from_buffer() returns an int but the return value is never
used.
Also it's not clear where the validation that the buffer is not read out
of bounds happens. Making this more explicit would be nice.

> +
> +	// IS_READONLY:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.is_readonly);
> +
> +	//DISPLAY_IN_UI:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.display_in_ui);
> +
> +	// REQUIRES_PHYSICAL_PRESENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.requires_physical_presence);
> +
> +	// SEQUENCE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.sequence);
> +
> +	// PREREQUISITES_SIZE:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.prerequisites_size);

If the common values are always in the same order you could refactor it
into a function.

> +
> +	if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE) {
> +		/* Report a message and limit prerequisite size to maximum value */
> +		pr_warn("Integer Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
> +		integer_data->common.prerequisites_size = MAX_PREREQUISITES_SIZE;
> +	}
> +
> +	// PREREQUISITES:
> +	for (reqs = 0;
> +	     reqs < integer_data->common.prerequisites_size && reqs < MAX_PREREQUISITES_SIZE;
> +	     reqs++)
> +		get_string_from_buffer(&buffer_ptr, buffer_size,
> +				       integer_data->common.prerequisites[reqs],
> +				       sizeof(integer_data->common.prerequisites[reqs]));

How is this supposed to work?

Presumably if the firmware returns too many prerequisites the ignored
prerequisites can't just be interpreted as security_level, lower_bound,
upper_bound.

In general it may be useful to be able mark an attribute as invalid and
probihibit interaction from userspace.
Then if the firmware returns bogus data we can just enable that invalid
state and don't have to worry about things like that.

> +
> +	// SECURITY_LEVEL:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->common.security_level);
> +
> +	// INT_LOWER_BOUND:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->lower_bound);
> +
> +	// INT_UPPER_BOUND:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->upper_bound);
> +
> +	// INT_SCALAR_INCREMENT:
> +	get_integer_from_buffer(&buffer_ptr, buffer_size,
> +				&integer_data->scalar_increment);
> +
> +	kfree(dst);

dst can be freed much earlier.

> +	return 0;
> +}

The new logic looks much nicer!
Now let's see if it can be used for reading from a package.

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
> +	for (instance_id = 0; instance_id < bioscfg_drv.integer_instances_count;
> +	     instance_id++) {
> +		struct kobject *attr_name_kobj =
> +			bioscfg_drv.integer_data[instance_id].attr_name_kobj;
> +
> +		if (attr_name_kobj)
> +			sysfs_remove_group(attr_name_kobj, &integer_attr_group);
> +	}
> +	bioscfg_drv.integer_instances_count = 0;
> +
> +	kfree(bioscfg_drv.integer_data);
> +	bioscfg_drv.integer_data = NULL;
> +}
> -- 
> 2.34.1
> 
