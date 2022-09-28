Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE05EDF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiI1OuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1Otq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FE3DF24;
        Wed, 28 Sep 2022 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664376580; x=1695912580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4mKdCBQ/L3nadRGu2ObR+yaP1/MetbEPHis8vAe2ShM=;
  b=lFDx7Zw3fh9Yeg6aiVp+WbamPOkhlb34otEvrNTbotm+vpKxYgcmNXtX
   6KegpGb2bWPtI/T1Q4K6zJSOh0o+6rcO/hvIunvM1JkmXNKGy2298NgRF
   umwDc3NF0Tl20exl6HC6LoREPcZeJMsOcrEcDkmGWEjdZktp+SBYQ5Lv7
   5oUrPEuIsOuGelh/7sc29sZhPWnFZvZDQpyJc+9jM6u3RZ3S0Zsr7HN4A
   8UomxGT5AYiKxu6QKGwhALtiMxGWBf5FE/O/QTlrEq5um35/58Yjak3cT
   TvjsXn6l5XNRr4oie9fqxbtJ5+l7UTJvQY2N9vrotTRWo4icbPw68I8lj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="300338312"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="300338312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="655152824"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="655152824"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2022 07:49:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odYNU-008yKB-15;
        Wed, 28 Sep 2022 17:49:36 +0300
Date:   Wed, 28 Sep 2022 17:49:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: Replace custom implementation of
 device_match_fwnode()
Message-ID: <YzRfAE58ZMI/MC0K@smile.fi.intel.com>
References: <20220927172258.62418-1-andriy.shevchenko@linux.intel.com>
 <YzRZp4e48XK6jAZD@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRZp4e48XK6jAZD@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:26:47PM +0200, Thierry Reding wrote:
> On Tue, Sep 27, 2022 at 08:22:58PM +0300, Andy Shevchenko wrote:
> > Replace custom implementation of the device_match_fwnode().

> I really don't see the point in having an exported symbol for this. It's
> a simple comparison and the result is even longer than the original.

Longer doesn't always mean worse.

> The
> *only* reason why this helper exists seems to be because it is getting
> used in *_find_device() callbacks.

Yes and no. Initially for the purpose to be a callback it can be reused.
The point is that it hides the dev_fwnode() machinery behind and taking
into account ongoing discussion about constification of the dev_fwnode()
we might need to touch this or similar places to avoid problems with
compiler.

> Honestly, I don't see a reason why this should be applied. And frankly,
> why bother making all these changes. It's a waste of time, in my
> opinion.

Obviously I will not do it if I be with you on the same page.
But okay, not a big deal in this case.

-- 
With Best Regards,
Andy Shevchenko


