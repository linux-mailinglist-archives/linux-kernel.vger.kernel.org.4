Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50B1622B67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKIMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiKIMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:19:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A02612E;
        Wed,  9 Nov 2022 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667996374; x=1699532374;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bCkzJnJGlqi2Ptd+wmfFB6aY/2jG6IDmsgal7Led+7Q=;
  b=k8cctlNhz6shQhnGSiOBlWPYWgohVe1CuxXkIPReg56FEZVQwFCyhQcN
   L8tYU8jCc5CIvUVE9SKh6VvnhM+JuQVYRIvPw1v8DqqJQ+yzX9HoEnLvL
   7xBHyg0D7tz3JLeLgzQs2GgoTWqWFj/rNWASY1lnfc36/OT3o3SFHTA5k
   NIeTwBrdN4aBqhILQoWX61fUzzRbW8fvUqDkq+hnxX0oO0uPidgdBIgsL
   53XCYnr6UsehsFEL0cicaiVL1o+fsVkRUf7pQ47XdxKpZbRqYxKsjtm+0
   YPnBs0AuRGNlYQPjGP5qx3wd5d1BnRlUISRGcVLGwxqzD7o2oKqRmCwlK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312123326"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="312123326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:19:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881911295"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="881911295"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.251.219.48])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:19:25 -0800
Date:   Wed, 9 Nov 2022 14:19:21 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: improve lpuart32 registers
 clearing when shutdown
In-Reply-To: <20221109104515.17266-3-sherry.sun@nxp.com>
Message-ID: <9e682825-3420-fbe3-eb9d-8e864430363a@linux.intel.com>
References: <20221109104515.17266-1-sherry.sun@nxp.com> <20221109104515.17266-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, Sherry Sun wrote:

> Need to clear the UARTSTAT and UARTMODIR registers when shutdown the
> uart port, also clear the Rx/Tx DMA enable bits and loopback
> configuration bit.

This lacks answer to "Why?" question. Think about somebody not as familiar 
with the HW as you are looking back to this very commit message like 5 
years from now and wondering why this change was made.

Preferrably make a separate change out of all these four changes if the 
answers to why question are different.

It would also help in deciding whether Fixes tag is necessary or not 
since you didn't seem to include.

-- 
 i.

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index f5a0a14fa366..43d9d6a6e94a 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1771,11 +1771,22 @@ static void lpuart32_shutdown(struct uart_port *port)
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  
> +	/* clear statue */
> +	temp = lpuart32_read(&sport->port, UARTSTAT);
> +	lpuart32_write(&sport->port, temp, UARTSTAT);
> +
> +	/* disable Rx/Tx DMA */
> +	temp = lpuart32_read(port, UARTBAUD);
> +	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
> +	lpuart32_write(port, temp, UARTBAUD);
> +
>  	/* disable Rx/Tx and interrupts */
>  	temp = lpuart32_read(port, UARTCTRL);
>  	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
> -			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
> +			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
> +			UARTCTRL_LOOPS);
>  	lpuart32_write(port, temp, UARTCTRL);
> +	lpuart32_write(port, 0, UARTMODIR);
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
> 
