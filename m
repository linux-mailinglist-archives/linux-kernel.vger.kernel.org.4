Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A73B67798E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAWKs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjAWKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:48:40 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05246B1;
        Mon, 23 Jan 2023 02:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ITlUv0BwWHWqWW8dmqlTXwJruahish2NNnM7ocyFIqk=; b=e48AO1cEHXSBghFRNhSvGx6N+t
        gwdk/V53/Ufx8eFaWKKFbSpvB8VvaagYbCDgy7ZWkQ0gcFpOYvwNUYPRU1CztKC2ChOy/H8TQBqEE
        6+NGXO3HdMuc4Ffd61lkUQg3RsJZMUohpcxHUmvYURsjiPVBPP65LQqEj2LImhKdxk/pyAW4f53aP
        HTXQCdgh0bjk0AzfP/cm0ROMcs29QbcpZIjzgA24j56zxl7QO+JVropdmXv+hD936+DzopJXYzFCj
        Cgpedl9yXR8Fu9nEhzGORswOvV9u2ZjM0LV1qiLJgndLLwMEPRXT8Sujp5RE+Q+jBQAWqMgVnIR/5
        cO8ugDxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36266)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pJuNF-0004Cl-V1; Mon, 23 Jan 2023 10:48:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pJuNE-0004Go-5R; Mon, 23 Jan 2023 10:48:24 +0000
Date:   Mon, 23 Jan 2023 10:48:24 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] ARM: Reduce __thumb2__ definition to crypto files that
 require it
Message-ID: <Y85l+E22PJ8lhmcN@shell.armlinux.org.uk>
References: <20221222193039.2267074-1-nathan@kernel.org>
 <CAKwvOd=WQ5cAL74z+gbGgxG9WrOcDJtrGXJWxEEcWnmyoypu0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=WQ5cAL74z+gbGgxG9WrOcDJtrGXJWxEEcWnmyoypu0w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:52:27AM -0800, Nick Desaulniers wrote:
> On Thu, Dec 22, 2022 at 11:30 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Commit 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler") added
> > a __thumb2__ define to ASFLAGS to avoid build errors in the crypto code,
> > which relies on __thumb2__ for preprocessing. Commit 59e2cf8d21e0 ("ARM:
> > 9275/1: Drop '-mthumb' from AFLAGS_ISA") followed up on this by removing
> > -mthumb from AFLAGS so that __thumb2__ would not be defined when the
> > default target was ARMv7 or newer.
> >
> > Unfortunately, the second commit's fix assumes that the toolchain
> > defaults to -mno-thumb / -marm, which is not the case for Debian's
> > arm-linux-gnueabihf target, which defaults to -mthumb:
> >
> >   $ echo | arm-linux-gnueabihf-gcc -dM -E - | grep __thumb
> >   #define __thumb2__ 1
> >   #define __thumb__ 1
> 
> Interesting, that was hard to foresee in review of 1d2e9b67b001 and
> 59e2cf8d21e0.
> 
> FWIW, their non-hf target does not.
> $ echo | arm-linux-gnueabi-gcc -dM -E - | grep __thumb
> $
> 
> >
> > This target is used by several CI systems, which will still see
> > redefined macro warnings, despite '-mthumb' not being present in the
> > flags:
> >
> >   <command-line>: warning: "__thumb2__" redefined
> >   <built-in>: note: this is the location of the previous definition
> >
> > Remove the global AFLAGS __thumb2__ define and move it to the crypto
> > folder where it is required by the imported OpenSSL algorithms; the rest
> > of the kernel should use the internal CONFIG_THUMB2_KERNEL symbol to
> > know whether or not Thumb2 is being used or not. Be sure that __thumb2__
> > is undefined first so that there are no macro redefinition warnings.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1772
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks Nathan and Ard.

Shouldn't this also have a fixes tag?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
