Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC9620F98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiKHLzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiKHLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:55:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62512080;
        Tue,  8 Nov 2022 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667908511; x=1699444511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LCJ+LA4EoECYwdOJcOySMDwZZdQunAqwqpjhdUCb7Fw=;
  b=Nu3EwoRTDgQE8cK07vXXhhBXpLWblfeEfxffSi31ElJtFlEm2RIoOOJW
   pgnBzAj2n3Xbj6s7W4xe5Sx12XhYOUtkaQBkmnNUBxfMY6N85jjM8j4WO
   dWzOzx0+zss+LBU9DFS7zHkXGMWCO6TWHtM5zXjmvyKgeqe9oiAz6pkfL
   mIksvV4sRdeR9FV4AANigItniqrd/40x0luyk9KbSfp27CEHblEqPcTXC
   d9/LIPIlWWr9wXi10Kak9En2zNGBZTjCypw7YnfzLGCvuv9b+X6NKXfER
   IcCwNGUssNx33RM+P8rvbiS3fI4uLq98zSccEQ9LGV8hmGlYDro/fTxOj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311830255"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="311830255"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 03:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="761470048"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="761470048"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2022 03:55:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osNC6-0096tw-0T;
        Tue, 08 Nov 2022 13:55:06 +0200
Date:   Tue, 8 Nov 2022 13:55:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qe: request pins non-exclusively
Message-ID: <Y2pDmaHKU+1/ai9k@smile.fi.intel.com>
References: <Y2nKIbKxHAMimxII@google.com>
 <CACRpkdaW-dwKNtTQ2_Mj4JpG34N3m19g+s5xcs3Xj=2kAdE0cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaW-dwKNtTQ2_Mj4JpG34N3m19g+s5xcs3Xj=2kAdE0cw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:50:07AM +0100, Linus Walleij wrote:
> On Tue, Nov 8, 2022 at 4:16 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > Commit 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()") changed
> > qe_pin_request() to request and hold GPIO corresponding to a given pin.
> > Unfortunately this does not work, as fhci-hcd requests these GPIOs
> > first, befor calling qe_pin_request() (see
> > drivers/usb/host/fhci-hcd.c::of_fhci_probe()).
> > To fix it change qe_pin_request() to request GPIOs non-exclusively, and
> > free them once the code determines GPIO controller and offset for each
> > GPIO/pin.
> >
> > Also reaching deep into gpiolib implementation is not the best idea. We
> > should either export gpio_chip_hwgpio() or keep converting to the global
> > gpio numbers space until we fix the driver to implement proper pin
> > control.
> >
> > Fixes: 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Wow! Thanks for fixing this!
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I just sent that patch into the SoC patch tracker (soc@kernel.org)
> with a not to apply it directly, I suggest you do the same (or ask me
> to sign it off and send it).

It depends on the patch in my tree, which is in your tree as well.
I guess you need to take or wait for v6.2-rc1.

-- 
With Best Regards,
Andy Shevchenko


