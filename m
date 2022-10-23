Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC0609494
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiJWQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJWQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:04:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3EB4BD;
        Sun, 23 Oct 2022 09:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82747B80D4F;
        Sun, 23 Oct 2022 16:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90271C433C1;
        Sun, 23 Oct 2022 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666541066;
        bh=hH28WnDvFDE2qfWdV6HVPtVEhC+usBQqGVk2hARPGUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jP1bTPF1VXIqGUgmuH7MRHbmOyGLatP3s7xtbkaKandIC3ZjDqehXjVJHMGerF4LO
         kNF2UoMxmtBeg0Flktjsb+B3OB8kufqYsBa95EoH/hWsXTPOFUDijEPdvkvHCZgTY7
         fxDWCwaguqGmQAXEVhTXmAJD40BYJvdD05aMPqe4=
Date:   Sun, 23 Oct 2022 18:04:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
Message-ID: <Y1VmBuVrkL7MSzjY@kroah.com>
References: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
 <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
 <Y1Vjb9v2ggSjhRbc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Vjb9v2ggSjhRbc@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Along these lines, do we really not have a predefined macro/inline
function that does:
	(value >> 8)
to give you the "high byte" of a 16bit value?  I keep seeing people
write their own macros for this in staging drivers, but I just
attributed that to them not using the correct in-kernel macro, but I
can't seem to find anything at the moment to do this (same with "give me
just the lower 8 bits of a 16bit value").

Am I just blind?

It's not like it's complex or tricky stuff, I just thought we had
something in bits.h or bitops.h or the like.  Oh well...

thanks,

greg k-h
