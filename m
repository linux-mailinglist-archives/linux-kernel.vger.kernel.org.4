Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD45EA51E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiIZL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiIZLy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:54:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744D580B0;
        Mon, 26 Sep 2022 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664189427; x=1695725427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+ifAFjkIpf8nC5A0f/apNUT3BdhUru5RvSDO/r6TG8=;
  b=kQKDnVKR2b/Cumhs1lq7HUputvNow+5sqFhy0K9SwZ6cbgi1yz/FneJ4
   /NEHUe17RjqQmqp9bj4JjnOFM4RLDWcodQfpj+naM20jQ16gTWd0bUN81
   chiPbTH/bDjsHXzyliuQcJmws/BCIJzmpUF2rd+ScdwFh8kIuMpAwXlGl
   6hKblccMjfeYY9rvldOnXo+kRb0qF0k2wrKGOnmsk+KkPsItPmy7wEtxm
   kqZUOLpKKdvB6H0H1L872UPoiPuQdS0oyjMnrsaSqeFdMAmknl7+ZWaNC
   /lJJo6SEnKUgfNNiOJcW6IOlGUXTFJb6kom6UX6jGtDs0rJL+SBAkOm1t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="365028445"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="365028445"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="796284064"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="796284064"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 26 Sep 2022 03:48:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oclfM-007lTI-2G;
        Mon, 26 Sep 2022 13:48:48 +0300
Date:   Mon, 26 Sep 2022 13:48:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Magnus Damm <damm+renesas@opensource.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] serdev: Replace poll loop by readx_poll_timeout()
 macro
Message-ID: <YzGDkKnttYBI4S0Q@smile.fi.intel.com>
References: <20220923171048.37386-1-andriy.shevchenko@linux.intel.com>
 <Yy7wqSWVBGwNtiiZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy7wqSWVBGwNtiiZ@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 01:57:29PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 23, 2022 at 08:10:48PM +0300, Andy Shevchenko wrote:
> > The readx_poll_timeout() consolidates the necessary code under
> > macro. Replace current code with it.

...

> > +#include <vdso/time64.h>
> 
> Ick, just for USEC_PER_MSEC?  That should be in units.h, not burried in
> a vdso-only .h file.  This feels wrong, sorry.

Why are you asking me about this? It was not my choice and it was made
a couple of years ago (see [1]).

As a solution I can just drop using that constant in v3.

[1]: b72a9c5e023b ("linux/time64.h: Extract common header for vDSO")


-- 
With Best Regards,
Andy Shevchenko


