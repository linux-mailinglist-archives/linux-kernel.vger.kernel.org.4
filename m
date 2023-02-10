Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC74A6925A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjBJSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjBJSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:46:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D97A7E4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:46:27 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pQYPg-0007he-2y; Fri, 10 Feb 2023 19:46:24 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pQYPf-0005N6-6j; Fri, 10 Feb 2023 19:46:23 +0100
Date:   Fri, 10 Feb 2023 19:46:23 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Message-ID: <20230210184623.GC10447@pengutronix.de>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
 <20230209101807.GO10447@pengutronix.de>
 <6d618e518de06854727f26de950404f02ec61c64.camel@crapouillou.net>
 <20230209114103.GQ10447@pengutronix.de>
 <Y+ULv1BpcrPWf5nN@rowland.harvard.edu>
 <20230210144940.GB10447@pengutronix.de>
 <Y+ZmsofmJPYRoUjW@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ZmsofmJPYRoUjW@rowland.harvard.edu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:45:54AM -0500, Alan Stern wrote:
> On Fri, Feb 10, 2023 at 03:49:41PM +0100, Sascha Hauer wrote:
> > On Thu, Feb 09, 2023 at 10:05:35AM -0500, Alan Stern wrote:
> > > Sascha:
> > > 
> > > When you first posted your original patch, I wondered if it was really 
> > > the right thing to do.  Making the net device not be a child of the UDC 
> > > device means you can (in theory) have strange behavior such as the 
> > > kernel suspending the USB device controller while expecting the network 
> > > interface to keep on working.
> > > 
> > > Is there a different way of solving the original problem?
> > 
> > I don't know which. One thing would be to couple the lifetime of the
> > ethernet device to the lifetime of the UDC, but the result would look
> > different to userspace, so wouldn't be ideal either.
> > 
> > Note the original reason doing this change was that we saw backtraces
> > when doing a 'reboot -f', the 'rmmod dummy_hcd' was just an easy
> > reproducer for the problem.
> > 
> > One other possibility might be to take a reference to the UDC while
> > it is in use so that the module can't be rmmoded. Not sure if that fixes
> > my original problem though.
> 
> Not being familiar with the networking code, I don't really understand 
> the original problem.  Does the use-after-free error occur when you try 
> to dereference a dev->parent pointer in the ethernet device?
> 
> If that's so, then taking a reference (i.e. get_device()) on the parent 
> device should fix the problem.
> 
> If not, maybe you can give a more detailed guide as to what's going 
> wrong.

I don't remember the details anymore. I'll do some more investigation
next week.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
