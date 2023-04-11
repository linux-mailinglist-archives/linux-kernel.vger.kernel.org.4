Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB486DDF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDKPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDKPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:21:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0302618E;
        Tue, 11 Apr 2023 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681226433; x=1712762433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRHq5ZmffdYtJuEIeovcz27g4gO+MO+kJRQT8B7616Q=;
  b=SUtiMEStQQyJet+cA20yMibOfbV6iGlEZORGPn5DE5jr4Bj+S/hsRRqg
   pEkq1RdtdBVc1VIA5seQYdtOSfXpul12AYOGTgmGhYoc7Nr9DkAF5j7vx
   T+NNYhlemDUMfllE/9HFV0Aw/yAAGMUlx8ZqWDtRgPCiG9r3bGBa0O28P
   o43Hba2WbLolPUSofmMQKYAtVJhEMbxRA+hsV+hSEenUW+FYZlynmzY8j
   eWfjoXONOUnkjF3GqikqVBXi9YBJ+tbwaOQg0byuaVK32wXlukxPufjc5
   ZOTZ58Lv4pkZh01lQhVe7etv+JTzXBWlxk3v6Arzim6YmgnQ8ahi/WFvu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371495970"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="371495970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753179074"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753179074"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 08:17:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmFkb-00FLmV-0i;
        Tue, 11 Apr 2023 18:17:41 +0300
Date:   Tue, 11 Apr 2023 18:17:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <ZDV6FKd/TupHEPMf@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
 <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <ZDVyyoN71cB7dvWW@smile.fi.intel.com>
 <20230411150916.24vagjzbhshaujse@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411150916.24vagjzbhshaujse@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:09:16PM +0300, Serge Semin wrote:
> On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote:
> > > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:

...

> > > > > -	if (n_bytes == 1)
> > > > > +	switch (n_bytes) {
> > > > > +	case 1:
> > > > >  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > > -	else if (n_bytes == 2)
> > > > > +	case 2:
> > > > >  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > > -
> > > > > -	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > 
> > > > > +	case 3:
> > > > 
> > > > I'm not sure about this.
> > > 
> > > This actually makes sense seeing the function argument can have values
> > > 1, 2, _3_ and 4:
> > > dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> > > transfer->bits_per_word = __F__(master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32));
> > > ...
> > > dw_spi_dma_convert_width(dws->n_bytes)
> > > 
> > > The spi_transfer.bits_per_word field value depends on the
> > > SPI peripheral device communication protocol requirements which may
> > > imply the 3-bytes word xfers (even though it's indeed unluckily).
> > > 
> > > This semantic will also match to what we currently have in the
> > > IRQ-based SPI-transfer implementation (see dw_writer() and
> > > dw_reader()).
> 
> > Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for that. Why we don't
> > use it?
> 
> We could but there are two more-or-less firm reasons not to do
> that:
> 1. There aren't that much DMA-engines with the
> DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW APB SSI just
> ignores the upper bits if CTRLR0.DFS is less than the value actual
> written to the DR registers. Note DW DMAC engine isn't one of such
> controllers. So if we get to meet a peripheral SPI-device with 3-bytes
> word protocol transfers and the DMA-engine doesn't support it the
> DMA-based transfers may fail (depending on the DMA-engine driver
> implementation).
> 2. The DW APB SSIs (3.x and 4.x) can be synthesized with the APB Data
> Bus Width of 8, 16 and 32. So no matter whether DMA-engine supports
> the 3-bytes bus width the system bus most likely will either convert
> the transfers to the proper sized bus-transactions or fail.
> 
> So taking all of the above into account not using the
> DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than using it with
> a risk to fail some of the platform setups especially seeing the DW
> APB SSI ignores the upper bits anyway.

But this is not about SPI host hardware, it's about the consumers.
They should know about supported sizes. Either we add the corresponding support
to the driver or remove 3 case as I suggested. I don't think it's correct to
use 3 as 4.

> > > > > +	case 4:
> > > > > +		return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > > +	default:
> > > > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > +	}

-- 
With Best Regards,
Andy Shevchenko


