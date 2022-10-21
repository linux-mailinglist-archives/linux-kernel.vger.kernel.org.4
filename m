Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73D607138
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJUHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJUHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55623239201;
        Fri, 21 Oct 2022 00:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA88061DDD;
        Fri, 21 Oct 2022 07:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB284C433D7;
        Fri, 21 Oct 2022 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666337805;
        bh=qcoFQ3Y1t/OCn1xo7MF0G3Jg4ODkh6FFpJxwxnaf5dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZI/il1cIufXd8K1qI1xAjT1PC3P6iuEQ0DkEJHKU/tPFqixNUIMswm8t01ZxtRIh
         9mXPw1m0VK334fDfV108iafCJka7qzFFr1NUy6kVQc++k6xCFvkvvxNXnLxa5OJXjJ
         sHwpnVggKa0wSW7dMqiEg66Qm481cjX2xe9L43mc=
Date:   Fri, 21 Oct 2022 09:36:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y1JMCqv5QucIfNCS@kroah.com>
References: <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <CAHk-=wgdXRZy0-3v+vLZdDfRFKFXZLehgmR2QUKSemBA99sfmg@mail.gmail.com>
 <CAHk-=wjvp=ys2adnWwc1PNt3OrZ_0EkFaUcvjiVuOoVNjX_+AA@mail.gmail.com>
 <Y1JA0S7jvlA2573n@kroah.com>
 <CAHmME9ouSriPmMCQ3kfF01k4-D4hc7g22GE8m79gT5snqr7MSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ouSriPmMCQ3kfF01k4-D4hc7g22GE8m79gT5snqr7MSg@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 03:24:27AM -0400, Jason A. Donenfeld wrote:
> Hi Greg,
> 
> On Fri, Oct 21, 2022 at 2:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 20, 2022 at 01:17:33PM -0700, Linus Torvalds wrote:
> > > And in other cases, there's no actual difference at all, just
> > > different register usage, so the diff looks fairly big, but doesn't
> > > seem to be real.  In one case I looked at, it started with a 'movzbl',
> > > but it was that in both cases, because the type was actually 'unsigned
> > > char' to begin with. But for some reason it just used different
> > > registers. Example:
> > >
> > >  - handle_control_request() in drivers/usb/gadget/udc/dummy_hcd.c
> > >
> > >    The reason here *seems* to be that
> > >
> > >                         char *buf;
> > >                         buf = (char *)urb->transfer_buffer;
> > >
> > >    where it really probably should be 'u8 *buf', since it actually
> > > does a cast to 'u8' in one place, but there isn't even any read of
> > > that 'buf' pointer. So the difference seems to be entirely just some
> > > "different type in assignment" cast internal to gcc that then
> > > incidentally generated a random other choice in register allocation.
> >
> > I've send a patch for this now:
> >         https://lore.kernel.org/r/20221021064453.3341050-1-gregkh@linuxfoundation.org
> > and will take it through the USB tree, unless Jason wants to grab it
> > through his tree.
> 
> This doesn't appear to have any actual effect, but just changes gcc's
> register allocation unexpectedly. So feel free to take it, as it
> doesn't seem like it's "one of those bad cases" that I'm keeping track
> of.

Great, will take it through my tree, thanks!

greg k-h
