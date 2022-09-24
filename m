Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB75E88D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiIXGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiIXGoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:44:13 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66B9AFEA;
        Fri, 23 Sep 2022 23:44:12 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28O6hxWo030667;
        Sat, 24 Sep 2022 15:43:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28O6hxWo030667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664001840;
        bh=BrB/d9GLo7Y+hIxSma9xiwLjfmTb240J0ExFJfaukvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jA3Bs6pYeQ4B0Y2UNfTeO4t0CbQWWtApoDi6B3PKQbNNamW+uI11jKaYEDJeG7L/A
         duEoBMFdDwYagjXGH9OSoRC4td0JOh3VBj2QPjmUBU6T4D/DvI7z2t6q+SMGLINZzW
         fRHj6JdqXBiVp6d4LDMwFPkwpXp57y0S5ujtmJy2dVbEOMY38FIfzBQ/UtVWURJIp+
         ALzaoi/uaCExLe+CxZ5maHWB0uhZKq/MBroL8E2HGfgM9ijOYab8APcqKHnOEvMSzQ
         vBJ6aWMY/3IbmeNa+/763oyfv9vvZE28QjQrPoP3OxQGoyLDKIXK40dosc3b23i8m1
         hzZ1jY9eXyF+A==
X-Nifty-SrcIP: [209.85.210.47]
Received: by mail-ot1-f47.google.com with SMTP id l7-20020a056830154700b0065563d564dfso1357722otp.0;
        Fri, 23 Sep 2022 23:43:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf2e8jF1NcSnihSpwIqKqI9V7QSsqhXdhLoRzYtt/hqF4K9JbxLm
        fNA2I+LZWwRICDH8w43kRIF0JvcjWc2U7ZI4Cvg=
X-Google-Smtp-Source: AMsMyM5uHnH+GtLwvwpxHGwGqJliKbqPhsHZxCRP03wo/6E3AokdAm0Mto/u5ftDq0kJAladauu2e6jL4Ed8TI598Z8=
X-Received: by 2002:a05:6830:3115:b0:658:ea61:249c with SMTP id
 b21-20020a056830311500b00658ea61249cmr5736448ots.225.1664001838616; Fri, 23
 Sep 2022 23:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919174547.3730737-1-ndesaulniers@google.com> <CAK7LNAS5xSQTjDuu+dsNW2fOz1-s7x0gsCLmfQOnGpb5CY06KA@mail.gmail.com>
 <CAKwvOdk-oj24MQs-W0Xs6p33f+Ei7Wu3wwCX+d34T=xoOPxOiw@mail.gmail.com>
In-Reply-To: <CAKwvOdk-oj24MQs-W0Xs6p33f+Ei7Wu3wwCX+d34T=xoOPxOiw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 24 Sep 2022 15:43:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfiq4fONgRKpO-FOAUNitVwmr=if+04pJfa62aamjSOw@mail.gmail.com>
Message-ID: <CAK7LNARfiq4fONgRKpO-FOAUNitVwmr=if+04pJfa62aamjSOw@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.debug: re-enable debug info for .S files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 11:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 23, 2022 at 7:12 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This patch still misses the debug info for *.S files
> > for the combination of LLVM_IAS=0 and
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > because, as the comment says, Clang does not pass -g down to GAS.
> >
> >
> > With "[v4] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT"
> > and this one applied,
> >
> >
> >
> > $ grep CONFIG_DEBUG_INFO_DWARF .config
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > $ make LLVM=1 LLVM_IAS=0 arch/x86/kernel/irqflags.o
> >   SYNC    include/config/auto.conf.cmd
> >   SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
> >   SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
> >   SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
> >   HOSTCC  arch/x86/tools/relocs_32.o
> >   [snip]
> >   AS      arch/x86/kernel/irqflags.o
> > $ objdump  -h arch/x86/kernel/irqflags.o | grep debug
> > $
> >
> >
> >
> >
> >
> >
> >
> >
> > I think the following fix-up is needed on top.
> >
> >
> >
> >
> > diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> > index d6aecd78b942..8cf1cb22dd93 100644
> > --- a/scripts/Makefile.debug
> > +++ b/scripts/Makefile.debug
> > @@ -1,4 +1,5 @@
> > -DEBUG_CFLAGS   := -g
> > +DEBUG_CFLAGS   :=
> > +debug-flags-y  := -g
> >
> >  ifdef CONFIG_DEBUG_INFO_SPLIT
> >  DEBUG_CFLAGS   += -gsplit-dwarf
> >
> >
> >
> >
> > Then, I can see the debug sections.
> >
> >
> >
> > $ make LLVM=1 LLVM_IAS=0 arch/x86/kernel/irqflags.o
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   AS      arch/x86/kernel/irqflags.o
> > $ objdump -h arch/x86/kernel/irqflags.o | grep debug
> >   6 .debug_line   00000050  0000000000000000  0000000000000000  0000008f  2**0
> >   7 .debug_info   0000002e  0000000000000000  0000000000000000  000000f8  2**0
> >   8 .debug_abbrev 00000014  0000000000000000  0000000000000000  000001d0  2**0
> >   9 .debug_aranges 00000030  0000000000000000  0000000000000000  000001f0  2**4
> >  10 .debug_str    0000004d  0000000000000000  0000000000000000  00000250  2**0
> >
> >
> >
> >
> >
> > If you agree, I can locally fix it up as such.
>
> Ah, sorry I missed testing that combination. Thanks for your
> thoroughness. Yes please apply that diff on top.
> --
> Thanks,
> ~Nick Desaulniers



Applied to linux-kbuild with the fixup.



-- 
Best Regards
Masahiro Yamada
