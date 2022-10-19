Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C2604366
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJSLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiJSLhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:37:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A690F036D;
        Wed, 19 Oct 2022 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178117; x=1697714117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6P7kIa36+7jAAfqrpo1HhIeiIYqEsGmum7j1waY+mVw=;
  b=TBOlxz7JkqsBYXqTpSfb+6M7JjARaCyHYNN532TTckiJhvxBrOdxzqtr
   J2NV0CCJvt4IwsU7cMr+Uc5/elrM6i/A20jZ9yr+EPrpRSs8z4+DfIy8D
   AUmk5NSfrp0+UOHa1w3ueUkIhY5qR+1yea5BUmoaYM3XJqNm2i/zjV1A8
   e54+h0/5bREIS8BImymxTIUeBK1o/Xrq3HkGtr/f68KSw4sL4a5OGnNuT
   XcJMO8uV41+/Th1fVKx2TtgEAPyLKJTRTBoAqbQqbCyNhdys3eyubb/BJ
   OZSYFjYCY5G9nNAlEs3xTA4DQVk9rkmcsS8lM2zvwGE+s++oG4jusxiR8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303996165"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="303996165"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="624086281"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="624086281"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2022 04:11:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol6yc-009pA6-31;
        Wed, 19 Oct 2022 14:11:10 +0300
Date:   Wed, 19 Oct 2022 14:11:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/44] serial: pch_uart: Use uart_xmit_advance()
Message-ID: <Y0/bTtsR2gqVa8/t@smile.fi.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019091151.6692-5-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:11:11PM +0300, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/pch_uart.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index c59ce7886579..c76719c0f453 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -738,15 +738,12 @@ static void pch_dma_tx_complete(void *arg)
>  {
>  	struct eg20t_port *priv = arg;
>  	struct uart_port *port = &priv->port;
> -	struct circ_buf *xmit = &port->state->xmit;
>  	struct scatterlist *sg = priv->sg_tx_p;
>  	int i;
>  
> -	for (i = 0; i < priv->nent; i++, sg++) {
> -		xmit->tail += sg_dma_len(sg);
> -		port->icount.tx += sg_dma_len(sg);
> -	}
> -	xmit->tail &= UART_XMIT_SIZE - 1;
> +	for (i = 0; i < priv->nent; i++, sg++)
> +		uart_xmit_advance(port, sg_dma_len(sg));
> +
>  	async_tx_ack(priv->desc_tx);
>  	dma_unmap_sg(port->dev, sg, priv->orig_nent, DMA_TO_DEVICE);
>  	priv->tx_dma_use = 0;
> @@ -843,8 +840,7 @@ static unsigned int handle_tx(struct eg20t_port *priv)
>  
>  	while (!uart_tx_stopped(port) && !uart_circ_empty(xmit) && fifo_size) {
>  		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> +		uart_xmit_advance(port, 1);
>  		fifo_size--;
>  		tx_empty = 0;
>  	}
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


