Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAC650D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiLSOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiLSOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:38:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56BFFD;
        Mon, 19 Dec 2022 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460731; x=1702996731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aYzZBOs+BOeZN2LyM0VkyKujjc0n0nPt0i+E9p/iOYE=;
  b=iLc+0NLaeewpWrnpv/HD7lCg+e+iNzy4TtscZjFg3Rer/kkS+yu4t6jx
   86uAS6h+uOxc8IGisFRY7+mkq2D1onQqbffCWPzyIIY8nB/OEYNnE/3Z+
   wkh7iT01c2NCB5e4glFsLacLvCN1zIzCBI1hbzE/3DBiVohtXs1bYbiLX
   M1WaTUYUDUfSVN9TEQdYkHXS8bCNDotIvG+YOgPKVkyddBEep/azay/Ym
   T0wupiR+vAENWis/1t/8f30C9vVs8S2Lbd7oVSxoIC9xLSDcf72hS9n8m
   p+U1+EfunmI02blwSxmwRAg1bZJmjAyg9U8pdrbC7Q77zvO6Pv7y1M22+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299038410"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299038410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="757642269"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="757642269"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 19 Dec 2022 06:38:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7HI0-00CKJs-25;
        Mon, 19 Dec 2022 16:38:48 +0200
Date:   Mon, 19 Dec 2022 16:38:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 01/17] pinctrl: intel: Introduce INTEL_COMMUNITY_*()
 to unify community macros
Message-ID: <Y6B3eAn3D7ifK8By@smile.fi.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
 <Y6B2FyOvOK2rR9H9@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B2FyOvOK2rR9H9@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:32:55PM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 02:26:27PM +0200, Andy Shevchenko wrote:
> > Now it becomes visible that we can deduplicate SoC specific
> > *_COMMUNITY() macros across the Intel pin control drivers.
> > For that, introduce a common INTEL_COMMUNITY_GPPS() and
> > INTEL_COMMUNITY_SIZE() macros in the pinctrl-intel.h.
> 
> You should really start learning how to use --cover-letter option with
> git format-patch because for anything more than one patch pretty much
> requires such.

Oh, indeed.

> Here I would really like to see how much lines this
> series ends up removing :)

drivers/pinctrl/intel/pinctrl-alderlake.c    | 18 ++----------------
drivers/pinctrl/intel/pinctrl-broxton.c      | 31 +++++++++++--------------------
drivers/pinctrl/intel/pinctrl-cannonlake.c   | 31 +++++++++++--------------------
drivers/pinctrl/intel/pinctrl-cedarfork.c    | 13 +------------
drivers/pinctrl/intel/pinctrl-denverton.c    | 13 +------------
drivers/pinctrl/intel/pinctrl-elkhartlake.c  | 24 +++++++-----------------
drivers/pinctrl/intel/pinctrl-emmitsburg.c   | 13 +------------
drivers/pinctrl/intel/pinctrl-geminilake.c   | 21 ++++++---------------
drivers/pinctrl/intel/pinctrl-icelake.c      | 35 +++++++++++++----------------------
drivers/pinctrl/intel/pinctrl-intel.c        |  9 +--------
drivers/pinctrl/intel/pinctrl-intel.h        | 35 +++++++++++++++++++++++++++++------
drivers/pinctrl/intel/pinctrl-jasperlake.c   | 13 +------------
drivers/pinctrl/intel/pinctrl-lakefield.c    | 13 +------------
drivers/pinctrl/intel/pinctrl-lewisburg.c    | 12 +-----------
drivers/pinctrl/intel/pinctrl-meteorlake.c   | 23 ++++++-----------------
drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 37 +++++++++++++------------------------
drivers/pinctrl/intel/pinctrl-tigerlake.c    | 30 ++++++++++--------------------
17 files changed, 115 insertions(+), 256 deletions(-)

> The series looks good to me, though.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


