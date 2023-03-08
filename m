Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CC6B07EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjCHNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCHNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:06:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E2BD008A;
        Wed,  8 Mar 2023 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678280657; x=1709816657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mffJjopUQuayYQh7kyjcApg/4oAZhLIAeU682Yd2vJw=;
  b=n0w0GLhw3lwKmB5DakIAk58vxuJK7hW1zytfqVTo3PsMejRlNgF0QUAA
   Udwnhp5fVdUHlwGFbr4liCFH8ctREDcmk8ur6EkvEe4HpygD6Jn6HWGbU
   4GPeKDi6R+cmEzF1r4eHT8wJ3waJStyZC34fqjxNBji5hygOIaVbGs/MO
   1cOBrAS9whsEHlFH2tMJvTMhN/TylPl5U/ZeHGlbb1J+ddDYFl5Tqyg88
   5Kr0V9/hcBMAhnATjnSGQ+NmFNBrFMYz7RHA7En6qP6N/mmYBTDM6eJhU
   UX8SfR7NXi6oEUA/Qy2dehVWRsjmhJZali8ifep2yisd1myk9JW8Sx9+b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333615241"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333615241"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800736604"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="800736604"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2023 05:01:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZtPw-00HQuT-08;
        Wed, 08 Mar 2023 15:01:16 +0200
Date:   Wed, 8 Mar 2023 15:01:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/3] gpiolib: cleanups WRT GPIO device handling
Message-ID: <ZAiHGwhulKl8ohYd@smile.fi.intel.com>
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MetDO+mr6F8oKSkW3G8vv3nV+K-8QHM+Eov0s_3eCG2HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MetDO+mr6F8oKSkW3G8vv3nV+K-8QHM+Eov0s_3eCG2HA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:50:49AM +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 7, 2023 at 7:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > A few cleanups to GPIO device handling in the library code.
> >
> > Andy Shevchenko (3):
> >   gpiolib: Access device's fwnode via dev_fwnode()
> >   gpiolib: Get rid of gpio_bus_match() forward declaration
> >   gpiolib: Move gpiodevice_*() to gpiodev namespace

> I applied the first two patches, for the third I have a comment.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


