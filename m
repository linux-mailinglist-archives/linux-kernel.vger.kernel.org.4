Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECCF6456EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:56:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762E10041;
        Wed,  7 Dec 2022 01:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670406960; x=1701942960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9p3iWoLP22mdK8lH1mdoYcGXRJk0lUpSxNqmRWLEp4=;
  b=jPRpWa52l55GVUEK8EZ7GkNc0Afk/p72xjIXZO5WE14JoINGYLpHRoqh
   gIMWNHJeMekZh7/aBTjWEgrktb3U/cDT+y7YzrLSPW8gqFwzaxCzY139R
   8UD7/Yys+MDKw7373KYdJQ2N8HSSGcMgks6feuqmmnESGE9pKhaM9U9em
   z6AkNprKI9DbzlPO1Fe324Q1IW9bXKmSHB+fGKqjVMzYtaSoLSVKfE7dE
   WF5SfUjwLN7dkCEHiduJdZ69MmvG4D5TZ2/+7VXiKaVuSi1i3pTh/7Wnc
   5lA/8/qaHcEe4clkY8XSOD8LJURaNEfh56bo9LEE2B64472mI1scgdg+p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316866808"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="316866808"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 01:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648674941"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="648674941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2022 01:55:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2r9b-005hPw-0O;
        Wed, 07 Dec 2022 11:55:51 +0200
Date:   Wed, 7 Dec 2022 11:55:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y5BjJmz5Mvdr8cAR@smile.fi.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
 <Y41MxPthLjitvzEl@sol>
 <CACRpkdb67ygsEuZhRZ9TGmmNXhiU2LsuefD0-48xtCLx3fq-KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb67ygsEuZhRZ9TGmmNXhiU2LsuefD0-48xtCLx3fq-KA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 01:06:46AM +0100, Linus Walleij wrote:
> On Mon, Dec 5, 2022 at 2:43 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
> > My preference would be for the driver API to be extended with a new
> > callback for the output buffer, say get_output(), and have the existing
> > get() always return the input buffer.
> 
> This has a certain elegance to it, as it cuts to the bone of the
> problem and partition it in two halves, reflecting the two pieces
> of hardware: input and output buffer. Also follows Rusty Russells
> API hierarchy.

The (one of) problem is that not all hardware may support input and output
be enabled at the same time. What would that new API return in that case
and how it would be better with get() returning the value depending on
direction?

-- 
With Best Regards,
Andy Shevchenko


