Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915BA6ABF4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCFMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCFMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:16:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF020579;
        Mon,  6 Mar 2023 04:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678104990; x=1709640990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PuPDornh1OEsP3yzAZOWoqW4lUda0/ttH3RpXrbjS8s=;
  b=PygDbpHWIPxWSyE8IvXWrpvUkiZ2qYqLNhVQalvcTExejMAl/hzX2nyo
   IGaV+pk7uurgm+DIdOtWtM2KiVnUEug8bU8aAdadtdj/nIx5uEetgMHEA
   l+pVdeqL/y90C/b7cMJJf4HSC7rTnA1DNxtnYjXeRchIL/M06SK+EJWt9
   9VpsD8xGFxsSAKp7jsHbQDPmGR5JXXcagLujdJbjXSa0G0M2XD3rWnOxK
   13RUexfez0b8CzYRVGf+oDrrgGaMXyU4wBTPAqTjwE7O7xt27eqZpMkuK
   o4rdI994UCUOIB/tp1oZsqgcr8Jcl9I99SONT2oc6fu5f2bnIrAfQpeOf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="335560376"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="335560376"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="708633313"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="708633313"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 06 Mar 2023 04:16:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9lQ-00GLG9-1E;
        Mon, 06 Mar 2023 14:16:24 +0200
Date:   Mon, 6 Mar 2023 14:16:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZAXZmETRgpWAsE/+@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <20230304175751.2daae308@jic23-huawei>
 <ZAXYhIETzMa/7G6N@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAXYhIETzMa/7G6N@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:11:48PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 04, 2023 at 05:57:51PM +0000, Jonathan Cameron wrote:
> > On Tue, 28 Feb 2023 07:31:51 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:

...

> > > +	for (i = 0; i < 4; i++) {
> > > +		if (BIT(i) == gain) {
> > > +			ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
> > > +			return 0;
> > > +		}
> > > +	}
> > Andy's suggestion of something like..
> > 	if (!gain)
> > 		return -EINVAL;
> > 	i = ffs(gain);
> > 	if (i >= 4 || BIT(i) != gain)
> > 		return -EINVAL;
> > 
> > 	ads...
> > 
> > Is perhaps nicer than the loop.
> 
> Even better:
> 
> 	if (!gain || !is_power_of_2(gain))
> 		return -EINVAL;

Or if you want to combine all checks:

	if (clamp_val(gain, BIT(0), BIT(3)) != gain || !is_power_of_2(gain))
		return -EINVAL;

	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain));
	return 0;

(You can play with bloat-o-meter for the code generation and see which one is
 better from that aspect)

-- 
With Best Regards,
Andy Shevchenko


