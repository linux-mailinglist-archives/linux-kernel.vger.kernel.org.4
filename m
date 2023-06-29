Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496E7428C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjF2Ooa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF2Oo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:44:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148F1FC1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688049865; x=1719585865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6/fsB8WyUAC8c3jQmgFNRD0AvMmRQIcX4wvRqe5bAo=;
  b=iUMbV8lITXkUuhZ8mFsS2He1qSf+oKJbLEc5FujdlBqCtLGI7+Vt4SYq
   M77pJFPqtLLJPwtkBCmuibvojd4OQym8P+fGW823ff3mfeOigysKD8G/U
   sEoId3LHl9RW2+Mwa2ELx4R2lGYcIwfXXYQT0klVT88gHWvJS/x5X9uuI
   1vGUdEkrtVL+MWCDFE4nsaONbfY/P3AG+CwsiITk/Wpk4PzA3ARdILPv3
   Zd1WcOkgBp50XMih6FubzlThRTtk2Q5dBDb5GoCvAVihqgKMIePeWhwtf
   0MDBIkETOyZr5lCgcsfskRp31IK+Yh2VIYartAxMVbdObsRYuAKXg5j6R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="392848654"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="392848654"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 07:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="667555125"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="667555125"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2023 07:44:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEssK-000sk9-2D;
        Thu, 29 Jun 2023 17:44:00 +0300
Date:   Thu, 29 Jun 2023 17:44:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/3] ASoC: rt5677: Use agnostic
 irq_domain_create_linear()
Message-ID: <ZJ2YsMJhFLLjd1Lr@smile.fi.intel.com>
References: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
 <20230629104603.88612-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629104603.88612-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:46:01PM +0300, Andy Shevchenko wrote:
> Instead of irq_domain_add_linear() that requires of_node,
> use irq_domain_create_linear() that works outside of OF world.

...

> -	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
> +	rt5677->domain = irq_domain_create_linear(dev_fwnode(i2c->dev),
>  			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);

Oops, this won't compile :-(
Seems I tried in another branch that has this module disabled.

>  	if (!rt5677->domain) {
>  		dev_err(&i2c->dev, "Failed to create IRQ domain\n");

-- 
With Best Regards,
Andy Shevchenko


