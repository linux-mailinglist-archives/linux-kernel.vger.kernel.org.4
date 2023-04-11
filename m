Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496006DDA80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDKMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDKMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:13:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428363581;
        Tue, 11 Apr 2023 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681215234; x=1712751234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/E7uLg3CXBVdDMjNrQzi7EHdi99oJj+BrcE9HoD6thY=;
  b=JFtsmzM+MsKtQgtrPoZ8uQ++1ScWZqbL7Os3HagJcxnlyYjNtGWPa9Zv
   4ox7drRhVpdQv53GzmLbL6T6r9e5tF8KF82vRnd22aKGSN5zaNg6UKpuW
   eobgUOOQvHfol6ehD8y34zjs518H6Qax4grLdBqHfD+fUF1csODMNRPWF
   F1v+0gmI37DXwuQYclTogcm0uF3GCW3U26bAYp2xDBiHxqjGYqShnpzW9
   BsBeYY24qbIqkjpCldRkW5RrRw16CU9Mz3lZyfb/7qErWIyHU+Sip3x/L
   P6G9K2ofKYSqrDE1sALF4dcJS2yGQmqm8ddw7CqD93T/k9EbwhbGiTt/h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="406426457"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="406426457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 05:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="812547591"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812547591"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2023 05:13:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmCsf-00FFnN-1V;
        Tue, 11 Apr 2023 15:13:49 +0300
Date:   Tue, 11 Apr 2023 15:13:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-2-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330063450.2289058-2-joychakr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:

First of all the Subject is wrong. You are not touching DMA controller.
Needs to be rephrased.

> Add Support for AxSize = 4 bytes configuration from dw dma driver if

SPI DMA driver

(or something like this, note capital letters for acronyms).

> n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> 
> Number of bytes written to fifo per write is depended on the bits/word
> configuration being used which the DW core driver translates to n_bytes.

...

>  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
>  {
> -	if (n_bytes == 1)
> +	switch (n_bytes) {
> +	case 1:
>  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> -	else if (n_bytes == 2)
> +	case 2:
>  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
> -
> -	return DMA_SLAVE_BUSWIDTH_UNDEFINED;

> +	case 3:

I'm not sure about this.

> +	case 4:
> +		return DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	default:
> +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +	}
>  }

-- 
With Best Regards,
Andy Shevchenko


