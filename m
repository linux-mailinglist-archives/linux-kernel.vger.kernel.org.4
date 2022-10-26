Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28C60E269
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiJZNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiJZNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:45:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5B24BC7;
        Wed, 26 Oct 2022 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666791895; x=1698327895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7J0SNO8xJ44grHoSSnIA2cU/huV/6fXHnOtqsUH84lQ=;
  b=fcqQVARAUMSdPWo25jq23Z2iJ9az8lEr7uYk5344yRqTsUcINjgs51/y
   /y2yCarNdECYUozWqCEX2MhXqoLgsAEZpoqBb6upKdr4H1M7xiYgJ4QIT
   K70hTfwY8QjJzNW5BNcNWCxFmsdPMnnhgyjZxrE0cEwmDLIZrjL5dA9lJ
   dMXUonviEZFecOyhcCAsM6hkZ2ltDnkiLAwPOSTZZmjq+kHQtGEYLJF8o
   1DWwTjkcyhYPiEidmlssSdubnRQVg3bLAvL8Ww5ppl/4PrHJ+898VI4xP
   SCFJxIfAnrVlRvYes8+VHSXJxRr/We1Nd6ViCWs5p5i42x4oS5q6CEyay
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="287662484"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="287662484"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 06:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="757302850"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="757302850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2022 06:44:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ongiC-002fmx-2C;
        Wed, 26 Oct 2022 16:44:52 +0300
Date:   Wed, 26 Oct 2022 16:44:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Use str_enable_disable() helper
Message-ID: <Y1k51GOu+9DT4Ng+@smile.fi.intel.com>
References: <20221017171506.64183-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdY6CnetKHQCpWPv_e559Mu_6im7GPMuOez=HwpSy9favw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY6CnetKHQCpWPv_e559Mu_6im7GPMuOez=HwpSy9favw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:30:09AM +0200, Linus Walleij wrote:
> On Mon, Oct 17, 2022 at 7:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Use str_enable_disable() helper instead of open coding the same.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


