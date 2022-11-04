Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5732E619D84
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKDQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiKDQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:41:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394AC3F064
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B38E4B82ED8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC87C43143
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667580043;
        bh=ntRAKbBYNWlX+LKMjOPFMzVDA2vJlFmB4vJ1n9WugN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ir+ZohAhM2+/xuVD4BoGesVI38EMwbKMBOhUq5lLk5D4L3Hmhb++aZ+abXWPYsEbn
         +Tx7R0Z3ACe94HWLThGPvDwUfGTj8ov5MwPQtc805MRNHkjWbwf2NowXMZaQX9T12j
         8iVIQ0N6pUN1TFLfl992pfiyT0JQMDoIUxHZFWW56mQSHUKbCtbzEGbm9y6S/mm+MU
         8im7jUgBT6qI2uYhenvXICZqG0RQjXtwRF8ERIj3dXprq2+J65sIt0cO7DKk/kvkNR
         XruK2X644tqRnT5lsF9+1bHix3LMDX1bigiLXb15MZwNOx/IX2r28vTr1n5FZied61
         qJ2XjU+wBt9WA==
Received: by mail-lf1-f41.google.com with SMTP id d6so8126973lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:40:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2doZCfJnfvZvtX9yDqCffr33QJt9hB2P5B+8vIqX7IezzJx99m
        p9Rb5SevdQDJYGZa0y93GKXKMeD3YNdQ4WX8d3Q=
X-Google-Smtp-Source: AMsMyM4Aaec0D5FkxA2TQOlyMcolf6j7EwVqf78RDFEWIyIzH8M2N5m1RLKcU1bSr8UvHfNdJJ9srbOooPSjY1Hoa6U=
X-Received: by 2002:a19:4f53:0:b0:4b1:1f35:279b with SMTP id
 a19-20020a194f53000000b004b11f35279bmr7248289lfk.637.1667580041308; Fri, 04
 Nov 2022 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221027112741.1678057-1-ardb@kernel.org> <Y2TIqcfxFaThC4d5@sol.localdomain>
 <CAMj1kXFv5gyp=jkgHPJPT9nLW16jpBF4rdo6tDCZYAPgkRma3Q@mail.gmail.com> <Y2U7pjN5B9T9KcQr@arm.com>
In-Reply-To: <Y2U7pjN5B9T9KcQr@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 4 Nov 2022 17:40:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGY5P_gnYpeMiucZvEHW-3_tcj4nr9XjgMcZFJXuLB9kw@mail.gmail.com>
Message-ID: <CAMj1kXGY5P_gnYpeMiucZvEHW-3_tcj4nr9XjgMcZFJXuLB9kw@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 17:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Nov 04, 2022 at 10:29:10AM +0100, Ard Biesheuvel wrote:
> > On Fri, 4 Nov 2022 at 09:09, Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> > > > Given that running privileged code with DIT disabled on a CPU that
> > > > implements support for it may result in a side channel that exposes
> > > > privileged data to unprivileged user space processes, let's enable DIT
> > > > while running in the kernel if supported by all CPUs.
> > >
> > > This patch looks good to me, though I'm not an expert in low-level arm64 stuff.
> > > It's a bit unfortunate that we have to manually create the .inst to enable DIT
> > > instead of just using the assembler.  But it looks like there's a reason for it
> > > (it's done for PAN et al. too), and based on the manual it looks correct.
> >
> > Yes. The reason is that the assembler requires -march=armv8.2-a to be
> > passed when using the DIT register (and similar requirements apply to
> > the other registers). However, doing so may result in object code that
> > can no longer run on pre-v8.2 cores, whereas the DIT accesses
> > themselves are only emitted in a carefully controlled manner anyway,
> > so keeping the arch baseline to v8.0 and using .inst is the cleanest
> > way around this.
>
> We worked around this already by defining asm-arch in
> arch/arm64/Makefile to the latest that the assembler supports while
> keeping the C compiler on armv8.0. Unlike the C compiler, the assembler
> shouldn't generate new instructions unless specifically asked through
> inline asm or .S files. We use this trick for MTE already (and LSE
> atomics), though we needed another __MTE_PREAMBLE as armv8.5-a wasn't
> sufficient for these instructions.
>
> I think we ended up with .inst initially as binutils did not support
> some of those instructions. We could try to clean them up but it's a bit
> of a hassle to check which versions your binutils supports.
>

OK, good to know.

However, I double checked, and DIT needs v8.4-a (not v8.2 as i
mentioned above), and my ubuntu 16.04 toolchain, which has GCC 5.3,
only goes up to v8.2

So I guess we should be able to fix this at /some/ point, but for now,
I'll need to stick with the __inst()
