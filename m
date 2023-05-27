Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71389713511
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjE0NkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjE0Njw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:39:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24DC3;
        Sat, 27 May 2023 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685194791; x=1716730791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qfjzqpAYgR3XMV316cfjMosBmC4HWLJh7OuqlZd9VwU=;
  b=mCXFZ9nYE+15llGvC5G39coFF7EeAZKzyvb4JDuivif5tvLD7m0UW92x
   1O/0nxKXaIhhGsqOS26BYrPmKbKnsGke1VUIbEvGxJK6jv+xnzZeu4SZ7
   qHv/dCV15iG095zhABJxUlK86YUfesm8W0O/erbCSN0x2ouH6J35C46x3
   zszu/RMaFSi+54lWXGRnOP9u+n+2+BCzUHQgLvFAGal/xo79Ew/yaxsEh
   SY/Ddvg3j+4Q5oksLVEWdEh2nE4sr7Ebv7eL870GHg4vnOz0m2FpnvRRu
   xmYDTW3ZDVMayTeJlrXiZhnqROq/dCybskIU+3UD2cgcqj/0KQ3K+wSBL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="343896226"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="343896226"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 06:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="829811418"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="829811418"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2023 06:39:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q2u94-000J3h-2y;
        Sat, 27 May 2023 16:39:46 +0300
Date:   Sat, 27 May 2023 16:39:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZHIIIhtOAQRw4F40@smile.fi.intel.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
 <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 04:30:46PM +0200, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.

...

> -	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	chip_info = device_get_match_data(&i2c->dev);
> +	if (!chip_info) {
> +		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> +		chip_info = (const struct kx022a_chip_info *)id->driver_data;
> +	}

And if still no chip_info available?..

> +	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to initialize Regmap\n");

...

> -	if (val > KX022A_FIFO_LENGTH)
> -		val = KX022A_FIFO_LENGTH;
> +	if (val > data->chip_info->fifo_length)
> +		val = data->chip_info->fifo_length;

min()/min_t() ?

...

> +	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
> +				&data->fifo_buffer[0], fifo_bytes);

data->fifo_buffer will suffice.


>  	if (ret)
>  		goto renable_out;

...

> +	data->fifo_buffer = kmalloc(data->chip_info->fifo_length *
> +				    KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);

> +

Redundant blank line.

> +	if (!data->fifo_buffer)
> +		return -ENOMEM;

...

> +struct kx022a_chip_info {
> +	const char *name;
> +	const struct regmap_config *regmap_config;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned int fifo_length;
> +	u8 who;
> +	u8 id;
> +	u8 cntl;
> +	u8 cntl2;
> +	u8 odcntl;
> +	u8 buf_cntl1;
> +	u8 buf_cntl2;
> +	u8 buf_clear;
> +	u8 buf_status1;

Here is the gap since it's not a packed structure. Can we avoid it?

> +	u16 buf_smp_lvl_mask;
> +	u8 buf_read;
> +	u8 inc1;
> +	u8 inc4;
> +	u8 inc5;
> +	u8 inc6;
> +	u8 xout_l;
> +};

-- 
With Best Regards,
Andy Shevchenko


