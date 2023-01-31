Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27AF682C80
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjAaMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAaMYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:24:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D994201;
        Tue, 31 Jan 2023 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675167874; x=1706703874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B+jzb4I37dNSApzbqADF2C9W9v68b2IUVH3ZFuuIjjs=;
  b=U5tyjvxutlV+DuFWPQVgGNES23tEt5giL6skrC+WvWcgBANvQJq5ZOlT
   EhVnAtXwUECWJ9kNJQ03Iqs5V5tS8JT1iYcozF8jvVKBwAF+O44YvTmKb
   UOr2BAxKSszGICfkfzMZ5fQfPjonbGlARRnxBs3vpaB8UtfMttoZSS6gN
   +8bBWC+B07+DdyyNSg/d85mChatFzjgQm1X44dbGYHLoA0sTIpQJbcwV8
   LzMGOBMFjUG4NUpnxvyteLPa47YDKlaLCdLasKMnkLCw8IHXfZA7XQuLg
   cpeUAu2uKeRby3d/GoVLGW3UZMFxyenQ6EL+hmf1IRElG3sg4pQIEXkVY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307481917"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="307481917"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="993242918"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="993242918"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jan 2023 04:24:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMpga-000FEz-2w;
        Tue, 31 Jan 2023 14:24:28 +0200
Date:   Tue, 31 Jan 2023 14:24:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y9kIfEj70XdO3Q/7@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:20:52AM +0000, Sahin, Okan wrote:
> On Wed, 18 Jan 2022 11:20 AM
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Wed, Jan 18, 2023 at 09:38:10AM +0300, Okan Sahin wrote:

...

> >> +		rdev = devm_regulator_register(dev,
> >> +					       &desc[i], &config);
> >
> >This is perfectly one line.
> Thank you, I will arrange it.
> >
> >> +		if (IS_ERR(rdev))
> >> +			return dev_err_probe(dev, PTR_ERR(rdev),
> >> +					     "Failed to register regulator\n");
> >> +	}
> >> +
> >> +	return 0;
> >> +}

> However, this one is not fit when I set max-line-length argument as 80 in
> checkpatch script. What do you suggest? This line has 99 characters.

Which line do you refer to?

-- 
With Best Regards,
Andy Shevchenko


