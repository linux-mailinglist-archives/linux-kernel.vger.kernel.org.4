Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7316DDEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDKPBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDKPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:01:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD0C46A5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:01:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so4467499wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681225260; x=1683817260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqkRalIM0aqu0Pxww01rzS1FmGnvWcm01wXp3Z4A+dk=;
        b=qIXIQ0NwwqGq8NwmLYhnb3mk5Ix1hEBltcPwrStsAwI3pTUHkudgSMr1f1SQsH3tIB
         ax7p9PwsLmwqSfvIXkLubxBgbaRDavU0vMYJaendC8wQTOUmE69iSqkQZ/xhPE3F1L0b
         brLqQtszcn2VkupjSGh9+ELu7BlNIzYUcAYyNs2roycJ4rLTowzIXGRdsvI8v5Z/7aH+
         +6D4zmlrJ3v/px8rV5FTCDmHuiC//CQqy5w3+2H/J2ab5VLx6QfdTNGMUqgRLTmkPd5T
         n85TE30oH4PAIk+VmN/O/6xeFEhySjxWg0yoCWb+qMc2XU+n0hTSOPUPc0llrxznbwps
         ePmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225260; x=1683817260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqkRalIM0aqu0Pxww01rzS1FmGnvWcm01wXp3Z4A+dk=;
        b=LuuFl75WQ7UzdGgWyRbXULrgZZG/0DeMoREuFUUszz+6mqUOhvWEV3BqbcU3MErAUh
         byz7Swry2cvai5wcR53/orMWJ+zEF/ViR4oQ4KJj2g3DuTfpdiLipokD65+dS5gDnp+v
         Xh5L3noVOvg14S07nNVDjHsUu5Mbn63MPB5w3kwEkXQ2XhW1/MGz/hRfE8Nc8yZAJwu9
         Zol23Ix6pI9DbYouNq7gLs1uPxb5+xHmhvXT1N0ApAZR2i83EKOXvMOeSeBJZ90JvngM
         j2DvRrznHLp62AdeIfTI8+GBX1sDInvuKrBY+5gjZMuCYcjLKOpPFIKV0gV7QIfPeEGF
         QDsg==
X-Gm-Message-State: AAQBX9fwnhnIs9NkdzMP2WGwQijA1uXKqP9C5AnAIX6EhsPyWBAuQR0O
        Svd5EZul3KqoCmL1OvmQ1BzOu6dpeXHnPZfu2c39yd/+03TBNUNpN74=
X-Google-Smtp-Source: AKy350blQW7hKzeqCR95KjCh2vPGTztz0lWUnnRSSlORpW9/PfLMxjK87Nnb2K/j09UlGGNVfejkTgk2QMhgWdUn23c=
X-Received: by 2002:a1c:740b:0:b0:3ef:5da6:45e2 with SMTP id
 p11-20020a1c740b000000b003ef5da645e2mr3284465wmc.3.1681225260290; Tue, 11 Apr
 2023 08:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu> <20230329140642.2186644-5-heiko.stuebner@vrull.eu>
In-Reply-To: <20230329140642.2186644-5-heiko.stuebner@vrull.eu>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 11 Apr 2023 08:00:00 -0700
Message-ID: <CAJkfWY63E7x-OQ2yTKJ03Sd7P2AuLruan_41EXzYcTZpNnLPzw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] RISC-V: crypto: add accelerated GCM GHASH implementation
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Heiko,

Thanks for the patch, it generally looks good. A few comments.

On Wed, Mar 29, 2023 at 7:08=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> With different sets of available extensions a number of different
> implementation variants are possible. Quite a number of them are already
> implemented in openSSL or are in the process of being implemented, so pic=
k
> the relevant openSSL coden and add suitable glue code similar to arm64 an=
d
> powerpc to use it for kernel-specific cryptography.
>
> The prioritization of the algorithms follows the ifdef chain for the
> assembly callbacks done in openssl but here algorithms will get registere=
d
> separately so that all of them can be part of the crypto selftests.
>
> The crypto subsystem will select the most performant of all registered
> algorithms on the running system but will selftest all registered ones.
>
> In a first step this adds scalar variants using the Zbc, Zbb and
> possible Zbkb (bitmanip crypto extension) and the perl implementation
> stems from openSSL pull request on
>     https://github.com/openssl/openssl/pull/20078
>
> Co-developed-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/crypto/Kconfig              |  13 +
>  arch/riscv/crypto/Makefile             |  14 +
>  arch/riscv/crypto/ghash-riscv64-glue.c | 258 ++++++++++++++++
>  arch/riscv/crypto/ghash-riscv64-zbc.pl | 400 +++++++++++++++++++++++++
>  arch/riscv/crypto/riscv.pm             | 231 ++++++++++++++
>  5 files changed, 916 insertions(+)
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-zbc.pl
>  create mode 100644 arch/riscv/crypto/riscv.pm
>
> diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
> index 10d60edc0110..cd2237923e68 100644
> --- a/arch/riscv/crypto/Kconfig
> +++ b/arch/riscv/crypto/Kconfig
> @@ -2,4 +2,17 @@
>
>  menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
>
> +config CRYPTO_GHASH_RISCV64
> +       tristate "Hash functions: GHASH"
> +       depends on 64BIT && RISCV_ISA_ZBC
> +       select CRYPTO_HASH
> +       select CRYPTO_LIB_GF128MUL
> +       help
> +         GCM GHASH function (NIST SP800-38D)
> +
> +         Architecture: riscv64 using one of:
> +         - Zbc extension
> +         - Zbc + Zbb extensions
> +         - Zbc + Zbkb extensions
> +
>  endmenu
> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
> index b3b6332c9f6d..0a158919e9da 100644
> --- a/arch/riscv/crypto/Makefile
> +++ b/arch/riscv/crypto/Makefile
> @@ -2,3 +2,17 @@
>  #
>  # linux/arch/riscv/crypto/Makefile
>  #
> +
> +obj-$(CONFIG_CRYPTO_GHASH_RISCV64) +=3D ghash-riscv64.o
> +ghash-riscv64-y :=3D ghash-riscv64-glue.o
> +ifdef CONFIG_RISCV_ISA_ZBC
> +ghash-riscv64-y +=3D ghash-riscv64-zbc.o
> +endif
> +
> +quiet_cmd_perlasm =3D PERLASM $@
> +      cmd_perlasm =3D $(PERL) $(<) void $(@)
> +
> +$(obj)/ghash-riscv64-zbc.S: $(src)/ghash-riscv64-zbc.pl
> +       $(call cmd,perlasm)
> +
> +clean-files +=3D ghash-riscv64-zbc.S
> diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/g=
hash-riscv64-glue.c
> new file mode 100644
> index 000000000000..5ab704c49539
> --- /dev/null
> +++ b/arch/riscv/crypto/ghash-riscv64-glue.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V optimized GHASH routines
> + *
> + * Copyright (C) 2023 VRULL GmbH
> + * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/err.h>
> +#include <linux/crypto.h>
> +#include <linux/module.h>
> +#include <asm/simd.h>
> +#include <crypto/ghash.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/internal/simd.h>
> +
> +/* Zbc (optional with zbkb improvements) */
> +void gcm_ghash_rv64i_zbc(u64 Xi[2], const u128 Htable[16],
> +                        const u8 *inp, size_t len);
> +void gcm_ghash_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16],
> +                              const u8 *inp, size_t len);
> +
> +struct riscv64_ghash_ctx {
> +       void (*ghash_func)(u64 Xi[2], const u128 Htable[16],
> +                          const u8 *inp, size_t len);
> +
> +       /* key used by vector asm */
> +       u128 htable[16];

This field looks too big. The assembly only loads the first 128-byte
value from this table.

Is this copied from another implementation? There's an optimization
where you precompute the first N powers of H so that you can perform 1
finite field reduction for every N multiplications, but it doesn't
look like that's being used here.

> +       /* key used by software fallback */
> +       be128 key;
> +};
> +
> +struct riscv64_ghash_desc_ctx {
> +       u64 shash[2];
> +       u8 buffer[GHASH_DIGEST_SIZE];
> +       int bytes;
> +};
> +
> +static int riscv64_ghash_init(struct shash_desc *desc)
> +{
> +       struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
> +
> +       dctx->bytes =3D 0;
> +       memset(dctx->shash, 0, GHASH_DIGEST_SIZE);
> +       return 0;
> +}
> +
> +#ifdef CONFIG_RISCV_ISA_ZBC
> +
> +#define RISCV64_ZBC_SETKEY(VARIANT, GHASH)                             \
> +void gcm_init_rv64i_ ## VARIANT(u128 Htable[16], const u64 Xi[2]);     \
> +static int riscv64_zbc_ghash_setkey_ ## VARIANT(struct crypto_shash *tfm=
,      \
> +                                          const u8 *key,               \
> +                                          unsigned int keylen)         \
> +{                                                                      \
> +       struct riscv64_ghash_ctx *ctx =3D crypto_tfm_ctx(crypto_shash_tfm=
(tfm)); \
> +       const u64 k[2] =3D { cpu_to_be64(((const u64 *)key)[0]),         =
 \
> +                          cpu_to_be64(((const u64 *)key)[1]) };        \
> +                                                                       \
> +       if (keylen !=3D GHASH_BLOCK_SIZE)                                =
 \
> +               return -EINVAL;                                         \
> +                                                                       \
> +       memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);                       \
> +       gcm_init_rv64i_ ## VARIANT(ctx->htable, k);                     \
> +                                                                       \
> +       ctx->ghash_func =3D gcm_ghash_rv64i_ ## GHASH;                   =
 \
> +                                                                       \
> +       return 0;                                                       \
> +}

I'd prefer three identical functions over a macro here. Code searching
tools and compiler warnings are significantly worse with macros.

> +
> +static int riscv64_zbc_ghash_update(struct shash_desc *desc,
> +                          const u8 *src, unsigned int srclen)
> +{
> +       unsigned int len;
> +       struct riscv64_ghash_ctx *ctx =3D crypto_tfm_ctx(crypto_shash_tfm=
(desc->tfm));
> +       struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
> +
> +       if (dctx->bytes) {
> +               if (dctx->bytes + srclen < GHASH_DIGEST_SIZE) {
> +                       memcpy(dctx->buffer + dctx->bytes, src,
> +                               srclen);
> +                       dctx->bytes +=3D srclen;
> +                       return 0;
> +               }
> +               memcpy(dctx->buffer + dctx->bytes, src,
> +                       GHASH_DIGEST_SIZE - dctx->bytes);
> +
> +               ctx->ghash_func(dctx->shash, ctx->htable,
> +                               dctx->buffer, GHASH_DIGEST_SIZE);
> +
> +               src +=3D GHASH_DIGEST_SIZE - dctx->bytes;
> +               srclen -=3D GHASH_DIGEST_SIZE - dctx->bytes;
> +               dctx->bytes =3D 0;
> +       }
> +       len =3D srclen & ~(GHASH_DIGEST_SIZE - 1);
> +
> +       if (len) {
> +               gcm_ghash_rv64i_zbc(dctx->shash, ctx->htable,
> +                               src, len);
> +               src +=3D len;
> +               srclen -=3D len;
> +       }
> +
> +       if (srclen) {
> +               memcpy(dctx->buffer, src, srclen);
> +               dctx->bytes =3D srclen;
> +       }
> +       return 0;
> +}
> +
> +static int riscv64_zbc_ghash_final(struct shash_desc *desc, u8 *out)
> +{
> +       int i;
> +       struct riscv64_ghash_ctx *ctx =3D crypto_tfm_ctx(crypto_shash_tfm=
(desc->tfm));
> +       struct riscv64_ghash_desc_ctx *dctx =3D shash_desc_ctx(desc);
> +
> +       if (dctx->bytes) {
> +               for (i =3D dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
> +                       dctx->buffer[i] =3D 0;
> +               ctx->ghash_func(dctx->shash, ctx->htable,
> +                               dctx->buffer, GHASH_DIGEST_SIZE);

Can we do this without an indirect call?

> +               dctx->bytes =3D 0;
> +       }
> +       memcpy(out, dctx->shash, GHASH_DIGEST_SIZE);
> +       return 0;
> +}
> +
> +RISCV64_ZBC_SETKEY(zbc, zbc);
> +struct shash_alg riscv64_zbc_ghash_alg =3D {
> +       .digestsize =3D GHASH_DIGEST_SIZE,
> +       .init =3D riscv64_ghash_init,
> +       .update =3D riscv64_zbc_ghash_update,
> +       .final =3D riscv64_zbc_ghash_final,
> +       .setkey =3D riscv64_zbc_ghash_setkey_zbc,
> +       .descsize =3D sizeof(struct riscv64_ghash_desc_ctx)
> +                   + sizeof(struct ghash_desc_ctx),
> +       .base =3D {
> +                .cra_name =3D "ghash",
> +                .cra_driver_name =3D "riscv64_zbc_ghash",
> +                .cra_priority =3D 250,
> +                .cra_blocksize =3D GHASH_BLOCK_SIZE,
> +                .cra_ctxsize =3D sizeof(struct riscv64_ghash_ctx),
> +                .cra_module =3D THIS_MODULE,
> +       },
> +};
> +
> +RISCV64_ZBC_SETKEY(zbc__zbb, zbc);
> +struct shash_alg riscv64_zbc_zbb_ghash_alg =3D {
> +       .digestsize =3D GHASH_DIGEST_SIZE,
> +       .init =3D riscv64_ghash_init,
> +       .update =3D riscv64_zbc_ghash_update,
> +       .final =3D riscv64_zbc_ghash_final,
> +       .setkey =3D riscv64_zbc_ghash_setkey_zbc__zbb,
> +       .descsize =3D sizeof(struct riscv64_ghash_desc_ctx)
> +                   + sizeof(struct ghash_desc_ctx),
> +       .base =3D {
> +                .cra_name =3D "ghash",
> +                .cra_driver_name =3D "riscv64_zbc_zbb_ghash",
> +                .cra_priority =3D 251,
> +                .cra_blocksize =3D GHASH_BLOCK_SIZE,
> +                .cra_ctxsize =3D sizeof(struct riscv64_ghash_ctx),
> +                .cra_module =3D THIS_MODULE,
> +       },
> +};
> +
> +RISCV64_ZBC_SETKEY(zbc__zbkb, zbc__zbkb);
> +struct shash_alg riscv64_zbc_zbkb_ghash_alg =3D {
> +       .digestsize =3D GHASH_DIGEST_SIZE,
> +       .init =3D riscv64_ghash_init,
> +       .update =3D riscv64_zbc_ghash_update,
> +       .final =3D riscv64_zbc_ghash_final,
> +       .setkey =3D riscv64_zbc_ghash_setkey_zbc__zbkb,
> +       .descsize =3D sizeof(struct riscv64_ghash_desc_ctx)
> +                   + sizeof(struct ghash_desc_ctx),
> +       .base =3D {
> +                .cra_name =3D "ghash",
> +                .cra_driver_name =3D "riscv64_zbc_zbkb_ghash",
> +                .cra_priority =3D 252,
> +                .cra_blocksize =3D GHASH_BLOCK_SIZE,
> +                .cra_ctxsize =3D sizeof(struct riscv64_ghash_ctx),
> +                .cra_module =3D THIS_MODULE,
> +       },
> +};
> +
> +#endif /* CONFIG_RISCV_ISA_ZBC */
> +
> +#define RISCV64_DEFINED_GHASHES                7
> +
> +static struct shash_alg *riscv64_ghashes[RISCV64_DEFINED_GHASHES];
> +static int num_riscv64_ghashes;
> +
> +static int __init riscv64_ghash_register(struct shash_alg *ghash)
> +{
> +       int ret;
> +
> +       ret =3D crypto_register_shash(ghash);
> +       if (ret < 0) {
> +               int i;
> +
> +               for (i =3D num_riscv64_ghashes - 1; i >=3D 0 ; i--)
> +                       crypto_unregister_shash(riscv64_ghashes[i]);
> +
> +               num_riscv64_ghashes =3D 0;
> +
> +               return ret;
> +       }
> +
> +       pr_debug("Registered RISC-V ghash %s\n", ghash->base.cra_driver_n=
ame);
> +       riscv64_ghashes[num_riscv64_ghashes] =3D ghash;
> +       num_riscv64_ghashes++;
> +       return 0;
> +}
> +
> +static int __init riscv64_ghash_mod_init(void)
> +{
> +       int ret =3D 0;
> +
> +#ifdef CONFIG_RISCV_ISA_ZBC
> +       if (riscv_isa_extension_available(NULL, ZBC)) {
> +               ret =3D riscv64_ghash_register(&riscv64_zbc_ghash_alg);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (riscv_isa_extension_available(NULL, ZBB)) {
> +                       ret =3D riscv64_ghash_register(&riscv64_zbc_zbb_g=
hash_alg);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +
> +               if (riscv_isa_extension_available(NULL, ZBKB)) {
> +                       ret =3D riscv64_ghash_register(&riscv64_zbc_zbkb_=
ghash_alg);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +       }
> +#endif
> +
> +       return 0;
> +}
> +
> +static void __exit riscv64_ghash_mod_fini(void)
> +{
> +       int i;
> +
> +       for (i =3D num_riscv64_ghashes - 1; i >=3D 0 ; i--)
> +               crypto_unregister_shash(riscv64_ghashes[i]);
> +
> +       num_riscv64_ghashes =3D 0;
> +}
> +
> +module_init(riscv64_ghash_mod_init);
> +module_exit(riscv64_ghash_mod_fini);
> +
> +MODULE_DESCRIPTION("GSM GHASH (accelerated)");
> +MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_CRYPTO("ghash");
> diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/g=
hash-riscv64-zbc.pl
> new file mode 100644
> index 000000000000..691231ffa11c
> --- /dev/null
> +++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> @@ -0,0 +1,400 @@
> +#! /usr/bin/env perl
> +# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
> +#
> +# Licensed under the Apache License 2.0 (the "License").  You may not us=
e
> +# this file except in compliance with the License.  You can obtain a cop=
y
> +# in the file LICENSE in the source distribution or at
> +# https://www.openssl.org/source/license.html
> +
> +use strict;
> +use warnings;
> +
> +use FindBin qw($Bin);
> +use lib "$Bin";
> +use lib "$Bin/../../perlasm";
> +use riscv;
> +
> +# $output is the last argument if it looks like a file (it has an extens=
ion)
> +# $flavour is the first argument if it doesn't look like a file
> +my $output =3D $#ARGV >=3D 0 && $ARGV[$#ARGV] =3D~ m|\.\w+$| ? pop : und=
ef;
> +my $flavour =3D $#ARGV >=3D 0 && $ARGV[0] !~ m|\.| ? shift : undef;
> +
> +$output and open STDOUT,">$output";
> +
> +my $code=3D<<___;
> +.text
> +___
> +
> +########################################################################=
########
> +# void gcm_init_rv64i_zbc(u128 Htable[16], const u64 H[2]);
> +# void gcm_init_rv64i_zbc__zbb(u128 Htable[16], const u64 H[2]);
> +# void gcm_init_rv64i_zbc__zbkb(u128 Htable[16], const u64 H[2]);
> +#
> +# input:  H: 128-bit H - secret parameter E(K, 0^128)
> +# output: Htable: Preprocessed key data for gcm_gmult_rv64i_zbc* and
> +#                 gcm_ghash_rv64i_zbc*
> +#
> +# All callers of this function revert the byte-order unconditionally
> +# on little-endian machines. So we need to revert the byte-order back.
> +# Additionally we reverse the bits of each byte.
> +
> +{
> +my ($Htable,$H,$VAL0,$VAL1,$TMP0,$TMP1,$TMP2) =3D ("a0","a1","a2","a3","=
t0","t1","t2");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_init_rv64i_zbc
> +.type gcm_init_rv64i_zbc,\@function
> +gcm_init_rv64i_zbc:
> +    ld      $VAL0,0($H)
> +    ld      $VAL1,8($H)
> +    @{[brev8_rv64i   $VAL0, $TMP0, $TMP1, $TMP2]}
> +    @{[brev8_rv64i   $VAL1, $TMP0, $TMP1, $TMP2]}
> +    @{[sd_rev8_rv64i $VAL0, $Htable, 0, $TMP0]}
> +    @{[sd_rev8_rv64i $VAL1, $Htable, 8, $TMP0]}
> +    ret
> +.size gcm_init_rv64i_zbc,.-gcm_init_rv64i_zbc
> +___
> +}
> +
> +{
> +my ($Htable,$H,$VAL0,$VAL1,$TMP0,$TMP1,$TMP2) =3D ("a0","a1","a2","a3","=
t0","t1","t2");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_init_rv64i_zbc__zbb
> +.type gcm_init_rv64i_zbc__zbb,\@function
> +gcm_init_rv64i_zbc__zbb:
> +    ld      $VAL0,0($H)
> +    ld      $VAL1,8($H)
> +    @{[brev8_rv64i $VAL0, $TMP0, $TMP1, $TMP2]}
> +    @{[brev8_rv64i $VAL1, $TMP0, $TMP1, $TMP2]}
> +    @{[rev8 $VAL0, $VAL0]}
> +    @{[rev8 $VAL1, $VAL1]}
> +    sd      $VAL0,0($Htable)
> +    sd      $VAL1,8($Htable)
> +    ret
> +.size gcm_init_rv64i_zbc__zbb,.-gcm_init_rv64i_zbc__zbb
> +___
> +}
> +
> +{
> +my ($Htable,$H,$TMP0,$TMP1) =3D ("a0","a1","t0","t1");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_init_rv64i_zbc__zbkb
> +.type gcm_init_rv64i_zbc__zbkb,\@function
> +gcm_init_rv64i_zbc__zbkb:
> +    ld      $TMP0,0($H)
> +    ld      $TMP1,8($H)
> +    @{[brev8 $TMP0, $TMP0]}
> +    @{[brev8 $TMP1, $TMP1]}
> +    @{[rev8 $TMP0, $TMP0]}
> +    @{[rev8 $TMP1, $TMP1]}
> +    sd      $TMP0,0($Htable)
> +    sd      $TMP1,8($Htable)
> +    ret
> +.size gcm_init_rv64i_zbc__zbkb,.-gcm_init_rv64i_zbc__zbkb
> +___
> +}
> +
> +########################################################################=
########
> +# void gcm_gmult_rv64i_zbc(u64 Xi[2], const u128 Htable[16]);
> +# void gcm_gmult_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16]);
> +#
> +# input:  Xi: current hash value
> +#         Htable: copy of H
> +# output: Xi: next hash value Xi
> +#
> +# Compute GMULT (Xi*H mod f) using the Zbc (clmul) and Zbb (basic bit ma=
nip)
> +# extensions. Using the no-Karatsuba approach and clmul for the final re=
duction.
> +# This results in an implementation with minimized number of instruction=
s.
> +# HW with clmul latencies higher than 2 cycles might observe a performan=
ce
> +# improvement with Karatsuba. HW with clmul latencies higher than 6 cycl=
es
> +# might observe a performance improvement with additionally converting t=
he
> +# reduction to shift&xor. For a full discussion of this estimates see
> +# https://github.com/riscv/riscv-crypto/blob/master/doc/supp/gcm-mode-cm=
ul.adoc
> +{
> +my ($Xi,$Htable,$x0,$x1,$y0,$y1) =3D ("a0","a1","a4","a5","a6","a7");
> +my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) =3D ("t0","t1","t2","t3","t4","t5"=
,"t6");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_gmult_rv64i_zbc
> +.type gcm_gmult_rv64i_zbc,\@function
> +gcm_gmult_rv64i_zbc:
> +    # Load Xi and bit-reverse it
> +    ld        $x0, 0($Xi)
> +    ld        $x1, 8($Xi)
> +    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
> +    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
> +
> +    # Load the key (already bit-reversed)
> +    ld        $y0, 0($Htable)
> +    ld        $y1, 8($Htable)
> +
> +    # Load the reduction constant
> +    la        $polymod, Lpolymod
> +    lbu       $polymod, 0($polymod)
> +
> +    # Multiplication (without Karatsuba)
> +    @{[clmulh $z3, $x1, $y1]}
> +    @{[clmul  $z2, $x1, $y1]}
> +    @{[clmulh $t1, $x0, $y1]}
> +    @{[clmul  $z1, $x0, $y1]}
> +    xor       $z2, $z2, $t1
> +    @{[clmulh $t1, $x1, $y0]}
> +    @{[clmul  $t0, $x1, $y0]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $x0, $y0]}
> +    @{[clmul  $z0, $x0, $y0]}
> +    xor       $z1, $z1, $t1
> +
> +    # Reduction with clmul
> +    @{[clmulh $t1, $z3, $polymod]}
> +    @{[clmul  $t0, $z3, $polymod]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $z2, $polymod]}
> +    @{[clmul  $t0, $z2, $polymod]}
> +    xor       $x1, $z1, $t1
> +    xor       $x0, $z0, $t0
> +
> +    # Bit-reverse Xi back and store it
> +    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
> +    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
> +    sd        $x0, 0($Xi)
> +    sd        $x1, 8($Xi)
> +    ret
> +.size gcm_gmult_rv64i_zbc,.-gcm_gmult_rv64i_zbc
> +___
> +}
> +
> +{
> +my ($Xi,$Htable,$x0,$x1,$y0,$y1) =3D ("a0","a1","a4","a5","a6","a7");
> +my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) =3D ("t0","t1","t2","t3","t4","t5"=
,"t6");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_gmult_rv64i_zbc__zbkb
> +.type gcm_gmult_rv64i_zbc__zbkb,\@function
> +gcm_gmult_rv64i_zbc__zbkb:
> +    # Load Xi and bit-reverse it
> +    ld        $x0, 0($Xi)
> +    ld        $x1, 8($Xi)
> +    @{[brev8  $x0, $x0]}
> +    @{[brev8  $x1, $x1]}
> +
> +    # Load the key (already bit-reversed)
> +    ld        $y0, 0($Htable)
> +    ld        $y1, 8($Htable)
> +
> +    # Load the reduction constant
> +    la        $polymod, Lpolymod
> +    lbu       $polymod, 0($polymod)
> +
> +    # Multiplication (without Karatsuba)
> +    @{[clmulh $z3, $x1, $y1]}
> +    @{[clmul  $z2, $x1, $y1]}
> +    @{[clmulh $t1, $x0, $y1]}
> +    @{[clmul  $z1, $x0, $y1]}
> +    xor       $z2, $z2, $t1
> +    @{[clmulh $t1, $x1, $y0]}
> +    @{[clmul  $t0, $x1, $y0]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $x0, $y0]}
> +    @{[clmul  $z0, $x0, $y0]}
> +    xor       $z1, $z1, $t1
> +
> +    # Reduction with clmul
> +    @{[clmulh $t1, $z3, $polymod]}
> +    @{[clmul  $t0, $z3, $polymod]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $z2, $polymod]}
> +    @{[clmul  $t0, $z2, $polymod]}
> +    xor       $x1, $z1, $t1
> +    xor       $x0, $z0, $t0
> +
> +    # Bit-reverse Xi back and store it
> +    @{[brev8  $x0, $x0]}
> +    @{[brev8  $x1, $x1]}
> +    sd        $x0, 0($Xi)
> +    sd        $x1, 8($Xi)
> +    ret
> +.size gcm_gmult_rv64i_zbc__zbkb,.-gcm_gmult_rv64i_zbc__zbkb
> +___
> +}
> +
> +########################################################################=
########
> +# void gcm_ghash_rv64i_zbc(u64 Xi[2], const u128 Htable[16],
> +#                          const u8 *inp, size_t len);
> +# void gcm_ghash_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16],
> +#                                const u8 *inp, size_t len);
> +#
> +# input:  Xi: current hash value
> +#         Htable: copy of H
> +#         inp: pointer to input data
> +#         len: length of input data in bytes (mutiple of block size)
> +# output: Xi: Xi+1 (next hash value Xi)
> +{
> +my ($Xi,$Htable,$inp,$len,$x0,$x1,$y0,$y1) =3D ("a0","a1","a2","a3","a4"=
,"a5","a6","a7");
> +my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) =3D ("t0","t1","t2","t3","t4","t5"=
,"t6");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_ghash_rv64i_zbc
> +.type gcm_ghash_rv64i_zbc,\@function
> +gcm_ghash_rv64i_zbc:
> +    # Load Xi and bit-reverse it
> +    ld        $x0, 0($Xi)
> +    ld        $x1, 8($Xi)
> +    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
> +    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
> +
> +    # Load the key (already bit-reversed)
> +    ld        $y0, 0($Htable)
> +    ld        $y1, 8($Htable)
> +
> +    # Load the reduction constant
> +    la        $polymod, Lpolymod
> +    lbu       $polymod, 0($polymod)
> +
> +Lstep:
> +    # Load the input data, bit-reverse them, and XOR them with Xi
> +    ld        $t0, 0($inp)
> +    ld        $t1, 8($inp)
> +    add       $inp, $inp, 16
> +    add       $len, $len, -16
> +    @{[brev8_rv64i $t0, $z0, $z1, $z2]}
> +    @{[brev8_rv64i $t1, $z0, $z1, $z2]}
> +    xor       $x0, $x0, $t0
> +    xor       $x1, $x1, $t1
> +
> +    # Multiplication (without Karatsuba)
> +    @{[clmulh $z3, $x1, $y1]}
> +    @{[clmul  $z2, $x1, $y1]}
> +    @{[clmulh $t1, $x0, $y1]}
> +    @{[clmul  $z1, $x0, $y1]}
> +    xor       $z2, $z2, $t1
> +    @{[clmulh $t1, $x1, $y0]}
> +    @{[clmul  $t0, $x1, $y0]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $x0, $y0]}
> +    @{[clmul  $z0, $x0, $y0]}
> +    xor       $z1, $z1, $t1
> +
> +    # Reduction with clmul
> +    @{[clmulh $t1, $z3, $polymod]}
> +    @{[clmul  $t0, $z3, $polymod]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $z2, $polymod]}
> +    @{[clmul  $t0, $z2, $polymod]}
> +    xor       $x1, $z1, $t1
> +    xor       $x0, $z0, $t0
> +
> +    # Iterate over all blocks
> +    bnez      $len, Lstep
> +
> +    # Bit-reverse final Xi back and store it
> +    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
> +    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
> +    sd        $x0, 0($Xi)
> +    sd        $x1, 8($Xi)
> +    ret
> +.size gcm_ghash_rv64i_zbc,.-gcm_ghash_rv64i_zbc
> +___
> +}
> +
> +{
> +my ($Xi,$Htable,$inp,$len,$x0,$x1,$y0,$y1) =3D ("a0","a1","a2","a3","a4"=
,"a5","a6","a7");
> +my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) =3D ("t0","t1","t2","t3","t4","t5"=
,"t6");
> +
> +$code .=3D <<___;
> +.p2align 3
> +.globl gcm_ghash_rv64i_zbc__zbkb
> +.type gcm_ghash_rv64i_zbc__zbkb,\@function
> +gcm_ghash_rv64i_zbc__zbkb:
> +    # Load Xi and bit-reverse it
> +    ld        $x0, 0($Xi)
> +    ld        $x1, 8($Xi)
> +    @{[brev8  $x0, $x0]}
> +    @{[brev8  $x1, $x1]}
> +
> +    # Load the key (already bit-reversed)
> +    ld        $y0, 0($Htable)
> +    ld        $y1, 8($Htable)
> +
> +    # Load the reduction constant
> +    la        $polymod, Lpolymod
> +    lbu       $polymod, 0($polymod)
> +
> +Lstep_zkbk:
> +    # Load the input data, bit-reverse them, and XOR them with Xi
> +    ld        $t0, 0($inp)
> +    ld        $t1, 8($inp)
> +    add       $inp, $inp, 16
> +    add       $len, $len, -16
> +    @{[brev8  $t0, $t0]}
> +    @{[brev8  $t1, $t1]}
> +    xor       $x0, $x0, $t0
> +    xor       $x1, $x1, $t1
> +
> +    # Multiplication (without Karatsuba)
> +    @{[clmulh $z3, $x1, $y1]}
> +    @{[clmul  $z2, $x1, $y1]}
> +    @{[clmulh $t1, $x0, $y1]}
> +    @{[clmul  $z1, $x0, $y1]}
> +    xor       $z2, $z2, $t1
> +    @{[clmulh $t1, $x1, $y0]}
> +    @{[clmul  $t0, $x1, $y0]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $x0, $y0]}
> +    @{[clmul  $z0, $x0, $y0]}
> +    xor       $z1, $z1, $t1
> +
> +    # Reduction with clmul
> +    @{[clmulh $t1, $z3, $polymod]}
> +    @{[clmul  $t0, $z3, $polymod]}
> +    xor       $z2, $z2, $t1
> +    xor       $z1, $z1, $t0
> +    @{[clmulh $t1, $z2, $polymod]}
> +    @{[clmul  $t0, $z2, $polymod]}
> +    xor       $x1, $z1, $t1
> +    xor       $x0, $z0, $t0
> +
> +    # Iterate over all blocks
> +    bnez      $len, Lstep_zkbk
> +
> +    # Bit-reverse final Xi back and store it
> +    @{[brev8  $x0, $x0]}
> +    @{[brev8  $x1, $x1]}
> +    sd $x0,  0($Xi)
> +    sd $x1,  8($Xi)
> +    ret
> +.size gcm_ghash_rv64i_zbc__zbkb,.-gcm_ghash_rv64i_zbc__zbkb
> +___
> +}
> +
> +$code .=3D <<___;
> +.p2align 3
> +Lbrev8_const:
> +    .dword  0xAAAAAAAAAAAAAAAA
> +    .dword  0xCCCCCCCCCCCCCCCC
> +    .dword  0xF0F0F0F0F0F0F0F0
> +.size Lbrev8_const,.-Lbrev8_const
> +
> +Lpolymod:
> +    .byte 0x87
> +.size Lpolymod,.-Lpolymod
> +___
> +
> +print $code;
> +
> +close STDOUT or die "error closing STDOUT: $!";
> diff --git a/arch/riscv/crypto/riscv.pm b/arch/riscv/crypto/riscv.pm
> new file mode 100644
> index 000000000000..b0c786a13ca0
> --- /dev/null
> +++ b/arch/riscv/crypto/riscv.pm
> @@ -0,0 +1,231 @@
> +#! /usr/bin/env perl
> +# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
> +#
> +# Licensed under the Apache License 2.0 (the "License").  You may not us=
e
> +# this file except in compliance with the License.  You can obtain a cop=
y
> +# in the file LICENSE in the source distribution or at
> +# https://www.openssl.org/source/license.html
> +
> +use strict;
> +use warnings;
> +
> +# Set $have_stacktrace to 1 if we have Devel::StackTrace
> +my $have_stacktrace =3D 0;
> +if (eval {require Devel::StackTrace;1;}) {
> +    $have_stacktrace =3D 1;
> +}
> +
> +my @regs =3D map("x$_",(0..31));
> +# Mapping from the RISC-V psABI ABI mnemonic names to the register numbe=
r.
> +my @regaliases =3D ('zero','ra','sp','gp','tp','t0','t1','t2','s0','s1',
> +    map("a$_",(0..7)),
> +    map("s$_",(2..11)),
> +    map("t$_",(3..6))
> +);
> +
> +my %reglookup;
> +@reglookup{@regs} =3D @regs;
> +@reglookup{@regaliases} =3D @regs;
> +
> +# Takes a register name, possibly an alias, and converts it to a registe=
r index
> +# from 0 to 31
> +sub read_reg {
> +    my $reg =3D lc shift;
> +    if (!exists($reglookup{$reg})) {
> +        my $trace =3D "";
> +        if ($have_stacktrace) {
> +            $trace =3D Devel::StackTrace->new->as_string;
> +        }
> +        die("Unknown register ".$reg."\n".$trace);
> +    }
> +    my $regstr =3D $reglookup{$reg};
> +    if (!($regstr =3D~ /^x([0-9]+)$/)) {
> +        my $trace =3D "";
> +        if ($have_stacktrace) {
> +            $trace =3D Devel::StackTrace->new->as_string;
> +        }
> +        die("Could not process register ".$reg."\n".$trace);
> +    }
> +    return $1;
> +}
> +
> +# Helper functions
> +
> +sub brev8_rv64i {
> +    # brev8 without `brev8` instruction (only in Zbkb)
> +    # Bit-reverses the first argument and needs two scratch registers
> +    my $val =3D shift;
> +    my $t0 =3D shift;
> +    my $t1 =3D shift;
> +    my $brev8_const =3D shift;
> +    my $seq =3D <<___;
> +        la      $brev8_const, Lbrev8_const
> +
> +        ld      $t0, 0($brev8_const)  # 0xAAAAAAAAAAAAAAAA
> +        slli    $t1, $val, 1
> +        and     $t1, $t1, $t0
> +        and     $val, $val, $t0
> +        srli    $val, $val, 1
> +        or      $val, $t1, $val
> +
> +        ld      $t0, 8($brev8_const)  # 0xCCCCCCCCCCCCCCCC
> +        slli    $t1, $val, 2
> +        and     $t1, $t1, $t0
> +        and     $val, $val, $t0
> +        srli    $val, $val, 2
> +        or      $val, $t1, $val
> +
> +        ld      $t0, 16($brev8_const) # 0xF0F0F0F0F0F0F0F0
> +        slli    $t1, $val, 4
> +        and     $t1, $t1, $t0
> +        and     $val, $val, $t0
> +        srli    $val, $val, 4
> +        or      $val, $t1, $val
> +___
> +    return $seq;
> +}
> +
> +sub sd_rev8_rv64i {
> +    # rev8 without `rev8` instruction (only in Zbb or Zbkb)
> +    # Stores the given value byte-reversed and needs one scratch registe=
r
> +    my $val =3D shift;
> +    my $addr =3D shift;
> +    my $off =3D shift;
> +    my $tmp =3D shift;
> +    my $off0 =3D ($off + 0);
> +    my $off1 =3D ($off + 1);
> +    my $off2 =3D ($off + 2);
> +    my $off3 =3D ($off + 3);
> +    my $off4 =3D ($off + 4);
> +    my $off5 =3D ($off + 5);
> +    my $off6 =3D ($off + 6);
> +    my $off7 =3D ($off + 7);
> +    my $seq =3D <<___;
> +        sb      $val, $off7($addr)
> +        srli    $tmp, $val, 8
> +        sb      $tmp, $off6($addr)
> +        srli    $tmp, $val, 16
> +        sb      $tmp, $off5($addr)
> +        srli    $tmp, $val, 24
> +        sb      $tmp, $off4($addr)
> +        srli    $tmp, $val, 32
> +        sb      $tmp, $off3($addr)
> +        srli    $tmp, $val, 40
> +        sb      $tmp, $off2($addr)
> +        srli    $tmp, $val, 48
> +        sb      $tmp, $off1($addr)
> +        srli    $tmp, $val, 56
> +        sb      $tmp, $off0($addr)
> +___
> +    return $seq;
> +}
> +
> +# Scalar crypto instructions
> +
> +sub aes64ds {
> +    # Encoding for aes64ds rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0011101_00000_00000_000_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub aes64dsm {
> +    # Encoding for aes64dsm rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0011111_00000_00000_000_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub aes64es {
> +    # Encoding for aes64es rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0011001_00000_00000_000_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub aes64esm {
> +    # Encoding for aes64esm rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0011011_00000_00000_000_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub aes64im {
> +    # Encoding for aes64im rd, rs1 instruction on RV64
> +    #                XXXXXXXXXXXX_ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b001100000000_00000_001_00000_0010011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    return ".word ".($template | ($rs1 << 15) | ($rd << 7));
> +}
> +
> +sub aes64ks1i {
> +    # Encoding for aes64ks1i rd, rs1, rnum instruction on RV64
> +    #                XXXXXXXX_rnum_ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b00110001_0000_00000_001_00000_0010011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rnum =3D shift;
> +    return ".word ".($template | ($rnum << 20) | ($rs1 << 15) | ($rd << =
7));
> +}
> +
> +sub aes64ks2 {
> +    # Encoding for aes64ks2 rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0111111_00000_00000_000_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub brev8 {
> +    # brev8 rd, rs
> +    my $template =3D 0b011010000111_00000_101_00000_0010011;
> +    my $rd =3D read_reg shift;
> +    my $rs =3D read_reg shift;
> +    return ".word ".($template | ($rs << 15) | ($rd << 7));
> +}
> +
> +sub clmul {
> +    # Encoding for clmul rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0000101_00000_00000_001_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub clmulh {
> +    # Encoding for clmulh rd, rs1, rs2 instruction on RV64
> +    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b0000101_00000_00000_011_00000_0110011;
> +    my $rd =3D read_reg shift;
> +    my $rs1 =3D read_reg shift;
> +    my $rs2 =3D read_reg shift;
> +    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7=
));
> +}
> +
> +sub rev8 {
> +    # Encoding for rev8 rd, rs instruction on RV64
> +    #               XXXXXXXXXXXXX_ rs  _XXX_ rd  _XXXXXXX
> +    my $template =3D 0b011010111000_00000_101_00000_0010011;
> +    my $rd =3D read_reg shift;
> +    my $rs =3D read_reg shift;
> +    return ".word ".($template | ($rs << 15) | ($rd << 7));
> +}
> +
> +1;
> --
> 2.39.0
>

Thanks,
Huck
