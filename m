Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402AD6DDAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDKMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDKMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:18:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4B3C11;
        Tue, 11 Apr 2023 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681215518; x=1712751518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F3tTaS8OOhNzVJofNqRodngfFzO2631v/GLY7lCoADo=;
  b=SDx6BOGvn2Wwkb+THf/pe7PbcBimJG7430mJ/W99F4xuAao1C7vz0RX6
   OtW0NvmXc6QR2BpHa/+6AoFFCUqwfOH9nZjtSS1ACPwlKneAPgENwXUxz
   Wo2PyNkycmnynigKIKdGjGxNclqVtlnWhnVUQ8BzjJBnrBuIVEvnBKbjw
   xli9QHGQydeNxgIaCTMPpxhYhDje6TpqruT2Hk26PYB/713ksjvjdLpVz
   th8j0b+ytbM7QQoWZxOyCfeBdxku8Ci/735TaPCAfPc/xwu97X3IvlZZr
   BrPgYJNUOCcpxSfUGj80xM6cGLy3vUmLCnAgJRDocE6HBWPzwzB7+sCRS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408738469"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="408738469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 05:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="665958842"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="665958842"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 05:18:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmCxG-00FFsi-1X;
        Tue, 11 Apr 2023 15:18:34 +0300
Date:   Tue, 11 Apr 2023 15:18:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330063450.2289058-3-joychakr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:
> Check capabilities of DMA controller during init to make sure it is
> capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> and store addr_width capabilities to check per transfer to make sure the
> bits/word requirement can be met for that transfer.

...

> +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);

Can we avoid forward declarations please?

...

> +	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> +	      rx.directions & BIT(DMA_DEV_TO_MEM)))
> +		return -ENXIO;

What about simplex transfers where we only care about sending or receiving data
and using dummy data for the other channel? Doesn't this make a regression for
that types of transfers? (Or, if we don't support such, this should be explained
in the commit message at least.)

...

> +	/*
> +	 * Assuming both channels belong to the same DMA controller hence the
> +	 * address width capabilities most likely would be the same.
> +	 */
> +	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;

I don't think so this is correct.

Theoretically it's possible to have simplex transfers on which the one of
the channel is simply ignored / not used. See above.

-- 
With Best Regards,
Andy Shevchenko


