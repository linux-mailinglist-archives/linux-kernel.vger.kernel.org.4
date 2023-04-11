Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB846DDA78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDKMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDKMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:11:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939282D61;
        Tue, 11 Apr 2023 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681215094; x=1712751094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5BT3BOmfFOrJL/K8+Lh7oMPYlXgAXEEjdOA14LXUTlA=;
  b=TrH6YmFAlpZYyfaZ6v/251WsAgtrkRLeX4mBIFiIGPOlRIH4OdnIkiVv
   txVdRBriKiWrMN88RqsouQLoEViYnCyau+XXod3TjXPeKyd6U2kqEF6Iz
   vR3cMS+KtVsOTdFuuBYbyfLxGoM6w4qTett8W26qJWmPn3UzadFuVQ+8Y
   iPVIIoUrYxRWW2ECGzMiP2GGsa6wxVGQSkLdhAqKihYDitcORXEdoehxV
   GH3W89Cpv/rC4anU42m2ivwDtvglZhK2dxpNLJFGYGGoshPaDdFcE/m1y
   7seKwz3dLjKNZl7/JeRDuvrAZWVVH5Qp9wKRKJQ5R8ixGgnZXrKp+UDMK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="406426061"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="406426061"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 05:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="812546833"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812546833"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2023 05:11:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmCqQ-00FFl0-1P;
        Tue, 11 Apr 2023 15:11:30 +0300
Date:   Tue, 11 Apr 2023 15:11:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 0/2] spi: dw: DW SPI DMA Driver updates
Message-ID: <ZDVOcvdrsvI8cCsH@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230411051233.aps5g2eq4qt4iumt@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411051233.aps5g2eq4qt4iumt@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:12:33AM +0300, Serge Semin wrote:
> Cc+=Andy

Thank for Cc'ing me. I'll go through individual patches and give my comments
if any.

> On Thu, Mar 30, 2023 at 06:34:48AM +0000, Joy Chakraborty wrote:
> > This Patch series adds support for 32 bits per word trasfers using DMA
> > and some defensive checks around dma controller capabilities.
> > ---
> > V1 Changes : Add support for AxSize=4 bytes to support 32bits/word.
> > ---
> > V1->V2 Changes : Add dma capability check to make sure address widths
> > are supported.
> > ---
> > V2->V3 Changes : Split changes , add DMA direction check and other
> > cosmetic chnages.
> > ---
> > V3->V4 Changes : Fix Sparce Warning
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/
> > ---
> > V4->V5 Changes : Preserve reverse xmas Tree order, move direction
> > check before initalisation of further capabilities, remove zero
> > initialisations, remove error OR'ing.
> 
> The series looks good to me now. Though if I were you I would have
> split up the last patch into two ones.
> 
> Anyway I tested the patchset on Baikal-T1 SoC with DW APB SSI 3.22b +
> DW DMAC 2.18b and looped back SPI-interface. So feel free to add:
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> @Andy, anything to add from your side?
> @Mark, if you are ok with the series content please merge in.

-- 
With Best Regards,
Andy Shevchenko


