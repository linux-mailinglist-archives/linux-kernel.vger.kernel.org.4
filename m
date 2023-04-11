Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CED6DDE64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDKOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDKOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:46:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89750172A;
        Tue, 11 Apr 2023 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681224416; x=1712760416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9YtPmGxmv4CA69+troKASVTIGrjtBdtTHpFIWMGP7kE=;
  b=X/a4SkGgOpz2KdNhcVuP26OLHFZeXrzbhdQCmf/N3/VH6y6TcxLvI6Xo
   G7NhZekGJEg46Q9bhfSpvto8pfdvi4yWaOpQ06yOz+yvSc5YCTPEDSKZG
   GgI6U90U/Hz9ns3YM1gYTCUebC0FbbTFwcTXhqEI4dWmzhude1XorHlbT
   Lcs4X1xECzsTM7YRlRdas7xuzL2nRjc0q/dAjZnZevTcFzcqnkgHp0RuT
   A56oLSGFncKOb+dmNtgOpEZwlXfJTG3t5eKV0FU+6a3nN7sHZCbcZ7/1Z
   ezk5mihRcKqqP50cG7KeT+cmvoCoDaoyR7Bh7iL2mhCI76zZNebR9imau
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327736711"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327736711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="799945211"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="799945211"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2023 07:46:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmFGU-00FKMS-2q;
        Tue, 11 Apr 2023 17:46:34 +0300
Date:   Tue, 11 Apr 2023 17:46:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <ZDVyyoN71cB7dvWW@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
 <20230411141115.vrfd6sud66u6xeog@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411141115.vrfd6sud66u6xeog@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote:
> On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:

...

> > > -	if (n_bytes == 1)
> > > +	switch (n_bytes) {
> > > +	case 1:
> > >  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > -	else if (n_bytes == 2)
> > > +	case 2:
> > >  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > -
> > > -	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > 
> > > +	case 3:
> > 
> > I'm not sure about this.
> 
> This actually makes sense seeing the function argument can have values
> 1, 2, _3_ and 4:
> dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> transfer->bits_per_word = __F__(master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32));
> ...
> dw_spi_dma_convert_width(dws->n_bytes)
> 
> The spi_transfer.bits_per_word field value depends on the
> SPI peripheral device communication protocol requirements which may
> imply the 3-bytes word xfers (even though it's indeed unluckily).
> 
> This semantic will also match to what we currently have in the
> IRQ-based SPI-transfer implementation (see dw_writer() and
> dw_reader()).

Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for that. Why we don't
use it?

> > > +	case 4:
> > > +		return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > +	default:
> > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


