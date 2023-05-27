Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28636713348
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjE0IVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjE0IVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:21:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D210A;
        Sat, 27 May 2023 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685175667; x=1716711667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gaq5upMCYm0n+93a3GQTD3/I551zJxCC6KXvfyxQV+0=;
  b=DZrhKbpVp/5X0xVVBdh9RVTgozJ07rfHz5gI7Iq/ISWBl1l7Ydlh1FhI
   vv6a0HW55SskVNiNBd+G9PaTJICs8dNM90nuHpjCvutP6lhyA3Wc3iQJn
   M9TADgk7Kvboe0oX3RSixZbCwnAD1DBegK3KVlFvcmf+NS+cH0FaQZLoK
   wjce+qC/vS035qJVJIHpRbu8jQrexD2M/VpU1mDvcWoL1azqiCopli46i
   c+8sNyHvQSdCoPKaJTggKhAP8qU0RC9/6YDQYdowUH42JHwxkSDdBMz3d
   SVTL8btpfWvq1g8c7IPeAoEO1MmjtYSNLDcF058G767jN6j63xran3I8D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="334000947"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="334000947"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 01:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="1035600798"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="1035600798"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2023 01:21:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q2pAb-000IpE-2O;
        Sat, 27 May 2023 11:21:01 +0300
Date:   Sat, 27 May 2023 11:21:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1] meson saradc: add iio device attrib to switch channel
 7 mux
Message-ID: <ZHG9bYO1PNuPJhWn@smile.fi.intel.com>
References: <20230524000111.14370-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524000111.14370-1-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:01:11AM +0300, George Stark wrote:
> Patch adds two sysfs nodes: chan7_mux to set mux state
> and chan7_mux_available to show available mux states.
> Mux can be used to debug and calibrate adc by
> switching and measuring well-known inputs like gnd, vdd etc.

GND
Vdd

...

> +static ssize_t chan7_mux_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(chan7_vol); i++)
> +		if (!strcmp(chan7_vol[i], buf)) {
> +			meson_sar_adc_set_chan7_mux(indio_dev, i);
> +			return count;
> +		}
> +
> +	return -EINVAL;

NIH sysfs_match_string().

> +}

...

> +static IIO_DEVICE_ATTR_RW(chan7_mux, -1);
> +static IIO_DEVICE_ATTR_RO(chan7_mux_available, -1);

Place each of them near to the respective callback(s),

...

> +static struct attribute *meson_sar_adc_attrs[] = {
> +	&iio_dev_attr_chan7_mux_available.dev_attr.attr,
> +	&iio_dev_attr_chan7_mux.dev_attr.attr,
> +	NULL,

No comma for the terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko


