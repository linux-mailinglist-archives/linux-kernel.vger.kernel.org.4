Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614B0604057
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiJSJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiJSJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:45:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A1CDD88C;
        Wed, 19 Oct 2022 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666171238; x=1697707238;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=euE7pDmRzACLoAO9QxdZAaZkp7WeUhWkpLjl25+pHlk=;
  b=HXwd6H1CS7rjHE5tmsUyHvLixiWR0GVGUZP8RxAiBju73cWFHvRzz/28
   hU2zxoE3ynGF0pDz5RdmqGwP1EA9OIPgE8Tm6e4cLY97c7Yvl2qclXb8Y
   SsPuYgh6sNpOClAokBYRA0RIWk5WuXZI0tqpGOR/XDvOALLaZgkbC3nW3
   hqzIyrIg/2X9vi4eSR+WnHSVaMpRk43Rjz2ibzb49JBTgjhZYoipPwJmM
   28xHv4r8TaXTqnI1wbZhzyK8jlceBF/1Pl6J/bEvkLrTWIQYltTP+8QXk
   12ZYlWm8lCsTMbyEjR76W4GgyMkHiGpkVZoNlRBsaHPCdITzr3mjTRCrW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303973593"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="303973593"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:19:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660255720"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="660255720"
Received: from sponnura-mobl1.amr.corp.intel.com ([10.251.214.35])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:19:49 -0700
Date:   Wed, 19 Oct 2022 12:19:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: don't break the on-going transfer
 when global reset
In-Reply-To: <20221019065854.12397-1-sherry.sun@nxp.com>
Message-ID: <34564f52-cae1-fdc3-8676-ce3d8e645672@linux.intel.com>
References: <20221019065854.12397-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022, Sherry Sun wrote:

> lpuart_global_reset() shouldn't break the on-going transmit engin, need
> to recover the on-going data transfer after reset.
> 
> This can help earlycon here, since commit 60f361722ad2 ("serial:
> fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
> before uart_add_one_port(), earlycon is writing during global reset,
> as global reset will disable the TX and clear the baud rate register,
> which caused the earlycon cannot work any more after reset, needs to
> restore the baud rate and re-enable the transmitter to recover the
> earlycon write.
>
> Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 67fa113f77d4..5064fdba1b61 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -408,11 +408,9 @@ static int lpuart_global_reset(struct lpuart_port *sport)
>  {
>  	struct uart_port *port = &sport->port;
>  	void __iomem *global_addr;
> +	unsigned long tx_enable, bd, stat, sfifo;
>  	int ret;
>  
> -	if (uart_console(port))
> -		return 0;
> -
>  	ret = clk_prepare_enable(sport->ipg_clk);
>  	if (ret) {
>  		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
> @@ -420,11 +418,30 @@ static int lpuart_global_reset(struct lpuart_port *sport)
>  	}
>  
>  	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
> +		/*
> +		 * If the transmitter is used by earlycon, wait transmit engin complete
> +		 * and then reset
> +		 */
> +		tx_enable = lpuart32_read(port, UARTCTRL) & UARTCTRL_TE;
> +		if (tx_enable) {
> +			bd = lpuart32_read(&sport->port, UARTBAUD);
> +			stat = lpuart32_read(port, UARTSTAT);
> +			sfifo = lpuart32_read(port, UARTFIFO);
> +			while (!(stat & UARTSTAT_TC && sfifo & UARTFIFO_TXEMPT))
> +				cpu_relax();

This loop, if ever taken once, will loop forever as neither stat nor sfifo 
are reread inside the loop.

-- 
 i.

> +		}
> +
>  		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
>  		writel(UART_GLOBAL_RST, global_addr);
>  		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
>  		writel(0, global_addr);
>  		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
> +
> +		/* Recover the transmitter for earlycon */
> +		if (tx_enable) {
> +			lpuart32_write(port, bd, UARTBAUD);
> +			lpuart32_write(port, UARTCTRL_TE, UARTCTRL);
> +		}
>  	}
>  
>  	clk_disable_unprepare(sport->ipg_clk);
> 

