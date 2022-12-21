Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED765387D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiLUWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLUWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:23:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA062716F;
        Wed, 21 Dec 2022 14:23:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B22CB81BA5;
        Wed, 21 Dec 2022 22:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6167C433F0;
        Wed, 21 Dec 2022 22:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671661422;
        bh=a4YlhMKwpDx91P9/OqB5YgBJ3CZZKs0GBLO0nss4l5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gW5FaHCafpN8ZHL5irBlgHeFWBBO/ENKqAJyXcOmUTD05EsGlo0F23Di+6Itkj35X
         2JkRi9prJRsOH9MVAjKt07kLTzk9konccJ9E/1E/g/B4iE3Vv/pJ2jzhnBlgX56wVv
         mz2RJjDDGpuzmPi9CCiFFnpWxlY2fEk5xmomRZjRfzATOugR/Cf42Z84mJIJsfg+U+
         JtJLZZzN5vtKPy5MCC+yhO79taV+3t+yQV2/vu+Dlh51p/3/flMkLXhdvgQjPxiBMv
         iYWG31s1SNjYaSYZRi/cXz0JqV986Bt6O8kPvsQPRUq9CNS8KXpoG5IJFUd7W/93bU
         lzbkgNAYsMUNQ==
Date:   Wed, 21 Dec 2022 14:23:39 -0800
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
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v13 6/7] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y6OHa196S8e1mImg@sol.localdomain>
References: <20221221142327.126451-1-Jason@zx2c4.com>
 <20221221142327.126451-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221142327.126451-7-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 03:23:26PM +0100, Jason A. Donenfeld wrote:
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 6425f5f838e0..660cd15b6228 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -60,6 +60,7 @@
>  #include <crypto/blake2s.h>
>  #ifdef CONFIG_VDSO_GETRANDOM
>  #include <vdso/getrandom.h>
> +#include <vdso/datapage.h>
>  #endif
>  #include <asm/archrandom.h>
>  #include <asm/processor.h>
> @@ -407,6 +408,9 @@ static void crng_reseed(struct work_struct *work)
>	/*
>	 * We copy the new key into the base_crng, overwriting the old one,
>	 * and update the generation counter. We avoid hitting ULONG_MAX,
>	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
>	 * forces new CPUs that come online to always initialize.
>	 */
>	spin_lock_irqsave(&base_crng.lock, flags);
>	memcpy(base_crng.key, key, sizeof(base_crng.key));
>	next_gen = base_crng.generation + 1;
>  	if (next_gen == ULONG_MAX)
>  		++next_gen;
>  	WRITE_ONCE(base_crng.generation, next_gen);
> +#ifdef CONFIG_VDSO_GETRANDOM
> +	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> +#endif

It's confusing that "uninitialized generation" is ULONG_MAX in the per-cpu
crngs, but 0 in the vdso_rng_data.  That results in a weird off-by one thing,
where the vdso_rng_data generation number has to be 1 higher.

Would it be possible to use 0 for both?

- Eric
