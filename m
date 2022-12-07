Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29A646311
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLGVLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLGVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:10:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63073F6E;
        Wed,  7 Dec 2022 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670447414; x=1701983414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtXPm73TQE1igv2+AuaMTBvBWWXlqUK8fRBvyXcN/Og=;
  b=lEgJPet6yz0UyAq+tf0yRh0gV35vJScxvY/4JDEACYBBK2bDamjrDDpD
   9b/SOCDN6QA5O2eiNCNeXRwXm04HS/JxbMhe7PpY+DcBSN1SMQ7jpe8Au
   H47UEaM7SECCypB1olXQ4MaWm+yAp7509g60r6mQKXFmUJCZvs0Fq2/T0
   7IqWBw6P5Thl0CcUdjmR4t9ZNXNa3R5kR0GxNdX06xh8zSnoS4VfZWd49
   W+KAFl7Yb5ZuiAde0bxrSnNb/8mCJWecsxIQWaj7uGVYxKeV/Z3TarJcv
   O/5OpFOAJTychAPQxAWd5xCPadpJNB5qLPWRgGtwET7J0dCt4a7NRuXOB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="379173336"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="379173336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="735537370"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="735537370"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2022 13:10:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p31g8-005ziT-2i;
        Wed, 07 Dec 2022 23:10:08 +0200
Date:   Wed, 7 Dec 2022 23:10:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [RFC 1/3] mfd: Add support for UP board CPLD/FPGA
Message-ID: <Y5EBMCWEPgCFPnMj@smile.fi.intel.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
 <20221207163359.26564-2-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207163359.26564-2-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:33:57AM +0800, larry.lai wrote:
> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.
> 
> This mfd driver implements the line protocol to read and write registers
> from the FPGA through regmap. The register address map is also included.
> 
> The UP Boards provide a few I/O pin headers (for both GPIO and
> functions), including a 40-pin Raspberry Pi compatible header.
> 
> This patch implements support for the FPGA-based pin controller that
> manages direction and enable state for those header pins.
> 
> Partial support UP boards:
> * UP core + CREX
> * UP core + CRST02

...

> +#include <linux/acpi.h>
> +#include <linux/dmi.h>

> +#include <linux/gpio.h>

I'm not sure if you read my previous emails regarding the topic.
This header must not be in the new code.

> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/upboard-fpga.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>


Missing bits.h and err.h at least.

...

> +struct upboard_fpga_data {
> +	const struct regmap_config *regmapconf;

No need to repeat regmap twice.

> +	const struct mfd_cell *cells;
> +	size_t ncells;
> +};

...

> +#define MENUFACTURER_ID_MASK		0xFF

GENMASK()?

...

> +#define FIRMWARE_ID_MASK		0xF

Ditto.

...

> +/* Apollo Lake GPIO pin number mapping to FPGA LED */
> +#define APL_GPIO_218			507

No way. It should be addressed as GPIO chip reference and relative pin
(or GPIO, whichever suits better for your purposes) number.

...

> +/* For UP Board Series FPGA register read/write protocols 		      */
> +/* EMUTEX specs: 						              */
> +/* D0   D1  D2  D3  D4  D5  D6  D7  D8  D9 .... D22  D23                      */
> +/* [RW][        address           ][	    DATA        ]                     */
> +
> +/* Read Sequence:                                                             */
> +/*      ___   ____________________________________________________   _________*/
> +/* clr:    \_/ <--low-pulse does start the write-readback         \_/<--start */
> +/*	          sequence with partital reset of internal 	  new sequence*/
> +/*	          registers but the CONF-REG. 	  		              */
> +/*        ____________________________________________________________________*/
> +/* rst: _/       _   _   _        _   _   _   __       __   __   _            */
> +/* stb: STB#1->_/1\_/2\_/3\_...._/7\_/8\_/9\_/10\_..../23\_/24\_/<-STB#25 edge*/
> +/*						                   is needed  */
> +/*	  						           to ACK     */
> +/*             (D0 - D7 stb rising latch)                                     */
> +/* data_in:     D0  D1  D2  .... D6  D7  don't ........ care(DC)              */
> +/* data_out:    don't ...........care(DC)  D8   D9 ....  D22  D23   	      */
> +/*					  (D8 - D23 stb falling latch) 	      */
> +/* flag_Read:				  _________...._________              */
> +/*      __DC_   ____________...._________/                      \_            */
> +/* counter:								      */
> +/*    [00]DC[00][01][02] ............[08][9][10]............[24][00]	      */
> +/* CONF-REG:					                              */
> +/*    [00] [				CONF-REG               ]              */
> +/* wreg:   							              */
> +/*    [00]DC[00][  wreg=SHFT(wreg)  ][ADR][DATA][wreg=SHFT(wreg]	      */
> +/* wreg2:		  						      */
> +/*    					  [	   (COPY)=ADDR ]	      */

This has too many /* */ and TABs vs space mix... Please, fix it.

Is it SPI 24-bit bit-banging? Why spi-gpio can't be utilized for it?

...

> +/* Write Sequence:                                                   	      */
> +/*      ___   ____________________________________________________   _________*/
> +/* clr:    \_/ <--low-pulse does start the write-readback         \_/<--start */
> +/*	          sequence with partital reset of internal 	  new sequence*/
> +/*	          registers but the CONF-REG. 	  			      */
> +/*        ____________________________________________________________________*/
> +/* rst: _/       _   _   _        _   _   _   __       __   __   _            */
> +/* stb: STB#1->_/1\_/2\_/3\_...._/7\_/8\_/9\_/10\_..../23\_/24\_/<-STB#25 edge*/
> +/*						                   is needed  */
> +/*								   to ACK     */
> +/*             (D0 - D23 stb rising latch)                                    */
> +/* data_in:     D0  D1  D2  .... D6  D7  D8  D9 ....  D22  D23                */
> +/* data_out:    don't ................................care (DC)               */
> +/* flag_Read:			 					      */
> +/*      __DC_   ____________....__________________________________            */
> +/* counter:								      */
> +/*    [00]DC[00][01][02] ............[08][9][10]............[24][00]          */
> +/* wreg:								      */
> +/*    [00]DC[00][wreg=SHFT(wreg)&dat_in ][SHFT(wreg)&dat_in][DAT]             */
> +/* wreg2:							              */
> +/*    					 [     (COPY)=ADDR     ]	      */
> +/* CONF-REG:								      */
> +/*    [00] [	     CONF-REG = OLD VALUE		       ][CONF-REG=DAT]*/


Same comments as per above.

...

> +		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);

!!(reg & BIT(i))

...

> +		gpiod_set_value(fpga->datain_gpio, (val >> i) & 0x1);

Ditto.

But see above.

...

> +static struct gpio_led upboard_gpio_leds[] = {
> +	{
> +		.name = "upboard:blue:",
> +		.gpio = APL_GPIO_218,

You must understand that it won't work with dynamic GPIO bases which will be
enabled in v6.2-rc1. And even in general it must not be like this.

> +		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
> +	},
> +};

...

> +	enum gpiod_flags flags;
> +
> +	flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;

Can be united.

...

> +	/*
> +	 * The SoC pinctrl driver may not support reserving the GPIO line for
> +	 * FPGA reset without causing an undesired reset pulse. This will clear
> +	 * any settings on the FPGA, so only do it if we must.
> +	 * Reset gpio defaults HIGH, get gpio and set to LOW, then set back to
> +	 * HIGH as a pulse.
> +	 */
> +	if (fpga->uninitialised) {
> +		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset", GPIOD_OUT_LOW);
> +		if (IS_ERR(fpga->reset_gpio))
> +			return PTR_ERR(fpga->reset_gpio);

No sleep for the hardware to be really reset?

> +		gpiod_set_value(fpga->reset_gpio, 1);
> +	}

> +/*
> + * MFD upboard-fpga is acpi driver and can recognize the AANT ID from different

ACPI

> + * kind of upboards. We get the led gpio initialized information from this

LED GPIO

> + * then add led-upboard driver.
> + */

...

> +	int blue_gpio = -1, yellow_gpio = -1, green_gpio = -1, red_gpio = -1;

NAK.

...

> +		blue_gpio = desc_to_gpio(desc);

NAK.

...

> +		yellow_gpio = desc_to_gpio(desc);

NAK.

...

> +		green_gpio = desc_to_gpio(desc);

NAK.

...

> +		red_gpio = desc_to_gpio(desc);

NAK.

...

> +/*
> + *	Refer https://www.kernel.org/doc/htmldocs/writing_musb_glue_layer/device-platform-data.html,
> + *	the id field could be set to -1 (equivalent to PLATFORM_DEVID_NONE),
> + *  -2 (equivalent to PLATFORM_DEVID_AUTO) or start with 0 for the first
> + *	device of this kind if we want a specific id number.
> + */

Useless comment. Just use the proper definition.

> +	if (devm_mfd_add_devices(fpga->dev, 0,
> +				 upboard_gpio_led_cells,
> +				 ARRAY_SIZE(upboard_gpio_led_cells),
> +				 NULL, 0, NULL)) {
> +		dev_info(fpga->dev, "Failed to add GPIO leds");
> +	}


	ret = ...(...);
	if (ret)
		dev_warn(...);


...

> +	/* get fpga/EC protocol hardware version */
> +	acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev), "_HRV", NULL, &hrv);

No error check?

...

> +	system_id = dmi_first_match(upboard_dmi_table);
> +	if (system_id)
> +		quirks = (unsigned long)system_id->driver_data;
> +
> +	if (hrv == UPFPGA_PROTOCOL_V1_HRV &&
> +	    (quirks & UPFPGA_QUIRK_HRV1_IS_PROTO2))
> +		hrv = UPFPGA_PROTOCOL_V2_HRV;

Maybe it's easier to provide driver data?

...

> +	fpga_data = (const struct upboard_fpga_data *) id->driver_data;


Use device_get_match_data().

...

> +	if (quirks & UPFPGA_QUIRK_UNINITIALISED) {
> +		dev_info(&pdev->dev, "FPGA not initialised by this BIOS");

dev_warn()?

> +		fpga->uninitialised = true;
> +	}

...

> +	dev_set_drvdata(&pdev->dev, fpga);

platform_set_drvdata().

> +	fpga->dev = &pdev->dev;
> +	fpga->regmap = devm_regmap_init(&pdev->dev, NULL,
> +					fpga, fpga_data->regmapconf);

Can be one line and you can actually have

	struct device *dev = &pdev->dev;

at the top of the function.

> +	fpga->regmapconf = fpga_data->regmapconf;

Why is it done if you know that error might happen?

> +	if (IS_ERR(fpga->regmap))
> +		return PTR_ERR(fpga->regmap);

...

> +	/* gpio leds initialize */

GPIO LEDs

...

> +		ret =  devm_mfd_add_devices(&pdev->dev, 0,

Use proper definition.

> +					    upboard_gpio_led_cells,
> +					    ARRAY_SIZE(upboard_gpio_led_cells),
> +					    NULL, 0, NULL);

> +			dev_err(&pdev->dev, "Failed to add GPIO leds");
> +			return ret;

	return dev_err_probe();

> +		}
> +	}

+ blank line.

> +	return devm_mfd_add_devices(&pdev->dev, 0,

Use proper definition.

> +				    fpga_data->cells,
> +				    fpga_data->ncells,
> +				    NULL, 0, NULL);
> +}

...

Move ACPI ID table here, it's not needed to have it upper.

> +static struct platform_driver upboard_fpga_driver = {
> +	.driver = {
> +		.name = "upboard-fpga",
> +		.acpi_match_table = upboard_fpga_acpi_match,
> +	},
> +};

...

The header file missing several forward declarations and inclusions, like

#include <linux/types.h>

struct regmap;

-- 
With Best Regards,
Andy Shevchenko


