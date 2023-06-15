Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A18731D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbjFOPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjFOPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:55:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375C10F6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686844525; x=1718380525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/UExcCSWcCbBihpF3Gt3tZY015dD69CsvobSQlZbPY=;
  b=Ne+TEIZtZiZouhs/BS/1amvjyNiskpMPtnAM3YPVXmeAXjnlBal75s18
   lGUjDQqy3YIYUsps1uFR3ov5poNgrxYnFVcpI8fBVgqF4MNsk2HrA6qzN
   w2KSCtxeTKHQBVOfWRvWcNnbDGUGSUw8TYsTI2fnZx7szcbgSHBZsT8gh
   B5KGjMTvCYcKMXg74xDPc2gF7MLvg0468NBfKyuMzyoVuEnUb5UOgRQrZ
   KHDPStD2rVZ5z59fErG4ChiBlO4ISInF/8Ffi9e3jCwT5bb+fubQtQBAB
   pdPNh07kRg5HKxATGe6/pc3EyM4dQwdLoSIY1EPH5W5qCLA+qXOyiYs6P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343683102"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343683102"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="712509047"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="712509047"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2023 08:53:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9pI9-003ygq-0i;
        Thu, 15 Jun 2023 18:53:45 +0300
Date:   Thu, 15 Jun 2023 18:53:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Message-ID: <ZIs0CC2J7nu0LHEK@smile.fi.intel.com>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com>
 <87pm75kd0h.fsf@intel.com>
 <ZF4j0NPoBGMBT8CO@smile.fi.intel.com>
 <87mt29kc34.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt29kc34.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:45:19PM +0300, Jani Nikula wrote:
> On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 12, 2023 at 02:25:18PM +0300, Jani Nikula wrote:
> >> On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> >> >> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> >> >> masks for fixed-width types and also the corresponding BIT_U32(),
> >> >> BIT_U16() and BIT_U8().
> >> >
> >> > Why?
> >> 
> >> The main reason is that GENMASK() and BIT() size varies for 32/64 bit
> >> builds.
> >
> > When needed GENMASK_ULL() can be used (with respective castings perhaps)
> > and BIT_ULL(), no?
> 
> How does that help with making them the same 32-bit size on both 32 and
> 64 bit builds?

	u32 x = GENMASK();
	u64 y = GENMASK_ULL();

No? Then use in your code either x or y. Note that I assume that the parameters
to GENMASK*() are built-time constants. Is it the case for you?

-- 
With Best Regards,
Andy Shevchenko


