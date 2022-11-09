Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B53622FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKIQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKIQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:08:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D739B1DD;
        Wed,  9 Nov 2022 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010118; x=1699546118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FiQLWYkjdyO1qQhhHY44DqIPDJ/CxNxSI7jLEJoEGVY=;
  b=QXjkZIwsOEfGQ8mZeFFTfHXSEyowOvaITkKXMo3z114Gw5SHl2TEbzgo
   cDcET5VWL8QeetbQF11sKKU5vpD3flkG/D/cZvbyjXTW9f7pC8bxAAhHR
   XvxuCkbXsg7vwWLkGBwuLUXeRRHZVSopRXQ4wUlLbmBTR77r6fOXw1xnz
   3DjN2J66JS0+1y2ZazhTMCaV2IcOg9Q2XImls2UPSjKaFGYGVHUAoIkaV
   2ozyoVGJz3PO/qDb1MdKbRmpnyvAMmevFOpViCyXEZKzyZmGZ+ahB+cSb
   2mXY98EdtQKq1ugu8Z27OP9TaSWfy1swq5N0Ru+xYyfWGFp6tfsWA8HhQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="373164957"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="373164957"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="639244231"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="639244231"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2022 08:08:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osncv-009oqP-3A;
        Wed, 09 Nov 2022 18:08:33 +0200
Date:   Wed, 9 Nov 2022 18:08:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: Move for_each_maps() to namespace and
 hide iterator inside
Message-ID: <Y2vQgdzBl+MvoqQM@smile.fi.intel.com>
References: <20221109155724.42354-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109155724.42354-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:57:24PM +0200, Andy Shevchenko wrote:
> First of all, while for_each_maps() is private to pin control subsystem
> it's still better to have it put into a namespace.
> 
> Besides that, users are not relying on iterator variable, so hide it
> inside for-loop.

...

> +#define for_each_pin_map(_maps_node_, _map_)						\
> +	list_for_each_entry(_maps_node_, &pinctrl_maps, node)				\
> +		for (unsigned int __i = 0;						\

> +		     _map_ = &_maps_node_->maps[__i], __i < _maps_node_->num_maps;	\

Hmm... I think this is actually not okay, if we have maps be NULL and
num_maps = 0, KABOOM is guaranteed.

I will experiment and update this.

Meanwhile, Linus, do you think this change is useful?

> +		     __i++)

-- 
With Best Regards,
Andy Shevchenko


