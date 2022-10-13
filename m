Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679795FD25D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJMBNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJMBMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:12:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7867E5C94B;
        Wed, 12 Oct 2022 18:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93430B81CBF;
        Thu, 13 Oct 2022 00:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691FAC433D6;
        Thu, 13 Oct 2022 00:35:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="APa0Deq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665621334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GU3B0Qianzi1mc6k9wWXG+2DLPBGqfoakAe03+BRcd4=;
        b=APa0Deq/4F8uodtlaZSF6OTS7LQlwJHcOpGGYoVrS4hFrcq6lh5ex7acbdVhKo56ZidpAt
        ePDG8UBEM7qZw2aNLmbDXIO0Lry+tQNpQx1O+Hk9XBaoQj9dQZe8yfhslSZeay2MooIDmL
        VDHsT4fUQS4gcEEh/NW8/j4rH6iGnv0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f46fb10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 00:35:34 +0000 (UTC)
Date:   Wed, 12 Oct 2022 18:35:30 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
Message-ID: <Y0ddUkGg15kHCIiB@zx2c4.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-10-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012215931.3896-10-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 04:59:21PM -0500, Robert Elliott wrote:
> Use a common macro name (FPU_BYTES) for the limit of the number of bytes
> processed within kernel_fpu_begin and kernel_fpu_end rather than
> using SZ_4K (which is a signed value), or a magic value of 4096U.

Not sure I like this very much. The whole idea is that this is variable
per algorithm, since not all algorithms have the same performance
characteristics. So in that sense, it's better to put this close to
where it's actually used, rather than somewhere at the top of the file.
When you do that, it makes it seem like "FPU_BYTES" is some universal
constant, which of course it isn't.

Instead, declare this as an untyped enum value within the function. For
example:

diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index aaba21230528..602883eee5f3 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -30,7 +30,8 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 		      size_t nblocks, const u32 inc)
 {
 	/* SIMD disables preemption, so relax after processing each page. */
-	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
+	enum { BLOCKS_PER_FPU = SZ_4K / BLAKE2S_BLOCK_SIZE };
+	BUILD_BUG_ON(BLOCKS_PER_FPU < 8);

 	if (!static_branch_likely(&blake2s_use_ssse3) || !may_use_simd()) {
 		blake2s_compress_generic(state, block, nblocks, inc);
@@ -38,8 +39,7 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 	}

 	do {
-		const size_t blocks = min_t(size_t, nblocks,
-					    SZ_4K / BLAKE2S_BLOCK_SIZE);
+		const size_t blocks = min_t(size_t, nblocks, BLOCKS_PER_FPU);

 		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) &&
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7b3a1cf0984b..f8fd2b7025c1 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -142,12 +142,14 @@ EXPORT_SYMBOL(chacha_init_arch);
 void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src, unsigned int bytes,
 		       int nrounds)
 {
+	enum { BYTES_PER_FPU = SZ_4K };
+
 	if (!static_branch_likely(&chacha_use_simd) || !crypto_simd_usable() ||
 	    bytes <= CHACHA_BLOCK_SIZE)
 		return chacha_crypt_generic(state, dst, src, bytes, nrounds);

 	do {
-		unsigned int todo = min_t(unsigned int, bytes, SZ_4K);
+		unsigned int todo = min_t(unsigned int, bytes, BYTES_PER_FPU);

 		kernel_fpu_begin();
 		chacha_dosimd(state, dst, src, todo, nrounds);


