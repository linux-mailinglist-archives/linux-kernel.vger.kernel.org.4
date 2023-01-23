Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345BE677DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjAWOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjAWOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:12:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F73173C;
        Mon, 23 Jan 2023 06:12:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE34CB80DAD;
        Mon, 23 Jan 2023 14:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39AEC433D2;
        Mon, 23 Jan 2023 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674483159;
        bh=xFLOnDtk94LbkRcvU27vXX6doFgrUITeWaNgk1986HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQq6YkkL4QqEs8PFGw3bcEihpcmRbNRanM32NBpqWFWdXh5Ehhz4b8G1VFErSpd5G
         3mPltjvOIJm6Mkk2GBX6cH8SabBqpW0qqK8TV3C8xUdRiD7Qm0izf9YHWyaSYDX981
         tOdyj8EXbYHIr0Dm1Bun/NlOhTdu6F/yfUcc9b7gw/jwoetUd6xtRilM12Drpx8zUP
         fCBWyOp5AIPI1OrZXvR7uamLjREor/aShknMCc/Xik4qJIYp6+pNHHXhLiSl6RG7QA
         mBWeauYkaOjPPE4qhLJK71c99GqGuztPiPWEwbH8SvYBOXG/dN38Z9P1s3kGB9dpi6
         kdn5DCte2Iysg==
Date:   Mon, 23 Jan 2023 07:12:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] ARM: Reduce __thumb2__ definition to crypto files that
 require it
Message-ID: <Y86V1Ro+iQaa3IYe@dev-arch.thelio-3990X>
References: <20221222193039.2267074-1-nathan@kernel.org>
 <CAKwvOd=WQ5cAL74z+gbGgxG9WrOcDJtrGXJWxEEcWnmyoypu0w@mail.gmail.com>
 <Y85l+E22PJ8lhmcN@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y85l+E22PJ8lhmcN@shell.armlinux.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:48:24AM +0000, Russell King (Oracle) wrote:
> On Thu, Dec 22, 2022 at 11:52:27AM -0800, Nick Desaulniers wrote:
> > On Thu, Dec 22, 2022 at 11:30 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Commit 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler") added
> > > a __thumb2__ define to ASFLAGS to avoid build errors in the crypto code,
> > > which relies on __thumb2__ for preprocessing. Commit 59e2cf8d21e0 ("ARM:
> > > 9275/1: Drop '-mthumb' from AFLAGS_ISA") followed up on this by removing
> > > -mthumb from AFLAGS so that __thumb2__ would not be defined when the
> > > default target was ARMv7 or newer.
> > >
> > > Unfortunately, the second commit's fix assumes that the toolchain
> > > defaults to -mno-thumb / -marm, which is not the case for Debian's
> > > arm-linux-gnueabihf target, which defaults to -mthumb:
> > >
> > >   $ echo | arm-linux-gnueabihf-gcc -dM -E - | grep __thumb
> > >   #define __thumb2__ 1
> > >   #define __thumb__ 1
> > 
> > Interesting, that was hard to foresee in review of 1d2e9b67b001 and
> > 59e2cf8d21e0.
> > 
> > FWIW, their non-hf target does not.
> > $ echo | arm-linux-gnueabi-gcc -dM -E - | grep __thumb
> > $
> > 
> > >
> > > This target is used by several CI systems, which will still see
> > > redefined macro warnings, despite '-mthumb' not being present in the
> > > flags:
> > >
> > >   <command-line>: warning: "__thumb2__" redefined
> > >   <built-in>: note: this is the location of the previous definition
> > >
> > > Remove the global AFLAGS __thumb2__ define and move it to the crypto
> > > folder where it is required by the imported OpenSSL algorithms; the rest
> > > of the kernel should use the internal CONFIG_THUMB2_KERNEL symbol to
> > > know whether or not Thumb2 is being used or not. Be sure that __thumb2__
> > > is undefined first so that there are no macro redefinition warnings.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1772
> > > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > Thanks Nathan and Ard.
> 
> Shouldn't this also have a fixes tag?

Ugh, yes, sorry about that :( would you kind taking these when you apply
the patch or would you like me to resubmit?

Fixes: 59e2cf8d21e0 ("ARM: 9275/1: Drop '-mthumb' from AFLAGS_ISA")
Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")

Cheers,
Nathan
