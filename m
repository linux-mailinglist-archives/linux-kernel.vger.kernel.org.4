Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AA619D02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKDQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiKDQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:20:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7084AF27
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A3DBB80C6A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815D7C433D6;
        Fri,  4 Nov 2022 16:19:54 +0000 (UTC)
Date:   Fri, 4 Nov 2022 16:19:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y2U7pjN5B9T9KcQr@arm.com>
References: <20221027112741.1678057-1-ardb@kernel.org>
 <Y2TIqcfxFaThC4d5@sol.localdomain>
 <CAMj1kXFv5gyp=jkgHPJPT9nLW16jpBF4rdo6tDCZYAPgkRma3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFv5gyp=jkgHPJPT9nLW16jpBF4rdo6tDCZYAPgkRma3Q@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:29:10AM +0100, Ard Biesheuvel wrote:
> On Fri, 4 Nov 2022 at 09:09, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> > > Given that running privileged code with DIT disabled on a CPU that
> > > implements support for it may result in a side channel that exposes
> > > privileged data to unprivileged user space processes, let's enable DIT
> > > while running in the kernel if supported by all CPUs.
> >
> > This patch looks good to me, though I'm not an expert in low-level arm64 stuff.
> > It's a bit unfortunate that we have to manually create the .inst to enable DIT
> > instead of just using the assembler.  But it looks like there's a reason for it
> > (it's done for PAN et al. too), and based on the manual it looks correct.
> 
> Yes. The reason is that the assembler requires -march=armv8.2-a to be
> passed when using the DIT register (and similar requirements apply to
> the other registers). However, doing so may result in object code that
> can no longer run on pre-v8.2 cores, whereas the DIT accesses
> themselves are only emitted in a carefully controlled manner anyway,
> so keeping the arch baseline to v8.0 and using .inst is the cleanest
> way around this.

We worked around this already by defining asm-arch in
arch/arm64/Makefile to the latest that the assembler supports while
keeping the C compiler on armv8.0. Unlike the C compiler, the assembler
shouldn't generate new instructions unless specifically asked through
inline asm or .S files. We use this trick for MTE already (and LSE
atomics), though we needed another __MTE_PREAMBLE as armv8.5-a wasn't
sufficient for these instructions.

I think we ended up with .inst initially as binutils did not support
some of those instructions. We could try to clean them up but it's a bit
of a hassle to check which versions your binutils supports.

-- 
Catalin
