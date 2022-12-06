Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627D64479F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiLFPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiLFPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:08:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBDA2DAA2;
        Tue,  6 Dec 2022 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670339099; x=1701875099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gaANcgDLtpQVPsnEy3VGI5ie3X6MSAD+xjymeHx3S0=;
  b=bIzsBl3SrP/ieuvPOyBdWZ2Nh2vd5Ro8XIrYSjkpA9J4kq/2IGTYgKuK
   U+jxr70fka/XcUWehJwNUfhLZ4YjlQ1Kjhi96290I78PgVUu/G14+4/ta
   3jMIsTjRvnHLylPHCf3NFVyuZ11T7DQDMWuKaXpenb1JQjg+s7ChRUKbv
   Xuj1+Dktsls5wXbXi2PywmAMlb5zTYEl+tmjDemXniGMyoJxs395xGwGX
   a7d2YoZbqVfuaVeGBgQOJDH/kVvdhkgrs27UiZrVn6+cGs1UdaFbG0RYG
   /xT+kHHu8exiTC4bgPlCrWBMXXdnX+YyqVSiiZ8aO42anUJAGfeQzxk33
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="402918530"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="402918530"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 07:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="677002574"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="677002574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2022 07:04:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2ZUy-005M2F-0T;
        Tue, 06 Dec 2022 17:04:44 +0200
Date:   Tue, 6 Dec 2022 17:04:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pinctrl tree with the arm-soc
 tree
Message-ID: <Y49aC6dMyoAMcTkd@smile.fi.intel.com>
References: <20221206121336.474457bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206121336.474457bb@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:13:36PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pinctrl tree got a conflict in:
> 
>   drivers/soc/fsl/qe/gpio.c
> 
> between commits:
> 
>   84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
>   66310b5a0fc1 ("soc: fsl: qe: request pins non-exclusively")
> 
> from the arm-soc tree and commit:
> 
>   c9eb6e546a23 ("soc: fsl: qe: Switch to use fwnode instead of of_node")
> 
> from the pinctrl tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

That's correct fix in my opinion. Thank you!

How to avoid conflict and why it's there I have explained here:
https://lore.kernel.org/linux-arm-kernel/Y43ij5rwNLOaztch@smile.fi.intel.com/

-- 
With Best Regards,
Andy Shevchenko


