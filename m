Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7C68F8C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBHUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBHUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:21:23 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6BFB732503
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:21:21 -0800 (PST)
Received: (qmail 746896 invoked by uid 1000); 8 Feb 2023 15:21:20 -0500
Date:   Wed, 8 Feb 2023 15:21:20 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Message-ID: <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
References: <1675864487-18620-1-git-send-email-quic_prashk@quicinc.com>
 <Y+O3vBbBh4ZwSBWT@kroah.com>
 <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:15:54PM +0530, Prashanth K wrote:
> 
> 
> On 08-02-23 08:24 pm, Greg Kroah-Hartman wrote:
> > On Wed, Feb 08, 2023 at 07:24:47PM +0530, Prashanth K wrote:
> > > Consider a case where gserial_disconnect has already cleared
> > > gser->ioport. And if a wakeup interrupt triggers afterwards,
> > > gserial_resume gets called, which will lead to accessing of
> > > gserial->port and thus causing null pointer dereference.Add
> > > a null pointer check to prevent this.
> > > 
> > > Fixes: aba3a8d01d62 (" usb: gadget: u_serial: add suspend resume callbacks")
> > 
> > Nit, and our tools will complain, no " " before the "usb:" string here,
> > right?
> > 
> Will fix it in next patch.
> > 
> > 
> > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > > ---
> > >   drivers/usb/gadget/function/u_serial.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> > > index 840626e..98be2b8 100644
> > > --- a/drivers/usb/gadget/function/u_serial.c
> > > +++ b/drivers/usb/gadget/function/u_serial.c
> > > @@ -1428,6 +1428,9 @@ void gserial_resume(struct gserial *gser)
> > >   	struct gs_port *port = gser->ioport;
> > >   	unsigned long	flags;
> > > +	if (!port)
> > > +		return;
> > > +
> > 
> > What prevents port from going to NULL right after this check?
> In our case we got a null pointer de-reference while performing USB
> compliance tests, as the gser->port was null. Because in gserial_resume,
> spinlock_irq_save(&port->port_lock) accesses a null-pointer as port was
> already marked null by gserial_disconnect.
> 
> And after gserial_resume acquires the spinlock, gserial_disconnect cant mark
> it null until the spinlock is released. We need to check if the port->lock
> is valid before accessing it, otherwise it can lead to the above mentioned
> scenario

What happens if gserial_disconnect sets gser->port to NULL immediately 
after your new check occurs, but before 
spinlock_irq_save(&port->port_lock) gets called?

You may need to add a static spinlock to prevent this from happening.

Alan Stern
