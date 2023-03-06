Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3B6AD16E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCFWVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCFWVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:21:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E56F49F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:21:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso14669034pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678141262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKCElbLVytEeNaS32sBjplzVfFGrbs1J/gek8MDMo+s=;
        b=dWbER2ermfYOLcrW0sDivAeOSvYk0GsFe6u2znhDUzpCVDrUw/oKji1q0A+uAu7zx0
         7+lo35hmysvEutdN/SHld5KHpsx6rUohnL+1Mts+AjaR0OBqXAm8wQUvh+yJn38GCayP
         dfOTrtfxJkgy3dXc6QNXyFLhjrJA6kBOxDuzzHcLHkuUo/bAeGKs4+zlYKYf22Wv+cYt
         U07gp9rIxD2zxbAkCnHXHZMw9mhJHU33/UB+uSficHnMx0Z/nUdJWypziR0Hhh5VfKUe
         WwECbOtp8EPOnX5R4s5pthV7v7DXr9ftiTedmCbLWi3XdORsD/NTsMqhL7I2ZZgIdPOO
         zPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKCElbLVytEeNaS32sBjplzVfFGrbs1J/gek8MDMo+s=;
        b=RJosRD4quG1o7+1jtOIIteLkGzTPdKvXGOTKmvfMV2MeF0r7UKQJS20USXT94uMScL
         4gjQkDpIc/4kpG9LXRF93ZxdTE7Ob+m+NRrXXQyPrlZDX9hAKDuHgma/3i02MyQb5sU4
         kPDu8La6hvLY6NICUL0zoo472wLjo8U0KyeiPQw2pFq2ksVgtl3JthWPPk2CIvLRJGHD
         0qc+nM4Sm8bXr1411ynYw7A4WqTPKfI5/rkcwDr1qMsM7Xndqva5piBpO3njJJOBfl9M
         7t0oJVdJjCboMp5I4jVBaYdwU1MdGVof+pWghke2glUt3y4jpgWErudbawgEL871LRbj
         l/5g==
X-Gm-Message-State: AO0yUKU9NR16h7L/1b4VNPnWvbEmwgc0APiKxFD1XuzuczOM+JOwmEAy
        a5pOIig777GimMh+6uf7heMAwg+DHJKEy2Sxjvk2+Q==
X-Google-Smtp-Source: AK7set9V/HSr9SQeQoq+XWK8onpnxrxDXIFX9ueYHg4Yh817nq27oxoWlyBsW+9D3nCi4fvc7XrGxSSg7bP3ODw/Viw=
X-Received: by 2002:a17:90a:14c2:b0:237:c367:edda with SMTP id
 k60-20020a17090a14c200b00237c367eddamr4623132pja.5.1678141262029; Mon, 06 Mar
 2023 14:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20230306220947.1982272-1-trix@redhat.com>
In-Reply-To: <20230306220947.1982272-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Mar 2023 14:20:50 -0800
Message-ID: <CAKwvOdkd7pUu_oxt4=CW3fxXz2y7evtU9J5Gd7oQuyi1MkDMCw@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
To:     Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, paulmck@kernel.org, hannes@cmpxchg.org,
        ojeda@kernel.org, thunder.leizhen@huawei.com,
        christophe.leroy@csgroup.eu, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kees
https://lore.kernel.org/lkml/20230306220947.1982272-1-trix@redhat.com/

On Mon, Mar 6, 2023 at 2:10=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> With gcc 13.0.1 on x86, there are several false positives like
>
> drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31:
>   error: array subscript 4 is above array bounds of =E2=80=98const struct=
 sparx5_psfp_gce[4]=E2=80=99 [-Werror=3Darray-bounds=3D]
>   167 |                 gce =3D &sg->gce[i];
>       |                        ~~~~~~~^~~
> In file included from drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c=
:8:
> drivers/net/ethernet/microchip/sparx5/sparx5_main.h:506:32: note: while r=
eferencing =E2=80=98gce=E2=80=99
>   506 |         struct sparx5_psfp_gce gce[SPX5_PSFP_GCE_CNT];
>       |                                ^~~
>
> The code lines for the reported problem
>         /* For each scheduling entry */
>         for (i =3D 0; i < sg->num_entries; i++) {
>                 gce =3D &sg->gce[i];
>
> i is bounded by num_entries, which is set in sparx5_tc_flower.c
>         if (act->gate.num_entries >=3D SPX5_PSFP_GCE_CNT) {
>                 NL_SET_ERR_MSG_MOD(extack, "Invalid number of gate entrie=
s");
>                 return -EINVAL;
>         }
> ..
>         sg->num_entries =3D act->gate.num_entries;
>
> So disable array-bounds as was done on gcc 11 and 12
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  init/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 1fb5f313d18f..10d0a0020726 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -898,10 +898,14 @@ config GCC11_NO_ARRAY_BOUNDS
>  config GCC12_NO_ARRAY_BOUNDS
>         def_bool y
>
> +config GCC13_NO_ARRAY_BOUNDS
> +       def_bool y
> +
>  config CC_NO_ARRAY_BOUNDS
>         bool
>         default y if CC_IS_GCC && GCC_VERSION >=3D 110000 && GCC_VERSION =
< 120000 && GCC11_NO_ARRAY_BOUNDS
>         default y if CC_IS_GCC && GCC_VERSION >=3D 120000 && GCC_VERSION =
< 130000 && GCC12_NO_ARRAY_BOUNDS
> +       default y if CC_IS_GCC && GCC_VERSION >=3D 130000 && GCC_VERSION =
< 140000 && GCC13_NO_ARRAY_BOUNDS
>
>  #
>  # For architectures that know their GCC __int128 support is sound
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
