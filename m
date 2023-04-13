Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B06E0982
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDMI6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDMI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:57:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228486BC;
        Thu, 13 Apr 2023 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681376161; x=1712912161;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dx/KcB1yuWxjVTqAdCjBiSdHBqk0SPkHcsrbO43oHeQ=;
  b=Ry3wuscH5Es2scla0SeJ33oiO3feD45rQ1xsl804xXKNXA6S4W7OX8Md
   Tjao+9MTxBmjB2GzzJf+ev1o9TYqmR5QhmwCyoHpZ+U/dFrjuJk/YTQY3
   2RDkgtQgdAH3QMsIsggGqM+bZRjW1TpUvwX0SBnsvcNpf0BhkEpMtZOdO
   w70x91Mrl3gE/Xs1XSltzg7QL3asTxrez1oSiL2/PBlzE4X/yXNTz+mnb
   aPBh10nTOc9djh5BvzT+5J7FVU4IvdjF1S4ycBONbVBCnXrkqngO4fXJe
   z7UcIN8JLSnw5oGBxouo0gREkGatR7fAOw/3aiKBtGm1/EnR8yZRnej4S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332836327"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="332836327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 01:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719754073"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="719754073"
Received: from pkudryav-mobl1.ger.corp.intel.com ([10.252.45.220])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 01:55:52 -0700
Date:   Thu, 13 Apr 2023 11:55:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        philippe.schenker@toradex.com,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: use UARTMODIR register bits
 for lpuart32 platform
In-Reply-To: <20230413053908.17702-1-sherry.sun@nxp.com>
Message-ID: <a8e12926-58e7-43c3-f4d1-a67b4bfbc1@linux.intel.com>
References: <20230413053908.17702-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1437061742-1681376154=:1987"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1437061742-1681376154=:1987
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 13 Apr 2023, Sherry Sun wrote:

> For lpuart32 platforms, UARTMODIR register is used instead of UARTMODEM.
> So here should configure the corresponding UARTMODIR register bits.
> 
> Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")

The patch is good but I don't think Fixes tag is warranted here because 
TXRTSPOL and TXRTSE bits are the same for both registers. ...So this 
is mostly to avoid reader confusion rather than fix an actual problem.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 074bfed57fc9..9845d3f5b84b 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1406,12 +1406,12 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
>  			struct lpuart_port, port);
>  
>  	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
> -				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
> +				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
>  	lpuart32_write(&sport->port, modem, UARTMODIR);
>  
>  	if (rs485->flags & SER_RS485_ENABLED) {
>  		/* Enable auto RS-485 RTS mode */
> -		modem |= UARTMODEM_TXRTSE;
> +		modem |= UARTMODIR_TXRTSE;
>  
>  		/*
>  		 * The hardware defaults to RTS logic HIGH while transfer.
> @@ -1420,9 +1420,9 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
>  		 * Note: UART is assumed to be active high.
>  		 */
>  		if (rs485->flags & SER_RS485_RTS_ON_SEND)
> -			modem |= UARTMODEM_TXRTSPOL;
> +			modem |= UARTMODIR_TXRTSPOL;
>  		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
> -			modem &= ~UARTMODEM_TXRTSPOL;
> +			modem &= ~UARTMODIR_TXRTSPOL;
>  	}
>  
>  	lpuart32_write(&sport->port, modem, UARTMODIR);
> 
--8323329-1437061742-1681376154=:1987--
