Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB86FFBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbjEKVj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjEKVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F25BA6;
        Thu, 11 May 2023 14:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0328665217;
        Thu, 11 May 2023 21:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE355C433EF;
        Thu, 11 May 2023 21:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683841190;
        bh=UjjEdlXj0HhjChfM/RbO9aN86cb9w0LIC70PQKJaGYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIviS5c1he2E4BlLgg/YeRdDMtgGR+gzpVOLaTWRN46al89ApdAJKmKO8bUA1uqtW
         WuCp/St4UE8aGQsP4GKWaQ/GCKv6GfNC+TlV46ZPuYWWZ6FkZYgOSdbggwEz8DNmPM
         gVIh+Iv9myKxUzzPpko6UkGDSQY/b49m9+ho1ZvglSEF4eUU7yWw0ZInva9DYCbARB
         o+P+XKLEm+fbeTAqOpF5cFEuvKKD6MWMbh8nQoe3etSBnzlGphx+/etJ4s9U94vDf4
         3v+pv69K/Dli/LEHtPkAELsq6ki5pkElWFfYHZwr9LW7e8wB1vZm4uI4cJTPtYywDs
         6H63+TF2tNfdQ==
Date:   Thu, 11 May 2023 14:39:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 10/12] crypto: x86/aes - Prepare for a new AES
 implementation
Message-ID: <20230511213948.GA838@quark.localdomain>
References: <08da7a0a-6b66-2c0e-eb56-96b5ee8faa30@intel.com>
 <20230511190517.10149-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511190517.10149-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 12:05:17PM -0700, Chang S. Bae wrote:
> +
> +struct aes_xts_ctx {
> +	struct crypto_aes_ctx tweak_ctx AES_ALIGN_ATTR;
> +	struct crypto_aes_ctx crypt_ctx AES_ALIGN_ATTR;
> +};
> +
> +static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
> +{
> +	unsigned long addr = (unsigned long)raw_ctx;
> +	unsigned long align = AES_ALIGN;
> +
> +	if (align <= crypto_tfm_ctx_alignment())
> +		align = 1;
> +
> +	return (struct crypto_aes_ctx *)ALIGN(addr, align);
> +}

It seems you took my suggestion to fix the definition of struct aes_xts_ctx, but
you didn't make the corresponding change to the runtime alignment code.  There
should be a helper function aes_xts_ctx() that is used like:

    struct aes_xts_ctx *ctx = aes_xts_ctx(tfm);

It would do the runtime alignment.  Then, aes_ctx() should be removed.

- Eric
