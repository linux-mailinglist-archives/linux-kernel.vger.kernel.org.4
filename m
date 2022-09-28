Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA145EE85D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiI1Vgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiI1Vgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF357D792;
        Wed, 28 Sep 2022 14:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF63261FE5;
        Wed, 28 Sep 2022 21:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF29C433D6;
        Wed, 28 Sep 2022 21:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664401008;
        bh=aT8rvgKz7c6G4ZCSZioQYbTyzSYZAZy9hqJAzraHnDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyeKR7S/R81B3srxAHth1JOo3X7zSYqY8N6htG5l86xMIqsG+133M1R+lTz9khsSS
         g+FUDoxyGX0HE0mNKz9+ds4kQAtixk4nDn3iDmWRG7jiBT3sekVpZVvkZmfSVVRDhF
         SxGIMTuAOpgiBgUEm+h4UzLY0xiUnyGFsS+CH1f+xUPar9f/Eo+yRuNJBpX2cQvYAO
         +WiSn5R0QGqBCEb1N0eUlK9UBUYFbzn8Gca2h9jT2otSQKTjjrLExrmiHUn5laPk+Q
         hBWuum5xeZ05/rSYc0pb2i/m0JsadNWBx52uQgU6ZdG1nPNB5Z0BYT73pGo3ejVrs+
         07MSrfM+JiP9Q==
Date:   Wed, 28 Sep 2022 14:36:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
Message-ID: <YzS+bQT1zJAUpp/6@dev-arch.thelio-3990X>
References: <20220928182523.3105953-1-nathan@kernel.org>
 <CAKwvOdmPLqX=oCwg43TYHj=tdoaU5OYc=bO906u=LeqcSrx+Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmPLqX=oCwg43TYHj=tdoaU5OYc=bO906u=LeqcSrx+Dw@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:13:47PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 28, 2022 at 11:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When building with a RISC-V kernel with DWARF5 debug info using clang
> > and the GNU assembler, several instances of the following error appear:
> >
> >   /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported
> >
> > Dumping the .s file reveals these .uleb128 directives come from
> > .debug_loc and .debug_ranges:
> >
> >   .Ldebug_loc0:
> >           .byte   4                               # DW_LLE_offset_pair
> >           .uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
> >           .uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
> >           .byte   1                               # Loc expr size
> >           .byte   90                              # DW_OP_reg10
> >           .byte   0                               # DW_LLE_end_of_list
> >
> >   .Ldebug_ranges0:
> >           .byte   4                               # DW_RLE_offset_pair
> >           .uleb128 .Ltmp6-.Lfunc_begin0           #   starting offset
> >           .uleb128 .Ltmp27-.Lfunc_begin0          #   ending offset
> >           .byte   4                               # DW_RLE_offset_pair
> >           .uleb128 .Ltmp28-.Lfunc_begin0          #   starting offset
> >           .uleb128 .Ltmp30-.Lfunc_begin0          #   ending offset
> >           .byte   0                               # DW_RLE_end_of_list
> >
> > There is an outstanding binutils issue to support a non-constant operand
> > to .sleb128 and .uleb128 in GAS for RISC-V but there does not appear to
> > be any movement on it, due to concerns over how it would work with
> > linker relaxation.
> >
> > To avoid these build errors, prevent DWARF5 from being selected when
> > using clang and an assembler that does not have support for these symbol
> > deltas, which can be easily checked in Kconfig with as-instr plus the
> > small test program from the dwz test suite from the binutils issue.
> >
> > Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1719
> > Tested-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  lib/Kconfig.debug | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d3e5f36bb01e..19de03ead2ed 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -231,6 +231,9 @@ config DEBUG_INFO
> >           in the "Debug information" choice below, indicating that debug
> >           information will be generated for build targets.
> >
> > +config AS_HAS_NON_CONST_LEB128
> > +       def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
> > +
> >  choice
> >         prompt "Debug information"
> >         depends on DEBUG_KERNEL
> > @@ -277,6 +280,10 @@ config DEBUG_INFO_DWARF5
> >         bool "Generate DWARF Version 5 debuginfo"
> >         select DEBUG_INFO
> >         depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> > +       # Clang is known to generate .{s,u}leb128 with symbol deltas with
> > +       # DWARF5, which some targets may not support.
> > +       # https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> > +       depends on !CC_IS_CLANG || AS_HAS_NON_CONST_LEB128
> 
> Reraising my concern from
> https://github.com/ClangBuiltLinux/linux/issues/1719#issuecomment-1258678969

Sorry, I thought I addressed your concern with my comment right below it
but I probably should have worded it better.

> We've put a fair amount of work into getting CC=clang LLVM_IAS=0 to
> work for DWARF v5 (both on the GNU binutils side, and Kbuild), I'd
> hate to see that effectively knee-capped because of an issue in GNU
> binutils that is only relevant for one architecture.

Sure, that is a completely reasonable concern. However...

> I'd concede support for ARCH=riscv, but not for all other
> architectures, which this effectively does.

No, it does not, CONFIG_AS_HAS_NON_CONST_LEB128 can still be enabled
when GNU as supports this construct for a particular architecture; as
far as I can tell, RISC-V is the only one that doesn't. See the tests
with ARCH=arm64 and ARCH=x86_64 compared with ARCH=riscv below.

$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 LLVM_IAS=0 defconfig

$ rg "CONFIG_AS_(IS|VERSION|HAS)" .config
9:CONFIG_AS_IS_GNU=y
10:CONFIG_AS_VERSION=23950
4750:CONFIG_AS_HAS_NON_CONST_LEB128=y

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 LLVM_IAS=0 defconfig

$ rg "CONFIG_AS_(IS|VERSION|HAS)" .config
9:CONFIG_AS_IS_GNU=y
10:CONFIG_AS_VERSION=23950
442:CONFIG_AS_HAS_LDAPR=y
443:CONFIG_AS_HAS_LSE_ATOMICS=y
451:CONFIG_AS_HAS_ARMV8_2=y
452:CONFIG_AS_HAS_SHA3=y
465:CONFIG_AS_HAS_PAC=y
466:CONFIG_AS_HAS_CFI_NEGATE_RA_STATE=y
473:CONFIG_AS_HAS_ARMV8_4=y
480:CONFIG_AS_HAS_ARMV8_5=y
9719:CONFIG_AS_HAS_NON_CONST_LEB128=y

$ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1 LLVM_IAS=0 defconfig

$ rg "CONFIG_AS_(IS|VERSION|HAS)" .config
9:CONFIG_AS_IS_GNU=y
10:CONFIG_AS_VERSION=23950

Cheers,
Nathan
