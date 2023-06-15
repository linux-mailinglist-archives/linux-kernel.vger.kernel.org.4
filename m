Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79C731630
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbjFOLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjFOLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:11:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787F695;
        Thu, 15 Jun 2023 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686827503; x=1718363503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7suixzcMP7z6n1FaI3b9pArrUtwogDAwwgTIMBuyRlc=;
  b=Z97/zAOuvhRTqEc0uQfs2JT+8ABvlXB5p+yDIjbmZs/5lf1GTZQv/XIA
   67aO+ue5HJPYPJOxPu3oaOLbgWkKP+qMO3PT4M+arf0Vw1twRnX2d5cDk
   l67AJUl3Dpco3qoWObmc5ttlFM+WY+qyZAoDXGzNTblWOHTMr8sesvPLG
   aJfuxjHT5P4mummhdfIgzz39B80sv+ZYN30nOMpZswiho19weTzR7qFkz
   zkzQQkxOt5eTnFuyn8j/mGNaGfNyrE8GpQGH+uZQdQdLY4u5ndxTJ+22Q
   jmuGj5clBxxPoj1WlRA+pviZDChULH8tTabr0DfGLscBu27r+T5AZ18DP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356371636"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="356371636"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782480892"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782480892"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 04:11:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9kt9-003vR1-0c;
        Thu, 15 Jun 2023 14:11:39 +0300
Date:   Thu, 15 Jun 2023 14:11:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] rtc: isl12022: add support for trip level DT
 binding
Message-ID: <ZIrx6lZfsYnM7TnQ@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615105826.411953-5-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:58:22PM +0200, Rasmus Villemoes wrote:
> Implement support for using the values given in the
> isil,battery-trip-levels-microvolt property to set appropriate values
> in the VB85TP/VB75TP bits in the PWR_VBAT register.

A few nit-picks below.

...

> +static void isl12022_set_trip_levels(struct device *dev)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	u32 levels[2] = {0, 0};

A nit, 0, 0 is not needed, {} will do the job.

> +	int ret, i, j, x[2];
> +	u8 val, mask;

BUILD_BUG_ON(ARRAY_SIZE(x) != ARRAY_SIZE(levels)) ?

> +	device_property_read_u32_array(dev, "isil,battery-trip-levels-microvolt",
> +				       levels, 2);

A nit, ARRAY_SIZE(levels) ?

> +	for (i = 0; i < 2; i++) {

ARRAY_SIZE(x) ?

> +		for (j = 0; j < ARRAY_SIZE(trip_levels[i]) - 1; j++) {
> +			if (levels[i] <= trip_levels[i][j])
> +				break;
> +		}
> +		x[i] = j;
> +	}
> +
> +	val = FIELD_PREP(ISL12022_REG_VB85_MASK, x[0]) |
> +		FIELD_PREP(ISL12022_REG_VB75_MASK, x[1]);
> +	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
> +
> +	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
> +	if (ret)
> +		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
> +}

-- 
With Best Regards,
Andy Shevchenko


