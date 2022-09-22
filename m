Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C695E64C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiIVOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiIVOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:10:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C960F08BF;
        Thu, 22 Sep 2022 07:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86F56B83724;
        Thu, 22 Sep 2022 14:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9284C4347C;
        Thu, 22 Sep 2022 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663855843;
        bh=mOuSUdHvHoTyLUwQ9Xy11fVS+4QZJbq1zQBk5d2LeNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHS4MQbhdy6a0EoB5Cbtu1ro1XOt2r6KJbca19aSfRyiprz1hQlpVkhzx7w/WIGYy
         MLvBDolkcRv//9CyANBrFwdskg94QD2xOzDFPz869tzb86h+hozsEXXuQudwwSG2WX
         X9aE9E7YTlVe1Rr4vg9I6viQoh3KdfNcZU1JE8fk=
Date:   Thu, 22 Sep 2022 16:10:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_omap: Convert to use
 uart_xmit_advance()
Message-ID: <Yyxs4NSxYs/KrQyt@kroah.com>
References: <20220909091258.68886-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091258.68886-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:12:58PM +0300, Andy Shevchenko wrote:
> uart_xmit_advance() provides a common way on how to advance
> the Tx queue. Use it for the sake of unification and robustness.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index b43894e15b07..4f4d878dc2fc 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -984,9 +984,7 @@ static void omap_8250_dma_tx_complete(void *param)
>  
>  	dma->tx_running = 0;
>  
> -	xmit->tail += dma->tx_size;
> -	xmit->tail &= UART_XMIT_SIZE - 1;
> -	p->port.icount.tx += dma->tx_size;
> +	uart_xmit_advance(&p->port, dma->tx_size);
>  
>  	if (priv->delayed_restore) {
>  		priv->delayed_restore = 0;
> -- 
> 2.35.1
> 

Breaks the build :(
