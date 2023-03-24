Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD26C79ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCXIgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCXIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:36:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A37925B96
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:36:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pfcu5-0003BF-6n; Fri, 24 Mar 2023 09:36:05 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pfcu3-0004LI-Op; Fri, 24 Mar 2023 09:36:03 +0100
Date:   Fri, 24 Mar 2023 09:36:03 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: gadget: lower informal user notifaction
 dequeue operation
Message-ID: <20230324083603.vkbnyygx645fcfxl@pengutronix.de>
References: <20230323171931.4085496-1-m.felsch@pengutronix.de>
 <20230323234103.mx7f3pzvbrrguzqe@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323234103.mx7f3pzvbrrguzqe@synopsys.com>
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

Hi,

On 23-03-23, Thinh Nguyen wrote:
> Hi,
> 
> On Thu, Mar 23, 2023, Marco Felsch wrote:
> > Printing an error message during usb_ep_dequeue() is more confusing than
> > helpful since the usb_ep_dequeue() could be call during unbind() just
> > in case that everything is canceld before unbinding the driver. Lower
> > the dev_err() message to dev_dbg() to keep the message for developers.
> > 
> > Fixes: fcd2def66392 ("usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/usb/dwc3/gadget.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 89dcfac01235f..6699db26cc7b5 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2106,7 +2106,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
> >  		}
> >  	}
> >  
> > -	dev_err(dwc->dev, "request %pK was not queued to %s\n",
> > +	dev_dbg(dwc->dev, "request %pK was not queued to %s\n",
> >  		request, ep->name);
> >  	ret = -EINVAL;
> >  out:
> > -- 
> > 2.30.2
> > 
> 
> How were you able to reproduce this error message?

We use the driver within barebox where we do have support for fastboot.
During the driver unbind usb_ep_dequeue() is called which throw this
error.

> During unbind(), the function driver would typically call to
> usb_ep_disable(). Before the call usb_ep_disable() completes, all queued
> and incompleted requests are expected to be returned with -ESHUTDOWN.

So the unbind() function driver should use usb_ep_disable() instead of
usb_ep_dequeue()?

> For you to see this error, this means that the function driver issued
> usb_ep_dequeue() to an already disabled endpoint, and the request was
> probably already given back.

The unbind() just calls usb_ep_dequeue() which isn't forbidden according
the API doc. We just want to ensure that the request is cancled if any.

> Even though this error message is not critical and shouldn't affect the
> driver's behavior, it's better to fix the function driver to handle this
> race.

As you have pointed out: 'it is not criticial' and therefore we shouldn't
use dev_err() for non crictical information since this can cause
user-space confusion.

Regards,
  Marco

> 
> Thanks,
> Thinh
