Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86646A1D88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBXOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBXOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:36:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7967997;
        Fri, 24 Feb 2023 06:36:42 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PNXTf6qvNz67CmC;
        Fri, 24 Feb 2023 22:34:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Feb
 2023 14:36:39 +0000
Date:   Fri, 24 Feb 2023 14:36:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        "Jagath Jog J" <jagathjog1996@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH] iio: Add some kerneldoc for channel types
Message-ID: <20230224143638.00003515@Huawei.com>
In-Reply-To: <10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com>
References: <10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 15:02:32 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> For occasional contributor like me navigating the IIO channel types and
> modifiers may be a daunting task. One may have hard time finding out
> what type of channel should be used for device data and what units the
> data should be converted.
> 
> There is a great documentation for the sysfs interfaces though. What is
> missing is mapping of the channel types and modifiers to the sysfs
> documentation (and entries in documentation).
> 
> Give a hand to a driver writer by providing some documentation and by
> pointing to the sysfs document from the kerneldocs of respective enums.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
+CC linux-iio

> ---
> Please note that this RFC patch should not be applied as is. The docs
> have TODO comments regarding units for IIO_ELECTRICALCONDUCTIVITY,
> IIO_PHASE and IIO_RESISTANCE. I'll fix these TODOs, remove RFC and respin
> if anyone familiar with the values provided via sysfs could provide me the
> corret units for these channels. I am also open to any suggestions how
> to better link from enum documentation to specific entry at the IIO sysfs
> documetation.
> 
> Initial discussion about these docs can be found from:
> https://lore.kernel.org/all/0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com/
> ---
>  include/uapi/linux/iio/types.h | 140 ++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index c79f2f046a0b..e6329d3cc055 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -10,7 +10,129 @@
>  
>  #ifndef _UAPI_IIO_TYPES_H_
>  #define _UAPI_IIO_TYPES_H_
> -
> +/**
> + * iio_chan_type - Type of data transferred via IIO channel.
> + *
> + * The 'main' type of data transferred via channel. Please note that most
> + * devices need to specify also a more accurate 'sub category'. See the
> + * enum iio_modifier for this. (For example, IIO_ACCEL channel often needs to
> + * specify the direction. IIO_CONCENTRATION specifies the type of substance
> + * it measures etc).
> + *
> + * Use of correct units is required but scale and offset that user must apply
> + * to channel values can be advertised.
> + *
> + * Please find the detailed documentation for reported values from the
> + * Documentation/ABI/testing/sysfs-bus-iio.
> + *
> + * IIO_ACCEL:		Acceleration, m/s^2
> + *			Doc keyword: in_accel_x_raw
> + *
> + * IIO_ACTIVITY:	Activity state. For example a pedometer signaling
> + *			jogging, walking or staying still.
> + *			Doc keyword: in_activity_still_thresh_rising_en
> + *
> + * IIO_ALTVOLTAGE:
> + *
> + * IIO_ANGL:		Angle of rotation, radians.
> + *			Doc keyword: in_angl_raw
> + *
> + * IIO_ANGL_VEL:	Angular velocity, rad/s
> + *			Doc keyword: in_anglvel_x_raw
> + *
> + * IIO_CAPACITANCE:	Capacitance, nanofarads.
> + *			Doc keyword: in_capacitanceY_raw
> + *
> + * IIO_CCT:
> + *
> + * IIO_CURRENT:		Current, milliamps
> + *			Doc keyword: in_currentY_raw
> + *
> + * IIO_CONCENTRATION:	Reading of a substance, percents. Used for example by
> + *			deviced measuring amount of CO2, O2, ethanol...
> + *			Doc keyword: in_concentration_raw
> + *
> + * IIO_COUNT:		Deprecated, please use counter subsystem.
> + *
> + * IIO_DISTANCE:	Distance in meters. Typically used to report measured
> + *			distance to an object or the distance covered by the
> + *			user
> + *			Doc keyword: in_distance_input
> + *
> + * IIO_ELECTRICALCONDUCTIVITY: electric conductivity, siemens per meter
> + *			Doc keyword: in_electricalconductivity_raw
> + *			TODO: What does "can be processed to siemens per meter"
> + *			mean? Do we have unit requirement?
> + *
> + * IIO_ENERGY:		Energy in Joules. Typically reported by a device
> + *			measuring energy burnt by the user.
> + *			Doc keyword: in_energy_input
> + *
> + * IIO_GRAVITY:		Gravity, m/s^2
> + *			Doc keyword: in_gravity_x_raw
> + *
> + * IIO_HUMIDITYRELATIVE: Relative humidity, percents
> + *			Doc keyword: in_humidityrelative_raw
> + *
> + * IIO_INCLI:		Inclination, degrees
> + *			Doc keyword: in_incli_x_raw
> + *
> + * IIO_INDEX:		Deprecated, please use Counter subsystem
> + *
> + * IIO_INTENSITY:	Unitless intensity.
> + *			Doc keyword: in_intensityY_raw
> + *
> + * IIO_LIGHT:		Visible light intensity, lux
> + *			Doc keyword: in_illuminance_raw
> + *
> + * IIO_MAGN:		Magnetic field, Gauss.
> + *			Doc keyword: in_magn_x_raw
> + *
> + * IIO_MASSCONCENTRATION: Mass concentration, ug / m3
> + *			Doc keyword: in_massconcentration_pm1_input
> + *
> + * IIO_PH:		pH reading, negative base-10 logarithm of hydrodium
> + *			ions in a litre of water
> + *			Doc keyword: in_ph_raw
> + *
> + * IIO_PHASE:		Phase difference, radians
> + *			Doc keyword: in_phaseY_raw
> + *			TODO: What does "can be processed to radians" mean? Do
> + *			we have unit requirement?
> + *
> + * IIO_POSITIONRELATIVE: Relative position.
> + *			Doc keyword: in_positionrelative_x_raw
> + *
> + * IIO_POWER:		Power, milliwatts
> + *			Doc keyword: in_powerY_raw
> + *
> + * IIO_PRESSURE:	Pressure, kilopascal
> + *			Doc keyword: in_pressureY_raw
> + *
> + * IIO_RESISTANCE:	Resistance, ohms
> + *			Doc keyword: in_resistance_raw
> + *			TODO: What means "can be processed..." Do we have unit
> + *			requirement?
> + *
> + * IIO_ROT:		Euler angles, deg
> + *			Doc keyword: in_rot_yaw_raw
> + *
> + * IIO_STEPS:		Steps taken by the user
> + *			Doc keyword: in_steps_input
> + *
> + * IIO_TEMP:		Temperature, milli degrees Celsius
> + *			Doc keyword: in_temp_raw
> + *
> + * IIO_UVINDEX:		UV light intensity index
> + *			Doc keyword: in_uvindex_input
> + *
> + * IIO_VELOCITY:	Current speed (norm or magnitude of the velocity
> + *			vector), m/s
> + *			Doc keyword: in_velocity_sqrt(x^2+y^2+z^2)_input
> + *
> + * IIO_VOLTAGE:		Voltage, millivolts
> + *			Doc keyword: in_voltageY_raw
> + */
>  enum iio_chan_type {
>  	IIO_VOLTAGE,
>  	IIO_CURRENT,
> @@ -49,6 +171,22 @@ enum iio_chan_type {
>  	IIO_MASSCONCENTRATION,
>  };
>  
> +/**
> + * iio_modifier - accurate class for channel data
> + *
> + * IIO_MOD_<X,Y,Z>:	Value represents <X,Y,Z>-axis data.
> + *			Typically used by channels of type:
> + *			IIO_ACCEL, IIO_TEMP, IIO_GRAVITY, IIO_POSITIONRELATIVE,
> + *			IIO_ANGL_VEL, IIO_INCLI, IIO_MAGN
> + * IIO_MOD_LIGHT_BOTH:	Value contains visible and infra red light components
> + * IIO_MOD_LIGHT_IR:	Value represents infra-red radiation
> + * IIO_MOD_LIGHT_<RED, GREEN, BLUE>:
> + *			Value represents visible <red, green, blue>  light
> + * IIO_MOD_LIGHT_CLEAR:	Value represents all visible light frequencies
> + *
> + * Please find the detailed documentation for reported values from the
> + * Documentation/ABI/testing/sysfs-bus-iio.
> + */
>  enum iio_modifier {
>  	IIO_NO_MOD,
>  	IIO_MOD_X,
> 
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c

