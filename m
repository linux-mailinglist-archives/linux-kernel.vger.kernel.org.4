Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8346E680E11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjA3Mwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjA3Mwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:52:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2A3A92;
        Mon, 30 Jan 2023 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675083172; x=1706619172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v97echkqpv0ROQM0BvxlBuRxi9UNuWJ0X+ifZwf9NbU=;
  b=a/vzhrT8kJm8fkddGSXCuQCTdX7JX5IzuoYRQRu7ctceaAcXsL/RbKd2
   h+oiSfPFwrE1Nrno6UNt18++52Rs7TiiTyvToMPfeIJSfX4tlbX8M8uJ4
   n6fgcGPth5Tq8fnJtMrKRxpkSj6rFKQmhQGV9svzmuJ3sgD406l2ceH+6
   lENFOmA/YG6/nklFwRuvUDHGI0msMo4NZKGMTqeyjL0lxZCYPR3gkDqoy
   ZAMudzqW7aShPRXwp0fCS8B4cPmHkorh7K2HxVY2m0iwe/3Dr+5hGo9ku
   OJSinDtrvzl4ASl67he82cHSF1rXyRGxr6Xpa3sUmraP++oaasqIQgp4u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="315507345"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="315507345"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="657441411"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="657441411"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 04:52:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTeR-00HM0a-2p;
        Mon, 30 Jan 2023 14:52:47 +0200
Date:   Mon, 30 Jan 2023 14:52:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Do not dereference NULL structure
Message-ID: <Y9e9nwfsxlw/t3sQ@smile.fi.intel.com>
References: <20230127223623.never.507-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223623.never.507-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:36:27PM -0800, Kees Cook wrote:
> If "vdesc" is NULL, it cannot be used with vd_to_axi_desc(). Leave
> "bytes" unchanged at 0. Seen under GCC 13 with -Warray-bounds:
> 
> ../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'dma_chan_tx_status':
> ../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:329:46: warning: array subscript 0 is outside array bounds of 'struct
> virt_dma_desc[46116860184273879]' [-Warray-bounds=]
>   329 |                 bytes = vd_to_axi_desc(vdesc)->length;
>       |                                              ^~

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 8e55444da65c ("dmaengine: dw-axi-dmac: Support burst residue granularity")
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 08af483331fd..4169e1d7d5ca 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -325,8 +325,6 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  		len = vd_to_axi_desc(vdesc)->hw_desc[0].len;
>  		completed_length = completed_blocks * len;
>  		bytes = length - completed_length;
> -	} else {
> -		bytes = vd_to_axi_desc(vdesc)->length;
>  	}
>  
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


