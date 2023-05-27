Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278EB7135BB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjE0QhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE0QhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:37:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 65CB4BB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:36:59 -0700 (PDT)
Received: (qmail 327854 invoked by uid 1000); 27 May 2023 12:36:58 -0400
Date:   Sat, 27 May 2023 12:36:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        francesco@dolcini.it, alistair@alistair23.me, stephan@gerhold.net,
        bagasdotme@gmail.com, luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler
 processing
Message-ID: <406371f0-db48-4195-b85d-b75ce83e738b@rowland.harvard.edu>
References: <20230519043041.1593578-1-badhri@google.com>
 <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
 <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
 <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com>
 <547ecbb2-921d-4714-82b7-066202ccf292@rowland.harvard.edu>
 <CAPTae5J=VGeHNio0XAj=trrwqXWgGCiwcSaKsxQ4H_9j2mCVXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5J=VGeHNio0XAj=trrwqXWgGCiwcSaKsxQ4H_9j2mCVXA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 07:42:39PM -0700, Badhri Jagan Sridharan wrote:
> Thanks again Alan !
> 
> On Mon, May 22, 2023 at 8:55 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Getting back to your first point, it looks like we need to assume any
> > routine that needs to communicate with the UDC hardware (such as the
> > ->pullup callback used in usb_gadget_{dis}connect()) must always be
> > called in process context.  This means that usb_udc_connect_control()
> > always has to run in process context, since it will do either a connect
> > or a disconnect.
> >
> > On the other hand, some routines -- in particular,
> > usb_udc_vbus_handler() -- may be called by a UDC driver's interrupt
> > handler and therefore may run in interrupt context.  (This fact should
> > be noted in that routine's kerneldoc, by the way.)
> >
> > So here's the problem: usb_udc_vbus_handler() running in interrupt
> > context calls usb_udc_connect_control(), which has to run in process
> > context.  And this is not just a simple issue caused by the
> > ->disconnect() callback or use of mutexes; it's more fundamental.
> >
> > I'm led to conclude that you were right to offload part of
> > usb_udc_vbus_handler()'s job to a workqueue.  It's an awkward thing to
> > do, because you have to make sure to cancel the work item at times when
> > it's no longer needed.  But there doesn't seem to be any other choice.
> >
> > Here's two related problems for you to think about:
> >
> >     1.  Once gadget_unbind_driver() has called usb_gadget_disconnect(),
> >         we don't want a VBUS change to cause usb_udc_vbus_handler()'s
> >         work routine to turn the pullup back on.  How can we prevent
> >         this?
> >
> >     2.  More generally, suppose usb_udc_vbus_handler() gets called at
> >         exactly the same time that some other pathway (either
> >         gadget_bind_driver() or soft_connect_store()) tries to do a
> >         connect or disconnect.  What should happen then?
> 
> 
> I believe I can solve the above races by protecting the flags set by
> each of them with connect_lock and not pulling up unless all of them
> are true.
> 
> The caller will hold connect_lock, update the respective flag and
> invoke the below usb_gadget_pullup_update_locked function(shown
> below).

Are you certain this can be done without causing any deadlocks?

> Code stub:
> /* Internal version of usb_gadget_connect needs to be called with
> connect_lock held. */
> static int usb_gadget_pullup_update_locked(struct usb_gadget *gadget)
>         __must_hold(&gadget->udc->connect_lock)
> {
>         int ret = 0;
>         bool connect = !gadget->deactivated && gadget->udc->started &&
> gadget->udc->vbus &&
>                              gadget->udc->allow_connect;

On further thought, I decided "allow_connect" is a dumb name.  Let's 
call it "unbinding" instead, since it gets set only when a gadget driver 
is about to be unbound (which is when we want to prevent new 
connections).

>         if (!gadget->ops->pullup) {
>                 ret = -EOPNOTSUPP;
>                 goto out;
>         }
> 
>         if (connect != gadget->connected) {

You need to be more careful here.  It's possible to have 
gadget->connected set at the same time as gadget->deactivated -- it 
means that when the gadget gets re-activated, it will immediately try to 
connect again.

In fact, this logic doesn't look right at all.  For example, suppose the 
gadget driver wants to disconnect.  This routine will compute connect = 
true and will see that gadget->connected is set, so it won't do 
anything!

I think it would be better just to merge the new material into 
usb_gadget_connect() and usb_gadget_disconnect().

>                 ret = gadget->ops->pullup(gadget, connect);
>                 if (!ret)
>                         gadget->connected = connect;
>                 if (!connect) {
>                         mutex_lock(&udc_lock);
>                         if (gadget->udc->driver)
>                                 gadget->udc->driver->disconnect(gadget);
>                         mutex_unlock(&udc_lock);
>         }
> 
> out:
>         trace_usb_gadget_connect(gadget, ret);
> 
>         return ret;
> }
> 
> However, while auditing the code again, I noticed another potential
> race as well:
> Looks like usb_del_gadget() can potentially race against
> usb_udc_vbus_handler() and call device_unregister.
> This implies usb_udc can be freed while usb_udc_vbus_handler() or the
> work item is executing.
> 
> void usb_del_gadget(struct usb_gadget *gadget)
> {
>         struct usb_udc *udc = gadget->udc;
> 
> ..
> ...
>         device_unregister(&udc->dev);
> }
> EXPORT_SYMBOL_GPL(usb_del_gadget);
> 
> Does this look like a valid concern to you or am I misunderstanding this ?

You're missing an important point.  Before doing device_unregister(), 
this routine calls device_del(&gadget->dev).  That will unbind the 
gadget driver, which (among other things) will stop the UDC, preventing 
it from calling usb_udc_vbus_handler().  However, you're right that the 
work item will need to be cancelled at some point before the usb_udc is 
unregistered.

> If so, I am afraid that the only way to solve this is by synchronizing
> usb_udc_vbus_handler() against usb_del_gadget() through a mutex as
> device_unregister() can sleep.
> So offloading usb_udc_vbus_handler() cannot work either.
> 
> usb_udc_vbus_hander() seems to be invoked from the following drivers:
> 
> 1. drivers/usb/chipidea/udc.c:
> usb_udc_vbus_hander()  is called from a non-atomic context.
> 
> 2. drivers/usb/gadget/udc/max3420_udc.c
> usb_udc_vbus_hander()  is called from the interrupt handler.
> However, all the events are processed from max3420_thread kthread.
> So I am thinking of making them threaded irq handlers instead.
> 
> 3. drivers/usb/gadget/udc/renesas_usbf.c
> This one looks more invasive. However, still attempting to move them
> to threaded irq handlers.
> 
> As always, I'm looking forward to your feedback !

Moving those things to threaded IRQ handlers is a separate job.  Let's 
get this issue fixed first.

Alan Stern
