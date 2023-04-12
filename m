Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB76DF762
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjDLNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDLNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:38:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719491709;
        Wed, 12 Apr 2023 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681306682; x=1712842682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pnUjDJ/xUCsHQjHZB7cPemWJJbBm5AuX1hvD8ONxtnY=;
  b=BdkbXRm6HE3LEU7IkzTiyAOuUWq64mFlkicXZOFDUDqfw2AbzjIRlldq
   R5OcaMj/05R1c0mCwLLMl9AoGdXq8oa/6+hL5+cxQfkKpQouGlg6gk/bg
   icttqWGOlAo0UKLFb655agU+YiIldiURQ3Uyamou0IbQB701iRAndcTco
   kEaY7Qqe2Fzwh7Jk66AW3DI+1SQ/sz87gUpdZlIWBsuq42B01K8YOQCgt
   2RHiKBc5m5DCdCej3lvR8m9cMY5Ig4NyDO78CrTCZ9D2xvmv92wDbpvdJ
   7LBWi/P8bZJIIV8dLlXnDVPUcxeiiTv2vRJr9oGrO2ENQQyUlqPTaV+bI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323520851"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323520851"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="1018745687"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="1018745687"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2023 06:37:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmafc-00FxVI-2F;
        Wed, 12 Apr 2023 16:37:56 +0300
Date:   Wed, 12 Apr 2023 16:37:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZDa0NIot/4aRJ0pI@smile.fi.intel.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
 <ZDVWB9xV9Cdbwyqd@smile.fi.intel.com>
 <ab1d9746-4d23-efcc-0ee1-d2b8c634becd@tweaklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab1d9746-4d23-efcc-0ee1-d2b8c634becd@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:29:15PM +0800, Subhajit Ghosh wrote:

...

> > > +static const struct regmap_config apds9306_regmap = {
> > > +	.name = "apds9306_regmap",
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.rd_table = &apds9306_readable_table,
> > > +	.wr_table = &apds9306_writable_table,
> > > +	.volatile_table = &apds9306_volatile_table,
> > > +	.precious_table = &apds9306_precious_table,
> > > +	.max_register = APDS9306_ALS_THRES_VAR,
> > > +	.cache_type = REGCACHE_RBTREE,
> > 
> > Do you need an internal regmap lock? If so, why?
> For event interface - interrupt enable, adaptive interrupt enable,
> upper and lower threshold values, selection of clear or als
> channels for interrupt, the mutex in the driver's private data structure
> is not used.
> I thought to use the regmap's internal locking mechanism for
> mutual exclusion as the values are directly written to or read from
> the device registers form the write_event(), read_event(),
> write_event_config() and read_event_config().
> What do you think?

I didn't get. If you have a sequence of registers to be read/write/modified/etc
in IRQ handler and/or elsewhere and at the same time in IRQ or elsewhere you
have even a single IO access to the hardware you have to be sure that the IO
ordering has no side effects. regmap API does not guarantee that. It only works
on a simple read/write/modify of a _single_ register, or a coupled group of
registers (like bulk ops), if your case is sparse, you on your own and probably
lucky enough not to have an issue during the testing. So, take your time and
think more about what you are doing in the driver and what locking schema
should take place.

...

> > > +static int apds9306_power_state(struct apds9306_data *data,
> > > +		enum apds9306_power_states state)
> > > +{
> > > +	int ret;
> > > +
> > > +	/* Reset not included as it causes ugly I2C bus error */
> > > +	switch (state) {
> > > +	case standby:
> > > +		return regmap_field_write(data->regfield_en, 0);
> > > +	case active:
> > > +		ret = regmap_field_write(data->regfield_en, 1);
> > > +		if (ret)
> > > +			return ret;
> > > +		/* 5ms wake up time */
> > > +		usleep_range(5000, 10000);
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > 
> > > +	return 0;
> > 
> > Move that to a single user of this line inside the switch-case.
> Sorry, I did not get you. Can you please elaborate?

The user of this return is only one case in the switch. Instead of breaking
the switch-case, just move this return statement to there.

...

> > > +	struct device *dev = &data->client->dev;
> > 
> > Why data contains I²C client pointer, what for?
> I copied the implementation. It will be re-implemented.

I mean, how client pointer is used in comparison to the plain pointer to the
generic device object.

...

> > > +		while (retries--) {
> > > +			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
> > > +					&status);
> > > +			if (ret) {
> > > +				dev_err(dev, "read status failed: %d\n", ret);
> > > +				return ret;
> > > +			}
> > > +			if (status & APDS9306_ALS_DATA_STAT_MASK)
> > > +				break;
> > > +			/*
> > > +			 * In case of continuous one-shot read from userspace,
> > > +			 * new data is available after sampling period.
> > > +			 * Delays are in the range of 25ms to 2secs.
> > > +			 */
> > > +			fsleep(delay);
> > > +		}
> > 
> > regmap_read_poll_timeout().
> According to the regmap_read_poll_timeout() documentation, the maximum time
> to sleep between reads should be less than ~20ms as it uses usleep_range().
> 
> If userspace is doing continuous reads, then data is available after sampling
> period (25ms to 2sec) or integration time (3.125ms to 400ms) whichever is
> greater.
> 
> The runtime_suspend() function is called after 5 seconds, so the device is
> still active and running.
> 
> If the ALS data bit is not set in status reg, it is efficient to sleep for
> one sampling period rather than continuously checking the status reg
> within ~20ms if we use regmap_read_poll_timeout().
> 
> Do you have any suggestions?

Yes, Use proposed API. It takes _two_ timeout parameters, one of which is the
same as your delay. You may actually resplit it by multiplying retries and
decreasing delay to satisfy the regmap_read_poll_timeout() recommendation.

-- 
With Best Regards,
Andy Shevchenko


