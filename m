Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C7740E47
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjF1KJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:09:05 -0400
Received: from mga06b.intel.com ([134.134.136.31]:18087 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbjF1KGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687946768; x=1719482768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D9/HaLrYlCtEllZMLsE+qnE2OoNhKXG87x9IvttFtFM=;
  b=XFXbIRdVNZn0eBZ5+Wjv5zAL/SsMaYwsS+Bc0y10MwZo/U9A9H9ZVuQd
   kfmtBysihWZIxujQQ9Xu6dm153YNE+Nb7zDreHZxCnqh7OAsSrwosjjhJ
   jpYZGJNs8l9b5bGV9qAn6e0kf5oFTIst5kQ1qzHwFefCoo47RBrxqD9Kh
   zKVyZ5qPI/e5THdq4KU4rxJNkjT/GnF14dQTrVhciaaxI04yc2Ja2RyQz
   oglPjWrxQyiHmYXqn+Z8zTLVDws0mOMsPmh2zRbm8INebHwBjui6PE7CI
   VKvaP7ROSjbtTpNX68tt9nqPwdlH4DL6TcVFEYqyjR3rDATE/bbjD2lV8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425476475"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="425476475"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 03:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="963538182"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="963538182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2023 03:06:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qES3k-000YPx-1a;
        Wed, 28 Jun 2023 13:06:00 +0300
Date:   Wed, 28 Jun 2023 13:06:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v3 5/5] meson saradc: support reading from channel 7 mux
 inputs
Message-ID: <ZJwGCNA+ZURri24i@smile.fi.intel.com>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
 <20230627224017.1724097-6-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627224017.1724097-6-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:37:18AM +0300, George Stark wrote:
> Add iio channel for every channel 7 mux input.
> Meson saradc channel 7 is connected to a mux that can switch channel
> input to well-known sources like Vdd, GND and several Vdd dividers.

...

> +static enum meson_sar_adc_chan7_mux_sel chan7_mux_values[] = {
> +	CHAN7_MUX_VSS,
> +	CHAN7_MUX_VDD_DIV4,
> +	CHAN7_MUX_VDD_DIV2,
> +	CHAN7_MUX_VDD_MUL3_DIV4,
> +	CHAN7_MUX_VDD,
> +};
> +
> +static const char * const chan7_mux_names[] = {
> +	"gnd",
> +	"0.25vdd",
> +	"0.5vdd",
> +	"0.75vdd",
> +	"vdd",

For the sake of robustness you can assign like this

	[CHAN7_MUX_VDD_DIV2] = "0.5vdd",

>  };

...

> -	if (chan->type == IIO_VOLTAGE)
> -		return sprintf(label, "channel-%d\n", chan->channel);
> +	if (chan->type == IIO_VOLTAGE) {

> +		if (chan->channel <= NUM_CHAN_7)

I believe you can get rid of this conditional and make diff less ping-pong-ish,
  see below.

> +			return sprintf(label, "channel-%d\n", chan->channel);
> +		if (chan->channel >= NUM_MUX_0_VSS)
> +			return sprintf(label, "%s\n",
> +				chan7_mux_names[chan->channel - NUM_MUX_0_VSS]);
> +	}


	if (chan->type == IIO_VOLTAGE && chan->channel >= NUM_MUX_0_VSS)
		return sprintf(label, "%s\n", chan7_mux_names[chan->channel - NUM_MUX_0_VSS]);

	if (chan->type == IIO_VOLTAGE)
		return sprintf(label, "channel-%d\n", chan->channel);


-- 
With Best Regards,
Andy Shevchenko


