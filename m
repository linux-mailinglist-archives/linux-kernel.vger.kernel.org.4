Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609426519D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLTD6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTD6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:58:34 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE907632B;
        Mon, 19 Dec 2022 19:58:32 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7TlG-008kIf-61; Tue, 20 Dec 2022 11:57:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 11:57:50 +0800
Date:   Tue, 20 Dec 2022 11:57:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, Jason@zx2c4.com, ardb@kernel.org,
        ap420073@gmail.com, David.Laight@aculab.com, ebiggers@kernel.org,
        tim.c.chen@linux.intel.com, peter@n8pjl.ca, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Message-ID: <Y6Eyvo7z8uHRF46G@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219220223.3982176-4-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:02:13PM -0600, Robert Elliott wrote:
>
> +void __sha1_transform_ssse3(struct sha1_state *state, const u8 *data, int blocks)
> +{
> +	if (blocks <= 0)
> +		return;
> +
> +	kernel_fpu_begin();
> +	for (;;) {
> +		const int chunks = min(blocks, 4096 / SHA1_BLOCK_SIZE);
> +
> +		sha1_transform_ssse3(state->state, data, chunks);
> +		data += chunks * SHA1_BLOCK_SIZE;
> +		blocks -= chunks;
> +
> +		if (blocks <= 0)
> +			break;
> +
> +		kernel_fpu_yield();

Shouldn't this check the MAY_SLEEP flag?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
