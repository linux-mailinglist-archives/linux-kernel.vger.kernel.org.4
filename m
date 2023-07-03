Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB104745E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGCOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:14:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684FB3;
        Mon,  3 Jul 2023 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688393667; x=1719929667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wSk3MHcrgAFdRcKe1IPLlO6pBUGolyaLA6RQKQU5aME=;
  b=JWaIwPtFpLS4RewF/ShWX/+kZ7QL0JNC7lSkxvzVIqipyd8RfVpkkFhG
   6D1MeWSanFmc+rxAMGcPTcdR/y+LmBMQrBGBRtIQlMFG8kWbmyq9DVMlz
   laNkvrLiL+KvcoVVv3JgG76dVov4Vx0CLTXurgQR5kYnCgoxN2pp0R3H9
   AZJZeGpKyuNPsKoiLURhLSvGxHWt6NdMEjKMNnyfhe8+0Fl5xbhoHtMOc
   I+ERiE3Ih7wGhJJFX+N15nxCAShuziIZd38fHKEnseKLbeBCxJV/rFnHf
   4WtqlxbfDXFobEczpiYOBjh5Dd1SMfWshkqNvyRvK9y1i/XxdrVRPUgWO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="360372591"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="360372591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="1049107135"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="1049107135"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2023 07:14:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGKJq-001sqg-0w;
        Mon, 03 Jul 2023 17:14:22 +0300
Date:   Mon, 3 Jul 2023 17:14:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 0/3] gpiolib: Avpid modifying GPIO chip fwnode
Message-ID: <ZKLXvQJsRSvOuYtg@smile.fi.intel.com>
References: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
 <CAO-hwJJOW6QT-weKqTC5QJnP5e6EjJD3-d0-cxePpdHOj3Epkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJJOW6QT-weKqTC5QJnP5e6EjJD3-d0-cxePpdHOj3Epkg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:06:38PM +0200, Benjamin Tissoires wrote:
> On Mon, Jul 3, 2023 at 2:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Ideally the GPIO chip data structure has to be constant.
> > In real life it's not true, but we can make it closer to
> > that. Hence the series.
> >
> > Benjamin, would be nice it you can perform regression test for your
> > case.

> 
> FWIW:
> Tested-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> I've tested Danny's series + my SSDT override, with and without your
> series on top of the master of hid.git (v6.4+merge of the hid.git tree
> for v6.5-rc1), and in both cases, I can access the I2C-HID node that
> sits on top of the CP2112 USB adapter.

Thank you very much!

I will issue a v2 either today or this week. So Bart will have time to review
that and robots to test more before v6.5-rc1 is out.


> > Bart, the idea is that this series has to land immediately after
> > v6.5-rc1 is out so we will have longer time to fix any downsides
> > and regressions found, if any.

-- 
With Best Regards,
Andy Shevchenko


