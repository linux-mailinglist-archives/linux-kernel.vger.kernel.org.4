Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD66E6B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDRRsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDRRr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:47:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2393;
        Tue, 18 Apr 2023 10:47:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso1951670b3a.2;
        Tue, 18 Apr 2023 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840074; x=1684432074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0aHPwUm+nHfPbpRzjUGPcYV0vNpCzAJ2ZQdeAyc2yQ=;
        b=POiUmAoQeY6Yc0fHWkIFUH26e5mSchhDtN8Gke1qx+wNDj8QCfgi2Nsqdgzkqz2Iza
         L4oAuE94RQ29ObMC1Ln7GsbyffesBEkvoh30sfjwSreNsC8mvO2tdBzGfKQaItZRFHWO
         6WiJ2M2S3ejlfvPXBUt8R//zb5p46HeiE8tdzIbWEUy2Tbr+TupzXSiKgpKzWX3bBpuL
         NEoEVgZhiwLKIedGtC6kk4+MgawIlluW9UAE7V/Jwhy7QfqGXttpbf0GKfe+xVDMQ+yK
         A9UaSibjh49Iuv0uDwgSF6/BqMaqI+oljOuW0S5mMAz+UI1kZNfEwIzI3x5pBPPPoDlH
         SAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840074; x=1684432074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0aHPwUm+nHfPbpRzjUGPcYV0vNpCzAJ2ZQdeAyc2yQ=;
        b=Pd+op0LDhw/qfGgTIapjlLaFe2AA6aT2eWhdqiNuDR6a/jrwvZoBVM8xaqJrYZ8L4i
         6va/QU9RF+9JKK6iEgc2FDbptHHf85gDV3ZlHNO0HDtsAnJ3dcQcfno5S460yseywaql
         BW5NiNyc2jOTncdtm43GFqFB5EjeoFtM4XuH7BOUAJiAawqBMOKhtD8DrE2TrZU7qPWT
         pBkR6tU4mybUAB0P1xk9Jo+cXspbQyP9Og1O9rf52Xu3uanh7lJQ+4FKgkggvrSRg7Yq
         FdTJC1r4SikFo4jZYs3ilwRmkIYcn4hV5xeqZgyRoO4nW/q5DE8jjHDZfcbWdjmPZdtt
         +qYw==
X-Gm-Message-State: AAQBX9frJhcPrJfcRZpRqQcHW/XM46yaQj0mPLa3FUmjVD1D5wlsSHAj
        kTbyulskXRoQOW9/7s1Ub78=
X-Google-Smtp-Source: AKy350Ynn/SAVNZRjG2BBdYlsSfH8O7hqL7UpfrnxISfFXMt+0vsL+3BPa4+zaQTc6x2bzONMUz8kw==
X-Received: by 2002:a05:6a00:2e0b:b0:63b:7af1:47d5 with SMTP id fc11-20020a056a002e0b00b0063b7af147d5mr672855pfb.9.1681840073587;
        Tue, 18 Apr 2023 10:47:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o21-20020a63f155000000b0050be8e0b94csm9102986pgk.90.2023.04.18.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:47:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Apr 2023 10:47:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jdelvare@suse.com, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/9] hwmon: (gxp-psu) Add driver to read HPE PSUs
Message-ID: <5328abea-6356-487d-aa24-60350d06ba7b@roeck-us.net>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418152824.110823-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:28:18AM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC can support up to 8 power supplies that it can communicate
> with via i2c. The GXP PSU driver will provide a method for the GPIO
> driver with info it reads to be available to the host.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/gxp-psu.c | 773 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 784 insertions(+)
>  create mode 100644 drivers/hwmon/gxp-psu.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..3b56690ea089 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -723,6 +723,16 @@ config SENSORS_GXP_FAN_CTRL
>  	  The GXP controls fan function via the CPLD through the use of PWM
>  	  registers. This driver reports status and pwm setting of the fans.
>  
> +config SENSORS_GXP_PSU
> +	tristate "HPE GXP PSU driver"
> +	depends on ARCH_HPE_GXP || COMPILE_TEST
> +	depends on I2C
> +	help
> +	  If you say yes you will get support for GXP psu driver support. The GXP
> +	  gets PSU presence and state information from the CPLD. The GXP gets PSU
> +	  data via i2c. It provides a method for other drivers to call into get
> +	  PSU presence information.
> +
>  config SENSORS_HIH6130
>  	tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..6c84cd52d0d3 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>  obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
> +obj-$(CONFIG_SENSORS_GXP_PSU)	+= gxp-psu.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
>  obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
> diff --git a/drivers/hwmon/gxp-psu.c b/drivers/hwmon/gxp-psu.c
> new file mode 100644
> index 000000000000..e4217200c34b
> --- /dev/null
> +++ b/drivers/hwmon/gxp-psu.c
> @@ -0,0 +1,773 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Hewlett-Packard Enterpise Development Company, L.P. */
> +
> +#include <linux/err.h>
> +#include <linux/debugfs.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +
> +#define READ_REG_CMD		0x00
> +#define READ_FRU_CMD		0x22
> +#define REG_IN_VOL		0x10
> +#define REG_IN_CUR		0x11
> +#define REG_IN_PWR		0x12
> +#define REG_OUT_VOL		0x20
> +#define REG_OUT_CUR		0x21
> +#define REG_OUT_PWR		0x22
> +#define REG_FAN_SPEED		0x40
> +#define REG_INLET_TEMP		0x42
> +#define MAX_PSU			0x08
> +#define INPUT_CHAN 0
> +
> +#define L_IN_POWER		"pin1"
> +#define L_OUT_POWER		"pout1"
> +#define L_IN_IN			"vin"
> +#define L_OUT_IN		"vout1"
> +#define L_FAN			"fan1"
> +#define L_IN_CURR		"iin"
> +#define L_OUT_CURR		"iout1"
> +#define L_TEMP			"temp1"
> +
> +static void __iomem *pl_psu;
> +
> +struct gxp_psu_drvdata {
> +	struct i2c_client *client;
> +	u16 input_power;
> +	u16 input_voltage;
> +	u16 input_current;
> +	u16 output_power;
> +	u16 output_voltage;
> +	u16 output_current;
> +	s16 inlet_temp;
> +	u16 fan_speed;
> +	u8 id;
> +	struct dentry *debugfs;
> +	u8 spare_part[10];
> +	u8 product_name[26];
> +	u8 serial_number[14];
> +	u8 product_manufacturer[3];
> +	bool present; /* psu can be physically removed */
> +	struct mutex update_lock;
> +	struct device *hwmon_dev;
> +};
> +
> +static u8 psucount;
> +struct gxp_psu_drvdata *psus[MAX_PSU] = { NULL };
> +
> +u8 get_psu_inst(void)
> +{
> +	if (!pl_psu)
> +		return 0;
> +
> +	return readb(pl_psu);
> +}
> +EXPORT_SYMBOL(get_psu_inst);
> +
> +u8 get_psu_ac(void)
> +{
> +	if (!pl_psu)
> +		return 0;
> +
> +	return readb(pl_psu + 0x02);
> +}
> +EXPORT_SYMBOL(get_psu_ac);
> +
> +u8 get_psu_dc(void)
> +{
> +	if (!pl_psu)
> +		return 0;
> +
> +	return readb(pl_psu + 0x03);
> +}
> +EXPORT_SYMBOL(get_psu_dc);
> +

The above is unacceptable. If you want to make the information available
to userspace, use debugfs files. 

> +void update_presence(u8 id)
> +{
> +	unsigned int i;
> +	unsigned long temp = (unsigned long)readb(pl_psu);
> +
> +	for_each_set_bit(i, &temp, 8) {
> +		if (i == id)
> +			psus[id]->present = true;
> +	}
> +
> +	temp = ~temp;
> +	for_each_set_bit(i, &temp, 8) {
> +		if (i == id)
> +			psus[id]->present = false;
> +	}
> +}
> +
> +static unsigned char cal_checksum(unsigned char *buf, unsigned long size)
> +{
> +	unsigned char sum = 0;
> +
> +	while (size > 0) {
> +		sum += (*(buf++));
> +		size--;
> +	}
> +	return ((~sum) + 1);
> +}
> +
> +static unsigned char valid_checksum(unsigned char *buf, unsigned long size)
> +{
> +	unsigned char sum = 0;
> +
> +	while (size > 0) {
> +		sum += (*(buf++));
> +		size--;
> +	}
> +	return sum;
> +}
> +
> +static int psu_read_fru(struct gxp_psu_drvdata *drvdata,
> +			u8 offset, u8 length, u8 *value)
> +{
> +	struct i2c_client *client = drvdata->client;
> +	unsigned char buf_tx[4] = {(client->addr << 1), READ_FRU_CMD, offset, length};
> +	unsigned char tx[4] = {0};
> +	unsigned char chksum = cal_checksum(buf_tx, 4);
> +	int ret = 0;

Initializing ret is unnecessary.

> +	struct i2c_msg msgs[2] = {0};
> +
> +	update_presence(drvdata->id);
> +
> +	value[0] = '\0';
> +
> +	if (!drvdata->present)
> +		return -EOPNOTSUPP;

Wrong return value. The attribute is supported, it just doesn't have any data
associated with it.

> +
> +	tx[0] = READ_FRU_CMD;
> +	tx[1] = offset;
> +	tx[2] = length;
> +	tx[3] = chksum;
> +	msgs[0].addr = client->addr;
> +	msgs[0].flags = 0;
> +	msgs[0].buf = tx;
> +	msgs[0].len = 4;
> +	msgs[1].addr = client->addr;
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].buf = value;
> +	msgs[1].len = length;
> +
> +	mutex_lock(&drvdata->update_lock);
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	mutex_unlock(&drvdata->update_lock);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"gxppsu_i2c_tx_fail addr:0x%x offest:0x%x length:0x%x chk:0x%x ret:0x%x\n",
> +			client->addr, offset, length, chksum, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int psu_read_reg_word(struct gxp_psu_drvdata *drvdata,
> +			     u8 reg, u16 *value)
> +{
> +	struct i2c_client *client = drvdata->client;
> +	unsigned char buf_tx[3] = {(client->addr << 1), READ_REG_CMD, reg};
> +	unsigned char buf_rx[3] = {0};
> +	unsigned char tx[3] = {0};
> +	unsigned char rx[3] = {0};
> +	unsigned char chksum = cal_checksum(buf_tx, 3);
> +	struct i2c_msg msgs[2] = {0};
> +	int ret = 0;
> +
> +	tx[0] = 0;
> +	tx[1] = reg;
> +	tx[2] = chksum;
> +
> +	msgs[0].addr = client->addr;
> +	msgs[0].flags = 0;
> +	msgs[0].buf = tx;
> +	msgs[0].len = 3;
> +	msgs[1].addr = client->addr;
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].buf = rx;
> +	msgs[1].len = 3;
> +	mutex_lock(&drvdata->update_lock);
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	mutex_unlock(&drvdata->update_lock);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"gxppsu_i2c_tx_fail addr:0x%x reg:0x%x chk:0x%x ret:0x%x\n",
> +			client->addr, reg, chksum, ret);
> +		return ret;
> +	}
> +
> +	buf_rx[0] = rx[0];
> +	buf_rx[1] = rx[1];
> +	buf_rx[2] = rx[2];
> +	if (valid_checksum(buf_rx, 3) != 0) {
> +		dev_err(&client->dev,
> +			"gxppsu_checksum_fail addr:0x%x reg:0x%x, data:%x %x %x\n",
> +			client->addr, reg, rx[0], rx[1], rx[2]);
> +		return -EAGAIN;

This is an IO error. If the interface is so unstable that it needs retries,
implement retries, don't expect the kernel or userspace to do it for you,
and limit the number of retries.

> +	}
> +
> +	*value = rx[0] + (rx[1] << 8);

Are those values all in units expected by the hwmon subsystem ?

> +
> +	return ret;
> +}
> +
> +static int gxppsu_update_client(struct device *dev, u8 reg)
> +{
> +	struct gxp_psu_drvdata *drvdata = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	update_presence(drvdata->id);
> +
 +	if (!drvdata->present)
> +		return -EOPNOTSUPP;

Should be -ENODATA but, really, PSUs should not be instantiated to start with
if they are not installed.

> +
> +	switch (reg) {
> +	case REG_IN_PWR:
> +		ret = psu_read_reg_word(drvdata, REG_IN_PWR,
> +					&drvdata->input_power);
> +		break;
> +	case REG_IN_VOL:
> +		ret = psu_read_reg_word(drvdata, REG_IN_VOL,
> +					&drvdata->input_voltage);
> +		break;
> +	case REG_IN_CUR:
> +		ret = psu_read_reg_word(drvdata, REG_IN_CUR,
> +					&drvdata->input_current);
> +		break;
> +	case REG_OUT_PWR:
> +		ret = psu_read_reg_word(drvdata, REG_OUT_PWR,
> +					&drvdata->output_power);
> +		break;
> +	case REG_OUT_VOL:
> +		ret = psu_read_reg_word(drvdata, REG_OUT_VOL,
> +					&drvdata->output_voltage);
> +		break;
> +	case REG_OUT_CUR:
> +		ret = psu_read_reg_word(drvdata, REG_OUT_CUR,
> +					&drvdata->output_current);
> +		break;
> +	case REG_INLET_TEMP:
> +		ret = psu_read_reg_word(drvdata, REG_INLET_TEMP,
> +					&drvdata->inlet_temp);
> +		break;
> +	case REG_FAN_SPEED:
> +		ret = psu_read_reg_word(drvdata, REG_FAN_SPEED,
> +					&drvdata->fan_speed);
> +		break;
> +	default:
> +		dev_err(&drvdata->client->dev, "gxppsu_error_reg 0x%x\n", reg);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int gxp_psu_get_power_input(struct device *dev, u32 attr, int channel,
> +				   long *val)
> +{
> +	struct gxp_psu_drvdata *drvdata = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u8 reg;
> +
> +	if (channel == INPUT_CHAN)
> +		reg = REG_IN_PWR;
> +	else
> +		reg = REG_OUT_PWR;
> +
> +	ret = gxppsu_update_client(dev, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel == INPUT_CHAN)
> +		*val = drvdata->input_power;
> +	else
> +		*val = drvdata->output_power;
> +
> +	return 0;
> +}
> +
> +static int gxp_psu_get_in_input(struct device *dev, u32 attr, int channel,
> +				long *val)
> +{
> +	struct gxp_psu_drvdata *drvdata = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u8 reg;
> +
> +	if (channel == INPUT_CHAN)
> +		reg = REG_IN_VOL;
> +	else
> +		reg = REG_OUT_VOL;
> +
> +	ret = gxppsu_update_client(dev, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel == INPUT_CHAN)
> +		*val = drvdata->input_voltage;
> +	else
> +		*val = drvdata->output_voltage;
> +
> +	return 0;
> +}
> +
> +static int gxp_psu_get_curr_input(struct device *dev, u32 attr, int channel,
> +				  long *val)
> +{
> +	struct gxp_psu_drvdata *drvdata = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u8 reg;
> +
> +	if (channel == INPUT_CHAN)
> +		reg = REG_IN_CUR;
> +	else
> +		reg = REG_OUT_CUR;
> +
> +	ret = gxppsu_update_client(dev, reg);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel == INPUT_CHAN)
> +		*val = drvdata->input_current;
> +	else
> +		*val = drvdata->output_current;
> +
> +	return 0;
> +}
> +
> +static int gxp_psu_get_temp_input(struct device *dev, u32 attr, int channel,
> +				  long *val)
> +{
> +	struct gxp_psu_drvdata *drvdata = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u8 reg = REG_INLET_TEMP;
> +
> +	ret = gxppsu_update_client(dev, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = drvdata->inlet_temp;
> +
> +	return 0;
> +};
> +
> +static int gxp_psu_get_fan_input(struct device *dev, u32 attr, int channel,
> +				 long *val)
> +{
> +	struct gxp_psu_drvdata *drvdata = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u8 reg = REG_FAN_SPEED;
> +
> +	ret = gxppsu_update_client(dev, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = drvdata->fan_speed;
> +

All this code is terribly complex. Why not just use a function passing the
register and returning its value ? Storing interim results in various
variables just to read them a bit later seems like a lot of overly complex
code.

Example:

psu_read_reg_word(drvdata, REG_IN_PWR,
> +                                     &drvdata->input_power);

	u16 fan_speed;

	ret = psu_read_reg_word(dev, REG_FAN_SPEED, &fan_speed);
	if (ret < 0)
		return ret
	
	return fan_speed;

Given that the value parameter of psu_read_reg_word() is a pointer to u16,
it is unnecessary to provide it in the first place, and the return value
could be both an error or a return value. This would reduce this code to

	return psu_read_reg_word(dev, REG_FAN_SPEED);

> +	return 0;
> +}
> +
> +void swapbytes(void *input, size_t len)
> +{
> +	unsigned int i;
> +	unsigned char *in = (unsigned char *)input, tmp;
> +
> +	for (i = 0; i < len / 2; i++) {
> +		tmp = *(in + i);
> +		*(in + i) = *(in + len - i - 1);
> +		*(in + len - i - 1) = tmp;
> +	}
> +}
> +
> +static const struct hwmon_channel_info *gxp_psu_info[] = {
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static umode_t gxp_psu_is_visible(const void *_data, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	umode_t mode = 0;
> +
> +	switch (type) {
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +		case hwmon_power_label:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +	break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +		case hwmon_in_label:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +		case hwmon_fan_label:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +		case hwmon_curr_label:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_label:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +static int gxp_psu_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			return gxp_psu_get_power_input(dev, attr, channel,
> +							       val);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return gxp_psu_get_in_input(dev, attr, channel,
> +							    val);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return gxp_psu_get_fan_input(dev, attr, channel,
> +							     val);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			return gxp_psu_get_curr_input(dev, attr, channel,
> +						val);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return gxp_psu_get_temp_input(dev, attr, channel,
> +						      val);
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int gxp_psu_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			       u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_label:
> +			*str = channel ? L_OUT_POWER : L_IN_POWER;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_label:
> +			*str = channel ? L_OUT_IN : L_IN_IN;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_label:
> +			*str = L_FAN;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_label:
> +			*str = channel ? L_OUT_CURR : L_IN_CURR;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +			*str = L_TEMP;
> +			return 0;
> +		default:
> +			break;
> +		}
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops gxp_psu_ops = {
> +	.is_visible = gxp_psu_is_visible,
> +	.read = gxp_psu_read,
> +	.read_string = gxp_psu_read_string,
> +};
> +
> +static const struct hwmon_chip_info gxp_psu_chip_info = {
> +	.ops = &gxp_psu_ops,
> +	.info = gxp_psu_info,
> +};
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static int serial_number_show(struct seq_file *seqf, void *unused)
> +{
> +	struct gxp_psu_drvdata *drvdata = seqf->private;
> +	int ret = 0;
> +
> +	ret = psu_read_fru(drvdata, 91, 14, &drvdata->serial_number[0]);
> +	if (ret < 0) {
> +		dev_err(&drvdata->client->dev, "Unknown product serial number %d", ret);
> +		seq_puts(seqf, "unknown\n");
> +		return 0;
> +	}
> +
> +	seq_printf(seqf, "%s\n", drvdata->serial_number);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(serial_number);
> +
> +static int manufacturer_show(struct seq_file *seqf, void *unused)
> +{
> +	struct gxp_psu_drvdata *drvdata = seqf->private;
> +	int ret = 0;
> +
> +	ret = psu_read_fru(drvdata, 197, 3, &drvdata->product_manufacturer[0]);
> +	if (ret < 0) {
> +		dev_err(&drvdata->client->dev, "Unknown product manufacturer %d", ret);
> +		seq_puts(seqf, "unknown\n");
> +		return 0;
> +	}
> +
> +	swapbytes(&drvdata->product_manufacturer[0], 3);
> +	seq_printf(seqf, "%s\n", drvdata->product_manufacturer);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(manufacturer);
> +
> +static int product_name_show(struct seq_file *seqf, void *unused)
> +{
> +	struct gxp_psu_drvdata *drvdata = seqf->private;
> +	int ret = 0;
> +
> +	ret = psu_read_fru(drvdata, 50, 26, &drvdata->product_name[0]);
> +	if (ret < 0) {
> +		dev_err(&drvdata->client->dev, "Unknown product name %d", ret);
> +		seq_puts(seqf, "unknown\n");
> +		return 0;
> +	}
> +
> +	seq_printf(seqf, "%s\n", drvdata->product_name);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(product_name);
> +
> +static int spare_show(struct seq_file *seqf, void *unused)
> +{
> +	struct gxp_psu_drvdata *drvdata = seqf->private;
> +	int ret = 0;
> +
> +	ret = psu_read_fru(drvdata, 18, 10, &drvdata->spare_part[0]);
> +	if (ret < 0) {
> +		dev_err(&drvdata->client->dev, "Unknown product spare %d", ret);
> +		seq_puts(seqf, "unknown\n");
> +		return 0;
> +	}
> +
> +	seq_printf(seqf, "%s\n", drvdata->spare_part);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(spare);
> +
> +static int present_show(struct seq_file *seqf, void *unused)
> +{
> +	struct gxp_psu_drvdata *drvdata = seqf->private;
> +
> +	update_presence(drvdata->id);
> +
> +	if (drvdata->present)
> +		seq_puts(seqf, "yes\n");
> +	else
> +		seq_puts(seqf, "no\n");
> +

What happens if the power supply is not present and someone tries 
to read any of its attributes ?

> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(present);
> +
> +static void gxp_psu_debugfs_init(struct gxp_psu_drvdata *drvdata)
> +{
> +	char name[32];
> +
> +	scnprintf(name, sizeof(name), "%s_%s-%d", dev_name(drvdata->hwmon_dev),
> +		  drvdata->client->name, drvdata->client->addr);
> +
> +	drvdata->debugfs = debugfs_create_dir(name, NULL);

drvdata->debugfs is only used here. No point storing the variable in drvdata
unless it is used there (for removal, for example).

I really wonder what happens if the driver is built as module and unloaded.

> +
> +	debugfs_create_file("serial_number", 0444, drvdata->debugfs, drvdata, &serial_number_fops);
> +
> +	debugfs_create_file("manufacturer", 0444, drvdata->debugfs, drvdata, &manufacturer_fops);
> +
> +	debugfs_create_file("product_name", 0444, drvdata->debugfs, drvdata, &product_name_fops);
> +
> +	debugfs_create_file("spare", 0444, drvdata->debugfs, drvdata, &spare_fops);
> +
> +	debugfs_create_file("present", 0444, drvdata->debugfs, drvdata, &present_fops);
> +
> +	if (!debugfs_initialized())
> +		dev_err(&drvdata->client->dev, "Debug FS not Init");

No such error message please. debugfs failures are supposed to be silent.

> +}
> +
> +#else
> +
> +static void gxp_psu_debugfs_init(struct gxp_psu_drvdata *drvdata)
> +{
> +}
> +
> +#endif
> +
> +static int gxp_psu_probe(struct i2c_client *client)
> +{
> +	struct gxp_psu_drvdata *drvdata;
> +	struct device *hwmon_dev;
> +	struct device_node *np;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL))
> +		return -EIO;
> +
> +	drvdata = devm_kzalloc(&client->dev, sizeof(struct gxp_psu_drvdata),
> +			       GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	if (!pl_psu) {
> +		np = of_parse_phandle(client->dev.of_node, "hpe,sysreg", 0);
> +		if (!np)
> +			return -ENODEV;
> +
> +		pl_psu = of_iomap(np, 0);
> +		if (IS_ERR(pl_psu))
> +			return dev_err_probe(&client->dev, IS_ERR(pl_psu),
> +					     "failed to map pl_psu");
> +	}
> +
> +	drvdata->client = client;
> +	i2c_set_clientdata(client, drvdata);
> +
> +	mutex_init(&drvdata->update_lock);
> +	drvdata->hwmon_dev = NULL;

What is that for ? drvdata was just allocated with devm_kzalloc().

> +	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
> +							 "hpe_gxp_psu",
> +							 drvdata,
> +							 &gxp_psu_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	drvdata->hwmon_dev = hwmon_dev;

drvdata->hwmon_dev is only used in gxp_psu_debugfs_init().
That means it is really pointless to store it in drvdata;
you might as well pass hwmon_dev as parameter to that function.

> +
> +	drvdata->id = psucount;
> +
> +	psus[psucount] = drvdata;
> +
> +	update_presence(drvdata->id);
> +
> +	psucount++;

So what happens if someone removes and reinstantiates this driver ?
Or instantiates more than MAX_PSU instances ?

Overall this looks very fragile. There should not be any such static
variables/arrays. I'd suggest to use a list and the I2C address as
ID, or something similar.

> +
> +	gxp_psu_debugfs_init(drvdata);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gxp_psu_of_match[] = {
> +	{ .compatible = "hpe,gxp-psu" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_psu_of_match);
> +
> +static struct i2c_driver gxp_psu_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "gxp-psu",
> +		.of_match_table = gxp_psu_of_match,
> +	},
> +	.probe_new = gxp_psu_probe,
> +};
> +module_i2c_driver(gxp_psu_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP PSU driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 
