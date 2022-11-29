Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29E63C54D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiK2QiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiK2QiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:38:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D286F57B5B;
        Tue, 29 Nov 2022 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739898; x=1701275898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pl0aGdARfvWS523S5l0UgKlIzt2EKDvOzbaOvuIoHjk=;
  b=dnFAzfJMRmUqrPiaHGaQTOgVFugc8VWDDlbFsaHJVzKjT9sTO0WCJ7Uk
   bZXRmpSpXpPCaJx3iu/4BJgz7npvTYvV6SEQ8YmI5ey+qjmxHYKshAXu4
   I4HsIlTu7Byoa5TVLj6rJT0AMGbULZhH9dqGcMRyVU17Uy/9Z53S5O4cN
   iPOOKObPBge5xdVJfBV1BLUfpAuT3yJZQgNc+YZ+ExiORWSOxQZgJ5Bg1
   x9F4X8zpr461Gqz2kiPvCyB7qYUzkrI6XPOiJQwJwa13i2u8xyUcrrxJH
   UhJeSvYJKZnG41/9B//zYTR579jAwNTSH16hJpYeLgnldvRmBxqB0P+nX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315190281"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="315190281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768486521"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="768486521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 08:37:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03c6-001muh-15;
        Tue, 29 Nov 2022 18:37:42 +0200
Date:   Tue, 29 Nov 2022 18:37:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v4 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y4Y1VqvYS0XsWi1r@smile.fi.intel.com>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
 <20221129064540.3218982-4-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129064540.3218982-4-gerald.loacker@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 07:45:40AM +0100, Gerald Loacker wrote:
> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.

...

> +static int tmag5273_get_measure(struct tmag5273_data *data, s16 *t, s16 *x,
> +				s16 *y, s16 *z, u16 *angle, u16 *magnitude)
> +{
> +	unsigned int status, val;
> +	__be16 reg_data[4];
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	/*
> +	 * Max. conversion time is 2425 us in 32x averaging mode for all three
> +	 * channels. Since we are in continuous measurement mode, a measurement
> +	 * may already be there, so poll for completed measurement with
> +	 * timeout.
> +	 */
> +	ret = regmap_read_poll_timeout(data->map, TMAG5273_CONV_STATUS, status,
> +				       status & TMAG5273_CONV_STATUS_COMPLETE,
> +				       100, 10000);
> +	if (ret) {

> +		dev_err_probe(data->dev, ret,
> +			      "timeout waiting for measurement\n");

Is it called from ->probe()? I don't think so...

> +		goto out_unlock;
> +	}
> +
> +	ret = regmap_bulk_read(data->map, TMAG5273_T_MSB_RESULT, reg_data,
> +			       sizeof(reg_data));
> +	if (ret)
> +		goto out_unlock;
> +	*t = be16_to_cpu(reg_data[0]);
> +	*x = be16_to_cpu(reg_data[1]);
> +	*y = be16_to_cpu(reg_data[2]);
> +	*z = be16_to_cpu(reg_data[3]);
> +
> +	ret = regmap_bulk_read(data->map, TMAG5273_ANGLE_RESULT_MSB,
> +			       &reg_data[0], sizeof(reg_data[0]));
> +	if (ret)
> +		goto out_unlock;
> +	/*
> +	 * angle has 9 bits integer value and 4 bits fractional part
> +	 * 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0
> +	 * 0  0  0  a  a  a  a  a  a  a  a  a  f  f  f  f
> +	 */
> +	*angle = be16_to_cpu(reg_data[0]);
> +
> +	ret = regmap_read(data->map, TMAG5273_MAGNITUDE_RESULT, &val);
> +	if (ret < 0)
> +		goto out_unlock;
> +	*magnitude = val;
> +
> +out_unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}

...

> +static const struct iio_info tmag5273_info = {
> +	.read_avail = &tmag5273_read_avail,
> +	.read_raw = &tmag5273_read_raw,
> +	.write_raw = &tmag5273_write_raw,
> +};

Functions when being assigned are already pointers, no?

...

> +	ret = match_string(tmag5273_angle_names,
> +			   ARRAY_SIZE(tmag5273_angle_names), str);
> +	if (ret < 0)
> +		dev_warn(dev, "unexpected read angle-measurement property: %s\n", str);

		dev_warn(dev, "unexpected value in angle-measurement property: %s\n", str);

?

> +	else
> +		data->angle_measurement = ret;

...

> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u", data->version);

Thinking more about this format, perhaps

		snprintf(data->name, sizeof(data->name), "tmag5273x-v%1u", data->version);

?

...

> +static int tmag5273_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	int ret;

> +	/*
> +	 * Time to go to stand-by mode from sleep mode is 50us
> +	 * typically. During this time no I2C access is possible.
> +	 */

Shouldn't be this comment closer to usleep_range()?

> +	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
> +	usleep_range(80, 200);
> +	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
> +	if (ret)
> +		dev_err(dev, "failed to power on device (%pe)\n", ERR_PTR(ret));
> +
> +	return ret;
> +}

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops, tmag5273_runtime_suspend,
> +				 tmag5273_runtime_resume, NULL);

I would logically split it like:

static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops,
				 tmag5273_runtime_suspend, tmag5273_runtime_resume, NULL);

or like:

static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops,
				 tmag5273_runtime_suspend, tmag5273_runtime_resume,
				 NULL);

or like:

static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops,
				 tmag5273_runtime_suspend,
				 tmag5273_runtime_resume,
				 NULL);

Depending on your preferences.

-- 
With Best Regards,
Andy Shevchenko


