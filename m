Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7166A2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjAMTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAMTRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:17:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC26276;
        Fri, 13 Jan 2023 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673637457; x=1705173457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1SvtVZGvdj95Oi+1TLhuCqJ/YRqPXF2Bnfx5f3NXlBU=;
  b=BzdEDlTpxQz+A1mfetCB/v6uJ5oVbn3OCXPvSuCdbee5ya/ZMj/7+7Lc
   yNP9pMV3G5z/Yifdh86f632sBuzU6Ey22W/eCSzbKThBKaw7CjcosULdz
   CHzR9jzbQ+ahTdsgtVuaTBSRGh2xSv/0uFnPZqdyFop2TMFjx1PzRLSTA
   Mmid28UDYySua21rkFETanxBPpslL8iTHLL4kb3F5LRZxniUA8tVa/0Ba
   3xPyo0X/GN3yAoQXCY3n5JHc2XqVSvw0qcfW1zh4IgtoG4UOuw7exCT0q
   9ninN5OubibK15CFGRdt4dRUJa64U5zLofH0kSN0/+wBLsl1RYvjrkP8y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322774246"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322774246"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608254838"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608254838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 11:17:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGPYS-008mKf-2G;
        Fri, 13 Jan 2023 21:17:32 +0200
Date:   Fri, 13 Jan 2023 21:17:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: dw: Fix wrong FIFO level setting for long xfers
Message-ID: <Y8GuTDmAxGweJ1/7@smile.fi.intel.com>
References: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
 <20230113185942.2516-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113185942.2516-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:59:42PM +0300, Serge Semin wrote:
> Due to using the u16 type in the min_t() macros the SPI transfer length
> will be cast to word before participating in the conditional statement
> implied by the macro. Thus if the transfer length is greater than 64KB the
> Tx/Rx FIFO threshold level value will be determined by the leftover of the
> truncated after the type-case length. In the worst case it will cause the
> dramatical performance drop due to the "Tx FIFO Empty" or "Rx FIFO Full"
> interrupts triggered on each xfer word sent/received to/from the bus.
> 
> The problem can be easily fixed by specifying the unsigned int type in the
> min_t() macros thus preventing the possible data loss.

LGTM,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

thanks!

> Fixes: ea11370fffdf ("spi: dw: get TX level without an additional variable")
> Reported-by: Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Use min_t(unisgned int, ...) macros instead of just min(). (@Andy)
> ---
>  drivers/spi/spi-dw-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 99edddf9958b..c3bfb6c84cab 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -366,7 +366,7 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
>  	 * will be adjusted at the final stage of the IRQ-based SPI transfer
>  	 * execution so not to lose the leftover of the incoming data.
>  	 */
> -	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
> +	level = min_t(unsigned int, dws->fifo_len / 2, dws->tx_len);
>  	dw_writel(dws, DW_SPI_TXFTLR, level);
>  	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
>  
> -- 
> 2.39.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko


