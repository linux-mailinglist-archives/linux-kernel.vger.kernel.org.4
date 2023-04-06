Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583D6D9D01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbjDFQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDFQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:05:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5E086B0;
        Thu,  6 Apr 2023 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680797084; i=w_armin@gmx.de;
        bh=OMWNCSi8r0eRbK4rYL/tpTRzGKYYJz/oM9lPKh4U11M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D6KWS/fKD+meV94UsRONO8S3/lPcXsIGsS5bB79pjGibxpJ7UfbuPhMLMjp+f0gGW
         Op2nccM7rHoZxD/YMfcMwXoF9eoNoJ9Pqv+PGUD2nB4MnJ/tAqAw09y3nWrbMR06Zl
         3O2fixRDHikBZkRRWtDpDhn71nLFMyMCkeMeV2H/dy39XnDEMGFwXKUIX1X3BTgqDE
         MiX47Yaba9nhtxIKS8wotVkF5DuyUFMJM+GBulFfoFQBTx/PeV7UOe6NpTSBtN0wMD
         X7lyWxo2lKGYJyfj7PjP0B8ClXme1OgAxq09vS2dNb+eYTVhYH//hS/nzzY1n+2Mbz
         I96QEXmrkc2iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1qMpBY1iC4-00erUd; Thu, 06
 Apr 2023 18:04:44 +0200
Subject: Re: [PATCH v2] hwmon: add HP WMI Sensors driver
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406152321.42010-1-james@equiv.tech>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <2257deba-187b-82d2-181c-f1fed08a2ff7@gmx.de>
Date:   Thu, 6 Apr 2023 18:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230406152321.42010-1-james@equiv.tech>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:lRTumk36GRkzJ8kV2bjcFdqBF70XHjNRdmjb6gvtuVp1YTyActl
 nNpQmSJa4Va+SEntsrpuZ1Wp5bPQgjPP7PudrpkZQQL9bPkkaiXA9lu9N+28thYGIz3pzMG
 x7NPzDaPGe89rUnj5/4y8PKmuKNT6/xEyTgDV3LaxkkgOWfFvNxvxVGN3pW5+3oVhZOWT3C
 yNqmBJz025GZOI8SOqf1Q==
UI-OutboundReport: notjunk:1;M01:P0:z2vv5WCU2Tc=;fJbDlU8MPhDDj8KYpuvuWbAu/L2
 hSmaameX81m/SbZZ5fe4+CGzko5gHo6LFu+eYjXK1IQGbGguwN8veMo0uSN0eYDt3dkL1wPln
 nl5G2+/pSAtHBWoxVI3TnguhTdqpA8N8YPnX0Kg2Nq0hbheXs/O3VB19yHfL1oMgpJQ+a4k0Y
 UTReaxnZXu4XO2/EkGyYsNCQ62vsA3JMoZqy2mZ7KCqcgjsO9tIOtm6VG8mwFJHUcOHkma1rE
 7jEt+PkTL/44+huwjGqTwG8Fkt8kQiFqkS8et3ow/5uIAMzmT02oPhcQCXnCcQvZBmkCjZDMA
 0nbUtkP7aQfqXu/t8BCQQbnMInxKyAr/wduhTmzxPIIrPXVlQLRG7yK8gcXQ5Vj/j00GvKYZk
 0wZROBFpMkDfLMMYWUFgWBjz/ZeWDXeGSIttNmoaPdSuTitW9vV/kS5Gwktv4EgIOAyapJMQv
 6IkTo3Zx6aL5YnPSyWMLgjodW5yySE7genhNWoiTCCNv+d/lgjrC7pFpwCLerKe15yV34nu9j
 Fz0GCfpWo424dhxzLEaTFj1iI4XMIzPJp9Ah2i2tCms8jPuhrrSd4MPcfS6LxtEIudt5kbM7W
 ntdLtrixJEKDeApf+IAHGj0xB41A/4YlL8CTUgOfkpU2sAsXU4Vp3k/XLE1kGrVeUgTiJqfeV
 KM6dX4r60gETFjLMV3boBPfV4GzGaE0tazPZYr6JfSvyDKuA2Ta/DMLU0IPoLi6BezSHAOs1k
 66X+oS7Zj48HWhvlFMzeJXSnD8K1boV27BAcHkc3AkdmNq8p5s0HRT/7ORPQqfkBHiQdgCx58
 OH/dPu7YoQh4PzVq34cF3GyhO7VOLLcgGD0ap4eSs9GDpeOnhdD1DBsyWR0HXXsz8kDRRmVBp
 C3194yVOxBzjuJ49pf3leS/Xx5EHS3ePOHeV8WMXkQbXs9pL6E3iaYG04qm3vNzWGSWeYcthw
 3xVMCkVlIW49yaUGzq0BrGsBulM=
X-Spam-Status: No, score=-3.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FUZZY_MILLION,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.04.23 um 17:23 schrieb James Seo:

> Hewlett-Packard business-class computers report hardware monitoring
> information via WMI. This driver exposes that information to hwmon.
> Initial support is provided for temperature, voltage, current, and
> fan speed sensor types.
>
> HP's WMI implementation permits many other types of numeric sensors.
> Therefore, a debugfs interface is also provided to enumerate and
> inspect all numeric sensors visible on the WMI side. This should
> facilitate adding support for other sensor types in the future.
>
> Tested on a HP Z420 and a HP EliteOne 800 G1.
>
> Note that these models only have temperature and fan speed sensors,
> so other sensor types have not been tested working yet. However, the
> driver should still work as expected. A 2005 HP whitepaper describes
> the relevant MOF definition and sensor value calculation, and both
> this driver and the official HP Performance Advisor utility comply
> with them (confirmed in the latter case by reverse engineering).
>
> Link: https://h20331.www2.hp.com/hpsub/downloads/cmi_whitepaper.pdf
> Signed-off-by: James Seo <james@equiv.tech>
>
> ---
>
> Changes in v2:
> * Reword commit message
> * Reword documentation
> * Remove stray #include
> * Use DIV_ROUND_CLOSEST in F to C conversion
> * Consolidate uses of mutex_lock()/mutex_unlock()
> * Process sensors in forward order by type
>
> History:
> v1: https://lore.kernel.org/linux-hwmon/20230403084859.26286-1-james@equ=
iv.tech/
> ---
>   Documentation/hwmon/hp-wmi-sensors.rst |   95 +++
>   Documentation/hwmon/index.rst          |    1 +
>   MAINTAINERS                            |    7 +
>   drivers/hwmon/Kconfig                  |   11 +
>   drivers/hwmon/Makefile                 |    1 +
>   drivers/hwmon/hp-wmi-sensors.c         | 1034 ++++++++++++++++++++++++
>   6 files changed, 1149 insertions(+)
>   create mode 100644 Documentation/hwmon/hp-wmi-sensors.rst
>   create mode 100644 drivers/hwmon/hp-wmi-sensors.c
>
> diff --git a/Documentation/hwmon/hp-wmi-sensors.rst b/Documentation/hwmo=
n/hp-wmi-sensors.rst
> new file mode 100644
> index 000000000000..71b1391d5072
> --- /dev/null
> +++ b/Documentation/hwmon/hp-wmi-sensors.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +.. include:: <isonum.txt>
> +
> +Linux HP WMI Sensors Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +:Copyright: |copy| 2023 James Seo <james@equiv.tech>
> +
> +Description
> +-----------
> +
> +Hewlett-Packard business-class computers report hardware monitoring inf=
ormation
> +via Windows Management Instrumentation (WMI). This driver exposes that
> +information to the Linux ``hwmon`` subsystem, allowing familiar userspa=
ce
> +utilities like ``sensors`` to gather numeric sensor readings.
> +
> +``sysfs`` interface
> +-------------------
> +
> +When the driver is loaded, it discovers the sensors available on the cu=
rrent
> +system and creates the following read-only ``sysfs`` attributes as appr=
opriate
> +within ``/sys/class/hwmon/hwmonX``:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name		 Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +curr[X]_input    Current in milliamperes (mA).
> +curr[X]_label    Current sensor label.
> +fan[X]_input     Fan speed in RPM.
> +fan[X]_label     Fan sensor label.
> +fan[X]_fault     Fan sensor fault indicator.
> +in[X]_input      Voltage in millivolts (mV).
> +in[X]_label      Voltage sensor label.
> +temp[X]_input    Temperature in millidegrees Celsius (m\ |deg|\ C).
> +temp[X]_label    Temperature sensor label.
> +temp[X]_fault    Temperature sensor fault indicator.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Here, ``X`` is some number that depends on other available sensors and =
on other
> +system hardware components.
> +
> +``fault`` attributes
> +  Reading ``1`` instead of ``0`` as the ``fault`` attribute for a senso=
r
> +  indicates that the sensor has encountered some issue during operation=
 such
> +  that measurements from it should no longer be trusted.
> +
> +``debugfs`` interface
> +---------------------
> +
> +The standard ``hwmon`` interface in ``sysfs`` exposes sensors of severa=
l common
> +types that are connected and operating normally as of driver initializa=
tion.
> +However, there are usually other sensors on the WMI side that do not me=
et these
> +criteria. This driver therefore provides a ``debugfs`` interface in
> +``/sys/kernel/debug/hp-wmi-sensors-X`` that allows read-only access to =
*all* HP
> +WMI sensors on the current system.
> +
> +.. warning:: The ``debugfs`` interface is only available when the kerne=
l is
> +             compiled with option ``CONFIG_DEBUG_FS``, and its implemen=
tation
> +             is subject to change without notice at any time.
> +
> +One numbered entry is created per sensor with the following attributes:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Name				Example
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +name                            ``CPU0 Fan``
> +description                     ``Reports CPU0 fan speed``
> +sensor_type                     ``12``
> +other_sensor_type               ``(null)``
> +operational_status              ``2``
> +current_state                   ``Normal``
> +possible_states                 ``Normal\nCaution\nCritical\nNot Presen=
t``
> +base_units                      ``19``
> +unit_modifier                   ``0``
> +current_reading                 ``1008``
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +These represent the properties of the underlying ``HP_BIOSNumericSensor=
`` WMI
> +object. Contents may vary somewhat between systems. See [#]_ for more d=
etails.
> +
> +Known issues and limitations
> +----------------------------
> +
> +- Non-numeric HP sensor types such as intrusion sensors that belong to =
the
> +  ``HP_BIOSStateSensor`` WMI object type are not supported.
> +- HP's WMI implementation permits sensors to claim to be of any type.
> +  However, only sensor types already known to hwmon can be supported.
> +
> +References
> +----------
> +
> +.. [#] Hewlett-Packard Development Company, L.P.,
> +       "HP Client Management Interface Technical White Paper", 2005. [O=
nline].
> +       Available: https://h20331.www2.hp.com/hpsub/downloads/cmi_whitep=
aper.pdf
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> index f1fe75f596a5..f8f3c0bef6ed 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -77,6 +77,7 @@ Hardware Monitoring Kernel Drivers
>      gl518sm
>      gxp-fan-ctrl
>      hih6130
> +   hp-wmi-sensors
>      ibmaem
>      ibm-cffps
>      ibmpowernv
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..264960e4c77e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9373,6 +9373,13 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Orphan
>   F:	drivers/platform/x86/hp/tc1100-wmi.c
>
> +HP WMI HARDWARE MONITOR DRIVER
> +M:	James Seo <james@equiv.tech>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/hp-wmi-sensors.rst
> +F:	drivers/hwmon/hp-wmi-sensors.c
> +
>   HPET:	High Precision Event Timers driver
>   M:	Clemens Ladisch <clemens@ladisch.de>
>   S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..78798e0ed5e6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2399,6 +2399,17 @@ config SENSORS_ASUS_EC
>   	  This driver can also be built as a module. If so, the module
>   	  will be called asus_ec_sensors.
>
> +config SENSORS_HP_WMI
> +	tristate "HP WMI Sensors"
> +	depends on ACPI_WMI
> +	help
> +	  If you say yes here you get support for the ACPI hardware monitoring
> +	  interface found in HP business-class computers. Temperature, voltage=
,
> +	  current, and fan speed sensor types are supported if present.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called hp_wmi_sensors.
> +
>   endif # ACPI
>
>   endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..05cce16f37f6 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_ACPI_POWER) +=3D acpi_power_meter=
.o
>   obj-$(CONFIG_SENSORS_ATK0110)	+=3D asus_atk0110.o
>   obj-$(CONFIG_SENSORS_ASUS_EC)	+=3D asus-ec-sensors.o
>   obj-$(CONFIG_SENSORS_ASUS_WMI)	+=3D asus_wmi_sensors.o
> +obj-$(CONFIG_SENSORS_HP_WMI)	+=3D hp-wmi-sensors.o
>
>   # Native drivers
>   # asb100, then w83781d go first, as they can override other drivers' a=
ddresses.
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-senso=
rs.c
> new file mode 100644
> index 000000000000..8c1f09fcdfce
> --- /dev/null
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -0,0 +1,1034 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hwmon driver for HP business-class computers that report numeric
> + * sensor data via Windows Management Instrumentation (WMI).
> + *
> + * Copyright (C) 2023 James Seo <james@equiv.tech>
> + *
> + * References:
> + * [1] Hewlett-Packard Development Company, L.P.,
> + *     "HP Client Management Interface Technical White Paper", 2005. [O=
nline].
> + *     Available: https://h20331.www2.hp.com/hpsub/downloads/cmi_whitep=
aper.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/debugfs.h>
> +#include <linux/hwmon.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/units.h>
> +#include <linux/wmi.h>
> +
> +/*
> + * MOF definition of the HP_BIOSNumericSensor WMI object [1]:
> + *
> + *   #pragma namespace("\\\\.\\root\\HP\\InstrumentedBIOS");
> + *
> + *   [abstract]
> + *   class HP_BIOSSensor
> + *   {
> + *     [read] string Name;
> + *     [read] string Description;
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *      "10","11","12"}, Values {"Unknown","Other","Temperature",
> + *      "Voltage","Current","Tachometer","Counter","Switch","Lock",
> + *      "Humidity","Smoke Detection","Presence","Air Flow"}]
> + *     uint32 SensorType;
> + *     [read] string OtherSensorType;
> + *     [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *      "10","11","12","13","14","15","16","17","18","..",
> + *      "0x8000.."}, Values {"Unknown","Other","OK","Degraded",
> + *      "Stressed","Predictive Failure","Error",
> + *      "Non-Recoverable Error","Starting","Stopping","Stopped",
> + *      "In Service","No Contact","Lost Communication","Aborted",
> + *      "Dormant","Supporting Entity in Error","Completed",
> + *      "Power Mode","DMTF Reserved","Vendor Reserved"}]
> + *     uint32 OperationalStatus;
> + *     [read] string CurrentState;
> + *     [read] string PossibleStates[];
> + *   };
> + *
> + *   class HP_BIOSNumericSensor : HP_BIOSSensor
> + *   {
> + *      [read, ValueMap {"0","1","2","3","4","5","6","7","8","9",
> + *       "10","11","12","13","14","15","16","17","18","19","20",
> + *       "21","22","23","24","25","26","27","28","29","30","31",
> + *       "32","33","34","35","36","37","38","39","40","41","42",
> + *       "43","44","45","46","47","48","49","50","51","52","53",
> + *       "54","55","56","57","58","59","60","61","62","63","64",
> + *       "65"}, Values {"Unknown","Other","Degrees C","Degrees F",
> + *       "Degrees K","Volts","Amps","Watts","Joules","Coulombs",
> + *       "VA","Nits","Lumens","Lux","Candelas","kPa","PSI",
> + *       "Newtons","CFM","RPM","Hertz","Seconds","Minutes",
> + *       "Hours","Days","Weeks","Mils","Inches","Feet",
> + *       "Cubic Inches","Cubic Feet","Meters","Cubic Centimeters",
> + *       "Cubic Meters","Liters","Fluid Ounces","Radians",
> + *       "Steradians","Revolutions","Cycles","Gravities","Ounces",
> + *       "Pounds","Foot-Pounds","Ounce-Inches","Gauss","Gilberts",
> + *       "Henries","Farads","Ohms","Siemens","Moles","Becquerels",
> + *       "PPM (parts/million)","Decibels","DbA","DbC","Grays",
> + *       "Sieverts","Color Temperature Degrees K","Bits","Bytes",
> + *       "Words (data)","DoubleWords","QuadWords","Percentage"}]
> + *     uint32 BaseUnits;
> + *     [read] sint32 UnitModifier;
> + *     [read] uint32 CurrentReading;
> + *   };
> + *
> + */
> +
> +#define HP_WMI_BIOS_GUID	   "5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
> +#define HP_WMI_NUMERIC_SENSOR_GUID "8F1F6435-9F42-42C8-BADC-0E9424F20C9=
A"
> +
> +/* These limits are arbitrary. The WMI implementation may vary by model=
. */
> +
> +#define HP_WMI_MAX_STR_SIZE	   128U
> +#define HP_WMI_MAX_PROPERTIES	   32U
> +#define HP_WMI_MAX_INSTANCES	   32U
> +
> +enum hp_wmi_type {
> +	HP_WMI_TYPE_OTHER			   =3D 1,
> +	HP_WMI_TYPE_TEMPERATURE			   =3D 2,
> +	HP_WMI_TYPE_VOLTAGE			   =3D 3,
> +	HP_WMI_TYPE_CURRENT			   =3D 4,
> +	HP_WMI_TYPE_AIR_FLOW			   =3D 12,
> +};
> +
> +enum hp_wmi_status {
> +	HP_WMI_STATUS_OK			   =3D 2,
> +};
> +
> +enum hp_wmi_units {
> +	HP_WMI_UNITS_DEGREES_C			   =3D 2,
> +	HP_WMI_UNITS_DEGREES_F			   =3D 3,
> +	HP_WMI_UNITS_DEGREES_K			   =3D 4,
> +	HP_WMI_UNITS_VOLTS			   =3D 5,
> +	HP_WMI_UNITS_AMPS			   =3D 6,
> +	HP_WMI_UNITS_RPM			   =3D 19,
> +};
> +
> +enum hp_wmi_property {
> +	HP_WMI_PROPERTY_NAME			   =3D 0,
> +	HP_WMI_PROPERTY_DESCRIPTION		   =3D 1,
> +	HP_WMI_PROPERTY_SENSOR_TYPE		   =3D 2,
> +	HP_WMI_PROPERTY_OTHER_SENSOR_TYPE	   =3D 3,
> +	HP_WMI_PROPERTY_OPERATIONAL_STATUS	   =3D 4,
> +	HP_WMI_PROPERTY_CURRENT_STATE		   =3D 5,
> +	HP_WMI_PROPERTY_POSSIBLE_STATES		   =3D 6,
> +	HP_WMI_PROPERTY_BASE_UNITS		   =3D 7,
> +	HP_WMI_PROPERTY_UNIT_MODIFIER		   =3D 8,
> +	HP_WMI_PROPERTY_CURRENT_READING		   =3D 9,
> +};
> +
> +static const acpi_object_type hp_wmi_property_map[] =3D {
> +	[HP_WMI_PROPERTY_NAME]			   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_DESCRIPTION]		   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_SENSOR_TYPE]		   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_OTHER_SENSOR_TYPE]	   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_OPERATIONAL_STATUS]	   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_CURRENT_STATE]		   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_POSSIBLE_STATES]	   =3D ACPI_TYPE_STRING,
> +	[HP_WMI_PROPERTY_BASE_UNITS]		   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_UNIT_MODIFIER]		   =3D ACPI_TYPE_INTEGER,
> +	[HP_WMI_PROPERTY_CURRENT_READING]	   =3D ACPI_TYPE_INTEGER,
> +};
> +
> +static const enum hwmon_sensor_types hp_wmi_hwmon_type_map[] =3D {
> +	[HP_WMI_TYPE_TEMPERATURE]		   =3D hwmon_temp,
> +	[HP_WMI_TYPE_VOLTAGE]			   =3D hwmon_in,
> +	[HP_WMI_TYPE_CURRENT]			   =3D hwmon_curr,
> +	[HP_WMI_TYPE_AIR_FLOW]			   =3D hwmon_fan,
> +};
> +
> +static const u32 hp_wmi_hwmon_attributes[hwmon_max] =3D {
> +	[hwmon_chip] =3D HWMON_C_REGISTER_TZ,
> +	[hwmon_temp] =3D HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_FAULT,
> +	[hwmon_in]   =3D HWMON_I_INPUT | HWMON_I_LABEL,
> +	[hwmon_curr] =3D HWMON_C_INPUT | HWMON_C_LABEL,
> +	[hwmon_fan]  =3D HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_FAULT,
> +};
> +
> +/*
> + * struct hp_wmi_numeric_sensor - a HP_BIOSNumericSensor instance
> + *
> + * Contains WMI object instance properties. See MOF definition [1].
> + */
> +struct hp_wmi_numeric_sensor {
> +	const char *name;
> +	const char *description;
> +	u32 sensor_type;
> +	const char *other_sensor_type; /* Explains "Other" SensorType. */
> +	u32 operational_status;
> +	const char *current_state;
> +	const char **possible_states;  /* Count may vary. */
> +	u32 base_units;
> +	s32 unit_modifier;
> +	u32 current_reading;
> +
> +	u8 possible_states_count;
> +};
> +
> +/*
> + * struct hp_wmi_info - sensor info
> + * @nsensor: numeric sensor properties
> + * @instance: its WMI instance number
> + * @is_active: whether the following fields are valid
> + * @type: its hwmon sensor type
> + * @cached_val: current sensor reading value, scaled for hwmon
> + * @last_updated: when these readings were last updated
> + */
> +struct hp_wmi_info {
> +	struct hp_wmi_numeric_sensor nsensor;
> +	u8 instance;
> +
> +	bool is_active;
> +	enum hwmon_sensor_types type;
> +	long cached_val;
> +	unsigned long last_updated; /* in jiffies */
> +};
> +
> +/*
> + * struct hp_wmi_sensors - driver state
> + * @wdev: pointer to the parent WMI device
> + * @debugfs: root directory in debugfs
> + * @info: sensor info structs for all sensors visible in WMI
> + * @info_map: access info structs by hwmon type and channel number
> + * @count: count of all sensors visible in WMI
> + * @channel_count: count of hwmon channels by hwmon type
> + * @lock: mutex to lock polling WMI and changes to driver state
> + */
> +struct hp_wmi_sensors {
> +	struct wmi_device *wdev;
> +	struct dentry *debugfs;
> +	struct hp_wmi_info info[HP_WMI_MAX_INSTANCES];
> +	struct hp_wmi_info **info_map[hwmon_max];
> +	u8 count;
> +	u8 channel_count[hwmon_max];
> +
> +	struct mutex lock; /* lock polling WMI, driver state changes */
> +};
> +
> +/* hp_wmi_strdup - devm_kstrdup, but length-limited */
> +static char *hp_wmi_strdup(struct device *dev, const char *src, u32 len=
)
> +{
> +	char *dst;
> +
> +	len =3D min(len, HP_WMI_MAX_STR_SIZE - 1);
> +
> +	dst =3D devm_kmalloc(dev, (len + 1) * sizeof(*dst), GFP_KERNEL);
> +	if (!dst)
> +		return NULL;
> +
> +	strscpy(dst, src, len + 1);
> +
> +	return dst;
> +}
> +
> +/*
> + * hp_wmi_get_wobj - poll WMI for a HP_BIOSNumericSensor object instanc=
e
> + * @state: pointer to driver state
> + * @instance: WMI object instance number
> + *
> + * Returns a new WMI object instance on success, or NULL on error.
> + * Caller must kfree the result.
> + */
> +static union acpi_object *hp_wmi_get_wobj(struct hp_wmi_sensors *state,
> +					  u8 instance)
> +{
> +	struct wmi_device *wdev =3D state->wdev;
> +
> +	return wmidev_block_query(wdev, instance);
> +}
> +
> +/*
> + * check_wobj - validate a HP_BIOSNumericSensor WMI object instance
> + * @wobj: pointer to WMI object instance to check
> + * @possible_states_count: out pointer to count of possible states
> + *
> + * Returns 0 on success, or a negative error code on error.
> + */
> +static int check_wobj(const union acpi_object *wobj, u8 *possible_state=
s_count)
> +{
> +	acpi_object_type type =3D wobj->type;
> +	int prop =3D HP_WMI_PROPERTY_NAME;
> +	acpi_object_type valid_type;
> +	union acpi_object *elements;
> +	u32 elem_count;
> +	u8 count =3D 0;
> +	u32 i;
> +
> +	if (type !=3D ACPI_TYPE_PACKAGE)
> +		return -EINVAL;
> +
> +	elem_count =3D wobj->package.count;
> +	if (elem_count > HP_WMI_MAX_PROPERTIES)
> +		return -EINVAL;
> +
> +	elements =3D wobj->package.elements;
> +	for (i =3D 0; i < elem_count; i++, prop++) {
> +		if (prop > HP_WMI_PROPERTY_CURRENT_READING)
> +			return -EINVAL;
> +
> +		type =3D elements[i].type;
> +		valid_type =3D hp_wmi_property_map[prop];
> +		if (type !=3D valid_type)
> +			return -EINVAL;
> +
> +		/*
> +		 * elements is a variable-length array of ACPI objects, one for
> +		 * each property of the WMI object instance, except that the
> +		 * strs in PossibleStates[] are flattened into this array, and
> +		 * their count is found in the WMI BMOF. We don't decode the
> +		 * BMOF, so find the count by finding the next int.
> +		 */
> +
> +		if (prop =3D=3D HP_WMI_PROPERTY_CURRENT_STATE) {
> +			prop =3D HP_WMI_PROPERTY_POSSIBLE_STATES;
> +			valid_type =3D hp_wmi_property_map[prop];
> +			for (; i + 1 < elem_count; i++, count++) {
> +				type =3D elements[i + 1].type;
> +				if (type !=3D valid_type)
> +					break;
> +			}
> +		}
> +	}
> +
> +	if (!count || prop <=3D HP_WMI_PROPERTY_CURRENT_READING)
> +		return -EINVAL;
> +
> +	*possible_states_count =3D count;
> +
> +	return 0;
> +}
> +
> +static int numeric_sensor_has_fault(const struct hp_wmi_numeric_sensor =
*nsensor)
> +{
> +	u32 operational_status =3D nsensor->operational_status;
> +	u32 current_reading =3D nsensor->current_reading;
> +
> +	return operational_status !=3D HP_WMI_STATUS_OK || !current_reading;
> +}
> +
> +/* scale_numeric_sensor - scale sensor reading for hwmon */
> +static long scale_numeric_sensor(const struct hp_wmi_numeric_sensor *ns=
ensor)
> +{
> +	u32 current_reading =3D nsensor->current_reading;
> +	s32 unit_modifier =3D nsensor->unit_modifier;
> +	u32 sensor_type =3D nsensor->sensor_type;
> +	u32 base_units =3D nsensor->base_units;
> +	s32 target_modifier;
> +	long val;
> +
> +	/* Fan readings are in RPM units; others are in milliunits. */
> +	target_modifier =3D sensor_type =3D=3D HP_WMI_TYPE_AIR_FLOW ? 0 : -3;
> +
> +	val =3D current_reading;
> +
> +	for (; unit_modifier < target_modifier; unit_modifier++)
> +		val =3D DIV_ROUND_CLOSEST(val, 10);
> +
> +	for (; unit_modifier > target_modifier; unit_modifier--) {
> +		if (val > LONG_MAX / 10) {
> +			val =3D LONG_MAX;
> +			break;
> +		}
> +		val *=3D 10;
> +	}
> +
> +	if (sensor_type =3D=3D HP_WMI_TYPE_TEMPERATURE) {
> +		switch (base_units) {
> +		case HP_WMI_UNITS_DEGREES_F:
> +			val -=3D MILLI * 32;
> +			val =3D val <=3D LONG_MAX / 5 ?
> +				      DIV_ROUND_CLOSEST(val * 5, 9) :
> +				      DIV_ROUND_CLOSEST(val, 9) * 5;
> +			break;
> +
> +		case HP_WMI_UNITS_DEGREES_K:
> +			val =3D milli_kelvin_to_millicelsius(val);
> +			break;
> +		}
> +	}
> +
> +	return val;
> +}
> +
> +/*
> + * classify_numeric_sensor - classify a numeric sensor
> + * @nsensor: pointer to numeric sensor struct
> + *
> + * Returns an enum hp_wmi_type value on success,
> + * or a negative value if the sensor type is unsupported.
> + */
> +static int classify_numeric_sensor(const struct hp_wmi_numeric_sensor *=
nsensor)
> +{
> +	u32 sensor_type =3D nsensor->sensor_type;
> +	u32 base_units =3D nsensor->base_units;
> +
> +	switch (sensor_type) {
> +	case HP_WMI_TYPE_TEMPERATURE:
> +		if (base_units =3D=3D HP_WMI_UNITS_DEGREES_C ||
> +		    base_units =3D=3D HP_WMI_UNITS_DEGREES_F ||
> +		    base_units =3D=3D HP_WMI_UNITS_DEGREES_K)
> +			return HP_WMI_TYPE_TEMPERATURE;
> +		break;
> +
> +	case HP_WMI_TYPE_VOLTAGE:
> +		if (base_units =3D=3D HP_WMI_UNITS_VOLTS)
> +			return HP_WMI_TYPE_VOLTAGE;
> +		break;
> +
> +	case HP_WMI_TYPE_CURRENT:
> +		if (base_units =3D=3D HP_WMI_UNITS_AMPS)
> +			return HP_WMI_TYPE_CURRENT;
> +		break;
> +
> +	case HP_WMI_TYPE_AIR_FLOW:
> +		if (base_units =3D=3D HP_WMI_UNITS_RPM)
> +			return HP_WMI_TYPE_AIR_FLOW;
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int
> +populate_numeric_sensor_from_wobj(struct device *dev,
> +				  struct hp_wmi_numeric_sensor *nsensor,
> +				  const union acpi_object *wobj)
> +{
> +	const union acpi_object *element;
> +	const char **possible_states;
> +	u8 possible_states_count;
> +	acpi_object_type type;
> +	const char *string;
> +	u32 value;
> +	int prop;
> +	int err;
> +
> +	err =3D check_wobj(wobj, &possible_states_count);
> +	if (err)
> +		return err;
> +
> +	possible_states =3D devm_kcalloc(dev, possible_states_count,
> +				       sizeof(*possible_states),
> +				       GFP_KERNEL);
> +	if (!possible_states)
> +		return -ENOMEM;
> +
> +	element =3D wobj->package.elements;
> +	nsensor->possible_states =3D possible_states;
> +	nsensor->possible_states_count =3D possible_states_count;
> +
> +	for (prop =3D 0; prop <=3D HP_WMI_PROPERTY_CURRENT_READING; prop++) {
> +		type =3D hp_wmi_property_map[prop];
> +
> +		switch (type) {
> +		case ACPI_TYPE_INTEGER:
> +			value =3D element->integer.value;
> +			break;
> +
> +		case ACPI_TYPE_STRING:
> +			string =3D hp_wmi_strdup(dev, element->string.pointer,
> +					       element->string.length);
> +			if (!string)
> +				return -ENOMEM;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		element++;
> +
> +		switch (prop) {
> +		case HP_WMI_PROPERTY_NAME:
> +			nsensor->name =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_DESCRIPTION:
> +			nsensor->description =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_SENSOR_TYPE:
> +			if (value > HP_WMI_TYPE_AIR_FLOW)
> +				return -EINVAL;
> +
> +			nsensor->sensor_type =3D value;
> +
> +			/* Skip OtherSensorType if it will be meaningless. */
> +			if (value !=3D HP_WMI_TYPE_OTHER) {
> +				element++;
> +				prop++;
> +			}
> +
> +			break;
> +
> +		case HP_WMI_PROPERTY_OTHER_SENSOR_TYPE:
> +			nsensor->other_sensor_type =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
> +			nsensor->operational_status =3D value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_CURRENT_STATE:
> +			nsensor->current_state =3D string;
> +			break;
> +
> +		case HP_WMI_PROPERTY_POSSIBLE_STATES:
> +			*possible_states++ =3D string;
> +			if (--possible_states_count)
> +				prop--;
> +			break;
> +
> +		case HP_WMI_PROPERTY_BASE_UNITS:
> +			nsensor->base_units =3D value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_UNIT_MODIFIER:
> +			/* UnitModifier is signed. */
> +			nsensor->unit_modifier =3D (s32)value;
> +			break;
> +
> +		case HP_WMI_PROPERTY_CURRENT_READING:
> +			nsensor->current_reading =3D value;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* update_numeric_sensor_from_wobj - update fungible sensor properties =
*/
> +static void
> +update_numeric_sensor_from_wobj(struct device *dev,
> +				struct hp_wmi_numeric_sensor *nsensor,
> +				const union acpi_object *wobj)
> +{
> +	const union acpi_object *elements;
> +	const union acpi_object *element;
> +	const char *string;
> +	u32 length;
> +	u8 offset;
> +
> +	elements =3D wobj->package.elements;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_OPERATIONAL_STATUS];
> +	nsensor->operational_status =3D element->integer.value;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_CURRENT_STATE];
> +	string =3D element->string.pointer;
> +
> +	if (strcmp(string, nsensor->current_state)) {
> +		length =3D element->string.length;
> +		devm_kfree(dev, nsensor->current_state);
> +		nsensor->current_state =3D hp_wmi_strdup(dev, string, length);
> +	}
> +
> +	/* Offset reads into the elements array after PossibleStates[0]. */
> +	offset =3D nsensor->possible_states_count - 1;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_UNIT_MODIFIER + offset];
> +	nsensor->unit_modifier =3D (s32)element->integer.value;
> +
> +	element =3D &elements[HP_WMI_PROPERTY_CURRENT_READING + offset];
> +	nsensor->current_reading =3D element->integer.value;
> +}
> +
> +/*
> + * interpret_info - interpret sensor for hwmon
> + * @info: pointer to sensor info struct
> + *
> + * Should be called after the numeric sensor member has been updated.
> + */
> +static void interpret_info(struct hp_wmi_info *info)
> +{
> +	const struct hp_wmi_numeric_sensor *nsensor =3D &info->nsensor;
> +
> +	info->cached_val =3D scale_numeric_sensor(nsensor);
> +	info->last_updated =3D jiffies;
> +}
> +
> +/*
> + * hp_wmi_update_info - poll WMI to update sensor info
> + * @state: pointer to driver state
> + * @info: pointer to sensor info struct
> + *
> + * Returns 0 on success, or a negative error code on error.
> + */
> +static int hp_wmi_update_info(struct hp_wmi_sensors *state,
> +			      struct hp_wmi_info *info)
> +{
> +	struct hp_wmi_numeric_sensor *nsensor =3D &info->nsensor;
> +	struct device *dev =3D &state->wdev->dev;
> +	const union acpi_object *wobj;
> +	u8 instance =3D info->instance;
> +	int ret =3D 0;
> +
> +	if (time_after(jiffies, info->last_updated + HZ)) {
> +		mutex_lock(&state->lock);
> +
> +		wobj =3D hp_wmi_get_wobj(state, instance);
> +		if (!wobj) {
> +			ret =3D -EIO;
> +			goto out_free_wobj;
> +		}
> +
> +		update_numeric_sensor_from_wobj(dev, nsensor, wobj);
> +
> +		interpret_info(info);
> +
> +out_free_wobj:
> +		kfree(wobj);
> +
> +		mutex_unlock(&state->lock);
> +	}
> +
> +	return ret;
> +}
> +
> +#if CONFIG_DEBUG_FS
> +
> +static int basic_string_show(struct seq_file *seqf, void *ignored)
> +{
> +	const char *str =3D seqf->private;
> +
> +	seq_printf(seqf, "%s\n", str);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(basic_string);
> +
> +static int fungible_show(struct seq_file *seqf, enum hp_wmi_property pr=
op)
> +{
> +	struct hp_wmi_numeric_sensor *nsensor;
> +	struct hp_wmi_sensors *state;
> +	struct hp_wmi_info *info;
> +	int err;
> +
> +	switch (prop) {
> +	case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       operational_status);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_STATE:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       current_state);
> +		break;
> +
> +	case HP_WMI_PROPERTY_UNIT_MODIFIER:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       unit_modifier);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_READING:
> +		nsensor =3D container_of(seqf->private,
> +				       struct hp_wmi_numeric_sensor,
> +				       current_reading);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	info =3D container_of(nsensor, struct hp_wmi_info, nsensor);
> +	state =3D container_of(info, struct hp_wmi_sensors, info[info->instanc=
e]);
> +
> +	err =3D hp_wmi_update_info(state, info);
> +	if (err)
> +		return err;
> +
> +	switch (prop) {
> +	case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
> +		seq_printf(seqf, "%u\n", nsensor->operational_status);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_STATE:
> +		seq_printf(seqf, "%s\n", nsensor->current_state);
> +		break;
> +
> +	case HP_WMI_PROPERTY_UNIT_MODIFIER:
> +		seq_printf(seqf, "%d\n", nsensor->unit_modifier);
> +		break;
> +
> +	case HP_WMI_PROPERTY_CURRENT_READING:
> +		seq_printf(seqf, "%u\n", nsensor->current_reading);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int operational_status_show(struct seq_file *seqf, void *ignored=
)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_OPERATIONAL_STATUS);
> +}
> +DEFINE_SHOW_ATTRIBUTE(operational_status);
> +
> +static int current_state_show(struct seq_file *seqf, void *ignored)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_CURRENT_STATE);
> +}
> +DEFINE_SHOW_ATTRIBUTE(current_state);
> +
> +static int possible_states_show(struct seq_file *seqf, void *ignored)
> +{
> +	struct hp_wmi_numeric_sensor *nsensor =3D seqf->private;
> +	u8 i;
> +
> +	for (i =3D 0; i < nsensor->possible_states_count; i++)
> +		seq_printf(seqf, "%s\n", nsensor->possible_states[i]);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(possible_states);
> +
> +static int unit_modifier_show(struct seq_file *seqf, void *ignored)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_UNIT_MODIFIER);
> +}
> +DEFINE_SHOW_ATTRIBUTE(unit_modifier);
> +
> +static int current_reading_show(struct seq_file *seqf, void *ignored)
> +{
> +	return fungible_show(seqf, HP_WMI_PROPERTY_CURRENT_READING);
> +}
> +DEFINE_SHOW_ATTRIBUTE(current_reading);
> +
> +/* hp_wmi_devm_debugfs_remove - devm callback for debugfs cleanup */
> +static void hp_wmi_devm_debugfs_remove(void *res)
> +{
> +	debugfs_remove_recursive(res);
> +}
> +
> +/* hp_wmi_debugfs_init - create and populate debugfs directory tree */
> +static void hp_wmi_debugfs_init(struct hp_wmi_sensors *state)
> +{
> +	struct device *dev =3D &state->wdev->dev;
> +	struct hp_wmi_info *info =3D state->info;
> +	struct hp_wmi_numeric_sensor *nsensor;
> +	char buf[HP_WMI_MAX_STR_SIZE];
> +	struct dentry *dir;
> +	int err;
> +	u8 i;
> +
> +	/* dev_name() gives a not-very-friendly GUID for WMI devices. */
> +	scnprintf(buf, sizeof(buf), "%s-%u", "hp-wmi-sensors", dev->id);
> +
> +	state->debugfs =3D debugfs_create_dir(buf, NULL);
> +	if (IS_ERR(state->debugfs))
> +		return;
> +
> +	err =3D devm_add_action(dev, hp_wmi_devm_debugfs_remove, state->debugf=
s);
> +	if (err) {
> +		debugfs_remove(state->debugfs);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < state->count; i++, info++) {
> +		nsensor =3D &info->nsensor;
> +
> +		scnprintf(buf, sizeof(buf), "%u", i);
> +		dir =3D debugfs_create_dir(buf, state->debugfs);
> +
> +		debugfs_create_file("name", 0444, dir,
> +				    (void *)nsensor->name,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("description", 0444, dir,
> +				    (void *)nsensor->description,
> +				    &basic_string_fops);
> +
> +		debugfs_create_u32("sensor_type", 0444, dir,
> +				   &nsensor->sensor_type);
> +
> +		debugfs_create_file("other_sensor_type", 0444, dir,
> +				    (void *)nsensor->other_sensor_type,
> +				    &basic_string_fops);
> +
> +		debugfs_create_file("operational_status", 0444, dir,
> +				    &nsensor->operational_status,
> +				    &operational_status_fops);
> +
> +		debugfs_create_file("current_state", 0444, dir,
> +				    (void *)&nsensor->current_state,
> +				    &current_state_fops);
> +
> +		debugfs_create_file("possible_states", 0444, dir,
> +				    nsensor, &possible_states_fops);
> +
> +		debugfs_create_u32("base_units", 0444, dir,
> +				   &nsensor->base_units);
> +
> +		debugfs_create_file("unit_modifier", 0444, dir,
> +				    &nsensor->unit_modifier,
> +				    &unit_modifier_fops);
> +
> +		debugfs_create_file("current_reading", 0444, dir,
> +				    &nsensor->current_reading,
> +				    &current_reading_fops);
> +	}
> +}
> +
> +#else
> +
> +static void hp_wmi_debugfs_init(struct hp_wmi_sensors *state)
> +{
> +}
> +
> +#endif
> +
> +static umode_t hp_wmi_hwmon_is_visible(const void *drvdata,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel)
> +{
> +	const struct hp_wmi_sensors *state =3D drvdata;
> +
> +	if (!state->info_map[type] || !state->info_map[type][channel])
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static int hp_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> +			     u32 attr, int channel, long *val)
> +{
> +	struct hp_wmi_sensors *state =3D dev_get_drvdata(dev);
> +	const struct hp_wmi_numeric_sensor *nsensor;
> +	struct hp_wmi_info *info;
> +	int err;
> +
> +	info =3D state->info_map[type][channel];
> +	nsensor =3D &info->nsensor;
> +
> +	err =3D hp_wmi_update_info(state, info);
> +	if (err)
> +		return err;
> +
> +	else if ((type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_fault) ||
> +		 (type =3D=3D hwmon_fan  && attr =3D=3D hwmon_fan_fault))
> +		*val =3D numeric_sensor_has_fault(nsensor);
> +
> +	else
> +		*val =3D info->cached_val;
> +
> +	return 0;
> +}
> +
> +static int hp_wmi_hwmon_read_string(struct device *dev,
> +				    enum hwmon_sensor_types type, u32 attr,
> +				    int channel, const char **str)
> +{
> +	const struct hp_wmi_sensors *state =3D dev_get_drvdata(dev);
> +	const struct hp_wmi_info *info;
> +
> +	info =3D state->info_map[type][channel];
> +	*str =3D info->nsensor.name;
> +
> +	return 0;
> +}
> +
> +static int add_channel_info(struct device *dev,
> +			    struct hwmon_channel_info *channel_info,
> +			    u8 count, enum hwmon_sensor_types type)
> +{
> +	u32 attr =3D hp_wmi_hwmon_attributes[type];
> +	u32 *config;
> +
> +	config =3D devm_kcalloc(dev, count + 1, sizeof(*config), GFP_KERNEL);
> +	if (!config)
> +		return -ENOMEM;
> +
> +	channel_info->type =3D type;
> +	channel_info->config =3D config;
> +	memset32(config, attr, count);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops hp_wmi_hwmon_ops =3D {
> +	.is_visible  =3D hp_wmi_hwmon_is_visible,
> +	.read	     =3D hp_wmi_hwmon_read,
> +	.read_string =3D hp_wmi_hwmon_read_string,
> +};
> +
> +static struct hwmon_chip_info hp_wmi_chip_info =3D {
> +	.ops         =3D &hp_wmi_hwmon_ops,
> +	.info        =3D NULL,
> +};
> +
> +static int hp_wmi_sensors_init(struct hp_wmi_sensors *state)
> +{
> +	struct hp_wmi_info *active_info[HP_WMI_MAX_INSTANCES];
> +	const struct hwmon_channel_info **ptr_channel_info;
> +	struct hwmon_channel_info *channel_info;
> +	struct device *dev =3D &state->wdev->dev;
> +	struct hp_wmi_info *info =3D state->info;
> +	struct hp_wmi_numeric_sensor *nsensor;
> +	u8 channel_count[hwmon_max] =3D {};
> +	enum hwmon_sensor_types type;
> +	union acpi_object *wobj;
> +	struct device *hwdev;
> +	u8 type_count =3D 0;
> +	u8 channel;
> +	int wtype;
> +	int err;
> +	u8 i;
> +
> +	for (i =3D 0, channel =3D 0; i < HP_WMI_MAX_INSTANCES; i++, info++) {
> +		wobj =3D hp_wmi_get_wobj(state, i);
> +		if (!wobj)
> +			break;
> +
> +		info->instance =3D i;
> +		nsensor =3D &info->nsensor;
> +
> +		err =3D populate_numeric_sensor_from_wobj(dev, nsensor, wobj);
> +		if (err)
> +			goto out_free_wobj;
> +
> +		if (numeric_sensor_has_fault(nsensor))
> +			goto out_free_wobj;
> +

Hi,

is it guaranteed that faulty sensors wont become operational later?
Also filtering out such sensors would make the support for the hwmon_temp_=
fault and
hwmon_fan_fault attributes meaningless.

> +		wtype =3D classify_numeric_sensor(nsensor);
> +		if (wtype < 0)
> +			goto out_free_wobj;
> +
> +		type =3D hp_wmi_hwmon_type_map[wtype];
> +		if (!channel_count[type])
> +			type_count++;
> +		channel_count[type]++;
> +
> +		info->is_active =3D true;
> +		info->type =3D type;
> +
> +		interpret_info(info);
> +
> +		active_info[channel++] =3D info;
> +
> +out_free_wobj:
> +		kfree(wobj);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	dev_dbg(dev, "Found %u sensors (%u active, %u types)\n",
> +		i, channel, type_count);
> +
> +	state->count =3D i;
> +	if (!state->count)
> +		return -ENODATA;
> +
> +	hp_wmi_debugfs_init(state);
> +
> +	if (!channel)
> +		return 0; /* Not an error, but debugfs only. */
> +
> +	if (channel_count[hwmon_temp]) {
> +		channel_count[hwmon_chip] =3D 1;
> +		type_count++;
> +	}
> +
> +	memcpy(state->channel_count, channel_count, sizeof(channel_count));
> +
> +	channel_info =3D devm_kcalloc(dev, type_count,
> +				    sizeof(*channel_info),
> +				    GFP_KERNEL);
> +	if (!channel_info)
> +		return -ENOMEM;
> +
> +	ptr_channel_info =3D devm_kcalloc(dev, type_count + 1,
> +					sizeof(*ptr_channel_info),
> +					GFP_KERNEL);
> +	if (!ptr_channel_info)
> +		return -ENOMEM;
> +
> +	hp_wmi_chip_info.info =3D ptr_channel_info;
> +
> +	for (type =3D hwmon_chip; type < hwmon_max; type++) {
> +		if (!channel_count[type])
> +			continue;
> +
> +		err =3D add_channel_info(dev, channel_info,
> +				       channel_count[type], type);
> +		if (err)
> +			return err;
> +
> +		*ptr_channel_info++ =3D channel_info++;
> +
> +		state->info_map[type] =3D devm_kcalloc(dev, channel_count[type],
> +						     sizeof(*state->info_map),
> +						     GFP_KERNEL);
> +		if (!state->info_map[type])
> +			return -ENOMEM;
> +	}
> +
> +	while (channel > 0) {
> +		type =3D active_info[--channel]->type;
> +		i =3D --channel_count[type];
> +		state->info_map[type][i] =3D active_info[channel];
> +	}
> +
> +	hwdev =3D devm_hwmon_device_register_with_info(dev, "hp_wmi_sensors",
> +						     state, &hp_wmi_chip_info,
> +						     NULL);
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}
> +
> +static int hp_wmi_sensors_probe(struct wmi_device *wdev, const void *co=
ntext)
> +{
> +	struct device *dev =3D &wdev->dev;
> +	struct hp_wmi_sensors *state;
> +	int err;
> +
> +	/* Sanity check. */
> +	if (!wmi_has_guid(HP_WMI_NUMERIC_SENSOR_GUID) ||
> +	    !wmi_has_guid(HP_WMI_BIOS_GUID)) {
> +		err =3D -ENODEV;
> +		goto out_err;
> +	}
> +

The sanity check for HP_WMI_NUMERIC_SENSOR_GUID is unnecessary, the WMI dr=
iver core already makes sure that your driver
is only matched with WMI devices containing HP_WMI_NUMERIC_SENSOR_GUID.
As for the sanity check regarding HP_WMI_BIOS_GUID: this WMI GUID is not u=
sed inside the driver. Since WMI GUIDs are expected
to be unique, checking for HP_WMI_BIOS_GUID (which AFAIK is used by the HP=
-BIOSCFG driver) without intending to use it is
meaningless.

Armin Wolf

> +	state =3D devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +	if (!state) {
> +		err =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	state->wdev =3D wdev;
> +
> +	mutex_init(&state->lock);
> +
> +	dev_set_drvdata(dev, state);
> +
> +	err =3D hp_wmi_sensors_init(state);
> +
> +out_err:
> +	return err;
> +}
> +
> +static const struct wmi_device_id hp_wmi_sensors_id_table[] =3D {
> +	{ HP_WMI_NUMERIC_SENSOR_GUID, NULL },
> +	{},
> +};
> +
> +static struct wmi_driver hp_wmi_sensors_driver =3D {
> +	.driver   =3D { .name =3D "hp-wmi-sensors" },
> +	.id_table =3D hp_wmi_sensors_id_table,
> +	.probe    =3D hp_wmi_sensors_probe,
> +};
> +module_wmi_driver(hp_wmi_sensors_driver);
> +
> +MODULE_AUTHOR("James Seo <james@equiv.tech>");
> +MODULE_DESCRIPTION("HP WMI Sensors driver");
> +MODULE_LICENSE("GPL");
>
> base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
