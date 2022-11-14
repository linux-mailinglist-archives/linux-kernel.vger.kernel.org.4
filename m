Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A63627D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiKNMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiKNMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:01:51 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E923143
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F/Wr+SVV/WVwZt2osIxsvNDdmkKmeVCwtMMYAaUXH+I=; b=IobAelHrlC9OmYTjrWvY8TZyco
        FHukHDGF3YCUiw/2E2zcXGj//gKXRt0D5OBPh7zifr0oC2XYlUOYZ1oVss/oBV/E8IBvwGhDEdWvU
        zUxdXK81AhbB+jGu0zYHZqWmTxeLVseHHtnDDdm2Q2Z+uKrLi+Xz64u5l+johTbgxX9rzW5WltnPs
        Kh1p90LT+r9IvIqp7iGQXJLPB3TkOl3+p0xRNhor2qVb65uPSwAhVZWcyPbIq1SlDoT/IkYdHhvU4
        szcDUsOSiruckNDrGS9+wxuP288Gd3uVs6d5KkTu3LhdaMvLqmaH4Xay8R9uJb+rQa5S5zAoTcb55
        f4y+PY5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35258)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ouY7e-0000kO-J4; Mon, 14 Nov 2022 11:59:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ouY7b-0003n5-FQ; Mon, 14 Nov 2022 11:59:27 +0000
Date:   Mon, 14 Nov 2022 11:59:27 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] bitmap: add sanity check function for find_bit()
Message-ID: <Y3Itn2Dwq3yIFhme@shell.armlinux.org.uk>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
 <20221020032024.1804535-2-yury.norov@gmail.com>
 <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
 <Y1gY18JGz4zKw+gW@yury-laptop>
 <Y1gqTM19oLeN59Kl@shell.armlinux.org.uk>
 <CAHk-=wht2pdAoG97kbFqCyOzi1C714x-BY92pvtMcmtGCfUasw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wht2pdAoG97kbFqCyOzi1C714x-BY92pvtMcmtGCfUasw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:38:31AM -0700, Linus Torvalds wrote:
> On Tue, Oct 25, 2022 at 11:26 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > However, we still support ARMv5 and ARMv4, both of which _trap_ every
> > unaligned access, which will make a findbit call with an unaligned
> > pointer using word loads painfully expensive. This is the main reason
> > we haven't used word loads in the findbit ops.
> 
> The findbit ops really shouldn't be a special case, and bitmaps can
> never be unaligned.
> 
> Just look at what 'test_bit()' does: the non-constant non-instrumented
> version ends up as generic_test_bit(), which uses a "const volatile
> unsigned long *" access to do the bitmap load.
> 
> So there is absolutely no way that bitmaps can ever be unaligned,
> because that would trap.
> 
> And test_bit() is a lot more fundamental than one of the "find bits" functions.
> 
> Have we had bugs in this area before? Sure. People have used "unsigned
> int" for flags and mised the bitmap ops on it, and it has worked on
> x86.
> 
> But then it fails *miserably* on big-endian machines and on machines
> that require more alignment (and even on x86 we have KASAN failures
> etc these days and obviously without casts it will warn), so we've
> hopefully fixed all those cases up long long ago.
> 
> So I really think it's pointless to worry about alignment for
> "find_bit()" and friends, when much more fundamental bitop functions
> don't worry about it.

Yes, which is what my series does by converting to use word operations
and not caring anymore whether the pointer is aligned or not.

My reply was more a correction of the apparent "we don't have to worry
about unaligned accesses because version 6 of the architecture has a
feature that means we don't have to worry" which I regard as broken
thinking, broken as long as we continue to support previous versions
of the architecture.

I'm planning to queue up my series of five patches today, so it should
be in tonight's linux-next.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
