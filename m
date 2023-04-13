Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B376E119B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDMQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDMQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745BAD1B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681401649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iANOiZlyBrGUp2a9xJkWV6qymcBHN7RUsXY3k69I3fg=;
        b=aXt9TcqODxrfbZm4HbIi2OiQIJw6IV3YyNoSeSaGI3L5KAuJXxY5MaEYMS6bE8jcXwi3J2
        wPThg7uxCxALtLznQzeG8Mhs/w3DY2lVVL3sUbj7q07OcGQ0E9vJ5IcqeYwtVueDNd1EFk
        CL+Q5CqMMOtug0Ih74r4eb8R2/Zs5j4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-SJv22lYFOqGq4KvU1tOIzQ-1; Thu, 13 Apr 2023 12:00:47 -0400
X-MC-Unique: SJv22lYFOqGq4KvU1tOIzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25A0E29A9D56;
        Thu, 13 Apr 2023 16:00:37 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3C44BC88;
        Thu, 13 Apr 2023 16:00:35 +0000 (UTC)
Date:   Thu, 13 Apr 2023 18:00:33 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-stadiaff: add support for Stadia force feedback
Message-ID: <20230413160033.buwdbysbbc2hgu6o@mail.corp.redhat.com>
References: <20230403103324.1746758-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403103324.1746758-1-fabiobaltieri@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Apr 03 2023, Fabio Baltieri wrote:
> Add a hid-stadiaff module to support rumble based force feedback on the
> Google Stadia controller. This works using the HID output endpoint
> exposed on both the USB and BLE interface.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
> 
> Hi, this adds rumble support to the stadia controller using the input
> interface. Up to now this has only been implemented at application level
> using hidraw:
> 
> https://source.chromium.org/chromium/chromium/src/+/main:device/gamepad/hid_haptic_gamepad.cc
> 
> Tested with fftest, works both over USB and BLE.
> 
>  drivers/hid/Kconfig        |   7 ++
>  drivers/hid/Makefile       |   1 +
>  drivers/hid/hid-ids.h      |   1 +
>  drivers/hid/hid-stadiaff.c | 132 +++++++++++++++++++++++++++++++++++++

Mind renaming this hid-google-stadiaff.c?
It's hard to know that stadia is from Google otherwise.

>  4 files changed, 141 insertions(+)
>  create mode 100644 drivers/hid/hid-stadiaff.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 82f64fb31fda..934f73e9b800 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1031,6 +1031,13 @@ config HID_SPEEDLINK
>  	help
>  	Support for Speedlink Vicious and Divine Cezanne mouse.
>  
> +config HID_STADIA_FF
> +	tristate "Google Stadia force feedback"
> +	select INPUT_FF_MEMLESS
> +	help
> +	Say Y here if you want to enable force feedback support for the Google
> +	Stadia controller.
> +
>  config HID_STEAM
>  	tristate "Steam Controller/Deck support"
>  	select POWER_SUPPLY
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 5d37cacbde33..1d900fa55890 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -120,6 +120,7 @@ obj-$(CONFIG_HID_SIGMAMICRO)	+= hid-sigmamicro.o
>  obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
>  obj-$(CONFIG_HID_SONY)		+= hid-sony.o
>  obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
> +obj-$(CONFIG_HID_STADIA_FF)	+= hid-stadiaff.o
>  obj-$(CONFIG_HID_STEAM)		+= hid-steam.o
>  obj-$(CONFIG_HID_STEELSERIES)	+= hid-steelseries.o
>  obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 63545cd307e5..cffd4ac609a0 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -525,6 +525,7 @@
>  #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
>  #define USB_DEVICE_ID_GOOGLE_DON	0x5050
>  #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
> +#define USB_DEVICE_ID_GOOGLE_STADIA	0x9400
>  
>  #define USB_VENDOR_ID_GOTOP		0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2		0x007f
> diff --git a/drivers/hid/hid-stadiaff.c b/drivers/hid/hid-stadiaff.c
> new file mode 100644
> index 000000000000..f974b9e24d46
> --- /dev/null
> +++ b/drivers/hid/hid-stadiaff.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Stadia controller rumble support.
> + *
> + * Copyright 2023 Google LLC
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define STADIA_FF_REPORT_ID 5
> +
> +struct stadiaff_device {
> +	struct hid_device *hid;
> +	struct hid_report *report;
> +	struct work_struct work;
> +};
> +
> +static void stadiaff_work(struct work_struct *work)
> +{
> +	struct stadiaff_device *stadiaff =
> +		container_of(work, struct stadiaff_device, work);
> +
> +	hid_hw_request(stadiaff->hid, stadiaff->report, HID_REQ_SET_REPORT);
> +}
> +
> +static int stadiaff_play(struct input_dev *dev, void *data,
> +			 struct ff_effect *effect)
> +{
> +	struct hid_device *hid = input_get_drvdata(dev);
> +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> +	struct hid_field *rumble_field = stadiaff->report->field[0];
> +
> +	rumble_field->value[0] = effect->u.rumble.strong_magnitude;
> +	rumble_field->value[1] = effect->u.rumble.weak_magnitude;
> +
> +	schedule_work(&stadiaff->work);

It seems weird that you don't have any locking in place here.
What if you are sending a report (in stadiaff_work) while having your
_play() function called at the same time?

> +
> +	return 0;
> +}
> +
> +static int stadiaff_init(struct hid_device *hid)
> +{
> +	struct stadiaff_device *stadiaff;
> +	struct hid_report *report;
> +	struct hid_input *hidinput;
> +	struct input_dev *dev;
> +	int error;
> +
> +	if (list_empty(&hid->inputs)) {
> +		hid_err(hid, "no inputs found\n");
> +		return -ENODEV;
> +	}
> +	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> +	dev = hidinput->input;
> +
> +	report = hid_validate_values(hid, HID_OUTPUT_REPORT,
> +				     STADIA_FF_REPORT_ID, 0, 2);
> +	if (!report)
> +		return -ENODEV;
> +
> +	stadiaff = devm_kzalloc(&hid->dev, sizeof(struct stadiaff_device),
> +				GFP_KERNEL);
> +	if (!stadiaff)
> +		return -ENOMEM;
> +
> +	hid_set_drvdata(hid, stadiaff);
> +
> +	input_set_capability(dev, EV_FF, FF_RUMBLE);
> +
> +	error = input_ff_create_memless(dev, NULL, stadiaff_play);
> +	if (error)
> +		return error;
> +
> +	stadiaff->hid = hid;
> +	stadiaff->report = report;
> +	INIT_WORK(&stadiaff->work, stadiaff_work);
> +
> +	hid_info(hid, "Force Feedback for Google Stadia controller\n");
> +
> +	return 0;
> +}
> +
> +static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	stadiaff_init(hdev);
> +
> +	return 0;
> +}
> +
> +static void stadia_remove(struct hid_device *hid)
> +{
> +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> +
> +	cancel_work_sync(&stadiaff->work);

What if you have a ff play event scheduled right here? Don't you need
some way of forcing the work to not be scheduled once again?

> +	hid_hw_stop(hid);
> +}
> +
> +static const struct hid_device_id stadia_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, stadia_devices);
> +
> +static struct hid_driver stadia_driver = {
> +	.name = "stadia",
> +	.id_table = stadia_devices,
> +	.probe = stadia_probe,
> +	.remove = stadia_remove,
> +};
> +module_hid_driver(stadia_driver);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.0.348.gf938b09366-goog
> 

Cheers,
Benjamin

