Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3469228F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjBJPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBJPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:45:56 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B242A2004E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:45:55 -0800 (PST)
Received: (qmail 816679 invoked by uid 1000); 10 Feb 2023 10:45:54 -0500
Date:   Fri, 10 Feb 2023 10:45:54 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Message-ID: <Y+ZmsofmJPYRoUjW@rowland.harvard.edu>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
 <20230209101807.GO10447@pengutronix.de>
 <6d618e518de06854727f26de950404f02ec61c64.camel@crapouillou.net>
 <20230209114103.GQ10447@pengutronix.de>
 <Y+ULv1BpcrPWf5nN@rowland.harvard.edu>
 <20230210144940.GB10447@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210144940.GB10447@pengutronix.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:49:41PM +0100, Sascha Hauer wrote:
> On Thu, Feb 09, 2023 at 10:05:35AM -0500, Alan Stern wrote:
> > Sascha:
> > 
> > When you first posted your original patch, I wondered if it was really 
> > the right thing to do.  Making the net device not be a child of the UDC 
> > device means you can (in theory) have strange behavior such as the 
> > kernel suspending the USB device controller while expecting the network 
> > interface to keep on working.
> > 
> > Is there a different way of solving the original problem?
> 
> I don't know which. One thing would be to couple the lifetime of the
> ethernet device to the lifetime of the UDC, but the result would look
> different to userspace, so wouldn't be ideal either.
> 
> Note the original reason doing this change was that we saw backtraces
> when doing a 'reboot -f', the 'rmmod dummy_hcd' was just an easy
> reproducer for the problem.
> 
> One other possibility might be to take a reference to the UDC while
> it is in use so that the module can't be rmmoded. Not sure if that fixes
> my original problem though.

Not being familiar with the networking code, I don't really understand 
the original problem.  Does the use-after-free error occur when you try 
to dereference a dev->parent pointer in the ethernet device?

If that's so, then taking a reference (i.e. get_device()) on the parent 
device should fix the problem.

If not, maybe you can give a more detailed guide as to what's going 
wrong.

Alan Stern
