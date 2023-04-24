Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC206ECAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjDXLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXLD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9526BD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682334161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR9m9WryA0+sdkXiJ2C0Z9LuHmnYeDZPpjV0NauN8dk=;
        b=CiYAuXa3Q60Pl6pgy6jNEnr9tRB3o4xIv6zDYBG3iiaO+N4JO2/sChEM0HsQe5hSgGwQ77
        xG16yl/OVntAIoU9kVG9CLSZ40xc7eC/KfkLkeImO9hj+Ps1+UPuK/Pu1x8HdM0jf8TJ4g
        L9+7BS3V39CeflSg4MdyHKf/RGfY/2w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-rOKtvxWJPPuKaNwCf2grdA-1; Mon, 24 Apr 2023 07:02:40 -0400
X-MC-Unique: rOKtvxWJPPuKaNwCf2grdA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-504ecbc85c2so4592005a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682334156; x=1684926156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zR9m9WryA0+sdkXiJ2C0Z9LuHmnYeDZPpjV0NauN8dk=;
        b=hWWL29l90w/BlsNKU8CNJqgQtksn+3eOUPFCpkqtqIRtTyOvd2alGX1+YNZgLNP0oJ
         AMeMeqZWvMbnj6qcnU/HCspVpce2AhKzmRMjE+nqsiQ7VHpCoO0E3rs4yMoOga4lw09s
         ufgtIeub6a9yDTTmZvTmuknlUTmDNMFbk+neoWNL/LOd6L6wVGaixtOur1Ze06AlKpfN
         3aWHnEfkiW2ToSlLd/fZeoypBMRye7vK2oZqrmpZ2dDr2snhSbn75fAQa4zEnGUOxD9K
         UXhXj79oap+089tPUodLK3nU8hrI0gOZVkn0a4e8/9WONIruf8Ojs4mfQHbIT56kfDCg
         v7zg==
X-Gm-Message-State: AAQBX9c+m5v4Fdc+SFHnQ9osrkfMNkHU0u0bJ3ctokpFWLRWjh/RL+OV
        ZvRsksomQtTFyNZZbpYV8dkxXQUFez9xF+kEk+L0v0kwN7fZGkhDiOyfP+Wkb7yTlClSvYUusGo
        kjz9gjSu3GZmkIVFOlaUnP5lX
X-Received: by 2002:a17:907:c06:b0:949:cb6a:b6f7 with SMTP id ga6-20020a1709070c0600b00949cb6ab6f7mr11863956ejc.56.1682334155597;
        Mon, 24 Apr 2023 04:02:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZorSVCRrRVA4Mgqe0kiB+xQrLDd6sxPTuIO9af40jxYwSk0530hdbZdwJdCm5Fd8/Ne/9zOA==
X-Received: by 2002:a17:907:c06:b0:949:cb6a:b6f7 with SMTP id ga6-20020a1709070c0600b00949cb6ab6f7mr11863909ejc.56.1682334155110;
        Mon, 24 Apr 2023 04:02:35 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906504e00b0094a90d3e385sm5352005ejk.30.2023.04.24.04.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 04:02:34 -0700 (PDT)
Message-ID: <47209259-9e57-f263-bf48-10f233c63b69@redhat.com>
Date:   Mon, 24 Apr 2023 13:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/5] Input: add driver for Focaltech FTS touchscreen
To:     Jeff LaBundy <jeff@labundy.com>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Maxime Ripard <mripard@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
 <20230415020222.216232-3-joelselvaraj.oss@gmail.com>
 <ZEXr1hC+Q5Bo/3Tc@nixie71>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZEXr1hC+Q5Bo/3Tc@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/24/23 04:39, Jeff LaBundy wrote:
> Hi Joel,
> 
> Great work so far! It's coming along nicely. Please find my latest
> feedback below.
> 
> On Fri, Apr 14, 2023 at 09:02:19PM -0500, Joel Selvaraj wrote:
>> The Focaltech FTS driver supports several variants of focaltech
>> touchscreens found in ~2018 era smartphones including variants found on
>> the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
>> This driver is loosely based on the original driver from Focaltech
>> but has been simplified and largely reworked.
>>
>> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

Sorry for jumping into this thread a bit late.

I've been reading the archived discussion, but AFAICT the following question is not answered there:

Why do a new driver at all ? I have a couple of devices (Nextbook Ares 8, Nextbook Ares 8A) with focaltech FT5416 touchscreens and they both work fine with the existing drivers/input/touchscreen/edt-ft5x06.c driver.

Is there any reason we need a whole new driver for the ft5452 instead of
using (with maybe some tweaks?) the existing edt-ft5x06 driver ?

Note that despite the name the edt-ft5x06 is a generic Focaltect touchscreen driver.

Regards,

Hans



>> ---
>>  MAINTAINERS                                   |   8 +
>>  drivers/input/touchscreen/Kconfig             |  12 +
>>  drivers/input/touchscreen/Makefile            |   1 +
>>  drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
>>  4 files changed, 453 insertions(+)
>>  create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7ec4ce64f66d..1a3ea61e1f52 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8028,6 +8028,14 @@ L:	linux-input@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/input/joystick/fsia6b.c
>>  
>> +FOCALTECH FTS5452 TOUCHSCREEN DRIVER
>> +M:	Joel Selvaraj <joelselvaraj.oss@gmail.com>
>> +M:	Caleb Connolly <caleb@connolly.tech>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
>> +F:	drivers/input/touchscreen/focaltech_fts5452.c
>> +
>>  FOCUSRITE SCARLETT GEN 2/3 MIXER DRIVER
>>  M:	Geoffrey D. Bennett <g@b4.vu>
>>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 1feecd7ed3cb..11af91504969 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -388,6 +388,18 @@ config TOUCHSCREEN_EXC3000
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called exc3000.
>>  
>> +config TOUCHSCREEN_FOCALTECH_FTS5452
>> +	tristate "Focaltech FTS Touchscreen"
>> +	depends on I2C
>> +	help
>> +	  Say Y here to enable support for I2C connected Focaltech FTS
>> +	  based touch panels, including the 5452 and 8917 panels.
> 
> This language is a bit misleading, as it seems to suggest three or more
> models are supported. It seems the title should simply be "FocalTech
> FTS5452 touchscreen controller" with the description as "...FocalTech
> FTS5452 and compatible touchscreen controllers."
> 
> As more are found to be compatible (e.g. FTS8917), the compatible strings
> can simply be appended.
> 
>> +
>> +	  If unsure, say N.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called focaltech_fts.
>> +
>>  config TOUCHSCREEN_FUJITSU
>>  	tristate "Fujitsu serial touchscreen"
>>  	select SERIO
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index 159cd5136fdb..47d78c9cff21 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>>  obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
>>  obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>> +obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FTS5452)	+= focaltech_fts5452.o
>>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>> diff --git a/drivers/input/touchscreen/focaltech_fts5452.c b/drivers/input/touchscreen/focaltech_fts5452.c
>> new file mode 100644
>> index 000000000000..abf8a2f271ca
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/focaltech_fts5452.c
>> @@ -0,0 +1,432 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * FocalTech touchscreen driver.
>> + *
>> + * Copyright (c) 2010-2017, FocalTech Systems, Ltd., all rights reserved.
>> + * Copyright (C) 2018 XiaoMi, Inc.
>> + * Copyright (c) 2021 Caleb Connolly <caleb@connolly.tech>
>> + * Copyright (c) 2023 Joel Selvaraj <joelselvaraj.oss@gmail.com>
>> + */
> 
> Nit: inconsistent copyright capitalization.
> 
>> +
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/input/mt.h>
>> +#include <linux/input/touchscreen.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +
>> +#define FTS_REG_CHIP_ID_H		0xA3
>> +#define FTS_REG_CHIP_ID_L		0x9F
>> +
>> +#define FTS_MAX_POINTS_SUPPORT		10
>> +#define FTS_ONE_TOUCH_LEN		6
>> +
>> +#define FTS_TOUCH_X_H_OFFSET		3
>> +#define FTS_TOUCH_X_L_OFFSET		4
>> +#define FTS_TOUCH_Y_H_OFFSET		5
>> +#define FTS_TOUCH_Y_L_OFFSET		6
>> +#define FTS_TOUCH_PRESSURE_OFFSET	7
>> +#define FTS_TOUCH_AREA_OFFSET		8
>> +#define FTS_TOUCH_TYPE_OFFSET		3
>> +#define FTS_TOUCH_ID_OFFSET		5
>> +
>> +#define FTS_TOUCH_DOWN			0
>> +#define FTS_TOUCH_UP			1
>> +#define FTS_TOUCH_CONTACT		2
>> +
>> +#define FTS_INTERVAL_READ_REG_MS	100
>> +#define FTS_TIMEOUT_READ_REG_MS		2000
>> +
>> +#define FTS_DRIVER_NAME			"fts-i2c"
>> +
>> +static const u16 fts_chip_types[] = {
>> +	0x5452,
>> +	0x8719,
>> +};
>> +
>> +struct fts_ts_data {
>> +	struct i2c_client *client;
>> +	struct input_dev *input_dev;
>> +	struct regmap *regmap;
>> +	int irq;
>> +	struct regulator_bulk_data regulators[2];
>> +	u8 max_touch_points;
>> +	u8 *point_buf;
>> +	int point_buf_size;
>> +	struct gpio_desc *reset_gpio;
>> +	struct touchscreen_properties prop;
>> +};
>> +
>> +struct fts_i2c_chip_data {
>> +	int max_touch_points;
>> +};
> 
> There is no reason to wrap a single member in a struct; just define an array
> and point each driver_data member to the appropriate element.
> 
> An even better solution, however, would be to merge the device ID into this.
> Then you would have a single array of structs with very clear association
> between device ID and number of points.
> 
>> +
>> +int fts_check_status(struct fts_ts_data *data)
> 
> This function can be static. It also seems to be inappropriately named. Here
> we are checking the device's ID, not its status.
> 
>> +{
>> +	int error, i = 0, count = 0;
>> +	unsigned int val, id;
>> +
>> +	do {
>> +		error = regmap_read(data->regmap, FTS_REG_CHIP_ID_L, &id);
>> +		if (error)
>> +			dev_err(&data->client->dev, "I2C read failed: %d\n", error);
> 
> If this read fails, there is no point in continuing further in this loop. Most
> likely the second read would fail as well but if it doesn't, you are computing
> the id using an uninitialized variable.
> 
> Can you also explain, and possibly add comments, as to why the device ID must
> be checked in a retry loop? Is it because the device may be in a deep sleep and
> must be hit with I2C traffic a couple of times?
> 
> If so, then you likely want to briefly sleep and then start over (i.e. continue)
> in the event of an error.
> 
>> +
>> +		error = regmap_read(data->regmap, FTS_REG_CHIP_ID_H, &val);
>> +		if (error)
>> +			dev_err(&data->client->dev, "I2C read failed: %d\n", error);
> 
> Same problem here.
> 
>> +
>> +		id |= val << 8;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(fts_chip_types); i++)
>> +			if (id == fts_chip_types[i])
>> +				return 0;
> 
> This retry loop in general seems a bit non-optimal. If for example the driver
> is simply communicating with an incompatible device, there is no need to go
> through all N loops.
> 
>> +
>> +		count++;
>> +		msleep(FTS_INTERVAL_READ_REG_MS);
>> +	} while ((count * FTS_INTERVAL_READ_REG_MS) < FTS_TIMEOUT_READ_REG_MS);
> 
> This multiplication seems unnecessarily complicated; can we not simply have
> FTS_MAX_RETRIES or similar?
> 
>> +
>> +	return -EIO;
>> +}
>> +
>> +static int fts_report_touch(struct fts_ts_data *data)
>> +{
>> +	struct input_dev *input_dev = data->input_dev;
>> +	int base;
>> +	unsigned int x, y, z, maj;
>> +	u8 slot, type;
>> +	int error, i = 0;
>> +
>> +	u8 *buf = data->point_buf;
>> +
>> +	memset(buf, 0, data->point_buf_size);
>> +
>> +	error = regmap_bulk_read(data->regmap, 0, buf, data->point_buf_size);
>> +	if (error) {
>> +		dev_err(&data->client->dev, "I2C read failed: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	for (i = 0; i < data->max_touch_points; i++) {
>> +		base = FTS_ONE_TOUCH_LEN * i;
>> +
>> +		slot = buf[base + FTS_TOUCH_ID_OFFSET] >> 4;
>> +		if (slot >= data->max_touch_points)
>> +			break;
>> +
>> +		x = ((buf[base + FTS_TOUCH_X_H_OFFSET] & 0x0F) << 8) +
>> +		    (buf[base + FTS_TOUCH_X_L_OFFSET] & 0xFF);
>> +		y = ((buf[base + FTS_TOUCH_Y_H_OFFSET] & 0x0F) << 8) +
>> +		    (buf[base + FTS_TOUCH_Y_L_OFFSET] & 0xFF);
> 
> Sorry, I did not quite follow the image that was shared in an earlier thread.
> It is unclear to me why we cannot represent the interrupt status registers
> as an array of __be16 values and then do something like the following:
> 
> 		x = be16_to_cpu(buf[FTS_TOUCH_X_OFFSET]) & GENMASK(11, 0);
> 
> I would be surprised if the mask is even necessary; you would need to refer
> to a datasheet however. Perhaps the vendor would be willing to give one to
> you if it means they get an upstream driver?
> 
>> +
>> +		z = buf[base + FTS_TOUCH_PRESSURE_OFFSET];
>> +		if (z == 0)
>> +			z = 0x3f;
>> +
>> +		maj = buf[base + FTS_TOUCH_AREA_OFFSET] >> 4;
>> +		if (maj == 0)
>> +			maj = 0x09;
> 
> I think we need some comments and possibly some #defines to explain what is
> happening here.
> 
>> +
>> +		type = buf[base + FTS_TOUCH_TYPE_OFFSET] >> 6;
>> +
>> +		input_mt_slot(input_dev, slot);
>> +		if (type == FTS_TOUCH_DOWN || type == FTS_TOUCH_CONTACT) {
>> +			input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, true);
>> +			touchscreen_report_pos(data->input_dev, &data->prop, x, y, true);
>> +			input_report_abs(input_dev, ABS_MT_PRESSURE, z);
>> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, maj);
>> +			input_report_key(data->input_dev, BTN_TOUCH, 1);
>> +		} else {
>> +			input_report_key(data->input_dev, BTN_TOUCH, 0);
>> +			input_mt_report_slot_inactive(input_dev);
>> +		}
>> +	}
>> +	input_mt_sync_frame(input_dev);
>> +	input_sync(input_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t fts_ts_interrupt(int irq, void *dev_id)
>> +{
>> +	struct fts_ts_data *data = dev_id;
>> +
>> +	return fts_report_touch(data) ? IRQ_NONE : IRQ_HANDLED;
>> +}
>> +
>> +static void fts_power_off(void *d)
>> +{
>> +	struct fts_ts_data *data = d;
>> +
>> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>> +}
>> +
>> +static int fts_start(struct fts_ts_data *data)
>> +{
>> +	int error;
>> +
>> +	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
>> +				      data->regulators);
>> +	if (error) {
>> +		dev_err(&data->client->dev, "failed to enable regulators\n");
>> +		return error;
>> +	}
>> +
>> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
>> +	msleep(200);
> 
> Same here with respect to comments; what happens during these first 200 ms after
> reset is released? Does the interrupt pin toggle several times? 200 ms is also
> quite a while to wait each time the input handler opens the device; is it really
> necessary?
> 
>> +
>> +	enable_irq(data->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int fts_stop(struct fts_ts_data *data)
>> +{
>> +	disable_irq(data->irq);
>> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
>> +	fts_power_off(data);
>> +
>> +	return 0;
>> +}
>> +
>> +static int fts_input_open(struct input_dev *dev)
>> +{
>> +	struct fts_ts_data *data = input_get_drvdata(dev);
>> +	int error;
>> +
>> +	error = fts_start(data);
>> +	if (error)
>> +		return error;
>> +
>> +	error = fts_check_status(data);
>> +	if (error) {
>> +		dev_err(&data->client->dev, "Failed to start or unsupported chip");
>> +		return error;
>> +	}
> 
> It seems unnecessary and wasteful to check the device ID every time the input
> handler opens the device. We also don't want to go through all the trouble of
> registering the device, only to find out later it wasn't even the right part.
> 
> Instead, you should power up the device during probe, validate its ID and then
> power it back down.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void fts_input_close(struct input_dev *dev)
>> +{
>> +	struct fts_ts_data *data = input_get_drvdata(dev);
>> +
>> +	fts_stop(data);
>> +}
>> +
>> +static int fts_input_init(struct fts_ts_data *data)
>> +{
>> +	struct device *dev = &data->client->dev;
>> +	struct input_dev *input_dev;
>> +	int error = 0;
> 
> No need to initialize this, only for it to get overwritten later.
> 
>> +
>> +	input_dev = devm_input_allocate_device(dev);
>> +	if (!input_dev)
>> +		return -ENOMEM;
>> +
>> +	data->input_dev = input_dev;
>> +
>> +	input_dev->name = FTS_DRIVER_NAME;
>> +	input_dev->id.bustype = BUS_I2C;
>> +	input_dev->dev.parent = dev;
>> +	input_dev->open = fts_input_open;
>> +	input_dev->close = fts_input_close;
>> +	input_set_drvdata(input_dev, data);
>> +
>> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
>> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
>> +
>> +	touchscreen_parse_properties(input_dev, true, &data->prop);
>> +	if (!data->prop.max_x || !data->prop.max_y) {
>> +		dev_err(dev,
>> +			"touchscreen-size-x and/or touchscreen-size-y not set in device properties\n");
> 
> "Device properties" is vague; one could interpret it to mean the controller's
> embedded FW. Just cut the message off at "...not set".
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	error = input_mt_init_slots(input_dev, data->max_touch_points,
>> +				    INPUT_MT_DIRECT);
>> +	if (error)
>> +		return error;
>> +
>> +	data->point_buf_size = (data->max_touch_points * FTS_ONE_TOUCH_LEN) + 3;
>> +	data->point_buf = devm_kzalloc(dev, data->point_buf_size, GFP_KERNEL);
>> +	if (!data->point_buf)
>> +		return -ENOMEM;
>> +
>> +	error = input_register_device(input_dev);
>> +	if (error) {
>> +		dev_err(dev, "Failed to register input device\n");
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct regmap_config fts_ts_i2c_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +};
>> +
>> +static int fts_ts_probe(struct i2c_client *client)
>> +{
>> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>> +	const struct fts_i2c_chip_data *chip_data;
>> +	struct fts_ts_data *data;
>> +	int error = 0;
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>> +		dev_err(&client->dev, "I2C not supported");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!client->irq) {
>> +		dev_err(&client->dev, "No irq specified\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	chip_data = device_get_match_data(&client->dev);
>> +	if (!chip_data)
>> +		chip_data = (const struct fts_i2c_chip_data *)id->driver_data;
>> +	if (!chip_data || !chip_data->max_touch_points) {
>> +		dev_err(&client->dev, "invalid or missing chip data\n");
>> +		return -EINVAL;
>> +	}
>> +	if (chip_data->max_touch_points > FTS_MAX_POINTS_SUPPORT) {
>> +		dev_err(&client->dev,
>> +			"invalid chip data, max_touch_points should be less than or equal to %d\n",
>> +			FTS_MAX_POINTS_SUPPORT);
>> +		return -EINVAL;
>> +	}
> 
> This check is not necessary; if someone adds an invalid max_touch_points, then the
> driver was updated incorrectly. There is no need to check it at every runtime.
> 
>> +	data->max_touch_points = chip_data->max_touch_points;
>> +
>> +	data->client = client;
>> +	i2c_set_clientdata(client, data);
>> +
>> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(data->reset_gpio)) {
>> +		error = PTR_ERR(data->reset_gpio);
>> +		dev_err(&client->dev, "Failed to request reset gpio, error %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &fts_ts_i2c_regmap_config);
>> +	if (IS_ERR(data->regmap)) {
>> +		error = PTR_ERR(data->regmap);
>> +		dev_err(&client->dev, "regmap allocation failed, error %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	/*
>> +	 * AVDD is the analog voltage supply (2.6V to 3.3V)
>> +	 * VDDIO is the digital voltage supply (1.8V)
>> +	 */
>> +	data->regulators[0].supply = "avdd";
>> +	data->regulators[1].supply = "vddio";
>> +	error = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
>> +					data->regulators);
>> +	if (error) {
>> +		dev_err(&client->dev, "Failed to get regulators %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	error = devm_add_action_or_reset(&client->dev, fts_power_off, data);
>> +	if (error) {
>> +		dev_err(&client->dev, "failed to install power off handler\n");
>> +		return error;
>> +	}
> 
> Christophe makes a great point. If this or any other call throughout the rest of
> probe as you have written it fails, you will try to disable a disabled regulator.
> 
> The same will happen when the driver is torn down, as the input handler should
> have already powered down the device by way of the close callback. Did you build
> this driver as a module and test removal? I suspect you will get a stack trace.
> 
> I think the call needs to go away altogether.
> 
>> +
>> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +					  fts_ts_interrupt, IRQF_ONESHOT,
>> +					  client->name, data);
>> +	if (error) {
>> +		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	error = fts_input_init(data);
>> +	if (error)
>> +		return error;
>> +
>> +	return 0;
> 
> This is idiomatic, but I find "return fts_input_init(data);" to be simpler.
> 
>> +}
>> +
>> +static int fts_pm_suspend(struct device *dev)
>> +{
>> +	struct fts_ts_data *data = dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&data->input_dev->mutex);
>> +
>> +	if (input_device_enabled(data->input_dev))
>> +		fts_stop(data);
>> +
>> +	mutex_unlock(&data->input_dev->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int fts_pm_resume(struct device *dev)
>> +{
>> +	struct fts_ts_data *data = dev_get_drvdata(dev);
>> +	int error = 0;
> 
> Same here, there is no point in initializating this.
> 
>> +
>> +	mutex_lock(&data->input_dev->mutex);
>> +
>> +	if (input_device_enabled(data->input_dev))
>> +		error = fts_start(data);
>> +
>> +	mutex_unlock(&data->input_dev->mutex);
>> +
>> +	return error;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(fts_dev_pm_ops, fts_pm_suspend, fts_pm_resume);
>> +
>> +static const struct fts_i2c_chip_data fts5452_chip_data = {
>> +	.max_touch_points = 5,
>> +};
>> +
>> +static const struct fts_i2c_chip_data fts8719_chip_data = {
>> +	.max_touch_points = 10,
>> +};
>> +
>> +static const struct i2c_device_id fts_i2c_id[] = {
>> +	{ .name = "fts5452", .driver_data = (long)&fts5452_chip_data },
>> +	{ .name = "fts8719", .driver_data = (long)&fts8719_chip_data },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, fts_i2c_id);
>> +
>> +static const struct of_device_id fts_of_match[] = {
>> +	{ .compatible = "focaltech,fts5452", .data = &fts5452_chip_data },
>> +	{ .compatible = "focaltech,fts8719", .data = &fts8719_chip_data },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, fts_of_match);
>> +
>> +static struct i2c_driver fts_ts_driver = {
>> +	.probe_new = fts_ts_probe,
>> +	.id_table = fts_i2c_id,
>> +	.driver = {
>> +		.name = FTS_DRIVER_NAME,
>> +		.pm = pm_sleep_ptr(&fts_dev_pm_ops),
>> +		.of_match_table = fts_of_match,
>> +	},
>> +};
>> +module_i2c_driver(fts_ts_driver);
>> +
>> +MODULE_AUTHOR("Joel Selvaraj <joelselvaraj.oss@gmail.com>");
>> +MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
>> +MODULE_DESCRIPTION("Focaltech Touchscreen Driver");
> 
> Nit: mixing 'FocalTech' and 'Focaltech' throughout.
> 
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.40.0
>>
> 
> Kind regards,
> Jeff LaBundy
> 

