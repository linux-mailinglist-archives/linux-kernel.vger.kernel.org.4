Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F7680737
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjA3IQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjA3IQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:16:28 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426712CFEF;
        Mon, 30 Jan 2023 00:16:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMPK9-005VfP-6V; Mon, 30 Jan 2023 16:15:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 30 Jan 2023 16:15:33 +0800
Date:   Mon, 30 Jan 2023 16:15:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix possible crash in GCM cryption
Message-ID: <Y9d8pfRQADxIhLIB@gondor.apana.org.au>
References: <20230118141928.48136-1-tianjia.zhang@linux.alibaba.com>
 <Y8gIC8Yn/E8Kwtf0@gondor.apana.org.au>
 <c7dbadbf-dade-fb1e-bda3-d23d567c620f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7dbadbf-dade-fb1e-bda3-d23d567c620f@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:34:42PM +0800, Tianjia Zhang wrote:
>
> I printed the walk->nbytes of each iteration of the walker, it is not
> always multiples of chunksize except at the end when the algorithm test
> manager is turned on.

Sorry I was mistaken.  We only guarantee that a minimum of chunksize
bytes is given to you until the very end, not that it is exactly a
multiple of chunksize.

While you still need to compute tail, you could get rid of the else if
check as walk->nbytes - tail cannot be zero (we must provide you with
at least one chunk before the end):

		if (walk->nbytes == walk->total) {
			tail = 0;

			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
					       walk->nbytes, ghash,
					       ctx->ghash_table,
					       (const u8 *)&lengths);
		} else {
			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
					       walk->nbytes - tail, ghash,
					       ctx->ghash_table, NULL);
		}

In fact we could rewrite it like this:

		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
		unsigned int nbytes = walk->nbytes - tail;
		const u8 *src = walk->src.virt.addr;
		u8 *dst = walk->dst.virt.addr;
		u8 *lp = NULL;

		if (walk->nbytes == walk->total) {
			nbytes = walk->nbytes;
			tail = 0;
			lp = (u8 *)&lengths;
		}

		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
				       nbytes, ghash, ctx->ghash_table, lp);

The second part of that loop could also be rewritten as:

		kernel_neon_end();

		err = skcipher_walk_done(walk, tail);
		if (!walk->nbytes)
			return err;

		kernel_neon_begin();
	} while (1);

Actually I think there is a serious bug here.  If you're doing an
empty message, you must not call skcipher_walk_done as that may
then free random uninitialised stack memory.

Did you copy this code from somewhere else? If so wherever you got
it from needs to be fixed too.  The loop should look like this:

	if (!walk->nbytes) {
		/* iv may be unaligned as the walker didn't run at all. */
		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, NULL, NULL, iv,
				       0, ghash, ctx->ghash_table,
				       (u8 *)&lengths);
		kernel_neon_end();
		return 0;
	}

	do {
		...
	}

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
