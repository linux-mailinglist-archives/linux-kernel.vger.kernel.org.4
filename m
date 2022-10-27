Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09C61053F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiJ0WAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiJ0WAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B817539E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E25526251A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1908AC433D6;
        Thu, 27 Oct 2022 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666908032;
        bh=FZ3JmBL7SiyPSruD0iHXcZmWmgHniHy0HHBvw5Er4VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPf/PMHF94BvAurwGGpgiZj4QFtHZWbhA8kjGYZu4qMcF/nV/zvYGw02b5ozQJDPP
         noJyuCpuDmPwNAhsotE2yEs2qymyOUX+5fNvOyiqpnCn8SruKYW/PTvL+7ROlPeQOA
         /Sytn20T+RrtbdFNA5OiDhe3rdsqEcwlKlVJ8cgYvbjc3dRsn5sRrpx1KnZKX6RAeF
         fzYeY8ymbKQcYCAhiBBDSBAKViGVNDrOTYsOKFvQTZmYs1Vq8QSjC0XZ7+Ch/jAyH/
         SX1WdaFv/O1Cd+KY9fw+1f4zUVnKIat/WrUpQR/SDy+ASjttQYdb4OVcwnUmxPzaxJ
         qfiHSvpFarpHQ==
Date:   Thu, 27 Oct 2022 23:00:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        Conor Dooley <conor.dooley@microchip.com>, daolu@rivosinc.com,
        heiko@sntech.de, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] (attempt to) Fix RISC-V toolchain extension support
 detection
Message-ID: <Y1r/e2iECt72m60/@spud>
References: <Y1k9W6+EXgiL60uq@spud>
 <mhng-99b62de8-5b5c-48f7-bd01-bca2a5a26064@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-99b62de8-5b5c-48f7-bd01-bca2a5a26064@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:32:16PM -0700, Palmer Dabbelt wrote:
> On Wed, 26 Oct 2022 06:59:55 PDT (-0700), Conor Dooley wrote:
> > On Wed, Oct 26, 2022 at 06:48:32AM -0700, Palmer Dabbelt wrote:
> > > On Thu, 06 Oct 2022 10:35:19 PDT (-0700), Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > Hey,
> > > > This came up due to a report from Kevin @ kernel-ci, who had been
> > > > running a mixed configuration of GNU binutils and clang. Their compiler
> > > > was relatively recent & supports Zicbom but binutils @ 2.35.2 did not.
> > > >
> > > > Our current checks for extension support only cover the compiler, but it
> > > > appears to me that we need to check both the compiler & linker support
> > > > in case of "pot-luck" configurations that mix different versions of
> > > > LD,AS,CC etc.
> > > >
> > > > Linker support does not seem possible to actually check, since the ISA
> > > > string is emitted into the object files - so I put in version checks for
> > > > that. The checks have gotten a bit ugly since 32 & 64 bit support need
> > > > to be checked independently but ahh well.
> > > >
> > > > As I was going, I fell into the trap of there being duplicated checks
> > > > for CC support in both the Makefile and Kconfig, so as part of renaming
> > > > the Kconfig symbol to TOOLCHAIN_HAS_FOO, I dropped the extra checks in
> > > > the Makefile. This has the added advantage of the TOOLCHAIN_HAS_FOO
> > > > symbol for Zihintpause appearing in .config.
> > > >
> > > > I pushed out a version of this that specificly checked for assember
> > > > support for LKP to test & it looked /okay/ - but I did some more testing
> > > > today and realised that this is redudant & have since dropped the as
> > > > check.
> > > >
> > > > I tested locally with a fair few different combinations, to try and
> > > > cover each of AS, LD, CC missing support for the extension.
> > > >
> > > > The one that I am left wondering about is Zicsr/Zifencei. Our Makefile
> > > > has:
> > > >
> > > > > # Newer binutils versions default to ISA spec version 20191213 which moves some
> > > > > # instructions from the I extension to the Zicsr and Zifencei extensions.
> > > > > toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
> > > > > riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
> > > >
> > > > I'd like to also move that one to Kconfig rather than the Makefile so
> > > > that, again, it shows up in .config etc. But as Zicsr/Zifencei do not
> > > > appear to be emitted into the object files it's not a fix and can be a
> > > > follow-on patch if my approach here is not entirely off-the-wall.
> > > 
> > > This is actually a different case: for Zicbom and Zihintpause the
> > > instructions were added to the toolchain at the same time the extensions
> > > were, for Zifencei and Zicsr the toolchain had the instructions before the
> > > extension was defined (as they were in previous base ISAs).  So the
> > > assembler always supports "fence.i", it's just a question of whether it also
> > > needs another extension in march.
> > 
> > Yeah, that one isn't going to break the build. If the extra bit isn't
> > emitted then the old linker doesn't care. Was more for whether we wanted
> > it to be consistent with a symbol for everything that we can check
> > easily after the fact.
> > 
> > > I'm not opposed to adding a Kconfig for it, but it's a slightly different
> > > thing and I'm not sure the Kconfig really helps any because none of the
> > > kernel sources need to understand the "the assembler doesn't support the
> > > 'fence.i' instruction" case.
> > 
> > tbh beyond the OCD thing about being consistent I don't really care :)
> > 
> > > > I am not 100% on the LD/LLD versions that I picked, I went off of a
> > > > `git branch -a --contains` of the first commits I found that with
> > > > mention of the extension. Please scream if I got it wrong, I'm not
> > > > overly familar with where to find this sort of info for the toolchains.
> > > 
> > > This LD version check is for the ISA string mismatches between objects?
> > > IIRC we stopped failing on those in 2.38, from that point on we just guess
> > > at a mix and allow linking anyway (largely because of that fence.i stuff).
> > 
> > idk, I wouldn't say "mismatches between objects". The
> > _zicbom_zihintpause ends up in the object files and the linker doesnt
> > understand that and aborts. The version checks are so that we don't
> > emitt that string into object files where our linker doesn't support
> > them. It only really matters for people that've got some sort of heavily
> > mixed setup of things - which includes some CIs like Kernel CI.
> 
> As of 87fdd7ac09b ("RISC-V: Stop reporting warnings for mismatched extension
> versions"), we should be just ignoring these at link time -- unless I mixed
> something up and we're still getting errors, in which case we should fix
> binutils (and then make the check for whatever version that is).
> 
> Do you have an example of a link that's failing?  I attempted to construct
> one in the test suite, but not sure if I'm just missing something...

Following some discussion on IRC, settling for 2.38 as the gating
version for Zicbom as logic was added there to stop erroring at all for
unrecognised isa strings in objects as per Palmer's suggestion.

Tested 2.38 w/:
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0

and it does link properly. Folding in a 23800 instead of 23900 seems
fair enough to me.

Thanks,
Conor.

