Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB6735470
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjFSK4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjFSKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:55:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB27199F;
        Mon, 19 Jun 2023 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687172032; x=1718708032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3dNy/BukF6G6+IieCCsf48zXtI7d2qqsAxBdpNPkQeQ=;
  b=ZVB/54FQNdsqZowm+NspIGXhvlEtWu4YMXtOOaLVeWWHm/xqJyUravKl
   WZalBt0WTlzBIiZKKpRvqnVHvccmrIg5MTqmo8ACzHbnDYjjSzk0AFoh8
   2vl/X+dp97a2bg7FlvNL4du3acYj+GqruYid6h0AuC1yr9gFgcHLcn7uc
   oaG+HjTiBV1bnycamYR15L6KmH9n3GG1Qj+Bogq/aMwCpnDtwtiPsnHet
   9G9qBMMWGXuhakugXBsLlqzEYR1TuSEosD0npCDSPHA2Yjh8bEMj3ZDF2
   3qqiURixC4g9Td9ViMf7J+MtDgFFK9jtFZnAZZW2d0jSW/EA0Mc/G0BuX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339940602"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339940602"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="803578386"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="803578386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2023 03:53:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBCW3-004yEN-19;
        Mon, 19 Jun 2023 13:53:47 +0300
Date:   Mon, 19 Jun 2023 13:53:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH for-next v1 0/3] Minor improvements for Baytrail pinctrl
Message-ID: <ZJAzu9Mb7MKHvJw/@smile.fi.intel.com>
References: <20230616203356.27343-1-raag.jadav@intel.com>
 <20230619062247.GD45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619062247.GD45886@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:22:47AM +0300, Mika Westerberg wrote:
> On Sat, Jun 17, 2023 at 02:03:53AM +0530, Raag Jadav wrote:
> > This series implements minor improvements for Baytrail pinctrl driver.
> > 
> > Raag Jadav (3):
> >   pinctrl: baytrail: reduce scope of spinlock in ->dbg_show() hook
> >   pinctrl: baytrail: add warning for BYT_VAL_REG retrieval failure
> >   pinctrl: baytrail: invert if condition
> 
> For the series,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


