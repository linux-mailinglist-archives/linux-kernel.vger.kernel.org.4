Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE65573D13C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFYN5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFYN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:57:47 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 45BD91B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:57:45 -0700 (PDT)
Received: (qmail 804932 invoked by uid 1000); 25 Jun 2023 09:57:43 -0400
Date:   Sun, 25 Jun 2023 09:57:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-at91: Fix the unhandle interrupt when resume
Message-ID: <e3d29c44-a471-4ca2-b996-1648ba8f3d77@rowland.harvard.edu>
References: <20230622025739.13934-1-aarongt.shen@gmail.com>
 <4cf867a9-3c78-403a-aaeb-91f6cf099a3d@rowland.harvard.edu>
 <c2d0b37a-3ee1-e07e-e265-c71895474ba8@gmail.com>
 <9c702495-a839-43ea-85b7-1c0a0c54ec73@rowland.harvard.edu>
 <8569ced1-ed6d-18b3-5223-a8bd923f864b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8569ced1-ed6d-18b3-5223-a8bd923f864b@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 12:01:12PM +0800, Guiting Shen wrote:
> On Fri, Jun 23, 2023 at 23:52:53PM GMT+8, Alan Stern wrote:
> >> The comment which was added with commit-id 0365ee0a8f745 may be outdated
> >> because ohci_suspend() and ohci_at91_port_suspend() is used to suspend
> >> instead of setting ohci->rh_state to OHCI_RH_HALTED.
> > 
> > The comment says nothing about ohci->rh_state; it talks about the 
> > integrated transceivers and the 48 MHz clock.  I don't see why you would 
> > think the comment is outdated.
> > 
> 
> The comment says the reason to discard connection state by reset, but I
> don't see any reset operation at ohci-at91 suspend/resume routine in
> source code.And ohci_suspend() disable irq emission and mark HW
> unaccessible  maybe do the same effect as set ohci->rh_state to
> OHCI_RH_HALTED to discard connection state which I think the comment is
> outdated.

No, it doesn't do the same.  An actual reset is needed.

> >> What's more, I found that only ohci-at91 driver to set the ohci->rh_state
> >> which may be unnessory because the ohci_suspend() disable irq emission and
> >> mark HW unaccessible and ohci_at91_port_suspend() suspend the controller.
> >>
> >> Is it really need to set ohci->rh_state in ohci_hcd_at91_drv_suspend()?
> >>
> >> It maybe confused to set ohci->rh_state to OHCI_RH_SUSPEND in resume
> >> routine.
> > 
> > I'm not really sure what that assignment was intended to accomplish, but 
> > maybe it was meant to force a reset when the controller resumes.
> > 
> > You could get the same result by leaving ohci->rh_state set to 
> > OHCI_RH_SUSPENDED but changing ohci_hcd_at91_drv_resume().  Instead of 
> > calling ohci_resume(hcd, false), have it call:
> > 
> > 	ohci_resume(hcd, !ohci_at91->wakeup);
> > 
> > That way, if the wakeup flag is clear and the clock was stopped, 
> > ohci_resume() will call ohci_usb_reset().  You should also add a comment 
> > explaining the reason.
> > 
> > I can't test this because I don't have the AT91 hardware.
> > 
> 
> It works by your methods to force a reset in my sama5d3 soc hardware.
> And I found that the ohci->rh_state was already OHCI_RH_SUSPEND before
> set it OHCI_RH_HALTED in suspend.So the question is whether to set it
> OHCI_RH_HALETED in ohci-at91 suspend routine.
> 
> It also works by comment the ohci->rh_state = OHCI_RH_HALTED in suspend
> routine.But I think it is safer to use your methods.
> 
> Do you have any suggestion on it before I send v2 patch latter.

No suggestions now.  Submit your v2 patch and then maybe I'll have 
something more to say.

Alan Stern
