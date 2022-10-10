Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F65F9899
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiJJGtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiJJGs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:48:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E957576;
        Sun,  9 Oct 2022 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665384510; x=1696920510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tpV8I20bPwnleIgRuVNbiXE++yFty8pyBbknzN9MNnw=;
  b=ESwANT+/0+RKcyt819JTRDo7iIVo/qplnR2KU6Y8eDIZwrmp8mQrm/zD
   AG/U88OWZCcLuMeZXRzYpLRj6OGWFLne4u8zpq63IDcQqhi3lNDVV+E/l
   fr5CTqwFhFdPqVg8F4sYIgErYuippWUP9SnLsAhkHSFuIB4cVvngRVSSy
   LwfclRQyKsKkoU9M34MeCDgTleGdyc+rmQqFJgIS1kwpBfmW3RCaV0GBI
   DOBhQKfz4Ftje1v9z1d2DkAso5FuIXHv0recZBDFYkP2Ukk6IHtboTmbT
   CLqXmeVkVuBRUs0MbFnIwCcP6SseHDhRgANQOlSRvm/LdUZu10Cb/gS4F
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="368294792"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="368294792"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 23:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="625869133"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="625869133"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2022 23:47:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohmZx-004kth-0l;
        Mon, 10 Oct 2022 09:47:57 +0300
Date:   Mon, 10 Oct 2022 09:47:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: st: Avoid using of_node member of struct
 gpio_chip
Message-ID: <Y0PAHF8lZUpYE3CW@smile.fi.intel.com>
References: <20221004125449.67679-1-andriy.shevchenko@linux.intel.com>
 <Y0O4GNR28kSOR1Iu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0O4GNR28kSOR1Iu@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 11:13:44PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 04, 2022 at 03:54:49PM +0300, Andy Shevchenko wrote:
> > The of_node member of the struct gpio_chip is obsoleted and
> > shouldn't be used. It will be removed in the future.
> > 
> > Replace its use in st_pctl_dt_calculate_pin() by comparing
> > the fwnode pointers.
> > 
> > Fixes: e75729b2f63f ("pinctrl: st: stop abusing of_get_named_gpio()")

...

> Are you sure chip's fwnode is properly set here (without your other
> patch)? I don't believe the driver sets it up, and I don't think gpiolib
> maps it from the gpio_chip->of_node.
> 
> Actually, there is another reference to of_node in gpio chip in
> st_gpiolib_register_bank()...

You are right, this patch has been made on top of another not yet published
one. Hence, nothing to fix it right now.

-- 
With Best Regards,
Andy Shevchenko


