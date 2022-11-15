Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5C629FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKORCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiKORCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:02:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D72CC9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:02:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ouzJp-0000al-Kh; Tue, 15 Nov 2022 18:01:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ouzJm-004Tq7-Ou; Tue, 15 Nov 2022 18:01:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ouzJm-00GrE0-VP; Tue, 15 Nov 2022 18:01:50 +0100
Date:   Tue, 15 Nov 2022 18:01:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: (max6639) Change from pdata to dt
 configuration
Message-ID: <20221115170150.ovrfesvy36beedyq@pengutronix.de>
References: <20221115122005.758519-1-Naresh.Solanki@9elements.com>
 <20221115122005.758519-4-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jayssqa4c35myrxt"
Content-Disposition: inline
In-Reply-To: <20221115122005.758519-4-Naresh.Solanki@9elements.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jayssqa4c35myrxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 15, 2022 at 01:20:05PM +0100, Naresh Solanki wrote:
> max6639_platform_data is not used by any in-kernel driver and does not
> address the MAX6639 fans separately.
> Move to device tree configuration with explicit properties to configure
> each fan.

My overall impression is that this patch mixes too much things. IMHO it
should be split in (at least)

 - Add dt support
 - Drop platform support
 - Add PWM provider support
 - Make use of the PWM API

maybe also add the 2nd PWM in a separate step.

Some more comments inline.

> Non-DT platform can still use this module with its default
> configuration.
>=20
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/Kconfig   |   1 +
>  drivers/hwmon/max6639.c | 465 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 392 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5695b266abcf..ad1f6742ca50 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1106,6 +1106,7 @@ config SENSORS_MAX6621
>  config SENSORS_MAX6639
>  	tristate "Maxim MAX6639 sensor chip"
>  	depends on I2C
> +	depends on PWM
>  	help
>  	  If you say yes here you get support for the MAX6639
>  	  sensor chips.
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 9b895402c80d..d1ae77e8f72e 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -19,7 +19,7 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> -#include <linux/platform_data/max6639.h>

This file is now unused and can be dropped.

> +#include <linux/pwm.h>
> =20
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] =3D { 0x2c, 0x2e, 0x2f, I2C_CLI=
ENT_END };
> @@ -54,11 +54,20 @@ static const unsigned short normal_i2c[] =3D { 0x2c, =
0x2e, 0x2f, I2C_CLIENT_END };
>  #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
> =20
>  #define MAX6639_FAN_CONFIG1_PWM			0x80
> -
> +#define MAX6639_REG_FAN_CONFIG2a_PWM_POL	0x02
>  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
> +#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
> +#define MAX6639_REG_TARGTDUTY_SLOT		120
> =20
> +/* Tach supported range. This internally controls tach frequency */
>  static const int rpm_ranges[] =3D { 2000, 4000, 8000, 16000 };
> =20
> +/* Supported PWM frequency */
> +static const unsigned int freq_table[] =3D { 20, 33, 50, 100, 5000, 8333=
, 12500,
> +					25000 };

I would have put these in a single line, or one line per freq, or at
least aligned the last value such that it is at a higher column than the
opening {.

> +
> +
> +

Three empty lines? One or two only should do it.

>  #define FAN_FROM_REG(val, rpm_range)	((val) =3D=3D 0 || (val) =3D=3D 255=
 ? \
>  				0 : (rpm_ranges[rpm_range] * 30) / (val))
>  #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
> @@ -76,20 +85,24 @@ struct max6639_data {
>  	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
>  	bool temp_fault[2];	/* Detected temperature diode failure */
>  	u8 fan[2];		/* Register value: TACH count for fans >=3D30 */
> +	struct pwm_device	*pwmd[2]; /* max6639 has two pwm device */
> +	u32 target_rpm[2];
> +	u32 max_rpm[2];
> +
>  	u8 status;		/* Detected channel alarms and fan failures */
> =20
>  	/* Register values only written to */
> -	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
>  	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
>  	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
>  	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
> =20
>  	/* Register values initialized only once */
> -	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
> -	u8 rpm_range;		/* Index in above rpm_ranges table */
> -
> +	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
> +	u8 rpm_range[2];	/* Index in above rpm_ranges table */
>  	/* Optional regulator for FAN supply */
>  	struct regulator *reg;
> +	/* max6639 pwm chip */
> +	struct pwm_chip chip;
>  };
> =20
>  static struct max6639_data *max6639_update_device(struct device *dev)
> @@ -280,8 +293,12 @@ static ssize_t pwm_show(struct device *dev, struct d=
evice_attribute *dev_attr,
>  {
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data =3D dev_get_drvdata(dev);
> +	struct pwm_state state;
> +
> +	pwm_get_state(data->pwmd[attr->index], &state);
> +
> +	return sprintf(buf, "%d\n", pwm_get_relative_duty_cycle(&state, 255));
> =20
> -	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
>  }
> =20
>  static ssize_t pwm_store(struct device *dev,
> @@ -290,9 +307,9 @@ static ssize_t pwm_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data =3D dev_get_drvdata(dev);
> -	struct i2c_client *client =3D data->client;
>  	unsigned long val;
>  	int res;
> +	struct pwm_state state;
> =20
>  	res =3D kstrtoul(buf, 10, &val);
>  	if (res)
> @@ -300,12 +317,12 @@ static ssize_t pwm_store(struct device *dev,
> =20
>  	val =3D clamp_val(val, 0, 255);
> =20
> -	mutex_lock(&data->update_lock);
> -	data->pwm[attr->index] =3D (u8)(val * 120 / 255);
> -	i2c_smbus_write_byte_data(client,
> -				  MAX6639_REG_TARGTDUTY(attr->index),
> -				  data->pwm[attr->index]);
> -	mutex_unlock(&data->update_lock);
> +	pwm_get_state(data->pwmd[attr->index], &state);
> +	pwm_set_relative_duty_cycle(&state, val, 255);
> +	res =3D pwm_apply_state(data->pwmd[attr->index], &state);
> +	if (res)
> +		return res;
> +
>  	return count;
>  }
> =20
> @@ -319,7 +336,7 @@ static ssize_t fan_input_show(struct device *dev,
>  		return PTR_ERR(data);
> =20
>  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> -		       data->rpm_range));
> +		       data->rpm_range[attr->index]));
>  }
> =20
>  static ssize_t alarm_show(struct device *dev,
> @@ -386,29 +403,41 @@ static struct attribute *max6639_attrs[] =3D {
>  ATTRIBUTE_GROUPS(max6639);
> =20
>  /*
> - *  returns respective index in rpm_ranges table
> - *  1 by default on invalid range
> + *  Get respective index in rpm_ranges table
>   */
> -static int rpm_range_to_reg(int range)
> +static int rpm_range_to_index(struct device *dev, u8 *index, int rpm)
>  {
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(rpm_ranges); i++) {
> -		if (rpm_ranges[i] =3D=3D range)
> -			return i;
> +	if (rpm < 0)
> +		return -EINVAL;
> +
> +	/* Set index based on chip support */
> +	switch (rpm) {
> +	case 0 ... 2000:
> +		*index =3D 0;
> +		break;
> +	case 2001 ... 4000:
> +		*index =3D 1;
> +		break;
> +	case 4001 ... 8000:
> +		*index =3D 2;
> +		break;
> +	case 8001 ... 16000:
> +		*index =3D 3;
> +		break;
> +	default:
> +		/* Use max range for higher RPM */
> +		dev_warn(dev,
> +		    "RPM higher than supported range. Default to 16000 RPM");
> +		*index =3D 3;
>  	}
> -
> -	return 1; /* default: 4000 RPM */
> +	return 0;
>  }
> =20
>  static int max6639_init_client(struct i2c_client *client,
>  			       struct max6639_data *data)
>  {
> -	struct max6639_platform_data *max6639_info =3D
> -		dev_get_platdata(&client->dev);
> -	int i;
> -	int rpm_range =3D 1; /* default: 4000 RPM */
> -	int err;
> +	int i, err;
> +	struct pwm_state state;
> =20
>  	/* Reset chip to default values, see below for GCONFIG setup */
>  	err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> @@ -416,51 +445,29 @@ static int max6639_init_client(struct i2c_client *c=
lient,
>  	if (err)
>  		goto exit;
> =20
> -	/* Fans pulse per revolution is 2 by default */
> -	if (max6639_info && max6639_info->ppr > 0 &&
> -			max6639_info->ppr < 5)
> -		data->ppr =3D max6639_info->ppr;
> -	else
> -		data->ppr =3D 2;
> -	data->ppr -=3D 1;
> -
> -	if (max6639_info)
> -		rpm_range =3D rpm_range_to_reg(max6639_info->rpm_range);
> -	data->rpm_range =3D rpm_range;
> -
>  	for (i =3D 0; i < 2; i++) {
> =20
>  		/* Set Fan pulse per revolution */
> -		err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_FAN_PPR(i),
> -				data->ppr << 6);
> +		err =3D i2c_smbus_write_byte_data(client,	MAX6639_REG_FAN_PPR(i),
> +						data->ppr[i] << 6);
>  		if (err)
>  			goto exit;
> =20
>  		/* Fans config PWM, RPM */
>  		err =3D i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_CONFIG1(i),
> -			MAX6639_FAN_CONFIG1_PWM | rpm_range);
> -		if (err)
> -			goto exit;
> -
> -		/* Fans PWM polarity high by default */
> -		if (max6639_info && max6639_info->pwm_polarity =3D=3D 0)
> -			err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> -		else
> -			err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> +						MAX6639_REG_FAN_CONFIG1(i),
> +						MAX6639_FAN_CONFIG1_PWM |
> +						data->rpm_range[i]);
>  		if (err)
>  			goto exit;
> =20
>  		/*
> -		 * /THERM full speed enable,
> +		 * /THERM full speed disable,
>  		 * PWM frequency 25kHz, see also GCONFIG below
>  		 */
>  		err =3D i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_CONFIG3(i),
> -			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
> +						MAX6639_REG_FAN_CONFIG3(i),
> +						0x03);
>  		if (err)
>  			goto exit;
> =20
> @@ -469,31 +476,35 @@ static int max6639_init_client(struct i2c_client *c=
lient,
>  		data->temp_alert[i] =3D 90;
>  		data->temp_ot[i] =3D 100;
>  		err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_THERM_LIMIT(i),
> -				data->temp_therm[i]);
> +						MAX6639_REG_THERM_LIMIT(i),
> +						data->temp_therm[i]);
>  		if (err)
>  			goto exit;
>  		err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_ALERT_LIMIT(i),
> -				data->temp_alert[i]);
> +						MAX6639_REG_ALERT_LIMIT(i),
> +						data->temp_alert[i]);
>  		if (err)
>  			goto exit;
>  		err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
> +						MAX6639_REG_OT_LIMIT(i),
> +						data->temp_ot[i]);
>  		if (err)
>  			goto exit;
> =20
> -		/* PWM 120/120 (i.e. 100%) */
> -		data->pwm[i] =3D 120;
> -		err =3D i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
> +		/* Configure PWM controller */
> +		pwm_get_state(data->pwmd[i], &state);
> +		pwm_set_relative_duty_cycle(&state, data->target_rpm[i],
> +					    data->max_rpm[i]);
> +		err =3D pwm_apply_state(data->pwmd[i], &state);
>  		if (err)
>  			goto exit;
> +
>  	}
>  	/* Start monitoring */
>  	err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
>  		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
>  		MAX6639_GCONFIG_PWM_FREQ_HI);
> +
>  exit:
>  	return err;
>  }
> @@ -524,12 +535,276 @@ static void max6639_regulator_disable(void *data)
>  	regulator_disable(data);
>  }
> =20
> +static int max6639_probe_child_from_dt(struct i2c_client *client,
> +				      struct device_node *child,
> +				      struct max6639_data *data)
> +
> +{
> +	struct device *dev =3D &client->dev;
> +	u32 i, maxrpm;
> +	int val, err;
> +
> +	err =3D of_property_read_u32(child, "reg", &i);
> +	if (err) {
> +		dev_err(dev, "missing reg property of %pOFn\n", child);
> +		return err;
> +	}
> +
> +	if (i >=3D 2) {
> +		dev_err(dev, "invalid reg %d of %pOFn\n", i, child);
> +		return -EINVAL;
> +	}
> +
> +	err =3D of_property_read_u32(child, "pulses-per-revolution", &val);
> +	if (err) {
> +		dev_err(dev, "missing pulses-per-revolution property of %pOFn",
> +			child);
> +		return err;
> +	}
> +
> +	if (val < 0 || val > 5) {
> +		dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val,
> +			child);
> +		return -EINVAL;
> +	}
> +	data->ppr[i] =3D val;
> +
> +	err =3D of_property_read_u32(child, "max-rpm", &maxrpm);
> +	if (err) {
> +		dev_err(dev, "missing max-rpm property of %pOFn\n", child);
> +		return err;
> +	}
> +
> +	err =3D rpm_range_to_index(dev, &data->rpm_range[i], maxrpm);
> +	if (err) {
> +		dev_err(dev, "invalid max-rpm %d of %pOFn\n", maxrpm, child);
> +		return err;
> +	}
> +	data->max_rpm[i] =3D maxrpm;
> +
> +	err =3D of_property_read_u32(child, "target-rpm", &val);
> +	/* Use provided target RPM else default to maxrpm */
> +	if (!err)
> +		data->target_rpm[i] =3D val;
> +	else
> +		data->target_rpm[i] =3D maxrpm;
> +
> +	/* Get pwms property for PWM control */
> +	data->pwmd[i] =3D devm_fwnode_pwm_get(dev, &child->fwnode, NULL);
> +
> +	if (!IS_ERR(data->pwmd[i]))
> +		return 0;
> +
> +	if (PTR_ERR(data->pwmd[i]) =3D=3D -EPROBE_DEFER)
> +		return PTR_ERR(data->pwmd[i]);
> +
> +	dev_dbg(dev, "Using chip default PWM");
> +	data->pwmd[i] =3D pwm_request_from_chip(&data->chip, i, NULL);
> +	if (!IS_ERR(data->pwmd[i]))
> +		return 0;

Are these PWMs usuable at all for a consumer other than the driver
itself? If not I'd doubt the added value of this patch.

> +	dev_dbg(dev, "Failed to configure pwm for fan %d", i);
> +	return PTR_ERR_OR_ZERO(data->pwmd[i]);
> +}
> +
> +static int max6639_probe_from_dt(struct i2c_client *client,
> +				 struct max6639_data *data)
> +{
> +	struct device *dev =3D &client->dev;
> +	const struct device_node *np =3D dev->of_node;
> +	struct device_node *child;
> +	int err;
> +
> +	/* Compatible with non-DT platforms */
> +	if (!np)
> +		return 0;
> +
> +	for_each_child_of_node(np, child) {
> +		if (strcmp(child->name, "fan"))
> +			continue;
> +
> +		err =3D max6639_probe_child_from_dt(client, child, data);
> +		if (err) {
> +			of_node_put(child);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct max6639_data *to_max6639_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct max6639_data, chip);
> +}
> +
> +static void max6639_pwm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +
> +	struct max6639_data *data =3D to_max6639_pwm(chip);
> +	struct i2c_client *client =3D data->client;
> +	int value, i =3D pwm->hwpwm, x;

Please use pwm->hwpwm directly instead of i, this makes the code IMHO a
bit more readable.

> +	unsigned int freq;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	value =3D i2c_smbus_read_byte_data(client, MAX6639_REG_FAN_CONFIG1(i));
> +	if (value < 0)
> +		goto abort;
> +
> +	if (value & MAX6639_FAN_CONFIG1_PWM) {
> +		state->enabled =3D true;
> +
> +		/* Determine frequency from respective registers */
> +		value =3D i2c_smbus_read_byte_data(client,
> +						 MAX6639_REG_FAN_CONFIG3(i));
> +		if (value < 0)
> +			goto abort;
> +		x =3D value & MAX6639_FAN_CONFIG3_FREQ_MASK;
> +
> +		value =3D i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> +		if (value < 0)
> +			goto abort;
> +		if (value & MAX6639_GCONFIG_PWM_FREQ_HI)
> +			x |=3D 0x4;
> +		x &=3D 0x7;
> +		freq =3D freq_table[x];
> +
> +		state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);

both NSEC_PER_SEC and freq fit into an unsigned int, so you can use the
(cheaper) DIV_ROUND_UP here.

> +
> +		value =3D i2c_smbus_read_byte_data(client,
> +						 MAX6639_REG_TARGTDUTY(i));
> +		if (value < 0)
> +			goto abort;
> +		/* max6639 supports 120 slots only */
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(value * state->period,
> +						     120);

s/120/MAX6639_REG_TARGTDUTY_SLOT/ ?

value * state->period might overflow. Use something like
mul_u64_u32_div. (Hmm, there doesn't seem to be a variant for unsigned *
unsigned / unsigned?)

You're loosing precision here. Consider freq =3D 8333 and TARGTDUTY =3D 97
then you have state->period =3D 120005 and calulate duty_cycle as:

	DIV_ROUND_UP_ULL(97 * 120005, 120) =3D 97005

=2E The exact value is (I guess)

	97 * NSEC_PER_SEC / (8333 * 120) =3D 97003.880

> +		value =3D i2c_smbus_read_byte_data(client,
> +						 MAX6639_REG_FAN_CONFIG2a(i));
> +		if (value < 0)
> +			goto abort;
> +		value &=3D MAX6639_REG_FAN_CONFIG2a_PWM_POL;
> +		state->polarity =3D (value !=3D 0);
> +	} else
> +		state->enabled =3D false;
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +
> +}
> +
> +static int max6639_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct max6639_data *data =3D to_max6639_pwm(chip);
> +	struct i2c_client *client =3D data->client;
> +	int value =3D 0, i =3D pwm->hwpwm, x;

Please use pwm->hwpwm directly instead of i, this makes the code IMHO a
bit more readable.

> +	unsigned int freq;
> +	struct pwm_state cstate;
> +
> +	pwm_get_state(pwm, &cstate);

Please don't use pwm API functions in PWM callbacks. Accessing
pwm->state is fine here.

> +	mutex_lock(&data->update_lock);
> +
> +	if (state->period !=3D cstate.period) {
> +		/* Configure frequency */
> +		freq =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, state->period);
> +		/* Chip supports limited number of frequency */
> +		for (x =3D 0; x < sizeof(freq_table); x++)
> +			if (freq < freq_table[x])
> +				break;

For state->period =3D 80000 we get:

	freq =3D 12500

and then x =3D 7 is picked while x =3D 6 would be an exact match.

I think you just need

	if (freq <=3D freq_table[x])

> +		value =3D i2c_smbus_read_byte_data(client,
> +						 MAX6639_REG_FAN_CONFIG3(i));
> +		if (value < 0)
> +			goto abort;
> +		value &=3D ~MAX6639_FAN_CONFIG3_FREQ_MASK;
> +		value |=3D (x & MAX6639_FAN_CONFIG3_FREQ_MASK);
> +		value =3D i2c_smbus_write_byte_data(client,
> +						  MAX6639_REG_FAN_CONFIG3(i),
> +						  value);
> +
> +		value =3D i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> +		if (value < 0)
> +			goto abort;
> +
> +		if ((value & MAX6639_GCONFIG_PWM_FREQ_HI) && (x >> 2))
> +			value &=3D ~MAX6639_GCONFIG_PWM_FREQ_HI;
> +		else
> +			value |=3D MAX6639_GCONFIG_PWM_FREQ_HI;
> +		value =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> +						  value);

Why does it depend on MAX6639_GCONFIG_PWM_FREQ_HI being already set if
you need to set it?

> +		if (value < 0)
> +			goto abort;
> +	}
> +
> +	/* Configure dutycycle */
> +	if (state->duty_cycle !=3D cstate.duty_cycle) {

That check is wrong if you go from

	.duty_cycle =3D 50000; .period =3D 200000

to

	.duty_cycle =3D 50000; .period =3D 100000


> +		value =3D DIV_ROUND_UP_ULL(
> +				state->duty_cycle * MAX6639_REG_TARGTDUTY_SLOT,
> +				state->period);

Please round down here. (And test with PWM_DEBUG which might have told
you given the right tests.) Also please use the real period to determine
the register value. (Otherwise for a request with

	.duty_cycle =3D 40000; .period =3D 150000

where a real period of 120004.8 ns is picked you get
MAX6639_REG_TARGTDUTY_SLOT =3D 32 which results in a duty cycle of
32001.28 ns, while with MAX6639_REG_TARGTDUTY_SLOT =3D 39 you'd get
39001.56 ns.

> +		value =3D i2c_smbus_write_byte_data(client,
> +						  MAX6639_REG_TARGTDUTY(i),
> +						  value);
> +		if (value < 0)
> +			goto abort;
> +	}
> +
> +	/* Configure polarity */
> +	if (state->polarity !=3D cstate.polarity) {
> +		value =3D i2c_smbus_read_byte_data(client,
> +						 MAX6639_REG_FAN_CONFIG2a(i));
> +		if (value < 0)
> +			goto abort;
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			value |=3D MAX6639_REG_FAN_CONFIG2a_PWM_POL;
> +		else
> +			value &=3D ~MAX6639_REG_FAN_CONFIG2a_PWM_POL;
> +		value =3D i2c_smbus_write_byte_data(client,
> +						  MAX6639_REG_FAN_CONFIG2a(i),
> +						  value);
> +		if (value < 0)
> +			goto abort;
> +	}
> +
> +	if (state->enabled =3D=3D cstate.enabled)
> +		goto abort;

Please use goto only for error handling.

> +
> +	value =3D i2c_smbus_read_byte_data(client, MAX6639_REG_FAN_CONFIG1(i));
> +	if (value < 0)
> +		goto abort;
> +	if (state->enabled)
> +		value |=3D MAX6639_FAN_CONFIG1_PWM;
> +	else
> +		value &=3D ~MAX6639_FAN_CONFIG1_PWM;
> +
> +	value =3D i2c_smbus_write_byte_data(client, MAX6639_REG_FAN_CONFIG1(i),
> +					  value);
> +	if (value < 0)
> +		goto abort;
> +	value =3D 0;
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +
> +	return value;
> +}
> +
> +static const struct pwm_ops max6639_pwm_ops =3D {
> +	.apply =3D max6639_pwm_apply,
> +	.get_state =3D max6639_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
>  static int max6639_probe(struct i2c_client *client)
>  {
>  	struct device *dev =3D &client->dev;
>  	struct max6639_data *data;
>  	struct device *hwmon_dev;
> -	int err;
> +	int err, i;
> =20
>  	data =3D devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
>  	if (!data)
> @@ -537,11 +812,26 @@ static int max6639_probe(struct i2c_client *client)
> =20
>  	data->client =3D client;
> =20
> +	/* Add PWM controller of max6639 */
> +	data->chip.dev =3D dev;
> +	data->chip.ops =3D &max6639_pwm_ops;
> +	data->chip.npwm =3D 2;
> +	data->chip.of_pwm_n_cells =3D 3;

Please drop this, of_pwmchip_add() overwrites it anyhow.

> +
> +	err =3D devm_pwmchip_add(dev, &data->chip);
> +	if (err < 0) {
> +		dev_err(dev, "failed to add PWM chip %d\n", err);

dev_err_probe please.

> +		return err;
> +	}
> +
>  	data->reg =3D devm_regulator_get_optional(dev, "fan");
>  	if (IS_ERR(data->reg)) {
> -		if (PTR_ERR(data->reg) !=3D -ENODEV)
> -			return PTR_ERR(data->reg);
> -
> +		if (PTR_ERR(data->reg) !=3D -ENODEV) {
> +			err =3D (int)PTR_ERR(data->reg);
> +			dev_warn(dev, "Failed looking up fan supply: %d\n",
> +				 err);

unrelated change. Also dev_probe_err is better suited here.

> +			return err;
> +		}
>  		data->reg =3D NULL;
>  	} else {
>  		/* Spin up fans */
> @@ -560,6 +850,22 @@ static int max6639_probe(struct i2c_client *client)
> =20
>  	mutex_init(&data->update_lock);
> =20
> +	/* Below are defaults leter overridden by DT properties */
> +	for (i =3D 0; i < 2; i++) {
> +		/* 4000 RPM */
> +		data->rpm_range[i] =3D 1;
> +		data->ppr[i] =3D 2;
> +		/* Max. temp. 80C/90C/100C */
> +		data->temp_therm[i] =3D 80;
> +		data->temp_alert[i] =3D 90;
> +		data->temp_ot[i] =3D 100;
> +	}
> +
> +	/* Probe from DT to get configuration */
> +	err =3D max6639_probe_from_dt(client, data);
> +	if (err)
> +		return err;
> +
>  	/* Initialize the max6639 chip */
>  	err =3D max6639_init_client(client, data);
>  	if (err < 0)
> @@ -571,6 +877,7 @@ static int max6639_probe(struct i2c_client *client)
>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
> =20
> +#if IS_ENABLED(CONFIG_PM_SLEEP)

unrelated change

>  static int max6639_suspend(struct device *dev)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
> @@ -608,6 +915,7 @@ static int max6639_resume(struct device *dev)
>  	return i2c_smbus_write_byte_data(client,
>  			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
>  }
> +#endif
> =20
>  static const struct i2c_device_id max6639_id[] =3D {
>  	{"max6639", 0},
> @@ -616,13 +924,22 @@ static const struct i2c_device_id max6639_id[] =3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, max6639_id);
> =20
> -static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639=
_resume);
> +#ifdef CONFIG_OF

Note that ACPI also uses of_match_table.

> +static const struct of_device_id maxim_of_platform_match[] =3D {
> +	{.compatible =3D "maxim,max6639"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume=
);
> =20
>  static struct i2c_driver max6639_driver =3D {
>  	.class =3D I2C_CLASS_HWMON,
>  	.driver =3D {
>  		   .name =3D "max6639",
>  		   .pm =3D pm_sleep_ptr(&max6639_pm_ops),
> +		   .of_match_table =3D of_match_ptr(maxim_of_platform_match),
>  		   },
>  	.probe_new =3D max6639_probe,
>  	.id_table =3D max6639_id,

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jayssqa4c35myrxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNzxfsACgkQwfwUeK3K
7AnkdQf+MoKRKHFGemiqiDwNYKCjPlmTHMxadyTdmwl1hQOzaw/i8tXiZtjMil8w
v8a6utNqI2y2AlBrNiW7K2IUgxt22712EzVRajQbeVJZBuKSKpvmFVdapVugdQ+d
0/3T3Ijq6KB91roGGNNJAvh5I8oDEeZKfk/mV+U1yV5UTYFOhRCEIvRf6HjuRARn
+ySB0dRxsx2kgpgRKkszoCrTG4HeoG+dfAKYWIjQVuTrOpbSGRZRN8QBzjUxzBX4
8Z9dvkOq1owvGIPRMUDLLEyHqD48k07jZjVo9MHAbIDNmk89J58SbVoSirZsHL62
+MAGZdnvpRz3G39Lw/hVCcS3t9Jnyg==
=9lOc
-----END PGP SIGNATURE-----

--jayssqa4c35myrxt--
