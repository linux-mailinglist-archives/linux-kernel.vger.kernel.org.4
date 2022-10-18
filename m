Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B12602F99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJRPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJRPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:23:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2F77FD01AA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:23:49 -0700 (PDT)
Received: (qmail 1216402 invoked by uid 1000); 18 Oct 2022 11:23:48 -0400
Date:   Tue, 18 Oct 2022 11:23:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dan Vacura <w36195@motorola.com>
Cc:     Dan Scally <dan.scally@ideasonboard.com>,
        linux-usb@vger.kernel.org,
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
Message-ID: <Y07FBDIQKEysy+lF@rowland.harvard.edu>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-7-w36195@motorola.com>
 <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
 <Y065ASuFhM9bntvd@rowland.harvard.edu>
 <Y07C7hYKyByahNjL@p1g3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07C7hYKyByahNjL@p1g3>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:14:54AM -0500, Dan Vacura wrote:
> Hi Alan,
> 
> On Tue, Oct 18, 2022 at 10:32:33AM -0400, Alan Stern wrote:
> > On Tue, Oct 18, 2022 at 02:27:13PM +0100, Dan Scally wrote:
> > > Hi Dan

> > > > --- a/Documentation/usb/gadget-testing.rst
> > > > +++ b/Documentation/usb/gadget-testing.rst
> > > > @@ -796,6 +796,8 @@ The uvc function provides these attributes in its function directory:
> > > >   	function_name       name of the interface
> > > >   	req_int_skip_div    divisor of total requests to aid in calculating
> > > >   			    interrupt frequency, 0 indicates all interrupt
> > > > +	sg_supported        allow for scatter gather to be used if the UDC
> > > > +			    hw supports it
> > 
> > Why is a configuration option needed for this?  Why not always use SG 
> > when the UDC supports it?  Or at least, make the decision automatically 
> > (say, based on the amount of data to be transferred) with no need for 
> > any user input?
> 
> Patches for a fix and to select to use SG depending on amount of data
> are already submitted and under review. I agree, ideally we don't need
> this patch, but there have been several regressions uncovered with
> enabling this support and it takes time to root cause these issues.

Please put this information into the patch description, and maybe also 
into the documentation file.  For your readers' and reviewers' sake it's 
important -- probably _more_ important -- to explain why you're making a 
change than what that change is.

Alan Stern

> In my specific environment, Android GKI 2.0, changes need to get
> upstreamed first here before they're pulled into Android device
> software. Having this logic in place gives us the ability to turn off
> this functionality without going through this process. A revert was also
> considered until all the bugs are resolved, but the code is quite
> entrenched now to take out, plus others seem to benefit from it being
> enabled. Thus the configurability.
