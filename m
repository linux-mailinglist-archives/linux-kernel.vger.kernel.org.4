Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627B657010
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiL0VlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiL0VlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:41:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC78630C;
        Tue, 27 Dec 2022 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672177280; x=1703713280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxD++ps1IbbWsJX6X9+jm6apfnGUk0+rQtqm69YTTpY=;
  b=RGCktqUvYdveHIQilAnMibVrS7j79++m23IpPs1yl+QXxOm18Tc9X/53
   wnzI+j8aBWo46OKr/SVYtc6vkJfO3GqQ/xOxdPSPkOniEBFzpLRx+MB7B
   NDb+PQIbpHERt9elQYOcW0oJxmsSoXASrE0XwTZ4qyHn34FvZP2b+oF3V
   LhBx2w892Q3PiSLbe5pm0tcjqfMKpphe5L2oAN7TFJAA1KdaerU/w3iFW
   1cbnBouYyfNw8nmChw6tXSa/YZcHhWZ0hUrCMaR6urj0CzQzbuSKwtkcr
   MM4iMbszrecmMblbTX3MmiNRvhp4UoBRdR+2sc/KcT0WxekeTI0XiNmDz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="318438241"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="318438241"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="827226694"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="827226694"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2022 13:41:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAHh3-000GkZ-23;
        Tue, 27 Dec 2022 23:41:05 +0200
Date:   Tue, 27 Dec 2022 23:41:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: pressure: bmp280: Add preinit callback
Message-ID: <Y6tmcRlHCZTgT9jS@smile.fi.intel.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
 <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 03:29:21PM +0100, Angel Iglesias wrote:
> Adds preinit callback to execute operations on probe before applying
> initial configuration.

...

> @@ -935,6 +936,7 @@ static const struct bmp280_chip_info bmp280_chip_info = {
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
>  	.read_calib = bmp280_read_calib,
> +	.preinit = NULL,
>  };
>  
>  static int bme280_chip_config(struct bmp280_data *data)
> @@ -979,6 +981,7 @@ static const struct bmp280_chip_info bme280_chip_info = {
>  	.read_press = bmp280_read_press,
>  	.read_humid = bmp280_read_humid,
>  	.read_calib = bme280_read_calib,
> +	.preinit = NULL,
>  };

Useless changes.

...

> @@ -1604,6 +1614,7 @@ static const struct bmp280_chip_info bmp180_chip_info = {
>  	.read_temp = bmp180_read_temp,
>  	.read_press = bmp180_read_press,
>  	.read_calib = bmp180_read_calib,
> +	.preinit = NULL,
>  };

Ditto.

...

> +	/*
> +	 * Some chips like the BMP3xx have preinit tasks to run
> +	 * before applying the initial configuration.
> +	 */
> +	if (data->chip_info->preinit) {
> +		ret = data->chip_info->preinit(data);

> +		dev_err(dev, "error running preinit tasks");

Huh?! I guess you wanted

>  		if (ret < 0)
>  			return ret;

	if (ret < 0)
		return dev_err_probe(...);

>  	}

-- 
With Best Regards,
Andy Shevchenko


