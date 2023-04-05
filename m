Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA86D779C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjDEI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjDEI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:59:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42A55B4;
        Wed,  5 Apr 2023 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680685149; x=1712221149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4O5ehGBLPBte6x414yZg/CsErbhx48+S52oonQLnw0=;
  b=kQE+Hrn6ecz+Fet9ltcXJtkpkD9wKWWq5j4UL3JDZoWS3Fn0VZftn0e1
   kAKB2t81sSejeWnOu7KkRjhLBHeQqoLc+f9Fj+u8Z+2ejSY9AvJjTGVJD
   MCKOmB2vQn1I169YDqgb7brXk+Pwc7rT5EpM2XVUibjKMTPITtpreOcUz
   3iRbY1pJVQBX81vD8pXAJI7/2UprTJmxxigUnI7qe6p+cn3N+kv2kXx0c
   8mxXVN4cSq1yqhPjP52vLqnjh0cxtCcQzD+Ts07QGvRGfyVZWx0YW3T/3
   s21h1OARvVdJzCoYRZVVdWqZCscfdPcQUfrRe/6nMeU8RD6nmt23DRZgs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344118169"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344118169"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016403555"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="1016403555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 05 Apr 2023 01:58:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyy7-00Cl8Y-1a;
        Wed, 05 Apr 2023 11:58:15 +0300
Date:   Wed, 5 Apr 2023 11:58:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/2] iopoll: Introduce ioreadXX_poll_timeout() macros
Message-ID: <ZC04J30xQTVPJ1ho@smile.fi.intel.com>
References: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
 <3a348abc-d1f3-364f-88de-a0012fbc0fde@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a348abc-d1f3-364f-88de-a0012fbc0fde@schinagl.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:12:31AM +0200, Olliver Schinagl wrote:
> On 30-03-2023 16:14, Andy Shevchenko wrote:

...

> But I actually have a small addendum for this series, as it will break
> `drivers/net/wwan/t7xx/t7xx_dpmaif.c` due to a redefinition (yeah I know).
> 
> So I have:
> https://gitlab.com/olliver/linux/-/commit/c9e591f2dabb2dbaeceebee61fa70b70fdbffc2a
> https://gitlab.com/olliver/linux/-/commit/41e0f8c08a1c55940813a240215910336ad7bec2
> https://gitlab.com/olliver/linux/-/commit/f36562f09b0185d403415864ef7218b46a742cdc
> https://gitlab.com/olliver/linux/-/commit/66237fd97bc42d272602b01dc0cca541c619b2be
> 
> Which actually replaces silly calls like readx_poll_timeout(ioread32, ... .
> 
> Do you want me to (re-?)post this as a series? I can put your thunderbolt
> (and your changes here) and post as one big series (or you can do the same
> obviously).

I believe the best course of action is to collect this series and your fix
in your hands and send it as a material for Linux WWAN subsystem with Mika's
Ack (if he has no objections). That said, let's wait for Mika's answer
on this.

-- 
With Best Regards,
Andy Shevchenko


