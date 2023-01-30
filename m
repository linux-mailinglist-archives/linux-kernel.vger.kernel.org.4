Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC99680C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjA3L5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3L5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:57:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D71350C;
        Mon, 30 Jan 2023 03:56:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 970A3B8101B;
        Mon, 30 Jan 2023 11:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9E9C433D2;
        Mon, 30 Jan 2023 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675079816;
        bh=88xHB3ATTJ6+C5a9hnzEUZbsVGGPB+7/QUjrMTIT5F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akmjvx88bthjCgD6/rN+0g1+hhb/SDFgvA7IsJkPXyuaZvk+aN6UH8ToYVmrBux72
         MN8rZEBDPDpVWex8ttf0PkEsal3afI0scKquvAq7NFi23bdyvW7e5CVN/hYUwGV/I+
         CAMjNQaxamRD5QN6QxP3e1gf2Rh/oaW/3p8a2gJC3wQZo/PBxKlyVrgnFfcWLMgjxp
         gzQzhZ5FdHHQSikCBA0qvlki28bKuaM12k5Rr2lBcykP7hIed65puWhHEr9yTDhCru
         M7l8RdLeR0CENNJSum2WWK8uptE7YzSCVZXGCittYNiBWuK/vbmgNv/yuXtD3A3WlU
         KWfU8AGa033jw==
Date:   Mon, 30 Jan 2023 11:56:50 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, krzysztof.kozlowski@linaro.org,
        Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [RESEND PATCH v5 1/2] leds: flash: add driver to support flash
 LED module in QCOM PMICs
Message-ID: <Y9ewgukk4jPoBOFZ@google.com>
References: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
 <20221227081523.2277797-2-quic_fenglinw@quicinc.com>
 <Y9J+5OZQ5Fv60T3V@google.com>
 <97e75fe1-f4cc-3cb6-9c16-b91fbd0bdee5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97e75fe1-f4cc-3cb6-9c16-b91fbd0bdee5@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023, Fenglin Wu wrote:

> Hi Jones,
> 
> Thanks for reviewing the driver!
> Replies inline.
> 
> 
> On 2023/1/26 21:23, Lee Jones wrote:
> > On Tue, 27 Dec 2022, Fenglin Wu wrote:
> > 
> > > Add initial driver to support flash LED module found in Qualcomm
> > > Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
> > > and each channel can be controlled indepedently and support full scale
> > > current up to 1.5 A. It also supports connecting two channels together
> > > to supply one LED component with full scale current up to 2 A. In that
> > > case, the current will be split on each channel symmetrically and the
> > > channels will be enabled and disabled at the same time.
> > > 
> > > Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> > > Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4 + pm6150l
> > > ---
> > >   drivers/leds/flash/Kconfig           |  15 +
> > >   drivers/leds/flash/Makefile          |   1 +
> > >   drivers/leds/flash/leds-qcom-flash.c | 701 +++++++++++++++++++++++++++
> > >   3 files changed, 717 insertions(+)
> > >   create mode 100644 drivers/leds/flash/leds-qcom-flash.c
> > > 
> > > diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
> > > index d3eb689b193c..f36a60409290 100644
> > > --- a/drivers/leds/flash/Kconfig
> > > +++ b/drivers/leds/flash/Kconfig
> > > @@ -61,6 +61,21 @@ config LEDS_MT6360
> > >   	  Independent current sources supply for each flash LED support torch
> > >   	  and strobe mode.
> > > +config LEDS_QCOM_FLASH
> > > +	tristate "LED support for flash module inside Qualcomm Technologies, Inc. PMIC"
> > > +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> > > +	depends on LEDS_CLASS && OF
> > > +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> > > +	select REGMAP
> > > +	help
> > > +	  This option enables support for the flash module found in Qualcomm
> > > +	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
> > > +	  channels and each channel is programmable to support up to 1.5 A full
> > > +	  scale current. It also supports connecting two channels' output together
> > > +	  to supply one LED component to achieve current up to 2 A. In such case,
> > > +	  the total LED current will be split symmetrically on each channel and
> > > +	  they will be enabled/disabled at the same time.
> > > +
> > >   config LEDS_RT4505
> > >   	tristate "LED support for RT4505 flashlight controller"
> > >   	depends on I2C && OF
> > > diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
> > > index 0acbddc0b91b..8a60993f1a25 100644
> > > --- a/drivers/leds/flash/Makefile
> > > +++ b/drivers/leds/flash/Makefile
> > > @@ -6,6 +6,7 @@ obj-$(CONFIG_LEDS_AS3645A)	+= leds-as3645a.o
> > >   obj-$(CONFIG_LEDS_KTD2692)	+= leds-ktd2692.o
> > >   obj-$(CONFIG_LEDS_LM3601X)	+= leds-lm3601x.o
> > >   obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
> > > +obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
> > >   obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
> > >   obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
> > >   obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
> > > diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
> > > new file mode 100644
> > > index 000000000000..3735282b77e9
> > > --- /dev/null
> > > +++ b/drivers/leds/flash/leds-qcom-flash.c
> > > @@ -0,0 +1,701 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/leds.h>
> > > +#include <linux/led-class-flash.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/regmap.h>
> > > +#include <media/v4l2-flash-led-class.h>
> > > +
> > > +/* registers definitions */
> > > +#define FLASH_TYPE_REG			0x04
> > > +#define FLASH_TYPE_VAL			0x18
> > > +
> > > +#define FLASH_SUBTYPE_REG		0x05
> > > +#define FLASH_SUBTYPE_3CH_VAL		0x04
> > > +#define FLASH_SUBTYPE_4CH_VAL		0x07
> > > +
> > > +#define FLASH_TIMER_EN_BIT		BIT(7)
> > > +#define FLASH_TIMER_VAL_MASK		GENMASK(6, 0)
> > > +#define FLASH_TIMER_STEP_MS		10
> > > +
> > > +#define FLASH_STROBE_HW_SW_SEL_BIT	BIT(2)
> > > +#define SW_STROBE_VAL			0
> > > +#define HW_STROBE_VAL			1
> > > +#define FLASH_HW_STROBE_TRIGGER_SEL_BIT	BIT(1)
> > > +#define STROBE_LEVEL_TRIGGER_VAL	0
> > > +#define STROBE_EDGE_TRIGGER_VAL		1
> > > +#define FLASH_STROBE_POLARITY_BIT	BIT(0)
> > > +#define STROBE_ACTIVE_HIGH_VAL		1
> > > +
> > > +#define FLASH_IRES_MASK_4CH		BIT(0)
> > > +#define FLASH_IRES_MASK_3CH		GENMASK(1, 0)
> > > +#define FLASH_IRES_12P5MA_VAL		0
> > > +#define FLASH_IRES_5MA_VAL_4CH		1
> > > +#define FLASH_IRES_5MA_VAL_3CH		3
> > > +
> > > +/* constants */
> > > +#define FLASH_CURRENT_MAX_UA		1500000
> > > +#define TORCH_CURRENT_MAX_UA		500000
> > > +#define FLASH_TOTAL_CURRENT_MAX_UA	2000000
> > > +#define FLASH_CURRENT_DEFAULT_UA	1000000
> > > +#define TORCH_CURRENT_DEFAULT_UA	200000
> > > +
> > > +#define TORCH_IRES_UA			5000
> > > +#define FLASH_IRES_UA			12500
> > > +
> > > +#define FLASH_TIMEOUT_MAX_US		1280000
> > > +#define FLASH_TIMEOUT_STEP_US		10000
> > > +
> > > +enum hw_type {
> > > +	QCOM_MVFLASH_3CH,
> > > +	QCOM_MVFLASH_4CH,
> > > +};
> > > +
> > > +enum led_mode {
> > > +	FLASH_MODE,
> > > +	TORCH_MODE,
> > > +};
> > > +
> > > +enum led_strobe {
> > > +	SW_STROBE,
> > > +	HW_STROBE,
> > > +};
> > > +
> > > +enum {
> > > +	REG_STATUS1,
> > > +	REG_STATUS2,
> > > +	REG_STATUS3,
> > > +	REG_CHAN_TIMER,
> > > +	REG_ITARGET,
> > > +	REG_MODULE_EN,
> > > +	REG_IRESOLUTION,
> > > +	REG_CHAN_STROBE,
> > > +	REG_CHAN_EN,
> > > +	REG_MAX_COUNT,
> > > +};
> > > +
> > > +struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
> > > +	REG_FIELD(0x08, 0, 7),			/* status1	*/
> > > +	REG_FIELD(0x09, 0, 7),                  /* status2	*/
> > > +	REG_FIELD(0x0a, 0, 7),                  /* status3	*/
> > > +	REG_FIELD_ID(0x40, 0, 7, 3, 1),         /* chan_timer	*/
> > > +	REG_FIELD_ID(0x43, 0, 6, 3, 1),         /* itarget	*/
> > > +	REG_FIELD(0x46, 7, 7),                  /* module_en	*/
> > > +	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
> > > +	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
> > > +	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
> > > +};
> > > +
> > > +struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
> > > +	REG_FIELD(0x06, 0, 7),			/* status1	*/
> > > +	REG_FIELD(0x07, 0, 6),			/* status2	*/
> > > +	REG_FIELD(0x09, 0, 7),			/* status3	*/
> > > +	REG_FIELD_ID(0x3e, 0, 7, 4, 1),		/* chan_timer	*/
> > > +	REG_FIELD_ID(0x42, 0, 6, 4, 1),		/* itarget	*/
> > > +	REG_FIELD(0x46, 7, 7),			/* module_en	*/
> > > +	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
> > > +	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
> > > +	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
> > > +};
> > > +
> > > +struct qcom_flash_led {
> > > +	struct qcom_flash_chip		*chip;
> > 
> > Not a fan of these interwoven references.  Where 'chip' has a reverence
> > to 'led' and 'led' has a reference to 'chip'.
> > 
> >    chip->leds[0]->chip->leds[0]->chip ...
> > 
> > Either re-work your API (pass 'chip' and an LED index for example [this
> > may very well not be the correct solution) or use something akin to
> > container_of().
> > 
> 
> Done.
> 'container_of()' won't work here since the 'leds' is a pointer and the
> buffer is allocated dynamically according to the number of the flas LED
> device-tree sub-nodes. I will figure out how to avoid the interwoven
> reference and update.

Which is why I said "akin to".

> > > +	struct led_classdev_flash	flash;
> > > +	struct v4l2_flash		*v4l2_flash;
> > > +	u32				max_flash_current_ma;
> > > +	u32				max_torch_current_ma;
> > > +	u32				max_timeout_ms;
> > > +	u32				flash_current_ma;
> > > +	u32				flash_timeout_ms;
> > > +	u8				*chan_id;
> > > +	u8				chan_count;
> > > +	bool				enabled;
> > > +};
> > > +
> > > +struct qcom_flash_chip {
> > > +	struct qcom_flash_led	*leds;
> > > +	struct regmap_field     *r_fields[REG_MAX_COUNT];
> > > +	struct device		*dev;
> > > +	struct mutex		lock;
> > > +	enum hw_type		hw_type;
> > > +	u8			leds_count;
> > > +	u8			max_channels;
> > > +	u8			chan_en_bits;
> > > +};
> > > +
> > > +static int set_flash_module_en(struct qcom_flash_led *led, bool en)
> > > +{
> > > +	struct qcom_flash_chip *chip = led->chip;
> > > +	u8 led_mask = 0, val;
> > > +	int i, rc;
> > > +
> > > +	for (i = 0; i < led->chan_count; i++)
> > > +		led_mask |= BIT(led->chan_id[i] - 1);
> > > +
> > > +	mutex_lock(&chip->lock);
> > > +	if (en)
> > > +		chip->chan_en_bits |= led_mask;
> > > +	else
> > > +		chip->chan_en_bits &= ~led_mask;
> > > +
> > > +	val = !!chip->chan_en_bits;
> > > +	rc = regmap_field_write(chip->r_fields[REG_MODULE_EN], val);
> > 
> > I'm a little confused by this.
> > 
> > So we go through the process of flipping individual enable bits, then
> > trash all of that knowledge and end up writing an individual 0 or 1.
> > 
> > Why not replace the whole function with:
> > 
> >      regmap_field_write(chip->r_fields[REG_MODULE_EN], en);

I see, so chan_en_bits is the cache to all enabled channels.

> 'REG_MODULE_EN" is basically an overall gating register for all channels. It
> needs to be enabled when any channel is enabled and it can only be disabled
> after all channels are disabled.
> 
> > > +	if (rc < 0)
> > > +		dev_err(chip->dev, "write module_en failed, rc=%d\n", rc);
> > > +	mutex_unlock(&chip->lock);
> > > +
> > > +	return rc;
> > > +}
> > > +
> > > +static int set_flash_current(struct qcom_flash_led *led, u32 current_ma, enum led_mode mode)
> > > +{
> > > +	struct qcom_flash_chip *chip = led->chip;
> > > +	u32 itarg_ua = current_ma * 1000 / led->chan_count + 1;
> > 
> > Please make it clear what you're doing here.
> > 
> > I suggest you separate the allocation and the assignment and add a
> > comment to the latter.
> > 
> 
> Done.

Please snip replies.  You only need to provide responses for items
you're providing more info about.  It takes time to go read all of the
'done' comments that do not add value.

> > > +	/*
> > > +	 * Split the current across the channels and set the
> > > +	 * IRESOLUTION and ITARGET registers accordingly.
> > > +	 */
> > > +	for (i = 0; i < led->chan_count; i++) {
> > > +		chan_id = led->chan_id[i];
> > > +		if (itarg_ua < ires_ua)
> > > +			val = 0;
> > 
> > If you allocate 'val' in here and pre-assign it, you can negate the
> > logic and omit this branch.  Unless this is going to be multi-use, 'val'
> > is not a great name for a variable.
> > 
> 
> Done.
> I use 'val' to represent the variable is for caching the register value, I
> can update it to 'reg_val' or 'value'.

Those are equally terrible variable names.

 What is the name of the register you're writing to?

 What does it actually 'do'?

 What happens when that is written?

 What *is* the value?

'shared_ua` perhaps?  Not data, reg, or value please.

> > > +		val = min_t(u32, val, FLASH_CURRENT_MAX_UA * led->chan_count);
> > > +		val = min_t(u32, val, FLASH_TOTAL_CURRENT_MAX_UA);
> > > +		s = &flash->brightness;
> > 
> > 's' is not a good variable name.
> > 
> > > +		s->min = s->step = FLASH_IRES_UA * led->chan_count;
> > 
> > These get over-written before they are used.
> > 
> > Scrap that, I see that 's' gets reassigned.
> > 
> > Even more reason to change 's' for something else and use 2 variables
> > instead of one to make this point clear.
> > 
> > A few comments spread around the complex areas wouldn't go amiss either.
> > 
> 
> The 's' here is just a temporary pointer to simply the initial assignments
> to data members in 'flash->brightness' and 'flash->timeout' and both of them
> are 'struct flash_led_setting' type, so there won't be any places really use
> it.
> I can update it and use 'brightness' and 'timeout' if you suggest to use 2
> variables.

It just makes everything so much nicer to read if you use proper
human-friendly names for things.

-- 
Lee Jones [李琼斯]
