Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE36631B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiKUI1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiKUI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:27:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739DDF22;
        Mon, 21 Nov 2022 00:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669019265; x=1700555265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UcAlxZZtX/L5C7vzngfeWVdeLqnyk1XDhH9IwX9rwJc=;
  b=DU9agdos79kQmes2Ih4GQDCAPjQkVdyIFHrkfDJnEfXhh040x+p04zuN
   7dUNplvHlIkuhCuTzJ8dZ8FKHzOdpbefESAjkfV4HGqzcQjROfi1jPj0l
   GQ8lMagG30NY3yHng+efDUEI7tOgVzfyrEY2qWEhMTHKDH8OExdb6tHvE
   Qf5Ay32pMWGGCD8EYRc7oxBe+lnTdF+75pC08Kpzv9hGkFj6SCWQxylei
   g5E6RcWBJyDjBzQpAIrtDEsP3XLKKXlkI1MKQCvpTnmHdsj3WxnjuoXZZ
   yk0V1ihg6f2UsB/AHVOw4e9CBr1fkM8voN8RQWjyh03bEx3vo/aVgaMmE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="375647539"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="375647539"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:27:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="640939047"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="640939047"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2022 00:27:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ox29V-00FBEd-0G;
        Mon, 21 Nov 2022 10:27:41 +0200
Date:   Mon, 21 Nov 2022 10:27:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Message-ID: <Y3s2fHkr29eMQvtt@smile.fi.intel.com>
References: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
 <20221120191622.kngdz462bmns7fwe@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120191622.kngdz462bmns7fwe@SoMainline.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 08:16:22PM +0100, Marijn Suijten wrote:
> On 2022-11-16 16:17:28, Andy Shevchenko wrote:
> > Some of the functions are using struct fwnode_handle, some struct device
> > pointer. In the GPIO library the firmware node of the GPIO device is the
> > same as GPIO node of the GPIO chip. Due to this fact we may use former
> > to access properties everywhere in the code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I presume this is a more complete version of [1], as this also happens
> to address the crash on MSM [1], hence:
> 
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org>

Thank you!

> Just in case, this seems to depend on [3] or it fails to apply cleanly
> because of the `const` change on `fwnode` (consider this irrelevant if
> it has already been applied, I'm still on -next-20221115 for this
> integration branch).

But initial issue was induced by (my) patch which is only in gpio/for-next.
It's supposed to be only Linux Next issue.

> [1]: https://lore.kernel.org/all/Y3S62i7OzocP5QrT@orome/
> [2]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3jb@SoMainline.org/
> [3]: https://lore.kernel.org/linux-gpio/20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


