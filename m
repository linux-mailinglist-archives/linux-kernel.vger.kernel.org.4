Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792AA724421
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbjFFNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjFFNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:16:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC1D118;
        Tue,  6 Jun 2023 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686057365; x=1717593365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3p7uQcRR6XNTq+yMVmDqMHwxnP2B2IkM1YvBCLYXAQ=;
  b=BQGesQURCgKjdfTs/Qi7bOtGrJY6Bbx7uRBJgMTgg8VJYXPNbE24TUpo
   EyfkV8Qt+grzIdXdIvMVqzxdwGM0RRsmZKVZQSB528ruaE8FvCKEgk2zT
   xliL+JpMP8ItY4dp6orxQ67IEtWwInxr2NswKaqRQ5fBsKwissyDkox3Y
   1ElU1vBxzoaK6M21+DERGzuAIr8lbW4wm2xbA5WqoKB0es46aKKMMtlNW
   fJDRvlJZqRfvRYzK6xD/gQKbuPQwdDmQpR+eRbTdhi4FU3HYlA7xVbhQf
   vIzfr5SfSZeDpm9DuumZGlr6r8iDkw/8xM2sYU8NeYMbZzXXm5L3/Q+xm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="341309596"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="341309596"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="659524655"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="659524655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2023 06:06:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6WOe-001dFm-32;
        Tue, 06 Jun 2023 16:06:48 +0300
Date:   Tue, 6 Jun 2023 16:06:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: cherryview: Return correct value if pin
 in push-pull mode
Message-ID: <ZH8vaEknLtT6q8AF@smile.fi.intel.com>
References: <20230605143734.73434-1-andriy.shevchenko@linux.intel.com>
 <20230606051116.GU45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606051116.GU45886@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:11:16AM +0300, Mika Westerberg wrote:
> On Mon, Jun 05, 2023 at 05:37:34PM +0300, Andy Shevchenko wrote:
> > Currently the getter returns ENOTSUPP on pin configured in
> > the push-pull mode. Fix this by adding the missed switch case.
> > 
> > Fixes: ccdf81d08dbe ("pinctrl: cherryview: add option to set open-drain pin config")
> > Fixes: 6e08d6bbebeb ("pinctrl: Add Intel Cherryview/Braswell pin controller support")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


