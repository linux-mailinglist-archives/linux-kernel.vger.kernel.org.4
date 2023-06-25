Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F573D382
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFYUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFYUEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:04:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DCA161AD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:04:29 -0700 (PDT)
Received: (qmail 812310 invoked by uid 1000); 25 Jun 2023 16:04:29 -0400
Date:   Sun, 25 Jun 2023 16:04:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: ohci-at91: Fix the unhandle interrupt when resume
Message-ID: <552b1ac6-2149-48fa-9432-49655bfbc366@rowland.harvard.edu>
References: <20230625161553.11073-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625161553.11073-1-aarongt.shen@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:15:53AM +0800, Guiting Shen wrote:
> The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
> suspend which will let the ohci_irq() skip the interrupt after resume. And
> nobody to handle this interrupt.
> 
> According to the comment in ohci_hcd_at91_drv_suspend(), it need to reset
> when resume from suspend(MEM) to fix.
> 
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/usb/host/ohci-at91.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index b9ce8d80f20b..1a0356d9ea15 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -672,7 +672,12 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  	else
>  		at91_start_clock(ohci_at91);
>  
> -	ohci_resume(hcd, false);
> +	/*
> +	 * need to reset according to the comment of suspend routine,
> +	 * otherwise the ohci_irq would skip the interrupt if ohci_state
> +	 * was OHCI_RH_HALTED.
> +	 */
> +	ohci_resume(hcd, !ohci_at91->wakeup);

This comment doesn't say why the code uses !ohci_at91->wakeup.  It 
should explain that.  For example:

	/*
	 * According to the comment in ohci_hcd_at91_drv_suspend()
	 * we need to do a reset if the 48-MHz clock was stopped,
	 * that is, if ohci_at91->wakeup is clear.  Tell ohci_resume()
	 * to reset in this case by setting its "hibernated" flag.
	 */

Alan Stern
