Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91B56A3C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjB0IVC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Feb 2023 03:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB0IVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:21:00 -0500
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 00:20:54 PST
Received: from ouvsmtp1.octopuce.fr (ouvsmtp1.octopuce.fr [194.36.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0461B337;
        Mon, 27 Feb 2023 00:20:54 -0800 (PST)
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
        by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id A80431647;
        Mon, 27 Feb 2023 09:13:41 +0100 (CET)
Received: from sm.ouvaton.coop (ouvadm.octopuce.fr [194.36.166.2])
        by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id 751185E1520;
        Mon, 27 Feb 2023 09:13:41 +0100 (CET)
MIME-Version: 1.0
Date:   Mon, 27 Feb 2023 08:13:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
From:   "Yann Droneaud" <ydroneaud@opteya.com>
Message-ID: <c18250f8126b92478e31817c4162286a31983f51@opteya.com>
Subject: Re: [PATCH] crypto: testmgr - fix RNG performance in fuzz tests
To:     "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227055018.1713117-1-ebiggers@kernel.org>
References: <20230227055018.1713117-1-ebiggers@kernel.org>
X-Originating-IP: 10.0.20.16
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

27 février 2023 à 06:52 "Eric Biggers" <ebiggers@kernel.org> a écrit:
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> The performance of the crypto fuzz tests has greatly regressed since
> v5.18. When booting a kernel on an arm64 dev board with all software
> crypto algorithms and CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled, the
> fuzz tests now take about 200 seconds to run, or about 325 seconds with
> lockdep enabled, compared to about 5 seconds before.
> 
> The root cause is that the random number generation has become much
> slower due to commit d4150779e60f ("random32: use real rng for
> non-deterministic randomness"). On my same arm64 dev board, at the time
> the fuzz tests are run, get_random_u8() is about 345x slower than
> prandom_u32_state(), or about 469x if lockdep is enabled.
> 
> Lockdep makes a big difference, but much of the rest comes from the
> get_random_*() functions taking a *very* slow path when the CRNG is not
> yet initialized. Since the crypto self-tests run early during boot,
> even having a hardware RNG driver enabled (CONFIG_CRYPTO_DEV_QCOM_RNG in
> my case) doesn't prevent this. x86 systems don't have this issue, but
> they still see a significant regression if lockdep is enabled.
> 
> Converting the "Fully random bytes" case in generate_random_bytes() to
> use get_random_bytes() helps significantly, improving the test time to
> about 27 seconds. But that's still over 5x slower than before.
> 
> This is all a bit silly, though, since the fuzz tests don't actually
> need cryptographically secure random numbers. So let's just make them
> use a non-cryptographically-secure RNG as they did before. The original
> prandom_u32() is gone now, so let's use prandom_u32_state() instead,
> with an explicitly managed state, like various other self-tests in the
> kernel source tree (rbtree_test.c, test_scanf.c, etc.) already do. This
> also has the benefit that no locking is required anymore, so performance
> should be even better than the original version that used prandom_u32().
> 
> Fixes: d4150779e60f ("random32: use real rng for non-deterministic randomness")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/testmgr.c | 268 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 171 insertions(+), 97 deletions(-)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index c91e93ece20b..2cbd2f8ce3c3 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -860,12 +860,52 @@ static int prepare_keybuf(const u8 *key, unsigned int ksize,
>  
>  #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
>  
> +/*
> + * The fuzz tests use prandom instead of the normal Linux RNG since they don't
> + * need cryptographically secure random numbers. This greatly improves the
> + * performance of these tests, especially if they are run before the Linux RNG
> + * has been initialized or if they are run on a lockdep-enabled kernel.
> + */
> +
> +static inline void init_rnd_state(struct rnd_state *rng)
> +{
> + static atomic64_t next_seed;
> +
> + prandom_seed_state(rng, atomic64_inc_return(&next_seed));

Isn't making this deterministic defeating the purpose of fuzzing ?

Regards.

-- 
Yann Droneaud
OPTEYA
