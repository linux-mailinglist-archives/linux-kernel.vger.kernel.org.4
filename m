Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD966F2128
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346782AbjD1XUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjD1XUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DB49DA;
        Fri, 28 Apr 2023 16:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D3F6171A;
        Fri, 28 Apr 2023 23:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED74AC433EF;
        Fri, 28 Apr 2023 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682724006;
        bh=cIqm3XTL0SG2Eh3M38737ND7Xx7N1gvN2VlCssMaT80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qduOYs9UigQVQhE+1Tqthv8UtsnibtIOE7Nh74kF5jb/uCPDKveP9wqLSWQMGbj/k
         xlm4JsiX4/AiKmyjZq63KcnWwx4nC9BxpBMVFeT9MgbohJ4mFnlOjYpdibsIXwLECs
         h+NZ1tCGbBD2RcEHlxKcAiQimS9f/gTX/j7EhM95JvbE0OdUHhB3l+MmQ87K5JgYQP
         7fl89K6nAczkClmmOC5fOZseW9ScS+d+4iVAuw1K97cZDHSP5qi8ojvxX8M6yTjAb2
         AossC/JSf3Mpbksmr8MKzgqzTotU54us1Dqg0dS+K9oaDS0wbowMtoPmXNR3uBNx5S
         5keHczeR6v4Mw==
Date:   Fri, 28 Apr 2023 16:19:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dongsoo Lee <letrhee@nsr.re.kr>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>,
        Dongsoo Lee <letrhee@gmail.com>
Subject: Re: [PATCH 0/3] crypto: LEA block cipher implementation
Message-ID: <20230428231952.GA3150@sol.localdomain>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428110058.1516119-1-letrhee@nsr.re.kr>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongsoo,

On Fri, Apr 28, 2023 at 08:00:55PM +0900, Dongsoo Lee wrote:
> The Korean e-government framework contains various cryptographic
> applications, and KCMVP-validated cryptographic module should be used
> according to the government requirements. The ARIA block cipher, which
> is already included in Linux kernel, has been widely used as a symmetric
> key cipher. However, the adoption of LEA increase rapidly for new
> applications.
> 
> By adding LEA to the Linux kernel, Dedicated device drivers that require
> LEA encryption can be provided without additional crypto implementation.
> An example of an immediately applicable use case is disk encryption
> using cryptsetup.
> 
> The submitted implementation includes a generic C implementation that
> uses 32-bit ARX operations, and an optimized implementation for the
> x86_64 environment.

Can you elaborate further on the use case for this cipher?  Your description
above is very vague.  What is the actual use case when so many other ciphers
already exist, including much better studied ones?  Are people being required to
use this cipher, and if so under what situations?  There is also already another
"national pride" block cipher from Korea (ARIA); do we really need another one?

BTW, in 2018, I investigated LEA and various other ciphers as options for
storage encryption on ARM processors without the crypto extensions.  We ended up
not selecting LEA for several different reasons (e.g. see
https://lore.kernel.org/r/20180507232000.GA194688@google.com), and we later
created Adiantum for the use case.  But, it sounds like "storage encryption on
processors without crypto instructions" isn't the use case you have in mind at
all anyway, seeing as the only assembly code you're providing is for x86_64.
What sort of use case do you actually have in mind?  Is this perhaps a PhD
thesis type of thing that won't actually be used in a real world application?

IIRC, one of the issues with LEA was that the LEA paper doesn't provide test
vectors, so I couldn't be certain that I had actually implemented the algorithm
correctly.  It sounds like there are now test vectors available.  How confident
are you that they actually match the original algorithm?

> The implementation has been tested with kernel module tcrypt.ko and has
> passed the selftest using test vectors for KCMVP[4]. The path also test
> with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.

There is a KASAN out-of-bounds error in lea_set_key() when running the
self-tests.

- Eric
