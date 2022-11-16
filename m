Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254A862C328
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiKPPyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiKPPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D24C27F;
        Wed, 16 Nov 2022 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668614065; x=1700150065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEMTVhD37/v0TOE4RjN1urcfJX/Nq7FS9gVShtgGvtM=;
  b=ODLUzvTYVN6KCKmuBls1n5ouRs27EyeCV8bDT0MBTtrdrnwiO2xPvuOr
   wLkOoYn+Jfvx8KDyBTr3E7bbo65UEV0GzHu3wkqYB/15AXm8UbLGyrGGB
   Xuypnn/ynWZo77sB5kOUk44OJhYgKwAgFbdKNonm0RLTYuVULjA/8inFI
   n4UNMVwHTNfOuzhzwhKVS9uTT9AjzTGZ2U5oXLrNoIYUfzB3zXSThayXX
   FJeYJhIna3DHudAhKOcnvHQaFKr/8s67FzGlQsdoP3b95KXYnbue0TUec
   oHalKYW/YnObYlXpI2emWBzfDhaDiQWBBI7sf6cn53txJC2KpE3lLs0lg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310208251"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="310208251"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 07:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="633670268"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633670268"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2022 07:54:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovKk0-00DCi3-1R;
        Wed, 16 Nov 2022 17:54:20 +0200
Date:   Wed, 16 Nov 2022 17:54:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        robert.marko@sartura.hr, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
Message-ID: <Y3UHrAQjOnUh4frh@smile.fi.intel.com>
References: <cover.1668129763.git.william.gray@linaro.org>
 <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
 <Y3DlsTAQMi6kKObJ@smile.fi.intel.com>
 <Y3DvUaA7YYAsypGv@fedora>
 <cc33aaa342ad60749d2f7c2a6d690733@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc33aaa342ad60749d2f7c2a6d690733@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:41:30PM +0100, Michael Walle wrote:
> Am 2022-11-13 14:21, schrieb William Breathitt Gray:
> > On Sun, Nov 13, 2022 at 02:40:17PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 10, 2022 at 08:55:50PM -0500, William Breathitt Gray
> > > wrote:
> > > > If you only have reg_dat_base set, then it is input-only; if you only
> > > > have reg_set_base set, then it is output-only. Thus, we can always set
> > > > gpio_chip get_direction to gpio_regmap_get_direction and return
> > > > GPIO_LINE_DIRECTION_IN/GPIO_LINE_DIRECTION_OUT given the respective
> > > > register base addresses configuration.
> > > 
> > > Seems legit to me. Have you checked if we have any gpio-regmap
> > > drivers that
> > > have something like this in their configuration already? In such
> > > cases we need
> > > to be sure they behave as expected.
> > > 
> > > From the code perspective:
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I see gpio-sl28cpld has two device types SL28CPLD_GPO (output-only) and
> > SL28CPLD_GPI (input-only); gpio-tn48m similarly has two device types
> > TN48M_GPO (output-only) and TN48M_GPI (input-only). It doesn't look like
> > the change in this patch will cause problems for them, but I'll let
> > Michael Walle and Robert Marko comment if they see issues here.
> 
> For the sl28cpld driver this shouldn't be a problem. So for that
> Acked-by: Michael Walle <michael@walle.cc>
> 
> But back when I wrote gpio-regmap the bgpio served as a blue print.
> There is the same handling. If you look at gpiolib-sysfs.c there
> is a comment about the direction property:
> 
>  * MAY BE OMITTED if kernel won't allow direction changes
> 
> So from a gpiolib/sysfs POV I'm not sure about this change. Does
> get_direction == NULL means setting the direction isn't possible?
> OTHO there is a fat "MAY" :)
> 
> Which brings me to the question of "why this change?". The commit
> message doesn't mention it. Just out of curiosity.

Sysfs shouldn't be considered nowadays as anything but deprecated and
not-to-use interface. Hence, I don't care what it tells there.

-- 
With Best Regards,
Andy Shevchenko


