Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FA76094D9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJWQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJWQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:46:12 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3138348E81
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:46:10 -0700 (PDT)
Received: (qmail 1382441 invoked by uid 1000); 23 Oct 2022 12:46:10 -0400
Date:   Sun, 23 Oct 2022 12:46:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
Message-ID: <Y1Vv0tJZoSeqX003@rowland.harvard.edu>
References: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
 <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
 <Y1Vjb9v2ggSjhRbc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Vjb9v2ggSjhRbc@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 05:53:19PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 21, 2022 at 10:30:37AM -0700, Linus Torvalds wrote:
> > On Thu, Oct 20, 2022 at 11:44 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > The function handle_control_request() casts the urb buffer to a char *,
> > > and then treats it like a unsigned char buffer when assigning data to
> > > it.  On some architectures, "char" is really signed, so let's just
> > > properly set this pointer to a u8 to take away any potential problems as
> > > that's what is really wanted here.
> > 
> > I think you might as well also remove the cast that was always a bit odd:
> > 
> >                 buf[0] = (u8)dum->devstatus;
> > 
> > although maybe it's intentional ("look, ma, I'm truncating this
> > value") because 'devstatus' is a 'u16' type?
> 
> (adding Alan as he's the owner of this file now)
> 
> Yes, devstatus is a u16 as that's what the USB spec says it should be,
> but so far only 7 of the lower bits have been used.  I guess to do this
> properly we should also copy the upper 8 bits in to buf[1], eventhough
> in reality it's only ever going to be 0x00 for now.

I count only 5 of the bits being used, not 7.  (See Figure 9-4 in 
section 9.4.5 of the USB-3.1 spec.)  Maybe you're thinking of Feature 
flags rather than Status bits?  They do have a lot of overlap.

Dave Brownell wrote that code initially, so we'll never know why he 
included the cast.  My guess is the same as Linus's: It's there to alert 
the reader that a 16-bit value is being shortened to squeeze into an 
8-bit slot.

> Although if we ever do get another 2 status bits defined, this code will
> break so we probably should do that too.
> 
> I'll go do that for a v2 of this and properly comment it.

Note that there's an out-of-date comment line just above this part of 
the code:

		 * device: remote wakeup, selfpowered

Thanks to USB-3 support, the device recipient now defines three more 
bits in devstatus: LTM_ENABLED, U1_ENABLED, and U2_ENABLED.

Alan Stern
