Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14FC6FD90B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjEJIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjEJIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60281BC0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9A962EE3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84549C4331D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683706565;
        bh=2+isg+BERD3Bcri0FsyryjsGR7pNNF6dlwowyBGKzec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uojg3pRQRGb3JyZIXWB1lhETfstrc1AzNDHW+0eEjEPD8W5m2XoKUEl4HbxtreNLv
         tZDBOyO4n0REfP1FXd9QIgu8kCTdfzWY/AxjB8yqZmCxJ2+WxlEms687I7x4v+rkoj
         S0ezNqIl9w2ENqvGN68ctpmef0dE/FKavszSoVy3KDRenoyPMH3Q5YiON2RND5YdCM
         fyxNwRaHTixaBCKTPAmXGoeOeY1tn3WXDYjLp/Pq4LCmpk/Tgr0JOr+AERgn19KY3e
         V8SFt68Q/SBKnJnIOoI3XBNK6Wb07kiYi9Fz3HjJNTs9CaZIFI+WHMPryZp+/uoUpP
         7olCKMZ9+dZPw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ac7de2b72fso77905381fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:16:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDw41cugwPLjdCIKgqoTw6mxV+Y7Rb/gLN9wKqmGWjTThMV8GRCX
        rCUw17ljPNAQa5HkTEp86gg2B8ABK6Y4HmtgmX0=
X-Google-Smtp-Source: ACHHUZ7uVGQvzAQ6CGkZJt+yjmV1NjA1Cw97ROF2oywkTYd8kKieLtnt8WDndzhTIrbwzDlKtEPBw/d5ocOHMVi9P1I=
X-Received: by 2002:ac2:597a:0:b0:4f0:441:71a4 with SMTP id
 h26-20020ac2597a000000b004f0044171a4mr1422762lfp.35.1683706563235; Wed, 10
 May 2023 01:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
 <20230508083223.GA116442@k08j02272.eu95sqa> <CAMj1kXH1P4owoSV9OmRwEZyKritBFmCpQaa68EMrTHi0LvUrFg@mail.gmail.com>
 <20230510070949.GA7127@k08j02272.eu95sqa>
In-Reply-To: <20230510070949.GA7127@k08j02272.eu95sqa>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 May 2023 10:15:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF3N89J-Y8OptZjXPxnOLW+K5Ot+jCSBT+py90uvBxh1w@mail.gmail.com>
Message-ID: <CAMj1kXF3N89J-Y8OptZjXPxnOLW+K5Ot+jCSBT+py90uvBxh1w@mail.gmail.com>
Subject: Re: [PATCH RFC 31/43] x86/modules: Adapt module loading for PIE support
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 09:15, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>
> On Mon, May 08, 2023 at 05:16:34PM +0800, Ard Biesheuvel wrote:
> > On Mon, 8 May 2023 at 10:38, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > >
> > > On Sat, Apr 29, 2023 at 03:29:32AM +0800, Ard Biesheuvel wrote:
> > > > On Fri, 28 Apr 2023 at 10:53, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > > >
> > > > > Adapt module loading to support PIE relocations. No GOT is generared for
> > > > > module, all the GOT entry of got references in module should exist in
> > > > > kernel GOT.  Currently, there is only one usable got reference for
> > > > > __fentry__().
> > > > >
> > > >
> > > > I don't think this is the right approach. We should permit GOTPCREL
> > > > relocations properly, which means making them point to a location in
> > > > memory that carries the absolute address of the symbol. There are
> > > > several ways to go about that, but perhaps the simplest way is to make
> > > > the symbol address in ksymtab a 64-bit absolute value (but retain the
> > > > PC32 references for the symbol name and the symbol namespace name).
> > > > That way, you can always resolve such GOTPCREL relocations by pointing
> > > > it to the ksymtab entry. Another option would be to take inspiration
> > > > from the PLT code we have on ARM and arm64 (and other architectures,
> > > > surely) and to count the GOT based relocations, allocate some extra
> > > > r/o module space for each, and allocate slots and populate them with
> > > > the right value as you fix up the relocations.
> > > >
> > > > Then, many such relocations can be relaxed at module load time if the
> > > > symbol is in range. IIUC, the module and kernel will still be inside
> > > > the same 2G window even after widening the KASLR range to 512G, so
> > > > most GOT loads can be converted into RIP relative LEA instructions.
> > > >
> > > > Note that this will also permit you to do things like
> > > >
> > > > #define PV_VCPU_PREEMPTED_ASM \
> > > >  "leaq __per_cpu_offset(%rip), %rax \n\t" \
> > > >  "movq (%rax,%rdi,8), %rax \n\t" \
> > > >  "addq steal_time@GOTPCREL(%rip), %rax \n\t" \
> > > >  "cmpb $0, " __stringify(KVM_STEAL_TIME_preempted) "(%rax) \n\t" \
> > > >  "setne %al\n\t"
> > > >
> > > > or
> > > >
> > > > +#ifdef CONFIG_X86_PIE
> > > > + " pushq arch_rethook_trampoline@GOTPCREL(%rip)\n"
> > > > +#else
> > > > " pushq $arch_rethook_trampoline\n"
> > > > +#endif
> > > >
> > > > instead of having these kludgy push/pop sequences to free up temp registers.
> > > >
> > > > (FYI I have looked into this PIE linking just a few weeks ago [0] so
> > > > this is all rather fresh in my memory)
> > > >
> > > >
> > > >
> > > >
> > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-pie
> > > >
> > > >
> > > Hi Ard,
> > > Thanks for providing the link, it has been very helpful for me as I am
> > > new to the topic of compilers.
> >
> > Happy to hear that.
> >
> > > One key difference I noticed is that you
> > > linked the kernel with "-pie" instead of "--emit-reloc". I also noticed
> > > that Thomas' initial patchset[0] used "-pie", but in RFC v3 [1], it
> > > switched to "--emit-reloc" in order to reduce dynamic relocation space
> > > on mapped memory.
> > >
> >
> > The problem with --emit-relocs is that the relocations emitted into
> > the binary may get out of sync with the actual code after the linker
> > has applied relocations.
> >
> > $ cat /tmp/a.s
> > foo:movq foo@GOTPCREL(%rip), %rax
> >
> > $ x86_64-linux-gnu-gcc -c -o /tmp/a.o /tmp/a.s
> > ard@gambale:~/linux$ x86_64-linux-gnu-objdump -dr /tmp/a.o
> >
> > /tmp/a.o:     file format elf64-x86-64
> >
> >
> > Disassembly of section .text:
> >
> > 0000000000000000 <foo>:
> >    0: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 7 <foo+0x7>
> > 3: R_X86_64_REX_GOTPCRELX foo-0x4
> >
> > $ x86_64-linux-gnu-gcc -c -o /tmp/a.o /tmp/a.s
> > $ x86_64-linux-gnu-objdump -dr /tmp/a.o
> > 0000000000000000 <foo>:
> >    0: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 7 <foo+0x7>
> > 3: R_X86_64_REX_GOTPCRELX foo-0x4
> >
> > $ x86_64-linux-gnu-gcc -o /tmp/a.elf -nostartfiles
> > -Wl,-no-pie,-q,--defsym,_start=0x0 /tmp/a.s
> > $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> > 0000000000401000 <foo>:
> >   401000: 48 c7 c0 00 10 40 00 mov    $0x401000,%rax
> > 401003: R_X86_64_32S foo
> >
> > $ x86_64-linux-gnu-gcc -o /tmp/a.elf -nostartfiles
> > -Wl,-q,--defsym,_start=0x0 /tmp/a.s
> > $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> > 0000000000001000 <foo>:
> >     1000: 48 8d 05 f9 ff ff ff lea    -0x7(%rip),%rax        # 1000 <foo>
> > 1003: R_X86_64_PC32 foo-0x4
> >
> > This all looks as expected. However, when using Clang, we end up with
> >
> > $ clang -target x86_64-linux-gnu -o /tmp/a.elf -nostartfiles
> > -fuse-ld=lld -Wl,--relax,-q,--defsym,_start=0x0 /tmp/a.s
> > $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> > 00000000000012c0 <foo>:
> >     12c0: 48 8d 05 f9 ff ff ff lea    -0x7(%rip),%rax        # 12c0 <foo>
> > 12c3: R_X86_64_REX_GOTPCRELX foo-0x4
> >
> > So in this case, what --emit-relocs gives us is not what is actually
> > in the binary. We cannot just ignore these either, given that they are
> > treated differently depending on whether the symbol is a per-CPU
> > symbol or not - in the former case, we need to perform a fixup if the
> > relaxed reference is RIP relative, and in the latter case, if the
> > relaxed reference is absolute.
> >
> > On top of that, --emit-relocs does not cover the GOT, so we'd still
> > need to process that from the code explicitly.
> >
> > In general, relying on --emit-relocs is kind of dodgy, and I think
> > combining PIE linking with --emit-relocs is a bad idea.
> >
> > > The another issue is that it requires the addition of the
> > > "-mrelax-relocations=no" option to support older compilers and linkers.
> >
> > Why? The decompressor is now linked in PIE mode so we should be able
> > to drop that. Or do you need to add is somewhere else?
> >
> Hi Ard,
>
> After removing the "-mrelax-relocations=no" option, I noticed that the
> linker was relaxing GOT references as absolute references for mov
> instructions, even if the symbol was in a high address, as long as I
> kept the compile-time base address of the kernel image in the top 2G. I
> consulted the "Optimize GOTPCRELX Relocations" chapter in x86-64 psABI,
> which stated that "When position-independent code is disabled and foo is
> defined locally in the lower 32-bit address space, memory operand in mov
> can be converted into immediate operand". However, it seemed that if the
> symbol was in the higher 32-bit address space, the memory operand in mov
> would also be converted into an immediate operand. If I decreased the
> compile-time base address of the kernel image, it would be relaxed as
> lea. Therefore, I believe that using "-mrelax-relocations=no" without
> "-pie" option is necessary.

Indeed. As you noted, the linker assumes that non-PIE linked binaries
will always appear at their link time address, and relaxations will
try to take advantage of that.

Currently, we use -pie linking only for the decompressor, and we
should be able to drop -mrelax-relocations=no from its LDFLAGS. But
position dependent linking should not use relaxations at all.

> Is there a way to force the linker to relax
> it as lea without using the "-pie" option when linking?
>

Not that I am aware of.

> Since all GOT references cannot be omitted, perhaps I should try linking
> the kernel with the "-pie" option.
>

That way, we will end up with two sets of relocations, the static ones
from --emit-relocs and the dynamic ones from -pie. This should be
manageable, given that the difference between those sets should
exactly cover the GOT.

However, relying on --emit-relocs and -pie at the same time seems
clumsy to me. I'd prefer to only depend on -pie at /some/ point.

-- 
Ard.
