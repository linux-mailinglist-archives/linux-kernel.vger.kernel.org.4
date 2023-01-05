Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C265E9E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjAEL2j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 06:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjAEL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:28:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEABB4AD;
        Thu,  5 Jan 2023 03:27:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70ECB23442;
        Thu,  5 Jan 2023 11:27:35 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31CEE13338;
        Thu,  5 Jan 2023 11:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ck/WCie0tmO8LwAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 05 Jan 2023 11:27:35 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] crypto: xts - drop xts_check_key()
References: <20221229211710.14912-1-vdronov@redhat.com>
        <20221229211710.14912-3-vdronov@redhat.com>
Date:   Thu, 05 Jan 2023 12:27:34 +0100
In-Reply-To: <20221229211710.14912-3-vdronov@redhat.com> (Vladis Dronov's
        message of "Thu, 29 Dec 2022 22:17:06 +0100")
Message-ID: <87bkndb4rd.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.10
X-Spamd-Result: default: False [-0.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladis,

Vladis Dronov <vdronov@redhat.com> writes:

> xts_check_key() is obsoleted by xts_verify_key(). Over time XTS crypto
> drivers adopted the newer xts_verify_key() variant, but xts_check_key()
> is still used by a number of drivers. Switch drivers to use the newer
> xts_verify_key() and make a couple of cleanups. This allows us to drop
> xts_check_key() completely and avoid redundancy.

nice work, thanks a lot for doing it!

There are two (obviously correct) cleanups which seem unrelated to
xts_verify_key(), namely in cvm_setkey() and
nitrox_aes_ctr_rfc3686_setkey(), see below.

But the commit message does say "and make a couple of cleanups" and
these changes certainly qualify as such. I just wanted to have it
mentioned.

Reviewed-by: Nicolai Stange <nstange@suse.de>

Thanks!

Nicolai


>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> ---

<snip>

> diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
> index 9eca0c302186..0b38c2600b86 100644
> --- a/drivers/crypto/cavium/cpt/cptvf_algs.c
> +++ b/drivers/crypto/cavium/cpt/cptvf_algs.c

<snip>

> @@ -289,8 +288,7 @@ static int cvm_validate_keylen(struct cvm_enc_ctx *ctx, u32 keylen)
>  static int cvm_setkey(struct crypto_skcipher *cipher, const u8 *key,
>  		      u32 keylen, u8 cipher_type)
>  {
> -	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
> -	struct cvm_enc_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct cvm_enc_ctx *ctx = crypto_skcipher_ctx(cipher);
>  
>  	ctx->cipher_type = cipher_type;
>  	if (!cvm_validate_keylen(ctx, keylen)) {

This change here and ...


> diff --git a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
> index 248b4fff1c72..138261dcd032 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c

<snip>

> @@ -362,8 +361,7 @@ static int nitrox_aes_xts_setkey(struct crypto_skcipher *cipher,
>  static int nitrox_aes_ctr_rfc3686_setkey(struct crypto_skcipher *cipher,
>  					 const u8 *key, unsigned int keylen)
>  {
> -	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
> -	struct nitrox_crypto_ctx *nctx = crypto_tfm_ctx(tfm);
> +	struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(cipher);
>  	struct flexi_crypto_context *fctx;
>  	int aes_keylen;
>

this one are not strictly related to xts_verify_key() AFAICS, but it's
fine to have them included nonetheless, IMO.


-- 
SUSE Software Solutions Germany GmbH, Frankenstraße 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG Nürnberg)
