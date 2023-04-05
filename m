Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147456D7AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjDELRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjDELQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:16:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51A59FF;
        Wed,  5 Apr 2023 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680693411; x=1712229411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jzs89KD6J2QAkjfrsdDESP2BknPRkKHKJ7f8eMf6mBk=;
  b=OOFkg5jno1AcjrQl2Aq+7wRwwvQ6skheR/yHCikZmaaJqA/MBVB0OCGg
   mL2EqGXFa+cl/02rxpDho7Ix7PwzzBAbDtlmabuasMT+xvgNBp9kJqrxo
   uD2Od0xnMTW9VCGsBxUgL2uAZoYs1qbVS76dUtzJ6sCa2r7/rfc1/DKMs
   cBJHglz5jm1NGGyAmRmvhrK01QpNw+8PLtY/hd2xMunE6xwMvSCxEs1B2
   Z1yvGxNgPP5fLoqYsI58LSPyzSDlkm0/H4k9Svq9PsGYq4LRCbg5yzBhv
   a/0RpnZgOXoPoHx+3yvKM1s2TpM9MqGem/G9KML2tPtaBmr5nhO0cDyho
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428712710"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428712710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 04:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="686713360"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="686713360"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2023 04:15:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk178-00Co2c-0d;
        Wed, 05 Apr 2023 14:15:42 +0300
Date:   Wed, 5 Apr 2023 14:15:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Olliver Schinagl <oliver@schinagl.nl>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/2] iopoll: Introduce ioreadXX_poll_timeout() macros
Message-ID: <ZC1YXarlQKresoTv@smile.fi.intel.com>
References: <20230330141413.25569-1-andriy.shevchenko@linux.intel.com>
 <3a348abc-d1f3-364f-88de-a0012fbc0fde@schinagl.nl>
 <ZC04J30xQTVPJ1ho@smile.fi.intel.com>
 <20230405094147.GS33314@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405094147.GS33314@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 12:41:47PM +0300, Mika Westerberg wrote:
> On Wed, Apr 05, 2023 at 11:58:15AM +0300, Andy Shevchenko wrote:
> > On Fri, Mar 31, 2023 at 10:12:31AM +0200, Olliver Schinagl wrote:
> > > On 30-03-2023 16:14, Andy Shevchenko wrote:

...

> > > But I actually have a small addendum for this series, as it will break
> > > `drivers/net/wwan/t7xx/t7xx_dpmaif.c` due to a redefinition (yeah I know).
> > > 
> > > So I have:
> > > https://gitlab.com/olliver/linux/-/commit/c9e591f2dabb2dbaeceebee61fa70b70fdbffc2a
> > > https://gitlab.com/olliver/linux/-/commit/41e0f8c08a1c55940813a240215910336ad7bec2
> > > https://gitlab.com/olliver/linux/-/commit/f36562f09b0185d403415864ef7218b46a742cdc
> > > https://gitlab.com/olliver/linux/-/commit/66237fd97bc42d272602b01dc0cca541c619b2be
> > > 
> > > Which actually replaces silly calls like readx_poll_timeout(ioread32, ... .
> > > 
> > > Do you want me to (re-?)post this as a series? I can put your thunderbolt
> > > (and your changes here) and post as one big series (or you can do the same
> > > obviously).
> > 
> > I believe the best course of action is to collect this series and your fix
> > in your hands and send it as a material for Linux WWAN subsystem with Mika's
> > Ack (if he has no objections). That said, let's wait for Mika's answer
> > on this.
> 
> No objections from my side.

Thank you, Mika!

This implies that I stop issuing a new version and Olliver takes over.

-- 
With Best Regards,
Andy Shevchenko


