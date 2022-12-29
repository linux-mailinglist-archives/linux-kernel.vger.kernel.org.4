Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC59658ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiL2JMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiL2JMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:12:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B75FE2;
        Thu, 29 Dec 2022 01:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672305163; x=1703841163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gvw9hPW1NVUGsvyuh1NJFIdYMmeucGuABn8XmyUvPWA=;
  b=eUP6iHn4HE3gJc0OmjT+HSF6ZiE9+j1IFjMCpY38G6xtjHfwjE3Rsh8G
   ky7diZCSloZWjQUd2UYutFiHaNXAYO7duLBTNv96di0R7azO4cQilzNZD
   ljv8LWcIuG5AZTQH/d5jIS+Lj+Jr+E6bwPeuGVLMuMt4YICLjHHSfsx+s
   AlcIpmZ7uUKxaRvGnq+b8UZyhc1eU17woEaIfdbpP/OyjYtYd1OE5H2eq
   Rj0CYfeJQsYqXQFbInaS0F4MoJVTcKXqCgT4Uv/PCsno6w1FFQEVSqBKH
   /8v/udmFi67gCkitZzlG47dNTyhIo9bKP8z7IIpCyTFCbbRTEmZ2csryR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="348221066"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="348221066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 01:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="742252638"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="742252638"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Dec 2022 01:12:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAoxr-0013qJ-3A;
        Thu, 29 Dec 2022 11:12:39 +0200
Date:   Thu, 29 Dec 2022 11:12:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pinctrl: nomadik: fix build when DEBUG_FS is not set
Message-ID: <Y61aBzEjABMCXzmN@smile.fi.intel.com>
References: <20221229012445.16169-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229012445.16169-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 05:24:45PM -0800, Randy Dunlap wrote:
> Fix build when DEBUG_FS is not set/enabled by moving the #include
> directive.
> 
> ../drivers/pinctrl/nomadik/pinctrl-nomadik.c: In function 'nmk_gpio_irq_print_chip':
> ../drivers/pinctrl/nomadik/pinctrl-nomadik.c:1084:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
>  1084 |         seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,
> 
> Fixes: e5530adc17a7 ("pinctrl: Clean up headers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>

I had sent
https://lore.kernel.org/linux-gpio/20221228084310.85210-1-andriy.shevchenko@linux.intel.com/T/#u
But now I see how I can amend it.

-- 
With Best Regards,
Andy Shevchenko


