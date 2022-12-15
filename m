Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17364DF83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiLORRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiLORQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:16:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8BC3F06E;
        Thu, 15 Dec 2022 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124619; x=1702660619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6+XIX9pR62q2iNq/HedN7zwBf3caBBDvsIWPeGYZ9A=;
  b=IlJn04N70VgsDnAqsEo218gMrzBSRG66MrSXgcB1GiX6iR7zQiAynx2b
   p7DYlXnwbctherM//am9s25ak8pJZITPeyHrhTtJu9qc1+q50UcuGcutj
   SWOkPzUnsClaWP+GibC25LPmUHTFSYWCpTZcCz0MZNHkmCsPhp5xghPVO
   g6w4MMd83/7uGRgYP+QSyNEBdsDZdSXGsvC+uTdSLy31nFJJHHz7fsq2A
   sbUOZ6J80xQ0FuHbZX6Qn2PPvGPK5XQaLB8kXCtOzy/f3yJXkje96WU4h
   FdL4gX7PkTNrUscBjXhskmL37BeXCiLU2g/C4X60wJfyvMs4v+qLzFvhp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="298412532"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="298412532"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="599648546"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="599648546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2022 09:16:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p5rqo-00ARel-1T;
        Thu, 15 Dec 2022 19:16:54 +0200
Date:   Thu, 15 Dec 2022 19:16:54 +0200
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
Message-ID: <Y5tWhi9s5fGDMfxW@smile.fi.intel.com>
References: <20221215170103.2349282-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170103.2349282-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 06:00:57PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some randconfig builds, the missing #include causes a
> build failure:
> 
> drivers/pinctrl/nomadik/pinctrl-nomadik.c: In function 'nmk_gpio_irq_print_chip':
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1084:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
>  1084 |         seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,
>       |         ^~~~~~~~~~
>       |         bstr_printf

Hmm... Strange that I have not noticed this from CIs.
Nevertheless, I have a patch that adds more missing
headers to this driver. I have planned to send it
after v6.2-rc1.

I'm fine if this goes first. Up to Linus.

-- 
With Best Regards,
Andy Shevchenko


