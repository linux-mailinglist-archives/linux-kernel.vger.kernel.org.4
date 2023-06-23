Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700E73BC12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFWPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:52:55 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DE2092129
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:52:53 -0700 (PDT)
Received: (qmail 754247 invoked by uid 1000); 23 Jun 2023 11:52:53 -0400
Date:   Fri, 23 Jun 2023 11:52:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-at91: Fix the unhandle interrupt when resume
Message-ID: <9c702495-a839-43ea-85b7-1c0a0c54ec73@rowland.harvard.edu>
References: <20230622025739.13934-1-aarongt.shen@gmail.com>
 <4cf867a9-3c78-403a-aaeb-91f6cf099a3d@rowland.harvard.edu>
 <c2d0b37a-3ee1-e07e-e265-c71895474ba8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d0b37a-3ee1-e07e-e265-c71895474ba8@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:44:04AM +0800, Guiting Shen wrote:
> 
> 
> On Thu,Jun 22,2023 at 22:29:43PM GMT+8, Alan Stern wrote:
> > On Thu, Jun 22, 2023 at 10:57:39AM +0800, Guiting Shen wrote:
> > > The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
> > > suspend which will let the ohci_irq() skip the interrupt after resume. And
> > > nobody to handle this interrupt.
> > > 
> > > Set the ohci->rh_state to OHCI_RH_SUSPEND instead of OHCI_RH_HALTED when
> > > suspend to fix it.
> > > 
> > > Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> > > ---
> > >   drivers/usb/host/ohci-at91.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> > > index b9ce8d80f20b..7a970e573668 100644
> > > --- a/drivers/usb/host/ohci-at91.c
> > > +++ b/drivers/usb/host/ohci-at91.c
> > > @@ -645,7 +645,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
> > >   	 * REVISIT: some boards will be able to turn VBUS off...
> > >   	 */
> > >   	if (!ohci_at91->wakeup) {
> > > -		ohci->rh_state = OHCI_RH_HALTED;
> > > +		ohci->rh_state = OHCI_RH_SUSPENDED;
> > 
> > It looks like this change ignores the comment immediately above it
> > (just before the start of this hunk).
> > 
> > If you want to find a way to handle IRQs better after the controller
> > resumes, maybe you should change the resume routine instead of the
> > suspend routine.
> > 
> > Alan Stern
> 
> The comment which was added with commit-id 0365ee0a8f745 may be outdated
> because ohci_suspend() and ohci_at91_port_suspend() is used to suspend
> instead of setting ohci->rh_state to OHCI_RH_HALTED.

The comment says nothing about ohci->rh_state; it talks about the 
integrated transceivers and the 48 MHz clock.  I don't see why you would 
think the comment is outdated.

> What's more, I found that only ohci-at91 driver to set the ohci->rh_state
> which may be unnessory because the ohci_suspend() disable irq emission and
> mark HW unaccessible and ohci_at91_port_suspend() suspend the controller.
> 
> Is it really need to set ohci->rh_state in ohci_hcd_at91_drv_suspend()?
> 
> It maybe confused to set ohci->rh_state to OHCI_RH_SUSPEND in resume
> routine.

I'm not really sure what that assignment was intended to accomplish, but 
maybe it was meant to force a reset when the controller resumes.

You could get the same result by leaving ohci->rh_state set to 
OHCI_RH_SUSPENDED but changing ohci_hcd_at91_drv_resume().  Instead of 
calling ohci_resume(hcd, false), have it call:

	ohci_resume(hcd, !ohci_at91->wakeup);

That way, if the wakeup flag is clear and the clock was stopped, 
ohci_resume() will call ohci_usb_reset().  You should also add a comment 
explaining the reason.

I can't test this because I don't have the AT91 hardware.

Alan Stern
