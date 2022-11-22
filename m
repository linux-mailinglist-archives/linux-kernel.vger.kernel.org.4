Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E15634120
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiKVQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiKVQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:13:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20377990F;
        Tue, 22 Nov 2022 08:12:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E126179B;
        Tue, 22 Nov 2022 16:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585A8C43470;
        Tue, 22 Nov 2022 16:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669133537;
        bh=CZmpOpNqrVQxpsX2fOGYDMBNpPg1FLHDxqQLqoO0bqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zip4tUr9yFB5O2ebDQ+Ck/H8fHgwdROhGTZF1crB2aWWd/iVYRyLnWNhXnGgKD2TG
         UycnVuO6xCxhI+gmui4Yr8BM+8HNrffTocfEL1Vmwdy6IE/DVPKrljZT+j4KtfVVL4
         1DkPHDja6fBYphckk3zqUGVYaaRuawgZhoqJ1Cpo=
Date:   Tue, 22 Nov 2022 17:12:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] USB: gadget: dummy_hcd: switch char * to u8 *
Message-ID: <Y3z03sS65YKgvI5R@kroah.com>
References: <20221109084450.2181848-1-gregkh@linuxfoundation.org>
 <Y2vBWJOgEBDn0NzU@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2vBWJOgEBDn0NzU@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:03:52AM -0500, Alan Stern wrote:
> On Wed, Nov 09, 2022 at 09:44:50AM +0100, Greg Kroah-Hartman wrote:
> > The function handle_control_request() casts the urb buffer to a char *,
> > and then treats it like a unsigned char buffer when assigning data to
> > it.  On some architectures, "char" is really signed, so let's just
> > properly set this pointer to a u8 to take away any potential problems as
> > that's what is really wanted here.
> > 
> > Use put_unaligned_le16() to copy the full 16bits into the buffer,
> > it's not a problem just yet as only 7 bits are being used here, but this
> > protects us when/if the USB spec changes in the future to define more of
> > these bits.
> > 
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Jakob Koschel <jakobkoschel@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: - use put_unaligned_le16() on Linus's recommendation as a simpler and
> >       more obvious way to describe the data being copied here.
> >     - update device: comment based on Alan's review
> > 
> >  drivers/usb/gadget/udc/dummy_hcd.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> > index 899ac9f9c279..7c59c20c8623 100644
> > --- a/drivers/usb/gadget/udc/dummy_hcd.c
> > +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> > @@ -1740,13 +1740,13 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
> >  		if (setup->bRequestType == Dev_InRequest
> >  				|| setup->bRequestType == Intf_InRequest
> >  				|| setup->bRequestType == Ep_InRequest) {
> > -			char *buf;
> > +			u8 *buf;
> >  			/*
> > -			 * device: remote wakeup, selfpowered
> > +			 * device: remote wakeup, selfpowered, LTM, U1, or U2
> >  			 * interface: nothing
> >  			 * endpoint: halt
> >  			 */
> > -			buf = (char *)urb->transfer_buffer;
> > +			buf = urb->transfer_buffer;
> >  			if (urb->transfer_buffer_length > 0) {
> >  				if (setup->bRequestType == Ep_InRequest) {
> >  					ep2 = find_endpoint(dum, w_index);
> > @@ -1755,10 +1755,9 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
> >  						break;
> >  					}
> >  					buf[0] = ep2->halted;
> > -				} else if (setup->bRequestType ==
> > -					   Dev_InRequest) {
> > -					buf[0] = (u8)dum->devstatus;
> > -				} else
> > +				} else if (setup->bRequestType == Dev_InRequest)
> > +					put_unaligned_le16(dum->devstatus, buf);
> 
> This is tempting but wrong.  At this point we haven't checked how big 
> the transfer_buffer is; if it is only one byte long then this call will 
> overflow the buffer.  Notice the "if" statement three lines below.

Ick, good catch.  I'll redo this again...

thanks,

greg k-h
