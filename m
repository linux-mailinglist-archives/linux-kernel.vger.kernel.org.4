Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5719268265B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjAaIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:30:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1271B568;
        Tue, 31 Jan 2023 00:30:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 164F5613B3;
        Tue, 31 Jan 2023 08:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C10BC4339C;
        Tue, 31 Jan 2023 08:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675153845;
        bh=MmjALNBfvdWez2aR1yaJB9INPg8W1OfRoP5fkM954vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TUwn/use7R8focdO/D8XyPR51jHzLktKeJnPHAnzeaQapurYbx9vLbJ0pT3DmYdA6
         jpx3Jri7T5VreOd+bxA71QMgjfpvfFGCKe4pa8kdRDXN+D1vqDxBJgQ3I+UYN4tl7i
         lYU0R50hdDlsmadRJ986cKuUn3ruW4mZcoaB/hKdrCsrmZEZV6NKi7wS0ITwdecJaO
         cSdIHbRKFFYJz8rF+JloV4DaxwFohNyAdNUmp24W2lVVUW81MyDo4Hww4UW5RXr132
         T0Wy0nFwjMv7mWO54IV+KhS/WbXSF5RW5O+ND0ug5jPFH1f0s/cKJQ7dhpsrYKJMWc
         fWAKX2SnbANew==
Received: by mail-lj1-f170.google.com with SMTP id b13so5260670ljf.8;
        Tue, 31 Jan 2023 00:30:45 -0800 (PST)
X-Gm-Message-State: AO0yUKUrB/wH7LMyae9Je+w6BlUuK3UFlNckD7Rdwwg6LN2aAGT7LKrO
        PLwC6S7BGGucvpX9XXRXURrn58RGNfOUEeQR3fw=
X-Google-Smtp-Source: AK7set+BvU5t5r0neeqP/RNCa/kypJDMf0Gt0f37PPU2RJLIfUOoFIiw8IEz9/q9sLhyWW3vk+67UroolmT+b7AJFw4=
X-Received: by 2002:a2e:91cc:0:b0:290:5920:fc30 with SMTP id
 u12-20020a2e91cc000000b002905920fc30mr1241931ljg.128.1675153843490; Tue, 31
 Jan 2023 00:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20230121183450.14570-1-peter@n8pjl.ca>
In-Reply-To: <20230121183450.14570-1-peter@n8pjl.ca>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 09:30:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFd+SXvpTyFrQVBHeODHNABn6pvG4Go0E3YEDH=ArqRAw@mail.gmail.com>
Message-ID: <CAMj1kXFd+SXvpTyFrQVBHeODHNABn6pvG4Go0E3YEDH=ArqRAw@mail.gmail.com>
Subject: Re: [PATCH RESEND] crypto: x86 - exit fpu context earlier in ECB/CBC macros
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jan 2023 at 19:40, Peter Lafreniere <peter@n8pjl.ca> wrote:
>
> Currently the ecb/cbc macros hold fpu context unnecessarily when using
> scalar cipher routines (e.g. when handling odd sizes of blocks per walk).
>
> Change the macros to drop fpu context as soon as the fpu is out of use.
>
> No performance impact found (on Intel Haswell).
>
> Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>

The patch seems correct to me, so

Acked-by: Ard Biesheuvel <ardb@kernel.org>

although I seriously doubt whether anyone would ever notice the
difference, given that the algorithms that use these macros are
primarily used in legacy block encryption scenarios, where the data is
always presented in multiples of the largest block size.


> ---
>  arch/x86/crypto/ecb_cbc_helpers.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/crypto/ecb_cbc_helpers.h b/arch/x86/crypto/ecb_cbc_helpers.h
> index eaa15c7b29d6..11955bd01af1 100644
> --- a/arch/x86/crypto/ecb_cbc_helpers.h
> +++ b/arch/x86/crypto/ecb_cbc_helpers.h
> @@ -13,13 +13,14 @@
>
>  #define ECB_WALK_START(req, bsize, fpu_blocks) do {                    \
>         void *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));   \
> +       const int __fpu_blocks = (fpu_blocks);                          \
>         const int __bsize = (bsize);                                    \
>         struct skcipher_walk walk;                                      \
>         int err = skcipher_walk_virt(&walk, (req), false);              \
>         while (walk.nbytes > 0) {                                       \
>                 unsigned int nbytes = walk.nbytes;                      \
> -               bool do_fpu = (fpu_blocks) != -1 &&                     \
> -                             nbytes >= (fpu_blocks) * __bsize;         \
> +               bool do_fpu = __fpu_blocks != -1 &&                     \
> +                             nbytes >= __fpu_blocks * __bsize;         \
>                 const u8 *src = walk.src.virt.addr;                     \
>                 u8 *dst = walk.dst.virt.addr;                           \
>                 u8 __maybe_unused buf[(bsize)];                         \
> @@ -35,7 +36,12 @@
>  } while (0)
>
>  #define ECB_BLOCK(blocks, func) do {                                   \
> -       while (nbytes >= (blocks) * __bsize) {                          \
> +       const int __blocks = (blocks);                                  \
> +       if (do_fpu && __blocks < __fpu_blocks) {                        \
> +               kernel_fpu_end();                                       \
> +               do_fpu = false;                                         \
> +       }                                                               \
> +       while (nbytes >= __blocks * __bsize) {                          \
>                 (func)(ctx, dst, src);                                  \
>                 ECB_WALK_ADVANCE(blocks);                               \
>         }                                                               \
> @@ -53,7 +59,12 @@
>  } while (0)
>
>  #define CBC_DEC_BLOCK(blocks, func) do {                               \
> -       while (nbytes >= (blocks) * __bsize) {                          \
> +       const int __blocks = (blocks);                                  \
> +       if (do_fpu && __blocks <  __fpu_blocks) {                       \
> +               kernel_fpu_end();                                       \
> +               do_fpu = false;                                         \
> +       }                                                               \
> +       while (nbytes >= __blocks * __bsize) {                          \
>                 const u8 *__iv = src + ((blocks) - 1) * __bsize;        \
>                 if (dst == src)                                         \
>                         __iv = memcpy(buf, __iv, __bsize);              \
> --
> 2.39.0
>
