Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52ED750C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjGLPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjGLPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2501FFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689175749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuUiPIGyLSrSLpyitD17vd+F6K0st7cX8tN53Ic5Lk8=;
        b=Y36MQj6qk4mgR+HxxRY+FT9V85ToeV6KmEAq6s3mxrUb733nBkoOAjmyiMONvkfeBCullq
        1nsCMH1bypij7JvSFcMBGB5Cns/5lbs/Y5IEmFwHCeW28jr6VcjvcEz2CHHbUk3WYX5oiJ
        sKsb6rK0H2xN5DRBKXJoU8ctpRbw4A0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-rf58PY0NP6-NWQmy7JT85Q-1; Wed, 12 Jul 2023 11:29:08 -0400
X-MC-Unique: rf58PY0NP6-NWQmy7JT85Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb87c48aceso6622783e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175747; x=1691767747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuUiPIGyLSrSLpyitD17vd+F6K0st7cX8tN53Ic5Lk8=;
        b=gMasYe3cB/sZua8/gW+c9xnSu0EADF2CtAdW4RmRDKi2dJBwrIfe7sfY70h/tdiSqf
         MTKw3PJ8hh0TrMoAYm1t836VtOJdBbPjipl0/mf+U8aP66O9H/okC/zf3+umAxf5Lf2J
         25rBZGlk2eHr1D4cX7ljc+ETCnY+NvA1xl6v0m5HI1+s0X0N41HoKmj7z/YA3ujYW9ug
         xGaix8aG3un+FcxFf/TgfrAmvxScSKWYK6rpYiR2aGyE+Gq345vv0yceTeiTRv4ncP4n
         Njb9hYEo9KG32KyHKhn54sn53Wbhz2rQy7apBF8PGYNjwPZax+DcO0tVrPOyRjvDTc3h
         Allw==
X-Gm-Message-State: ABy/qLYApxTqQCkmaNch05EVeoYixJ5nu+rk1fyjnhwAa29nPOE/GdhK
        g6ID3cFtV2JuOgH/6vpfIpg8AXleqIVKOtDn3zIMaZidv9zc44VR6XV5TnHh4Fec37UPMpZEfXU
        yz5kswB1ISdZMHM66+gG3/GaW
X-Received: by 2002:a19:ca14:0:b0:4f7:4098:9905 with SMTP id a20-20020a19ca14000000b004f740989905mr13377847lfg.65.1689175746653;
        Wed, 12 Jul 2023 08:29:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFSKMko0tHy+9JHRCZ3yeRHBPUTrLtiE5hhRc3PU8LSUOyhU0DxMORZzUAUqKgIfivQKpDbrw==
X-Received: by 2002:a19:ca14:0:b0:4f7:4098:9905 with SMTP id a20-20020a19ca14000000b004f740989905mr13377835lfg.65.1689175746287;
        Wed, 12 Jul 2023 08:29:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l13-20020aa7c30d000000b0051a3334f873sm2882276edq.89.2023.07.12.08.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:29:05 -0700 (PDT)
Message-ID: <3edab51a-fc1a-3657-88b5-02ab86aeaffb@redhat.com>
Date:   Wed, 12 Jul 2023 17:29:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/x86: wmi: add Positivo WMI key driver
Content-Language: en-US, nl
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230628214015.68558-1-edson.drosdeck@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230628214015.68558-1-edson.drosdeck@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edson,

On 6/28/23 23:40, Edson Juliano Drosdeck wrote:
> Some function keys on the built in keyboard on Positivo's notebooks does
> not produce any key events when pressed in combination with the function
> key. Some of these keys do report that they are being pressed via WMI
> events.
> 
> This driver reports key events for Fn+F10,Fn+F11  and a custom key to
> launch a custom program.
> 
> Other WMI events that are reported by the hardware but not utilized by
> this driver are Caps Lock(which already work).
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thank you for your patch.

As Armin has mentioned, please change the driver to use the
WMI bus model and make it a wmi_driver.

A simple example (except for it using multiple WMI GUIDs) of such
a driver would be drivers/platform/x86/xiaomi-wmi.c

Please model your driver after this. This means you will be able
to drop the wmi_has_guid(POSITIVO_WMI_EVENT_GUID) from your
module_init() function (which will now become a probe function).

You do still need to keep the DMI check, since as Armin pointed
out the GUID unfortunately is not unique, but instead used the
Microsoft WMI docs example GUID.

Armin, we have seen this (using Microsoft WMI example GUID)
before and there is nothing we can do about this except add
a DMI check. This works for Windows because the WMI driver
for this for Windows is part of the factory image and presumably
has never been added to Windows Updates avoiding the GUID conflict.

Regards,

Hans




> ---
>  drivers/platform/x86/Kconfig        |  11 +++
>  drivers/platform/x86/Makefile       |   1 +
>  drivers/platform/x86/positivo-wmi.c | 136 ++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 drivers/platform/x86/positivo-wmi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 22052031c719..f3ad84479460 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -134,6 +134,17 @@ config YOGABOOK_WMI
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called lenovo-yogabook-wmi.
>  
> +config POSITIVO_WMI
> +	tristate "Positivo WMI key driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	select INPUT_SPARSEKMAP
> +	help
> +	  This driver provides support for Positvo WMI hotkeys.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called positivo-wmi.
> +
>  config ACERHDF
>  	tristate "Acer Aspire One temperature and fan driver"
>  	depends on ACPI && THERMAL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2cafe51ec4d8..5458bb9a56d3 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
>  obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
>  obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
>  obj-$(CONFIG_YOGABOOK_WMI)		+= lenovo-yogabook-wmi.o
> +obj-$(CONFIG_POSITIVO_WMI)		+= positivo-wmi.o
>  
>  # Acer
>  obj-$(CONFIG_ACERHDF)		+= acerhdf.o
> diff --git a/drivers/platform/x86/positivo-wmi.c b/drivers/platform/x86/positivo-wmi.c
> new file mode 100644
> index 000000000000..5fbb4cf42154
> --- /dev/null
> +++ b/drivers/platform/x86/positivo-wmi.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* WMI driver for Positivo Laptops
> + *
> + * Copyright (C) 2023 Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> + * 
> + * */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/dmi.h>
> +#include <linux/module.h>
> +
> +MODULE_AUTHOR("Edson Juliano Drosdeck");
> +MODULE_DESCRIPTION("Positivo WMI Hotkey Driver");
> +MODULE_LICENSE("GPL");
> +
> +#define POSITIVO_WMI_EVENT_GUID "ABBC0F72-8EA1-11D1-00A0-C90629100000"
> +
> +MODULE_ALIAS("wmi:"POSITIVO_WMI_EVENT_GUID);
> +
> +static const struct key_entry positivo_wmi_keymap[] = {
> +	{ KE_KEY, 0x1c, { KEY_PROG1} },
> +	{ KE_KEY, 0x36, { KEY_WLAN } },
> +	{ KE_KEY, 0x37, { KEY_BLUETOOTH } },
> +	{ KE_END, 0},
> +};
> +
> +static struct input_dev *positivo_wmi_input_dev;
> +
> +static void positivo_wmi_notify(u32 value, void *context)
> +{
> +	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	int eventcode;
> +	acpi_status status;
> +
> +	status = wmi_get_event_data(value, &response);
> +	if (status != AE_OK) {
> +		pr_err("bad event status 0x%x\n", status);
> +		return;
> +	}
> +
> +	obj = (union acpi_object *)response.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		eventcode = obj->integer.value;
> +
> +		if (!sparse_keymap_report_event(positivo_wmi_input_dev,
> +						eventcode, 1, true))
> +			pr_err("Unknown key %x pressed\n", eventcode);
> +	}
> +
> +	kfree(response.pointer);
> +}
> +
> +static int positivo_wmi_input_setup(void)
> +{
> +
> +	int err;
> +
> +	positivo_wmi_input_dev = input_allocate_device();
> +	if (!positivo_wmi_input_dev)
> +		return -ENOMEM;
> +
> +	positivo_wmi_input_dev->name = "Positivo laptop WMI hotkeys";
> +	positivo_wmi_input_dev->phys = "wmi/input0";
> +	positivo_wmi_input_dev->id.bustype = BUS_HOST;
> +
> +	err = sparse_keymap_setup(positivo_wmi_input_dev,
> +				  positivo_wmi_keymap, NULL);
> +	if (err)
> +		goto err_free_dev;
> +	
> +	err = input_register_device(positivo_wmi_input_dev);
> +	
> +	if (err){
> +		pr_info("Unable to register input device\n");
> +		goto err_free_dev;
> +	}
> +
> +	return 0;
> +
> +err_free_dev:
> +	input_free_device(positivo_wmi_input_dev);
> +	return err;
> +}
> +
> +static const struct dmi_system_id positivo_wmi_dmi_table[] __initconst = {
> +	{
> +		.ident = "Positivo laptop",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
> +		},
> +	},
> +	{}
> +};
> +
> +static int __init positivo_wmi_init(void)
> +{
> +	int err;
> +
> +	if (!wmi_has_guid(POSITIVO_WMI_EVENT_GUID) ||
> +	    !dmi_check_system(positivo_wmi_dmi_table))
> +		return -ENODEV;
> +
> +	err = positivo_wmi_input_setup();
> +	if (err)
> +		return err;
> +
> +	err = wmi_install_notify_handler(POSITIVO_WMI_EVENT_GUID,
> +					positivo_wmi_notify, NULL);
> +		if (ACPI_FAILURE(err)) {
> +			pr_err("Unable to setup WMI notify handler\n");
> +			goto err_free_input;
> +		}
> +
> +	return 0;
> +
> +err_free_input:
> +	input_unregister_device(positivo_wmi_input_dev);
> +	return err;
> +
> +}
> +
> +static void __exit positivo_wmi_exit(void)
> +{
> +       wmi_remove_notify_handler(POSITIVO_WMI_EVENT_GUID);
> +       input_free_device(positivo_wmi_input_dev);
> +}
> +
> +module_init(positivo_wmi_init);
> +module_exit(positivo_wmi_exit);

