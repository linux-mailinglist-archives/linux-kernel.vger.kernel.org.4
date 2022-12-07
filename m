Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E742A646346
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLGVck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLGVch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:32:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D73B6;
        Wed,  7 Dec 2022 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670448754; x=1701984754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Boy6f1IbdP95LjK6U18wGNCSm3i0uKJ518Rnzce12TY=;
  b=BcIGmCnW+wn9ttmF84ZI0ZrkN245KEnQPggzl0OLTiNAS3TsffTk+jW0
   fVcyFPAJwz+bGBibXnNuzSGlNI9oRtKmoOk5A5Veej99mwPCR7/Umf/1t
   ASZOT9aXKuU9n7r+Pq2bj0O6iWs97RQIC5pBS9j7iZka94TBOnqPWEIib
   P4V4U/TBmEbC1BIYSGenLnoYhrQEhs74A1W1aPm9uxs87CVL9SnDmbW7u
   uuMKwhc9joEiCrRpOc1aOkHplITF9mnHNTJnAcxBQsoKzJREXgetzQx1T
   FhPOK/uTozOlFBUoOINlLGVpg8euBVA5V34aPaavXL8Vf33xYlA1V33FN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="317020490"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="317020490"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="715337852"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="715337852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2022 13:32:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p321l-00609q-05;
        Wed, 07 Dec 2022 23:32:29 +0200
Date:   Wed, 7 Dec 2022 23:32:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
Subject: Re: [RFC 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
Message-ID: <Y5EGbLxzSFMgGE87@smile.fi.intel.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
 <20221207163359.26564-3-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207163359.26564-3-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:33:58AM +0800, larry.lai wrote:
> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control) through an on-board FPGA.

(I already reviewed previous version and you have my tag, but some new comments
 which may be already answered, sorry for the repetition in such cases).

Actually... based on the below comments I have to withdraw my tag.
This driver may not go into upstream in the current form.

I'm puzzled if it's indeed the code I have reviewed?

...

> +#include <linux/acpi.h>

This is actually not needed, but property.h.
See below how.

...

> +static int upboard_fpga_request_enable(struct pinctrl_dev *pctldev,
> +				       struct pinctrl_gpio_range *range,
> +				       unsigned int pin)
> +{
> +	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
> +	const struct upboard_pin *p;
> +	int ret;

> +	if (!pd)
> +		return -EINVAL;

When this can be true?
Ditto for other functions with this conditional.

> +	p = pd->drv_data;
> +	if (p->funcbit) {
> +		ret = regmap_field_write(p->funcbit, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (p->enbit) {
> +		ret = regmap_field_write(p->enbit, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +};

...

> +	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);

Don't you set a private data of GPIO chip to point to your custom structure?

Either way, I would recommend to make gpio_chip a first member in your
upboard_pinctrl.

...

> +			int mode = 1;

See below about default.

> +			unsigned int val;
> +
> +			switch (pctrl->ident) {
> +			case 15:
> +				mode = 2;
> +			break;
> +			}

Wrong indentation, missing default.
Same for the rest below.

> +		} else if (strstr(pctrl->pctldesc->pins[offset[i]].name,
> +				  "UART")) {

One line would be better to read, same for the rest below.

...

> +		/* input pins */
> +		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "RX"))
> +			input = true;
> +		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CTS"))
> +			input = true;
> +		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "ADC"))
> +			input = true;
> +		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
> +			input = true;
> +		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "DIN"))
> +			input = true;

Can you have this in some static const data structure that is associated with
pin list?

...

> +static void upboard_gpio_free(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
> +	int gpio = upboard_rpi_to_native_gpio(gc, offset);
> +	unsigned int pin = pctrl->rpi_mapping[offset];
> +	char name[strlen(pctrl->pctldesc->pins[pin].name)];
> +	char *p;

> +	if (gpio < 0)
> +		return;

When this can be true?
Same to the rest below.

> +	pinctrl_gpio_free(gpio);
> +
> +	strcpy(name, pctrl->pctldesc->pins[pin].name);
> +	p = name;
> +	upboard_alt_func_enable(gc, strsep(&p, "_"));
> +}

...

> +	/* APL03 open drain GPIO */
> +	if (pctrl->ident == 9) {
> +		if (pin == 0 || pin == 1) {
> +			int val = readl(pctrl->pins[pin].regs);
> +
> +			if (value)
> +				val |= PADCFG0_GPIOTXDIS;
> +			else
> +				val &= ~PADCFG0_GPIOTXDIS;
> +			writel(val, pctrl->pins[pin].regs);

Huh?!

If we need OD support in the pinctrl-intel, add it there.

> +		}

...

> +	if (strstr(dev_name(&pdev->dev), "INTC1055:00") ||
> +	    strstr(dev_name(&pdev->dev), "INT34C5:00")) {
> +		struct intel_pinctrl *intel_pctrl = gpiochip_get_data(gc);
> +		struct pinctrl_dev *pctldev;
> +		struct pinctrl_gpio_range *range;
> +
> +		pctldev = intel_pctrl->pctldev;
> +		if (pctldev == NULL)
> +			return NULL;
> +
> +		range = pinctrl_find_gpio_range_from_pin(pctldev, pin);
> +		if (range)
> +			pin = pin - range->pin_base;
> +		else
> +			return NULL;
> +
> +		if (range->pin_base < 67)
> +			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		else if (range->pin_base < 171)
> +			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		else if (range->pin_base < 260)
> +			res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +		else
> +			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +	}
> +
> +	if (IS_ERR(res)) {
> +		dev_err(gc->parent, "upboard resource get failed");
> +		return NULL;
> +	}

> +	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	offset = readl(base + PADBAR);
> +	value = readl(base + REVID);
> +
> +	if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x94)
> +		nregs = 4;
> +	else
> +		nregs = 2;
> +
> +	return base + offset + reg + pin * nregs * 4;
> +}

What the heck is this?!
Was it really in the version I have reviewed before?

...

> +static void upboard_irq_ack(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +	dev_info(NULL, "upboard_irq_ack");

Besides dev_info() and strange NULL, why do you need these messages? What for?
Same to the rest below.

> +}

...

> +	data->parent_data = irq_get_irq_data(pctrl->pins[offset].irq);
> +	if (data->parent_data) {
> +		dev_info(NULL, "%s: no NULL", __func__);

What?!

> +		return irq_chip_set_type_parent(data, type);
> +	}
> +
> +	dev_info(NULL, "%s: NULL", __func__);

Ditto.

...

> +static struct irq_chip upboard_gpio_irqchip = {
> +	.name = "upboard-gpio-irq",
> +	.irq_ack = upboard_irq_ack,
> +	.irq_mask = upboard_irq_mask,
> +	.irq_unmask = upboard_irq_unmask,
> +	.irq_set_type = upboard_irq_chip_set_type,
> +	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,

It should be set IMMUTABLE.

> +};

...

> +	hid = acpi_device_hid(adev);
> +	if (!strcmp(hid, "AANT0F00") || !strcmp(hid, "AANT0F04") ||
> +	    !strcmp(hid, "AANT0000")) {

This is done via ACPI ID table (but without announcing it as module supported
hardware) and corresponding match functions.

> +		pctldesc = &upboard_up_pinctrl_desc;
> +		rpi_mapping = upboard_up_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_up_rpi_mapping);
> +	} else if (!strcmp(hid, "AANT0F01")) {
> +		pctldesc = &upboard_up2_pinctrl_desc;
> +		rpi_mapping = upboard_up2_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_up2_rpi_mapping);
> +	} else if (!strcmp(hid, "AANT0F02")) {
> +		pctldesc = &upboard_upcore_crex_pinctrl_desc;
> +		rpi_mapping = upboard_upcore_crex_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_upcore_crex_rpi_mapping);
> +	} else if (!strcmp(hid, "AANT0F03")) {
> +		pctldesc = &upboard_upcore_crst02_pinctrl_desc;
> +		rpi_mapping = upboard_upcore_crst02_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_upcore_crst02_rpi_mapping);
> +	} else
> +		return -ENODEV;

...

> +	pins = devm_kzalloc(&pdev->dev,
> +			    sizeof(*pins) * pctldesc->npins,
> +			    GFP_KERNEL);

devm_kcalloc() or even devm_kmalloc_array().

> +	if (!pins)
> +		return -ENOMEM;

...

I stopped here since I don't believe that I have given a tag to this earlier...
If it's the case, I don't know what I have got that day.

-- 
With Best Regards,
Andy Shevchenko


