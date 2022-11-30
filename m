Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E744163CEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiK3FWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiK3FWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:22:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972556B396;
        Tue, 29 Nov 2022 21:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57510B81A37;
        Wed, 30 Nov 2022 05:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AD5C433C1;
        Wed, 30 Nov 2022 05:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669785734;
        bh=kp7WrFOhYksNbx5hSZrR0P6GQW+jjejcFItXGpMwjuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7e4TcFRKI6SKCJ3Jo7T6DMMTmBLDYl7kgEuCaU3GL62v9QJ7pu3nkDOzsuUcPEbJ
         I4gxpzy8q5hJKOPPEr2iRzHJ8I9C1YDUfPm/WVWs1tWsfhqryDfJqvQNbnhJyeuWlZ
         54yT2zJ1bY7TVv4ZuQDHl/j7qRIcA6eoLNYV1Co50EImkOgTh/0vU0GwVvVMPD2BVb
         n3o8OGXsJlTFg8WO3u1WHCNciibGiA9xA7EQxL/bKZZbfOxbxItLxbGpjckClwNm/2
         tO3FJCfpbTCEtJ2Qo3d7rOTFnyNL7CUtHwAzIrQNcWnJ+ejjJ60fkfBWbzcUqLHeSQ
         32xjL9vaYLEVg==
Date:   Tue, 29 Nov 2022 21:22:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Message-ID: <Y4bogxKW6MPoUfMA@sol.localdomain>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129210639.42233-5-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:06:39PM +0100, Jason A. Donenfeld wrote:
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
> +
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

How was this ChaCha20 implementation tested?

It really ought to have some sort of test.

Wouldn't this be a good candidate for a KUnit test?

- Eric
