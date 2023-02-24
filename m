Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC86A1C98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBXNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBXNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:02:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D05BBA8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:02:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f18so17821014lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rW41mn6mfJ+WGIeGWueC3di5azsEPDdTPiU9YqxzRBs=;
        b=T6jzkTgNIR7SABkz+ch1MxxKReKw74AkVSRiklLisCpbWEqLuTUxy0niLabx4Pit4y
         e3YvH5npvFbao1zhKrQqjifD4CrO/dYnSfqA+PgNCHgetRWarzj53cE1i/mlz4ZFZEKH
         ezngqHHkkb/Vir5nIT1KFNl5eC6uo6nG3K4H3nTxyb+Z9RpqGJ1WPhwc8poV6Xik4EiL
         GZrB/ZVvXbiektTHqJ5WlSATh7zIYOmlDYOxoXoV5Wu4PKZoZ6HpOGToDklQDL/WqOXB
         9XbWV0c1JYQfgkLxrouFMGbpL3kRI0YReU8wPoET94+RYSPVAZkSoxbWgDvUcjFpOLXK
         KfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW41mn6mfJ+WGIeGWueC3di5azsEPDdTPiU9YqxzRBs=;
        b=m2uKmDOpiMYcYLlOspYKy6V/8JIQDnTHtjJN7pMNJDTo0tqgzdDnVAKphYNVSJ770N
         hnHGmZpdnhQDGdGRq1HtKnCtKyseG89c/R9+7UkN8ATBaM7pIq2waphu07YoOPzEGYN5
         N0l+tZ6NqGs1zL1X0ynZQY4lDL05WV+XQo7Hb+HvtKOJkxEEIxHXhXyZCmUyHqwX/sAe
         BZ3zFlbEJgjJNsDfWnox2soqCPv0K7UPgqqCPVgv8W0c3TF6iuj1u1bHBYiTKUAGtSgZ
         O8p1YpvCsalL9RL1F6tfAlLeOxbuoqMi/CrasJey0Dlk34IdBhHEj9/Xz3W8ky8wlRih
         GK+w==
X-Gm-Message-State: AO0yUKWfGOA4c3s5ey0ad4hZl6zkfP7KibXAwzTBRDsQugLlplTKBLyH
        W0zBRzAUiIJYgMeTzjiP018=
X-Google-Smtp-Source: AK7set87Hy52X+gGH77uva3nHF/a3f2aSZwykoHgaxqGEz8dl5GaM3zx+H+uqlT5uliucz1vr3HCcA==
X-Received: by 2002:a19:5205:0:b0:4d8:4b57:55e7 with SMTP id m5-20020a195205000000b004d84b5755e7mr4494316lfb.30.1677243765174;
        Fri, 24 Feb 2023 05:02:45 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id g6-20020ac25386000000b004db3e7dfb8csm1123760lfh.189.2023.02.24.05.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:02:44 -0800 (PST)
Date:   Fri, 24 Feb 2023 15:02:32 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iio: Add some kerneldoc for channel types
Message-ID: <10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iIpXvyDVx8O00vdX"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iIpXvyDVx8O00vdX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For occasional contributor like me navigating the IIO channel types and
modifiers may be a daunting task. One may have hard time finding out
what type of channel should be used for device data and what units the
data should be converted.

There is a great documentation for the sysfs interfaces though. What is
missing is mapping of the channel types and modifiers to the sysfs
documentation (and entries in documentation).

Give a hand to a driver writer by providing some documentation and by
pointing to the sysfs document from the kerneldocs of respective enums.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Please note that this RFC patch should not be applied as is. The docs
have TODO comments regarding units for IIO_ELECTRICALCONDUCTIVITY,
IIO_PHASE and IIO_RESISTANCE. I'll fix these TODOs, remove RFC and respin
if anyone familiar with the values provided via sysfs could provide me the
corret units for these channels. I am also open to any suggestions how
to better link from enum documentation to specific entry at the IIO sysfs
documetation.

Initial discussion about these docs can be found from:
https://lore.kernel.org/all/0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com/
---
 include/uapi/linux/iio/types.h | 140 ++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c79f2f046a0b..e6329d3cc055 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -10,7 +10,129 @@
=20
 #ifndef _UAPI_IIO_TYPES_H_
 #define _UAPI_IIO_TYPES_H_
-
+/**
+ * iio_chan_type - Type of data transferred via IIO channel.
+ *
+ * The 'main' type of data transferred via channel. Please note that most
+ * devices need to specify also a more accurate 'sub category'. See the
+ * enum iio_modifier for this. (For example, IIO_ACCEL channel often needs=
 to
+ * specify the direction. IIO_CONCENTRATION specifies the type of substance
+ * it measures etc).
+ *
+ * Use of correct units is required but scale and offset that user must ap=
ply
+ * to channel values can be advertised.
+ *
+ * Please find the detailed documentation for reported values from the
+ * Documentation/ABI/testing/sysfs-bus-iio.
+ *
+ * IIO_ACCEL:		Acceleration, m/s^2
+ *			Doc keyword: in_accel_x_raw
+ *
+ * IIO_ACTIVITY:	Activity state. For example a pedometer signaling
+ *			jogging, walking or staying still.
+ *			Doc keyword: in_activity_still_thresh_rising_en
+ *
+ * IIO_ALTVOLTAGE:
+ *
+ * IIO_ANGL:		Angle of rotation, radians.
+ *			Doc keyword: in_angl_raw
+ *
+ * IIO_ANGL_VEL:	Angular velocity, rad/s
+ *			Doc keyword: in_anglvel_x_raw
+ *
+ * IIO_CAPACITANCE:	Capacitance, nanofarads.
+ *			Doc keyword: in_capacitanceY_raw
+ *
+ * IIO_CCT:
+ *
+ * IIO_CURRENT:		Current, milliamps
+ *			Doc keyword: in_currentY_raw
+ *
+ * IIO_CONCENTRATION:	Reading of a substance, percents. Used for example by
+ *			deviced measuring amount of CO2, O2, ethanol...
+ *			Doc keyword: in_concentration_raw
+ *
+ * IIO_COUNT:		Deprecated, please use counter subsystem.
+ *
+ * IIO_DISTANCE:	Distance in meters. Typically used to report measured
+ *			distance to an object or the distance covered by the
+ *			user
+ *			Doc keyword: in_distance_input
+ *
+ * IIO_ELECTRICALCONDUCTIVITY: electric conductivity, siemens per meter
+ *			Doc keyword: in_electricalconductivity_raw
+ *			TODO: What does "can be processed to siemens per meter"
+ *			mean? Do we have unit requirement?
+ *
+ * IIO_ENERGY:		Energy in Joules. Typically reported by a device
+ *			measuring energy burnt by the user.
+ *			Doc keyword: in_energy_input
+ *
+ * IIO_GRAVITY:		Gravity, m/s^2
+ *			Doc keyword: in_gravity_x_raw
+ *
+ * IIO_HUMIDITYRELATIVE: Relative humidity, percents
+ *			Doc keyword: in_humidityrelative_raw
+ *
+ * IIO_INCLI:		Inclination, degrees
+ *			Doc keyword: in_incli_x_raw
+ *
+ * IIO_INDEX:		Deprecated, please use Counter subsystem
+ *
+ * IIO_INTENSITY:	Unitless intensity.
+ *			Doc keyword: in_intensityY_raw
+ *
+ * IIO_LIGHT:		Visible light intensity, lux
+ *			Doc keyword: in_illuminance_raw
+ *
+ * IIO_MAGN:		Magnetic field, Gauss.
+ *			Doc keyword: in_magn_x_raw
+ *
+ * IIO_MASSCONCENTRATION: Mass concentration, ug / m3
+ *			Doc keyword: in_massconcentration_pm1_input
+ *
+ * IIO_PH:		pH reading, negative base-10 logarithm of hydrodium
+ *			ions in a litre of water
+ *			Doc keyword: in_ph_raw
+ *
+ * IIO_PHASE:		Phase difference, radians
+ *			Doc keyword: in_phaseY_raw
+ *			TODO: What does "can be processed to radians" mean? Do
+ *			we have unit requirement?
+ *
+ * IIO_POSITIONRELATIVE: Relative position.
+ *			Doc keyword: in_positionrelative_x_raw
+ *
+ * IIO_POWER:		Power, milliwatts
+ *			Doc keyword: in_powerY_raw
+ *
+ * IIO_PRESSURE:	Pressure, kilopascal
+ *			Doc keyword: in_pressureY_raw
+ *
+ * IIO_RESISTANCE:	Resistance, ohms
+ *			Doc keyword: in_resistance_raw
+ *			TODO: What means "can be processed..." Do we have unit
+ *			requirement?
+ *
+ * IIO_ROT:		Euler angles, deg
+ *			Doc keyword: in_rot_yaw_raw
+ *
+ * IIO_STEPS:		Steps taken by the user
+ *			Doc keyword: in_steps_input
+ *
+ * IIO_TEMP:		Temperature, milli degrees Celsius
+ *			Doc keyword: in_temp_raw
+ *
+ * IIO_UVINDEX:		UV light intensity index
+ *			Doc keyword: in_uvindex_input
+ *
+ * IIO_VELOCITY:	Current speed (norm or magnitude of the velocity
+ *			vector), m/s
+ *			Doc keyword: in_velocity_sqrt(x^2+y^2+z^2)_input
+ *
+ * IIO_VOLTAGE:		Voltage, millivolts
+ *			Doc keyword: in_voltageY_raw
+ */
 enum iio_chan_type {
 	IIO_VOLTAGE,
 	IIO_CURRENT,
@@ -49,6 +171,22 @@ enum iio_chan_type {
 	IIO_MASSCONCENTRATION,
 };
=20
+/**
+ * iio_modifier - accurate class for channel data
+ *
+ * IIO_MOD_<X,Y,Z>:	Value represents <X,Y,Z>-axis data.
+ *			Typically used by channels of type:
+ *			IIO_ACCEL, IIO_TEMP, IIO_GRAVITY, IIO_POSITIONRELATIVE,
+ *			IIO_ANGL_VEL, IIO_INCLI, IIO_MAGN
+ * IIO_MOD_LIGHT_BOTH:	Value contains visible and infra red light componen=
ts
+ * IIO_MOD_LIGHT_IR:	Value represents infra-red radiation
+ * IIO_MOD_LIGHT_<RED, GREEN, BLUE>:
+ *			Value represents visible <red, green, blue>  light
+ * IIO_MOD_LIGHT_CLEAR:	Value represents all visible light frequencies
+ *
+ * Please find the detailed documentation for reported values from the
+ * Documentation/ABI/testing/sysfs-bus-iio.
+ */
 enum iio_modifier {
 	IIO_NO_MOD,
 	IIO_MOD_X,

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--iIpXvyDVx8O00vdX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP4tVAACgkQeFA3/03a
ocXAyggArD5L1uyLd8guaNcFepXF3uHQ8HYm75zQHdsuHo/SRH85IdJEPx0/yPjt
1MQ0hCyojLF/dxuYHS/VIhtukp/KiucXKTY1pm8hqki7VjzJCb3lzJtIf4KW8Uuf
TQaSymUdTwZ7EzNm9OJg4e5YynzUnuRIvFHRzXBN9PA6SLc2BLi95u+Z00CQT4jm
phG55RrvrdwQqS4A0nx0u/8qYtPFiSv4YD/Y4pQL9sz4QGlo8i/GMZUWX6OS08WC
iOkEhOVLzmtMjPJOgF44bA1OO/65fH2LANIetQeKbZdAOIQzN5JmJQLHLoW5dQYl
2O2J9FdrW1qbRiWERz1XUfuPu6Pe0g==
=a4Pe
-----END PGP SIGNATURE-----

--iIpXvyDVx8O00vdX--
