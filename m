Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E776DDE71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDKOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDKOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:49:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB8C10FE;
        Tue, 11 Apr 2023 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681224549; x=1712760549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yxNieAGJxNArsMRMWGq66uwBJ1qECzGtgiS3YVB784=;
  b=Q+N8xiyMgxNO0zytvNL9F2utknrAPn2hZ2bySANNMUNSnRZYJSRaqqOs
   w7otMrZt095VnN26PloU28Jo+CgB0BbqxgUcPgvz5J1QQc7oT9yFtKHC3
   IJWjUP2TCxoEOcSSe7D4mfVmCT3/XS9hsJFnM6jABPfDPIpcfwx8bV+zk
   hn5VzEC4Ry+6c+K5MM6cueaR1ttAztDHU47lHGjR7mgl+HtlzdFpza5XV
   dSDFrvaWF3gahBVghivJrCuyIqZS37IUiS2gX8ddmx4IysVbmbCUnR4oR
   eGaCuq8Q754UGIoX+lcuR8mhx1mmsH152QjtrmAChnv9WRst0jAP5XZC2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327737860"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327737860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="799945367"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="799945367"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2023 07:49:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmFIv-00FKS4-2V;
        Tue, 11 Apr 2023 17:49:05 +0300
Date:   Tue, 11 Apr 2023 17:49:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <ZDVzYTWlaIN0PlCh@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
 <20230411143758.2rpaxux6esiln26q@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143758.2rpaxux6esiln26q@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:37:58PM +0300, Serge Semin wrote:
> On Tue, Apr 11, 2023 at 03:18:34PM +0300, Andy Shevchenko wrote:
> > On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:

...

> > > +	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > > +	      rx.directions & BIT(DMA_DEV_TO_MEM)))
> > > +		return -ENXIO;
> > 
> 
> > What about simplex transfers where we only care about sending or receiving data
> > and using dummy data for the other channel? Doesn't this make a regression for
> > that types of transfers? (Or, if we don't support such, this should be explained
> > in the commit message at least.)
> 
> I don't think the code above is that much relevant for the half-duplex
> transfers. The DW APB SSI-DMA driver requires both Tx and Rx channels
> being specified thus supporting the Full-duplex transfers at least in
> case of the TxRx and Rx-only SPI-transfers (the later case relies on
> having the dummy buffers supplied by the SPI-core). Thus the channels
> must support the corresponding DMA-directions.
> 
> Indeed the Tx-only DMA-based SPI-transfers implementation in the
> driver implies not using the Rx DMA-channel, but even in that case the
> Rx-channel still needs to be specified otherwise the DW APB SSI-DMA
> setup methods will halt with error returned. So unless there are cases
> with dummy Rx DMA-channels (which I very much doubt there is) I don't
> see the suggested update causing a regression. Am I missing something?

Okay, so since it's not a problem, can we explain this in the commit message
then? A summary of the above, perhaps?

...

> Do you still think otherwise?

Answered above.

-- 
With Best Regards,
Andy Shevchenko


