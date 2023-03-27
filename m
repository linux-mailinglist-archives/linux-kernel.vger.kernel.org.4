Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7E6CA2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjC0Lmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjC0Lmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:42:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5919BD;
        Mon, 27 Mar 2023 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679917347; x=1711453347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/pQsJORoxhMom8gXQfDi1iEIB58NK/lUrqzdGM8v4OA=;
  b=Mc87Qh8d2hBgF5sb7fqv9XIiHI3H18u7YcHjUrVXJRoU8wTFrAzVr/Wj
   +gS3zom2NYiZ68eA4/PPqKd+U9/FUVZFr0w6zVIUgeJkgtlXdYHBt08BW
   4elBM61eyLH+mH0KP+u7oloOg+oCYfjZEle3TK1pKKqAuBEUs4a1lFes2
   E21wGFP4VozBPhC0Tr4uKRI9VP2hIAJhuKlMYyIwQz43C8j3oFr8p1gkl
   WrGi7vt+7IZ8wj8CNJT5CECJgZNxeELb1I4W7AhGE6ADUmRIvyfG6yJP2
   hR2qFVdQIwCV/XNBtjoqs5ZNT1C+/N58L2WYkGM2aCgrYm5PK03IdduCR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341816223"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="341816223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 04:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="827013874"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="827013874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 04:42:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pglF3-009CD1-04;
        Mon, 27 Mar 2023 14:42:25 +0300
Date:   Mon, 27 Mar 2023 14:42:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
References: <cover.1679867815.git.william.gray@linaro.org>
 <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 06:05:57PM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.

...

> +static const struct regmap_config aio_ctl_regmap_config = {
> +	.name = "aio_ctl",
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.reg_base = STX104_AIO_BASE,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = 0x11,

Not sure if define would be better for this, so it will be grouped with
register offset definitions. (Same for the other configs)

> +	.wr_table = &aio_ctl_wr_table,
> +	.rd_table = &aio_ctl_rd_table,
> +	.volatile_table = &aio_ctl_volatile_table,
> +	.cache_type = REGCACHE_FLAT,
> +};

Do we need regmap lock?

...

> +static const struct regmap_config aio_data_regmap_config = {
> +	.name = "aio_data",
> +	.reg_bits = 16,
> +	.reg_stride = STX104_AIO_DATA_STRIDE,
> +	.reg_base = STX104_AIO_BASE,
> +	.val_bits = 16,
> +	.io_port = true,
> +	.max_register = 0x6,
> +	.wr_table = &aio_data_wr_table,
> +	.rd_table = &aio_data_rd_table,
> +	.volatile_table = &aio_data_rd_table,
> +	.cache_type = REGCACHE_FLAT,
> +};

Ditto.

> +static const struct regmap_config dio_regmap_config = {
> +	.name = "dio",
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.reg_base = STX104_DIO_REG,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = 0x0,
>  };

Ditto.

...

> +		err = regmap_read(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, &adc_config);
> +		if (err)
> +			return err;
>  
> -		*val = 1 << gain;
> +		*val = 1 << u8_get_bits(adc_config, STX104_GAIN);

Maybe not for this change, but why not BIT()?

...

> +		do {
> +			err = regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_status);
> +			if (err)
> +				return err;
> +		} while (u8_get_bits(adc_status, STX104_CNV));

Hmm... Isn't it a potential infinite loop (e.g., ther hardware / firmware
is broken)?

Why not using regmap_read_poll_timeout() (or its atomic variant, depends on
the case)?

...

>  	case IIO_CHAN_INFO_RAW:
>  		if (chan->output) {

You can decrease indentation by

		if (!chan->output)
			return -EINVAL;

here.

>  			/* DAC can only accept up to a 16-bit value */
>  			if ((unsigned int)val > 65535)
>  				return -EINVAL;
>  
> -			priv->chan_out_states[chan->channel] = val;
> -			iowrite16(val, &priv->reg->dac[chan->channel]);
> -
> -			return 0;
> +			return regmap_write(priv->aio_data_map, STX104_DAC_OFFSET(chan->channel),
> +					    val);
>  		}
>  		return -EINVAL;
>  	}

...

> +	gpio_config = (struct gpio_regmap_config) {
> +		.parent = dev,
> +		.regmap = dio_map,
> +		.ngpio = STX104_NGPIO,
> +		.names = stx104_names,
> +		.reg_dat_base = GPIO_REGMAP_ADDR(STX104_DIO_REG),
> +		.reg_set_base = GPIO_REGMAP_ADDR(STX104_DIO_REG),
> +		.ngpio_per_reg = STX104_NGPIO,
> +		.reg_mask_xlate = stx104_reg_mask_xlate,
> +		.drvdata = dio_map,
> +	};

Not sure of compound literal is good to have in such case, but if
Jonathan asked for that...

-- 
With Best Regards,
Andy Shevchenko


