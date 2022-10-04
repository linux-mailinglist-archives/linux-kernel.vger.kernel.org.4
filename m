Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6488D5F3E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJDIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJDIaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:30:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA7A1DA41
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664872223; x=1696408223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nfxLdpiC4/RfgY4eKM8WxFHoE/HVrk9JXVxhD/K2Os=;
  b=jpqIVBK1WIM5GtLKqv497uS8YeNnN7BbfnW0mCjJ9mYa87NRM18iQ435
   5q05bABXJNC+DK9ZSY3g8/560Ag/qnWCNsOR+ogbTFYGgNk04Cp0VeCih
   DIz3LtsELF5TUNXjGhyfXlR9RfeXTUIFDceP1th4It2uL1Z4P9T977pS2
   2r0HpSOPxL/X9z7SSNIeg7PgLxD6+YxIn6+bONVX/Yx0Xz384tl1/KYLM
   3WEp24TTYHFAH2TrpnCzVH9uJn0t0Mr+czdG0e/+v4ktG1OmroNFEkhLS
   uVWwgbjMvSafe0GQ1nf46JserRVGxOdbQm4ol9zSUwPpV60vqUrShL34P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300458792"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="300458792"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="728134367"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="728134367"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2022 01:30:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofdJi-001yIe-0g;
        Tue, 04 Oct 2022 11:30:18 +0300
Date:   Tue, 4 Oct 2022 11:30:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>, heiko@sntech.de, brgl@bgdev.pl,
        robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Subject: Re: [PATCH 11/20] gpio/rockchip: add of_node for gpiochip
Message-ID: <YzvvGValqxfIriGL@smile.fi.intel.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
 <20220920103108.23074-12-jay.xu@rock-chips.com>
 <CACRpkdZSCamhBD-M8CkZt6B3N9c2Jo_D3kwgOykj8+VJ_otYGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZSCamhBD-M8CkZt6B3N9c2Jo_D3kwgOykj8+VJ_otYGQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 09:14:38AM +0200, Linus Walleij wrote:
> On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:
> > The Rockchip GPIO driver will probe before pinctrl and has no parent dt
> > node, lack of the of_node will cause the driver probe failure.
> >
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> 
> > +#ifdef CONFIG_OF_GPIO
> > +       gc->of_node = of_node_get(bank->dev->of_node);
> > +#endif
> 
> Any introduction of of_node_get() needs to be balanced with a
> corresponding of_node_put().

No, this code should not have been existed in the first place. We don't allow
anymore any of of_node usage in the GPIO drivers. There is an fwnode and parent
and logic to retrieve fwnode from parent in the GPIO library for the most of
the cases.

-- 
With Best Regards,
Andy Shevchenko


