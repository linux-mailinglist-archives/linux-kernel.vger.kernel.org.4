Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB736ABF69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCFMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCFMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:25:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110A279AD;
        Mon,  6 Mar 2023 04:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678105524; x=1709641524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W8RPdrA6zsq5zgKn1+vk/ssD+rDKRswAS+XkKih0rHw=;
  b=eBeMP4ZOaLjG9xXdfJ1mEx1KLnXFjRpV6Ar/hsUwEOFHam98+GF9XC6z
   1tJi5D8QZLP7VB2dUlAo5pBAjHcgqAzidAk8ghI0XlTaip8ve/y7E82nq
   iL01bpfMx468m4EMTkFNZWVnmCEEYj7RvrFxOTXinGUlob1zc+XMtba0N
   c86X63z8JsA0IYH/MQQvtd+X79DQi/mZgnackyonDN7g+GnVFO7mkStVU
   WP7eHpKCMWIzjOvTVEW7p6pxkKQv19cKRPj9b/imm09oguGvuwN2jlbu1
   /8WhLgudZFCySnrXS7e4iYnhBsMZfjCUZvwEIDxCO9KxztlVN30Nlyuz1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363157714"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363157714"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="678461002"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="678461002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2023 04:25:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9u2-00GLSW-0t;
        Mon, 06 Mar 2023 14:25:18 +0200
Date:   Mon, 6 Mar 2023 14:25:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v3 0/6] Support ROHM BU27034 ALS sensor
Message-ID: <ZAXbrtXUmWXWDby1@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678093787.git.mazziesaccount@gmail.com>
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

On Mon, Mar 06, 2023 at 11:15:10AM +0200, Matti Vaittinen wrote:
> Support ROHM BU27034 ALS sensor
> 
> This series adds support for ROHM BU27034 Ambient Light Sensor.
> 
> The BU27034 has configurable gain and measurement (integration) time
> settings. Both of these have inversely proportional relation to the
> sensor's intensity channel scale.
> 
> Many users only set the scale, which means that many drivers attempt to
> 'guess' the best gain+time combination to meet the scale. Usually this
> is the biggest integration time which allows setting the requested
> scale. Typically, increasing the integration time has better accuracy
> than increasing the gain, which often amplifies the noise as well as the
> real signal.
> 
> However, there may be cases where more responsive sensors are needed.
> So, in some cases the longest integration times may not be what the user
> prefers. The driver has no way of knowing this.
> 
> Hence, the approach taken by this series is to allow user to set both
> the scale and the integration time with following logic:
> 
> 1. When scale is set, the existing integration time is tried to be
>    maintained as a first priority.
>    1a) If the requested scale can't be met by current time, then also
>        other time + gain combinations are searched. If scale can be met
>        by some other integration time, then the new time may be applied.
>        If the time setting is common for all channels, then also other
>        channels must be able to maintain their scale with this new time
>        (by changing their gain). The new times are scanned in the order
>        of preference (typically the longest times first).
>    1b) If the requested scale can be met using current time, then only
>        the gain for the channel is changed.
> 
> 2. When the integration time change - scale is tried to be maintained.
>    When integration time change is requested also gain for all impacted
>    channels is adjusted so that the scale is not changed, or is chaned
>    as little as possible. This is different from the RFCv1 where the
>    request was rejected if suitable gain couldn't be found for some
>    channel(s).
> 
> This logic is simple. When total gain (either caused by time or hw-gain)
> is doubled, the scale gets halved. Also, the supported times are given a
> 'multiplier' value which tells how much they increase the total gain.
> 
> However, when I wrote this logic in bu27034 driver, I made quite a few
> errors on the way - and driver got pretty big. As I am writing drivers
> for two other sensors (RGB C/IR + flicker BU27010 and RGB C/IR BU27008)
> with similar gain-time-scale logic I thought that adding common helpers
> for these computations might be wise. I hope this way all the bugs will
> be concentrated in one place and not in every individual driver ;)
> 
> Hence, this series also intriduces IIO gain-time-scale helpers
> (abbreviated as gts-helpers) + a couple of KUnit tests for the most
> hairy parts.
> 
> I can't help thinking that there should've been simpler way of computing
> the gain-time-scale conversions. Also, pretty good speed improvements
> might be available if some of the do_div()s could be replaced by >>.
> This, however, is not a priority for my light-sensor use-case where
> speed demands are not that big.
> 
> Finally, these added helpers do provide some value also for drivers
> which only:
>  a) allow gain change
>   or
>  b) allow changing both the time and gain but so that the time-change is
>     not reflected in register values.
> 
> For a) we provide the gain - selector (register value) table format +
> selector to gain look-ups, gain <-> scale conversions and the available
> scales helpers.
> 
> For latter case we also provide the time-tables, and actually all the
> APIs should be usable by setting the time multiplier to 1. (not testeted
> thoroughly though).

A few comments can still be applied here.
Can you comment on the discussion against the previous version?

-- 
With Best Regards,
Andy Shevchenko


