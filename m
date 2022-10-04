Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93B5F3ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJDIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJDIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:51:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128172D1DB;
        Tue,  4 Oct 2022 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664873458; x=1696409458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F3RsIyre2ozS8zNUV5H6X65Ushen9x2OSekUTs4+WvU=;
  b=DRhfUF6vFTu/9lGSDSsCtjr5ddk6bTgbs6XS3/F+Fu4oxcUvJy5Nrzzl
   qqeofT/8TNtkd/AQIHoZRIsqxvtTLdxFEiPMlW+qC21WyNwLMXOgR3Cp8
   eOQQu/P96rxZFDpdOdGUWMNe3hd+ExsuEkMnWVU2f4cXM9UWcX4ZKtEsM
   hAY3XRep95cgODx0u3kKidpRDubYrXz7eOqrToCNyY/AjkRLGC3xND9UW
   gzKpERxPhKx+wk8dgGCWjs5rWOlinhBNooy1/BjfBNeJkQSaqrZoK4P4+
   86pSMmHnp0uwQzggbk2AWcYsy0WH/1dTqPmTSR3wXsh5ZA7zjsep/j6QA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="290080145"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="290080145"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="574957572"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="574957572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2022 01:50:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofdde-001yhH-0g;
        Tue, 04 Oct 2022 11:50:54 +0300
Date:   Tue, 4 Oct 2022 11:50:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: iio: dac: Add AD5754 DAC driver
Message-ID: <Yzvz7ecXcMVp7quF@smile.fi.intel.com>
References: <20221004071825.791307-1-ciprian.regus@analog.com>
 <20221004071825.791307-3-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221004071825.791307-3-ciprian.regus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:18:25AM +0300, Ciprian Regus wrote:
> The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial
> input, voltage output DACs. The devices operate from single-
> supply voltages from +4.5 V up to +16.5 V or dual-supply
> voltages from ±4.5 V up to ±16.5 V. The input coding is
> user-selectable twos complement or offset binary for a bipolar
> output (depending on the state of Pin BIN/2sComp), and straight
> binary for a unipolar output.

...

> +#define AD5754_INT_VREF			2500

Units? (Like _mV or _uV or what? Note, small u is OK to have in such cases)

...

> +#define AD5754_CLEAR_FUNC		BIT(2)
> +#define AD5754_LOAD_FUNC		(BIT(2) | BIT(0))
> +#define AD5754_NOOP_FUNC		GENMASK(4, 3)

Seems like abuse of BIT and GENMASK, use plain numbers as it's probably is.
Otherwise _each_ bit should have it's own descriptive meaning.

...

> +#define AD5754_DAC_REG			0
> +#define AD5754_RANGE_REG		BIT(0)
> +#define AD5754_PWR_REG			BIT(1)

...

> +#define AD5754_CTRL_REG			GENMASK(1, 0)

Why _REG uses GENMASK()?

...

> +struct ad5754_span_tbl {
> +	int min;
> +	int max;
> +};

I'm wondering if linear_range.h can anyhow help with this code.

...

> +struct ad5754_state {
> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +	struct device *dev;

You always can derive dev from regmap, is this one different?

> +
> +	const struct ad5754_chip_info *chip_info;
> +
> +	u32 range_idx[AD5754_MAX_CHANNELS];
> +	int offset[AD5754_MAX_CHANNELS];
> +	u32 dac_max_code;
> +	u32 data_mask;
> +	u32 sub_lsb;
> +	u32 vref;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8 buff[AD5754_FRAME_SIZE] __aligned(IIO_DMA_MINALIGN);
> +};

...

> +static const struct regmap_config ad5754_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.reg_write = ad5754_reg_write,
> +	.reg_read = ad5754_reg_read,

No max register address?

> +};

...

> +	struct fwnode_handle *channel_node = NULL;

Redundant assignment.

...

> +	fwnode_for_each_available_child_node(dev_fwnode(st->dev), channel_node) {

Why not device_for_each_child_node() ?

(Yes, it uses available ones)

> +	}

...

> +		range = &ad5754_range[st->range_idx[chan->channel]];
> +		gain = (range->max - range->min) / 2500;
> +		*val = st->vref * gain / 1000;
> +		*val2 = st->chip_info->resolution;

Yeah, looks familiar to the linear_range APIs.

...

> +static int ad5754_probe(struct spi_device *spi)
> +{
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ad5754_state *st;
> +	struct device *dev;
> +	int ret;

> +	dev = &spi->dev;

Can be done in the definition block (inline).

...

> +	st->chip_info = device_get_match_data(dev);
> +	if (!st->chip_info)
> +		st->chip_info =
> +			(const struct ad5754_chip_info *)spi_get_device_id(spi)->driver_data;

This can look better with a temporary variable. But doesn't matter since we
would like to have these lines to be packed in a new SPI API helper in the
future.

...

> +		st->vref = ret / 1000;

Do we have uV_PER_mV or so?

...

> +static const struct spi_device_id ad5754_id[] = {

> +	{},

No comma for the terminator line.

> +};

...

> +static const struct of_device_id ad5754_dt_id[] = {

> +	{},

Ditto.

> +};

...

> +module_driver(ad5754_driver,
> +	      ad5754_register_driver,
> +	      ad5754_unregister_driver);

Why not module_spi_driver()?

-- 
With Best Regards,
Andy Shevchenko


