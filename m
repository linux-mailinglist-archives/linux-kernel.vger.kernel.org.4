Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AFE6C9CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjC0HvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjC0HvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:51:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDD4233
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:51:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pghcr-0003Wv-70; Mon, 27 Mar 2023 09:50:45 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pghcq-0003UX-As; Mon, 27 Mar 2023 09:50:44 +0200
Date:   Mon, 27 Mar 2023 09:50:44 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: gadget: lower informal user notifaction
 dequeue operation
Message-ID: <20230327075044.qcvdwou57lb5vyqc@pengutronix.de>
References: <20230323171931.4085496-1-m.felsch@pengutronix.de>
 <20230323234103.mx7f3pzvbrrguzqe@synopsys.com>
 <20230324083603.vkbnyygx645fcfxl@pengutronix.de>
 <20230324172413.lpd3cces7byoe7tk@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324172413.lpd3cces7byoe7tk@synopsys.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-24, Thinh Nguyen wrote:
> On Fri, Mar 24, 2023, Marco Felsch wrote:
> > Hi,
> > 
> > On 23-03-23, Thinh Nguyen wrote:
> > > Hi,
> > > 
> > > On Thu, Mar 23, 2023, Marco Felsch wrote:
> > > > Printing an error message during usb_ep_dequeue() is more confusing than
> > > > helpful since the usb_ep_dequeue() could be call during unbind() just
> > > > in case that everything is canceld before unbinding the driver. Lower
> > > > the dev_err() message to dev_dbg() to keep the message for developers.
> > > > 
> > > > Fixes: fcd2def66392 ("usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue")
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >  drivers/usb/dwc3/gadget.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > > > index 89dcfac01235f..6699db26cc7b5 100644
> > > > --- a/drivers/usb/dwc3/gadget.c
> > > > +++ b/drivers/usb/dwc3/gadget.c
> > > > @@ -2106,7 +2106,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
> > > >  		}
> > > >  	}
> > > >  
> > > > -	dev_err(dwc->dev, "request %pK was not queued to %s\n",
> > > > +	dev_dbg(dwc->dev, "request %pK was not queued to %s\n",
> > > >  		request, ep->name);
> > > >  	ret = -EINVAL;
> > > >  out:
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > How were you able to reproduce this error message?
> > 
> > We use the driver within barebox where we do have support for fastboot.
> > During the driver unbind usb_ep_dequeue() is called which throw this
> > error.
> 
> I mean which gadget/function driver did you use.

As I have written, the fastboot driver within barebox.

> > > During unbind(), the function driver would typically call to
> > > usb_ep_disable(). Before the call usb_ep_disable() completes, all queued
> > > and incompleted requests are expected to be returned with -ESHUTDOWN.
> > 
> > So the unbind() function driver should use usb_ep_disable() instead of
> > usb_ep_dequeue()?
> 
> No, it can do whatever it wants. I'm just pointing out the typical
> behavior when this case happens during unbind().

Okay.

> > > For you to see this error, this means that the function driver issued
> > > usb_ep_dequeue() to an already disabled endpoint, and the request was
> > > probably already given back.
> > 
> > The unbind() just calls usb_ep_dequeue() which isn't forbidden according
> > the API doc. We just want to ensure that the request is cancled if any.
> 
> It's not forbidden, and it's not unexpected for this message to be
> generated if usb_ep_dequeue() is called after usb_ep_disable().

Exactly that happened: usb_ep_disable() called in front of the
usb_ep_dequeue(). Thanks to your first response which explained the
behaviour, since I'm not that familiar with the gadget stack.

> However, knowing the behavior of usb_ep_disable(), does it make sense
> to call usb_ep_dequeue() after usb_ep_disable() completes? (I'm
> assuming this is what happened in your case from the commit
> description).

Nope and therefore we removed it.

> > > Even though this error message is not critical and shouldn't affect the
> > > driver's behavior, it's better to fix the function driver to handle this
> > > race.
> > 
> > As you have pointed out: 'it is not criticial' and therefore we shouldn't
> > use dev_err() for non crictical information since this can cause
> > user-space confusion.
> 
> I noted this particular case that it's not critical because we know
> where/when it happened because you pointed out that it occurs during
> unbind(). However, in any case, we want to notify that the
> usb_ep_dequeue() was used on a wrong request, allowing the user to
> review and fix this if needed.

Right, thanks for your input. Please ignore this patch.

Regards,
  Marco


> 
> Thanks,
> Thinh
