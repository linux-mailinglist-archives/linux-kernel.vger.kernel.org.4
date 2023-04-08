Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49306DBA01
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjDHKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHKDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83722EA;
        Sat,  8 Apr 2023 03:03:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C1116069C;
        Sat,  8 Apr 2023 10:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD4EC4339B;
        Sat,  8 Apr 2023 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680948230;
        bh=V4a+tdNZ5VyCXSK9xKm7scGsOqxXzP9qP6i9zQ4cOl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/6vUlFX2NoPdRGrpBBksMGsrKewmDauqJSV5PQ2QuXxL1BCywys0Tf6ftnhWOO2z
         LDXhCpIeLPZl1+Q3mpVF7OK0yh3BKxeb92C5dxoBajIxJ4/JF56RvqmmMX+KMvieaZ
         FMyIlP6wm53vo+1W9fxEt1vThW+uDpRQ/Yvy7eunFiI33Hnk63WD1utkdy4kYBhM7F
         4jEs1rtQslv+1SZvVsnb4FgY62DHEh6/iEzqGdwyLQh3Ki9ZfUZzjZFqzeNbmvSqzO
         s6YTWxEdp7l+DG6xL7fAoYjtZ26zIxwAU3cWinwfC9pEtETIfPM8rrI7eGE7TB26Jp
         djxqlP/mfF1MA==
Date:   Sat, 8 Apr 2023 11:18:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: Add some kerneldoc for channel types
Message-ID: <20230408111849.77af363e@jic23-huawei>
In-Reply-To: <987b37ea10ace60f0e67a19f76c4b84dea3050c8.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
        <987b37ea10ace60f0e67a19f76c4b84dea3050c8.1677331779.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 15:54:30 +0200
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
> pointing to the sysfs document from the kernel doc of respective enums.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

If following seems a little over 'picky' I blame the bit of my day
job that involves reviewing far to many specifications...

Some of what follows probably applies to the ABI docs as well.


> ---
> Changelog RFCv1 => v2:
> - add missing channel type docs provided by Jonathan
> - add @in front of member names and fix typos pointed by Andy
> - drop TODOs as Jonathan clarified the units
> 
> Initial discussion about these docs can be found from:
> https://lore.kernel.org/all/0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com/
> ---
>  include/uapi/linux/iio/types.h | 134 +++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index c79f2f046a0b..78f4cfdc5e45 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -11,6 +11,124 @@
>  #ifndef _UAPI_IIO_TYPES_H_
>  #define _UAPI_IIO_TYPES_H_
>  
> +/**
> + * iio_chan_type - Type of data transferred via IIO channel.
I worry 'Type of data' could end up with people thinking '16 bit 2's complment'

Perhaps something more general would work?

- What is being measured / output by the channel.

> + *
> + * The 'main' type of data transferred via channel. Please note that most

type is fine here because it's more broken down than the short description.

most -> many

I can't be bothered to count actual devices and we have a lot of ADCs
and DACs that don't.  Just relaxing that to "many" avoids this being
or becoming inaccurate.

> + * devices also need to specify a more accurate 'sub category'. See the
> + * enum iio_modifier for this. (For example, IIO_ACCEL channel often needs to
> + * specify the direction. IIO_CONCENTRATION specifies the type of substance
> + * it measures etc).
> + *
> + * These reflect the units of the measurement via processed or unit after
> + * application of scale and offset. See the enum iio_chan_info_enum for
> + * scale and offset.
> + *
> + * Please find the detailed documentation for reported values from the

in Documentation/...

> + * Documentation/ABI/testing/sysfs-bus-iio.

Unusual to document an enum in a different order to the enum.
I'm in two minds on whether this is a good idea here.

> + *
> + * @IIO_ACCEL:		Acceleration, m/s^2
> + *			Doc keyword: in_accel_x_raw
> + *
> + * @IIO_ACTIVITY:	Activity state. For example a pedometer signaling
> + *			jogging, walking or staying still.
> + *			Doc keyword: in_activity_still_thresh_rising_en

Use in_activity_still_input
rather than the event control related to that here.

> + *
> + * @IIO_ALTVOLTAGE:	Peak to peak voltage, millivolts

Reference out_altvoltageY_raw

(the fun and complex game of DDS devices)

> + *
> + * @IIO_ANGL:		Angle of rotation, radians.
> + *			Doc keyword: in_angl_raw
> + *
> + * @IIO_ANGL_VEL:	Angular velocity, rad/s
> + *			Doc keyword: in_anglvel_x_raw
> + *
> + * @IIO_CAPACITANCE:	Capacitance, nanofarads.
> + *			Doc keyword: in_capacitanceY_raw
> + *
> + * @IIO_CCT:		Correlated color temperature, Kelvins
> + *
> + * @IIO_CURRENT:	Current, milliamps
> + *			Doc keyword: in_currentY_raw
> + *
> + * @IIO_CONCENTRATION:	Reading of a substance, percents. Used for example by

percentage

> + *			devices measuring amount of CO2, O2, ethanol...
concentration of CO2 ...

> + *			Doc keyword: in_concentration_raw
> + *
> + * @IIO_COUNT:		Deprecated, please use counter subsystem.
> + *
> + * @IIO_DISTANCE:	Distance in meters. Typically used to report measured
> + *			distance to an object or the distance covered by the
> + *			user
> + *			Doc keyword: in_distance_input
> + *
> + * @IIO_ELECTRICALCONDUCTIVITY: electric conductivity, siemens per meter
> + *			Doc keyword: in_electricalconductivity_raw
> + *
> + * @IIO_ENERGY:		Energy in Joules. Typically reported by a device
> + *			measuring energy burnt by the user.
> + *			Doc keyword: in_energy_input
> + *
> + * @IIO_GRAVITY:	Gravity, m/s^2
This needs more to differentiate from IIO_ACCEL.  Hmm. Something like
Acceleration due to gravity alone, independent of other accelerations due
to device movement.  (Which way is down!)

I'd forgotten this one even existed ;)

> + *			Doc keyword: in_gravity_x_raw
> + *
> + * @IIO_HUMIDITYRELATIVE: Relative humidity, percents
> + *			Doc keyword: in_humidityrelative_raw
> + *
> + * @IIO_INCLI:		Inclination, degrees
> + *			Doc keyword: in_incli_x_raw

(nothing to change here, but gah - an oddity in the ABI as all other angles
are radians)...

> + *
> + * @IIO_INDEX:		Deprecated, please use Counter subsystem
> + *
> + * @IIO_INTENSITY:	Unitless intensity.

This could do with an example.  "Used for measurements of light where
the exact meaning is dependent on the sensitivity curve."

> + *			Doc keyword: in_intensityY_raw
> + *
> + * @IIO_LIGHT:		Visible light intensity, lux

Not an intensity as depends on approx human eye sensitivity.
Raiding wikipedia - perhaps something like:

"Wave length weighted measure of light correlated with human
brightness perception." 

> + *			Doc keyword: in_illuminance_raw
> + *
> + * @IIO_MAGN:		Magnetic field, Gauss.
> + *			Doc keyword: in_magn_x_raw
> + *
> + * @IIO_MASSCONCENTRATION: Mass concentration, ug / m3
> + *			Doc keyword: in_massconcentration_pm1_input
> + *
> + * @IIO_PH:		pH reading, negative base-10 logarithm of hydrodium
> + *			ions in a litre of water
> + *			Doc keyword: in_ph_raw
> + *
> + * @IIO_PHASE:		Phase difference, radians
> + *			Doc keyword: in_phaseY_raw
> + *
> + * @IIO_POSITIONRELATIVE: Relative position.
Hohum. Another odd unit (however careful we are with this, some oddities
have made it in) Milipercent of 'pad' size.

> + *			Doc keyword: in_positionrelative_x_raw
> + *
> + * @IIO_POWER:		Power, milliwatts
> + *			Doc keyword: in_powerY_raw
> + *
> + * @IIO_PRESSURE:	Pressure, kilopascal
> + *			Doc keyword: in_pressureY_raw
> + *
> + * @IIO_RESISTANCE:	Resistance, ohms
> + *			Doc keyword: in_resistance_raw
> + *
> + * @IIO_ROT:		Euler angles, deg
> + *			Doc keyword: in_rot_yaw_raw
> + *
> + * @IIO_STEPS:		Steps taken by the user
> + *			Doc keyword: in_steps_input
> + *
> + * @IIO_TEMP:		Temperature, milli degrees Celsius
> + *			Doc keyword: in_temp_raw
> + *
> + * @IIO_UVINDEX:	UV light intensity index
> + *			Doc keyword: in_uvindex_input
> + *
> + * @IIO_VELOCITY:	Current speed (norm or magnitude of the velocity
> + *			vector), m/s
> + *			Doc keyword: in_velocity_sqrt(x^2+y^2+z^2)_input
> + *
> + * @IIO_VOLTAGE:	Voltage, millivolts
> + *			Doc keyword: in_voltageY_raw
> + */
>  enum iio_chan_type {
>  	IIO_VOLTAGE,
>  	IIO_CURRENT,
> @@ -49,6 +167,22 @@ enum iio_chan_type {
>  	IIO_MASSCONCENTRATION,
>  };
>  
> +/**
> + * iio_modifier - accurate class for channel data
accurate class -> sub class or direction for channel data
> + *
> + * @IIO_MOD_<X,Y,Z>:	Value represents <X,Y,Z>-axis data.
> + *			Typically used by channels of type:
> + *			IIO_ACCEL, IIO_TEMP, IIO_GRAVITY, IIO_POSITIONRELATIVE,
> + *			IIO_ANGL_VEL, IIO_INCLI, IIO_MAGN
> + * @IIO_MOD_LIGHT_BOTH:	Value contains visible and infrared light components
> + * @IIO_MOD_LIGHT_IR:	Value represents infrared radiation
> + * @IIO_MOD_LIGHT_<RED, GREEN, BLUE>:
> + *			Value represents visible <red, green, blue>  light
> + * @IIO_MOD_LIGHT_CLEAR:	Value represents all visible light frequencies

I guess a partial list is better than nothing here.  We can try and fill many
of the others in a future patch set.

> + *
> + * Please find the detailed documentation for reported values from the
> + * Documentation/ABI/testing/sysfs-bus-iio.
> + */
>  enum iio_modifier {
>  	IIO_NO_MOD,
>  	IIO_MOD_X,

