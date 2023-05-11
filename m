Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9B6FEFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbjEKKbq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 06:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjEKKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:31:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571BAD34;
        Thu, 11 May 2023 03:30:54 -0700 (PDT)
Received: from ip5b412278.dynamic.kabel-deutschland.de ([91.65.34.120] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1px3ZJ-0004sW-Uy; Thu, 11 May 2023 12:30:41 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH v4 4/4] RISC-V: crypto: add accelerated GCM GHASH implementation
Date:   Thu, 11 May 2023 12:30:41 +0200
Message-ID: <3540048.LM0AJKV5NW@diego>
In-Reply-To: <CAJkfWY63E7x-OQ2yTKJ03Sd7P2AuLruan_41EXzYcTZpNnLPzw@mail.gmail.com>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
 <20230329140642.2186644-5-heiko.stuebner@vrull.eu>
 <CAJkfWY63E7x-OQ2yTKJ03Sd7P2AuLruan_41EXzYcTZpNnLPzw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Am Dienstag, 11. April 2023, 17:00:00 CEST schrieb Nathan Huckleberry:
> On Wed, Mar 29, 2023 at 7:08 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > +struct riscv64_ghash_ctx {
> > +       void (*ghash_func)(u64 Xi[2], const u128 Htable[16],
> > +                          const u8 *inp, size_t len);
> > +
> > +       /* key used by vector asm */
> > +       u128 htable[16];
> 
> This field looks too big. The assembly only loads the first 128-byte
> value from this table.

OpenSSL defines the Htable field handed to the init- and the other
functions as this "u128 Htable[16]"    [0] . As I really like the concept
of keeping in sync with openSSL, I guess I'd rather not change that.

[0] https://github.com/openssl/openssl/blob/master/crypto/modes/gcm128.c#L88


> Is this copied from another implementation? There's an optimization
> where you precompute the first N powers of H so that you can perform 1
> finite field reduction for every N multiplications, but it doesn't
> look like that's being used here.

The whole crypto-specific code comes from openSSL itself, so for now I
guess I'd like to try keeping things the same.


> > +#define RISCV64_ZBC_SETKEY(VARIANT, GHASH)                             \
> > +void gcm_init_rv64i_ ## VARIANT(u128 Htable[16], const u64 Xi[2]);     \
> > +static int riscv64_zbc_ghash_setkey_ ## VARIANT(struct crypto_shash *tfm,      \
> > +                                          const u8 *key,               \
> > +                                          unsigned int keylen)         \
> > +{                                                                      \
> > +       struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(tfm)); \
> > +       const u64 k[2] = { cpu_to_be64(((const u64 *)key)[0]),          \
> > +                          cpu_to_be64(((const u64 *)key)[1]) };        \
> > +                                                                       \
> > +       if (keylen != GHASH_BLOCK_SIZE)                                 \
> > +               return -EINVAL;                                         \
> > +                                                                       \
> > +       memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);                       \
> > +       gcm_init_rv64i_ ## VARIANT(ctx->htable, k);                     \
> > +                                                                       \
> > +       ctx->ghash_func = gcm_ghash_rv64i_ ## GHASH;                    \
> > +                                                                       \
> > +       return 0;                                                       \
> > +}
> 
> I'd prefer three identical functions over a macro here. Code searching
> tools and compiler warnings are significantly worse with macros.

done :-)


> > +
> > +static int riscv64_zbc_ghash_update(struct shash_desc *desc,
> > +                          const u8 *src, unsigned int srclen)
> > +{
> > +       unsigned int len;
> > +       struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
> > +       struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
> > +
> > +       if (dctx->bytes) {
> > +               if (dctx->bytes + srclen < GHASH_DIGEST_SIZE) {
> > +                       memcpy(dctx->buffer + dctx->bytes, src,
> > +                               srclen);
> > +                       dctx->bytes += srclen;
> > +                       return 0;
> > +               }
> > +               memcpy(dctx->buffer + dctx->bytes, src,
> > +                       GHASH_DIGEST_SIZE - dctx->bytes);
> > +
> > +               ctx->ghash_func(dctx->shash, ctx->htable,
> > +                               dctx->buffer, GHASH_DIGEST_SIZE);
> > +
> > +               src += GHASH_DIGEST_SIZE - dctx->bytes;
> > +               srclen -= GHASH_DIGEST_SIZE - dctx->bytes;
> > +               dctx->bytes = 0;
> > +       }
> > +       len = srclen & ~(GHASH_DIGEST_SIZE - 1);
> > +
> > +       if (len) {
> > +               gcm_ghash_rv64i_zbc(dctx->shash, ctx->htable,
> > +                               src, len);
> > +               src += len;
> > +               srclen -= len;
> > +       }
> > +
> > +       if (srclen) {
> > +               memcpy(dctx->buffer, src, srclen);
> > +               dctx->bytes = srclen;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int riscv64_zbc_ghash_final(struct shash_desc *desc, u8 *out)
> > +{
> > +       int i;
> > +       struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
> > +       struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
> > +
> > +       if (dctx->bytes) {
> > +               for (i = dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
> > +                       dctx->buffer[i] = 0;
> > +               ctx->ghash_func(dctx->shash, ctx->htable,
> > +                               dctx->buffer, GHASH_DIGEST_SIZE);
> 
> Can we do this without an indirect call?

hmm, the indirect call is in both riscv64_zbc_ghash_update() and
riscv64_zbc_ghash_final() . And I found a missing one at the bottom
of riscv64_zbc_ghash_update(), where gcm_ghash_rv64i_zbc() is
called right now.

Getting rid of the indirect call would mean duplicating both of these
functions for all instances. Especially with the slightly higher
complexity of the update this somehow seems not the best way to go.


Thanks for your pointers
Heiko


