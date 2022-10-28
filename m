Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B2A611B02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJ1Tmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJ1Tmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:42:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5AE1F180D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+np9QiDBm5OX72zqnX/JkVZoxFFoy5PO1D9fyLa2J/g=; b=lR7/bwA+xivuEesUhh0er/aFry
        5hoSjRQMdoa5evgk8MhANcB2UrhCCgsa1IwY4m08cHOz+f8Q8rGNw8BH5MAotJr20yObyY54Fci3J
        tdHxCYgm/7WnkJvWPIRerrL97tJZ5D+4TMie6eKM7OuvamH7pG2OmPCWAKb+lquzo49vSkN3+//Sb
        zFqr7Gz7Hrg2GNQg7BSJCWYGp/oUgbgDkmohbzjREFFxtgHMIlFctVldht07remYp67elMZ6gW6lf
        MY+TzoyZjDyxrtM7Ag+1DkNvRJdQSeih2gVgCPBjS7IYQ7BUCUmDXC1Fz1gWJE86b1+Hgm3Wtxu8V
        krTNARdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35016)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ooVFL-0000LE-Hc; Fri, 28 Oct 2022 20:42:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ooVFJ-0002q0-Km; Fri, 28 Oct 2022 20:42:25 +0100
Date:   Fri, 28 Oct 2022 20:42:25 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
Message-ID: <Y1wwoTIjn3dBdLzX@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
 <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
 <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
 <Y1wheOT4yP7VCZ0p@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wheOT4yP7VCZ0p@yury-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:37:44AM -0700, Yury Norov wrote:
> + Alexey Klimov
> 
> On Fri, Oct 28, 2022 at 06:45:50PM +0100, Russell King (Oracle) wrote:
> > On Fri, Oct 28, 2022 at 10:05:29AM -0700, Linus Torvalds wrote:
> > > On Fri, Oct 28, 2022 at 9:47 AM Russell King (Oracle)
> > > <rmk+kernel@armlinux.org.uk> wrote:
> > > >
> > > > Document the ARMv5 bit offset calculation code.
> > > 
> > > Hmm. Don't the generic bitop functions end up using this? We do have a
> > > comment in the code that says
> > > 
> > >  * On ARMv5 and above, the gcc built-ins may rely on the clz instruction
> > >  * and produce optimal inlined code in all cases. On ARMv7 it is even
> > >  * better by also using the rbit instruction.
> > 
> > It's true that the generic code also makes use of the rbit and clz
> > instructions - but in terms of the speed of the functions these only
> > get used once we've found a word that is interesting to locate the
> > bit we want in.
> > 
> > > but that 'may' makes me wonder...
> > > 
> > > IOW, what is it in the hand-written code that doesn't get done by the
> > > generic code these days?
> > 
> > For the _find_first_bit, there isn't much difference in the number
> > of instructions or really what is going on, only the organisation
> > and flow of the code is more inline - but that shouldn't make much
> > of a difference. Yet, there is a definite repeatable measurable
> > difference between the two:
> > 
> > random-filled:
> > arm    : find_first_bit:               17778911 ns,  16448 iterations
> > generic: find_first_bit:               18596622 ns,  16401 iterations
> > 
> > sparse:
> > arm    : find_first_bit:                7301363 ns,    656 iterations
> > generic: find_first_bit:                7589120 ns,    655 iterations
> > 
> > The bigger difference is in the find_next_bit operations, and this
> > likely comes from the arm32 code not having the hassles of the "_and"
> > and other conditionals that the generic code has:
> > 
> > random-filled:
> > arm    : find_next_bit:                 2242618 ns, 163949 iterations
> > generic: find_next_bit:                 2632859 ns, 163743 iterations
> > 
> > sparse:
> > arm    : find_next_bit:                   40078 ns,    656 iterations
> > generic: find_next_bit:                   69943 ns,    655 iterations
> > 
> > find_next_zero_bit show a greater difference:
> > 
> > random-filled:
> > arm    : find_next_zero_bit:            2049129 ns, 163732 iterations
> > generic: find_next_zero_bit:            2844221 ns, 163938 iterations
> > 
> > sparse:
> > arm    : find_next_zero_bit:            3939309 ns, 327025 iterations
> > generic: find_next_zero_bit:            5529553 ns, 327026 iterations
> 
> Those numbers disagree with what Alexey has measured on Odroid board
> for A15 but somewhat in line with what he had for A7:

Considering no one has seen these patches until I've just posted
them, frankly I don't think there's any point me looking at anyone
elses results.

These changes make substantial improvements to the arm32 assembly
code versions.

If you want a like-for-like comparison, then please get Alexey to
test with these patches applied. I am confident that he will confirm
my results.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
