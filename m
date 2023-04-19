Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5036E83E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDSVqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDSVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:46:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4A1736
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:46:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2474e09fdcfso205363a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681940770; x=1684532770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNA55poY27sJGkFBB9ELAvckRSp+Hs3DdUKmyP8I/c=;
        b=Wu+EO2gLZK7bRlRXhOue6NYns1NGF7FgYObfpP2p7tSWYpnQJon+eZ1th/qgEPsbeT
         n6YG0IH0XPWgIbKKR/M3vjqnEh+7YqJN4K0V0IqQN1geeWosh3pj/m3nQmPs69zCTXOO
         F3hp3XJG3srHyjCAcvzWdXQrY8iGq+h3sroGuLR4nVCU/CgUPdhjHcZiGoQBwmYQOq6q
         6nHpbRCJtMdALeo1UBhlq4sGLfDBin4I4t5N2QYN2KQWrLWqqQOZulXn7jLCyO4SF5D1
         ADWe84kC/4VIG85xthR+4jmVpFZfD4HWvnk92BW52dBG9a56AAf+S53ye2pt6Wt1zQqu
         4zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681940770; x=1684532770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNA55poY27sJGkFBB9ELAvckRSp+Hs3DdUKmyP8I/c=;
        b=aAi8BU61xYb483c9uhsaHMFSPbCkRySxoT0GRcTb6epYtjg/7ZOJahWzP1pPydXkmM
         TRu6sIFqCRGO1uW1R4e9tSgVl0RCTK/PHo1D6PSza7EX4udyc/lt1/qobPIhMNHIb4hM
         gVCW8UjVa2kKqhbnKs5zDBquX+RPvUEOa9eASJhRtV/UAcD/VM00v3q8cE8102a8KNH4
         w432zTqUGnjRwAbe/mZ298j4Mrp+s3iChXPnThm40Kj7Y7R3PVzNeptabewFbv17Bo4Q
         V6PcB084vtLFyrBVRpNK30bVC0ABC/st9Vr1id+CHVZAJMuiRgWP/9HrZ5hMU2og7iav
         eMLg==
X-Gm-Message-State: AAQBX9eg3Elj8D6TKPgfFrSARsQCy1Fs2+rdTnVGvYpApwQ0SLjSdLs3
        L0D7LmKaV4qkmSZryIKR/FsLXoyEoheMw/lEG97+IQ==
X-Google-Smtp-Source: AKy350bL48Q9SK3cJudoJ6xx9ltTOmsUb9nCB/69hFqPx6lo5kbFN2yYSkaFZsBy9oE0K351LWgmiL9hiI5w4oDtC+Q=
X-Received: by 2002:a17:90b:4c4f:b0:247:78e7:8739 with SMTP id
 np15-20020a17090b4c4f00b0024778e78739mr4187323pjb.0.1681940770255; Wed, 19
 Apr 2023 14:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <202304081828.zjGcFUyE-lkp@intel.com> <ZD+0DJq1NHmMSSja@gondor.apana.org.au>
In-Reply-To: <ZD+0DJq1NHmMSSja@gondor.apana.org.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Apr 2023 14:45:58 -0700
Message-ID: <CAKwvOdm2VyCzfmG6707osmtyniV-oL-ism08kER49D7p_7x+Rg@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/sha1-neon - Fix clang function cast warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>,
        Robert Elliott <elliott@hpe.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 2:27=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> Instead of casting the function which upsets clang for some reason,
> change the assembly function siganture instead.

s/siganture/signature/

Thanks for the patch!  Perhaps worth noting in the commit message that
this fixes an instance of -Wcast-function-type-strict triggered for
W=3D1 builds, which helps us catch potential kCFI violations at compile
time rather than runtime.

After this patch, there's only 4 more users of the sha1_block_fn
typedef, consider if that typedef is a candidate for removal now?

Also, you should update the comment in
arch/arm/crypto/sha1-armv7-neon.S above the assembler implementation
on L288-289 to reflect this revised fn signature, in this patch.

>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304081828.zjGcFUyE-lkp@int=
el.com/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/arch/arm/crypto/sha1_neon_glue.c b/arch/arm/crypto/sha1_neon=
_glue.c
> index cfe36ae0f3f5..9c70b87e69f7 100644
> --- a/arch/arm/crypto/sha1_neon_glue.c
> +++ b/arch/arm/crypto/sha1_neon_glue.c
> @@ -26,8 +26,8 @@
>
>  #include "sha1.h"
>
> -asmlinkage void sha1_transform_neon(void *state_h, const char *data,
> -                                   unsigned int rounds);
> +asmlinkage void sha1_transform_neon(struct sha1_state *state_h,
> +                                   const u8 *data, int rounds);
>
>  static int sha1_neon_update(struct shash_desc *desc, const u8 *data,
>                           unsigned int len)
> @@ -39,8 +39,7 @@ static int sha1_neon_update(struct shash_desc *desc, co=
nst u8 *data,
>                 return sha1_update_arm(desc, data, len);
>
>         kernel_neon_begin();
> -       sha1_base_do_update(desc, data, len,
> -                           (sha1_block_fn *)sha1_transform_neon);
> +       sha1_base_do_update(desc, data, len, sha1_transform_neon);
>         kernel_neon_end();
>
>         return 0;
> @@ -54,9 +53,8 @@ static int sha1_neon_finup(struct shash_desc *desc, con=
st u8 *data,
>
>         kernel_neon_begin();
>         if (len)
> -               sha1_base_do_update(desc, data, len,
> -                                   (sha1_block_fn *)sha1_transform_neon)=
;
> -       sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_transform_neon)=
;
> +               sha1_base_do_update(desc, data, len, sha1_transform_neon)=
;
> +       sha1_base_do_finalize(desc, sha1_transform_neon);
>         kernel_neon_end();
>
>         return sha1_base_finish(desc, out);
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>


--=20
Thanks,
~Nick Desaulniers
