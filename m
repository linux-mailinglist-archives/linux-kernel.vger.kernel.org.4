Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45B606BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJTWzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJTWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:55:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B6EA6B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6VyHB2mpLc7BFJBIg1MpS4fR1ENCvjLPztkC/qwZDhU=; b=CvXb4BgSCUD0xdnk+d/zfEFo2M
        d6SuQ3xJpfCddMYFWrxlizI77feC3+SiB1yLf8xewtNqIl+UyyQ9gJtNmUxfbzIEE3YvtkUQeJMpA
        4t3iRAXqNIdVIhsg3FyJsYZgUzIhQh19QX27yHUuqrZYssUh92IzZgmNRvPtCHIEcAT0HXT8wv68O
        rVL9xaRZ93znzq045hxM+Gu65S7zQENonYxw5mIP5OfUgmjEx+YJA/Nu1iHLTbwhMk541opJdQ5qh
        0gTRoNz+sAWdYGgTUvAqcAJCoijWGC/NQ7j0IemIn4SeLivUSU0qqq5CphDJ77Zi0Au5OsWWYjL+O
        eEY3WuyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34840)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oleRL-000803-08; Thu, 20 Oct 2022 23:55:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oleRI-0003YW-GO; Thu, 20 Oct 2022 23:55:00 +0100
Date:   Thu, 20 Oct 2022 23:55:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH 0/2] Switch ARM to generic find_bit() API
Message-ID: <Y1HRxNpxYcFHf/8R@shell.armlinux.org.uk>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
 <Y1F8ljDDqYElE3aT@shell.armlinux.org.uk>
 <Y1GpP+aY0o40MTNS@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GpP+aY0o40MTNS@yury-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:02:07PM -0700, Yury Norov wrote:
> On Thu, Oct 20, 2022 at 05:51:34PM +0100, Russell King (Oracle) wrote:
> > On Wed, Oct 19, 2022 at 08:20:22PM -0700, Yury Norov wrote:
> > > Hi Russell, all,
> > > 
> > > I'd like to respin a patch that switches ARM to generic find_bit()
> > > functions.
> > > 
> > > Generic code works on par with arch or better, according to my
> > > testing [1], and with recent improvements merged in v6.1, it should
> > > be even faster.
> > > 
> > > ARM already uses many generic find_bit() functions - those that it
> > > doesn't implement. So we are talking about migrating a subset of the
> > > API; most of find_bit() family has only generic implementation on ARM.
> > > 
> > > The only concern about this migration is that ARM code supports
> > > byte-aligned bitmap addresses, while generic code is optimized for
> > > word-aligned bitmaps.
> > > 
> > > In my practice, I've never seen unaligned bitmaps. But to check that on
> > > ARM, I added a run-time check for bitmap alignment. I gave it run on
> > > several architectures and found nothing.
> > > 
> > > Can you please check that on your hardware and compare performance of
> > > generic vs arch code for you? If everything is OK, I suggest switching
> > > ARM to generic find_bit() completely.
> > > 
> > > Thanks,
> > > Yury
> > > 
> > > [1] https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/
> > 
> > I _really_ don't want to play around with this stuff right now... 6.0
> > appears to have a regression on arm32 early on during boot:
> > 
> > [    1.410115] EXT4-fs error (device sda1): htree_dirblock_to_tree:1093: inode #256: block 8797: comm systemd: bad entry in directory: rec_len % 4 != 0 - offset=0, inode=33188, rec_len=35097, size=4096 fake=0
> > 
> > Booting 5.19 with the same filesystem works without issue and without
> > even a fsck, but booting 6.0 always results in some problem that
> > prevents it booting.
> > 
> > Debugging this is not easy, because there also seems to be something
> > up with the bloody serial console - sometimes I get nothing, other
> > times I get nothing more than:
> > 
> > [    2.929502] EXT4-fs error (de
> > 
> > and then the output stops. Is the console no longer synchronous? If it
> > isn't, that's a huge mistake which can be seen right here with the
> > partial message output... so I also need to work out how to make the
> > console output synchronous again.
> 
> Got it.
> 
> I you think that EXT4 problems are due to unaligned bitmaps, you can take
> 1st patch from this series to check.

Got to the bottom of it, it wasn't the bit array functions, it was DMA
API issues.

Okay, I've now tested the generic ops vs my updated optimised ops,
and my version still comes out faster (based on three runs). The
random-filled show less difference, but the sparse bitmaps show a
much better win for my optimised code over the generic code where
they exist:

arm: [  694.614773] find_next_bit:                   40078 ns,    656 iterations
gen: [   88.611973] find_next_bit:                   69943 ns,    655 iterations
arm: [  694.625436] find_next_zero_bit:            3939309 ns, 327025 iterations
gen: [   88.624227] find_next_zero_bit:            5529553 ns, 327026 iterations
arm: [  694.646236] find_first_bit:                7301363 ns,    656 iterations
gen: [   88.645313] find_first_bit:                7589120 ns,    655 iterations

These figures appear to be pretty consistent across the three
runs.

For completness, here's the random-filled results:

arm: [  694.109190] find_next_bit:                 2242618 ns, 163949 iterations
gen: [   88.167340] find_next_bit:                 2632859 ns, 163743 iterations
arm: [  694.117968] find_next_zero_bit:            2049129 ns, 163732 iterations
gen: [   88.176912] find_next_zero_bit:            2844221 ns, 163938 iterations
arm: [  694.151421] find_first_bit:               17778911 ns,  16448 iterations
gen: [   88.211167] find_first_bit:               18596622 ns,  16401 iterations

So, I don't see much reason to switch to the generic ops for
these, not when we have such a significant speedup on the
find_next_* functions for sparse-filled results..

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
