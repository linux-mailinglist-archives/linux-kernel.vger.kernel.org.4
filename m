Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179726AEE62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCGSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjCGSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:10:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C61F485;
        Tue,  7 Mar 2023 10:05:59 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334639735"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334639735"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="654063694"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="654063694"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 10:05:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pZbhD-00H31K-18;
        Tue, 07 Mar 2023 20:05:55 +0200
Date:   Tue, 7 Mar 2023 20:05:55 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] gpio: pisosr: Use devm_gpiochip_add_data() to
 simplify remove path
Message-ID: <ZAd9A+waCS88zDZj@smile.fi.intel.com>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-4-afd@ti.com>
 <ZAd35D4C96MP5Qrm@smile.fi.intel.com>
 <b6e4ae3f-a3ff-b118-43ce-a45d007ae2e9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e4ae3f-a3ff-b118-43ce-a45d007ae2e9@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:55:11AM -0600, Andrew Davis wrote:
> On 3/7/23 11:44 AM, Andy Shevchenko wrote:
> > On Tue, Mar 07, 2023 at 10:54:30AM -0600, Andrew Davis wrote:
> > > Use devm version of gpiochip add function to handle removal for us.
> > > 
> > > While here update copyright and module author.

...

> > > -	mutex_destroy(&gpio->lock);
> > 
> > You need to wrap this into devm.
> 
> I was thinking that but it seems there is no such thing. Most drivers
> just ignore unwinding mutex_init() since it doesn't allocate anything.
> 
> mutex_destroy() is a NOP unless you are doing DEBUG builds were
> it sets a magic value to check for use-after-free issues.

In any case it's correct to destroy it.

See, how it's done, for example, here a82c7cf803d9 ("leds: is31fl319x: Wrap
mutex_destroy() for devm_add_action_or_rest()").

-- 
With Best Regards,
Andy Shevchenko


