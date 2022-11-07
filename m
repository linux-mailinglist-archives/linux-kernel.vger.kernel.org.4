Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D180E61F0DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiKGKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKGKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:37:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB418B2A;
        Mon,  7 Nov 2022 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667817424; x=1699353424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6MTD6B4lNHMqgSksufKxFv2DiiLzRusg7SK8cxF7qQ=;
  b=ipV3bX5fuKQFv/lfvOtNIrgq+Vs2ILcNg1kKRDSVNqPCSkvZEJ8c869c
   3Mw9ZWXNzId2L0emgr/ZA1jRbGaIT6T299EHiPGlmgu0+ep/pvjPHfzgp
   8jXF9cX/t11gh8hjgwqk/orgp/dWHkA5yxe8oP6nkfjlmVfPG2U8MKJZ/
   7mFSbbJtX629d5gLOXpkLZufJrIxifHkAij+CRXP4wIs8SIfLl1efNIUt
   ImkJwCEho4cTLbqaWxb5ipD8YMloL3EmSfjwpGnzSyK7LJ51DSbwgrF02
   RtrxAF2icMcpcgmsWHb4A61viemywuUUJOzXTT8SyO8qGhxMwYhuKBikH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="312145289"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="312145289"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 02:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="638322691"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="638322691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 02:37:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1orzUy-008av4-28;
        Mon, 07 Nov 2022 12:37:00 +0200
Date:   Mon, 7 Nov 2022 12:37:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Migrate i8255 GPIO drivers to regmap API
Message-ID: <Y2jfzKZkcEcQTdH5@smile.fi.intel.com>
References: <cover.1667472555.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667472555.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 07:20:46AM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> Precursor patches are provided for 104-dio-48e and 104-idi-48 to migrate
> their respective device-specific registers first in order to simplify
> the subsequent patch migrating the i8255 library and its dependents.
> 
> The struct i8255 control_state member serves as a cache of the i8255
> device's control register. Does the regmap API support caching such that
> we won't need to manually update a control_state member?

Yes, regmap supports caching and IIRC it's opt-out.

> William Breathitt Gray (3):
>   gpio: 104-dio-48e: Migrate to regmap API
>   gpio: 104-idi-48: Migrate to regmap API
>   gpio: i8255: Migrate to regmap API
> 
>  drivers/gpio/gpio-104-dio-48e.c | 200 +++++++++++++++++++----------
>  drivers/gpio/gpio-104-idi-48.c  | 110 +++++++++++-----
>  drivers/gpio/gpio-gpio-mm.c     |  97 ++++++++++----
>  drivers/gpio/gpio-i8255.c       | 218 +++++++++++++++++++++-----------
>  drivers/gpio/gpio-i8255.h       |  54 ++++----
>  5 files changed, 451 insertions(+), 228 deletions(-)
> 
> 
> base-commit: b8b80348c57b360019071e17380298619c5d8066
> -- 
> 2.37.3
> 

-- 
With Best Regards,
Andy Shevchenko


