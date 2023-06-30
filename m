Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB57441B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjF3SAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3R76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:59:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F835AB;
        Fri, 30 Jun 2023 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688147997; x=1719683997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SsGHuD60K6V+2Csu940O7qwcjIx9HfXaFouXONb7hXY=;
  b=MsJIGi3x5Fh7DSsaFiAWg8fZuB7zFPBZ20RuKGxQbzVJNLKuBNpoclbY
   VsILDQntt7zhU4uDKk1Zdn1dlAFyxuILxGvBoDty3WQPt+es8bHZL+aTa
   Wx4XriaA8YnV3qFCYjLi+A8QmyPt0n9aMaivUcCyZWsv3Hm/pAyO1AGNV
   e6g1NPk7wZLtWxPpGmIBTEBFE03M2OJkEHvFp1Vk8fMg9sCUSt9Zdu8Gs
   eC61gfyCCuJRxNOmpBiNsdMy2S1E7qSjt7TCUspv2L25fPD3YunQzdACf
   OJV3jcvfgKTf/MZ8mzy31c0mKMD31GXW65rD1PLSpPBWhv3R5vVOWyT5n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="361307514"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="361307514"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="831030189"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="831030189"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2023 10:59:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qFIPQ-001AjG-2G;
        Fri, 30 Jun 2023 20:59:52 +0300
Date:   Fri, 30 Jun 2023 20:59:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        kernel@axis.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] led: led-class: Read max-brightness from
 devicetree
Message-ID: <ZJ8YGFxQCHKCCAqw@smile.fi.intel.com>
References: <20230630092248.4146169-1-astrid.rost@axis.com>
 <20230630092248.4146169-2-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630092248.4146169-2-astrid.rost@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:22:46AM +0200, Astrid Rost wrote:
> Add max-brightness in order to reduce the current on the connected LEDs.
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions. Note that led-max-microamp should be preferably used, if it
> is supported by the controller.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Maybe you can also add to the cover letter that there are already users in
the kernel that may be simplified after this change lands the upstream.

> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  drivers/leds/led-class.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 9255bc11f99d..ce652abf9336 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -457,6 +457,10 @@ int led_classdev_register_ext(struct device *parent,
>  			if (fwnode_property_present(init_data->fwnode,
>  						    "retain-state-shutdown"))
>  				led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
> +
> +			fwnode_property_read_u32(init_data->fwnode,
> +				"max-brightness",
> +				&led_cdev->max_brightness);
>  		}
>  	} else {
>  		proposed_name = led_cdev->name;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


