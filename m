Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1426FBC38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjEIA6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIA6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:58:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E7126B3;
        Mon,  8 May 2023 17:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683593872; i=w_armin@gmx.de;
        bh=MNjXHm47F7SMQlyP50lxTlLPOCbejrfPlEf154zoiEc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hY0vi0fYVvpHM0Sr/UShxaUzUurdChReHSxjjHtj/uo1P7McInI9cIP17gw+uqLAg
         Ps2aDwwyrNeQg6P1ZooUaPTRcbIoOWE61TaxpCeMkHANhWHXYwIZi0BL0w7KecrKvi
         sJganRoMg2cUgR+49EfI2MuvSzf6fEi+GjkoZNWjs1FHS8IzVEOIaH9c6RQYFIFH3z
         GO7rjN9BbkCXrICU//JCXEhD8bky5kOyBYF9TZZQ9R7crfChWMLNFuVM/pF5fAX+LT
         FtkZKUDv6lVX9XSYv5xFXvZvzDEreJLWC5jjp9SajJaBR0mwxdzPeWKVnWmR5k2SFE
         +CMKc3Q4r90Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1qN6CA0rw2-010JEa; Tue, 09
 May 2023 02:57:52 +0200
Subject: Re: [PATCHv2 3/6] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
To:     dinh.nguyen@linux.intel.com, linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
 <20230508212852.8413-3-dinh.nguyen@linux.intel.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <4aa37522-9072-ac8d-0ba7-c2234c3228bc@gmx.de>
Date:   Tue, 9 May 2023 02:57:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230508212852.8413-3-dinh.nguyen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:927AKTC+xgO1vbAVjkAx0mBna0Jm9MvzadXzmSOHjmNsy8cGobV
 e+s92kBY7TNmWTXVkMxVbrKH8PCxRwLZRUxG68o67E77/OfBah+GfEpBXvv8tAP4fR+PH/c
 FoOZaBFRTtx8ESQYlWWf7YMv6gfe2gDkaJyWExsyTRxu2SkndrSWQ72n2HWmdLravdivQYz
 w5eNqaxDXXmMOB0/KUzvw==
UI-OutboundReport: notjunk:1;M01:P0:JR+ryY/kbRA=;f8W3IMcjOChKsn1Ca5O9TugFDpT
 sTaduEDbS4P5xaitr9hZDmtm/QTmffxaOkBvP11mBuOL5DXPlNnIot9ldk2Yu/+zHNoBt3eB7
 DmScqafh6FbzIHkjPA/fIBPdOSdqm2l1Nou6jKjsyEE4D9JWdKPvUYpdhnCXTYu4NA48kesI2
 T4Wmr9YMAkbQeczHgk1uZjZjJgfOSxeiaew0kQtLPHo+tySbdQG6offGvzk8aVLMRmwLBTarQ
 D7b3qitQQFuqTeE3rNgbPpdFw/iHiZvSG52WdtjzpLVxKig3vo3Vnv2K+atdGPyPTu/VdDqBZ
 Bwa5BYG+0aMYMtzQ0cuILWbRZYZvg17mD3rl1Wo+5HoWTt+G3Gumw/9LJ5Sc0WBsgQdeYuUUL
 w3u7sulcGkABEx5OB9inSZv9pW8L9zqzC8bwsVk8lfHgsCn7oGApbffqK/mCmOncg23qZPqqi
 W86+dfKb6Wr4KRWm02/1Njve+OFcYpIZcLsYVrxhwlG0LTJHS5w8zUjs28/qDqCX5SWm3na9o
 lAieNXmPmy+Vrw6s7rLcD0d8xNWXSqqTmjBcmAkHrfBR0t/BWNBkv9ffjSKxscRgUG1/rNMEG
 syLVscj/sw4LlXWRVMErj3H65oFf5btgkY5Z6Aao71R175vURayf0CVUQnH28E0ZEjKdbk5UC
 lMEr0LiJycF/A2gjKizPA6dv7Qbf8uTZjfQ2X9IfauOfPdo/zktqshp3pQ5zLJpOgQN51ve9M
 jqSYjWS6gwZu5yeAtZj44svfG7hEkYqwX7nBzf7vPKsXliJMp0PeqHj666khJTP/NKpfWzD3g
 REyOZ9LNfnby79BaIoW/AYtZfPcR1E6/ICXrUihxZEhTBBclZ3/Vdc4z7ikU2LSmF010MZ9J8
 nei3WtmXI3hFW5LNCEh1I4hZGgbR2guwYK1X663d9X+DYsYGCN2+/liuwckzohrB8deZ26vld
 ZWomwh7b2/ryLSFjLaxKzTvF+is=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.05.23 um 23:28 schrieb dinh.nguyen@linux.intel.com:

> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>
> The driver supports 64-bit SoCFPGA platforms for temperature and voltage
> reading using the platform's SDM(Secure Device Manager). The driver
> also uses the Stratix10 Service layer driver.
>
> This driver only supports OF SoCFPGA 64-bit platforms.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> ---
> v2: clean up race conditions in probe/remove functions
>      move changes in service driver to a separate patch
>      fix undefined 'ret' value in socfpga_read()
>      fix up socfpga_hwmon_err_to_errno() to handle signed integer
>      add platform specific dts binding
> ---
>   Documentation/hwmon/index.rst         |   1 +
>   Documentation/hwmon/socfpga-hwmon.rst |  30 ++
>   drivers/hwmon/Kconfig                 |  11 +
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/socfpga-hwmon.c         | 408 ++++++++++++++++++++++++++
>   5 files changed, 451 insertions(+)
>   create mode 100644 Documentation/hwmon/socfpga-hwmon.rst
>   create mode 100644 drivers/hwmon/socfpga-hwmon.c
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> index f1fe75f596a5..9db4e1537481 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -196,6 +196,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47b397
>      smsc47m192
>      smsc47m1
> +   socfpga-hwmon
>      sparx5-temp
>      stpddc60
>      sy7636a-hwmon
> diff --git a/Documentation/hwmon/socfpga-hwmon.rst b/Documentation/hwmon=
/socfpga-hwmon.rst
> new file mode 100644
> index 000000000000..f6565c83cf40
> --- /dev/null
> +++ b/Documentation/hwmon/socfpga-hwmon.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver socfpga-hwmon
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Supported chips:
> +
> + * Intel Stratix10
> + * Intel Agilex
> + * Intel N5X
> +
> +Author: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for 64-Bit SoCFPGA and eASIC d=
evices
> +based around the Secure Device Manager and Stratix 10 Service layer.
> +
> +The following sensor types are supported:
> +
> +  * temperature
> +  * voltage
> +
> +Usage Notes
> +-----------
> +
> +The driver relies on a device tree node to enumerate support present on=
 the
> +specific device. See Documentation/devicetree/bindings/hwmon/intel,socf=
pga-hwmon.yaml
> +for details of the device-tree node.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..c7c978acfece 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1875,6 +1875,17 @@ config SENSORS_SMSC47M192
>   	  This driver can also be built as a module. If so, the module
>   	  will be called smsc47m192.
>
> +config SENSORS_SOCFPGA
> +	tristate "SoCFPGA Hardware monitoring features"
> +	depends on INTEL_STRATIX10_SERVICE
> +	depends on OF || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for the temperature and
> +	  voltage sensors of 64-bit SoCFPGA devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called socfpga-hwmon.
> +
>   config SENSORS_SMSC47B397
>   	tristate "SMSC LPC47B397-NC"
>   	depends on !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..c04c0b2578a4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -193,6 +193,7 @@ obj-$(CONFIG_SENSORS_SMPRO)	+=3D smpro-hwmon.o
>   obj-$(CONFIG_SENSORS_SMSC47B397)+=3D smsc47b397.o
>   obj-$(CONFIG_SENSORS_SMSC47M1)	+=3D smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+=3D smsc47m192.o
> +obj-$(CONFIG_SENSORS_SOCFPGA)	+=3D socfpga-hwmon.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+=3D sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+=3D stts751.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+=3D sy7636a-hwmon.o
> diff --git a/drivers/hwmon/socfpga-hwmon.c b/drivers/hwmon/socfpga-hwmon=
.c
> new file mode 100644
> index 000000000000..01bdefa62b7f
> --- /dev/null
> +++ b/drivers/hwmon/socfpga-hwmon.c
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SoCFPGA hardware monitoring features
> + *
> + * Copyright (c) 2023 Intel Corporation. All rights reserved
> + */
> +#include <linux/arm-smccc.h>
> +#include <linux/hwmon.h>
> +#include <linux/firmware/intel/stratix10-svc-client.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +
> +#define HWMON_TIMEOUT	msecs_to_jiffies(SVC_HWMON_REQUEST_TIMEOUT_MS)
> +
> +/*
> + * Selected temperature sensor channel is currently inactive.
> + * Ensure that the tile where the TSD is located is actively in use.
> + */
> +#define ETEMP_INACTIVE		0
> +/*
> + * Selected temperature sensor channel returned a value that is not the
> + * latest reading. Try retrieve the temperature reading again.
> + */
> +#define ETEMP_TOO_OLD		1
> +/*
> + * Selected temperature sensor channel is invalid for the device. Ignor=
e
> + * the returned data because the temperature sensor channel location is
> + * invalid.
> + */
> +#define ETEMP_NOT_PRESENT	2
> +/*
> + * System is corrupted or failed to respond.
> + */
> +#define ETEMP_TIMEOUT		3
> +#define ETEMP_CORRUPT		4
> +/*
> + * Communication mechanism is busy.
> + */
> +#define ETEMP_BUSY		5
> +/*
> + * System is corrupted or failed to respond.
> + */
> +#define ETEMP_NOT_INITIALIZED	255
> +
> +#define SOCFPGA_HWMON_ERR_MAX	-2147483648
> +
> +#define SOCFPGA_HWMON_MAXSENSORS	16
> +
> +/**
> + * struct socfpga_hwmon_chan - channel input parameters.
> + * @n : Number of channels.
> + * @value: value read from the chip.
> + * @names: names array from DTS labels.
> + * @chan: channel array.
> + *
> + * The structure represents either the voltage or temperature informati=
on
> + * for the hwmon channels.
> + */
> +struct socfpga_hwmon_chan {
> +	unsigned int n;

Hi,

renaming n to something like sensor_count would allow other people
to immediately understand what n does.

> +	int value;
> +	const char *names[SOCFPGA_HWMON_MAXSENSORS];
> +	u32 chan[SOCFPGA_HWMON_MAXSENSORS];
> +};
> +
> +struct socfpga_hwmon_priv {
> +	struct device *hwmon_dev;
> +	struct stratix10_svc_client client;
> +	struct stratix10_svc_client_msg msg;
> +	struct stratix10_svc_chan *chan;
> +	struct completion completion;
> +	struct mutex lock; /* lock for reading the hardware volts/temps */
> +	struct socfpga_hwmon_chan temperature;
> +	struct socfpga_hwmon_chan voltage;
> +};
> +
> +enum hwmon_type_op {
> +	SOCFPGA_HWMON_TYPE_TEMP,
> +	SOCFPGA_HWMON_TYPE_VOLT
> +};
> +
> +static const char *const hwmon_types_str[] =3D { "temperature", "voltag=
e" };
> +
> +static umode_t socfpga_is_visible(const void *dev,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int chan)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +	case hwmon_in:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}

socfpga_is_visible() should actually check the number of temp/voltage chan=
nels ("n")
discovered over dt, and return 0 if a channel does not exist. Otherwise so=
cfpga_read()
could access temperature.chan[channel] and voltage.chan[channel] with "cha=
nnel" being
out-of-bounds and chan[channel] still being zero from devm_kzalloc().
Something similar would happen in socfpga_read_string().

> +
> +static void socfpga_smc_callback(struct stratix10_svc_client *client,
> +				 struct stratix10_svc_cb_data *data)
> +{
> +	struct socfpga_hwmon_priv *priv =3D client->priv;
> +	struct arm_smccc_res *res =3D data->kaddr1;
> +
> +	if (data->status =3D=3D BIT(SVC_STATUS_OK))	{
> +		if (priv->msg.command =3D=3D COMMAND_HWMON_READTEMP)
> +			priv->temperature.value =3D res->a0;
> +		else
> +			priv->voltage.value =3D res->a0;
> +	} else {
> +		dev_err(client->dev, "%s returned 0x%lX\n", __func__, res->a0);
> +	}
> +
> +	complete(&priv->completion);
> +}
> +
> +static int socfpga_hwmon_send(struct socfpga_hwmon_priv *priv)
> +{
> +	int ret;
> +
> +	priv->client.receive_cb =3D socfpga_smc_callback;
> +
> +	ret =3D stratix10_svc_send(priv->chan, &priv->msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!wait_for_completion_timeout(&priv->completion, HWMON_TIMEOUT)) {
> +		dev_err(priv->client.dev, "SMC call timeout!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv *priv)
> +{
> +	int value =3D priv->temperature.value;
> +	int err;
> +
> +	if (value >=3D SOCFPGA_HWMON_ERR_MAX)
> +		return 0;
> +
> +	err =3D abs(SOCFPGA_HWMON_ERR_MAX - value);
> +	switch (err) {
> +	case ETEMP_NOT_PRESENT:
> +		return -ENOENT;
> +	case ETEMP_CORRUPT:
> +	case ETEMP_NOT_INITIALIZED:
> +		return -ENODATA;
> +	case ETEMP_BUSY:
> +		return -EBUSY;
> +	case ETEMP_INACTIVE:
> +	case ETEMP_TIMEOUT:
> +	case ETEMP_TOO_OLD:
> +		return -EAGAIN;
> +	default:
> +		/* Unknown error */
> +		return -EIO;
> +	}
> +}
> +
> +static int socfpga_read(struct device *dev, enum hwmon_sensor_types typ=
e,
> +			u32 attr, int chan, long *val)
> +{
> +	struct socfpga_hwmon_priv *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	reinit_completion(&priv->completion);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		priv->msg.arg[0] =3D BIT_ULL(priv->temperature.chan[chan]);
> +		priv->msg.command =3D COMMAND_HWMON_READTEMP;
> +		ret =3D socfpga_hwmon_send(priv);
> +		if (ret)
> +			goto status_done;
> +
> +		ret =3D socfpga_hwmon_err_to_errno(priv);
> +		if (ret)
> +			break;
> +		/*
> +		 * The Temperature Sensor IP core returns the Celsius
> +		 * temperature value in signed 32-bit fixed point binary
> +		 * format, with eight bits below binary point.
> +		 */
> +		*val =3D (priv->temperature.value * MILLIDEGREE_PER_DEGREE) / 256;
> +		break;
> +	case hwmon_in:
> +		priv->msg.arg[0] =3D BIT_ULL(priv->voltage.chan[chan]);
> +		priv->msg.command =3D COMMAND_HWMON_READVOLT;
> +		ret =3D socfpga_hwmon_send(priv);
> +		if (ret)
> +			goto status_done;
> +
> +		/*
> +		 * The Voltage Sensor IP core returns the sampled voltage
> +		 * in unsigned 32-bit fixed point binary format, with 16 bits
> +		 * below binary point.
> +		 */
> +		*val =3D (priv->voltage.value * MILLIVOLT_PER_VOLT) / 65536;
> +		break;
> +	default:
> +		ret =3D -EOPNOTSUPP;
> +		break;
> +	}
> +
> +status_done:
> +	stratix10_svc_done(priv->chan);
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static int socfpga_read_string(struct device *dev,
> +			       enum hwmon_sensor_types type, u32 attr,
> +			       int chan, const char **str)
> +{
> +	struct socfpga_hwmon_priv *priv =3D dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_in:
> +		*str =3D priv->voltage.names[chan];
> +		return 0;
> +	case hwmon_temp:
> +		*str =3D priv->temperature.names[chan];
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops socfpga_ops =3D {
> +	.is_visible =3D socfpga_is_visible,
> +	.read =3D socfpga_read,
> +	.read_string =3D socfpga_read_string,
> +};
> +
> +static const struct hwmon_channel_info *socfpga_info[] =3D {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL),
> +	NULL
> +};

With two sensors entries sharing a line, someone might accidentally think =
that the driver
supports only up to 8 temp/voltage channels instead of 16.

> +
> +static const struct hwmon_chip_info socfpga_chip_info =3D {
> +	.ops =3D &socfpga_ops,
> +	.info =3D socfpga_info,
> +};
> +
> +static int socfpga_add_channel(struct device *dev,  const char *type,
> +			       u32 val, const char *label,
> +			       struct socfpga_hwmon_priv *priv)
> +{
> +	int type_index;
> +	struct socfpga_hwmon_chan *p;
> +
> +	type_index =3D match_string(hwmon_types_str, ARRAY_SIZE(hwmon_types_st=
r), type);
> +	switch (type_index) {
> +	case SOCFPGA_HWMON_TYPE_TEMP:
> +		p =3D &priv->temperature;
> +		break;
> +	case SOCFPGA_HWMON_TYPE_VOLT:
> +		p =3D &priv->voltage;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +	if (p->n >=3D SOCFPGA_HWMON_MAXSENSORS)
> +		return -ENOSPC;
> +
> +	p->names[p->n] =3D label;
> +	p->chan[p->n] =3D val;
> +	p->n++;
> +
> +	return 0;
> +}
> +
> +static int socfpga_probe_child_from_dt(struct device *dev,
> +				       struct device_node *child,
> +				       struct socfpga_hwmon_priv *priv)
> +{
> +	struct device_node *grandchild;
> +	const char *label;
> +	const char *type;
> +	u32 val;
> +	int ret;
> +
> +	if (of_property_read_string(child, "name", &type))
> +		return dev_err_probe(dev, -EINVAL, "No type for %pOF\n", child);
> +
> +	for_each_child_of_node(child, grandchild) {
> +		ret =3D of_property_read_u32(grandchild, "reg", &val);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "missing reg property of %pOF\n",
> +					     grandchild);
> +
> +		ret =3D of_property_read_string(grandchild, "label", &label);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "missing label propoerty of %pOF\n",
> +					     grandchild);
> +		ret =3D socfpga_add_channel(dev, type, val, label, priv);
> +		if (ret =3D=3D -ENOSPC)
> +			return dev_err_probe(dev, ret, "too many channels, only %d supported=
\n",
> +					     SOCFPGA_HWMON_MAXSENSORS);
> +	}
> +	return 0;
> +}
> +
> +static int socfpga_probe_from_dt(struct device *dev,
> +				 struct socfpga_hwmon_priv *priv)
> +{
> +	const struct device_node *np =3D dev->of_node;
> +	struct device_node *child;
> +	int ret =3D 0;
> +
> +	for_each_child_of_node(np, child) {
> +		ret =3D socfpga_probe_child_from_dt(dev, child, priv);
> +		if (ret)
> +			break;
> +	}
> +	of_node_put(child);
> +
> +	return ret;
> +}
> +
> +static int socfpga_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct socfpga_hwmon_priv *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->client.dev =3D dev;
> +	priv->client.priv =3D priv;
> +
> +	ret =3D socfpga_probe_from_dt(dev, priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to probe from device tree\n");
> +
> +	mutex_init(&priv->lock);
> +	init_completion(&priv->completion);
> +	priv->chan =3D stratix10_svc_request_channel_byname(&priv->client,
> +							  SVC_CLIENT_HWMON);
> +	if (IS_ERR(priv->chan))
> +		return dev_err_probe(dev, PTR_ERR(priv->chan),
> +				     "couldn't get service channel %s\n",
> +				     SVC_CLIENT_RSU);

Could it be that stratix10_svc_free_channel() needs to be called if
devm_hwmon_device_register_with_info() fails?
In such a case devm_add_action_or_reset() would be useful.

> +
> +	priv->hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "socfpga=
hwmon",
> +							       priv,
> +							       &socfpga_chip_info,
> +							       NULL);
> +	if (IS_ERR(priv->hwmon_dev))
> +		return PTR_ERR(priv->hwmon_dev);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int socfpga_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct socfpga_hwmon_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	hwmon_device_unregister(priv->hwmon_dev);

The hwmon device registered with devm_hwmon_device_register_with_info() is
already cleaned-up by devres, hwmon_device_unregister() should not be call=
ed here.

> +	stratix10_svc_free_channel(priv->chan);

Using devm_add_action_or_reset() would allow for socfpga_hwmon_remove() to=
 be dropped.

Armin Wolf

> +	return 0;
> +}
> +
> +static const struct of_device_id socfpga_of_match[] =3D {
> +	{ .compatible =3D "intel,socfpga-hwmon" },
> +	{ .compatible =3D "intel,socfpga-agilex-hwmon" },
> +	{ .compatible =3D "intel,socfpga-n5x-hwmon" },
> +	{ .compatible =3D "intel,socfpga-stratix10-hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, socfpga_of_match);
> +
> +static struct platform_driver socfpga_hwmon_driver =3D {
> +	.driver =3D {
> +		.name =3D "socfpga-hwmon",
> +		.of_match_table =3D socfpga_of_match,
> +	},
> +	.probe =3D socfpga_hwmon_probe,
> +	.remove =3D socfpga_hwmon_remove,
> +};
> +module_platform_driver(socfpga_hwmon_driver);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("SoCFPGA hardware monitoring features");
> +MODULE_LICENSE("GPL");
