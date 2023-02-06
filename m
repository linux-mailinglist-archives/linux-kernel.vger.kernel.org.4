Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CBE68C0E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBFPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:06:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C31F93F;
        Mon,  6 Feb 2023 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675695979; x=1707231979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0uruuG+lFvdqkb5Rtu42uu4BPfZQuwsVlS8JgTbg9I=;
  b=gcXh7RVW/8VppduEZBa/D6A2GUHo/0XuN93cS/AEzy4xRBp0ZjxatbD/
   XH1Q9TCHsIeunKRNejOuQWSH9n7V+q+oaADkzNZCUmJA7D7aiuE0Q3WpL
   6zoM7Hwgtbo4858G09Gnnli36aexr8XoJOIJZllx5SP7fRM94a/C4963X
   5eRG0lxYMKJq9tmpyyhUyAZvIdVx4NTzOwRDHYyMP7etU+IwptCAETOWx
   QELwMN/R+eOPb3JCBLlOm5QywWeh+xXGoejmhUhUaJbfd1dV1wz+aA4Bv
   8BhuoFyn7JfhLGY1+r3yiXlIF49c/bomRWp97wyLHgpiWYqWn0Tvtb4+S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="393822692"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393822692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 07:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="668433852"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="668433852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 07:06:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pP34P-003DW4-1G;
        Mon, 06 Feb 2023 17:06:13 +0200
Date:   Mon, 6 Feb 2023 17:06:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Minter <jimminter@microsoft.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be
 in Direct IRQ mode
Message-ID: <Y+EXZWp1Q4iMD5xD@smile.fi.intel.com>
References: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZaUFiWK_EsQkiKpR7n=VdbW=HnqonZ_GRei6r9Kyg3_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZaUFiWK_EsQkiKpR7n=VdbW=HnqonZ_GRei6r9Kyg3_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 04:02:27PM +0100, Linus Walleij wrote:
> On Mon, Feb 6, 2023 at 3:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > If the firmware mangled the register contents too much,
> > check the saved value for the Direct IRQ mode. If it
> > matches, we will restore the pin state.
> >
> > Reported-by: Jim Minter <jimminter@microsoft.com>
> > Fixes: 6989ea4881c8 ("pinctrl: intel: Save and restore pins in "direct IRQ" mode")
> > Tested-by: Jim Minter <jimminter@microsoft.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > Jim, this is a bit simplified version than what you tested. But it shouldn't
> > be a functional changes. Anyway, it would be nice if you have a chance to give
> > this a try.
> >
> > Linus, I don't expect more to come for this cycle, feel free to apply directly.
> 
> OK no problem, does it go into fixes pronto or for next (v6.3)?
> I would guess fixes but I never know the difference between urgent
> and nourgent fixes...

Fixes and kinda urgent (bad user experience with touchpad device).

Thank you!

-- 
With Best Regards,
Andy Shevchenko


