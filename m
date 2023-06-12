Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068D972CCF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjFLRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjFLRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:36:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A163AA5;
        Mon, 12 Jun 2023 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686591307; x=1718127307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5WMQQbOARw55yzbpOK/Pk6hobT1SHUO/FQ3x65ntFcQ=;
  b=j2RxsKNG1eZMS+lULufT1KUkd+JB+Uy804emRn+Mai3nJF4P+C/GQVzm
   x42GpnMir6nrEGEVfV4dpqYLyi4FQHC4NcV+4bp5MAsuvm8sESupq0GAD
   vH971/LPpRHL2CACtX4N0fMO9rxa6hJAfM8a0CCBe/BvMMWY+QWwhfFCG
   h/0nhjsBWoGhyWCJUC6TkO4r4NobyRZ9C9ZLEzg185I4sHnzlVCAgxwml
   oXXY845CNhlFfYl9N1J6noXWVpJGLhzm/23Q0Mgv+CpUC3ayxEM+Nel4A
   xKzxWumlnOggIkfWxJJfJmpdUak3EyYlu4+5PkdwYMq9sJQek/xWMGe4+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337749672"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="337749672"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 10:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776474295"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="776474295"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2023 10:32:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8lPB-003GXT-0L;
        Mon, 12 Jun 2023 20:32:37 +0300
Date:   Mon, 12 Jun 2023 20:32:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <linux@ew.tq-group.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay
 support for individual output pins
Message-ID: <ZIdWtBXLl2iJtWVF@smile.fi.intel.com>
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXhcR0MTVVpm-2PiSZkCc+BnU6oEp_aVRj+rqvBbWLHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXhcR0MTVVpm-2PiSZkCc+BnU6oEp_aVRj+rqvBbWLHMA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:11:04AM +0200, Geert Uytterhoeven wrote:
> On Thu, Jun 8, 2023 at 6:23 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > The aggregator mode can also handle properties of the platform, that
> > do not belong to the GPIO controller itself. One of such a property
> > is signal delay line. Intdoduce support of it.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > I don't like the idea of gpio-delay or similar. We have already GPIO
> > aggregator that incorporates the GPIO proxy / forwarder functionality.
> 
> I think this makes sense.

Thank you for the support of the idea.

...

> I hope no one ever needs to use the values from the example in the
> bindings
> 
>     enable-gpios = <&enable_delay 0 130000 30000>;
> 
> on a non-sleepable GPIO. Not only is a looping delay of 130 ms very bad
> for system responsiveness, such large delays may not even be supported
> on all systems (e.g. ARM implementation says < 2 ms).
> So for large values, this should use mdelay().
> 
> This also applies to gpio-delay, of course.

Thank you for pointing this out. I will think about better approach.
Shan't we add a comment into DT bindings to warn users about this?

-- 
With Best Regards,
Andy Shevchenko


