Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229E688D2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjBCCpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBCCo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:44:59 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4D5234C8;
        Thu,  2 Feb 2023 18:44:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vamridi_1675392294;
Received: from 30.240.100.126(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Vamridi_1675392294)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 10:44:55 +0800
Message-ID: <f4df6e4f-9d88-bb63-42bf-e2fa23b9a9bc@linux.alibaba.com>
Date:   Fri, 3 Feb 2023 10:44:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [v4 PATCH] crypto: arm64/sm4-gcm - Fix possible crash in GCM
 cryption
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230201123133.99768-1-tianjia.zhang@linux.alibaba.com>
 <Y9t1a2HkqlPT+Zfn@gondor.apana.org.au>
Content-Language: en-US
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Y9t1a2HkqlPT+Zfn@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 2/2/23 4:33 PM, Herbert Xu wrote:
> On Wed, Feb 01, 2023 at 08:31:33PM +0800, Tianjia Zhang wrote:
>>
>> +	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, walk->dst.virt.addr,
>> +			       walk->src.virt.addr, iv, walk->nbytes, ghash,
>> +			       ctx->ghash_table, (const u8 *)&lengths);
> 
> I still think this is error-prone.  When walk->nbytes == 0,
> walk->src and walk->dst are undefined.  Sure you could argue
> that the underlying assembly code won't touch the values, but
> accessing uninitialised memory even if just to throw them away
> is still a bit icky.

You're right, whether used or not, accessing an undefined pointer is
always ugly. This benefited me a lot.

> 
> Anyway, here's my attempt at rewriting the gcm loop:
> 
> ---8<---
> An often overlooked aspect of the skcipher walker API is that an
> error is not just indicated by a non-zero return value, but by the
> fact that walk->nbytes is zero.
> 
> Thus it is an error to call skcipher_walk_done after getting back
> walk->nbytes == 0 from the previous interaction with the walker.
> 
> This is because when walk->nbytes is zero the walker is left in
> an undefined state and any further calls to it may try to free
> uninitialised stack memory.
> 
> The sm4 arm64 ccm code gets this wrong and ends up calling
> skcipher_walk_done even when walk->nbytes is zero.
> 
> This patch rewrites the loop in a form that resembles other callers.
> 
> Reported-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Fixes: ae1b83c7d572 ("crypto: arm64/sm4 - add CE implementation for GCM mode")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks for the fix, this patch works find to me, so

Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

> 
> diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
> index c450a2025ca9..73bfb6972d3a 100644
> --- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
> +++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
> @@ -135,22 +135,23 @@ static void gcm_calculate_auth_mac(struct aead_request *req, u8 ghash[])
>   }
>   
>   static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
> -		     struct sm4_gcm_ctx *ctx, u8 ghash[],
> +		     u8 ghash[], int err,
>   		     void (*sm4_ce_pmull_gcm_crypt)(const u32 *rkey_enc,
>   				u8 *dst, const u8 *src, u8 *iv,
>   				unsigned int nbytes, u8 *ghash,
>   				const u8 *ghash_table, const u8 *lengths))
>   {
> +	struct crypto_aead *aead = crypto_aead_reqtfm(req);
> +	struct sm4_gcm_ctx *ctx = crypto_aead_ctx(aead);
>   	u8 __aligned(8) iv[SM4_BLOCK_SIZE];
>   	be128 __aligned(8) lengths;
> -	int err;
>   
>   	memset(ghash, 0, SM4_BLOCK_SIZE);
>   
>   	lengths.a = cpu_to_be64(req->assoclen * 8);
>   	lengths.b = cpu_to_be64(walk->total * 8);
>   
> -	memcpy(iv, walk->iv, GCM_IV_SIZE);
> +	memcpy(iv, req->iv, GCM_IV_SIZE);
>   	put_unaligned_be32(2, iv + GCM_IV_SIZE);
>   
>   	kernel_neon_begin();
> @@ -158,49 +159,51 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
>   	if (req->assoclen)
>   		gcm_calculate_auth_mac(req, ghash);
>   
> -	do {
> +	while (walk->nbytes) {
>   		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
>   		const u8 *src = walk->src.virt.addr;
>   		u8 *dst = walk->dst.virt.addr;
>   
>   		if (walk->nbytes == walk->total) {
> -			tail = 0;
> -
>   			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
>   					       walk->nbytes, ghash,
>   					       ctx->ghash_table,
>   					       (const u8 *)&lengths);
> -		} else if (walk->nbytes - tail) {
> -			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
> -					       walk->nbytes - tail, ghash,
> -					       ctx->ghash_table, NULL);
> +
> +			kernel_neon_end();
> +
> +			return skcipher_walk_done(walk, 0);
>   		}
>   
> +		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
> +				       walk->nbytes - tail, ghash,
> +				       ctx->ghash_table, NULL);
> +
>   		kernel_neon_end();
>   
>   		err = skcipher_walk_done(walk, tail);
> -		if (err)
> -			return err;
> -		if (walk->nbytes)
> -			kernel_neon_begin();
> -	} while (walk->nbytes > 0);
>   
> -	return 0;
> +		kernel_neon_begin();
> +	}
> +
> +	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, NULL, NULL, iv,
> +			       walk->nbytes, ghash, ctx->ghash_table,
> +			       (const u8 *)&lengths);
> +
> +	kernel_neon_end();
> +
> +	return err;
>   }
>   
>   static int gcm_encrypt(struct aead_request *req)
>   {
>   	struct crypto_aead *aead = crypto_aead_reqtfm(req);
> -	struct sm4_gcm_ctx *ctx = crypto_aead_ctx(aead);
>   	u8 __aligned(8) ghash[SM4_BLOCK_SIZE];
>   	struct skcipher_walk walk;
>   	int err;
>   
>   	err = skcipher_walk_aead_encrypt(&walk, req, false);
> -	if (err)
> -		return err;
> -
> -	err = gcm_crypt(req, &walk, ctx, ghash, sm4_ce_pmull_gcm_enc);
> +	err = gcm_crypt(req, &walk, ghash, err, sm4_ce_pmull_gcm_enc);
>   	if (err)
>   		return err;
>   
> @@ -215,17 +218,13 @@ static int gcm_decrypt(struct aead_request *req)
>   {
>   	struct crypto_aead *aead = crypto_aead_reqtfm(req);
>   	unsigned int authsize = crypto_aead_authsize(aead);
> -	struct sm4_gcm_ctx *ctx = crypto_aead_ctx(aead);
>   	u8 __aligned(8) ghash[SM4_BLOCK_SIZE];
>   	u8 authtag[SM4_BLOCK_SIZE];
>   	struct skcipher_walk walk;
>   	int err;
>   
>   	err = skcipher_walk_aead_decrypt(&walk, req, false);
> -	if (err)
> -		return err;
> -
> -	err = gcm_crypt(req, &walk, ctx, ghash, sm4_ce_pmull_gcm_dec);
> +	err = gcm_crypt(req, &walk, ghash, err, sm4_ce_pmull_gcm_dec);
>   	if (err)
>   		return err;
>   
