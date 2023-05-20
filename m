Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510D70A8A0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjETO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjETO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:59:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E74115;
        Sat, 20 May 2023 07:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0EF3616CF;
        Sat, 20 May 2023 14:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA479C4339B;
        Sat, 20 May 2023 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684594740;
        bh=3sNi5b+mHb0DNbUYZFndRTENzCDFeYGvixf9ehMCp2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rjKIa6oC2cUvdaQC1esIJOeFmqo/10Z5IbPdB2RhjTHXlO0QaP+KMnSPIBlSJHrwg
         vNQbNnl9/qEYR8n4/+8z+riZ6r+RrgD4lLLFEZr+hXHJa0uODlZdRpuQUMZxCWEtic
         m9UGUpzCzvTee21PjYPdMXTz3BxfhP+YKPXwHy+NPqaWwT6657tuGhNtHqQnkAS2ck
         4hjej5htitcoPo41bLcGn6aYTv5JxLAXLIfuSwNMwUlMWgZpXzAqe7mkFwKbOSzQyR
         5bXYYnPjkmTWceOBZY2TNreJlABNHkRgPnaACn94vJGKGTfyP07PMpTXFqF/7Rrs3N
         TE7aJeLKyAwAw==
Date:   Sat, 20 May 2023 16:15:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230520161509.4c704656@jic23-huawei>
In-Reply-To: <20230519160145.44208-3-marius.cristea@microchip.com>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 19:01:45 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the iio driver for Microchip family of 153.6 ksps,
> Low-Noise 16/24-Bit Delta-Sigma ADCs with an SPI interface.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Hi Marius,

Comments inline,

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-mcp3564         |  143 ++
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/mcp3564.c                     | 1395 +++++++++++++++++
>  5 files changed, 1559 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-mcp3564
>  create mode 100644 drivers/iio/adc/mcp3564.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-mcp3564 b/Documentat=
ion/ABI/testing/sysfs-bus-iio-mcp3564
> new file mode 100644
> index 000000000000..fd65995e2245
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-mcp3564

Don't provide documentation for anything that is standard ABI.
We can't have more than one instance of any given path + file in the
documentation without breaking it.

> @@ -0,0 +1,143 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/calibbias
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Offset Error Digital Calibration Code (two=E2=80=99s complement,
> +		MSb first coding). The device includes a digital calibration
> +		feature for offset and gain errors. The calibration
> +		scheme for offset error consists of the addition of a
> +		fixed offset value to the ADC output code
> +
> +		This attribute is used to set the offset error digital
> +		calibration code (two=E2=80=99s complement, MSb first coding).
> +		The ADC includes a digital calibration feature for offset
> +		errors. The calibration scheme for offset error consists of the
> +		addition of a fixed offset value to the ADC output code.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/calibbias_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a range with the possible values for the offset
> +		error digital calibration register.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/calibscale
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to set the gain error digital calibration
> +		code (unsigned, MSb first coding). The default value is 800000,
> +		which provides a gain of 1x.
> +		The ADC includes a digital calibration feature for gain errors.
> +		The calibration scheme for gain error consists of the
> +		multiplication of a fixed gain value to the ADC data code.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/calibscale_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a range with the possible values for the gain
> +		error digital calibration register.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/boost_current
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to set the biasing circuit of the
> +		Delta-Sigma modulator. The different BOOST settings are applied
> +		to the entire modulator circuit, including the voltage reference
> +		buffers.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/boost_current_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible values for
> +		the current biasing circuit of the Delta-Sigma modulator.
> +
> +		"x0.5",   - ADC channel has current x 0.5

Keep just numbers in the attr.  It should be named in a fashion that
makes it apparent that it's a multiplier, not an absolute current.

New ABI like this is best avoided if we can. I see from a quick glance at t=
he
datasheet that there is advice on controlling this to allow for different
clock settings, but I'm not sure if that's a simple relationship or not.
From=20
https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocu=
ments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-Noise-16=
-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
figures 2-20 onwards, it looks like this effectively trades off power consu=
mption
against max frequency, so maybe we could set it automatically?


> +
> +		"x0.66",  - ADC channel has current x 0.66
> +
> +		"x1",     - ADC channel has current x 1 (default)
> +
> +		"x2"      - ADC channel has current x 2
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/current_bias

Another bit of custom ABI with the normal problems of it being unknown
to standard userspace software.  You could perhaps use an output channel for
this and just treat it like a current DAC, with a label that makes it's rel=
ationship
to the inputs obvious.

> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to set the current Source/Sink
> +		values for sensor bias. The ADC inputs, VIN-/VIN+, feature a
> +		selectable burnout current source, which enables open or
> +		short-circuit detection, as well as biasing very low-current
> +		external sensors. The bias current is sourced on the VIN+ pin of
> +		the ADC (noninverting output of the analog multiplexer)
> +		and sunk on the VIN- pin of the ADC (inverting output of
> +		the analog multiplexer). Since the same current flows
> +		at the VIN-/VIN+ pins of the ADC, it can sense the
> +		impedance of an externally connected sensor that
> +		would be connected between the selected inputs of the
> +		multiplexer.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/current_bias_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible values for
> +		the current source/sink selection values for sensor bias.
> +
> +		"15_uA"        - 15 uA is applied to the ADC inputs.
Match to standard IIO units for a current then drop the postfix.
> +
> +		"3.7_uA"       - 3.7 uA is applied to the ADC inputs.
> +
> +		"0.9_uA"       - 0.9 uA is applied to the ADC inputs.
> +
> +		"no_current"   - "No current source is applied to the ADC
> +		inputs (default)"

0 would seem self explanatory for this an is easier for userspace software
to deal with.  Also, this doc should not include the values, merely that
there is a list.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_mux
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable the analog input multiplexer
> +		auto-zeroing algorithm. Write '1' to enable it, write '0' to
> +		disable it.
If you can explain what auto zeroing is that would be great. It's not somet=
hing
I recall seeing in other drivers.=20
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_ref
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable the chopping algorithm for the=20
> +		internal voltage reference buffer.  Write '1' to enable it,
> +		write '0' to disable it.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/hardwaregain
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to set the hardware applied gain factor.
> +		It is shared across all channels.
This attr is pretty much only used when the gain is not directly related to=
 the
value being used.  An example being a time of flight sensor where the ampli=
tude
of the measured signal doesn't directly matter as we are looking for the ti=
ming of the
peak, we just need it to be big enough to measure. Otherwise scale is what =
you want.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/hardwaregain_available
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this attribute will list all available hardware applied gain f=
actors.
> +		Shared across all channels.

Docs shouldn't included this level of detail  - they should say what the fi=
le
information means, not what the exact values are.

> +	=09
> +		"0.33"      - Gain is x1/3  ( x0.33 analog)
> +
> +		"1"         - Gain is x1    ( x8 analog) (default)
x8?

> +
> +		"2"         - Gain is x2    ( x2 analog)
> +
> +		"4"         - Gain is x4    ( x4 analog)
> +
> +		"8"         - Gain is x8    ( x8 analog)
> +
> +		"16"        - Gain is x16   (x16 analog)
> +
> +		"32"        - Gain is x32   (x16 analog, x2 digital)
> +
> +		"64"        - Gain is x64   (x16 analog, x4 digital)
> \ No newline at end of file
add one ;)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..2fd2d06fb87f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13786,6 +13786,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
>  F:	drivers/regulator/mcp16502.c
> =20
> +MICROCHIP MCP3564 ADC DRIVER
> +M:      Marius Cristea <marius.cristea@microchip.com>
> +L:      linux-iio@vger.kernel.org
> +S:      Supported
> +F:      Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> +F:      drivers/iio/adc/mcp3564.c
> +
>  MICROCHIP MCP3911 ADC DRIVER
>  M:	Marcus Folkesson <marcus.folkesson@gmail.com>
>  M:	Kent Gustavsson <kent@minoris.se>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index eb2b09ef5d5b..9ee85764b985 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -768,6 +768,19 @@ config MCP3422
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp3422.
> =20
> +config MCP3564
> +        tristate "Microchip Technology MCP3461/2/4/R, MCP3561/2/4/R driv=
er"
> +        depends on SPI
> +        depends on IIO
> +        help
> +          Say yes here to build support for Microchip Technology's MCP34=
61,
> +          MCP3462, MCP3464, MCP3461R, MCP3462R, MCP3464R, MCP3561, MCP35=
62,
> +          MCP3564, MCP3561R, MCP3562R and MCP3564R analog to digital
> +          converters.
> +
> +          This driver can also be built as a module. If so, the module w=
ill be
> +          called mcp3564.
> +
>  config MCP3911
>  	tristate "Microchip Technology MCP3911 driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index e07e4a3e6237..78aed4878e86 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o
>  obj-$(CONFIG_MAX9611) +=3D max9611.o
>  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
>  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> +obj-$(CONFIG_MCP356X) +=3D mcp3564.o

That won't work as config variable is MCP3564
Which is good given wildcards always go wrong in the end!

>  obj-$(CONFIG_MCP3911) +=3D mcp3911.o
>  obj-$(CONFIG_MEDIATEK_MT6360_ADC) +=3D mt6360-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6370_ADC) +=3D mt6370-adc.o
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> new file mode 100644
> index 000000000000..dfdbe4e37cd4
> --- /dev/null
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -0,0 +1,1395 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP356X/MCP356XR and MCP346X/MCP346XR series ADC chip =
family
> + *
> + * Copyright (C) 2022-2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea <marius.cristea@microchip.com>
> + *
> + * Datasheet for MCP3561, MCP3562, MCP3564 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Produ=
ctDocuments/DataSheets/MCP3561-2-4-Family-Data-Sheet-DS20006181C.pdf
> + * Datasheet for MCP3561R, MCP3562R, MCP3564R can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/Produ=
ctDocuments/DataSheets/MCP3561_2_4R-Data-Sheet-DS200006391C.pdf
> + * Datasheet for MCP3461, MCP3462, MCP3464 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/Produ=
ctDocuments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-No=
ise-16-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
> + * Datasheet for MCP3461R, MCP3462R, MCP3464R can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/Produ=
ctDocuments/DataSheets/MCP3461-2-4R-Family-Data-Sheet-DS20006404C.pdf
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/util_macros.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define MCP356X_ADCDATA		0x00
I'd rather not see wildcards as it implies these apply to other MCP356x dev=
ices
e.g. the mcp3565 (actually they may well do for that particular part, but t=
hat's not always the case :)

> +#define MCP356X_CONFIG0		0x01
> +#define MCP356X_CONFIG1		0x02
> +#define MCP356X_CONFIG2		0x03
> +#define MCP356X_CONFIG3		0x04
> +#define MCP356X_IRQ		0x05
> +#define MCP356X_MUX		0x06
> +#define MCP356X_SCAN		0x07
> +#define MCP356X_TIMER		0x08
> +#define MCP356X_OFFSETCAL	0x09
> +#define MCP356X_GAINCAL		0x0A
> +#define MCP356X_RESERVED_B	0x0B
> +#define MCP356X_RESERVED_C	0x0C
> +#define MCP356X_LOCK		0x0D
> +#define MCP356X_RESERVED_E	0x0E
> +#define MCP356X_CRCCFG		0x0F
> +
> +#define MCP356X_FAST_CMD_CTRL	0
> +#define MCP356X_RD_CTRL		BIT(0)
> +#define MCP356X_WRT_CTRL	BIT(1)
> +
> +#define MCP356X_FULL_RESET_CMD	GENMASK(3, 1)
> +
> +#define MCP3461_HW_ID		BIT(3)
> +#define MCP3462_HW_ID		0x0009
> +#define MCP3464_HW_ID		0x000B
> +
> +#define MCP3561_HW_ID		GENMASK(3, 2)
> +#define MCP3562_HW_ID		0x000D
> +#define MCP3564_HW_ID		GENMASK(3, 0)
As below. This isn't a mask, it's a numebr so GENMASK not appropriate.
> +#define MCP356X_HW_ID_MASK	GENMASK(3, 0)
This is a mask, so here GENMASK is the right choice.

> +
> +#define MCP356XR_INT_VREF_MV	2400
> +
> +/* MUX_VIN Input Selection
> + */
> +#define MCP356X_INTERNAL_VCM	GENMASK(3, 0)
Only use GENMASK if it's actually a mask, not just because it
happens to be some bits in a row.  Just use values in that case.
Same for BIT.  These are just the numbers 0 to 15 with some gaps.

> +#define MCP356X_TEMP_DIODE_M	GENMASK(3, 1)
> +#define MCP356X_TEMP_DIODE_P	0b1101
> +#define MCP356X_REFIN_NEG	GENMASK(3, 2)
> +#define MCP356X_REFIN_POZ	0b1011
> +#define MCP356X_RESERVED	0b1010 /* do not use */
> +#define MCP356X_AVDD		0b1001
> +#define MCP356X_AGND		BIT(3)
> +#define MCP356X_CH7		GENMASK(2, 0)
> +#define MCP356X_CH6		GENMASK(2, 1)
> +#define MCP356X_CH5		0b0101
> +#define MCP356X_CH4		BIT(2)
> +#define MCP356X_CH3		GENMASK(1, 0)
> +#define MCP356X_CH2		BIT(1)
> +#define MCP356X_CH1		BIT(0)
> +#define MCP356X_CH0		0
> +
> +#define MCP356X_ADC_MODE_MASK			GENMASK(1, 0)
> +
> +#define MCP356X_ADC_DEFAULT_MODE		0
> +#define MCP356X_ADC_SHUTDOWN_MODE		BIT(0)
> +#define MCP356X_ADC_STANDBY			BIT(1)
> +#define MCP356X_ADC_CONVERSION_MODE		GENMASK(1, 0)
> +
> +#define MCP356X_DATA_READY_MASK			BIT(6)
> +
> +#define MCP356X_OVERSAMPLING_RATIO_32		0
> +#define MCP356X_OVERSAMPLING_RATIO_64		BIT(0)
> +#define MCP356X_OVERSAMPLING_RATIO_128		BIT(1)
> +#define MCP356X_OVERSAMPLING_RATIO_256		GENMASK(1, 0)
> +#define MCP356X_OVERSAMPLING_RATIO_512		BIT(2)
> +#define MCP356X_OVERSAMPLING_RATIO_1024		0x05
> +#define MCP356X_OVERSAMPLING_RATIO_2048		GENMASK(2, 1)
> +#define MCP356X_OVERSAMPLING_RATIO_4096		GENMASK(2, 0)
> +#define MCP356X_OVERSAMPLING_RATIO_8192		BIT(3)
> +#define MCP356X_OVERSAMPLING_RATIO_16384	0x09
> +#define MCP356X_OVERSAMPLING_RATIO_20480	0x0A
> +#define MCP356X_OVERSAMPLING_RATIO_24576	0x0B
> +#define MCP356X_OVERSAMPLING_RATIO_40960	0x0C
> +#define MCP356X_OVERSAMPLING_RATIO_49152	0x0D
> +#define MCP356X_OVERSAMPLING_RATIO_81920	GENMASK(3, 1)
> +#define MCP356X_OVERSAMPLING_RATIO_98304	GENMASK(3, 0)
> +
> +#define MCP356X_OVERSAMPLING_RATIO_MASK		GENMASK(5, 2)
> +#define MCP356X_OVERSAMPLING_RATIO_SHIFT	0x02
> +
> +#define MCP356X_HARDWARE_GAIN_MASK		GENMASK(5, 3)
> +#define MCP356X_HARDWARE_GAIN_SHIFT		0x03
> +#define MCP356X_DEFAULT_HARDWARE_GAIN		BIT(1)
> +
> +#define MCP356X_CS_SEL_0_0_uA			0x0
> +#define MCP356X_CS_SEL_0_9_uA			BIT(0)
> +#define MCP356X_CS_SEL_3_7_uA			BIT(1)
> +#define MCP356X_CS_SEL_15_uA			GENMASK(1, 0)
> +
> +#define MCP356X_CS_SEL_MASK			GENMASK(3, 2)
> +
> +#define MCP356X_BOOST_CURRENT_x0_50		0
> +#define MCP356X_BOOST_CURRENT_x0_66		BIT(0)
> +#define MCP356X_BOOST_CURRENT_x1_00		BIT(1)
> +#define MCP356X_BOOST_CURRENT_x2_00		GENMASK(1, 0)
> +
> +#define MCP356X_BOOST_CURRENT_MASK		GENMASK(7, 6)
> +
> +/* Auto-Zeroing MUX Setting */
> +#define MCP356X_AZ_MUX_MASK			BIT(2)
> +/* Auto-Zeroing REF Setting */
> +#define MCP356X_AZ_REF_MASK			BIT(1)
> +
> +#define MCP356X_SHARED_DEVATTRS_COUNT		1
> +#define MCP356X_PARTICULAR_DEVATTRS_COUNT	1
> +
> +#define MAX_HWGAIN				64000

Event his wants to be prefixed because we may end up with a similar
define in a generic header at somepoint which would be confusing.

> +
> +#define MCP356X_DATA_READY_TIMEOUT_MS		2000
> +
> +enum mcp356x_ids {
> +	mcp3461,
> +	mcp3462,
> +	mcp3464,
> +	mcp3461r,
> +	mcp3462r,
> +	mcp3464r,
> +	mcp3561,
> +	mcp3562,
> +	mcp3564,
> +	mcp3561r,
> +	mcp3562r,
> +	mcp3564r,
> +};
> +
> +static const unsigned int mcp356x_oversampling_avail[16] =3D {
> +	[MCP356X_OVERSAMPLING_RATIO_32] =3D 32,
> +	[MCP356X_OVERSAMPLING_RATIO_64] =3D 64,
> +	[MCP356X_OVERSAMPLING_RATIO_128] =3D 128,
> +	[MCP356X_OVERSAMPLING_RATIO_256] =3D 256,
> +	[MCP356X_OVERSAMPLING_RATIO_512] =3D 512,
> +	[MCP356X_OVERSAMPLING_RATIO_1024] =3D 1024,
> +	[MCP356X_OVERSAMPLING_RATIO_2048] =3D 2048,
> +	[MCP356X_OVERSAMPLING_RATIO_4096] =3D 4096,
> +	[MCP356X_OVERSAMPLING_RATIO_8192] =3D 8192,
> +	[MCP356X_OVERSAMPLING_RATIO_16384] =3D 16384,
> +	[MCP356X_OVERSAMPLING_RATIO_20480] =3D 20480,
> +	[MCP356X_OVERSAMPLING_RATIO_24576] =3D 24576,
> +	[MCP356X_OVERSAMPLING_RATIO_40960] =3D 40960,
> +	[MCP356X_OVERSAMPLING_RATIO_49152] =3D 49152,
> +	[MCP356X_OVERSAMPLING_RATIO_81920] =3D 81920,
> +	[MCP356X_OVERSAMPLING_RATIO_98304] =3D 98304
> +};
> +
> +/*
> + * Current Source/Sink Selection Bits for Sensor Bias (source on VIN+/si=
nk on VIN-)
> + */
> +static const char * const mcp356x_current_bias_avail[] =3D {
> +	[MCP356X_CS_SEL_0_0_uA] =3D "no_current(default)",
> +	[MCP356X_CS_SEL_0_9_uA] =3D "0.9_uA",
> +	[MCP356X_CS_SEL_3_7_uA] =3D "3.7_uA",
> +	[MCP356X_CS_SEL_15_uA] =3D "15_uA",
> +};
> +
> +/*
> + * BOOST[1:0]: ADC Bias Current Selection
> + */
> +static const char * const mcp356x_boost_current_avail[] =3D {
> +	[MCP356X_BOOST_CURRENT_x0_50] =3D "x0.5",
> +	[MCP356X_BOOST_CURRENT_x0_66] =3D "x0.66",
> +	[MCP356X_BOOST_CURRENT_x1_00] =3D "x1_(default)",
> +	[MCP356X_BOOST_CURRENT_x2_00] =3D "x2",
See comments above. These should be IIO_VAL_INT_PLUS_MICRO pairs, not xX
> +};
> +
> +/*
> + * Calibration bias values
> + */
> +static const int mcp356x_calib_bias[] =3D {
> +	-8388608,	/* min: -2^23		*/
> +	 1,		/* step: 1		*/
> +	 8388607	/* max:  2^23 - 1	*/
> +};
> +
> +/*
> + * Calibration scale values
> + * The Gain Error Calibration register (GAINCAL) is an
> + * unsigned 24-bit register that holds the digital gain error
> + * calibration value, GAINCAL which could be calculated by
> + * GAINCAL (V/V) =3D (GAINCAL[23:0])/8388608
> + * The gain error calibration value range in equivalent voltage is [0; 2=
-2^(-23)]
> + */
> +static const unsigned int mcp356x_calib_scale[] =3D {
> +		0,	/* min:  0		*/
> +		1,	/* step: 1/8388608	*/
> +	 16777215	/* max:  2 - 2^(-23)	*/
> +};
> +
> +/* Programmable hardware gain x1/3, x1, x2, x4, x8, x16, x32, x64 */
> +static const int mcp356x_hwgain_frac[] =3D {
> +	3,
> +	10,

I think these are pairs so
	3, 10,
	1, 1,
	1, 2,
	1, 4,
etc.

> +	1,
> +	1,
> +	2,
> +	1,
> +	4,
> +	1,
> +	8,
> +	1,
> +	16,
> +	1,
> +	32,
> +	1,
> +	64,
> +	1
> +};
> +
> +static const int mcp356x_hwgain[] =3D {
> +	300,
> +	1000,
> +	2000,
> +	4000,
> +	8000,
> +	16000,
> +	32000,
> +	64000
> +};
> +
> +/**
> + * struct mcp356x_chip_info - chip specific data
> + * @channels:		struct iio_chan_spec matching the device's capabilities
> + * @num_channels:	number of channels
> + * @int_vref_uv:	internal voltage reference value in microVolts
> + * @has_vref:		Does the ADC has an internal voltage reference?
> + */
> +struct mcp356x_chip_info {
> +	const struct	iio_chan_spec *channels;
> +	unsigned int	num_channels;
> +	unsigned int	int_vref_uv;
> +	bool		has_vref;
> +};
> +
> +/**
> + * struct mcp356x_state - working data for a ADC device
> + * @chip_info:		chip specific data
> + * @mcp356x_info:	information about iio device
> + * @spi:		SPI device structure
> + * @vref:		The regulator device used as a voltage reference in case
> + *			external voltage reference is used
> + * @vref_mv:		voltage reference value in miliVolts
> + * @lock:		mutex to prevent concurrent reads/writes
> + * @dev_addr:		hardware device address
> + * @oversampling:	the index inside oversampling list of the ADC
> + * @hwgain:		the index inside hardware gain list of the ADC
> + * @calib_bias:		calibration bias value
> + * @calib_scale:	calibration scale value
> + * @current_boost_mode:	the index inside current boost list of the ADC
> + * @current_bias_mode:	the index inside current bias list of the ADC
> + * @auto_zeroing_mux:	set if ADC auto-zeroing algorithm is enabled
> + * @auto_zeroing_ref:	set if ADC auto-Zeroing Reference Buffer Setting i=
s enabled
> + */
> +struct mcp356x_state {
> +	const struct mcp356x_chip_info *chip_info;
> +	struct iio_info		mcp356x_info;

Shouldn't need a copy of this.  The real one in iio_dev should always be av=
ailable
any where you need it.

> +	struct spi_device	*spi;
> +	struct regulator	*vref;
> +	unsigned short		vref_mv;
> +	struct mutex		lock; /*lock to prevent concurrent reads/writes */

The spi core bus locks prevent that. Please add more specific dos. Also fin=
e to just
have docs in the kernel-doc block above, don't need this here as well.

> +	u8			dev_addr;
> +	unsigned int		oversampling;
> +	unsigned int		hwgain;
> +	int			calib_bias;
> +	int			calib_scale;
> +	unsigned int		current_boost_mode;

Modes tend to be better represented as enums. Can that work here?
Means the compiler can see what values are possible and complain if others
are used.

> +	unsigned int		current_bias_mode;
> +	bool			auto_zeroing_mux;
> +	bool			auto_zeroing_ref;
> +};
> +
> +static inline u8 mcp356x_reg_write(u8 chip_addr, u8 reg)
> +{
> +	return ((chip_addr << 6) | (reg << 2) | MCP356X_WRT_CTRL);
> +}
> +
> +static inline u8 mcp356x_reg_read(u8 chip_addr, u8 reg)
> +{
> +	return ((chip_addr << 6) | (reg << 2) | MCP356X_RD_CTRL);
> +}
> +
> +static inline u8 mcp356x_reg_fast_cmd(u8 chip_addr, u8 cmd)
> +{
> +	return ((chip_addr << 6) | (cmd << 2));
FIELD_PREP() + masks  =20

Also drop the extra outer brackets.

> +}
> +
> +static int mcp356x_read(struct mcp356x_state *adc, u8 reg, u32 *val, u8 =
len)
I'm in two minds about these read functions as they are more complex
than say just having
	mcp356x_read_8bits()
	mcp356x_read_16bits()
	mcp356x_read_24bits()
As then you a only do an endian conversion if it matters (not the 8 bit one=
s)
and it's obvious what is going on + you can use get_unaligned_be24 for exam=
ple
to make it even clearer.

> +{
> +	int ret;
> +	u8 tmp_reg;
> +
> +	tmp_reg =3D mcp356x_reg_read(adc->dev_addr, reg);
> +
> +	ret =3D spi_write_then_read(adc->spi, &tmp_reg, 1, val, len);
> +
> +	be32_to_cpus(val);

As below, better to enforce type as __be32

> +	*val >>=3D ((4 - len) * 8);
> +
> +	return ret;
> +}
> +
> +static int mcp356x_write(struct mcp356x_state *adc, u8 reg, u32 val, u8 =
len)
> +{
> +	val |=3D (mcp356x_reg_write(adc->dev_addr, reg) << (len * 8));
> +	val <<=3D (3 - len) * 8;
> +	cpu_to_be32s(&val);

Use a __be32 to store the temporary so that we can track the endian type cl=
eanly.

> +
> +	return spi_write(adc->spi, &val, len + 1);

spi_write needs a dma safe buffer.  Either allocate it on the stack, or emb=
ed
it in iio_priv() taking care to mark it appropriately aligned (lots of exam=
ples
of this in IIO). Or just use spi_write_then_read() with a 0 size read as th=
at
uses bounce buffers to achieve DMA safety.

As above, I'd be tempted to do sized versions as there are only a few diffe=
rent
options and they will be more readable + use unaligned puts to make it obvi=
ous
what is going on.


> +}
> +
> +static int mcp356x_fast_cmd(struct mcp356x_state *adc, u8 fast_cmd)
> +{
> +	u8 val;
> +
> +	val =3D mcp356x_reg_fast_cmd(adc->dev_addr, fast_cmd);
> +
> +	return spi_write(adc->spi, &val, 1);
> +}
> +
> +static int mcp356x_update(struct mcp356x_state *adc, u8 reg, u32 mask, u=
32 val,
> +			  u8 len)
> +{
> +	u32 tmp;
> +	int ret;
> +
> +	ret =3D mcp356x_read(adc, reg, &tmp, len);
	if (ret < 0)
		return ret;

	val &=3D mask
	...
	return mc356x_write();




> +
> +	if (ret =3D=3D 0) {
> +		val &=3D mask;
> +		val |=3D tmp & ~mask;
> +		ret =3D mcp356x_write(adc, reg, val, len);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Custom IIO Device Attributes */

Obvious comment, drop it. This sort of 'section' title frequently gets brok=
en
as code gets moved around.

> +static int mcp356x_set_current_boost_mode(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  unsigned int mode)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
> +
> +	mutex_lock(&adc->lock);
> +	ret =3D mcp356x_update(adc, MCP356X_CONFIG2, MCP356X_BOOST_CURRENT_MASK,
> +			     mode, 1);
> +
> +	if (ret)
> +		dev_err(&indio_dev->dev, "Failed to configure CONFIG2 register\n");
> +	else
> +		adc->current_boost_mode =3D mode;
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int mcp356x_get_current_boost_mode(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +
> +	return adc->current_boost_mode;
> +}
> +
> +static int mcp356x_set_current_bias_mode(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int mode)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
> +
> +	mutex_lock(&adc->lock);
> +	ret =3D mcp356x_update(adc, MCP356X_CONFIG0, MCP356X_CS_SEL_MASK, mode,=
 1);
> +
> +	if (ret)
> +		dev_err(&indio_dev->dev, "Failed to configure CONFIG0 register\n");
> +	else
> +		adc->current_bias_mode =3D mode;
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int mcp356x_get_current_bias_mode(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +
> +	return adc->current_bias_mode;
> +}
> +
> +static const struct iio_enum mcp356x_current_boost_mode_enum =3D {
> +	.items =3D mcp356x_boost_current_avail,
> +	.num_items =3D ARRAY_SIZE(mcp356x_boost_current_avail),
> +	.set =3D mcp356x_set_current_boost_mode,
> +	.get =3D mcp356x_get_current_boost_mode,

Not going to comment again on these. Before we focus on implementation need
to deal with question of whether we want them / how useful they are to expo=
se.

> +};
> +
> +static const struct iio_enum mcp356x_current_bias_mode_enum =3D {
> +	.items =3D mcp356x_current_bias_avail,
> +	.num_items =3D ARRAY_SIZE(mcp356x_current_bias_avail),
> +	.set =3D mcp356x_set_current_bias_mode,
> +	.get =3D mcp356x_get_current_bias_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info mcp356x_ext_info[] =3D {
> +	IIO_ENUM("boost_current", IIO_SHARED_BY_ALL, &mcp356x_current_boost_mod=
e_enum),
> +	{
> +		.name =3D "boost_current_available",
> +		.shared =3D IIO_SHARED_BY_ALL,
> +		.read =3D iio_enum_available_read,
> +		.private =3D (uintptr_t)&mcp356x_current_boost_mode_enum,
> +	},
> +	IIO_ENUM("current_bias", IIO_SHARED_BY_ALL, &mcp356x_current_bias_mode_=
enum),
> +	{
> +		.name =3D "current_bias_available",
> +		.shared =3D IIO_SHARED_BY_ALL,
> +		.read =3D iio_enum_available_read,
> +		.private =3D (uintptr_t)&mcp356x_current_bias_mode_enum,
> +	},
> +	{}
> +};
> +
> +static ssize_t mcp356x_auto_zeroing_mux_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", adc->auto_zeroing_mux);
> +}
> +
> +static ssize_t mcp356x_auto_zeroing_mux_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	bool auto_zero;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &auto_zero);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&adc->lock);
> +	ret =3D mcp356x_update(adc, MCP356X_CONFIG2, MCP356X_AZ_MUX_MASK,
> +			     (u32)auto_zero, 1);
> +
> +	if (ret)
> +		dev_err(&indio_dev->dev, "Failed to update CONFIG2 register\n");
> +	else
> +		adc->auto_zeroing_mux =3D auto_zero;
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t mcp356x_auto_zeroing_ref_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", adc->auto_zeroing_ref);
> +}
> +
> +static ssize_t mcp356x_auto_zeroing_ref_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	bool auto_zero;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &auto_zero);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&adc->lock);
> +	ret =3D mcp356x_update(adc, MCP356X_CONFIG2, MCP356X_AZ_REF_MASK,
> +			     (u32)auto_zero, 1);
> +
> +	if (ret)
> +		dev_err(&indio_dev->dev, "Failed to update CONFIG2 register\n");
> +	else
> +		adc->auto_zeroing_ref =3D auto_zero;
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +#define MCP356X_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
> +
> +static IIO_DEVICE_ATTR(enable_auto_zeroing_ref, 0644,
> +		       mcp356x_auto_zeroing_ref_show,
> +		       mcp356x_auto_zeroing_ref_store, 0);
> +
> +static struct attribute *mcp356x_particular_attributes[] =3D {
> +	MCP356X_DEV_ATTR(enable_auto_zeroing_ref),
> +	NULL
> +};
> +
> +static IIO_DEVICE_ATTR(enable_auto_zeroing_mux, 0644,
> +		       mcp356x_auto_zeroing_mux_show,
> +		       mcp356x_auto_zeroing_mux_store, 0);
> +
> +static struct attribute *mcp356x_shared_attributes[] =3D {
> +	MCP356X_DEV_ATTR(enable_auto_zeroing_mux),
> +	NULL,
No trailing comma needed on a NULL terminating element as we can't
stick anything after it.
> +};
> +
> +static int mcp356x_prep_custom_attributes(struct mcp356x_state *adc,
> +					  struct iio_dev *indio_dev)
> +{
> +	int i;
> +	struct attribute **mcp356x_custom_attr;
> +	struct attribute_group *mcp356x_group;
> +
> +	mcp356x_group =3D devm_kzalloc(&adc->spi->dev, sizeof(*mcp356x_group), =
GFP_KERNEL);
> +
> +	if (!mcp356x_group)
> +		return (-ENOMEM);
		return -ENOMEM;
same elsewhere.
> +
> +	mcp356x_custom_attr =3D devm_kzalloc(&adc->spi->dev, (MCP356X_SHARED_DE=
VATTRS_COUNT +
> +		MCP356X_PARTICULAR_DEVATTRS_COUNT + 1) * sizeof(struct attribute *),
> +		GFP_KERNEL);
> +
> +	if (!mcp356x_custom_attr)
> +		return (-ENOMEM);
> +
> +	for (i =3D 0; i < MCP356X_SHARED_DEVATTRS_COUNT; i++)
> +		mcp356x_custom_attr[i] =3D mcp356x_shared_attributes[i];
> +
> +	if (adc->chip_info->has_vref) {
> +		dev_dbg(&indio_dev->dev, "Setup custom attr for R variant\n");
> +		for (i =3D 0; i < MCP356X_PARTICULAR_DEVATTRS_COUNT; i++)
> +			mcp356x_custom_attr[MCP356X_SHARED_DEVATTRS_COUNT + i] =3D
> +				mcp356x_particular_attributes[i];
> +	}
> +
> +	mcp356x_group->attrs =3D mcp356x_custom_attr;
> +	adc->mcp356x_info.attrs =3D mcp356x_group;
This looks to me like you are picking between two fixed sets. Just define b=
oth sets
as static const and pick between dpending on has_vref.

return attrs and set them in the caller so you don't need the mcp356x_info =
element
in the adc struct.

> +
> +	return 0;
> +}
> +
> +#define MCP356X_V_CHANNEL(index, addr, depth) {					\
> +	.type =3D IIO_VOLTAGE,							\
> +	.indexed =3D 1,								\
> +	.channel =3D (index),							\
> +	.address =3D (((addr) << 4) | MCP356X_AGND),				\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all  =3D BIT(IIO_CHAN_INFO_HARDWAREGAIN)	|	\
> +				BIT(IIO_CHAN_INFO_CALIBBIAS)		|	\
> +				BIT(IIO_CHAN_INFO_CALIBSCALE)		|	\
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_CALIBSCALE) |	\
> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN)		|	\
> +				BIT(IIO_CHAN_INFO_CALIBBIAS)		|	\
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.ext_info =3D mcp356x_ext_info,						\
> +	.scan_index =3D 0,							\
> +	.scan_type =3D {								\
> +		.sign =3D 's',							\
> +		.realbits =3D depth,						\
> +		.storagebits =3D 32,						\
> +		.endianness =3D IIO_BE,						\
> +	},									\
> +}
> +
> +#define MCP356X_T_CHAN(depth) {							\
> +	.type =3D IIO_TEMP,							\
> +	.channel =3D 0,								\
> +	.address =3D ((MCP356X_TEMP_DIODE_P << 4) | MCP356X_TEMP_DIODE_M),	\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all  =3D BIT(IIO_CHAN_INFO_HARDWAREGAIN)	|	\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS)			|	\
> +			BIT(IIO_CHAN_INFO_CALIBSCALE)			|	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_CALIBSCALE) |	\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS)			|	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.ext_info =3D mcp356x_ext_info,						\
> +	.scan_index =3D 0,							\
> +	.scan_type =3D {								\
> +		.sign =3D 'u',							\
> +		.realbits =3D depth,						\
> +		.storagebits =3D 32,						\
> +		.endianness =3D IIO_BE,						\
> +	},									\
> +}
> +
> +#define MCP356X_V_CHANNEL_DIFF(chan1, chan2, addr, depth) {			\
> +	.type =3D IIO_VOLTAGE,							\
> +	.indexed =3D 1,								\
> +	.channel =3D (chan1),							\
> +	.channel2 =3D (chan2),							\
> +	.address =3D (addr),							\
> +	.differential =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all  =3D BIT(IIO_CHAN_INFO_HARDWAREGAIN)	|	\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS)			|	\
> +			BIT(IIO_CHAN_INFO_CALIBSCALE)			|	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_CALIBSCALE) |	\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS)			|	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.ext_info =3D mcp356x_ext_info,						\
> +	.scan_index =3D 0,							\
> +	.scan_type =3D {								\

Don't set any values you don't use - they can be misleading. For instance i=
f you
had implemented buffered capture (the chrdev route) then you could not have
scan_index =3D 0 for all the instances of this.
Also, you probably don't use any/all of the scan_type fields - so don't set=
 them.

> +		.sign =3D 's',							\
> +		.realbits =3D depth,						 \
> +		.storagebits =3D 32,						\
> +		.endianness =3D IIO_BE,						\
> +	},									\
> +}
> +
> +#define MCP3561_CHANNELS(depth) {			\
> +	MCP356X_V_CHANNEL(0, 0, depth),			\
> +	MCP356X_V_CHANNEL(1, 1, depth),			\
> +	MCP356X_V_CHANNEL_DIFF(0, 1, 0x01, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 0, 0x10, depth),	\
> +	MCP356X_T_CHAN(depth)				\
> +}
> +
> +#define MCP3562_CHANNELS(depth) {			\
> +	MCP356X_V_CHANNEL(0, 0, depth),			\
> +	MCP356X_V_CHANNEL(1, 1, depth),			\
> +	MCP356X_V_CHANNEL(2, 2, depth),			\
> +	MCP356X_V_CHANNEL(3, 3, depth),			\
> +	MCP356X_T_CHAN(depth),				\
> +	MCP356X_V_CHANNEL_DIFF(0, 1, 0x01, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 0, 0x10, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 2, 0x02, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 3, 0x03, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 2, 0x12, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 3, 0x13, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 3, 0x23, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 0, 0x20, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 0, 0x30, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 1, 0x21, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 1, 0x31, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 2, 0x32, depth),	\
> +}
> +
> +#define MCP3564_CHANNELS(depth) {			\
> +	MCP356X_V_CHANNEL(0, 0, depth),			\
> +	MCP356X_V_CHANNEL(1, 1, depth),			\
> +	MCP356X_V_CHANNEL(2, 2, depth),			\
> +	MCP356X_V_CHANNEL(3, 3, depth),			\
> +	MCP356X_V_CHANNEL(4, 4, depth),			\
> +	MCP356X_V_CHANNEL(5, 5, depth),			\
> +	MCP356X_V_CHANNEL(6, 6, depth),			\
> +	MCP356X_V_CHANNEL(7, 7, depth),			\
> +	MCP356X_T_CHAN(depth),				\
> +	MCP356X_V_CHANNEL_DIFF(0, 1, 0x01, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 0, 0x10, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 2, 0x02, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 3, 0x03, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 2, 0x12, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 3, 0x13, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 3, 0x23, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 0, 0x20, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 0, 0x30, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 1, 0x21, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 1, 0x31, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 2, 0x32, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 4, 0x04, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 5, 0x05, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 6, 0x06, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(0, 7, 0x07, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 4, 0x14, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 5, 0x15, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 6, 0x16, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(1, 7, 0x17, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 4, 0x24, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 5, 0x25, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 6, 0x26, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(2, 7, 0x27, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 4, 0x34, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 5, 0x35, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 6, 0x36, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(3, 7, 0x37, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 5, 0x45, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 6, 0x46, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 7, 0x47, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 6, 0x56, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 7, 0x57, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 7, 0x67, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 0, 0x40, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 0, 0x50, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 0, 0x60, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 0, 0x70, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 1, 0x41, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 1, 0x51, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 1, 0x61, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 1, 0x71, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 2, 0x42, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 2, 0x52, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 2, 0x62, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 2, 0x72, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(4, 3, 0x43, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 3, 0x53, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 3, 0x63, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 3, 0x73, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(5, 4, 0x54, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 4, 0x64, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 4, 0x74, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(6, 5, 0x65, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 5, 0x75, depth),	\
> +	MCP356X_V_CHANNEL_DIFF(7, 6, 0x76, depth)	\
> +}
> +
> +static const struct iio_chan_spec mcp3461_channels[] =3D MCP3561_CHANNEL=
S(16);
> +static const struct iio_chan_spec mcp3462_channels[] =3D MCP3562_CHANNEL=
S(16);
> +static const struct iio_chan_spec mcp3464_channels[] =3D MCP3564_CHANNEL=
S(16);
> +static const struct iio_chan_spec mcp3561_channels[] =3D MCP3561_CHANNEL=
S(24);
> +static const struct iio_chan_spec mcp3562_channels[] =3D MCP3562_CHANNEL=
S(24);
> +static const struct iio_chan_spec mcp3564_channels[] =3D MCP3564_CHANNEL=
S(24);
> +
> +static const struct mcp356x_chip_info mcp356x_chip_infos_tbl[] =3D {
> +	[mcp3461] =3D {
> +		.channels =3D mcp3461_channels,

Put the name in each of these as well as it avoids trying to extract it from
the id tables which tends to be error prone as a driver evolves over time.

> +		.num_channels =3D ARRAY_SIZE(mcp3461_channels),
> +		.int_vref_uv =3D 0,
> +		.has_vref =3D false
This is enough to decide whether the vref is optional. So use it for that.
> +	},
> +	[mcp3462] =3D {
> +		.channels =3D mcp3462_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3462_channels),
> +		.int_vref_uv =3D 0,
> +		.has_vref =3D false
> +	},
> +	[mcp3464] =3D {
> +		.channels =3D mcp3464_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3464_channels),
> +		.int_vref_uv =3D 0,
> +		.has_vref =3D false
> +	},
> +	[mcp3461r] =3D {
> +		.channels =3D mcp3461_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3461_channels),
> +		.int_vref_uv =3D MCP356XR_INT_VREF_MV,
> +		.has_vref =3D true
> +	},
> +	[mcp3462r] =3D {
> +		.channels =3D mcp3462_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3462_channels),
> +		.int_vref_uv =3D MCP356XR_INT_VREF_MV,
> +		.has_vref =3D true
> +	},
> +	[mcp3464r] =3D {
> +		.channels =3D mcp3464_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3464_channels),
> +		.int_vref_uv =3D MCP356XR_INT_VREF_MV,
> +		.has_vref =3D true
> +	},
> +	[mcp3561] =3D {
> +		.channels =3D mcp3561_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3561_channels),
> +		.int_vref_uv =3D 0,
> +		.has_vref =3D false
> +	},
> +	[mcp3562] =3D {
> +		.channels =3D mcp3562_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3562_channels),
> +		.int_vref_uv =3D 0,
> +		.has_vref =3D false
> +	},
> +	[mcp3564] =3D {
> +		.channels =3D mcp3564_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3564_channels),
> +		.int_vref_uv =3D 0,
> +		.has_vref =3D false
> +	},
> +	[mcp3561r] =3D {
> +		.channels =3D mcp3561_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3561_channels),
> +		.int_vref_uv =3D MCP356XR_INT_VREF_MV,
> +		.has_vref =3D true
> +	},
> +	[mcp3562r] =3D {
> +		.channels =3D mcp3562_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3562_channels),
> +		.int_vref_uv =3D MCP356XR_INT_VREF_MV,
> +		.has_vref =3D true
> +	},
> +	[mcp3564r] =3D {
> +		.channels =3D mcp3564_channels,
> +		.num_channels =3D ARRAY_SIZE(mcp3564_channels),
> +		.int_vref_uv =3D MCP356XR_INT_VREF_MV,
> +		.has_vref =3D true
> +	},
> +};
> +
> +static int mcp356x_read_single_value(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *channel,
> +				     int *val)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	int ret, tmp, ret_read =3D 0;

	int ret, tmp;
	int reg_read =3D 0;
That is keep the cases that set a value on separate lines from ones that do=
n't
for readability.

> +
> +	/* Configure MUX register with the requested channel */
Obvious from code - so drop the comment.

> +	ret =3D mcp356x_write(adc, MCP356X_MUX, channel->address, 1);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to configure MUX register\n");
> +		return ret;
> +	}
> +
> +	/* ADC Conversion starts by writing ADC_MODE[1:0] =3D 11 to CONFIG0[1:0=
] =3D  */
> +	ret =3D mcp356x_update(adc, MCP356X_CONFIG0, MCP356X_ADC_MODE_MASK,
> +			     MCP356X_ADC_CONVERSION_MODE, 1);
> +	if (ret) {
> +		dev_err(&indio_dev->dev,
> +			"Failed to configure CONFIG0 register\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Check if the conversion is ready. If not, wait a little bit, and
> +	 * in case of timeout exit with an error.
> +	 */
> +
> +	ret =3D read_poll_timeout(mcp356x_read, ret_read,
> +				ret_read || !(tmp & MCP356X_DATA_READY_MASK),
> +				1000, MCP356X_DATA_READY_TIMEOUT_MS * 1000, true,
> +				adc, MCP356X_IRQ, &tmp, 1);
> +
> +	/* failed to read status register */
> +	if (ret_read)
> +		return ret;
> +
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	if (tmp & MCP356X_DATA_READY_MASK)
> +		/* failing to finish conversion */
> +		return -EBUSY;
> +
> +	ret =3D mcp356x_read(adc, MCP356X_ADCDATA, &tmp, 4);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D tmp;
> +
> +	return ret;
> +}
> +
> +static int mcp356x_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *channel,
> +			      const int **vals, int *type,
> +			      int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*type =3D IIO_VAL_INT;
> +		*vals =3D mcp356x_oversampling_avail;
> +		*length =3D ARRAY_SIZE(mcp356x_oversampling_avail);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*type =3D IIO_VAL_FRACTIONAL;
> +		*length =3D ARRAY_SIZE(mcp356x_hwgain_frac);
> +		*vals =3D mcp356x_hwgain_frac;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals =3D mcp356x_calib_bias;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*vals =3D mcp356x_calib_scale;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp356x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&adc->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D mcp356x_read_single_value(indio_dev, channel, val);
> +		if (ret)
> +			ret =3D -EINVAL;
> +		else
> +			ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D adc->vref_mv;
> +		*val2 =3D channel->scan_type.realbits - 1;
> +		ret =3D IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D mcp356x_oversampling_avail[adc->oversampling];
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*val =3D mcp356x_hwgain_frac[2 * adc->hwgain];
> +		*val2 =3D mcp356x_hwgain_frac[(2 * adc->hwgain) + 1];
> +		ret =3D IIO_VAL_FRACTIONAL;
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val =3D adc->calib_bias;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val =3D adc->calib_scale;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int mcp356x_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel, int val,
> +			     int val2, long mask)
> +{
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +	int tmp;
> +	int ret =3D -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < mcp356x_calib_bias[0] && val > mcp356x_calib_bias[2])
> +			goto out;
> +
> +		adc->calib_bias =3D val;
> +		ret =3D mcp356x_write(adc, MCP356X_OFFSETCAL, val, 3);
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val < mcp356x_calib_bias[0] && val > mcp356x_calib_bias[2])
> +			goto out;
> +
> +		adc->calib_scale =3D val;
> +		ret =3D mcp356x_write(adc, MCP356X_GAINCAL, val, 3);
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val < 0)
> +			goto out;
> +
> +		adc->oversampling =3D find_closest(val, mcp356x_oversampling_avail,
> +						 ARRAY_SIZE(mcp356x_oversampling_avail));
> +
> +		dev_dbg(&adc->spi->dev,
> +			"IIO_CHAN_INFO_OVERSAMPLING_RATIO index %d\n",
> +			adc->oversampling);
> +
> +		ret =3D mcp356x_update(adc, MCP356X_CONFIG1, MCP356X_OVERSAMPLING_RATI=
O_MASK,
> +				     (adc->oversampling << MCP356X_OVERSAMPLING_RATIO_SHIFT),

FIELD_PREP() and no need to define the shift

> +				     1);
> +		if (ret)
> +			dev_err(&indio_dev->dev,
> +				"Failed to configure CONFIG1 register\n");
> +
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
As per comments above, I'd imagine that the raw value needs to be multiplied
by a factor related to the gain.  Thus control this with _SCALE not _HARDWA=
REGAIN.

> +		/*
> +		 * calculate gain from read values.
> +		 * avoid using fractional numbers so
> +		 * multiply the value with 1000. In case of x1/3 gain
> +		 * the tmp will be 300
> +		 */
> +		tmp =3D ((val * 1000000) + val2) / 1000;
> +		if (tmp < 1 || tmp > MAX_HWGAIN)
> +			goto out;
> +
> +		adc->hwgain =3D find_closest(tmp, mcp356x_hwgain,
> +					   ARRAY_SIZE(mcp356x_hwgain));
> +
> +		dev_dbg(&adc->spi->dev,
> +			"IIO_CHAN_INFO_HARDWAREGAIN Gain:%d; index %d\n",
> +			tmp, adc->hwgain);
> +
> +		/* Update GAIN in CONFIG2[5:3] -> GAIN[2:0]*/
> +		ret =3D mcp356x_update(adc, MCP356X_CONFIG2, MCP356X_HARDWARE_GAIN_MAS=
K,
> +				     (adc->hwgain << MCP356X_HARDWARE_GAIN_SHIFT), 1);
FIELD_PREP()

> +		if (ret)
> +			dev_err(&indio_dev->dev,
> +				"Failed to configure CONFIG0 register\n");
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int mcp356x_config(struct mcp356x_state *adc)
> +{
> +	int ret =3D 0;
> +	unsigned int tmp;
> +
> +	dev_dbg(&adc->spi->dev, "%s: Start config...\n", __func__);
A lot of debug prints. They are only wort keeping in a production driver if=
 you
can't get the same info from ftrace and similar.  This one you can, so dro =
it.
> +
> +	/*
> +	 * The address is set on a per-device basis by fuses in the factory,
> +	 * configured on request. If not requested, the fuses are set for 0x1.
> +	 * The device address is part of the device markings to avoid
> +	 * potential confusion. This address is coded on two bits, so four poss=
ible
> +	 * addresses are available when multiple devices are present on the same
> +	 * SPI bus with only one Chip Select line for all devices.
> +	 */
> +	device_property_read_u32(&adc->spi->dev, "microchip,hw-device-address",=
 &tmp);
> +
> +	if (tmp > 3) {
> +		dev_err_probe(&adc->spi->dev, tmp,
> +			      "invalid device address. Must be in range 0-3.\n");
> +		return -EINVAL;
> +	}
> +
> +	adc->dev_addr =3D 0xff & tmp;
> +
> +	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> +
> +	ret =3D mcp356x_read(adc, MCP356X_RESERVED_E, &tmp, 2);
> +
	if (ret < 0)
		return ret;

Then no need for if (ret =3D=3D 0)


> +	if (ret =3D=3D 0) {
> +		switch (tmp & MCP356X_HW_ID_MASK) {
> +		case MCP3461_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3461 chip\n");

If detectable, then you don't need (or indeed want) to have the device
specific data selected from the dt compatible.  Select it based on what
is actually present. However, you can warn about a missmatch if you like.

> +			break;
> +		case MCP3462_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3462 chip\n");
> +			break;
> +		case MCP3464_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3464 chip\n");
> +			break;
> +		case MCP3561_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3561 chip\n");
> +			break;
> +		case MCP3562_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3562 chip\n");
> +			break;
> +		case MCP3564_HW_ID:
> +			dev_dbg(&adc->spi->dev, "Found MCP3564 chip\n");
> +			break;
> +		default:
> +			dev_err_probe(&adc->spi->dev, tmp,
> +				      "Unknown chip found\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		return ret;
> +	}
> +
> +	/* Command sequence that ensures a recovery with

Multi line comment syntax wrong (see below).

> +	 * the desired settings in any cases of loss-of-power scenario.
> +	 */
> +
> +	/* Write LOCK register to 0xA5 (Write Access Password)
> +	 * Write access is allowed on the full register map.
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_LOCK, 0x000000A5, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Write IRQ register to 0x03 */

Two comments next to each other need combining into a single multi line
comment.

> +	/* IRQ --> IRQ Mode =3D Hi-Z IRQ Output  --> (0b00000011).

Feels like this should be controlled from device tree as the pull up may
not be present on some boards.  Why set this, then reset device?


> +	 * IRQ =3D 0x00000003
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_IRQ, 0x00000003, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Device Full Reset Fast Command */
Naming is self explanatory so drop the comment.
> +	ret =3D mcp356x_fast_cmd(adc, MCP356X_FULL_RESET_CMD);
> +
Check ret

> +	/* wait 1ms for the chip to restart after a full reset */
Another obvious comment that isn't needed.
> +	mdelay(1);
> +
> +	/* Reconfigure the ADC chip  */
Also not needed.

> +
> +	/* GAINCAL --> Disabled.
> +	 * Default value is GAINCAL =3D 0x00800000; which provides a gain of 1x
> +	 */

Use a define to make the magic value 0x00800000 meaning obvious. I assume i=
t's
some field of a larger register?  If so FIELD_PREP() appropriate mask etc.

> +	ret =3D mcp356x_write(adc, MCP356X_GAINCAL, 0x00800000, 3);
> +	if (ret)
> +		return ret;
> +
> +	adc->calib_scale =3D 0x00800000;
Again, use a FIELD_PREP() to set it (bits 23-8 I think).
> +
> +	/* OFFSETCAL --> 0 Counts of Offset Cancellation
> +	 * (Measured offset is negative).
> +	 * OFFSETCAL =3D 0x0

Value obvious from code (or should be anyway).

> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_OFFSETCAL, 0x00000000, 3);

FIELD_PREP and appropriately defined mask.

> +	if (ret)
> +		return ret;
> +
> +	/* TIMER --> Disabled.
> +	 * TIMER =3D 0x00000000
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_TIMER, 0x00000000, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* SCAN --> Disabled.
> +	 * SCAN =3D 0x00000000
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_SCAN, 0x00000000, 3);

A bunch of different things in here. I'd expect to see this built from all =
the
different fields you aren't enabling so it's easy to see the state.

> +	if (ret)
> +		return ret;
> +
> +	/* MUX --> VIN+ =3D CH0, VIN- =3D CH1 --> (0b00000001).
> +	 * MUX =3D 0x00000001

Defines and field masks should make this obvious in the code - thus not
needing the comment.
Same for the similar register writes that follow.
There should need to be almost no comments in here because the
code should make it obvious what is being set and to what value.

> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_MUX, 0x00000001, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* IRQ --> IRQ Mode =3D Hi-Z IRQ Output  --> (0b00000011).
> +	 * IRQ =3D 0x00000003
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_IRQ, 0x00000003, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* CONFIG3
> +	 * Conv. Mod =3D One-Shot/Standby,
> +	 * FORMAT =3D 32-bit (right justified data): SGN extension + ADC data,
> +	 * CRC_FORMAT =3D 16b, CRC-COM =3D Disabled,
> +	 * OFFSETCAL =3D Enabled, GAINCAL =3D Enabled --> (10100011).
> +	 * CONFIG3 =3D 0x000000A3
> +	 *
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_CONFIG3, 0x000000A3, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* CONFIG2 --> BOOST =3D 1x, GAIN =3D 1x, AZ_MUX =3D 1 --> (0b10001101).
> +	 * CONFIG2 =3D 0x0000008D
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_CONFIG2, 0x0000008D, 1);
> +	if (ret)
> +		return ret;
> +
> +	adc->hwgain =3D 0x01;
> +	adc->auto_zeroing_mux =3D true;
> +	adc->auto_zeroing_ref =3D false;
> +	adc->current_boost_mode =3D MCP356X_BOOST_CURRENT_x1_00;
> +
> +	/* CONFIG1 --> AMCLK =3D MCLK, OSR =3D 98304 --> (0b00111100).
> +	 * CONFIG1 =3D 0x0000003C
> +	 */
> +	ret =3D mcp356x_write(adc, MCP356X_CONFIG1, 0x0000003C, 1);
> +	if (ret)
> +		return ret;
> +
> +	adc->oversampling =3D 0x0F;
> +
> +	if (!adc->vref) {
> +		/* CONFIG0 --> VREF_SEL =3D Internal Voltage Reference 2.4v
> +		 * CLK_SEL =3D INTOSC w/o CLKOUT, CS_SEL =3D No Bias,
> +		 * ADC_MODE =3D Standby Mode --> (0b11100010).
> +		 * CONFIG0 =3D 0x000000E2
> +		 */
> +		ret =3D mcp356x_write(adc, MCP356X_CONFIG0, 0x000000E2, 1);

Build the value into a local variable, then have the write after the
if/else using that variable.

> +
> +		dev_dbg(&adc->spi->dev, "%s: Using internal Vref\n",
> +			__func__);
> +		adc->vref_mv =3D MCP356XR_INT_VREF_MV;
> +
> +	} else {
> +		/* CONFIG0 --> CLK_SEL =3D INTOSC w/o CLKOUT, CS_SEL =3D No Bias,
> +		 * ADC_MODE =3D Standby Mode --> (0b01100010).
> +		 * CONFIG0 =3D 0x000000E2
> +		 */
> +		ret =3D mcp356x_write(adc, MCP356X_CONFIG0, 0x00000062, 1);
> +	}
> +	adc->current_bias_mode =3D MCP356X_CS_SEL_0_0_uA;
> +
> +	return ret;
> +}
> +
> +static int mcp356x_probe(struct spi_device *spi)
> +{
> +	int ret, device_index;
> +	struct iio_dev *indio_dev;
> +	struct mcp356x_state *adc;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> +			      "Can't allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc =3D iio_priv(indio_dev);
> +	adc->spi =3D spi;
> +
> +	dev_dbg(&adc->spi->dev, "%s: probe(spi =3D 0x%p)\n", __func__, spi);
> +
> +	adc->vref =3D devm_regulator_get_optional(&adc->spi->dev, "vref");

Is it always optional? If it's only for some parts, then enforce that by
first using spi_get_device_match_data() to get appropriate pointer to
a chip type specific structure, then have a flag in there that says if
is optional or not.  Adjust how it is retrieved to take that
into account.


> +	if (IS_ERR(adc->vref)) {
> +		if (PTR_ERR(adc->vref) =3D=3D -ENODEV) {
> +			adc->vref =3D NULL;
> +			dev_dbg(&adc->spi->dev, "%s: Using internal Vref\n",
> +				__func__);

In binding docs you mention that not all devices have an internal reference.
If the device doesn't have one we need to error out here.

> +		} else {
> +			dev_err_probe(&adc->spi->dev, PTR_ERR(adc->vref),
> +				      "failed to get regulator\n");
> +			return PTR_ERR(adc->vref);
> +		}
> +	} else {
> +		ret =3D regulator_enable(adc->vref);
> +		if (ret)
> +			return ret;

Add a devm_add_action_or_reset() fall here with appropriate callback to
turn off the regulator.=20

> +
> +		dev_dbg(&adc->spi->dev, "%s: Using External Vref\n",
> +			__func__);
> +
> +		ret =3D regulator_get_voltage(adc->vref);
> +		if (ret < 0) {
> +			dev_err_probe(&adc->spi->dev, ret,
> +				      "Failed to read vref regulator\n");
> +			goto error_disable_reg;
> +		}
> +
> +		adc->vref_mv =3D ret / 1000;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);

This probably won't be needed after you take the devm_add_action_or_reset()
route to getting rid of remove() as suggested below.

> +	device_index =3D spi_get_device_id(spi)->driver_data;

	spi_get_device_match_data() and add the data as pointers to where
you currently have the enum values + to the spi_device_id table.
This avoids need to be careful that entries align perfectly between those
two tables.

However you show above that the chip type is detectable. Better
to just detect it than rely on firmware telling you which one you have.

> +	adc->chip_info =3D &mcp356x_chip_infos_tbl[device_index];
> +
> +	adc->mcp356x_info.read_raw =3D mcp356x_read_raw;
> +	adc->mcp356x_info.write_raw =3D mcp356x_write_raw;
> +	adc->mcp356x_info.read_avail =3D mcp356x_read_avail;
> +
> +	ret =3D mcp356x_prep_custom_attributes(adc, indio_dev);
> +	if (ret) {
> +		dev_err_probe(&adc->spi->dev, ret,
> +			      "Can't configure custom attributes for MCP356X device\n");
> +		goto error_disable_reg;
> +	}
> +
> +	indio_dev->name =3D spi_get_device_id(spi)->name;

This requires careful matching between the entries in the of and spi
ID tables. I'd rather the name was stored in part specific data so
your chip_infos_tbl[] entries.

> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &adc->mcp356x_info;
> +
> +	indio_dev->channels =3D adc->chip_info->channels;
> +	indio_dev->num_channels =3D adc->chip_info->num_channels;
> +	indio_dev->masklength =3D adc->chip_info->num_channels - 1;

You should not be setting that directly. Leave it to the IIO core.

> +
> +	/* initialize the chip access mutex */

Don't have any comments that state the obvious.  The mutex scope
is defined above and doesn't need repeating here.

> +	mutex_init(&adc->lock);
> +
> +	/* Do any chip specific initialization, e.g:

IIO multi-line comments are
	/*
	 * Do any ...

> +	 * read/write some registers
> +	 * enable/disable certain channels
> +	 * change the sampling rate to the requested value
> +	 */
> +	ret =3D mcp356x_config(adc);
> +	if (ret) {
> +		dev_err_probe(&adc->spi->dev, ret,
> +			      "Can't configure MCP356X device\n");
> +		goto error_disable_reg;
> +	}
> +
> +	dev_dbg(&adc->spi->dev, "%s: Vref (mV): %d\n", __func__, adc->vref_mv);
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret) {
> +		dev_err_probe(&adc->spi->dev, ret,
> +			      "Can't register IIO device\n");
> +		goto error_disable_reg;
> +	}
> +
> +	return 0;
> +
> +error_disable_reg:
> +	if (adc->vref)

Use devm_add_action_or_reset() and this goes away as all error caused
unwinding automatically handled.

> +		regulator_disable(adc->vref);
> +
> +	return ret;
> +}
> +
> +static void mcp356x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +	struct mcp356x_state *adc =3D iio_priv(indio_dev);
> +
> +	if (adc->vref)
> +		regulator_disable(adc->vref);
Use a devm_add_action_or_reset() in probe() to ensure this is turned off at
the right point in the right point in the sequence.  Right now you turn it
off before the userspace interfaces are removed leaving a race where a read=
ing
might be taken despite the reference being off.

> +}
> +
> +static const struct of_device_id mcp356x_dt_ids[] =3D {
> +	{ .compatible =3D "microchip,mcp3461" },
> +	{ .compatible =3D "microchip,mcp3462" },
> +	{ .compatible =3D "microchip,mcp3464" },
> +	{ .compatible =3D "microchip,mcp3461r" },
> +	{ .compatible =3D "microchip,mcp3462r" },
> +	{ .compatible =3D "microchip,mcp3464r" },
> +	{ .compatible =3D "microchip,mcp3561" },
> +	{ .compatible =3D "microchip,mcp3562" },
> +	{ .compatible =3D "microchip,mcp3564" },
> +	{ .compatible =3D "microchip,mcp3561r" },
> +	{ .compatible =3D "microchip,mcp3562r" },
> +	{ .compatible =3D "microchip,mcp3564r" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp356x_dt_ids);
> +
> +static const struct spi_device_id mcp356x_id[] =3D {
> +	{ "mcp3461",  mcp3461 },

Much prefer the data here to both be replicated in the above
of_device_id table and to be a pointer to a device type specific
structure with information about what a particular device supports.

> +	{ "mcp3462",  mcp3462 },
> +	{ "mcp3464",  mcp3464 },
> +	{ "mcp3461r", mcp3461r },
> +	{ "mcp3462r", mcp3462r },
> +	{ "mcp3464r", mcp3464r },
> +	{ "mcp3561",  mcp3561 },
> +	{ "mcp3562",  mcp3562 },
> +	{ "mcp3564",  mcp3564 },
> +	{ "mcp3561r", mcp3561r },
> +	{ "mcp3562r", mcp3562r },
> +	{ "mcp3564r", mcp3564r },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, mcp356x_id);
> +
> +static struct spi_driver mcp356x_driver =3D {
> +	.driver =3D {
> +		.name =3D "mcp3564",
> +		.of_match_table =3D mcp356x_dt_ids,
> +	},
> +	.probe =3D mcp356x_probe,
> +	.remove =3D mcp356x_remove,
> +	.id_table =3D mcp356x_id,
> +};
> +
> +module_spi_driver(mcp356x_driver);
> +
> +MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> +MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs=
");
> +MODULE_LICENSE("GPL v2");

