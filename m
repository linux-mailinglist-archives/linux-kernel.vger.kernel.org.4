Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD266C2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjAPOyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:53:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EFD526D;
        Mon, 16 Jan 2023 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673880059; x=1705416059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omRXLkSPYL+E0aSp9XjS5PIFHSuzZ008Zyz8ceghZRk=;
  b=OuEZms/wdG6xQSOMP1aurv/Ewf7kojiUcZm2EneOKk0DbBAWSxu5HobD
   odOwTJvhrMtr1i3hbiEbTCAMSQHN/Uejoda5K1pX0nDkys6RdJctUpSUf
   xjbvaiRjSb6WV7ey3UIQASEM9qWsdnu0Kf7MoINDRjQ2xAr5det6dmcHn
   rPk9vqqB5Ue6v/pTE0gH34l8D6lH127vj5E6MIrYgmCj9D99ttPjBjhHp
   7YGM1yKVa2iNF6iimPOgN1oAtzoOuFKpl6yuwLAb2yOoqn727PrP3pM1T
   HcOAAEa3vMyrj9/KOyskkGNKDbXK8zGl/4/RxCjc8S85SkQGfQ72VjUSE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325739489"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="325739489"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="636553720"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="636553720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2023 06:40:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHQfM-00A7nm-0Q;
        Mon, 16 Jan 2023 16:40:52 +0200
Date:   Mon, 16 Jan 2023 16:40:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 1/2] pinctrl: digicolor: Remove duplicate assignment
 of of_gpio_n_cells
Message-ID: <Y8Vh807+yUgIX6X0@smile.fi.intel.com>
References: <20230113143640.24302-1-andriy.shevchenko@linux.intel.com>
 <CACRpkda66+a0A2Ho4ndTnzZKeQG_rR2wWNLE0xTD1QoGwd3bUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda66+a0A2Ho4ndTnzZKeQG_rR2wWNLE0xTD1QoGwd3bUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:14:38PM +0100, Linus Walleij wrote:
> On Fri, Jan 13, 2023 at 3:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> > not defined. No need to assign it explicitly in the driver.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> > v2: added tag (Baruch), avoid confusion with previously sent patch
> 
> Took out v1 and applied the v2 version instead!
> 
> (Hoping there is no v3 version I have missed too...)

Nope, thanks!

-- 
With Best Regards,
Andy Shevchenko


