Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF56900A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBIHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBIHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:02:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9493B0E6;
        Wed,  8 Feb 2023 23:02:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41CC61831;
        Thu,  9 Feb 2023 07:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB508C433D2;
        Thu,  9 Feb 2023 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675926122;
        bh=ZuFbSrRoj++6J8ExSsVPwF8iZ9vdR9GzlKSYraDxvAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glZPMTsaDgi3yng3M71H/xkTd6NbVpVXbmhL3OQb107Gyh/HZq8E0OTy2s87D55b2
         FDXXgPyoAfr1wr2XASFi5RnYT2r2/RBrRZh5IVab9Q4eaca5C+7Buuel8pGKNqpCOW
         aGHJn/hkeq1kXAoEaHtaubxYzy/wT8pZQK2Mx+Aw=
Date:   Thu, 9 Feb 2023 08:01:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Message-ID: <Y+SaZrDmaqB0U2QA@kroah.com>
References: <1675864487-18620-1-git-send-email-quic_prashk@quicinc.com>
 <Y+O3vBbBh4ZwSBWT@kroah.com>
 <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:31:50AM +0530, Prashanth K wrote:
> 
> 
> On 09-02-23 01:51 am, Alan Stern wrote:
> > On Wed, Feb 08, 2023 at 09:15:54PM +0530, Prashanth K wrote:
> > > 
> > > 
> > > On 08-02-23 08:24 pm, Greg Kroah-Hartman wrote:
> > > > On Wed, Feb 08, 2023 at 07:24:47PM +0530, Prashanth K wrote:
> > > > > Consider a case where gserial_disconnect has already cleared
> > > > > gser->ioport. And if a wakeup interrupt triggers afterwards,
> > > > > gserial_resume gets called, which will lead to accessing of
> > > > > gserial->port and thus causing null pointer dereference.Add
> > > > > a null pointer check to prevent this.
> > > > > 
> > > > > Fixes: aba3a8d01d62 (" usb: gadget: u_serial: add suspend resume callbacks")
> > > > 
> > > > Nit, and our tools will complain, no " " before the "usb:" string here,
> > > > right?
> > > > 
> > > Will fix it in next patch.
> > > > 
> > > > 
> > > > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > > > > ---
> > > > >    drivers/usb/gadget/function/u_serial.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> > > > > index 840626e..98be2b8 100644
> > > > > --- a/drivers/usb/gadget/function/u_serial.c
> > > > > +++ b/drivers/usb/gadget/function/u_serial.c
> > > > > @@ -1428,6 +1428,9 @@ void gserial_resume(struct gserial *gser)
> > > > >    	struct gs_port *port = gser->ioport;
> > > > >    	unsigned long	flags;
> > > > > +	if (!port)
> > > > > +		return;
> > > > > +
> > > > 
> > > > What prevents port from going to NULL right after this check?
> > > In our case we got a null pointer de-reference while performing USB
> > > compliance tests, as the gser->port was null. Because in gserial_resume,
> > > spinlock_irq_save(&port->port_lock) accesses a null-pointer as port was
> > > already marked null by gserial_disconnect.
> > > 
> > > And after gserial_resume acquires the spinlock, gserial_disconnect cant mark
> > > it null until the spinlock is released. We need to check if the port->lock
> > > is valid before accessing it, otherwise it can lead to the above mentioned
> > > scenario
> > 
> > What happens if gserial_disconnect sets gser->port to NULL immediately
> > after your new check occurs, but before
> > spinlock_irq_save(&port->port_lock) gets called?
> > 
> > You may need to add a static spinlock to prevent this from happening.
> > 
> > Alan Stern
> In that case i guess we have to make port_lock a global variable and take it
> out of gs_port structure.
> 
> + static DEFINE_SPINLOCK(port_lock);
> 
> struct gs_port {
> 	struct tty_port port;
> -	spinlock_t port_lock;
> 
> This will require us to change all the spinlock(port->port_lock) used in
> u_serial.c, what do you suggest?

Yes, that would be the correct thing to do.
