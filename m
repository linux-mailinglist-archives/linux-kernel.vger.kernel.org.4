Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE156428E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLENBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiLENBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:01:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE8D1C126;
        Mon,  5 Dec 2022 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670245278; x=1701781278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t06hTuPTylxyL9L2Mkx5hZrsRZof+TAyjTUvgJ12Svo=;
  b=O2VJDjWnhY+7Hp3qSSYgQPjNWONLutuBqOE/pxJItLyRl12AcYPT5JG/
   UGORU1lNkM5ge4SAjrXBMsE35te2nCtAdJ7eQE/1rxbZ48iDf5FJroNtD
   Z85tHR7T2IeEr0bmK3WCnnQ3pcuRoYJSMiBEbcNRTD41t84e4oJEShcDx
   ob2DsKF1KWlos1klSmFuURhZjlXTNKkl+4pWI/mXGdHreJCoTCu+Ov7Jo
   hgLMPewpRTll+8txMPBVKxi1EUr8kze/mHwUUx3iZNgH1hc0Zkf0D867V
   Owx7mL1XE6Bb8kdGs91Ulow2IBCAI4jF+6cSrgj85pkMVY6eAclu7hZ9K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="303958929"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="303958929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:01:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752179333"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="752179333"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2022 05:01:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2B5u-004sYe-05;
        Mon, 05 Dec 2022 15:01:14 +0200
Date:   Mon, 5 Dec 2022 15:01:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
Message-ID: <Y43rmRW1S8PvMJW4@smile.fi.intel.com>
References: <20221205123903.159838-1-brgl@bgdev.pl>
 <Y43rPdus/9INC390@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y43rPdus/9INC390@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:59:42PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 05, 2022 at 01:39:01PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Linus Torvalds pointed out that using trylock here is wrong. This iteration
> > drops it in favor of unconditional locks but keeps all the fixes that came
> > later.
> > 
> > I will also not send it for this release but make it part of the updates PR
> > for v6.2 to give it some time in next.
> > 
> > v7 -> v8:
> > - don't use down_read_trylock(), just go straight for a full lock
> 
> Yep, it was a good wrap-up explanation.

But he also suggested to fold NULL check into call_*_locked(). Any points why
you decided not to go that way?

-- 
With Best Regards,
Andy Shevchenko


