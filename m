Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BE63BBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiK2Icl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2Ibx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:31:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28B58038
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:31:25 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 120E91EC04AD;
        Tue, 29 Nov 2022 09:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669710682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c2uLthRh1cekqoux6NKDaUFI7tnAo+8/uewFZFHwfUw=;
        b=jrdvWei+zrZRNks1rtZP6RnET0S8IR3zKlLvTMSkQI3RCmaQjJjieWBA1wv9HTWgpw5jfk
        HaRcPKPWBACEOplTeXsGcQhXIUCE5IdiNX9TFCFuFDUaGPJnv/UHvupf0ZPuleOCs1pj2z
        n3VYubTHueFDOsfMz1kSgc1jYFekbUY=
Date:   Tue, 29 Nov 2022 09:31:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
Message-ID: <Y4XDVbuYtFUYCrur@zn.tnic>
References: <20221104124546.196077-1-ubizjak@gmail.com>
 <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 08:39:23AM +0100, Uros Bizjak wrote:
> On Mon, Nov 28, 2022 at 11:20 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Nov 04, 2022 at 01:45:46PM +0100, Uros Bizjak wrote:
> > > Current minimum required version of GCC is version 5.1 which allows
> > > reuse of PIC hard register on x86/x86-64 targets [1]. Remove
> > > obsolete workaround that was needed for earlier GCC versions.
> > >
> > > [1] https://gcc.gnu.org/gcc-5/changes.html
> >
> > Thanks for the doc pointer.
> >
> > Lemme see if I understand this commit message correctly:
> >
> > SysV i386 ABI says that %ebx is used as the base reg in PIC. gcc 5 and
> > newer can handle all possible cases properly where inline asm could
> > clobber the PIC reg. I.e., it is able to deal with the "=b" constraint
> > where an insn can overwrite %ebx and it'll push and pop around that
> > statement.
> 
> gcc-5 considers PIC register as a pseudo-register and reloads it

So not a "hard" register as you say above?

> x86_64 does not use PIC register for small code models. Also, it uses
> %r15 instead of %rbx for PIC register, so the removed workaround
> applies only to x86_32.

Let's see:

arch/x86/Makefile:
        # Never want PIC in a 32-bit kernel, prevent breakage with GCC built
        # with nonstandard options
        KBUILD_CFLAGS += -fno-pic

$ gcc -Wp,-MMD,arch/x86/boot/.cpuflags.o.d ... -fno-pic ... -D__KBUILD_MODNAME=kmod_cpuflags -c -o arch/x86/boot/cpuflags.o arch/x86/boot/cpuflags.c

So this workaround applies to nothing, I'd say. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
