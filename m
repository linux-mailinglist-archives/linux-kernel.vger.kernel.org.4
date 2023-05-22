Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247B70C32C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEVQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjEVQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098B130;
        Mon, 22 May 2023 09:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E25AB61787;
        Mon, 22 May 2023 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9920C433D2;
        Mon, 22 May 2023 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684772444;
        bh=vSFHOs36phaNDhoJJwl55AGouRVa+xyYfnlhHvEqarI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDCThWn6U9qygT9+6U/z8hefj6+FpfR9CLVMzW39pDAP5loaWjYK0WK//B6amxkgW
         tlFEXSxoGnsji4RG2hy9U+hwOBuIVz1psQBNYJjbbQVgCvoRE9kxB8wztEytFSoCX5
         3Bqbv+pQrYgUqjx0j/1NGXwG1VCvg/5xKZoFssro=
Date:   Mon, 22 May 2023 17:20:40 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Check the return value of
 dmaengine_tx_status
Message-ID: <2023052225-slimy-struggle-6fee@gregkh>
References: <20230522025111.3747-1-sherry.sun@nxp.com>
 <PAXPR04MB918546704F3DB435675B747A89439@PAXPR04MB9185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB918546704F3DB435675B747A89439@PAXPR04MB9185.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:45:12PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Sherry Sun <sherry.sun@nxp.com>
> > Sent: Sunday, May 21, 2023 9:51 PM
> > To: gregkh@linuxfoundation.org; jirislaby@kernel.org; Shenwei Wang
> > <shenwei.wang@nxp.com>; ilpo.jarvinen@linux.intel.com
> > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: [PATCH] tty: serial: fsl_lpuart: Check the return value of
> > dmaengine_tx_status
> > 
> > Coverity reports the Unchecked return value (CHECKED_RETURN) warning:
> > Calling dmaengine_tx_status without checking return value.
> > 
> > So here add the return value check for dmaengine_tx_status() function to make
> > coverity happy.
> > 
> > Fixes: cf9aa72d2f91 ("tty: serial: fsl_lpuart: optimize the timer based EOP logic")
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c index
> > 92a3bd0f4158..f2a47a8c5b85 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1286,13 +1286,19 @@ static void lpuart_dma_rx_complete(void *arg)
> > static void lpuart_timer_func(struct timer_list *t)  {
> >  	struct lpuart_port *sport = from_timer(sport, t, lpuart_timer);
> > +	enum dma_status dmastat;
> 
> Should be reverse Christmas tree order.

Not a requirement at all, please don't force it.

thanks,

greg k-h
