Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C783F67B930
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjAYSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjAYSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:22:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9148587;
        Wed, 25 Jan 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674670931; x=1706206931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A76BzDJayrPXI3YjD5EhPGdQ7ascQPANML7Hn/B6Fpg=;
  b=BHQQc3aiVEG36bP7gOhoMmthLNvxUuSCT9IvKOF1IriZDTC0pKu+Ia8a
   oyIpSDmG+xVQ4jFVW+rnWg8EyL+CyvEXlGRXCa90HszJtAyoiLZqBKCcB
   A9hJCc5mwOJ12GTtmmQwrHMvdIgZt6bysSIN+K5p/e965Ihr+feOhvUID
   X66QkIuDxXQFp6N+weu8+Z2krfNuE+fpSDiMjrX+2OWNb79xzTSVSo2Zw
   lQ+ZEB/NCdJxSX3mlfLEoJaHInSFJO5NY3sxIqYgGOHYeR1WS1tea8Jir
   gP3/b9M0QBSohvD025tn09HcADDjrQg/7dOIizqjTq65vJTC9hDZpwrxH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306295375"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306295375"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="612520344"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="612520344"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 10:22:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pKkPM-00F1f9-1d;
        Wed, 25 Jan 2023 20:22:04 +0200
Date:   Wed, 25 Jan 2023 20:22:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Pierluigi Passaro <pierluigi.p@variscite.com>,
        linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.passaro@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] gpiolib: fix linker errors when GPIOLIB is disabled
Message-ID: <Y9FzTGxX5Z+XsTHV@smile.fi.intel.com>
References: <20230124013138.358595-1-pierluigi.p@variscite.com>
 <CAMRc=Mcf+PA-uhT+3Sq5AxHUMb-K_ogw=kBtGV6-wK00PtXGkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcf+PA-uhT+3Sq5AxHUMb-K_ogw=kBtGV6-wK00PtXGkw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:54:54AM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 24, 2023 at 2:31 AM Pierluigi Passaro
> <pierluigi.p@variscite.com> wrote:

...

> >  #else /* CONFIG_GPIOLIB */
> >
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> 
> Please move those headers to the top and arrange them alphabetically
> with the rest of the <linux/ headers. Since you're now including
> those, remove any forward declarations of the types in question.

That's not correct way. The headers will make the whole purpose of splitting
(between driver, machine, and consumer) useless.

Lemme look at it, but I believe the solution is not so simple.
We need to clean up header inclusions as we did for pin control.

-- 
With Best Regards,
Andy Shevchenko


