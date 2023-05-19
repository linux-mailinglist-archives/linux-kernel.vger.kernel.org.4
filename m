Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F4A709DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjESR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjESR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:27:31 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A5984A6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:27:29 -0700 (PDT)
Received: (qmail 45355 invoked by uid 1000); 19 May 2023 13:27:28 -0400
Date:   Fri, 19 May 2023 13:27:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler
 processing
Message-ID: <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
References: <20230519043041.1593578-1-badhri@google.com>
 <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 08:44:57AM -0700, Badhri Jagan Sridharan wrote:
> On Fri, May 19, 2023 at 8:07 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, May 19, 2023 at 10:49:49AM -0400, Alan Stern wrote:
> > > On Fri, May 19, 2023 at 04:30:41AM +0000, Badhri Jagan Sridharan wrote:
> > > > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > > > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> > > > processing.
> > >
> > > Look, this is way overkill.
> > >
> > > usb_udc_vbus_handler() has only two jobs to do: set udc->vbus and call
> > > usb_udc_connect_control().  Furthermore, it gets called from only two
> > > drivers: chipidea and max3420.
> > >
> > > Why not have the callers set udc->vbus themselves and then call
> > > usb_gadget_{dis}connect() directly?  Then we could eliminate
> > > usb_udc_vbus_handler() entirely.  And the unnecessary calls -- the ones
> > > causing deadlocks -- from within udc_start() and udc_stop() handlers can
> > > be removed with no further consequence.
> > >
> > > This approach simplifies and removes code.  Whereas your approach
> > > complicates and adds code for no good reason.
> >
> > I changed my mind.
> >
> > After looking more closely, I found the comment in gadget.h about
> > ->disconnect() callbacks happening in interrupt context.  This means we
> > cannot use a mutex to protect the associated state, and therefore the
> > connect_lock _must_ be a spinlock, not a mutex.
> 
> Quick observation so that I don't misunderstand.
> I already see gadget->udc->driver->disconnect(gadget) being called with
> udc_lock being held.
> 
>                mutex_lock(&udc_lock);
>                if (gadget->udc->driver)
>                        gadget->udc->driver->disconnect(gadget);
>                mutex_unlock(&udc_lock);
> 
> The below patch seems to have introduced it:
> 1016fc0c096c USB: gadget: Fix obscure lockdep violation for udc_mutex

Hmmm...  You're right about this.  A big problem with the USB gadget 
framework is that it does not clearly state which routines have to run 
in process context and which have to run in interrupt/atomic context.  
People therefore don't think about it and frequently get it wrong.

So now the problem is that the UDC or transceiver driver may detect 
(typically in an interrupt handler) that VBUS power has appeared or 
disappeared, and it wants to tell the core to adjust the D+/D- pullup 
signals appropriately.  The core notifies the UDC driver about this, and 
then in the case of a disconnection, it has to notify the gadget driver.  
But notifying the gadget driver requires process context for the 
udc_lock mutex, the ultimate reason being that disconnect notifications 
can race with gadget driver binding and unbinding.

If we could prevent those races in some other way then we wouldn't need 
to hold udc_lock in usb_gadget_disconnect().  This seems like a sensible 
thing to do in any case; the UDC core should never allow a connection to 
occur before a gadget driver is bound or after it is unbound.

The first approach that occurs to me is to add a boolean allow_connect 
flag to struct usb_udc, together with a global spinlock to synchronize 
access to it.  Then usb_gadget_disconnect() could check the flag before 
calling driver->disconnect(), gadget_bind_driver() could set the flag 
before calling usb_udc_connect_control(), and gadget_unbind_driver() 
could clear the flag before calling usb_gadget_disconnect().

(Another possible approach would be to change gadget->deactivated into a 
counter.  It would still need to be synchronized by a spinlock, 
however.)

This will simplify matters considerably.  udc_lock can remain a mutex 
and the deadlock problem should go away.

Do you want to try adding allow_connect as described here or would you 
prefer that I do it?

(And in any case, we should prevent the udc_start and udc_stop callbacks 
in the chipidea and max3420 drivers from trying to update the connection 
status.)

Alan Stern
