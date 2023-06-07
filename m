Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D1726A74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFGUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjFGUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:10:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D531210B;
        Wed,  7 Jun 2023 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686168639; x=1717704639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VfslLwORsK733vSveOGYznR4Jbt1k5WrIGitcTmqWsI=;
  b=SJt/CGSkG6k41B6a9p3dhX7obJve8RCp1B7V/lGyDIyHu8hCrZE+l8M3
   r1FozH/cvsNHi8G7jLslrf416wksXtaROUrU100Kr+MTjfYYPCuKdsEag
   h2uO1uQjvHhjNHBqyiX4HdzphLFIlsTzMGqgXb9xdN/G7IuXGRc0frZ8L
   /o8k7IihOCEmXIC7VK561oM+lT+MGjWYU7lh4TAAdAv/1Xe17wwq8mxHY
   gO8vMe86NwoMRtZsrzBnnRrU3qBd1Rt2fS/dJcmEYJbPkihOHns7vnRel
   GYJFerZ+aDW90cK5MGFenFO6yS5MJ8WwWCk53XnKEYKCEu9SbDPvJZCXf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360427250"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="360427250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 13:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="883929122"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="883929122"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 13:10:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6zUK-001zfm-0q;
        Wed, 07 Jun 2023 23:10:36 +0300
Date:   Wed, 7 Jun 2023 23:10:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Lake-S pin
 controller support
Message-ID: <ZIDkPPRpONQw/csZ@smile.fi.intel.com>
References: <20230605164943.3641-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbnHgqiXHFS+UnCrs5dPCwTd+g3NLyF-NcOq9ugdzZM=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbnHgqiXHFS+UnCrs5dPCwTd+g3NLyF-NcOq9ugdzZM=A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:42:19AM +0200, Linus Walleij wrote:
> On Mon, Jun 5, 2023 at 6:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > This driver adds pinctrl/GPIO support for Intel Meteor Lake-S.
> > The GPIO controller is based on the next generation GPIO hardware
> > but still compatible with the one supported by the Intel pinctrl
> > and GPIO core driver.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Pushed to my review and testing queue, thanks!

> I expect this to arrive by pull request with other Intel stuff
> as usual.

Yes, this week or beginning of the next one.

-- 
With Best Regards,
Andy Shevchenko


