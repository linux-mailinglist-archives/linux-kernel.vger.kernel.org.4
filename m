Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAC657458
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiL1IxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiL1IxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:53:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BF418B;
        Wed, 28 Dec 2022 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672217584; x=1703753584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8fUF24/ihBlgYQOdGQDE6pDDEjiexMimLn7EKulDOvg=;
  b=Qj9KPZlg09O6+3mAyW+yo0skvxYIpV71rxgkh7mt+GdU9qwTWII7LCv1
   WBfsEen6U3Zdk7uVhewZ4Tt6kGjpcMXhxW+Ik6Zf0eF+8VWlLIx98buPu
   re1tygmoFLPZtvPrWOi8kUp2uCOhCN4nx6+bWEsgZ9tU8a1SSfCEmsmg8
   NsVlsJnrEup0eYoX0NB2oVgnW8fOnafnl6Fcey8eZ8YBfiukzcdbiUGZu
   oO/9Y/BFCKoWAbo8HjpKK9DXcLXcS7cMkBwRKslVeAQSWo7bDWw2U5/QG
   LMi3XvwutGPavH/5fIN5clBVs/kLYHNscIhATQIyycT6Wm55cwxPfaDjT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322815948"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322815948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 00:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="646672225"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="646672225"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2022 00:53:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pASBH-000V45-2R;
        Wed, 28 Dec 2022 10:52:59 +0200
Date:   Wed, 28 Dec 2022 10:52:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: nomadik: include linux/seq_file.h
Message-ID: <Y6wD67Rj4ZCcHQ2X@smile.fi.intel.com>
References: <20221215170103.2349282-1-arnd@kernel.org>
 <Y5tWhi9s5fGDMfxW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5tWhi9s5fGDMfxW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 07:16:54PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 15, 2022 at 06:00:57PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > In some randconfig builds, the missing #include causes a
> > build failure:
> > 
> > drivers/pinctrl/nomadik/pinctrl-nomadik.c: In function 'nmk_gpio_irq_print_chip':
> > drivers/pinctrl/nomadik/pinctrl-nomadik.c:1084:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
> >  1084 |         seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,
> >       |         ^~~~~~~~~~
> >       |         bstr_printf
> 
> Hmm... Strange that I have not noticed this from CIs.
> Nevertheless, I have a patch that adds more missing
> headers to this driver. I have planned to send it
> after v6.2-rc1.
> 
> I'm fine if this goes first. Up to Linus.

FYI: I have just sent my version
https://lore.kernel.org/r/20221228084310.85210-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko


