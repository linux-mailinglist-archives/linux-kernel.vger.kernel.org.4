Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235246527F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiLTUeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiLTUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:34:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C97FA;
        Tue, 20 Dec 2022 12:34:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFB3B8133B;
        Tue, 20 Dec 2022 20:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B335C433EF;
        Tue, 20 Dec 2022 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671568460;
        bh=ZpDboU70AuwgCMB7rmWdlbACrVOmBDBpoLpC/ji7esY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nri9+1AVWka/i9XSGOFX5YomLKxf7ybZR/JF+ApDsAkxJxFXnQYLCsOC0/I0AN/lX
         VLhyLWOlMzpOCy4B1dIWtMU0wSKwglvEHbsad3/dyBOePeDaReRokdsra6PqeaR4Zz
         Pbux7j5lub2IbPqOg/llzb9VmaDyTngy3Eg19+VeuTWcywg055XSRsUmCOfa6l8z1F
         2kD92+PH4IIZLQ1Is/BzytR9HORQeFYpKJg/Mbn54cPMyMioux4n4YBWeg9bfWajpT
         nVyb/neZnpz2zVm8bTipzdh1rr2pDMIbgMcDsX+RUkVZVhLLiFNF8aeQfVIoUIGRFS
         KevaXpH+IWVOA==
Date:   Tue, 20 Dec 2022 20:34:18 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/blake2s - Split up test function to halve
 stack usage
Message-ID: <Y6IcSgmXpGwWP+xK@gmail.com>
References: <202211072109.qvrnjNKo-lkp@intel.com>
 <Y5Flnb8jadyDebx3@gondor.apana.org.au>
 <d25ac395-4335-be88-9dc5-364f5715554f@intel.com>
 <Y5V3JUL+r4k/XrL9@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5V3JUL+r4k/XrL9@gondor.apana.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 02:22:29PM +0800, Herbert Xu wrote:
> On Thu, Dec 08, 2022 at 02:37:45PM +0800, Chen, Rong A wrote:
> >
> > Thanks for the information, I checked the result of the fix commit,
> > it reduced the stack frame but the warning still exists:
> > 
> > lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1056 bytes
> > is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Sorry, I didn't realise that you could still reproduce it.  I tried
> reproducing it on multiple architectures and failed (all were in
> the 900 range).
> 
> Anyhow, this patch reduces it by half for me so hopefully it should
> put this to rest.
> 
> ---8<---
> Reduce the stack usage further by splitting up the test function.
> 
> Also squash blocks and unaligned_blocks into one array.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/lib/crypto/blake2s-selftest.c b/lib/crypto/blake2s-selftest.c
> index 7d77dea15587..484b89332c83 100644
> --- a/lib/crypto/blake2s-selftest.c
> +++ b/lib/crypto/blake2s-selftest.c
> @@ -545,7 +545,7 @@ static const u8 blake2s_testvecs[][BLAKE2S_HASH_SIZE] __initconst = {
>      0xd6, 0x98, 0x6b, 0x07, 0x10, 0x65, 0x52, 0x65, },
>  };
>  
> -bool __init blake2s_selftest(void)
> +static bool __init blake2s_digest_test(void)
>  {
>  	u8 key[BLAKE2S_KEY_SIZE];
>  	u8 buf[ARRAY_SIZE(blake2s_testvecs)];
> @@ -589,11 +589,20 @@ bool __init blake2s_selftest(void)
>  		}
>  	}
>  
> +	return success;
> +}
> +
> +static bool __init blake2s_random_test(void)
> +{
> +	struct blake2s_state state;
> +	bool success = true;
> +	int i, l;
> +

Shouldn't these functions have 'noinline_for_stack' added to them?

- Eric
