Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020446A1652
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBXFj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXFj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:39:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1980F22797;
        Thu, 23 Feb 2023 21:39:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF2CBB81B30;
        Fri, 24 Feb 2023 05:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6E3C433D2;
        Fri, 24 Feb 2023 05:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677217162;
        bh=6XxbHQoPaX8ToMzT7R+M50zf6v7enC+meqfCAd6TtkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AvRj+V2JMPRJFrrOkVz+XabzL8Yxf0fncjArqJufFAsvZsfv7EdOjnZCYcHJUpvRX
         Rj8fLk/e1A7JzH07Pp5DzhJoXwZoqc2fROSyPUM8e7hPz+eX75PXdpEwZFzCUUDUQO
         xJPPQIF9aqKd/jC37MYDOdmj/RcsE4fSUhjReOSe+LqlMZCe3TaCVrhUmeSR/ZUpfl
         Gaf0gul2Qm/DWDoFm/1/sW4qNonnZWQ/ie86OqgMAGf4MFf1cfxIKL3TWo+doSiWoB
         MvWLO0LGyr4hLlLyZnSqVnl08IElCdzMMGwrOGVgFXgAO3af+UN8QvrObGJzEuKUPg
         AYPK6/IFtwlLA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1720887dfcdso18378622fac.6;
        Thu, 23 Feb 2023 21:39:22 -0800 (PST)
X-Gm-Message-State: AO0yUKVtTuD2JcbF8/KYq+SvPTtTsqgx80L8tZJge3M1I8YG5DFblTxm
        tgkr1RGHdRPFKL0DrYMwq5bnVBvE4EM++lTa9yI=
X-Google-Smtp-Source: AK7set/P6HvAfN/2pLsZH7NeQy2lylcv3Eafv2JdQRHdhqS0XkWZB1zzX59dhcVnbx4cCLHakbzWfU4eJKdglmegiBI=
X-Received: by 2002:a05:6870:954f:b0:16a:6ab4:e878 with SMTP id
 v15-20020a056870954f00b0016a6ab4e878mr725581oal.8.1677217161751; Thu, 23 Feb
 2023 21:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20230223001607.95523-1-andrealmeid@igalia.com>
In-Reply-To: <20230223001607.95523-1-andrealmeid@igalia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Feb 2023 14:38:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbzWQs3WzsdyLsCyFD_2Kgz8sqjqk+nFXkEXQFrYobRA@mail.gmail.com>
Message-ID: <CAK7LNAQbzWQs3WzsdyLsCyFD_2Kgz8sqjqk+nFXkEXQFrYobRA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: modinst: Enable multithread xz compression
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-dev@igalia.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:17 AM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> As it's done for zstd compression, enable multithread compression for
> xz to speed up module installation.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>
> On my setup xz is a bottleneck during module installation. Here are the
> numbers to install it in a local directory, before and after this patch:
>
> $ time make INSTALL_MOD_PATH=3D/home/tonyk/codes/.kernel_deploy/ modules_=
install -j16
> Executed in  100.08 secs
>
> $ time make INSTALL_MOD_PATH=3D/home/tonyk/codes/.kernel_deploy/ modules_=
install -j16
> Executed in   28.60 secs


Heh, this is an interesting benchmark.

Without this patch, you ran 16 processes of 'xz' in parallel
since you gave -j16.

You created multi-threads in each xz process, then you got 3x faster.
What made it happen? How many threads can your system run?



I did not get such an improvement in my testing.
In my machine $(nproc) is 24.


[Without this patch]

$ time make INSTALL_MOD_PATH=3D/tmp/inst1  modules_install -j$(nproc)

real 0m33.965s
user 10m6.118s
sys 0m37.231s

[With this patch]

$ time make INSTALL_MOD_PATH=3D/tmp/inst1  modules_install -j$(nproc)

real 0m32.568s
user 10m4.472s
sys 0m39.132s



Given that GNU Make provides the parallel execution environment,
you can control the number of processes of 'xz'.

There is no point in forcing multi-threading, which the user
did not ask or ever want.













> ---
>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 4815a8e32227..28dcc523d2ee 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -99,7 +99,7 @@ endif
>  quiet_cmd_gzip =3D GZIP    $@
>        cmd_gzip =3D $(KGZIP) -n -f $<
>  quiet_cmd_xz =3D XZ      $@
> -      cmd_xz =3D $(XZ) --lzma2=3Ddict=3D2MiB -f $<
> +      cmd_xz =3D $(XZ) --lzma2=3Ddict=3D2MiB -f -T0 $<
>  quiet_cmd_zstd =3D ZSTD    $@
>        cmd_zstd =3D $(ZSTD) -T0 --rm -f -q $<
>
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
