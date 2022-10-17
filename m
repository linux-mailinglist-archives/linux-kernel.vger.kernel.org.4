Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68E0601582
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJQRgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJQRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:36:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8706D54C;
        Mon, 17 Oct 2022 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666028162; x=1697564162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/uKydgYhq3g5ftCl7FE1BcNYAbz9De0+pyZNa+RAaXk=;
  b=FPnmt2qvwZwiX+VmdCDd52Fwn93hnZ+9HtZp1i44Kl8LxsxpWdkRWrI9
   +p1mmKoAqqJgDFlOaXtS9xfaoct5djSEHjMJVSYw4vcdpiiJnBwb3IGVS
   hLhJdRzgX9EHI+RSIvhN0oFgmnBJ7p/7iQfEaSVkGnrn//Sc1yt9XPRFz
   lTbGMoflrdB88DXMDILjBgDhLS6smf/izsxwEAzaIVILC48RKEWhMzGId
   AvxbHVQVm+NKo8+oEBg972fnV1r0XGVaPW0VjG+mpUH14UGnhGQGc93R1
   06E28SSXn/FE/UI6FHktiNJlHrNV5VENZTKS7CxVScuWCV+thl/8ZohZJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307527670"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="307527670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="717577923"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="717577923"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 10:35:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okU1u-008wcS-0J;
        Mon, 17 Oct 2022 20:35:58 +0300
Date:   Mon, 17 Oct 2022 20:35:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 6/6] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
Message-ID: <Y02SfXLJNNFAdPSR@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-6-andriy.shevchenko@linux.intel.com>
 <Y02OuQVTxqm5mRtK@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02OuQVTxqm5mRtK@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:19:53PM +0100, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 08:12:43PM +0300, Andy Shevchenko wrote:
> 
> > Cleaning up the driver to use pm_ptr() macro instead of ifdeffery
> > that makes it simpler and allows the compiler to remove those functions
> > if built without CONFIG_PM and CONFIG_PM_SLEEP support.
> 
> Are you sure this works cleanly and doesn't suffer from similar problems
> to of_match_ptr() when PM is disabled, leaving some unreferenced statics?

Yes, this is the trick with PTR_IF() behind it, which is not used by OF code.

-- 
With Best Regards,
Andy Shevchenko


