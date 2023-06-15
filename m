Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505F9731673
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjFOLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbjFOLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C232942;
        Thu, 15 Jun 2023 04:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0EA62509;
        Thu, 15 Jun 2023 11:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A1EC433D9;
        Thu, 15 Jun 2023 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686828196;
        bh=k9fADbgKvV/Qn+j8XbAwaXlplLxpRignwQzXVFHSWt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OTx+Sljx6YMQKFA95oZuH+C2Hn73d40eLzW/LKTTMBs0Sd6WTjoQxZLaLmGyVPLSJ
         HDY7E7zr98cBAinzGe9Cj90fBEO6GO7097NmHzIKXVsiEaO11HgomXE6DOGgWlGc/6
         ffMhLjXMvXIZWMYZStNgT/vyxXqnV1D5mjcYoOGeg9NJXkpfzRmzPhAfmV/ScbCH0k
         F0XeDNCw17CV6SHazA0445KkgYVRhslR6yy3uv1Po++S0AyTbz8dC5N0sUo4p3v/Fy
         A4SB3e05LrW7/8NJJsY6N6sCMgT4adCqhXqZq4ij+genFaIheBYTuVChg34TDY1MaA
         mqa6L8HX7g04A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1a99f39a387so453319fac.2;
        Thu, 15 Jun 2023 04:23:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyTywZqXZX9Yg5wqLXLf7LDdpkNeGAYyvmtG+ZJ0uFOMvxG8T1n
        hULEla6vCkC4voqoG3FoyeIlKmPyEGUue98NYCA=
X-Google-Smtp-Source: ACHHUZ5hWhXAn/m8+l5Ml0NG1WlcoD7isYO4jpODDCwDXsdjNjcNp5pTXujRUFqfd7DKuvK26A3NKOM/rVbr74vYLjw=
X-Received: by 2002:a05:6870:3e4:b0:19f:45a1:b59d with SMTP id
 h36-20020a05687003e400b0019f45a1b59dmr14233174oaf.12.1686828195942; Thu, 15
 Jun 2023 04:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org>
In-Reply-To: <36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 15 Jun 2023 20:22:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1bfc_rEX-Wyi6az0KSse11ws-farvxkYwfGKXrueduw@mail.gmail.com>
Message-ID: <CAK7LNAQ1bfc_rEX-Wyi6az0KSse11ws-farvxkYwfGKXrueduw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: Include modules.builtin* even if non-modular
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 9:28=E2=80=AFAM Josh Triplett <josh@joshtriplett.or=
g> wrote:
>
> Even for a non-modular kernel, the kernel builds modules.builtin and
> modules.builtin.modinfo, with information about the built-in modules.
> Tools such as initramfs-tools need these files to build a working
> initramfs on some systems, such as those requiring firmware.
>
> Install modules.builtin and modules.builtin.modinfo into the linux-image
> package even for a non-modular kernel.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>



OK, I understood.
But, this patch only aids Debian in an ad-hoc file copy.

I think chaning modules_install would be a more
general solution.

Can you use this patch as a prerequisite?
https://patchwork.kernel.org/project/linux-kbuild/patch/20230615111743.8838=
91-1-masahiroy@kernel.org/

Then, you can simply remove
"if is_enabled CONFIG_MODULES; then"
so you can install the files unconditionally.



> ---
>  scripts/package/builddeb | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 252faaa5561c..91261529f2c7 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -70,6 +70,12 @@ install_linux_image () {
>                         mkdir -p "${pdir}/usr/lib/uml/modules"
>                         mv "${pdir}/lib/modules/${KERNELRELEASE}" "${pdir=
}/usr/lib/uml/modules/${KERNELRELEASE}"
>                 fi
> +       elif [ -f modules.builtin ]; then
> +               mkdir -p "${pdir}/lib/modules/${KERNELRELEASE}"
> +               cp modules.builtin "${pdir}/lib/modules/${KERNELRELEASE}/=
modules.builtin"
> +               if [ -f modules.builtin.modinfo ]; then
> +                       cp modules.builtin.modinfo "${pdir}/lib/modules/$=
{KERNELRELEASE}/modules.builtin.modinfo"
> +               fi
>         fi
>
>         # Install the kernel
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada
