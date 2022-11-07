Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5261F1E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKGLcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiKGLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:31:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55019C06;
        Mon,  7 Nov 2022 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820716; x=1699356716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fqn6QtaeFYW7jPHfHs6aYUWyGCrgoRcjFC8Z+hfgI/w=;
  b=Ch+SIiWQWELPsRwcbhh5IMZQF17e46umXTDVmUgN4v/5/hK6L0ceDwoh
   Qub25O/eucyCSnM1fXzOHhGh0FhYG/7BJaezYc2vP34Vm3340eAFKe4hj
   frEhIG/ZmjWwA2ZHnHc3KC+4flvfjihMVKZ96Ku8rdPAptjte4m13m47T
   sN7faVZd0QKLgDW1kj6atEJr/vPrpP0x3/8G+nEI3iYMVb8WGkQS+4D2T
   ML5LvmA48R4hISJwjXAEtJpz+K4ra8v1FJp9jAgKv3b737hjTGtkjZ+2g
   /SZ4p7fWr46ajKBxGyimPwblaV7L9PCkpchJWJ4DEUbOPuCjE4LUewagj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293734902"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293734902"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="965119800"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="965119800"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2022 03:31:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0M4-008bpd-1F;
        Mon, 07 Nov 2022 13:31:52 +0200
Date:   Mon, 7 Nov 2022 13:31:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles BULOZ <gilles.buloz@kontron.com>
Subject: Re: [PATCH 1/1] serial: 8250_dma: Rearm DMA Rx if more data is
 pending
Message-ID: <Y2jsqNHQ5KhYISb3@smile.fi.intel.com>
References: <20221107102126.56481-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107102126.56481-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 12:21:26PM +0200, Ilpo Järvinen wrote:
> When DMA Rx completes, the current behavior is to just exit the DMA
> completion handler without future actions. If the transfer is still
> on-going, UART will trigger an interrupt and that eventually rearms the
> DMA Rx. The extra interrupt round-trip has an inherent latency cost
> that increases the risk of FIFO overrun. In such situations, the
> latency margin tends to already be less due to FIFO not being empty.
> 
> Add check into DMA Rx completion handler to detect if LSR has DR (Data
> Ready) still set. DR indicates there will be more characters pending
> and DMA Rx can be rearmed right away to handle them.

Yep, I used to have something like draft of the below change locally.
Thanks for putting it in shape and upstreamimg!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Gilles BULOZ <gilles.buloz@kontron.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index b85c82616e8c..37d6af2ec427 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -38,9 +38,8 @@ static void __dma_tx_complete(void *param)
>  	spin_unlock_irqrestore(&p->port.lock, flags);
>  }
>  
> -static void __dma_rx_complete(void *param)
> +static void __dma_rx_complete(struct uart_8250_port *p)
>  {
> -	struct uart_8250_port	*p = param;
>  	struct uart_8250_dma	*dma = p->dma;
>  	struct tty_port		*tty_port = &p->port.state->port;
>  	struct dma_tx_state	state;
> @@ -57,6 +56,20 @@ static void __dma_rx_complete(void *param)
>  	tty_flip_buffer_push(tty_port);
>  }
>  
> +static void dma_rx_complete(void *param)
> +{
> +	struct uart_8250_port *p = param;
> +	struct uart_8250_dma *dma = p->dma;
> +	unsigned long flags;
> +
> +	__dma_rx_complete(p);
> +
> +	spin_lock_irqsave(&p->port.lock, flags);
> +	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
> +		p->dma->rx_dma(p);
> +	spin_unlock_irqrestore(&p->port.lock, flags);
> +}
> +
>  int serial8250_tx_dma(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma		*dma = p->dma;
> @@ -130,7 +143,7 @@ int serial8250_rx_dma(struct uart_8250_port *p)
>  		return -EBUSY;
>  
>  	dma->rx_running = 1;
> -	desc->callback = __dma_rx_complete;
> +	desc->callback = dma_rx_complete;
>  	desc->callback_param = p;
>  
>  	dma->rx_cookie = dmaengine_submit(desc);
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


