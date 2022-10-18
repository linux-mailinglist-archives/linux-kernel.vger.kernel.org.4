Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FEA60361C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJRWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJRWjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B2193;
        Tue, 18 Oct 2022 15:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4BD6170E;
        Tue, 18 Oct 2022 22:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DE9C433D6;
        Tue, 18 Oct 2022 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666132767;
        bh=nXQu6c9zXmXOQ1HwOdodGaaAxPLFBITWpD9z3hLUZls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyEgo97Cn7hfLcChk3T+cX7WuaWJRd+H+O2qLouS2yjdVjByS6mGcdMHOnE9Ksa8W
         eIUZ7Z1faq/NHabkMENSDpkwOsP+dvgHve8kxug1V1pNPe6Tgozt71U+e5db+c/wbb
         MmQ5fQPXoLPTlsqhEBQ5dH4l/q5Rlu/p4AgFpEWRu+OFFz8eGkNaYxQlOkQRzmeH+Y
         O7ULolO2gdyfipuy6v1IgbhWdUO5r8XIe/eUgg851ZKhSn7oqfurwjfWrXglK6LA/F
         NWCuAGMm+uQzeh9+8IHrDIXVSxUOLFmPS1LStyLbd0KuxkRbN7NdwLThnpn2/tgfMG
         +EQXqzP0TJbrg==
Date:   Tue, 18 Oct 2022 15:39:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     herbert@gondor.apana.org.au, ardb@kernel.org, bgoncalv@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v2] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
Message-ID: <Y08rHF09/qxCVK+K@sol.localdomain>
References: <Y04lhwMechdfBkUU@gondor.apana.org.au>
 <20221018215623.866014-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018215623.866014-1-nhuck@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:56:23PM -0700, Nathan Huckleberry wrote:
> -static void internal_polyval_update(const struct polyval_tfm_ctx *keys,
> +static inline struct polyval_tfm_ctx *polyval_tfm_ctx(const void *raw_ctx)
> +{
> +	unsigned long addr = (unsigned long)raw_ctx;
> +	unsigned long align = POLYVAL_ALIGN;
> +
> +	if (align <= crypto_tfm_ctx_alignment())
> +		align = 1;
> +	return (struct polyval_tfm_ctx *)ALIGN(addr, align);
> +}

This could just use PTR_ALIGN.  Also, checking for POLYVAL_ALIGN <=
crypto_tfm_ctx_alignment() isn't necessary.

> +
> +static void internal_polyval_update(const void *raw_keys,
>  	const u8 *in, size_t nblocks, u8 *accumulator)
>  {
> +	const struct polyval_tfm_ctx *keys = polyval_tfm_ctx(raw_keys);

This is being passed a struct polyval_tfm_ctx.  There's no need to cast it back
to a void pointer and align it again redundantly.

>  	if (likely(crypto_simd_usable())) {
>  		kernel_fpu_begin();
>  		clmul_polyval_update(keys, in, nblocks, accumulator);
> @@ -102,7 +117,8 @@ static int polyval_x86_update(struct shash_desc *desc,
>  			 const u8 *src, unsigned int srclen)
>  {
>  	struct polyval_desc_ctx *dctx = shash_desc_ctx(desc);
> -	const struct polyval_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
> +	const struct polyval_tfm_ctx *tctx =
> +	    polyval_tfm_ctx(crypto_shash_ctx(desc->tfm));
>  	u8 *pos;
>  	unsigned int nblocks;
>  	unsigned int n;

It would make more sense to have the polyval_tfm_ctx() function take in the
struct crypto_shash.

How about using the following:

static inline struct polyval_tfm_ctx *polyval_tfm_ctx(struct crypto_shash *tfm)
{
        return PTR_ALIGN(crypto_shash_ctx(tfm), POLYVAL_ALIGN);
}

- Eric
