Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895745EE0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiI1Pk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiI1PkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:40:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195337675E;
        Wed, 28 Sep 2022 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379621; x=1695915621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BIRTashmeCAkOF6Z1LglIdqt0BwFvyi02lwGwZN6jaw=;
  b=EXwcO76MiCA2u3pjlG5kjZcSiOarShuZyR08GLr5kkCWArm5f3JYlauG
   fQfyXQHRgfppWqiKgO/sUBvVlQFcVX+McQ5rE8BY55V9qnhvVADOUh2im
   wsHqVUmXGHqa4N+v6t+Zqzw9VsiMsMlLIX7efwzjfmmi5A6l5CdexVf/O
   ABG7o2/hKEwbr8aY1PvuWj/+CvNR04MY18L1N88u33w8BroUaamYUJyA8
   Z0JPXy/+WbzU+m52C/B0znjS+H+YaTwpslpmSE1FExMRSptC5T6eONFYf
   mUkot57BxvLSpf44tfji4q9SvfyRwe9E6BMrYoQ7b3N8D3dmogs0NN7YI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299234936"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="299234936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="652724445"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="652724445"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2022 08:40:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odZAX-0090As-2V;
        Wed, 28 Sep 2022 18:40:17 +0300
Date:   Wed, 28 Sep 2022 18:40:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: Replace custom implementation of
 device_match_fwnode()
Message-ID: <YzRq4fGcWACBi8WP@smile.fi.intel.com>
References: <20220927172258.62418-1-andriy.shevchenko@linux.intel.com>
 <YzRZp4e48XK6jAZD@orome>
 <YzRfAE58ZMI/MC0K@smile.fi.intel.com>
 <YzRg9cLVlfZfKhws@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRg9cLVlfZfKhws@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:57:57PM +0200, Thierry Reding wrote:
> On Wed, Sep 28, 2022 at 05:49:36PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 28, 2022 at 04:26:47PM +0200, Thierry Reding wrote:
> > > On Tue, Sep 27, 2022 at 08:22:58PM +0300, Andy Shevchenko wrote:
> > > > Replace custom implementation of the device_match_fwnode().
> > 
> > > I really don't see the point in having an exported symbol for this. It's
> > > a simple comparison and the result is even longer than the original.
> > 
> > Longer doesn't always mean worse.
> > 
> > > The
> > > *only* reason why this helper exists seems to be because it is getting
> > > used in *_find_device() callbacks.
> > 
> > Yes and no. Initially for the purpose to be a callback it can be reused.
> > The point is that it hides the dev_fwnode() machinery behind and taking
> > into account ongoing discussion about constification of the dev_fwnode()
> > we might need to touch this or similar places to avoid problems with
> > compiler.
> 
> Maybe next time use that argument in the commit message. That's much
> more convincing than a useless "replace custom implementation" because
> that just makes it look like you're doing this to pass the time or
> something.

Noted.

> Applied, with a slightly updated commit message, thanks.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


