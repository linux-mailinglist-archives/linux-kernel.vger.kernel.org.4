Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A376539CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLUX1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLUX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:27:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6B1BE85;
        Wed, 21 Dec 2022 15:27:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E9D06196F;
        Wed, 21 Dec 2022 23:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64466C433EF;
        Wed, 21 Dec 2022 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671665226;
        bh=z/T5QRAMwI/aM2wSsvcjJlnhhFOn5MGclCR919Yyc9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBJBAqiV8Y6Yn0s72mlVPq8NAGCYsJ2iv06chckorAsZ5hhjyx/uzq4Lm29vAxN0O
         7DRljHogOCCn5utlXE7SwE77nd0MXxaARNjaoS69qIWH3sVOvh903lXm0CYwhiI2/z
         VHY7BUWmJgT5iiI8sFnpc8KYrHij+Pg4AtH3CKQsJsZMPyto/DxYyVLHloauo7j0vu
         BQPjeMGA6i2LiXH/0yGHme4NjpvQZ8AZvistVUBPmDs1QQjfu8cAovssywwzNtoMP2
         tk1MER+XsHax/ErTIGc+eHak8dntLfFH4R3ltAzbQ+OIqGlXOIRzv/XbANpRrFWg5y
         QqU2H7eBjYjcg==
Date:   Wed, 21 Dec 2022 15:27:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Message-ID: <Y6OWSM18QL977nbC@sol.localdomain>
References: <20221221142327.126451-1-Jason@zx2c4.com>
 <20221221142327.126451-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221142327.126451-8-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 03:23:27PM +0100, Jason A. Donenfeld wrote:
> diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
> new file mode 100644
> index 000000000000..91fbb7ac7af4
> --- /dev/null
> +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/frame.h>
> +
> +.section	.rodata.cst16.CONSTANTS, "aM", @progbits, 16
> +.align 16
> +CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
> +.text

For simplicity, maybe leave off the section mergeability stuff and just have
plain ".section .rodata"?

> +/*
> + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> + * counter. Importantly does not spill to the stack. Its arguments are:
> + *
> + *	rdi: output bytes
> + *	rsi: 32-byte key input
> + *	rdx: 8-byte counter input/output
> + *	rcx: number of 64-byte blocks to write to output
> + */
> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> +
> +#define output  %rdi
> +#define key     %rsi
> +#define counter %rdx
> +#define nblocks %rcx
> +#define i       %al
> +#define state0  %xmm0
> +#define state1  %xmm1
> +#define state2  %xmm2
> +#define state3  %xmm3
> +#define copy0   %xmm4
> +#define copy1   %xmm5
> +#define copy2   %xmm6
> +#define copy3   %xmm7
> +#define temp    %xmm8
> +#define one     %xmm9

It would be worth mentioning in the function comment that none of the xmm
registers are callee-save.  That was not obvious to me.  I know that on arm64,
*kernel* code doesn't need to save/restore NEON registers, so it's not something
that arch/arm64/crypto/ does.  But, it *is* needed in arm64 userspace code.  So
I was worried that something similar would apply to x86_64, but it seems not.

> +	/* state1[0,1,2,3] = state1[0,3,2,1] */
> +	pshufd		$0x39,state1,state1
> +	/* state2[0,1,2,3] = state2[1,0,3,2] */
> +	pshufd		$0x4e,state2,state2
> +	/* state3[0,1,2,3] = state3[2,1,0,3] */
> +	pshufd		$0x93,state3,state3

The comments don't match the pshufd constants.  The code is correct but the
comments are not.  They should be:

	/* state1[0,1,2,3] = state1[1,2,3,0] */
	pshufd		$0x39,state1,state1
	/* state2[0,1,2,3] = state2[2,3,0,1] */
	pshufd		$0x4e,state2,state2
	/* state3[0,1,2,3] = state3[3,0,1,2] */
	pshufd		$0x93,state3,state3

> +	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
> +	paddd		state1,state0
> +	pxor		state0,state3
> +	movdqa		state3,temp
> +	pslld		$16,temp
> +	psrld		$16,state3
> +	por		temp,state3
> +
> +	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
> +	paddd		state3,state2
> +	pxor		state2,state1
> +	movdqa		state1,temp
> +	pslld		$12,temp
> +	psrld		$20,state1
> +	por		temp,state1
> +
> +	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
> +	paddd		state1,state0
> +	pxor		state0,state3
> +	movdqa		state3,temp
> +	pslld		$8,temp
> +	psrld		$24,state3
> +	por		temp,state3
> +
> +	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
> +	paddd		state3,state2
> +	pxor		state2,state1
> +	movdqa		state1,temp
> +	pslld		$7,temp
> +	psrld		$25,state1
> +	por		temp,state1

The above sequence of 24 instructions is repeated twice, so maybe it should be a
macro (".chacha_round"?).

> +	/* state1[0,1,2,3] = state1[2,1,0,3] */
> +	pshufd		$0x93,state1,state1
> +	/* state2[0,1,2,3] = state2[1,0,3,2] */
> +	pshufd		$0x4e,state2,state2
> +	/* state3[0,1,2,3] = state3[0,3,2,1] */
> +	pshufd		$0x39,state3,state3

Similarly, the above comments are wrong.  They should be:

	/* state1[0,1,2,3] = state1[3,0,1,2] */
	pshufd		$0x93,state1,state1
	/* state2[0,1,2,3] = state2[2,3,0,1] */
	pshufd		$0x4e,state2,state2
	/* state3[0,1,2,3] = state3[1,2,3,0] */
	pshufd		$0x39,state3,state3

- Eric
