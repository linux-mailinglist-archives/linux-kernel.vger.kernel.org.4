Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20173A310
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjFVOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:30:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D1C421FFE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:51 -0700 (PDT)
Received: (qmail 717012 invoked by uid 1000); 22 Jun 2023 10:29:43 -0400
Date:   Thu, 22 Jun 2023 10:29:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-at91: Fix the unhandle interrupt when resume
Message-ID: <4cf867a9-3c78-403a-aaeb-91f6cf099a3d@rowland.harvard.edu>
References: <20230622025739.13934-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622025739.13934-1-aarongt.shen@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:57:39AM +0800, Guiting Shen wrote:
> The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
> suspend which will let the ohci_irq() skip the interrupt after resume. And
> nobody to handle this interrupt.
> 
> Set the ohci->rh_state to OHCI_RH_SUSPEND instead of OHCI_RH_HALTED when
> suspend to fix it.
> 
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/usb/host/ohci-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index b9ce8d80f20b..7a970e573668 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -645,7 +645,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  	 * REVISIT: some boards will be able to turn VBUS off...
>  	 */
>  	if (!ohci_at91->wakeup) {
> -		ohci->rh_state = OHCI_RH_HALTED;
> +		ohci->rh_state = OHCI_RH_SUSPENDED;

It looks like this change ignores the comment immediately above it 
(just before the start of this hunk).

If you want to find a way to handle IRQs better after the controller 
resumes, maybe you should change the resume routine instead of the 
suspend routine.

Alan Stern
