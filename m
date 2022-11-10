Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357D6243F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiKJOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiKJOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:14:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462167018B;
        Thu, 10 Nov 2022 06:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668089642; x=1699625642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AuorvYTTFvI22jEW+pZGK+OOUvXnc9Abs3XkIMXnmAs=;
  b=FF7O9YHQDp1OsJfwkZASGkRxVgNCnSjMhW8bnTrIx6P+eYGD61N23qVk
   5ixvvwoB4hI1ilH0TTVqFhIEt+DmQbogbXP7DZte4Eb3xUn83eCSNBKdt
   BNnB38GYQCM+E5bkWPvblAGQfbxW6fqOouKGJfb8AMt5BzXeUwTlu8kaD
   Mqc9DvsbwYc46Qeq6E/RdxH1KJy/qC0kh/JTvw3O//VT9ahyYPdb5Y+/R
   DkrsG/WhKYQFhGaLPjGQ5P5MRI6m4prRoss1XC3dCbe5t0miSbYemeGfR
   whDC+qARdwxJs0sEXYMCH3TT0utSN9pfTbI1oNFU8ocqbHa2xaDbN3kHI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397610767"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="397610767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 06:14:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615109334"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="615109334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2022 06:13:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot8Ja-00ABCX-07;
        Thu, 10 Nov 2022 16:13:58 +0200
Date:   Thu, 10 Nov 2022 16:13:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y20HJe/vQPI4dWyW@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
 <20221031-gpiolib-swnode-v3-5-0282162b0fa4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v3-5-0282162b0fa4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:30:43AM -0800, Dmitry Torokhov wrote:
> Ensure that all paths to obtain/look up GPIOD from generic
> consumer-visible APIs go through the new gpiod_find_and_request()
> helper, so that we can easily extend it with support for new firmware
> mechanisms.
> 
> The only exception is OF-specific [devm_]gpiod_get_from_of_node() API
> that is still being used by a couple of drivers and will be removed as
> soon as patches converting them to use generic fwnode/device APIs are
> accepted.

...

> +	if (!IS_ERR_OR_NULL(fwnode))

As pointed earlier I still think this is not needed. Even for the sake of
showing an intent, the not-found fwnode(i.e. GPIO), will be handled anyway...

> +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> +					    &flags, &lookupflags);
> +
> +	if (gpiod_not_found(desc) && platform_lookup_allowed) {

...here by gpiod_not_found() which is an exact intention in both cases above
(fwnode is not provided / invalid or GPIO wasn't found).


With this addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


