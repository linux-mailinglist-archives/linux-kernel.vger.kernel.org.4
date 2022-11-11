Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169F8625B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiKKNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKKNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:50:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20CBB4;
        Fri, 11 Nov 2022 05:50:54 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="397892717"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="397892717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 05:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="882766556"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="882766556"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 11 Nov 2022 05:50:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1otUQk-00AjFQ-2J;
        Fri, 11 Nov 2022 15:50:50 +0200
Date:   Fri, 11 Nov 2022 15:50:50 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/6] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <Y25TOsMCQEezhnN0@smile.fi.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-5-andriy.shevchenko@linux.intel.com>
 <20221110072810.meu3cxh5repuglk3@pengutronix.de>
 <CAHp75VeV+ZBQ2M7xrP8o+KxSg9uXbcsDo5=9sU+=WF9muodDvA@mail.gmail.com>
 <20221110102317.ea64tgqd77kvygvt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110102317.ea64tgqd77kvygvt@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:23:17AM +0100, Uwe Kleine-König wrote:
> On Thu, Nov 10, 2022 at 11:58:53AM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 10, 2022 at 9:28 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Nov 08, 2022 at 04:22:24PM +0200, Andy Shevchenko wrote:
> > > > The PWM LPSS device can be embedded in another device.
> > > > In order to enable it, allow that drivers to probe
> > > > a corresponding device.

...

> > > Now that pwm_lpss_boardinfo lives in a different file, this makes the
> > > move of pwm_lpss_chip in patch 3 somewhat redundant.
> > 
> > But they are independent changes. At each stage (after each patch) we
> > should have a finished step, right? Not touching that makes me feel
> > that the step is half-baked. If you insist I can drop that move from
> > the other patch.
> 
> Given that the move is something you do just en passant in the earlier
> patch , I consider my suggestion cleaner. I'd call that 0.5 * insist.

I have looked again and I have noticed that in the current state we have

	sturct pwm_lpss_chip {
		...
	};

	struct pwm_lpss_boardinfo {
		...
	};

	extern struct pwm_lpss_boardinfo ...;


In the proposed change (with move included) it becomes

	#include <...>

	extern struct pwm_lpss_boardinfo ...;

	sturct pwm_lpss_chip {
		...
	};

and without

	#include <...>

	sturct pwm_lpss_chip {
		...
	};

	extern struct pwm_lpss_boardinfo ...;

And I consider that my way is slightly better in terms of ordering.
That said, I will leave it as is for v3. We may continue discussing
it further there.

-- 
With Best Regards,
Andy Shevchenko


