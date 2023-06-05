Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77418721C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjFECqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFECqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED178BC;
        Sun,  4 Jun 2023 19:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88CC960C99;
        Mon,  5 Jun 2023 02:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE32C433EF;
        Mon,  5 Jun 2023 02:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685933189;
        bh=ilc4aqBxknc3uTmZk+yPxYdn9Yrp8wkTJa1vkmGXir8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIR8lP3VuY2FebNisuWu2/TxliZ5uR6mV7mlXQhf8nJ2R770YM//8BJ1P3YrLV2cT
         pOm37hVU1ajzSoLvzMq2bBd6RbQdblBLMCUqsie3qcXbn+HSokrsxqs1L7PlTTWc2L
         qz9aj2gDywZoY1Z48FL5MPzfDEFSlWin3g3GTk4Ila7Hc1+cMiOl56SOAciK2DsLe1
         u6rW2/DR+Pqi6yjejDZQnnUNvKd//j+1xrJOJ/FubaaurJR1g6VdKqIAQntF9Y+cJv
         Ec9yApinSnbBkXdjkCLh4dfYIYG0dyfnlnsqanEnTvlGLVkQsGyGVbIB7RCSMYiXTn
         kjhKPrv6yYlug==
Date:   Sun, 4 Jun 2023 19:46:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 10/12] crypto: x86/aesni - Use the proper data type in
 struct aesni_xts_ctx
Message-ID: <20230605024623.GA4653@quark.localdomain>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-11-chang.seok.bae@intel.com>
 <20230604153434.GA1212@quark.localdomain>
 <0925dd9e-3588-38da-8dfb-0ac2ff568655@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0925dd9e-3588-38da-8dfb-0ac2ff568655@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 03:02:32PM -0700, Chang S. Bae wrote:
> On 6/4/2023 8:34 AM, Eric Biggers wrote:
> > 
> > To re-iterate what I said on v6, the runtime alignment to a 16-byte boundary
> > should happen when translating the raw crypto_skcipher_ctx() into the pointer to
> > the aes_xts_ctx.  It should not happen when accessing each individual field in
> > the aes_xts_ctx.
> > 
> > Yet, this code is still doing runtime alignment when accessing each individual
> > field, as the second argument to aes_set_key_common() is 'void *raw_ctx' which
> > aes_set_key_common() runtime-aligns to crypto_aes_ctx.
> > 
> > We should keep everything consistent, which means making aes_set_key_common()
> > take a pointer to crypto_aes_ctx and not do the runtime alignment.
> 
> Let me clarify what is the problem this patch tried to solve here. The
> current struct aesni_xts_ctx is ugly. So, the main story is let's fix it
> before using the code for AES-KL.
> 
> Then, the rework part may be applicable for code re-usability. That seems to
> be okay to do here.
> 
> Fixing the runtime alignment entirely seems to be touching other code than
> AES-XTS. Yes, that's ideal cleanup for consistency. But, it seems to be less
> relevant in this series.  I'd be happy to follow up on that improvement
> though.

IMO the issue is that your patch makes the code (including the XTS code)
inconsistent because it makes it use a mix of both approaches: it aligns each
field individually, *and* it aligns the ctx up-front.  I was hoping to switch
fully from the former approach to the latter approach, instead of switching from
the former approach to a mix of the two approaches as you are proposing.

The following on top of this patch is what I am asking for.  I think it would be
appropriate to fold into this patch.

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 589648142c173..ad1ae7a88b59d 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -228,10 +228,10 @@ static inline struct aesni_xts_ctx *aes_xts_ctx(struct crypto_skcipher *tfm)
 	return (struct aesni_xts_ctx *)aes_align_addr(crypto_skcipher_ctx(tfm));
 }
 
-static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
+static int aes_set_key_common(struct crypto_tfm *tfm,
+			      struct crypto_aes_ctx *ctx,
 			      const u8 *in_key, unsigned int key_len)
 {
-	struct crypto_aes_ctx *ctx = aes_ctx(raw_ctx);
 	int err;
 
 	if (key_len != AES_KEYSIZE_128 && key_len != AES_KEYSIZE_192 &&
@@ -252,7 +252,8 @@ static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		       unsigned int key_len)
 {
-	return aes_set_key_common(tfm, crypto_tfm_ctx(tfm), in_key, key_len);
+	return aes_set_key_common(tfm, aes_ctx(crypto_tfm_ctx(tfm)),
+				  in_key, key_len);
 }
 
 static void aesni_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
@@ -285,7 +286,7 @@ static int aesni_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			         unsigned int len)
 {
 	return aes_set_key_common(crypto_skcipher_tfm(tfm),
-				  crypto_skcipher_ctx(tfm), key, len);
+				  aes_ctx(crypto_skcipher_ctx(tfm)), key, len);
 }
 
 static int ecb_encrypt(struct skcipher_request *req)
