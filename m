Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD6720574
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjFBPIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjFBPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:08:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D2E5F;
        Fri,  2 Jun 2023 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685718518; x=1717254518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sOg+e66aWxQVMH2SnS4c8kmK+t/T96W9yihpb4WFeM4=;
  b=Wug9L8JeAOebSm8bE9NXNeQBVVwY1zwQlRyLwoWXeRCIPhfz8hpF4GPl
   jPeBCRpODWk+W59mfI9FYizx30i6DUSecqhbPZfpNTfwLhda4tRvFNnj/
   o9MAGfjk3J3cuEmhmPDq9PCd98dcPVxeV2FH8JBBlg/z5GRTRK2uCNsZ7
   x5rzNXkmvBhDmmi6CsrzD7LdL+YF3TmJAoQuLcGU2JtzRZuxC/cVGaD+r
   1I/qAeRjXaEV8pwMScOULduvcm41Ff4UuK7jQWvV4GAKalH9tNqH6Bq16
   7lFz9nJjVK9RNeNWZDLySO60OMe/2GT0fLykUH1Ji+/8qmjDPUxSIGY1J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="353384526"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="353384526"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="772910503"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="772910503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2023 08:06:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q56Mh-000fcK-2s;
        Fri, 02 Jun 2023 18:06:55 +0300
Date:   Fri, 2 Jun 2023 18:06:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused gpio_cansleep()
Message-ID: <ZHoFj1NSftx8iS3y@smile.fi.intel.com>
References: <20230602150106.47783-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602150106.47783-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 06:01:06PM +0300, Andy Shevchenko wrote:
> There is not a single user in the entire kernel of this deprecated API,
> kill it for good.

...

>  .../translations/zh_CN/driver-api/gpio/legacy.rst  | 14 +++-----------
>  Documentation/translations/zh_TW/gpio.txt          | 14 +++-----------

There are Chinese speaking people in Cc, if I'm not mistaken, can you, please,
check the respective translation fixes?

-- 
With Best Regards,
Andy Shevchenko


