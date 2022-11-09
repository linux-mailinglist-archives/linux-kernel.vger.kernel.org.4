Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED592622B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKIMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKIMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:02:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BB2CE30;
        Wed,  9 Nov 2022 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667995328; x=1699531328;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hypwsi6BOBxwCxzYBfJ6znER4INgKD9gmMosAIAe8os=;
  b=T29Vnlu9HD24NzsK9BxZfPT/PviIDkAUJwwqUsi1uDR/op0imtKVwemd
   ARFQVmxo8PaJoRfN8ozoSofKrO32YbtBPOuKLuvtSKUHzqCflZvH6KSUs
   LVezkR0Ni0XDuQ1k+ZaIUXfH9ddw/Mzlv1hdqzRYKzCprv2+mTtcUxC88
   9F8Uujqbx6WtOHCTyBnDFk3PkV1Mw0v5gtOCWNUt+nrrks6xNWgEMaUup
   8qHnORca+mIEm+N45erPHoKsz5RfXdXBc+k4N0KCpw03SNwZfK+NDiWaI
   BgekN7Hz16O0E2ztBegHo/MpHrXq7P6ICLFShDw1DQpgmLSrS940gwaOM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309669979"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="309669979"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:02:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="779320963"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="779320963"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.251.219.48])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:02:06 -0800
Date:   Wed, 9 Nov 2022 14:02:04 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: only enable Idle Line
 Interrupt for non-dma case
In-Reply-To: <20221109104515.17266-2-sherry.sun@nxp.com>
Message-ID: <154eb2b-9467-e915-f51c-18d616c81d34@linux.intel.com>
References: <20221109104515.17266-1-sherry.sun@nxp.com> <20221109104515.17266-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, Sherry Sun wrote:

> For the lpuart driver, the Idle Line Interrupt Enable now is only needed
> for the CPU mode, so enable the UARTCTRL_ILIE at the correct place, and
> clear it when shutdown.
> 
> Also need to configure the suitable UARTCTRL_IDLECFG, now the value is
> 0x7, represent 128 idle characters will trigger the Idle Line Interrupt.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index bd685491eead..f5a0a14fa366 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -179,7 +179,7 @@
>  #define UARTCTRL_SBK		0x00010000
>  #define UARTCTRL_MA1IE		0x00008000
>  #define UARTCTRL_MA2IE		0x00004000
> -#define UARTCTRL_IDLECFG	0x00000100
> +#define UARTCTRL_IDLECFG_OFF   8
>  #define UARTCTRL_LOOPS		0x00000080
>  #define UARTCTRL_DOZEEN		0x00000040
>  #define UARTCTRL_RSRC		0x00000020
> @@ -230,6 +230,8 @@
>  #define GLOBAL_RST_MIN_US	20
>  #define GLOBAL_RST_MAX_US	40
>  
> +#define UARTCTRL_IDLECFG	0x7
> +

GEN_MASK() to the correct bits directly?

>  /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
>  #define DMA_RX_TIMEOUT		(10)
>  
> @@ -1506,7 +1508,7 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
>  	ctrl = lpuart32_read(&sport->port, UARTCTRL);
>  	ctrl_saved = ctrl;
>  	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_TE |
> -			UARTCTRL_RIE | UARTCTRL_RE);
> +			UARTCTRL_RIE | UARTCTRL_RE | UARTCTRL_ILIE);
>  	lpuart32_write(&sport->port, ctrl, UARTCTRL);
>  
>  	/* enable FIFO mode */
> @@ -1530,7 +1532,8 @@ static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
>  	lpuart32_setup_watermark(sport);
>  
>  	temp = lpuart32_read(&sport->port, UARTCTRL);
> -	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
> +	temp |= UARTCTRL_RE | UARTCTRL_TE;
> +	temp |= UARTCTRL_IDLECFG << UARTCTRL_IDLECFG_OFF;

FIELD_PREP() would probably be more appropriate for this? Then you can 
also drop the shift offset.

-- 
 i.

>  	lpuart32_write(&sport->port, temp, UARTCTRL);
>  }
>  
> @@ -1669,7 +1672,7 @@ static void lpuart32_configure(struct lpuart_port *sport)
>  	}
>  	temp = lpuart32_read(&sport->port, UARTCTRL);
>  	if (!sport->lpuart_dma_rx_use)
> -		temp |= UARTCTRL_RIE;
> +		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
>  	if (!sport->lpuart_dma_tx_use)
>  		temp |= UARTCTRL_TIE;
>  	lpuart32_write(&sport->port, temp, UARTCTRL);
> @@ -1770,7 +1773,7 @@ static void lpuart32_shutdown(struct uart_port *port)
>  
>  	/* disable Rx/Tx and interrupts */
>  	temp = lpuart32_read(port, UARTCTRL);
> -	temp &= ~(UARTCTRL_TE | UARTCTRL_RE |
> +	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
>  			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
>  	lpuart32_write(port, temp, UARTCTRL);
>  
> 

