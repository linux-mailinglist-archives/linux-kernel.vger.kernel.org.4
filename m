Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA65B5EF5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiI2NCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiI2NCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:02:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD414F839
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:02:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s14so1444734ybe.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SEsUs2gvZHDmzlqffTDPO3uJa6JnVZZcNTKlq3Kt9MU=;
        b=gHitnds8mOgFlpyG1JRD0rZNOwboih9OaiUHc9I0HxgmSHUR3jJFPDsqtHhug986kN
         ETIfl2QAsT3j5ubEvPJWxUTN27GB0m9KGv/vfOvSDN2MQmUBSBaxZmQiXcn1NgQ/LQWJ
         RCIGRm8FuQfQNZLBzpD6yeebJJiAnSZjy0R382PvQhWo+urCsNovQ3kJWqVkoQOHahNv
         pQ0X+h7AM4tQzhfMFT/4ZxfwQ56QOdf6nt9rcZ87JKDCcGAFkoBfyVb8HDv9hgC8TsdQ
         GRxq3Tk+Nw94p7pS/ZQTGZLMBn+THp7NoqqFFurm5xtw3ALLW5vO4ybHYDWq2t2UOIHj
         yROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SEsUs2gvZHDmzlqffTDPO3uJa6JnVZZcNTKlq3Kt9MU=;
        b=06ekYADYo8aOpzMiT30d9gkrOD/ojqGK0vodBrbgbW+nszAsL6mOXsbZzdhbOR4nk/
         Oo4NhWDHznJ8EGB3AqxZVc+B2XhCg30sYH4sDmE5XTkPZ/W89IgsCcfwqhsQ6z0hS6XB
         Y0sXsTd4ekUpLOEz5R6aHivW/QXHGDgdFbR5uktIyk9OEJ2dQGYpi+euINNXESklrH6n
         BlA2jA0dMNFMrLLiIOtTh5er6UdBrXylLHWZhEv1JtPtMi5a8xIO8BChToFdDImz8DkF
         oPKd4Eqm1FhBbHEnmH/yCRFlynU3rClbgAWAkYj0fYUZKC7S62lXy1SBDQIHI5Ug0AV0
         1hFw==
X-Gm-Message-State: ACrzQf3Nxrni3yQ0z/KeHqtLpzLqlDphLEFrjxToQE39nZUyG4w7cMTN
        L8ckLjBzV0qvOXqxluSi4Y30DOu/v3reVzcJELHXYMzGGezmVQ==
X-Google-Smtp-Source: AMsMyM4f3trgZGyHQ9BaajqRad216hBQ3YzdhFat967jfTe6n5tmPAf0NGeFrmN/Vq5rA9cKbv0c33AcnR2l1non+mo=
X-Received: by 2002:a05:6902:100b:b0:6af:cda:704d with SMTP id
 w11-20020a056902100b00b006af0cda704dmr2928339ybt.584.1664456566130; Thu, 29
 Sep 2022 06:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220929103059.277230-1-Jason@zx2c4.com>
In-Reply-To: <20220929103059.277230-1-Jason@zx2c4.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Sep 2022 15:02:09 +0200
Message-ID: <CANpmjNMjUpx37KKc-zb--Z-=fpETwDGkyb9-mAOGLqZ+CBU-BA@mail.gmail.com>
Subject: Re: [PATCH] prandom: make use of smaller types in prandom_u32_max
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 12:31, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> When possible at compile-time, make use of smaller types in
> prandom_u32_max(), so that we can use smaller batches from random.c,
> which in turn leads to a 2x or 4x performance boost. This makes a
> difference, for example, in kfence, which needs a fast stream of small
> numbers (booleans).
>
> At the same time, we use the occasion to update the old documentation on
> these functions. prandom_u32() and prandom_bytes() have direct
> replacements now in random.h, while prandom_u32_max() remains useful as
> a prandom.h function, since it's not cryptographically secure by virtue
> of not being evenly distributed.
>
> Cc: Marco Elver <elver@google.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  include/linux/prandom.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> index deace5fb4e62..78db003bc290 100644
> --- a/include/linux/prandom.h
> +++ b/include/linux/prandom.h
> @@ -12,11 +12,13 @@
>  #include <linux/percpu.h>
>  #include <linux/random.h>
>
> +/* Deprecated: use get_random_u32 instead. */
>  static inline u32 prandom_u32(void)
>  {
>         return get_random_u32();
>  }
>
> +/* Deprecated: use get_random_bytes instead. */
>  static inline void prandom_bytes(void *buf, size_t nbytes)
>  {
>         return get_random_bytes(buf, nbytes);
> @@ -37,17 +39,20 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
>   * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
>   * @ep_ro: right open interval endpoint
>   *
> - * Returns a pseudo-random number that is in interval [0, ep_ro). Note
> - * that the result depends on PRNG being well distributed in [0, ~0U]
> - * u32 space. Here we use maximally equidistributed combined Tausworthe
> - * generator, that is, prandom_u32(). This is useful when requesting a
> - * random index of an array containing ep_ro elements, for example.
> + * Returns a pseudo-random number that is in interval [0, ep_ro). This is
> + * useful when requesting a random index of an array containing ep_ro elements,
> + * for example. The result is somewhat biased when ep_ro is not a power of 2,
> + * so do not use this for cryptographic purposes.
>   *
>   * Returns: pseudo-random number in interval [0, ep_ro)
>   */
>  static inline u32 prandom_u32_max(u32 ep_ro)
>  {
> -       return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
> +       if (__builtin_constant_p(ep_ro <= 1U << 8) && ep_ro <= 1U << 8)
> +               return (get_random_u8() * ep_ro) >> 8;
> +       if (__builtin_constant_p(ep_ro <= 1U << 16) && ep_ro <= 1U << 16)
> +               return (get_random_u16() * ep_ro) >> 16;
> +       return ((u64)get_random_u32() * ep_ro) >> 32;
>  }
>
>  /*
> --
> 2.37.3
>
