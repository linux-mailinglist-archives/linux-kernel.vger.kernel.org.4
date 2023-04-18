Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265946E5A90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDRHf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDRHf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:35:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF543ABC;
        Tue, 18 Apr 2023 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681803355; x=1713339355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBXL32ZoktEVZQJ07ztS/Tq0AkNQ5nMBLWpXT4c4Syc=;
  b=SyEfqdhObFe/HxlA7Alt7wt5zEVRi0evEqUnsI6DEtWRPha2cmm2dfXN
   o2Tzy5uXmmdj51bUB+zESGiycRlYh9xKSytnAzwRWnFYNiRYS9s3IBw9n
   r+gFQ6mFHeuYyBSDAp93122WNWeV3nu8C7ZIXxkEVhhUOD1iE1dwz8MfD
   IJOSuZ1D0q0TXnjc5Yt5gbu5Og+WVjodww9ZWt5ws2xC6xuZ3m3jdKjFr
   yhIe1MaWbPuHJ4MvNG5e6kiVCma3CZp0z7YIkn5si6QoarlKDijI/WRVR
   1OfbfW0AEbx6a2Ej3/4nd/G7iszOUO29jS7v9aXD9wamK5fEOUeZZ1d/u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="407998088"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="407998088"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="815103411"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="815103411"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2023 00:35:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pofsU-001VZr-31;
        Tue, 18 Apr 2023 10:35:50 +0300
Date:   Tue, 18 Apr 2023 10:35:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v6 4/5] spi: dw: Add DMA address widths capability check
Message-ID: <ZD5IVvoMO/an5h0A@smile.fi.intel.com>
References: <20230414120520.360291-1-joychakr@google.com>
 <20230414120520.360291-5-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414120520.360291-5-joychakr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:05:19PM +0000, Joy Chakraborty wrote:
> Store address width capabilities of DMA controller during init and check
> the same per transfer to make sure the bits/word requirement can be met.
> 
> Current DW DMA driver requires both tx and rx channel to be configured
> and functional hence a subset of both tx and rx channel address width
> capability is checked with the width requirement(n_bytes) for a
> transfer.

...

> +	/*
> +	 * Assuming both channels belong to the same DMA controller hence the
> +	 * address width capabilities most likely would be the same.

I would add something to explain the side of these address width, like

	 * Assuming both channels belong to the same DMA controller hence
	 * the peripheral side address width capabilities most likely would
	 * be the same.

> +	 */

-- 
With Best Regards,
Andy Shevchenko


