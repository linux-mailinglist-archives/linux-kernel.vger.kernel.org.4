Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DC6F1D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjD1Rco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjD1Rcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:32:42 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BB8CB4203
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:32:38 -0700 (PDT)
Received: (qmail 213655 invoked by uid 1000); 28 Apr 2023 13:32:37 -0400
Date:   Fri, 28 Apr 2023 13:32:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Subject: Re: [PATCH v2 2/2] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
Message-ID: <55ef9051-716d-4aaf-b994-e0beaecc48a3@rowland.harvard.edu>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-3-quic_kriskura@quicinc.com>
 <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 06:47:13AM +0530, Krishna Kurapati PSSNV wrote:
> Hi Alan, Geert,
> 
>  Can you help review and provide comments/approval on the following patch.
> 
> Regards,
> Krishna,

Sorry this took so long to review; I've been quite busy.

The patch is good except for one stylistic thing...

> On 3/28/2023 9:37 PM, Krishna Kurapati wrote:
> > In the event, gadget_connect call (which invokes pullup) fails,
> > propagate the error to udc bind operation which inturn sends the
> > error to configfs. The userspace can then retry enumeartion if
> > it chooses to.
> > 
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > ---
> >   drivers/usb/gadget/udc/core.c | 20 ++++++++++++++++----
> >   1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index 23b0629a8774..975205a1853f 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -1051,12 +1051,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
> >   /* ------------------------------------------------------------------------- */
> > -static void usb_udc_connect_control(struct usb_udc *udc)
> > +static int usb_udc_connect_control(struct usb_udc *udc)
> >   {
> > +	int ret;
> > +
> >   	if (udc->vbus)
> > -		usb_gadget_connect(udc->gadget);
> > +		ret = usb_gadget_connect(udc->gadget);
> >   	else
> > -		usb_gadget_disconnect(udc->gadget);
> > +		ret = usb_gadget_disconnect(udc->gadget);
> > +
> > +	return ret;
> >   }
> >   /**
> > @@ -1500,11 +1504,19 @@ static int gadget_bind_driver(struct device *dev)
> >   	if (ret)
> >   		goto err_start;
> >   	usb_gadget_enable_async_callbacks(udc);
> > -	usb_udc_connect_control(udc);
> > +	ret = usb_udc_connect_control(udc);
> > +	if (ret)
> > +		goto err_connect_control;
> >   	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> >   	return 0;
> > + err_connect_control:

For consistency with the other error-handling statement labels in this 
routine, there should be a blank line immediately before this label.

> > +	usb_gadget_disable_async_callbacks(udc);
> > +	if (gadget->irq)
> > +		synchronize_irq(gadget->irq);
> > +	usb_gadget_udc_stop(udc);
> > +
> >    err_start:
> >   	driver->unbind(udc->gadget);

Everything else looks okay.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
