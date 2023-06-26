Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623273E439
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjFZQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjFZQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:08:53 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 70DCE10F4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:08:47 -0700 (PDT)
Received: (qmail 838352 invoked by uid 1000); 26 Jun 2023 12:08:46 -0400
Date:   Mon, 26 Jun 2023 12:08:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: ohci-at91: Fix the unhandle interrupt when resume
Message-ID: <8908b612-0a87-428b-9d78-38fbc04354bf@rowland.harvard.edu>
References: <20230626152713.18950-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626152713.18950-1-aarongt.shen@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:27:13PM +0800, Guiting Shen wrote:
> The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
> suspend which will let the ohci_irq() skip the interrupt after resume. And
> nobody to handle this interrupt.
> 
> According to the comment in ohci_hcd_at91_drv_suspend(), it need to reset
> when resume from suspend(MEM) to fix by setting "hibernated" argument of
> ohci_resume().
> 
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-at91.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 533537ef3c21..360680769494 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -673,7 +673,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  	else
>  		at91_start_clock(ohci_at91);
>  
> -	ohci_resume(hcd, false);
> +	/*
> +	 * According to the comment in ohci_hcd_at91_drv_suspend()
> +	 * we need to do a reset if the 48Mhz clock was stopped,
> +	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
> +	 * to reset in this case by setting its "hibernated" flag.
> +	 */
> +	ohci_resume(hcd, !ohci_at91->wakeup);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
