Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914963D2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiK3KN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiK3KNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:13:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954626115;
        Wed, 30 Nov 2022 02:13:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA8D61AC1;
        Wed, 30 Nov 2022 10:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5A3C433D6;
        Wed, 30 Nov 2022 10:13:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DGe4Sg6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669803183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5KI5VqdE2HlpGgQETwndCJAiSwaxm//4zOl9xpJ4S8=;
        b=DGe4Sg6EMFRDuXK+3mXubUliwNKatSdYQ4syzXMR8t1iBD8BX96A8AVw+PCG4dHSuYLEgb
        zQQJfKGJ5HqbCAc2+mguXc6WYO8Y8ZEMsj2U/F2iCZiy3bRMywQ8lxqXsvDFEqtbFYL+i1
        bFlgyQ1y6D53hKrVM7xuNtqbINxs0KU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a89ed82a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 10:13:03 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:12:57 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v10 4/4] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <Y4csqTw5pY8W82Nh@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-5-Jason@zx2c4.com>
 <Y4bogxKW6MPoUfMA@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4bogxKW6MPoUfMA@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Nov 29, 2022 at 09:22:11PM -0800, Eric Biggers wrote:
> On Tue, Nov 29, 2022 at 10:06:39PM +0100, Jason A. Donenfeld wrote:
> > diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > new file mode 100644
> > index 000000000000..91fbb7ac7af4
> > --- /dev/null
> > +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/frame.h>
> > +
> > +.section	.rodata.cst16.CONSTANTS, "aM", @progbits, 16
> > +.align 16
> > +CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
> > +.text
> > +
> > +/*
> > + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> > + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> > + * counter. Importantly does not spill to the stack. Its arguments are:
> > + *
> > + *	rdi: output bytes
> > + *	rsi: 32-byte key input
> > + *	rdx: 8-byte counter input/output
> > + *	rcx: number of 64-byte blocks to write to output
> > + */
> > +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> 
> How was this ChaCha20 implementation tested?
> 
> It really ought to have some sort of test.

I've been comparing different output lengths with what libsodium
produces. ARX, so no bigint stuff with carry bugs or whatever. I'll see
if I can make a good test to add to one of the various suites for v11.

Jason
