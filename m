Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9973316A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbjFPMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjFPMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:40:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E25268A;
        Fri, 16 Jun 2023 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686919236; x=1718455236;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rr9Wv//YevBMNTQkmKpej7PgJmFxPrLjzfxfxWBHxKY=;
  b=leVTWwraRfup8gixHvAZ3eOnQd786B1G0WtC+q5tLKRovrg6yWwmyPxl
   8XsLI0mHNDrPH3NoBFxZXRfInruJCyFgZ2n9nI1ue3PkBulx9gqKZjptE
   b6ef8HSbmhNPpmOeFBsjilZE9+ObRkZosG1pqilf93ouCG69nFe/NkaqO
   5JMpvVNGxVnSQQkfolMe9NJKmpamca0NwcAEHsZXqwG1QAIt4XvDwT+du
   YY6AkoYKOAbqcmWV+L/sMcYO1exNPQRqNW2ajH/yPjhl3ezoEEUjLVnb+
   aVEM71Ojmhh33/LDLC3j/N9rrKIYOAFPytxnzqni/y6/9LSh6gfIozh5j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425140073"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="425140073"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 05:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="716005263"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="716005263"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.211.240])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 05:40:32 -0700
Date:   Fri, 16 Jun 2023 15:40:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: imx: fix rs485 rx after tx
In-Reply-To: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
Message-ID: <c3e02d8-fba8-5ae3-15f3-fe378567932@linux.intel.com>
References: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-799842524-1686919234=:3967"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-799842524-1686919234=:3967
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 16 Jun 2023, Martin Fuzzey wrote:

> Since commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal
> active high") RS485 reception no longer works after a transmission.
> 
> The following scenario shows the problem:
> 	1) Open a port in RS485 mode
> 	2) Receive data from remote (OK)
> 	3) Transmit data to remote (OK)
> 	4) Receive data from remote (Nothing received)
> 
> In RS485 mode, imx_uart_start_tx() calls imx_uart_stop_rx() and, when the
> transmission is complete, imx_uart_stop_tx() calls imx_uart_start_rx().
> 
> Since the above commit imx_uart_stop_rx() now sets the loopback bit but
> imx_uart_start_rx() does not clear it causing the hardware to remain in
> loopback mode and not receive external data.
> 
> Fix this by moving the existing loopback disable code to a helper function
> and calling it from imx_uart_start_rx() too.
> 
> Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
> ---
>  drivers/tty/serial/imx.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index c5e17569c3ad..3fe8ff241522 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -369,6 +369,16 @@ static void imx_uart_soft_reset(struct imx_port *sport)
>  	sport->idle_counter = 0;
>  }
>  
> +static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
> +{
> +	unsigned int uts;
> +
> +	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
> +	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
> +	uts &= ~UTS_LOOP;
> +	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
> +}
> +
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_start_rx(struct uart_port *port)
>  {
> @@ -390,6 +400,7 @@ static void imx_uart_start_rx(struct uart_port *port)
>  	/* Write UCR2 first as it includes RXEN */
>  	imx_uart_writel(sport, ucr2, UCR2);
>  	imx_uart_writel(sport, ucr1, UCR1);
> +	imx_uart_disable_loopback_rs485(sport);
>  }
>  
>  /* called with port.lock taken and irqs off */
> @@ -1422,7 +1433,7 @@ static int imx_uart_startup(struct uart_port *port)
>  	int retval;
>  	unsigned long flags;
>  	int dma_is_inited = 0;
> -	u32 ucr1, ucr2, ucr3, ucr4, uts;
> +	u32 ucr1, ucr2, ucr3, ucr4;
>  
>  	retval = clk_prepare_enable(sport->clk_per);
>  	if (retval)
> @@ -1521,10 +1532,7 @@ static int imx_uart_startup(struct uart_port *port)
>  		imx_uart_writel(sport, ucr2, UCR2);
>  	}
>  
> -	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
> -	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
> -	uts &= ~UTS_LOOP;
> -	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
> +	imx_uart_disable_loopback_rs485(sport);
>  
>  	spin_unlock_irqrestore(&sport->port.lock, flags);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-799842524-1686919234=:3967--
