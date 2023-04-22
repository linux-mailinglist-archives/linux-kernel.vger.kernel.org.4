Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267C6EBB84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDVVaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 17:30:19 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1CA198B;
        Sat, 22 Apr 2023 14:30:17 -0700 (PDT)
Date:   Sat, 22 Apr 2023 23:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682199016; bh=Qsivdrn+zdbk94u0CzZNudhkc8unavr50+H31wid6NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojj/3OQ2ac/ECakOniw55i80vnaDMDyQIFpQ8xB9pS57VdMK9MUuEIQ8smEi/Qw/2
         FvOTKs7BoiUwzBwoxg9ZpbAPjap84+G1+bflG7uZnALH8jzThC3wdc2f9ugR2SGnJx
         wAqyVByFK+FR8LKeGMSU5hFAf9QI0fAkhmDdKd/k=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 02/14] HP BIOSCFG driver - biosattr-interface
Message-ID: <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-3-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-3-jorge.lopez2@hp.com>
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

checkpatch.pl finds some issues on your patches.
Please make sure checkpath.pl --strict is happy.

On 2023-04-20 11:54:42-0500, Jorge Lopez wrote:
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 307 ++++++++++++++++++
>  1 file changed, 307 insertions(+)
>  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> new file mode 100644
> index 000000000000..f09dd41867f7
> --- /dev/null
> +++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to methods under BIOS interface GUID
> + * for use with hp-bioscfg driver.
> + *
> + *  Copyright (c) 2022 Hewlett-Packard Inc.
> + */
> +
> +#include <linux/wmi.h>
> +#include "bioscfg.h"
> +
> +#define SET_DEFAULT_VALUES_METHOD_ID	0x02
> +#define SET_BIOS_DEFAULTS_METHOD_ID	0x03
> +#define SET_ATTRIBUTE_METHOD_ID		0x04

This could be an enum.

> +
> +/*
> + * set_attribute() - Update an attribute value
> + * @a_name: The attribute name
> + * @a_value: The attribute value
> + *
> + * Sets an attribute to new value
> + */
> +int hp_set_attribute(const char *a_name, const char *a_value)
> +{
> +	size_t security_area_size;
> +	size_t a_name_size, a_value_size;
> +	u16 *buffer = NULL;
> +	u16 *start = NULL;
> +	int  buffer_size;
> +	int ret = 0;
> +	int instance;
> +	char *auth_empty_value = "";
> +	char *auth_token_choice = NULL;

No need to initialize auth_token_choice and start.
Consider coalescing variable declaration to avoid wasting vertical
space.

> +
> +
> +	mutex_lock(&bioscfg_drv.mutex);
> +	if (!bioscfg_drv.bios_attr_wdev) {
> +		ret = -ENODEV;
> +		goto out_set_attribute;
> +	}
> +
> +	instance = get_password_instance_for_type(SETUP_PASSWD);
> +	if (instance < 0) {
> +		ret = -EINVAL;
> +		goto out_set_attribute;
> +	}
> +
> +	if (strlen(bioscfg_drv.password_data[instance].current_password) == 0)
> +		strscpy(bioscfg_drv.password_data[instance].current_password,
> +			auth_empty_value,
> +			sizeof(bioscfg_drv.password_data[instance].current_password));

This essentially does

if (current_password[0] == '\0')
	current_password[0] = '\0';

... nothing.


In the driver there is a lot of dereferencing substructures of
bioscfg_drv going on. This makes the code harder to read.

> +
> +	/* Select which auth token to use; password or [auth token] */
> +
> +	if (bioscfg_drv.spm_data.auth_token != NULL)
> +		auth_token_choice = bioscfg_drv.spm_data.auth_token;
> +	else
> +		auth_token_choice = bioscfg_drv.password_data[instance].current_password;
> +
> +	a_name_size = bioscfg_calculate_string_buffer(a_name);
> +	a_value_size = bioscfg_calculate_string_buffer(a_value);
> +	security_area_size = calculate_security_buffer(auth_token_choice);
> +	buffer_size = a_name_size + a_value_size + security_area_size;
> +
> +	buffer = kmalloc(buffer_size + 1, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out_set_attribute;
> +	}
> +
> +	/* build variables to set */
> +	start = buffer;
> +	start = ascii_to_utf16_unicode(start, a_name);
> +	if (!start)
> +		goto out_set_attribute;

ret is 0 here. Is this success?

> +
> +	start = ascii_to_utf16_unicode(start, a_value);
> +	if (!start)
> +		goto out_set_attribute;

Same as above.

> +
> +	populate_security_buffer(start, auth_token_choice);
> +
> +	ret = hp_wmi_set_bios_setting(buffer, buffer_size);
> +
> +
> +out_set_attribute:
> +	kfree(buffer);
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return ret;
> +}
> +
> +/*
> + * hp_wmi_perform_query
> + *
> + * query:	The commandtype (enum hp_wmi_commandtype)
> + * write:	The command (enum hp_wmi_command)
> + * buffer:	Buffer used as input and/or output
> + * insize:	Size of input buffer
> + * outsize:	Size of output buffer
> + *
> + * returns zero on success
> + *         an HP WMI query specific error code (which is positive)
> + *         -EINVAL if the query was not successful at all
> + *         -EINVAL if the output buffer size exceeds buffersize

How is the caller supposed to distinguish those?

> + *
> + * Note: The buffersize must at least be the maximum of the input and output
> + *       size. E.g. Battery info query is defined to have 1 byte input
> + *       and 128 byte output. The caller would do:
> + *       buffer = kzalloc(128, GFP_KERNEL);
> + *       ret = hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ,
> + *				    buffer, 1, 128)
> + */
> +int hp_wmi_perform_query(int query, enum hp_wmi_command command, void *buffer,
> +			 int insize, int outsize)

Can insize and outsize ever be negative?
Maybe use u32 or size_t.

> +{
> +	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct bios_return *bios_return;
> +	union acpi_object *obj = NULL;
> +	struct bios_args *args = NULL;
> +	int mid, actual_outsize;
> +	size_t bios_args_size;
> +	int ret;
> +
> +	mid = encode_outsize_for_pvsz(outsize);
> +	if (WARN_ON(mid < 0))
> +		return mid;
> +
> +	bios_args_size = struct_size(args, data, insize);
> +	args = kmalloc(bios_args_size, GFP_KERNEL);
> +	if (!args)
> +		return -ENOMEM;
> +
> +	input.length = bios_args_size;
> +	input.pointer = args;
> +
> +	args->signature = 0x55434553;

What does this number mean?

> +	args->command = command;
> +	args->commandtype = query;
> +	args->datasize = insize;
> +	memcpy(args->data, buffer, flex_array_size(args, data, insize));
> +
> +	ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);

The driver is mixing calls to the UUID based APIs and the wmi_device
ones.
wmi_devices is newer and preferred.

> +	bioscfg_wmi_error_and_message(ret);
> +
> +	if (ret)
> +		goto out_free;
> +
> +	obj = output.pointer;
> +	if (!obj) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +	if (query != HPWMI_SECUREPLATFORM_GET_STATE &&
> +	    command != HPWMI_SECUREPLATFORM)
> +		if (obj->type != ACPI_TYPE_BUFFER ||
> +		    obj->buffer.length < sizeof(*bios_return)) {
> +			pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
> +			ret = -EINVAL;
> +			goto out_free;
> +		}
> +
> +
> +	bios_return = (struct bios_return *)obj->buffer.pointer;

For query == HPWMI_SECUREPLATFORM_GET_STATE && command == HPWMI_SECUREPLATFORM
this is not guaranteed to be a buffer.

> +	ret = bios_return->return_code;
> +	bioscfg_wmi_error_and_message(ret);
> +
> +	if (ret) {
> +		if (ret != HPWMI_RET_UNKNOWN_COMMAND &&
> +		    ret != HPWMI_RET_UNKNOWN_CMDTYPE)
> +			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
> +		goto out_free;
> +	}
> +
> +	/* Ignore output data of zero size */
> +	if (!outsize)
> +		goto out_free;
> +
> +	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));

actual_outsize could be negative, which will underflow in the call to
memcpy().

> +	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
> +	memset(buffer + actual_outsize, 0, outsize - actual_outsize);

memcpy_and_pad()

> +
> +out_free:
> +	kfree(obj);
> +	kfree(args);
> +	return ret;
> +}
> +
> +static void *utf16_empty_string(u16 *p)
> +{
> +	*p++ = 2;
> +	*p++ = (u8)0x00;
> +	return p;
> +}
> +
> +/*
> + * ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
> + *
> + * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
> + * multi-byte language supported.
> + *
> + * @p:   Unicode buffer address
> + * @str: string to convert to unicode
> + *
> + * Returns a void pointer to the buffer containing unicode string

This returns a pointer to the end of the written string.

> + */
> +void *ascii_to_utf16_unicode(u16 *p, const u8 *str)
> +{
> +	int len = strlen(str);
> +	int ret;
> +
> +	/*
> +	 * Add null character when reading an empty string
> +	 * "02 00 00 00"
> +	 */
> +	if (len == 0)
> +		return utf16_empty_string(p);
> +
> +	/* Move pointer len * 2 number of bytes */
> +	*p++ = len * 2;
> +	ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, len);
> +	if (ret < 0) {
> +		dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n");
> +		goto ascii_to_utf16_unicode_out;
> +	}

What if ret != len ?

> +
> +	if ((ret * sizeof(u16)) > U16_MAX) {
> +		dev_err(bioscfg_drv.class_dev, "Error string too long\n");
> +		goto ascii_to_utf16_unicode_out;
> +	}
> +
> +ascii_to_utf16_unicode_out:
> +	p += len;

In cases of errors this will still point to the end of the data that
should have been written but was not actually written.
The caller has no way to recognize the error case.

> +	return p;
> +}
> +
> +/*

kernel-doc comments start with "/**". Note the two asterisks.

> + * hp_wmi_set_bios_setting - Set setting's value in BIOS
> + *
> + * @input_buffer: Input buffer address
> + * @input_size:   Input buffer size
> + *
> + * Returns: Count of unicode characters written to BIOS if successful, otherwise
> + *		-ENOMEM unable to allocate memory
> + *		-EINVAL buffer not allocated or too small
> + */
> +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size)
> +{
> +	union acpi_object *obj;
> +	struct acpi_buffer input = {input_size, input_buffer};
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int ret = 0;

No need to initialize "ret".

> +
> +	ret = wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &input, &output);
> +
> +	obj = output.pointer;
> +	if (!obj)
> +		return -EINVAL;

This skips the bioscfg_wmi_error_and_message call.

> +
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		ret = -EINVAL;
> +
> +	ret = obj->integer.value;

This overwrites the "ret = -EINVAL" from above.
Add an "else" branch.

> +	bioscfg_wmi_error_and_message(ret);
> +
> +	kfree(obj);
> +	return ret;
> +}
> +
> +static int bios_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +	bioscfg_drv.bios_attr_wdev = wdev;
> +	mutex_unlock(&bioscfg_drv.mutex);
> +	return 0;
> +}

Technically a WMI UUID can be present multiple times.
This would lead to the driver being loaded multiple times, each driver
clobbering the bios_attr_wdev of the other drivers.

Maybe check the pointer and return -EEXIST.

This applies to all subdrivers.

> +
> +static void bios_attr_set_interface_remove(struct wmi_device *wdev)
> +{
> +	mutex_lock(&bioscfg_drv.mutex);
> +	bioscfg_drv.bios_attr_wdev = NULL;
> +	mutex_unlock(&bioscfg_drv.mutex);
> +}
> +
> +static const struct wmi_device_id bios_attr_set_interface_id_table[] = {
> +	{ .guid_string = HP_WMI_BIOS_GUID},
> +	{ }
> +};
> +static struct wmi_driver bios_attr_set_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME
> +	},
> +	.probe = bios_attr_set_interface_probe,
> +	.remove = bios_attr_set_interface_remove,
> +	.id_table = bios_attr_set_interface_id_table

Put a comma here and above after DRIVER_NAME to reduce future diffs.

> +};
> +
> +int init_bios_attr_set_interface(void)
> +{
> +	return wmi_driver_register(&bios_attr_set_interface_driver);
> +}
> +
> +void exit_bios_attr_set_interface(void)
> +{
> +	wmi_driver_unregister(&bios_attr_set_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, bios_attr_set_interface_id_table);
