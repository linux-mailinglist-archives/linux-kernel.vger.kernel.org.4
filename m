Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7D5F2401
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJBQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJBQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:09:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4EC27DFC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 09:09:28 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id f1WvoAgxknj75f1WvoHEv7; Sun, 02 Oct 2022 18:09:26 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Oct 2022 18:09:26 +0200
X-ME-IP: 86.243.100.34
Message-ID: <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
Date:   Sun, 2 Oct 2022 18:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Content-Language: fr
To:     cmo@melexis.com
Cc:     andy.shevchenko@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1663834141.git.cmo@melexis.com>
 <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/09/2022 à 10:13, cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org a écrit :
> From: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
> 
> The sensor can operate in lower power modes and even make measurements when
> in those lower powered modes. The decision was taken that if measurement
> is not requested within 2 seconds the sensor will remain in SLEEP_STEP
> power mode, where measurements are triggered on request with setting the
> start of measurement bit (SOB). In this mode the measurements are taking
> a bit longer because we need to start it and complete it. Currently, in
> continuous mode we read ready data and this mode is activated if sensor
> measurement is requested within 2 seconds. The suspend timeout is
> increased to 6 seconds (instead of 3 before), because that enables more
> measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> rate (2 seconds).

Hi,

should there be a v7, a few nitpick below.

> 
> Signed-off-by: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/iio/temperature/mlx90632.c | 379 +++++++++++++++++++++++------
>   1 file changed, 309 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 549c0ab5c2be..71130d237a69 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -6,11 +6,14 @@
>    *
>    * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
>    */
> +#include <linux/bitfield.h>
>   #include <linux/delay.h>
> +#include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
>   #include <linux/iopoll.h>
> +#include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/limits.h>
>   #include <linux/mod_devicetable.h>
> @@ -55,6 +58,12 @@
>   #define MLX90632_EE_Ha		0x2481 /* Ha customer calib value reg 16bit */
>   #define MLX90632_EE_Hb		0x2482 /* Hb customer calib value reg 16bit */
>   
> +#define MLX90632_EE_MEDICAL_MEAS1      0x24E1 /* Medical measurement 1 16bit */
> +#define MLX90632_EE_MEDICAL_MEAS2      0x24E2 /* Medical measurement 2 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS1     0x24F1 /* Extended measurement 1 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS2     0x24F2 /* Extended measurement 2 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS3     0x24F3 /* Extended measurement 3 16bit */
> +
>   /* Register addresses - volatile */
>   #define MLX90632_REG_I2C_ADDR	0x3000 /* Chip I2C address register */
>   
> @@ -62,13 +71,16 @@
>   #define MLX90632_REG_CONTROL	0x3001 /* Control Register address */
>   #define   MLX90632_CFG_PWR_MASK		GENMASK(2, 1) /* PowerMode Mask */
>   #define   MLX90632_CFG_MTYP_MASK		GENMASK(8, 4) /* Meas select Mask */
> +#define   MLX90632_CFG_SOB_MASK BIT(11)
>   
>   /* PowerModes statuses */
>   #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
>   #define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
> -#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step*/
> +#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step */
>   #define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
> -#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
> +#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
> +
> +#define MLX90632_EE_RR GENMASK(10, 8) /* Only Refresh Rate bits */
>   
>   /* Measurement types */
>   #define MLX90632_MTYP_MEDICAL 0
> @@ -116,8 +128,9 @@
>   #define MLX90632_REF_12 	12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
>   #define MLX90632_REF_3		12LL /* ResCtrlRef value of Channel 3 */
>   #define MLX90632_MAX_MEAS_NUM	31 /* Maximum measurements in list */
> -#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
> +#define MLX90632_SLEEP_DELAY_MS 6000 /* Autosleep delay */
>   #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
> +#define MLX90632_MEAS_MAX_TIME 2000 /* Max measurement time in ms for the lowest refresh rate */
>   
>   /**
>    * struct mlx90632_data - private data for the MLX90632 device
> @@ -130,6 +143,9 @@
>    * @object_ambient_temperature: Ambient temperature at object (might differ of
>    *                              the ambient temperature of sensor.
>    * @regulator: Regulator of the device
> + * @powerstatus: Current POWER status of the device
> + * @interaction_ts: Timestamp of the last temperature read that is used
> + *		    for power management in jiffies
>    */
>   struct mlx90632_data {
>   	struct i2c_client *client;
> @@ -139,6 +155,8 @@ struct mlx90632_data {
>   	u8 mtyp;
>   	u32 object_ambient_temperature;
>   	struct regulator *regulator;
> +	int powerstatus;
> +	unsigned long interaction_ts;
>   };
>   
>   static const struct regmap_range mlx90632_volatile_reg_range[] = {
> @@ -158,6 +176,8 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
>   	regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
>   	regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
>   	regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
> +	regmap_reg_range(MLX90632_EE_MEDICAL_MEAS1, MLX90632_EE_MEDICAL_MEAS2),
> +	regmap_reg_range(MLX90632_EE_EXTENDED_MEAS1, MLX90632_EE_EXTENDED_MEAS3),
>   	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
>   	regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
>   	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
> @@ -198,16 +218,38 @@ static const struct regmap_config mlx90632_regmap = {
>   
>   static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)

Not related to this patch, but why s32 and not int?
It would be more in line with places where this function is used.

>   {
> -	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> -				  MLX90632_CFG_PWR_MASK,
> -				  MLX90632_PWR_STATUS_SLEEP_STEP);
> +	struct mlx90632_data *data =
> +		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> +	s32 ret;
> +
> +	if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> +		return 0;
> +
> +	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL, MLX90632_CFG_PWR_MASK,
> +				MLX90632_PWR_STATUS_SLEEP_STEP);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> +	return ret;

return 0; ?

>   }
>   
>   static s32 mlx90632_pwr_continuous(struct regmap *regmap)

Not related to this patch, but why s32 and not int?
It would be more in line with places where this function is used.

>   {
> -	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> -				  MLX90632_CFG_PWR_MASK,
> -				  MLX90632_PWR_STATUS_CONTINUOUS);
> +	struct mlx90632_data *data =
> +		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> +	s32 ret;
> +
> +	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
> +		return 0;
> +
> +	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL, MLX90632_CFG_PWR_MASK,
> +				MLX90632_PWR_STATUS_CONTINUOUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
> +	return ret;

return 0; ?

>   }
>   
>   /**
> @@ -219,6 +261,63 @@ static void mlx90632_reset_delay(void)
>   	usleep_range(150, 200);
>   }
>   
> +static int mlx90632_get_measurement_time(struct regmap *regmap, u16 meas)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, meas, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return MLX90632_MEAS_MAX_TIME >> FIELD_GET(MLX90632_EE_RR, reg);
> +}
> +
> +static int mlx90632_calculate_dataset_ready_time(struct mlx90632_data *data)
> +{
> +	unsigned int refresh_time;
> +	int ret;
> +
> +	if (data->mtyp == MLX90632_MTYP_MEDICAL) {
> +		ret = mlx90632_get_measurement_time(data->regmap,
> +						    MLX90632_EE_MEDICAL_MEAS1);
> +		if (ret < 0)
> +			return ret;
> +
> +		refresh_time = ret;
> +
> +		ret = mlx90632_get_measurement_time(data->regmap,
> +						    MLX90632_EE_MEDICAL_MEAS2);
> +		if (ret < 0)
> +			return ret;
> +
> +		refresh_time += ret;
> +	} else {
> +		ret = mlx90632_get_measurement_time(data->regmap,
> +						    MLX90632_EE_EXTENDED_MEAS1);
> +		if (ret < 0)
> +			return ret;
> +
> +		refresh_time = ret;
> +
> +		ret = mlx90632_get_measurement_time(data->regmap,
> +						    MLX90632_EE_EXTENDED_MEAS2);
> +		if (ret < 0)
> +			return ret;
> +
> +		refresh_time += ret;
> +
> +		ret = mlx90632_get_measurement_time(data->regmap,
> +						    MLX90632_EE_EXTENDED_MEAS3);
> +		if (ret < 0)
> +			return ret;
> +
> +		refresh_time += ret;
> +	}
> +
> +	return refresh_time;
> +}
> +
>   /**
>    * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
>    * @data: pointer to mlx90632_data object containing regmap information
> @@ -249,26 +348,75 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
>   	return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
>   }
>   
> -static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
> +/**
> + * mlx90632_perform_measurement_burst() - Trigger and retrieve current measurement
> + * cycle in step sleep mode
> + * @data: pointer to mlx90632_data object containing regmap information
> + *
> + * Perform a measurement and return 2 as measurement cycle position reported
> + * by sensor. This is a blocking function for amount dependent on the sensor
> + * refresh rate.
> + */
> +static int mlx90632_perform_measurement_burst(struct mlx90632_data *data)
>   {
> +	unsigned int reg_status;
>   	int ret;
>   
> -	if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
> -		return -EINVAL;
> +	ret = regmap_write_bits(data->regmap, MLX90632_REG_CONTROL,
> +				MLX90632_CFG_SOB_MASK, MLX90632_CFG_SOB_MASK);
> +	if (ret < 0)
> +		return ret;
>   
> -	ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
> +	ret = mlx90632_calculate_dataset_ready_time(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(ret); /* Wait minimum time for dataset to be ready */
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS,
> +				       reg_status,
> +				       (reg_status & MLX90632_STAT_BUSY) == 0,
> +				       10000, 100 * 10000);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "data not ready");
> +		return -ETIMEDOUT;

Why not "return ret;"?

> +	}
> +
> +	return 2;
> +}
> +
> +static int mlx90632_set_meas_type(struct mlx90632_data *data, u8 type)
> +{
> +	int current_powerstatus;
> +	int ret;
> +
> +	if (data->mtyp == type)
> +		return 0;
> +
> +	current_powerstatus = data->powerstatus;
> +	ret = mlx90632_pwr_continuous(data->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
>   	if (ret < 0)
>   		return ret;
>   
>   	mlx90632_reset_delay();
>   
> -	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +	ret = regmap_update_bits(data->regmap, MLX90632_REG_CONTROL,
>   				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
>   				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
>   	if (ret < 0)
>   		return ret;
>   
> -	return mlx90632_pwr_continuous(regmap);
> +	data->mtyp = type;
> +	data->powerstatus = MLX90632_PWR_STATUS_HALT;
> +
> +	if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> +		return mlx90632_pwr_set_sleep_step(data->regmap);
> +
> +	return mlx90632_pwr_continuous(data->regmap);
>   }
>   
>   static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
> @@ -355,11 +503,30 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>   	s32 ret, measurement;
>   
>   	mutex_lock(&data->lock);
> -	measurement = mlx90632_perform_measurement(data);
> -	if (measurement < 0) {
> -		ret = measurement;
> +	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> +	if (ret < 0)
> +		goto read_unlock;
> +
> +	switch (data->powerstatus) {
> +	case MLX90632_PWR_STATUS_CONTINUOUS:
> +		measurement = mlx90632_perform_measurement(data);

   ret = mlx90632_perform_measurement(data);
and
   measurement = ret;
on success would be less verbose (no need for {}, and save 1 LoC) and 
more in line with mlx90632_calculate_dataset_ready_time() above.

> +		if (measurement < 0) {
> +			ret = measurement;
> +			goto read_unlock;
> +		}
> +		break;
> +	case MLX90632_PWR_STATUS_SLEEP_STEP:
> +		measurement = mlx90632_perform_measurement_burst(data);

Same.

> +		if (measurement < 0) {
> +			ret = measurement;
> +			goto read_unlock;
> +		}
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
>   		goto read_unlock;
>   	}
> +
>   	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
>   					ambient_old_raw);
>   	if (ret < 0)
> @@ -441,14 +608,20 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>   	s32 ret, meas;
>   
>   	mutex_lock(&data->lock);
> -	ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
> +	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_EXTENDED);
>   	if (ret < 0)
>   		goto read_unlock;
>   
> -	ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> -				50000, 800000, false, data);
> -	if (ret != 0)
> -		goto read_unlock;
> +	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +		ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> +					50000, 800000, false, data);
> +		if (ret)
> +			goto read_unlock;
> +	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +		ret = mlx90632_perform_measurement_burst(data);
> +		if (ret < 0)
> +			goto read_unlock;
> +	}
>   
>   	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
>   	if (ret < 0)
> @@ -457,8 +630,6 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>   	ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
>   
>   read_unlock:
> -	(void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
> -
>   	mutex_unlock(&data->lock);
>   	return ret;
>   }
> @@ -743,12 +914,47 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>   	return ret;
>   }
>   
> +/**
> + * mlx90632_pm_interraction_wakeup() - Measure time between user interactions to change powermode
> + * @data: pointer to mlx90632_data object containing interaction_ts information
> + *
> + * Switch to continuous mode when interaction is faster than MLX90632_MEAS_MAX_TIME. Update the
> + * interaction_ts for each function call with the jiffies to enable measurement between function
> + * calls. Initial value of the interaction_ts needs to be set before this function call.
> + */
> +static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
> +{
> +	unsigned long now;
> +	int ret;
> +
> +	now = jiffies;
> +	if (time_in_range(now, data->interaction_ts,
> +			  data->interaction_ts +
> +			  msecs_to_jiffies(MLX90632_MEAS_MAX_TIME + 100))) {
> +		if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +			ret = mlx90632_pwr_continuous(data->regmap);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	data->interaction_ts = now;
> +
> +	return 0;
> +}
> +
>   static int mlx90632_read_raw(struct iio_dev *indio_dev,
>   			     struct iio_chan_spec const *channel, int *val,
>   			     int *val2, long mask)
>   {
>   	struct mlx90632_data *data = iio_priv(indio_dev);
>   	int ret;
> +	int cr;

This 'cr' seems to be unused.

> +
> +	pm_runtime_get_sync(&data->client->dev);
> +	ret = mlx90632_pm_interraction_wakeup(data);
> +	if (ret < 0)
> +		goto mlx90632_read_raw_pm;

[...]
