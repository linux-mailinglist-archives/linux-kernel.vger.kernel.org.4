Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED51971390F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjE1Kqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Kqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 06:46:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D446A94;
        Sun, 28 May 2023 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685270802; x=1716806802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12XnZdCMLf2ECdKc7jgZMRFCTIoyk3JXcdiX3xQZb+Q=;
  b=irmPCYc5TVUOKtc/d/DxRU3LtE+AZmtBdFqiwqyQhOfLfhrtKEAIBlVQ
   uj1uOJIY59ZeQsw4yE2RxhR2meEteNY69uJCMak4HMxp9lQ7dDShVA80K
   nO883X3bnzP+x0Vbx+l6Pqe/etSoB2IRcBjtmSqRq8dFJD9dLeJvBY1gU
   VdWXQEj2sT/GJlyCI86VOIjy4meVJlRJQR8uK5sdKbPE0Wzwe4L0iSoW/
   U2dGv/8ZteTh4JhDv2jCKRgd54JHVYg5Lyf8ujjffXc8/rSG8gWZI86M3
   iy+p6hTUtz+NqKGzcUOdfLYDP0+ghVwEtECw6u+6p1a0c+WT7DHJo82a6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="344006203"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="344006203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 03:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="850056935"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="850056935"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2023 03:46:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q3Dv3-000Jjg-0a;
        Sun, 28 May 2023 13:46:37 +0300
Date:   Sun, 28 May 2023 13:46:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
Message-ID: <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527214854.126517-1-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 12:48:54AM +0300, George Stark wrote:
> Patch adds two sysfs nodes: chan7_mux to set mux state
> and chan7_mux_available to show available mux states.
> Mux can be used to debug and calibrate adc by
> switching and measuring well-known inputs like GND, Vdd etc.

Thank you for an update, my comments below.

...

> ---

Missing changelog, what has been done in v2, how it's different to v1.

>  drivers/iio/adc/meson_saradc.c | 65 ++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)

...

> +static const char * const chan7_vol[] = {
> +	"gnd",
> +	"vdd/4",
> +	"vdd/2",
> +	"vdd*3/4",
> +	"vdd",
> +	"ch7_input",
> +};
> +
> +static ssize_t chan7_mux_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	unsigned int index = priv->chan7_mux_sel;
> +
> +	if (index >= ARRAY_SIZE(chan7_vol))
> +		index = ARRAY_SIZE(chan7_vol) - 1;

I think this is incorrect and prone to error in the future in case this array
will be extended. What I would expect is to return something like "unknown".

> +	return sysfs_emit(buf, "%s\n", chan7_vol[index]);
> +}
> +
> +static ssize_t chan7_mux_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int i;
> +
> +	i = sysfs_match_string(chan7_vol, buf);
> +	if (i < 0)

> +		return -EINVAL;

Do not shadow the error code if it's not justified.

		return i;

> +	meson_sar_adc_set_chan7_mux(indio_dev, i);
> +	return count;
> +}

> +

Redundant blank line.

> +static IIO_DEVICE_ATTR_RW(chan7_mux, -1);
> +
> +static ssize_t chan7_mux_available_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(chan7_vol); i++)
> +		len += sysfs_emit_at(buf, len, "%s ", chan7_vol[i]);
> +
> +	return len;
> +}

> +

Ditto.

> +static IIO_DEVICE_ATTR_RO(chan7_mux_available, -1);

-- 
With Best Regards,
Andy Shevchenko


