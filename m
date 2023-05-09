Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCD6FC344
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjEIJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjEIJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82510E50
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCA56452D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F9C433A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683625965;
        bh=NoWB1+2hVQWvmeiRPNBGOreQS4eXWf7mET9Dh4j7Frw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MkdnJWR6O7f4dBl07R/Sy8BFpOTGeJqGt7PCy2KVc54ZMfQ7BuP9z9CAZOJs/lY6U
         dbXrbFpnl3+1b6jKPoIynwyolXclhUuqGkS935Jol1jMFef121SlXFnY6+YzEb0o6r
         AlcoxaQVfP4yXNJfB4qUgxRTQFFK4DmB5jM0SHXjYvf5ZVeSibj69v0SP7jMs24CqT
         TOKmaSgU3Hekw3RQ996vJScgzYOS390aCyIt40iOGiwwhHEcaAyC7LZ4DaC2P6yuAf
         8ooMov9ahAXK50l5lFRYOz1c9PB5uOzxOAGwMUvXi3dgZIWnR5BCXl6cxISb+YoWKu
         3fdJSUqTYwyow==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f139de8cefso32775633e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:52:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDz3JINhf3tnGAmuzw7INrXLEuB4hNGGD3toPRzLWD9TTGUwFwi6
        8trW4st3v7WUIR0db7DDJossa700Ni05PfDHRgI=
X-Google-Smtp-Source: ACHHUZ58oHJRJr4eKqvY1R5bKe5eAibHFbNDx9T3nYeRUeEEH4qeeRKeyDyNdwY3V63M46uF96KaG3XOfzgE9OSLRSU=
X-Received: by 2002:a05:6512:b95:b0:4f1:4a14:d97c with SMTP id
 b21-20020a0565120b9500b004f14a14d97cmr742517lfv.16.1683625963290; Tue, 09 May
 2023 02:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
 <20230508083223.GA116442@k08j02272.eu95sqa> <CAMj1kXH1P4owoSV9OmRwEZyKritBFmCpQaa68EMrTHi0LvUrFg@mail.gmail.com>
 <20230508114010.GA62035@k08j02272.eu95sqa> <CAMj1kXGcO+r0u-8R_g0Ysbxgjmqj+q2fDD5USAAxqvStjE75oQ@mail.gmail.com>
 <20230509094226.GA74483@k08j02272.eu95sqa>
In-Reply-To: <20230509094226.GA74483@k08j02272.eu95sqa>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 May 2023 11:52:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE331d0RZkTBLHPu-9UQQr3L855iE-w83PeTNCrfbCvkQ@mail.gmail.com>
Message-ID: <CAMj1kXE331d0RZkTBLHPu-9UQQr3L855iE-w83PeTNCrfbCvkQ@mail.gmail.com>
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

On Tue, 9 May 2023 at 11:42, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>
> On Tue, May 09, 2023 at 01:47:53AM +0800, Ard Biesheuvel wrote:
> > On Mon, 8 May 2023 at 13:45, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > >
> > > On Mon, May 08, 2023 at 05:16:34PM +0800, Ard Biesheuvel wrote:
> > > > On Mon, 8 May 2023 at 10:38, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > > >
> > > > > On Sat, Apr 29, 2023 at 03:29:32AM +0800, Ard Biesheuvel wrote:
> > > > > > On Fri, 28 Apr 2023 at 10:53, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
...
> > > > > R_X86_64_GOTPCRELX and R_X86_64_REX_GOTPCRELX relocations are supported
> > > > > in binutils 2.26 and later, but the mini version required for the kernel
> > > > > is 2.25. This option disables relocation relaxation, which makes GOT not
> > > > > empty. I also noticed this option in arch/x86/boot/compressed/Makefile
> > > > > with the reason given in [2]. Without relocation relaxation, GOT
> > > > > references would increase the size of GOT. Therefore, I do not want to
> > > > > use GOT reference in assembly directly.  However, I realized that the
> > > > > compiler could still generate GOT references in some cases such as
> > > > > "fentry" calls and stack canary references.
> > > > >
> > > >
> > > > The stack canary references are under discussion here [3]. I have also
> > > > sent a patch for kallsyms symbol references [4]. Beyond that, there
> > > > should be very few cases where GOT entries are emitted, so I don't
> > > > think this is fundamentally a problem.
> > > >
> > > > I haven't run into the __fentry__ issue myself: do you think we should
> > > > fix this in the compiler?
> > > >
> > > The issue about __fentry__ is that the compiler would generate 6-bytes
> > > indirect call through GOT with "-fPIE" option. However, the original
> > > ftrace nop patching assumes it is a 5-bytes direct call. And
> > > "-mnop-mcount" option is not compatiable with "-fPIE" option, so the
> > > complier woudn't patch it as nop.
> > >
> > > So we should patch it with one 5-bytes nop followed by one 1-byte nop,
> > > This way, ftrace can handle the previous 5-bytes as before. Also I have
> > > built PIE kernel with relocation relaxation on GCC, and the linker would
> > > relax it as following:
> > > ffffffff810018f0 <do_one_initcall>:
> > > ffffffff810018f0:       f3 0f 1e fa             endbr64
> > > ffffffff810018f4:       67 e8 a6 d6 05 00       addr32 call ffffffff8105efa0 <__fentry__>
> > >                         ffffffff810018f6: R_X86_64_PC32 __fentry__-0x4
> > >
> >
> > But if fentry is a function symbol, I would not expect the codegen to
> > be different at all. Are you using -fno-plt?
> >
> No, even with -fno-plt added, the compiler still generates a GOT
> reference for fentry. Therefore, the problem may be visibility, as you
> said.
>

Yeah, I spotted this issue in GCC - I just sent them a patch this morning.

> > > It still requires a different nop patching for ftrace. I notice
> > > "Optimize GOTPCRELX Relocations" chapter in x86-64 psABI, which suggests
> > > that the GOT indirect call can be relaxed as "call fentry nop" or "nop
> > > call fentry", it appears that the latter is chosen. If the linker could
> > > generate the former, then no fixup would be necessary for ftrace with
> > > PIE.
> > >
> >
> > Right. I think this may be a result of __fentry__ not being subject to
> > the same rules wrt visibility etc, similar to __stack_chk_guard. These
> > are arguably compiler issues that could qualify as bugs, given that
> > these symbol references don't behave like ordinary symbol references.
> >
> > > > > Regarding module loading, I agree that we should support GOT reference
> > > > > for the module itself. I will refactor it according to your suggestion.
> > > > >
> > > >
> > > > Excellent, good luck with that.
> > > >
> > > > However, you will still need to make a convincing case for why this is
> > > > all worth the trouble. Especially given that you disable the depth
> > > > tracking code, which I don't think should be mutually exclusive.
> > > >
> > > Actually, I could do relocation for it when apply patching for the
> > > depth tracking code. I'm not sure such case is common or not.
> > >
> >
> > I think that alternatives patching in general would need to support
> > RIP relative references in the alternatives. The depth tracking
> > template is a bit different in this regard, and could be fixed more
> > easily, I think.
> >
> > > > I am aware that this a rather tricky, and involves rewriting
> > > > RIP-relative per-CPU variable accesses, but it would be good to get a
> > > > discussion started on that topic, and figure out whether there is a
> > > > way forward there. Ignoring it is not going to help.
> > > >
> > > >
> > > I see that your PIE linking chose to put the per-cpu section in high
> > > kernel image address, I still keep it as zero-mapping. However, both are
> > > in the RIP-relative addressing range.
> > >
> >
> > Pure PIE linking cannot support the zero mapping - it can only work
> > with --emit-relocs, which I was trying to avoid.
> Sorry, why doesn't PIE linking support zero mapping? I noticed in the
> commit message for your PIE linking that it stated, "if we randomize the
> kernel's VA by increasing it by X bytes, every RIP-relative per-CPU
> reference needs to be decreased by the same amount in order for the
> produced offset to remain correct." As a result, I decided to decrease
> the GS base and not relocate the RIP-relative per-CPU reference in the
> relocs. Consequently, all RIP-relative references, regardless of whether
> they are per-CPU variables or not, do not require relocation.
>

Interesting. Does that work as expected with dynamically allocated
per-CPU variables?

> Furthermore, all symbols are hidden, which implies that all per-CPU
> references will not generate a GOT reference and will be relaxed as
> absolute reference due to zero mapping. However, the __stack_chk_guard
> on CLANG always generates a GOT reference, but I didn't see it being
> relaxed as absolute reference on LLVM.
>

Yeah, we should fix that.
