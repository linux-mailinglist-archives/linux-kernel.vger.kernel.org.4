Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C44C62BB85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiKPLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiKPLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:24:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92EF42982;
        Wed, 16 Nov 2022 03:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 605DFB81D12;
        Wed, 16 Nov 2022 11:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F29C433C1;
        Wed, 16 Nov 2022 11:13:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E3/4Gpvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668597234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ylrg0SsUWEb5UrvQ3bI3xRlXJhotHztN4QI+A1cTNhE=;
        b=E3/4Gpvq7eozER+CzL+Fc/nltatyJoeAH8kG8qDz6DTEStIaglfRU8PYfhUMi4NiIa9sA/
        mvZdievfIUYhDqB/UI1S/d9CqOHzfZYOvzeWoWmHR4FcpCK9D3pnj4Vz7An/F1T8jXXWVz
        ftpqksTXFVSWSuTwg9of2+C8dBmvIXQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af8c1a0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 11:13:54 +0000 (UTC)
Date:   Wed, 16 Nov 2022 12:13:51 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Message-ID: <Y3TF7/+DejcnN0eV@zx2c4.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116041342.3841-11-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:13:28PM -0600, Robert Elliott wrote:
> +/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
> +static const unsigned int bytes_per_fpu = 337 * 1024;
> +

Use an enum for constants like this:

    enum { BYTES_PER_FPU = ... };

You can even make it function-local, so it's near the code that uses it,
which will better justify its existence.

Also, where did you get this number? Seems kind of weird.

>  asmlinkage void nh_avx2(const u32 *key, const u8 *message, size_t message_len,
>  			u8 hash[NH_HASH_BYTES]);
>  
> @@ -26,18 +29,20 @@ static void _nh_avx2(const u32 *key, const u8 *message, size_t message_len,
>  static int nhpoly1305_avx2_update(struct shash_desc *desc,
>  				  const u8 *src, unsigned int srclen)
>  {
> +	BUILD_BUG_ON(bytes_per_fpu == 0);

Make the constant function local and remove this check.

> +7
>  	if (srclen < 64 || !crypto_simd_usable())
>  		return crypto_nhpoly1305_update(desc, src, srclen);
>  
> -	do {
> -		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
> +	while (srclen) {

Does this add a needless additional check or does it generate better
code? Would be nice to have some explanation of the rationale.

Same comments as above apply for the rest of this patch ans series.
