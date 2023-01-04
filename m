Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF465D137
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjADLLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:11:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62671275D;
        Wed,  4 Jan 2023 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672830660; x=1704366660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EF5y8cJBIgIZwE1pcFSYf3Xzp/7I0nWn/GnCSDBV3U4=;
  b=e1d92xNfO6eMGFam68o1YrPq+P321iADTnQ9KGFJg5kxMgw6yKzSNhAx
   jei6vYPqd+jxkrVAYwk18BO2ATIpFb+KJRrXSh1VNQ+IRMD5gFXXfKQW1
   IHTSeAk9Eql63Ol7IT28IzQbRSZEIBLgstefUC7e8RNCLVodGpjlncI1b
   TreIJ+MkHtkrgJNiSl2ZsUYv1FtSYj7rVwqEqapi33sgGJxAciyjXoOBd
   0SOnCxEpG/mN9u1wPQeTE7/RwexNIo6bb4Y6V6SX9dyhdmJatvmm46EsX
   wEkmVxjeWq+1xDzMGlyhC6cszv2obFEqc/dW5oYCMiKphd4FkbDB69/6e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="319619321"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="319619321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 03:11:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="762640159"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="762640159"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 03:10:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pD1fc-004HFz-0O;
        Wed, 04 Jan 2023 13:10:56 +0200
Date:   Wed, 4 Jan 2023 13:10:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        William Dean <williamsukatube@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sp7021: fix unused function warning
Message-ID: <Y7Vev23G+E2+bgjp@smile.fi.intel.com>
References: <20221215163822.542622-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215163822.542622-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:38:10PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> sppctl_gpio_inv_get is only used from the debugfs code inside
> of an #ifdef, so we get a warning without that:
> 
> drivers/pinctrl/sunplus/sppctl.c:393:12: error: 'sppctl_gpio_inv_get' defined but not used [-Werror=unused-function]
>   393 | static int sppctl_gpio_inv_get(struct gpio_chip *chip, unsigned int offset)
>       |            ^~~~~~~~~~~~~~~~~~~
> 
> Replace the #ifdef with an IS_ENABLED() check that avoids the warning.

I;m wondering why we can't use PTR_IF() here and in similar cases...

-- 
With Best Regards,
Andy Shevchenko


