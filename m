Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF963B22E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiK1TX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiK1TXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:23:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1C6350;
        Mon, 28 Nov 2022 11:23:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888ED6141B;
        Mon, 28 Nov 2022 19:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF66C433D7;
        Mon, 28 Nov 2022 19:23:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DpYMLOrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669663402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oH13CIpQ/7n5BcQUws9hK24sibfqfJzuMBXnlvB67Q4=;
        b=DpYMLOrZ793QCRyuTlQZN8qqEqS0HrsmmXwLJXR5bz/I+2EzFAN6zgzuziiNQ1ACLVDKSU
        xumueI67SFzmkHSLrNNqv/jNvMERoZYAVRw4+2heDbLejJ7rYRWj3zOZBbIJLj9uRcbO1g
        go7AJhYWsDuGtykFsUQekMM4/S4kL3M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b5fc3b82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 19:23:22 +0000 (UTC)
Date:   Mon, 28 Nov 2022 20:23:16 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v8 3/3] x86: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Y4UKpP7/NOwPIkYe@zx2c4.com>
References: <20221128111829.2477505-1-Jason@zx2c4.com>
 <20221128111829.2477505-4-Jason@zx2c4.com>
 <8f9326ba-f879-4b9e-9e5d-b65cad7cd726@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f9326ba-f879-4b9e-9e5d-b65cad7cd726@app.fastmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Nov 28, 2022 at 08:18:12PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 28, 2022, at 12:18, Jason A. Donenfeld wrote:
> > Hook up the generic vDSO implementation to the x86 vDSO data page. Since
> > the existing vDSO infrastructure is heavily based on the timekeeping
> > functionality, which works over arrays of bases, a new macro is
> > introduced for vvars that are not arrays.
> >
> > Also enable the vgetrandom_alloc() syscall, which the vDSO
> > implementation relies on.
> >
> > The vDSO function requires a ChaCha20 implementation that does not write
> > to the stack, yet can still do an entire ChaCha20 permutation, so
> > provide this using SSE2, since this is userland code that must work on
> > all x86-64 processors.
> >
> > Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/x86/Kconfig                        |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
> 
> I see that this enables the syscall in x86-64, while patch 1
> adds it to the eight architecures that use 
> include/uapi/asm-generic/unistd.h (with the __ARCH_WANT_*
> guard at the moment, but you already said that will be removed)
> 
> I think ideally the syscall.tbl and unistd.h changes should be done
> in one patch for all architectures that doesn't mix it with
> any other changes. In particular I think it should be separate
> from the vdso changes, but could be in the patch that implements
> the syscall.

That's more or less how v7 was, but Thomas thought the x86 stuff should
be separate. So for v8, the organization is:

1) generic syscall
2) generic vdso
3) x86 wiring

The primary advantage is that future archs wanting to add this now can
just look at commit (3) only, and make a similar commit for that new
arch.

If you think a different organization outweighs that advantage, can you
spell out what division of patches you want, and I'll do that for v9?
Or maybe this v8 is okay?

Jason
