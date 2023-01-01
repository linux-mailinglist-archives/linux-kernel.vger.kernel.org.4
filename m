Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3373C65AA8E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAAQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 11:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:21:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEECDF4;
        Sun,  1 Jan 2023 08:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2939860DB6;
        Sun,  1 Jan 2023 16:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BDDC433D2;
        Sun,  1 Jan 2023 16:21:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B7fXcrzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672590087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgzwF4VoLQnS0Fhvwjzy5nnGU3HAw7Tv8mnPH+MHVYA=;
        b=B7fXcrzDtFe0E6aOSojyhoQ+zHfjlKZUEbLQpak5PFpzMuR6OhQ6NxVHT1k5S+/URafa+E
        /xLrpCuWjGNnff90wj7EXRhlp1/R5fIq2NmJWbZxiHyR6DAn4SfzD/0elrf7T9I6E6NWzs
        dLqoU1+To/CumIEdvGAfJoc5tu127xw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a210ec61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 1 Jan 2023 16:21:27 +0000 (UTC)
Date:   Sun, 1 Jan 2023 17:21:24 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v13 7/7] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <Y7GzBAt3uUhpfEJD@zx2c4.com>
References: <20221221142327.126451-1-Jason@zx2c4.com>
 <20221221142327.126451-8-Jason@zx2c4.com>
 <Y6OWSM18QL977nbC@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6OWSM18QL977nbC@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 03:27:04PM -0800, Eric Biggers wrote:
> On Wed, Dec 21, 2022 at 03:23:27PM +0100, Jason A. Donenfeld wrote:
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
> 
> For simplicity, maybe leave off the section mergeability stuff and just have
> plain ".section .rodata"?

I guess nothing is going to get merged anyway, so sure, why not.

> It would be worth mentioning in the function comment that none of the xmm
> registers are callee-save.  That was not obvious to me.  I know that on arm64,
> *kernel* code doesn't need to save/restore NEON registers, so it's not something
> that arch/arm64/crypto/ does.  But, it *is* needed in arm64 userspace code.  So
> I was worried that something similar would apply to x86_64, but it seems not.

I'll add a comment.

> 
> > +	/* state1[0,1,2,3] = state1[0,3,2,1] */
> > +	pshufd		$0x39,state1,state1
> > +	/* state2[0,1,2,3] = state2[1,0,3,2] */
> > +	pshufd		$0x4e,state2,state2
> > +	/* state3[0,1,2,3] = state3[2,1,0,3] */
> > +	pshufd		$0x93,state3,state3
> 
> The comments don't match the pshufd constants.  The code is correct but the
> comments are not.  They should be:

Er, I swapped the endian when writing the comment. The code is fine
though, yea. Fixed, thanks.

> The above sequence of 24 instructions is repeated twice, so maybe it should be a
> macro (".chacha_round"?).

Not really a fan of the indirection when reading for something simple
like this.

Thanks for the review.

Jason
