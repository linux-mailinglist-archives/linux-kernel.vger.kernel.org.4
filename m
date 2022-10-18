Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A9602E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiJROcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJROch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:32:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F0066C894B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:32:34 -0700 (PDT)
Received: (qmail 1213921 invoked by uid 1000); 18 Oct 2022 10:32:33 -0400
Date:   Tue, 18 Oct 2022 10:32:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dan Scally <dan.scally@ideasonboard.com>
Cc:     Dan Vacura <w36195@motorola.com>, linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 6/6] usb: gadget: uvc: add configfs option for sg
 support
Message-ID: <Y065ASuFhM9bntvd@rowland.harvard.edu>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-7-w36195@motorola.com>
 <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:27:13PM +0100, Dan Scally wrote:
> Hi Dan
> 
> On 17/10/2022 21:54, Dan Vacura wrote:
> > The scatter gather support doesn't appear to work well with some UDC hw.
> > Add the ability to turn on the feature depending on the controller in
> > use.
> > 
> > Signed-off-by: Dan Vacura <w36195@motorola.com>
> 
> 
> Nitpick: I would call it use_sg everywhere, but either way:
> 
> 
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> 
> Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
> 
> > ---
> > V1 -> V2:
> > - no change, new patch in serie
> > V2 -> V3:
> > - default on, same as baseline
> > 
> >   Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
> >   Documentation/usb/gadget-testing.rst              | 2 ++
> >   drivers/usb/gadget/function/f_uvc.c               | 2 ++
> >   drivers/usb/gadget/function/u_uvc.h               | 1 +
> >   drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
> >   drivers/usb/gadget/function/uvc_queue.c           | 4 ++--
> >   6 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > index 5dfaa3f7f6a4..839a75fc28ee 100644
> > --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > @@ -9,6 +9,7 @@ Description:	UVC function directory
> >   		streaming_interval	1..16
> >   		function_name		string [32]
> >   		req_int_skip_div	unsigned int
> > +		sg_supported		0..1
> >   		===================	=============================
> >   What:		/config/usb-gadget/gadget/functions/uvc.name/control
> > diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> > index f9b5a09be1f4..8e3072d6a590 100644
> > --- a/Documentation/usb/gadget-testing.rst
> > +++ b/Documentation/usb/gadget-testing.rst
> > @@ -796,6 +796,8 @@ The uvc function provides these attributes in its function directory:
> >   	function_name       name of the interface
> >   	req_int_skip_div    divisor of total requests to aid in calculating
> >   			    interrupt frequency, 0 indicates all interrupt
> > +	sg_supported        allow for scatter gather to be used if the UDC
> > +			    hw supports it

Why is a configuration option needed for this?  Why not always use SG 
when the UDC supports it?  Or at least, make the decision automatically 
(say, based on the amount of data to be transferred) with no need for 
any user input?

Is this because the SG support in some UDC drivers is buggy?  In that 
case the proper approach is to fix the UDC drivers, not add new options 
that users won't know when to use.

Or is it because the UDC hardware itself is buggy?  In that case the 
best approach is to fix the UDC drivers so that they don't advertise 
working SG support when the hardware is unable to handle it.

Alan Stern
