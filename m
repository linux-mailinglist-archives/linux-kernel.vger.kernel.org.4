Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18B70923D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjESIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjESIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643410E6;
        Fri, 19 May 2023 01:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788A06552C;
        Fri, 19 May 2023 08:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD99AC4339C;
        Fri, 19 May 2023 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684486464;
        bh=l6xWlNTW11M1IArH9XbVsO0LuYjgvFrPFdvjgT2fKsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TLL7EZD00J0qHP0WIImFoaeP9iS7POWP+jnrXXMOVsvPZf7p0pLPOZmZditjFFg31
         hQ44JGMc+sINjBZQV4JnhcqiHZ/mQYoX/q3UD8LQ3fL7avD2osNo6ikbeO+dTVqI8U
         SLLneongeou+VquX03U5xk32P8IGa+mc28lW+KBpgGF+YcNep+zjvA092liO93u4Po
         Mr+Hg/2V7r/LSvvS51mmeCcObriQgn7bfCwvJml8+elLZMzpPHkT4iYPgk0FkGLQ/W
         H2027cYo7hdUiOwfaUuO0jp4YfS9qDFtQWfaHB6t7GSPEli7Z/CzCLg1UuRwwtw8K9
         mD5z70YGlVj8g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f2676d62a2so3346163e87.0;
        Fri, 19 May 2023 01:54:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDwz/1er401cIoV6TLsg0UmhbYPE5TCnAfnokzh6bDmWjvQM2ck7
        teEQdq8n/96UESDwnjrg6kSqQteCAOlkqzB54JM=
X-Google-Smtp-Source: ACHHUZ7SvdXKZpS/i9iOaPcFYPkRcxW6aWBrXA6Y7mN4OZu24KBaz9xljJ2ps4rcZZOJmt7v9Wu5xjt2j2ikxrgIIvk=
X-Received: by 2002:ac2:43a4:0:b0:4f2:7b65:baeb with SMTP id
 t4-20020ac243a4000000b004f27b65baebmr455104lfl.53.1684486462868; Fri, 19 May
 2023 01:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZGcyuyjJwZhdYS/G@gondor.apana.org.au> <E1pzvTZ-00AnMQ-5M@formenos.hmeau.com>
In-Reply-To: <E1pzvTZ-00AnMQ-5M@formenos.hmeau.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 10:54:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGwS03zUBTGb7jmk1-6r+=a-HH+A-S9ZFTYRyJSzN0Xcg@mail.gmail.com>
Message-ID: <CAMj1kXGwS03zUBTGb7jmk1-6r+=a-HH+A-S9ZFTYRyJSzN0Xcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] crypto: cmac - Add support for cloning
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Safonov <dima@arista.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Fri, 19 May 2023 at 10:29, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Allow hmac to be cloned.  The underlying cipher needs to support
> cloning by not having a cra_init function (all implementations of
> aes that do not require a fallback can be cloned).
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Does this imply that the cmac-aes-ce and cmac-aes-neon implementations
for arm64 need a similar treatment?

> ---
>
>  crypto/cmac.c |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/cmac.c b/crypto/cmac.c
> index bcc6f19a4f64..fce6b0f58e88 100644
> --- a/crypto/cmac.c
> +++ b/crypto/cmac.c
> @@ -213,7 +213,22 @@ static int cmac_init_tfm(struct crypto_shash *tfm)
>         ctx->child = cipher;
>
>         return 0;
> -};
> +}
> +
> +static int cmac_clone_tfm(struct crypto_shash *tfm, struct crypto_shash *otfm)
> +{
> +       struct cmac_tfm_ctx *octx = crypto_shash_ctx(otfm);
> +       struct cmac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
> +       struct crypto_cipher *cipher;
> +
> +       cipher = crypto_clone_cipher(octx->child);
> +       if (IS_ERR(cipher))
> +               return PTR_ERR(cipher);
> +
> +       ctx->child = cipher;
> +
> +       return 0;
> +}
>
>  static void cmac_exit_tfm(struct crypto_shash *tfm)
>  {
> @@ -280,6 +295,7 @@ static int cmac_create(struct crypto_template *tmpl, struct rtattr **tb)
>         inst->alg.final = crypto_cmac_digest_final;
>         inst->alg.setkey = crypto_cmac_digest_setkey;
>         inst->alg.init_tfm = cmac_init_tfm;
> +       inst->alg.clone_tfm = cmac_clone_tfm;
>         inst->alg.exit_tfm = cmac_exit_tfm;
>
>         inst->free = shash_free_singlespawn_instance;
